"""Build the anonymous coding of the open-ended answers (survey column 'Saran...').

Run from the repo root:
    uv run --with openpyxl python -I monev/laporan/build_tema.py

All 107 student answers were read and coded by hand (lecturer free text is not analyzed). Numbers below are the
1-based positions of the NON-EMPTY answers in sheet order. An answer may belong to several themes
and sub-themes. Output (data/tema.json) holds only counts, synthesis text, and short quotes that
carry no names of lecturers or courses.
"""
import glob
import json
import os

import openpyxl

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RAW = glob.glob(os.path.join(ROOT, "docs", "monev", "*Mahasiswa*.xlsx"))[0]
OUT = os.path.join(ROOT, "monev", "laporan", "data", "tema.json")

# answers with no content ("-", "tidak ada", "ok")
EMPTY = {4, 9, 10, 12, 20, 29, 34, 36, 43, 44, 46, 47, 53, 56, 69, 71, 72, 77, 79, 80, 91, 93, 97, 98, 104, 107}

# key, kind, label, [(sub label, ids)], ringkasan, makna, [(answer no, quote)]
THEMES = [
    ("koordinasi", "masalah", "Koordinasi dan konsistensi antar dosen",
     [("Arahan, permintaan, atau masukan berbeda antar dosen", [5, 8, 13, 16, 18, 26, 45, 48, 52, 81, 92, 94, 103]),
      ("Arah baru jelas setelah semester berjalan", [6, 27, 38]),
      ("Kekompakan dan pembagian peran dosen", [32, 57, 82])],
     "Komentar terbanyak datang dari SIB Semester 5. Mahasiswa mengatakan arahan, permintaan, dan masukan dosen sering berbeda. Mereka merasa kehilangan arah dan harus memilih sendiri arahan mana yang diikuti. Ada yang menyebut kejelasan baru muncul tiga minggu setelah semester berjalan.",
     "Keluhan ini bukan soal kemampuan masing-masing dosen. Masalahnya ada pada cara kerja bersama: belum ada forum dan waktu untuk menyamakan arahan. Data dosen sejalan dengan ini: kesepakatan peran jarang ada dan rapat koordinasi tidak selalu dihadiri.",
     [(81, "Hanya beberapa dosen terkoordinasi dan saling berkomunikasi, terkadang menyulitkan ketika dosen A mengatakan A sedangkan dosen B tidak setuju dengan hal itu."),
      (52, "Terkadang terdapat perbedaan pendapat antara dosen satu dengan lainnya sehingga kami seperti hilang arah."),
      (92, "Antar dosen kurang ada komunikasi yang menyebabkan miskomunikasi dan membingungkan kami."),
      (27, "Diawal semester sekitar 3 minggu pertama belum ada kejelasan mengenai PBL ini sehingga ada keterlambatan dalam pembentukan kelompok yang juga menimbulkan keterlambatan milestone."),
      (16, "Koordinasi antar dosen bisa ditingkatkan karena beberapa dosen tidak berada di dalam satu kesepakatan yang jelas, terkadang sering miskomunikasi."),
      (26, "Koordinasi antar mata kuliah tolong diperbaiki, terkadang tidak sinkron antara mata kuliah yang satu dengan yang lain.")]),
    ("beban", "masalah", "Tugas di luar proyek dan tenggat yang menambah beban",
     [("Tugas praktikum, jobsheet, atau tugas besar yang terpisah dari PBL", [2, 5, 22, 50, 51, 58, 67, 68, 70, 73, 88, 90, 95, 105]),
      ("Tenggat dan waktu pengerjaan terasa kurang", [1, 18, 23, 31, 33, 54])],
     "Ada dua keluhan. Pertama, tugas praktikum, jobsheet, atau tugas besar berjalan terpisah dari PBL, sehingga mahasiswa merasa mengerjakan lebih dari satu proyek. Kedua, tenggat dan waktu pengerjaan terasa singkat; ada yang mengusulkan PBL diperpanjang menjadi dua semester.",
     "Mahasiswa tidak menolak PBL. Beberapa justru mengatakan PBL layak dipertahankan asalkan tugas lain dikurangi. Masalahnya ada pada tugas yang menumpuk, bukan pada proyeknya. Survei menunjukkan hal yang sama: mahasiswa yang menilai beban berat jauh kurang puas dan kurang ingin PBL dilanjutkan.",
     [(73, "PBL dapat dipertahankan jika diluar itu tidak ada tugas yang membebankan mahasiswa, karena jadwal yang padat dan tugas yang diberikan juga banyak."),
      (67, "Dosen yang tidak terlibat dalam PBL tidak mengetahui seberapa besar tugas PBL dan memberikan tugas. Saat ini seakan akan ada 3 PBL."),
      (105, "Kalau bisa jobsheet-jobsheetnya tentang laporan progres PBL, dan tidak usah memberi tugas selain PBL."),
      (33, "Kritik dari saya hanya dari penyesuaian waktu dan tugas kuliah yang kadang bobotnya memberatkan sehingga agak susah progres PBL sampai mengorbankan waktu tidur."),
      (70, "Saran saya perkecil tugas kuliah untuk mata kuliah terkait dengan PBL; saya sudah merasakan banyaknya tugas di luar mata kuliah PBL."),
      (22, "Tugas di luar yang berkaitan dengan PBL dikurangi.")]),
    ("tim", "masalah", "Kontribusi anggota tim dan cara membentuk tim",
     [("Anggota kurang berkontribusi", [24, 59, 61, 87, 88]),
      ("Cara membentuk tim (pendapat terbelah: pilih sendiri atau diatur dosen)", [5, 6, 13, 21, 30, 59, 61, 96]),
      ("Perlu cara memantau kontribusi tiap anggota", [25, 58])],
     "Ada dua masalah yang berbeda: anggota yang kurang berkontribusi dan cara tim dibentuk. Pendapat tentang pembentukan tim terbelah. Sebagian mahasiswa ingin memilih sendiri anggotanya agar cocok. Sebagian lain ingin dosen yang membagi berdasarkan kemampuan agar seimbang. Beberapa juga meminta cara memantau kontribusi tiap anggota.",
     "Karena pendapatnya terbelah, aturan satu arah (acak, pilih sendiri, atau ditentukan dosen) akan tetap ditolak sebagian mahasiswa. Kedua pihak sepakat pada satu hal: kontribusi tiap orang perlu terlihat, dipantau dosen, dan memengaruhi nilai.",
     [(24, "Banyak anggota di tiap kelompok yang tidak mau bekerja atau berkontribusi untuk tim."),
      (59, "Akan lebih baik jika project manager (mahasiswa) diberikan kesempatan untuk memilih anggota kelompoknya sendiri agar lebih nyaman dalam bekerja sama."),
      (13, "Untuk pembagian tim sebaiknya dibagi secara serius, contohnya sesuai dengan keahlian yang dinilai pada performa PBL sebelumnya."),
      (25, "Lebih tegas dalam monitoring tiap anggota pada sebuah kelompok agar tahu kendala pada sebuah tim dan dapat memberikan solusi."),
      (88, "Evaluasi terhadap anggota tim yang susah diajak kerja sama dan jarang hadir."),
      (21, "Pemilihan kelompok yang lebih seimbang.")]),
    ("kejelasan", "masalah", "Alur, milestone, dan template perlu jelas sejak awal semester",
     [("Template dan dokumen terlambat atau terpisah per mata kuliah", [52, 62, 63, 83, 94]),
      ("Alur dan target milestone kurang jelas di awal", [6, 27, 35, 37, 55]),
      ("Milestone belum ada di LMS", [11])],
     "Mahasiswa meminta template, ketentuan, dan jadwal milestone diberikan sejak awal semester, dalam satu dokumen untuk semua mata kuliah. Mahasiswa SIB menyebut template dan jadwal yang mereka pakai berasal dari TI dan disampaikan dosen mata kuliah, bukan lewat paket informasi resmi SIB.",
     "Template sebenarnya salah satu hal yang paling dihargai. Yang bermasalah adalah waktu dan cara penyampaiannya. Perbaikannya murah: satu paket informasi di minggu pertama semester depan.",
     [(94, "Tolong sekali, dari awal sudah diberi template laporan tiap mata kuliah supaya di akhir tidak kebingungan."),
      (52, "Dokumen pelaporan milestone sebaiknya langsung dijadikan satu untuk semua mata kuliah, karena dokumen yang terpisah-pisah membuat kami malah berfokus pada dokumen daripada perbaikan kode."),
      (37, "Arahan untuk milestone dan ketentuan pengerjaan PBL ditentukan dengan jelas sedari awal."),
      (11, "Milestone dan progres PBL sebaiknya dicantumkan di LMS untuk memudahkan koordinasi tiap minggunya."),
      (55, "Alur dan target milestone sebaiknya diperjelas.")]),
    ("bimbingan", "masalah", "Bimbingan dan ketepatan waktu materi",
     [("Sulit berkonsultasi atau dosen jarang hadir", [3, 14, 75, 76, 103]),
      ("Kelas hanya berisi jobsheet atau penjelasan kurang", [28, 83, 85]),
      ("Materi terlambat atau tidak sesuai kebutuhan proyek", [17, 19, 86])],
     "Komentar menyebut sulit mendapat waktu konsultasi, dosen yang jarang hadir, dan kelas yang hanya berisi jobsheet tanpa sesi meninjau proyek. Materi juga sering datang setelah milestone membutuhkannya.",
     "Pengalaman bimbingan berbeda-beda antar mata kuliah. Data per mata kuliah menunjukkan hal yang sama: kegiatan dosen untuk proyek sangat bervariasi antar mata kuliah, lebih daripada antar program studi.",
     [(76, "Ada sebagian dosen yang jarang masuk sehingga kita tidak bisa berdiskusi mengenai proyek kami."),
      (17, "Materi mata kuliah yang sesuai dengan milestone harus diberikan sebelum target milestone."),
      (14, "Dosen sebaiknya lebih sering menanyakan progres kelompok, terutama kendala dalam pengerjaan, supaya kelompok tahu mana yang harus diperbaiki."),
      (3, "Mungkin bisa diperbaiki mengenai waktu konsultasi, karena tiap pertemuan selalu menjelaskan materi dan jobsheet tanpa sesi review atau kendala PBL."),
      (19, "Lanjutkan tersedianya bimbingan dan perbanyak bimbingan; materi sebaiknya sesuai beban PBL yang dilakukan.")]),
    ("nilai", "masalah", "Transparansi penilaian dan umpan balik",
     [("Nilai transparan, umpan balik jelas dan cepat", [38, 40, 42, 49, 95]),
      ("Penilaian jelas dan adil", [5, 50, 51]),
      ("Menilai proses dan analisis, bukan hanya produk", [15])],
     "Mahasiswa ingin nilai PBL transparan dan umpan balik jelas, cepat, dan membangun. Satu komentar SIB mengatakan penilaian terlalu menekankan produk atau kode, padahal ciri SIB adalah analisis kebutuhan dan manajemen proyek.",
     "Penilaian yang adil dan rubrik yang jelas termasuk hal yang paling berhubungan dengan kepuasan mahasiswa. Jadi transparansi nilai bukan sekadar urusan administrasi; ia bagian dari pengalaman PBL.",
     [(40, "Saran transparansi nilai PBL serta umpan balik dari hasil penilaian."),
      (51, "Penilaian pure murni dari skill, bukan personality."),
      (15, "Keberhasilan PBL bagi SIB seharusnya tidak diukur dari seberapa bagus aplikasi yang dihasilkan, melainkan dari kedalaman analisis kebutuhan, metodologi perancangan, dan efektivitas manajemen proyek.")]),
    ("fasilitas", "masalah", "Fasilitas: server untuk deployment dan jaringan wifi",
     [("Server untuk deployment", [2, 41, 87]),
      ("Jaringan wifi dan perangkat", [57, 68, 86, 101])],
     "Semua komentar tentang fasilitas datang dari mahasiswa SIB. Keluhan utamanya server untuk deployment: mahasiswa terpaksa memakai layanan gratis yang terbatas, dan mereka menyarankan kampus menyediakan server. Beberapa komentar lain menyebut wifi.",
     "Satu komentar menyebut PBL Semester 5 menuntut deployment, sehingga kebutuhan server naik. Fasilitas juga butir dengan skor terendah dan salah satu yang paling berhubungan dengan kepuasan. Pengaruhnya karena itu lebih besar daripada jumlah komentarnya.",
     [(41, "Beberapa mahasiswa sangat terkendala dengan tidak adanya server dari kampus untuk deployment."),
      (2, "Mungkin ke depannya pihak jurusan bisa menyediakan server di kampus bagi mahasiswa yang ingin melakukan deployment untuk kebutuhan PBL."),
      (101, "Wifi jurusan tolong jangan lag.")]),
    ("perubahan", "masalah", "Dosen menambah atau mengubah permintaan setelah proposal disetujui",
     [("Permintaan fitur atau alur baru setelah proposal disetujui", [16, 106])],
     "Dua komentar TI mengatakan dosen menambah fitur atau mengubah alur saat review progres, padahal proposal sudah disetujui di awal.",
     "Jumlahnya kecil, tetapi menunjukkan dosen belum sepakat tentang apa yang boleh diminta setelah proposal disetujui. Ini bagian dari kebutuhan akan satu arahan yang sama antar dosen.",
     [(106, "Waktu report progres, sebaiknya dosen tidak meminta tambahan fitur atau mengubah alur yang sudah dijelaskan di proposal.")]),
    ("baik", "baik", "Hal baik yang ingin dipertahankan",
     [("Manfaat PBL (pengalaman, kerja sama, bekal kerja)", [15, 33, 59, 68, 89, 90, 99]),
      ("Pelaksanaan lebih rapi dari sebelumnya", [1, 28, 48, 60, 62]),
      ("Bimbingan dan konsultasi dosen", [19, 30, 63, 74]),
      ("Baik secara umum", [64, 100])],
     "Pujian paling banyak menyebut manfaat PBL (pengalaman, kerja sama, bekal kerja), konsultasi dengan dosen, dan template. Beberapa mahasiswa SIB Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada semester sebelumnya.",
     "Hal baik ada pada yang sudah dibangun: template, bimbingan, dan manfaat. Keluhan ada pada cara kerja bersama dan beban. Banyak komentar kritis justru ditutup dengan harapan agar PBL dipertahankan dan diperbaiki, bukan dihentikan.",
     [(60, "Pelaksanaan PBL semester 5 di kelas kami sudah cukup baik dan rapi, cukup berbeda dari semester sebelumnya; sudah ada perbaikan."),
      (89, "Untuk PBL ini tetap dipertahankan saja karena bisa dijadikan bekal atau latihan untuk ke depannya seperti kerja."),
      (30, "Inisiatif dosen membuka ruang untuk berkonsultasi sangat memudahkan saya."),
      (90, "PBL actually very good. How our learning outcomes implemented to some near real project for preparing us in real life work later.")]),
]

