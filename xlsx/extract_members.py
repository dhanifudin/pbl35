"""
Best-effort extraction of team member rosters from the downloaded proposal
PDFs, since the submission form itself never collected a structured member
list (see gen_rubrik_proposal.py docstring).

Every proposal is required (per Format-Proposal-PBL-TI-Sem3/5.md) to include
a "1.2 Identitas Tim" / "1.2 Identitas Anggota" table (Nama | NIM | Peran) --
that is the primary, most reliable source. As a fallback, the cover page's
"Disusun Oleh" member list is parsed instead (looser format, more variation
across teams). This is inherently heuristic: student-authored documents vary
in wording, spacing, and line-wrapping, so extraction is NOT guaranteed for
every file, and is only attempted for teams whose file was downloaded
successfully. Results should be spot-checked, not trusted blindly.

Usage:
    uv run --with openpyxl python xlsx/extract_members.py

Writes:
    xlsx/members_manifest.json  -- {"<class_code>::<nama_tim>": [{"nama":, "nim":, "peran":}, ...]}
"""
import json
import re
import subprocess
import sys
import unicodedata
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from rubrik_common import UPLOADS_DIR, load_roster, sanitize_filename

MEMBERS_MANIFEST_PATH = Path(__file__).resolve().parent / "members_manifest.json"

NIM_RE = re.compile(r"(?:24|25)\d{10}")
SECTION_START_RE = re.compile(r"1\.2\.?\s*Identitas\s*(?:Tim|Anggota)", re.IGNORECASE)
SECTION_END_RE = re.compile(r"1\.3\.?\s*Mata\s*Kuliah|BAB\s+II|2\.\s*Ringkasan", re.IGNORECASE)
# "Nama Ketua" must come first in the alternation when it precedes "Nama
# Anggota" in the document, so the leader's own line isn't skipped.
COVER_START_RE = re.compile(
    r"Nama\s+Ketua|Di\s*susun\s+[Oo]leh|Nama\s+Anggota|Anggota\s+Kelompok", re.IGNORECASE
)
COVER_STOP_RE = re.compile(
    r"PROGRAM STUDI|JURUSAN TEKNOLOGI|POLITEKNIK|D-?\s?IV TEKNIK|D4 TEKNIK|"
    r"TAHUN AJARAN|Sampul dan Identitas|^\s*20\d{2}\s*$",
    re.IGNORECASE,
)
# Heading/label lines that carry no member data and must not be misread as a
# wrapped continuation of the previous member's name/role.
SKIP_LINE_RE = re.compile(
    r"^(Nama\s+(Ketua|Anggota)|Anggota(\s+Kelompok)?|Kelompok\s*\d*|Kelas\s*[:.]|"
    r"Di\s*susun\s+[Oo]leh)\s*[:.]*$",
    re.IGNORECASE,
)
ZERO_WIDTH = dict.fromkeys(map(ord, "​‌‍﻿"), None)
LIGATURES = str.maketrans({"ﬀ": "ff", "ﬁ": "fi", "ﬂ": "fl", "ﬃ": "ffi", "ﬄ": "ffl"})


def pdf_to_text(path):
    try:
        result = subprocess.run(
            ["pdftotext", "-layout", str(path), "-"],
            capture_output=True, text=True, timeout=30, check=True,
        )
        return result.stdout
    except (subprocess.SubprocessError, FileNotFoundError, OSError):
        return None


def soft_clean(line):
    """Normalize a line but keep leading whitespace -- needed to tell whether
    a no-NIM continuation line lines up with the Nama column or the Peran
    column when a long name or role wraps onto its own line."""
    line = line.translate(ZERO_WIDTH).translate(LIGATURES)
    return unicodedata.normalize("NFC", line)


def clean_line(line):
    return soft_clean(line).strip()


def parse_member_line(line):
    m = NIM_RE.search(line)
    if not m:
        return None
    nim = m.group()
    name = line[: m.start()]
    peran = line[m.end():]

    name = re.sub(r"^\s*\d+[.)]\s*", "", name)  # leading "1." / "1)" numbering
    name = re.sub(r"^\s*NIM\.?:?\s*", "", name, flags=re.IGNORECASE)
    name = re.sub(r"\s*NIM\.?:?\s*$", "", name, flags=re.IGNORECASE)
    name = name.strip(" \t/\\-–—.,:()[]")
    peran = re.sub(r"^\s*NIM\.?:?\s*", "", peran, flags=re.IGNORECASE)
    peran = peran.strip(" \t/\\-–—.,:()[]")

    if len(name) < 3 or not re.search(r"[A-Za-z]", name):
        return None

    entry = {"nama": name, "nim": nim}
    if peran and re.search(r"[A-Za-z]", peran) and len(peran) < 60:
        entry["peran"] = peran
    return entry


