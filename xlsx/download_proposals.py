"""
Download each team's uploaded proposal file from Google Drive into a local
folder, for easy access while grading, and record a manifest that
gen_rubrik_proposal.py uses to hyperlink to the local copy (falling back to
the original Drive link for any team whose file could not be fetched).

Most failures seen in practice are Google Drive's anonymous-download rate
limit kicking in after dozens of requests in a row ("Cannot retrieve the
public link of the file... may have had many accesses"), not real permission
problems -- so this script writes the manifest incrementally (safe to
interrupt) and supports a --retry-failed pass to re-attempt just the entries
that failed last time, after the rate limit has had time to cool down.

Usage:
    uv run --with gdown --with openpyxl python xlsx/download_proposals.py
    uv run --with gdown --with openpyxl python xlsx/download_proposals.py --retry-failed

Writes:
    docs/proposals-uploaded/<Kelas>/<Nama Tim - Nama Ketua>.<ext>
    xlsx/proposals_manifest.json
"""
import json
import subprocess
import sys
import time
from pathlib import Path

import gdown

from rubrik_common import ROOT, UPLOADS_DIR, MANIFEST_PATH, load_roster, sanitize_filename

DELAY_SECONDS = 2.0

MAGIC_EXTENSIONS = [
    (b"%PDF", ".pdf"),
    (b"PK\x03\x04", ".docx"),  # any zip-based Office format
    (b"\xd0\xcf\x11\xe0\xa1\xb1\x1a\xe1", ".doc"),
]


def try_curl_download(file_id, dest_dir):
    """Fallback for files gdown fails on ("Cannot retrieve the public link")
    even though a plain HTTP GET of the export URL succeeds -- seen for a
    handful of files where gdown's confirm-page parsing doesn't match."""
    tmp_path = dest_dir / f".curl-{file_id}.tmp"
    url = f"https://drive.google.com/uc?export=download&id={file_id}"
    try:
        subprocess.run(
            ["curl", "-sL", "--max-time", "60", "-o", str(tmp_path), url],
            check=True, capture_output=True,
        )
    except (subprocess.SubprocessError, OSError):
        return None
    if not tmp_path.exists() or tmp_path.stat().st_size < 1024:
        tmp_path.unlink(missing_ok=True)
        return None
    header = tmp_path.read_bytes()[:8]
    ext = next((e for magic, e in MAGIC_EXTENSIONS if header.startswith(magic)), None)
    if ext is None:
        tmp_path.unlink(missing_ok=True)
        return None
    final_path = tmp_path.with_suffix(ext)
    tmp_path.rename(final_path)
    return final_path


def load_existing_manifest():
    if not MANIFEST_PATH.exists():
        return {}
    return json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))


def save_manifest(manifest):
    MANIFEST_PATH.write_text(json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8")


def download_one(team, dest_dir):
    dest_dir.mkdir(parents=True, exist_ok=True)
    file_id = team["file_id"]
    if not file_id:
        return None, "tidak ada tautan Google Drive"

    downloaded_path = None
    gdown_error = None
    try:
        downloaded = gdown.download(id=file_id, output=str(dest_dir) + "/", quiet=False)
        if downloaded:
            downloaded_path = Path(downloaded)
        else:
            gdown_error = "gdown tidak mengembalikan berkas (kemungkinan akses dibatasi)"
    except Exception as exc:  # noqa: BLE001 -- report every failure, never abort the batch
        gdown_error = str(exc)

    if downloaded_path is None:
        downloaded_path = try_curl_download(file_id, dest_dir)
        if downloaded_path is None:
            return None, gdown_error
    ext = downloaded_path.suffix
    final_name = sanitize_filename(f"{team['nama_tim']} - {team['ketua']}") + ext
    final_path = dest_dir / final_name
    if final_path.exists():
        final_path.unlink()
    downloaded_path.rename(final_path)
    return final_path, None


def main():
    retry_failed = "--retry-failed" in sys.argv[1:]
    roster = load_roster()
    manifest = load_existing_manifest()
    ok, fail = [], []

    for class_code, teams in roster.items():
        if not teams:
            continue
        dest_dir = UPLOADS_DIR / class_code
        for team in teams:
            key = f"{class_code}::{team['nama_tim']}"
            label = f"{class_code} / {team['nama_tim']}"

            if retry_failed:
                if manifest.get(key, {}).get("status") != "failed":
                    continue
            elif manifest.get(key, {}).get("status") == "ok":
                ok.append(label)
                continue

            local_path, error = download_one(team, dest_dir)
            if local_path is not None:
                manifest[key] = {
                    "local_path": str(local_path.relative_to(ROOT)),
                    "drive_url": team["drive_url"],
                    "status": "ok",
                }
                ok.append(label)
                print(f"[OK]   {label} -> {local_path.relative_to(ROOT)}")
            else:
                manifest[key] = {
                    "local_path": None,
                    "drive_url": team["drive_url"],
                    "status": "failed",
                    "error": error,
                }
                fail.append((label, error))
                print(f"[GAGAL] {label}: {error}")

            save_manifest(manifest)
            time.sleep(DELAY_SECONDS)

    print()
    print(f"Selesai: {len(ok)} berhasil, {len(fail)} gagal pada proses ini, manifest ditulis ke {MANIFEST_PATH}")
    if fail:
        print("Tim yang masih gagal (tautan Drive tetap dipakai sebagai fallback di workbook):")
        for label, error in fail:
            print(f"  - {label}: {error}")

    return 0 if not fail else 1


if __name__ == "__main__":
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    sys.exit(main())
