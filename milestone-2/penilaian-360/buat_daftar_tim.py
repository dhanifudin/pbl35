"""Buat blok DAFTAR_TIM untuk Buat-Form-Penilaian-360.gs dari data anggota tim.

Jalankan dari akar repo:
    python3 -I milestone-2/penilaian-360/buat_daftar_tim.py [keluaran.txt]

Membaca xlsx/members_manifest.json (anggota tim hasil ekstraksi proposal) dan
menulis satu baris per anggota dengan format "Kelas;Tim;Nama Anggota".
Keluaran berisi nama mahasiswa, jadi simpan di luar repo (jangan di-commit).

Yang dicek dan diberi peringatan, bukan diperbaiki diam-diam:
- nama tim yang terlihat berantakan (terlalu panjang atau berisi daftar nama/NIM),
- tim dengan kurang dari 2 anggota (ditolak skrip form) atau di luar rentang 4-6 anggota (peringatan),
- nama tim ganda dalam satu kelas,
- kelas yang tidak ada pada data (mis. SIB dan TI-3B bila belum diekstraksi).
"""
import collections
import json
import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
MANIFEST = os.path.join(ROOT, "xlsx", "members_manifest.json")
KELAS_DIHARAPKAN = (
    [f"TI-2{c}" for c in "ABCDEFGHI"] + [f"TI-3{c}" for c in "ABCDEFGHI"]
    + [f"SIB-2{c}" for c in "ABCDEFG"] + [f"SIB-3{c}" for c in "ABCDEFG"]
)
BATAS_NAMA_TIM = 40
UKURAN_TIM = (4, 6)


def kelas_baku(kode):
    return kode.replace("_", "-")


def nama_tim_berantakan(tim):
    return len(tim) > BATAS_NAMA_TIM or bool(re.search(r"\d{9,}", tim))


def main():
    with open(MANIFEST, encoding="utf-8") as f:
        data = json.load(f)

    baris, peringatan = [], []
    per_kelas = collections.defaultdict(list)
    for kunci, nilai in data.items():
        kode, tim = kunci.split("::", 1)
        per_kelas[kelas_baku(kode)].append((tim.strip(), [m["nama"].strip() for m in nilai["members"]]))

    for kelas in sorted(per_kelas):
        dipakai = collections.Counter()
        for i, (tim, anggota) in enumerate(per_kelas[kelas], start=1):
            asli = tim
            if nama_tim_berantakan(tim):
                tim = f"PERIKSA-NAMA-TIM-{kelas}-{i}"
                peringatan.append(f"{kelas}: nama tim tidak wajar ({asli[:50]!r}...), diganti {tim}")
            dipakai[tim] += 1
            if dipakai[tim] > 1:
                tim = f"{tim} ({dipakai[tim]})"
                peringatan.append(f"{kelas}: nama tim ganda, ditambah nomor: {tim}")
            if len(anggota) < 2:
                peringatan.append(f"{kelas}/{tim}: anggota kurang dari 2, skrip form akan menolak")
            elif not (UKURAN_TIM[0] <= len(anggota) <= UKURAN_TIM[1]):
                peringatan.append(f"{kelas}/{tim}: {len(anggota)} anggota, di luar rentang {UKURAN_TIM[0]}-{UKURAN_TIM[1]}")
            for nama in anggota:
                baris.append(f"{kelas};{tim.replace(';', ',')};{nama.replace(';', ',')}")

    hilang = [k for k in KELAS_DIHARAPKAN if k not in per_kelas]
    if hilang:
        peringatan.append("Kelas tanpa data (perlu ditambah dari daftar tim lain): " + ", ".join(hilang))

    keluaran = "\n".join(baris) + "\n"
    if len(sys.argv) > 1:
        with open(sys.argv[1], "w", encoding="utf-8") as f:
            f.write(keluaran)
    else:
        sys.stdout.write(keluaran)

    sys.stderr.write(f"{len(baris)} baris, {sum(len(v) for v in per_kelas.values())} tim, {len(per_kelas)} kelas\n")
    for p in peringatan:
        sys.stderr.write("PERINGATAN: " + p + "\n")


if __name__ == "__main__":
    main()
