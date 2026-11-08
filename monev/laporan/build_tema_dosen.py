"""Code the open-ended answers of the LECTURER survey (anonymous coding, paraphrase only).

Run from the repo root:
    uv run --with openpyxl python -I monev/laporan/build_tema_dosen.py

Free text exists in three places of the lecturer survey: the optional "Saran perbaikan atau contoh praktik baik"
(column 66) and two typed "Lainnya" answers (column 31 and column 65). All 8 inputs from 7 of the 22 lecturers
were read and coded by hand. A respondent who teaches in both programmes counts in both TI and SIB.
Output (data/tema_dosen.json) holds only counts and paraphrased text: no names and no verbatim quotes, because
a quote from such a small group could identify the writer.
"""
import glob
import json
import os

import openpyxl

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RAW = glob.glob(os.path.join(ROOT, "docs", "monev", "*Dosen*.xlsx"))[0]
OUT = os.path.join(ROOT, "monev", "laporan", "data", "tema_dosen.json")

ws = openpyxl.load_workbook(RAW, read_only=True, data_only=True).worksheets[0]
rows = [r for r in ws.iter_rows(values_only=True)][1:]
rows = [r for r in rows if r and r[0]]
N = len(rows)
assert N == 22, N


def cell(r, i):
    return str(r[i]).strip() if len(r) > i and r[i] else ""


# 0-based respondent positions in sheet order -> keyword that must appear in the answer (guards against drift)
INPUTS = {
    "a_apresiasi": (0, 66, "Apresiasi kinerja dosen"),
    "a_rtm": (0, 66, "RTM"),
    "a_reward": (0, 66, "reward"),
    "a_repo": (0, 66, "repo"),
    "a_standar": (0, 65, "interpretasi mandiri"),
    "a_web": (5, 66, "website PBL"),
    "a_baik": (10, 66, "Sudah baik"),
    "a_mk": (14, 66, "dikurangi jumlah MK"),
    "a_koor": (15, 66, "Kordinasi diawal"),
    "a_anchor": (19, 66, "MK cantolan"),
    "a_timing": (12, 31, "timing materi"),
}
for k, (idx, col, kw) in INPUTS.items():
    assert kw.lower() in cell(rows[idx], col).lower(), (k, idx, col)

WRITERS = sorted({v[0] for v in INPUTS.values()})
assert len(WRITERS) == 7, WRITERS
n_inputs = 8  # the four numbered points of one answer count once, the typed "Lainnya" of the same lecturer is a second input


def prodi(idx):
    s = cell(rows[idx], 2)
    return {p for p in ("TI", "SIB") if any(x.strip().startswith(p) for x in s.split(","))}


def cnt(idxs):
    idxs = set(idxs)
    return {"n": len(idxs), "ti": sum(1 for i in idxs if "TI" in prodi(i)), "sib": sum(1 for i in idxs if "SIB" in prodi(i))}


def sub(label, idxs):
    return {"label": label, **cnt(idxs)}


