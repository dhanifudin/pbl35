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
     [("Arahan, permintaan, atau umpan balik berbeda antar dosen", [5, 8, 13, 16, 18, 26, 45, 48, 52, 81, 92, 94, 103]),
      ("Kejelasan arah baru muncul setelah semester berjalan", [6, 27, 38]),
      ("Kekompakan dan pembagian peran dosen pengampu", [32, 57, 82])],
     "Komentar terbanyak datang dari SIB Semester 5. Mahasiswa menggambarkan arahan, permintaan, dan umpan balik yang berbeda antar dosen, sehingga mereka merasa kehilangan arah dan harus memilih sendiri arahan mana yang diikuti. Beberapa menyebut kejelasan baru muncul tiga minggu setelah semester berjalan.",
     "Keluhan ini bukan tentang kemampuan dosen satu per satu, melainkan tentang cara kerja bersama: belum ada wadah dan waktu untuk menyamakan arahan. Pola ini sejalan dengan data dosen, yaitu kesepakatan peran yang jarang ada dan rapat koordinasi yang tidak selalu dihadiri.",
     [(81, "Hanya beberapa dosen terkoordinasi dan saling berkomunikasi, terkadang menyulitkan ketika dosen A mengatakan A sedangkan dosen B tidak setuju dengan hal itu."),
      (52, "Terkadang terdapat perbedaan pendapat antara dosen satu dengan lainnya sehingga kami seperti hilang arah."),
      (92, "Antar dosen kurang ada komunikasi yang menyebabkan miskomunikasi dan membingungkan kami."),
      (27, "Diawal semester sekitar 3 minggu pertama belum ada kejelasan mengenai PBL ini sehingga ada keterlambatan dalam pembentukan kelompok yang juga menimbulkan keterlambatan milestone."),
      (16, "Koordinasi antar dosen bisa ditingkatkan karena beberapa dosen tidak berada di dalam satu kesepakatan yang jelas, terkadang sering miskomunikasi."),
      (26, "Koordinasi antar mata kuliah tolong diperbaiki, terkadang tidak sinkron antara mata kuliah yang satu dengan yang lain.")]),
    ("beban", "masalah", "Tugas mata kuliah di luar proyek dan tenggat yang menambah beban",
     [("Tugas praktikum, jobsheet, atau tugas besar berjalan terpisah dari PBL", [2, 5, 22, 50, 51, 58, 67, 68, 70, 73, 88, 90, 95, 105]),
      ("Tenggat dan lama waktu pengerjaan dirasa kurang", [1, 18, 23, 31, 33, 54])],
     "Ada dua keluhan yang berbeda. Pertama, tugas praktikum, jobsheet, atau tugas besar berjalan terpisah dari PBL sehingga mahasiswa merasa mengerjakan lebih dari satu proyek. Kedua, tenggat dan lama waktu dirasa singkat, termasuk usulan memperpanjang PBL menjadi dua semester.",
     "Mahasiswa tidak menolak PBL: beberapa justru menyatakan PBL layak dipertahankan asalkan tugas lain dikurangi. Masalahnya adalah penumpukan, bukan proyeknya. Data survei menguatkan hal ini, yaitu mahasiswa yang menilai beban berat jauh lebih tidak puas dan lebih tidak ingin PBL dilanjutkan.",
     [(73, "PBL dapat dipertahankan jika diluar itu tidak ada tugas yang membebankan mahasiswa, karena jadwal yang padat dan tugas yang diberikan juga banyak."),
      (67, "Dosen yang tidak terlibat dalam PBL tidak mengetahui seberapa besar tugas PBL dan memberikan tugas. Saat ini seakan akan ada 3 PBL."),
      (105, "Kalau bisa jobsheet-jobsheetnya tentang laporan progres PBL, dan tidak usah memberi tugas selain PBL."),
      (33, "Kritik dari saya hanya dari penyesuaian waktu dan tugas kuliah yang kadang bobotnya memberatkan sehingga agak susah progres PBL sampai mengorbankan waktu tidur."),
      (70, "Saran saya perkecil tugas kuliah untuk mata kuliah terkait dengan PBL; saya sudah merasakan banyaknya tugas di luar mata kuliah PBL."),
      (22, "Tugas di luar yang berkaitan dengan PBL dikurangi.")]),
    ("tim", "masalah", "Pembagian tim dan kontribusi anggota yang tidak seimbang",
     [("Anggota kurang berkontribusi", [24, 59, 61, 87, 88]),
      ("Cara tim dibentuk (pendapat terbelah: pilih sendiri atau diatur dosen)", [5, 6, 13, 21, 30, 59, 61, 96]),
      ("Kebutuhan memantau kontribusi tiap anggota", [25, 58])],
     "Ada dua isu yang terpisah: anggota yang kurang berkontribusi, dan cara tim dibentuk. Pendapat tentang pembentukan tim terbelah. Sebagian mahasiswa ingin memilih sendiri anggotanya agar cocok, sebagian lain ingin dosen membagi berdasarkan kemampuan agar seimbang. Beberapa meminta cara memantau kontribusi tiap anggota.",
     "Karena pendapatnya terbelah, aturan satu arah (acak, pilih sendiri, atau ditentukan dosen) akan tetap ditolak sebagian mahasiswa. Yang disepakati kedua pihak adalah kebutuhan akan bukti kontribusi individu yang dipantau dosen dan memengaruhi penilaian.",
     [(24, "Banyak anggota di tiap kelompok yang tidak mau bekerja atau berkontribusi untuk tim."),
      (59, "Akan lebih baik jika project manager (mahasiswa) diberikan kesempatan untuk memilih anggota kelompoknya sendiri agar lebih nyaman dalam bekerja sama."),
      (13, "Untuk pembagian tim sebaiknya dibagi secara serius, contohnya sesuai dengan keahlian yang dinilai pada performa PBL sebelumnya."),
      (25, "Lebih tegas dalam monitoring tiap anggota pada sebuah kelompok agar tahu kendala pada sebuah tim dan dapat memberikan solusi."),
      (88, "Evaluasi terhadap anggota tim yang susah diajak kerja sama dan jarang hadir."),
      (21, "Pemilihan kelompok yang lebih seimbang.")]),
    ("kejelasan", "masalah", "Kejelasan alur, milestone, dan template sejak awal semester",
     [("Template dan dokumen datang terlambat atau terpisah per mata kuliah", [52, 62, 63, 83, 94]),
      ("Alur dan target milestone kurang jelas di awal", [6, 27, 35, 37, 55]),
      ("Pemantauan milestone belum ada di LMS", [11])],
     "Mahasiswa meminta template, ketentuan, dan jadwal milestone diberikan sejak awal semester dan dalam satu bentuk, tidak terpisah per mata kuliah. Komentar dari SIB menyebut template dan jadwal yang mereka ikuti berasal dari TI dan disampaikan oleh dosen mata kuliah, bukan melalui paket informasi resmi SIB.",
     "Template sebenarnya termasuk hal yang paling dihargai. Yang bermasalah adalah waktu dan bentuk penyampaiannya. Perbaikannya murah dan dapat dimulai pada semester depan dengan satu paket informasi di minggu pertama.",
     [(94, "Tolong sekali, dari awal sudah diberi template laporan tiap mata kuliah supaya di akhir tidak kebingungan."),
      (52, "Dokumen pelaporan milestone sebaiknya langsung dijadikan satu untuk semua mata kuliah, karena dokumen yang terpisah-pisah membuat kami malah berfokus pada dokumen daripada perbaikan kode."),
      (37, "Arahan untuk milestone dan ketentuan pengerjaan PBL ditentukan dengan jelas sedari awal."),
      (11, "Milestone dan progres PBL sebaiknya dicantumkan di LMS untuk memudahkan koordinasi tiap minggunya."),
      (55, "Alur dan target milestone sebaiknya diperjelas.")]),
    ("bimbingan", "masalah", "Ketersediaan bimbingan dan kesesuaian materi dengan milestone",
     [("Sulit berkonsultasi atau dosen jarang hadir", [3, 14, 75, 76, 103]),
      ("Pembelajaran hanya berupa jobsheet atau penjelasan kurang", [28, 83, 85]),
      ("Materi datang terlambat atau tidak sesuai beban proyek", [17, 19, 86])],
     "Komentar menyebut kesulitan mendapat waktu konsultasi, dosen yang jarang hadir, dan pembelajaran yang hanya berupa jobsheet tanpa sesi meninjau proyek. Materi juga disebut sering datang setelah dibutuhkan untuk milestone.",
     "Pengalaman bimbingan tidak merata antar mata kuliah. Data per mata kuliah menunjukkan hal yang sama: kegiatan dosen terkait proyek berbeda jauh antar mata kuliah, dan ini lebih terasa daripada perbedaan antar program studi.",
     [(76, "Ada sebagian dosen yang jarang masuk sehingga kita tidak bisa berdiskusi mengenai proyek kami."),
      (17, "Materi mata kuliah yang sesuai dengan milestone harus diberikan sebelum target milestone."),
      (14, "Dosen sebaiknya lebih sering menanyakan progres kelompok, terutama kendala dalam pengerjaan, supaya kelompok tahu mana yang harus diperbaiki."),
      (3, "Mungkin bisa diperbaiki mengenai waktu konsultasi, karena tiap pertemuan selalu menjelaskan materi dan jobsheet tanpa sesi review atau kendala PBL."),
      (19, "Lanjutkan tersedianya bimbingan dan perbanyak bimbingan; materi sebaiknya sesuai beban PBL yang dilakukan.")]),
    ("nilai", "masalah", "Transparansi penilaian dan umpan balik",
     [("Transparansi nilai dan umpan balik yang jelas dan cepat", [38, 40, 42, 49, 95]),
      ("Kejelasan dan keadilan penilaian", [5, 50, 51]),
      ("Penilaian proses dan analisis, bukan hanya produk", [15])],
     "Mahasiswa menginginkan transparansi nilai PBL serta umpan balik yang jelas, cepat, dan membangun. Satu komentar SIB menyoroti bahwa penilaian lebih menekankan produk atau kode daripada analisis kebutuhan dan manajemen proyek yang menjadi ciri program studinya.",
     "Keadilan penilaian dan kejelasan rubrik termasuk hal yang paling berkaitan dengan kepuasan mahasiswa. Transparansi nilai karena itu bukan urusan administrasi semata, melainkan bagian dari pengalaman PBL.",
     [(40, "Saran transparansi nilai PBL serta umpan balik dari hasil penilaian."),
      (51, "Penilaian pure murni dari skill, bukan personality."),
      (15, "Keberhasilan PBL bagi SIB seharusnya tidak diukur dari seberapa bagus aplikasi yang dihasilkan, melainkan dari kedalaman analisis kebutuhan, metodologi perancangan, dan efektivitas manajemen proyek.")]),
    ("fasilitas", "masalah", "Fasilitas: server untuk deployment dan jaringan wifi",
     [("Server untuk deployment", [2, 41, 87]),
      ("Jaringan wifi dan perangkat", [57, 68, 86, 101])],
     "Seluruh komentar tentang fasilitas berasal dari mahasiswa SIB. Keluhan utamanya adalah server untuk deployment: mahasiswa terpaksa memakai layanan gratis yang terbatas dan menyarankan kampus menyediakan server. Beberapa komentar lain menyebut jaringan wifi.",
     "Menurut salah satu komentar, PBL Semester 5 menuntut deployment sehingga kebutuhan server meningkat. Fasilitas juga butir dengan skor terendah dan salah satu yang paling berkaitan dengan kepuasan, sehingga pengaruhnya lebih besar daripada jumlah komentarnya.",
     [(41, "Beberapa mahasiswa sangat terkendala dengan tidak adanya server dari kampus untuk deployment."),
      (2, "Mungkin ke depannya pihak jurusan bisa menyediakan server di kampus bagi mahasiswa yang ingin melakukan deployment untuk kebutuhan PBL."),
      (101, "Wifi jurusan tolong jangan lag.")]),
    ("perubahan", "masalah", "Dosen menambah atau mengubah kebutuhan di luar proposal saat review",
     [("Permintaan fitur atau alur baru setelah proposal disepakati", [16, 106])],
     "Dua komentar TI menyebut dosen menambah fitur atau mengubah alur pada saat review progres, padahal proposal sudah disepakati di awal.",
     "Jumlahnya kecil, tetapi menunjukkan belum ada kesepakatan bersama tentang apa yang boleh diminta setelah proposal disetujui. Ini bagian dari kebutuhan akan arahan tunggal antar dosen.",
     [(106, "Waktu report progres, sebaiknya dosen tidak meminta tambahan fitur atau mengubah alur yang sudah dijelaskan di proposal.")]),
    ("baik", "baik", "Hal baik yang ingin dipertahankan",
     [("Manfaat PBL (pengalaman, kerja sama, bekal kerja)", [15, 33, 59, 68, 89, 90, 99]),
      ("Pelaksanaan lebih rapi atau jelas dari sebelumnya", [1, 28, 48, 60, 62]),
      ("Bimbingan dan konsultasi dosen", [19, 30, 63, 74]),
      ("Baik secara umum", [64, 100])],
     "Pujian paling banyak menyebut manfaat PBL (pengalaman, kerja sama, bekal kerja), konsultasi dosen, dan template. Beberapa mahasiswa SIB Semester 5 menyebut pelaksanaan semester ini lebih rapi daripada semester sebelumnya.",
     "Hal baik ada pada yang sudah dibangun (template, bimbingan, manfaat), sedangkan keluhan ada pada cara kerja bersama dan beban. Banyak komentar kritis justru ditutup dengan keinginan agar PBL dipertahankan dan diperbaiki, bukan dihentikan.",
     [(60, "Pelaksanaan PBL semester 5 di kelas kami sudah cukup baik dan rapi, cukup berbeda dari semester sebelumnya; sudah ada perbaikan."),
      (89, "Untuk PBL ini tetap dipertahankan saja karena bisa dijadikan bekal atau latihan untuk ke depannya seperti kerja."),
      (30, "Inisiatif dosen membuka ruang untuk berkonsultasi sangat memudahkan saya."),
      (90, "PBL actually very good. How our learning outcomes implemented to some near real project for preparing us in real life work later.")]),
]

# comments that say this semester is better than the previous one
IMPROVED = [1, 60, 62]

# concrete suggestions made by students: label, answer numbers
USULAN = [
    ("Template, dokumen, dan ketentuan diberikan sejak awal, dalam satu dokumen", [6, 18, 37, 52, 62, 63, 83, 94]),
    ("Kurangi atau satukan tugas mata kuliah di luar PBL", [22, 50, 58, 70, 73, 88, 95, 105]),
    ("Pembagian tim lebih seimbang atau lebih diatur", [13, 21, 30, 59, 61, 96]),
    ("Sistem pemantauan progres dan kontribusi (termasuk milestone di LMS)", [11, 14, 25, 57, 58]),
    ("Server kampus untuk deployment dan perbaikan jaringan", [2, 41, 57, 68, 86, 101]),
    ("Transparansi nilai dan umpan balik yang jelas", [38, 40, 42, 49, 95]),
    ("Perpanjang waktu atau durasi PBL", [18, 23, 31, 54]),
    ("Materi diberikan sebelum milestone dan sesuai beban proyek", [17, 19, 86]),
    ("Masukan dosen atau mitra untuk topik proyek dari dunia kerja", [13, 65, 78]),
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