def dedupe(members):
    seen = set()
    result = []
    for m in members:
        if m["nim"] in seen:
            continue
        seen.add(m["nim"])
        result.append(m)
    return result


def parse_member_block(raw_lines):
    """Parse a block of raw (whitespace-preserved) lines into member entries,
    merging column-wrapped continuation lines (a long name or role that
    overflows onto the next line with no NIM of its own) back into the
    previous member."""
    entries = []
    name_indent = None
    for raw in raw_lines:
        line = soft_clean(raw)
        stripped = line.strip()
        if not stripped or SKIP_LINE_RE.match(stripped):
            continue
        if re.match(r"^Hal\.\s*\d+\s*/\s*\d+", stripped, re.IGNORECASE):
            continue
        if re.match(r"^Nama\s+NIM", stripped, re.IGNORECASE):
            continue

        if NIM_RE.search(line):
            member = parse_member_line(stripped)
            if member:
                entries.append(member)
                name_indent = len(line) - len(line.lstrip(" "))
            continue

        if not entries:
            continue

        indent = len(line) - len(line.lstrip(" "))
        parts = [p.strip() for p in re.split(r" {2,}", stripped) if p.strip()]
        if not parts:
            continue

        if name_indent is not None and abs(indent - name_indent) <= 3 and len(parts[0]) < 40:
            entries[-1]["nama"] = f"{entries[-1]['nama']} {parts[0]}".strip()
            parts = parts[1:]

        for frag in parts:
            if not re.search(r"[A-Za-z]", frag) or len(frag) >= 60:
                continue
            if "peran" in entries[-1]:
                entries[-1]["peran"] = f"{entries[-1]['peran']} {frag}".strip()
            else:
                entries[-1]["peran"] = frag

    return dedupe(entries)


def extract_section_table(text):
    start = SECTION_START_RE.search(text)
    if not start:
        return []
    end = SECTION_END_RE.search(text, start.end())
    block = text[start.end(): end.start() if end else start.end() + 2000]
    return parse_member_block(block.splitlines())


def extract_cover_list(text):
    start = COVER_START_RE.search(text)
    if not start:
        return []
    raw_lines = []
    for raw_line in text[start.end():].splitlines():
        if COVER_STOP_RE.search(clean_line(raw_line)):
            break
        raw_lines.append(raw_line)
    return parse_member_block(raw_lines)


def extract_members(pdf_path):
    text = pdf_to_text(pdf_path)
    if text is None:
        return [], "pdftotext_unavailable"

    members = extract_section_table(text)
    if len(members) >= 2:
        return members, "section_1_2"

    members = extract_cover_list(text)
    if len(members) >= 2:
        return members, "cover_page"

    return [], "not_found"


def main():
    roster = load_roster()
    manifest = {}
    stats = {"section_1_2": 0, "cover_page": 0, "not_found": 0, "no_file": 0, "pdftotext_unavailable": 0}

    for class_code, teams in roster.items():
        dest_dir = UPLOADS_DIR / class_code
        for team in teams:
            key = f"{class_code}::{team['nama_tim']}"
            expected_name = sanitize_filename(f"{team['nama_tim']} - {team['ketua']}")
            matches = list(dest_dir.glob(f"{expected_name}.*")) if dest_dir.exists() else []
            if not matches:
                stats["no_file"] += 1
                continue

            members, source = extract_members(matches[0])
            stats[source] += 1
            if members:
                manifest[key] = {"members": members, "source": source, "file": str(matches[0].name)}
                label = ", ".join(f"{m['nama']} ({m['nim']})" for m in members)
                print(f"[{source}] {class_code} / {team['nama_tim']}: {label}")
            else:
                print(f"[gagal] {class_code} / {team['nama_tim']}: tidak ditemukan pola anggota")

    MEMBERS_MANIFEST_PATH.write_text(json.dumps(manifest, indent=2, ensure_ascii=False), encoding="utf-8")

    print()
    print(f"Selesai: {len(manifest)} tim berhasil diekstrak dari {sum(v for k, v in stats.items() if k != 'no_file')} berkas yang tersedia")
    print(f"  section_1_2 (paling andal): {stats['section_1_2']}")
    print(f"  cover_page (fallback):      {stats['cover_page']}")
    print(f"  tidak ditemukan pola:       {stats['not_found']}")
    print(f"  tidak ada berkas lokal:     {stats['no_file']}")
    print(f"Manifest ditulis ke {MEMBERS_MANIFEST_PATH}")


if __name__ == "__main__":
    main()