THEMES = [
    ("apresiasi", "saran", "Apresiasi dan penghargaan untuk pelaksanaan PBL",
     [("Apresiasi kinerja dosen berdasarkan komitmen mendampingi dan hasil PBL, bukan hanya survei kepuasan mahasiswa", [0]),
      ("Aturan penghargaan produk PBL terbaik, dibuat dan diumumkan sejak awal semester", [0])],
     "Satu dosen menyarankan dua hal. Pertama, kinerja dosen sebaiknya dihargai berdasarkan komitmen mendampingi dan hasil PBL, bukan hanya survei kepuasan mahasiswa di akhir semester. Kedua, aturan penghargaan untuk produk PBL terbaik perlu dibuat dan diumumkan sejak awal semester, supaya mendorong mahasiswa berkarya.",
     "Ini satu-satunya komentar tentang penghargaan, jadi hanya bisa dibaca sebagai usulan, bukan pendapat umum dosen. Isinya layak dibahas karena menyangkut dua pihak sekaligus: dosen yang membimbing dan mahasiswa yang membuat produk."),
    ("beban", "saran", "Beban dan pemerataan tugas dosen pengampu",
     [("Pengampu PBL ditata ulang secara berkala lewat RTM, supaya tidak ada yang kelelahan dan semua dosen mendapat kesempatan", [0]),
      ("Dosen dengan tugas tambahan mengampu lebih sedikit mata kuliah", [14])],
     "Dua dosen menyinggung beban pengampu. Satu menyarankan pembagian pengampu PBL ditata ulang secara berkala lewat RTM, untuk mencegah kelelahan dan memberi kesempatan yang adil bagi dosen lain. Satu lagi menyarankan agar dosen dengan tugas tambahan mengampu lebih sedikit mata kuliah.",
     "Dua komentar ini menguatkan hambatan yang paling sering dipilih dosen: beban mengajar dan administrasi lain. Penyelesaiannya ada pada penugasan dosen, yang diputuskan di tingkat program studi dan jurusan, bukan di kelas."),
    ("panduan", "saran", "Panduan tertulis dan koordinasi sejak awal",
     [("Panduan tertulis yang mengikat, supaya pengampu tidak mengajar menurut tafsir masing-masing", [0]),
      ("Koordinasi di awal semester, pemantauan selama berjalan, dan evaluasi di akhir", [15])],
     "Dua dosen meminta aturan main yang lebih tegas. Satu menyebut mutu PBL sulit diukur kalau tiap pengampu mengajar menurut tafsirnya sendiri, sehingga perlu panduan tertulis yang mengikat. Satu lagi menyarankan urutan kerja yang jelas: koordinasi di awal, pemantauan selama semester, dan evaluasi di akhir.",
     "Permintaan ini sejalan dengan dukungan yang dipilih banyak dosen: rapat koordinasi rutin, pembagian peran dosen secara tertulis, dan panduan serta contoh penilaian. Dosen sendiri yang meminta panduan yang mengikat, jadi usulan SOP dan peran tertulis didukung oleh dosen."),
    ("wadah", "saran", "Wadah bersama untuk produk dan progres PBL",
     [("Repositori agar produk PBL tersimpan dan bisa dikembangkan lintas semester", [0]),
      ("Situs PBL supaya progres tertata dan bisa dicek bersama oleh dosen dan mahasiswa", [5])],
     "Dua dosen mengusulkan wadah bersama. Satu meminta repositori supaya produk PBL tersimpan dengan baik dan bisa dikembangkan terus lintas semester. Satu lagi meminta situs PBL supaya kegiatan tertata dan bisa diperiksa bersama oleh dosen dan mahasiswa.",
     "Usulan ini menjawab dua permintaan mahasiswa: sistem pemantau progres dan kontribusi, serta milestone di LMS. Satu wadah bisa melayani keduanya, yaitu tempat produk disimpan dan tempat progres tim dilihat."),
    ("keselarasan", "saran", "Keselarasan mata kuliah dengan PBL",
     [("Waktu penyampaian materi belum selaras dengan kebutuhan PBL", [12]),
      ("SIB belum punya mata kuliah acuan yang benar-benar bisa dipakai menilai PBL; dua mata kuliah hanya mendukung sebagian karena punya rubrik sendiri", [19])],
     "Dua dosen menyoroti kaitan mata kuliah dengan PBL. Satu menyebut waktu penyampaian materi di sebagian mata kuliah belum selaras dengan kebutuhan PBL. Satu lagi, dari SIB Semester 3, menyebut SIB belum punya mata kuliah acuan yang benar-benar bisa dipakai menilai PBL. Dua mata kuliah yang dikaitkan dengan PBL punya rubrik sendiri dan hanya mendukung sebagian.",
     "Dua komentar ini sejalan dengan angka survei tentang keselarasan tugas dan rubrik, yang juga dinilai rendah oleh dosen dan mahasiswa SIB. Perbaikannya: tinjau rubrik dan jadwal materi tiap mata kuliah terhadap milestone."),
    ("baik", "baik", "Hal baik yang ingin dipertahankan",
     [("Pelaksanaan dinilai sudah baik dan sebaiknya dilanjutkan", [10])],
     "Satu dosen menulis bahwa pelaksanaan PBL sudah baik dan sebaiknya dilanjutkan.",
     "Pernyataan ini sejalan dengan penilaian dosen pada butir pelaksanaan, tetapi hanya satu dosen yang menuliskannya sebagai saran."),
]

themes = []
for key, kind, label, subs, ringkasan, makna in THEMES:
    ids = sorted({i for _, ix in subs for i in ix})
    themes.append({"key": key, "kind": kind, "label": label, **cnt(ids),
                   "subs": [sub(l, ix) for l, ix in subs], "ringkasan": ringkasan, "makna": makna})

out = {
    "dosen_n": N, "penulis": cnt(WRITERS), "input": n_inputs,
    "themes": themes,
}
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w", encoding="utf-8") as f:
    json.dump(out, f, ensure_ascii=False, indent=1)
print("penulis", out["penulis"], "input", n_inputs)
for t in themes:
    print(t["key"], t["n"], t["ti"], t["sib"])