# comments that say this semester is better than the previous one
IMPROVED = [1, 60, 62]

# concrete suggestions made by students: label, answer numbers
USULAN = [
    ("Berikan template dan ketentuan sejak awal, dalam satu dokumen", [6, 18, 37, 52, 62, 63, 83, 94]),
    ("Kurangi atau gabungkan tugas di luar PBL", [22, 50, 58, 70, 73, 88, 95, 105]),
    ("Bagi tim lebih seimbang atau lebih terarah", [13, 21, 30, 59, 61, 96]),
    ("Sediakan sistem pemantau progres dan kontribusi (termasuk milestone di LMS)", [11, 14, 25, 57, 58]),
    ("Sediakan server kampus untuk deployment dan perbaiki jaringan", [2, 41, 57, 68, 86, 101]),
    ("Buat nilai transparan dan umpan balik jelas", [38, 40, 42, 49, 95]),
    ("Perpanjang waktu atau durasi PBL", [18, 23, 31, 54]),
    ("Beri materi sebelum milestone dan sesuai kebutuhan proyek", [17, 19, 86]),
    ("Minta masukan dosen atau mitra untuk topik proyek dari dunia kerja", [13, 65, 78]),
]

def main():
    ws = openpyxl.load_workbook(RAW, read_only=True, data_only=True).worksheets[0]
    rows = list(ws.iter_rows(values_only=True))[1:]
    grp = {}  # answer number -> "TI Semester 3" ...
    i = 0
    for r in rows:
        if len(r) > 269 and r[269] and str(r[269]).strip():
            i += 1
            grp[i] = str(r[2])
    assert len(grp) == 107, len(grp)
    prodi = {k: v.split()[0] for k, v in grp.items()}
    sub = [k for k in grp if k not in EMPTY]
    keys = ["TI Semester 3", "TI Semester 5", "SIB Semester 3", "SIB Semester 5"]

    def counts(ids):
        ids = set(ids)
        return {"n": len(ids), "ti": sum(1 for k in ids if prodi[k] == "TI"), "sib": sum(1 for k in ids if prodi[k] == "SIB"),
                "by_sem": {s: sum(1 for k in ids if grp[k] == s) for s in keys}}

    out = {"total_answers": 107, "substantive": len(sub), "substantive_ti": sum(1 for k in sub if prodi[k] == "TI"),
           "substantive_sib": sum(1 for k in sub if prodi[k] == "SIB"),
           "substantive_by_sem": {s: sum(1 for k in sub if grp[k] == s) for s in keys}, "themes": []}

    prob_ids, good_ids = set(), set()
    for key, kind, label, subs, ringkasan, makna, quotes in THEMES:
        ids = sorted({k for _, s in subs for k in s})
        assert not set(ids) & EMPTY, key
        (good_ids if kind == "baik" else prob_ids).update(ids)
        for _, q in quotes:
            pass
        out["themes"].append({
            "key": key, "kind": kind, "label": label, **counts(ids), "ringkasan": ringkasan, "makna": makna,
            "subs": [{"label": sl, **counts(s)} for sl, s in subs],
            "quotes": [{"text": t, "tag": "Mahasiswa " + grp[k]} for k, t in quotes],
        })

    both = good_ids & prob_ids
    coded = good_ids | prob_ids
    sent = {"kritik": prob_ids - good_ids, "pujian": good_ids - prob_ids, "campuran": both, "lain": set(sub) - coded}
    out["sentimen"] = [{"label": k, **counts(v)} for k, v in sent.items()]
    out["membaik"] = counts(IMPROVED)
    # comments saying SIB receives information, templates, or the schedule late or via TI
    out["sib_info"] = counts([7, 62, 63, 83, 6])
    out["usulan"] = sorted(({"label": lab, **counts(ids)} for lab, ids in USULAN), key=lambda x: -x["n"])

    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=1)
    print("substantive", out["substantive"], "ti", out["substantive_ti"], "sib", out["substantive_sib"], out["substantive_by_sem"])
    for t in out["themes"]:
        print(f"{t['n']:3d} ti={t['ti']:2d} sib={t['sib']:2d}  {t['label'][:60]}  | subs {[s['n'] for s in t['subs']]}")
    print("sentimen", [(s["label"], s["n"]) for s in out["sentimen"]], "sum", sum(s["n"] for s in out["sentimen"]))
    print("usulan", [(u["label"][:30], u["n"]) for u in out["usulan"]])


if __name__ == "__main__":
    main()
