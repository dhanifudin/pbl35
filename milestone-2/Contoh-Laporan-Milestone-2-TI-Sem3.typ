#import "contoh-lib.typ": *
#show: doc => contoh(product: "SIKAP-PBL", team: "Koyok Ngene Lho",
  title: "Contoh Laporan Milestone 2 PBL (SIKAP-PBL, TI Semester 3)", doc)

#cover-sikap(
  product: "SIKAP-PBL",
  subtitle: "Sistem Informasi Kontribusi, Aktivitas, dan Partisipasi PBL",
  prodi: "Program Studi Teknik Informatika, Semester 3",
  team: "Koyok Ngene Lho", class-line: "Kelas TI-2C",
  members: "Raka Aditya Pratama, Salsabila Rahma Putri, Farrel Ibrahim Nugroho, Nadia Kirana Sari",
  year-line: "Tahun Akademik 2026/2027 · November 2026",
  headline: "Siapa Sebenarnya Mengerjakan Apa?", accent-word: "Mengerjakan",
  coverlines: (("Basis data", "13 tabel dan satu skema yang dibekukan di Minggu 9"), ("Bug", "Dua bug yang belum selesai"), ("Perubahan", "Dari MySQL ke PostgreSQL di tengah jalan"), ("Uji kecil", "Benarkah pengingat menolong?"),)
)
#counter(page).update(1)

#usage-note()

// =====================================================================
// LEMBAR STATUS
// =====================================================================
#part("Lembar Status Milestone 2", "Posisi Proyek pada Minggu 12")
#pill(st-hapus)
#v(0.5em)
#fakta((("Status", "Sebagian"), ("Kelas", "TI-2C"), ("Dosen rujukan", "Dian Hanifudin Subhi"), ("Tim", "Koyok Ngene Lho")))

#sec("S.1", "Identitas, Dosen Pengampu, dan Dosen Rujukan")
#tbl((1.6fr, 1.1fr, 1.6fr, 1.2fr),
  ([Nama], [NIM], [Peran saat ini], [Perubahan dari Milestone 1]),
  (
    ([Raka Aditya Pratama], [2341720011], [Ketua Tim dan Pengembang Utama], [Tidak ada]),
    ([Salsabila Rahma Putri], [2341720012], [Analis dan Desainer], [Tidak ada]),
    ([Farrel Ibrahim Nugroho], [2341720013], [Sekretaris dan Dokumentator], [Tidak ada]),
    ([Nadia Kirana Sari], [2341720014], [Penguji (QA)], [Tidak ada]),
  ), sz: 8.2pt)
#v(0.3em)
Keempat mata kuliah (Manajemen Proyek, Desain dan Pemrograman Web, Basis Data Lanjut, dan Sistem Informasi Manajemen) diampu Dian Hanifudin Subhi, M.Kom., yang juga menjadi dosen rujukan kelas TI-2C.

#sec("S.2", "Status Milestone 2")
Status kami Sebagian. Formulir Catat Aktivitas dan Dashboard Partisipasi sudah berjalan dengan 120 catatan data uji, dan alur utamanya (anggota mencatat, ketua tim memantau) bisa didemokan. Dua bug masih membuat alur itu gagal pada kasus tertentu, yaitu BUG-03 dan BUG-05. Rekap Keterlibatan Dosen baru berupa kueri dan tampilannya belum ada, sedangkan Pengingat Otomatis sengaja kami tunda ke laporan akhir. Dari 12 kasus uji, 10 lulus dan 2 gagal. Kami memilih Sebagian karena alur utama belum stabil, dan ingin memperbaikinya bersama dosen rujukan sebelum Minggu 14.

#sec("S.3", "Tindak Lanjut Milestone 1")
#tbl((2.2fr, 1.4fr, 2.2fr, 0.8fr),
  ([Umpan balik Milestone 1], [Mata kuliah], [Tindak lanjut], [Status]),
  (
    ([Relasi `Kontribusi` dan `Checkpoint` perlu dijelaskan], [Basis Data Lanjut], [PDM diperbarui dan skema dibekukan pada Minggu 9], [Selesai]),
    ([Kategori kontribusi belum selaras dengan rubrik], [Manajemen Proyek], [Kategori disamakan dengan rubrik checkpoint], [Selesai]),
  ), sz: 8.2pt)

#sec("S.4", "Capaian Produk")
Sudah berjalan: login empat peran dengan sandi ter-hash, Formulir Catat Aktivitas Mingguan, unggah bukti berupa tautan dan berkas hingga 2 MB, serta Dashboard Partisipasi per tim. Sebagian atau belum: Rekap Keterlibatan Dosen (kueri selesai, tampilan belum), Ekspor untuk Penilaian (rencana Minggu 14), dan Pengingat Otomatis (rencana laporan akhir).

Target TI Semester 3 terpenuhi seluruhnya: alur utama aplikasi web berjalan dengan dua bug tercatat, aplikasi tersambung ke basis data, dua peran atau lebih bisa login, dashboard sudah direncanakan dan sebagian berjalan, Bab 1–3 tertulis, dan Bab 4 memuat 12 kasus uji.

#sec("S.5", "Bukti")
#tbl((1.1fr, 2fr, 2.1fr),
  ([Aspek], [Pilihan tim], [Tautan atau keterangan]),
  (
    ([Bentuk demo], [Langsung di kelas], [Jadwal kelas TI-2C, Minggu 12]),
    ([Cara _deploy_], [Hosting gratis], [`sikap-pbl.example.com`]),
    ([Repositori], [Git dengan _tag_ `milestone-2`], [`github.com/contoh/sikap-pbl`]),
    ([Masukan pengguna], [Mitra dan calon pengguna (3 orang)], [Bab 4.5]),
    ([Bukti pengujian], [Uji manual dan uji kueri], [Bab 4 dan Lampiran G]),
  ), sz: 8.2pt)

#sec("S.6", "Rencana Minggu 13–16")
#tbl((0.7fr, 3.2fr, 1.2fr),
  ([Minggu], [Target], [Penanggung jawab]),
  (
    ([13], [Perbaiki BUG-03 dan BUG-05. Selesaikan tampilan Rekap Keterlibatan Dosen], [Raka, Farrel]),
    ([14], [Ekspor untuk Penilaian, pengujian lanjutan, dan indeks tambahan], [Salsabila, Nadia]),
    ([15], [Pengingat Otomatis, penyempurnaan Bab 1–5, dan materi demo], [Seluruh tim]),
    ([16], [Demo Day dan Expo], [Seluruh tim]),
  ), sz: 8.2pt)

#pagebreak()

#toc-page()

// =====================================================================
// BAB 1
// =====================================================================
#chapter("Bab 1", "Pendahuluan")
#lead[Bab ini menjelaskan masalah yang ingin dipecahkan SIKAP-PBL, batas pekerjaan kami, dan ukuran keberhasilannya. Pada Minggu 12, tiga dari enam ukuran itu sudah tercapai.]

#sec("1.1", "Latar Belakang dan Rumusan Masalah", stage: st-proposal)
Pembagian kerja pada proyek PBL sering terlihat merata di atas kertas, padahal riwayat aktivitasnya tidak selalu mendukung. Grup diskusi tim ramai di Minggu 1–3, sepi di Minggu 5, lalu ramai lagi sehari sebelum checkpoint. Dosen pengampu yang menilai banyak tim sekaligus tidak punya data yang bisa diperiksa dengan cepat, sehingga nilai kontribusi individu sering berakhir disamaratakan.

Bukti masalah ini kami kumpulkan dari tiga ketua tim lain pada Minggu 2 dan 3. Ketiganya mengaku menghabiskan sekitar 30 menit tiap minggu untuk menelusuri grup dan merangkum siapa mengerjakan apa, dan tidak ada yang yakin hasil rangkumannya akurat. Dua dari tiga dosen yang kami tanya menyebut penilaian kontribusi individu paling sulit saat checkpoint, karena yang tersedia hanya cerita lisan dari ketua tim. Dari situ rumusan masalah kami: bagaimana menyediakan data partisipasi individu yang objektif dan bisa diverifikasi, tanpa bergantung pada laporan lisan ketua tim?

#sec("1.2", "Tujuan", stage: st-proposal)
Kami ingin menghasilkan aplikasi web SIKAP-PBL yang berjalan penuh pada akhir Minggu 16, dengan dashboard partisipasi yang tidak lagi bergantung pada laporan lisan ketua tim.

#sec("1.3", "Cakupan Fitur dan Batasan", stage: st-proposal)
Ruang lingkup kami tuangkan dalam Pernyataan Ruang Lingkup (_scope statement_) di Project Charter SIKAP-PBL versi 1.1 (Lampiran E). Isinya dua daftar: yang kami bangun dan yang sengaja tidak kami bangun. Daftar kedua ternyata sama berguna dengan yang pertama, karena memberi alasan jelas untuk menolak permintaan yang tidak muat dalam empat bulan.

Yang kami bangun adalah Formulir Catat Aktivitas Mingguan, Dashboard Partisipasi per checkpoint, Ekspor untuk Penilaian, Rekap Keterlibatan Dosen, dan Pengingat Otomatis (laporan akhir). Di luar ruang lingkup: pelacakan otomatis dari WhatsApp atau Discord, deteksi kebohongan atas laporan kontribusi, dan integrasi ke sistem akademik kampus.

Asumsi kami, seluruh anggota bersedia mencatat aktivitas dengan jujur. Sistem tidak punya cara independen untuk membuktikan bahwa sebuah bukti benar, sehingga keputusan atas kasus semacam itu tetap di tangan dosen pengampu. Cakupan berubah satu kali sejak proposal, dan perubahannya dicatat di Bab 5.3.

#sec("1.4", "Pemangku Kepentingan dan Manfaat", stage: st-proposal)
Ada lima pihak yang kami catat di Stakeholder Register versi 1.1 (Lampiran E). Anggota tim (empat orang) adalah pengguna sekaligus pengembang, dan mereka paling berkepentingan pada penilaian yang adil. Ketua tim memakai dashboard tiap Jumat untuk tahu siapa yang tertinggal tanpa menegur di grup. Dosen pengampu menilai dan menyetujui perubahan, jadi mereka kami libatkan lewat tinjauan dashboard di tiap checkpoint. Koordinator PBL memakai rekap lintas tim untuk evaluasi program dan meninjau dashboard pada Minggu 12, sedangkan tiga calon pengguna dari tim lain cukup mencoba formulir saat pengujian.

Keputusan tentang cakupan, jadwal, dan peran kami simpan di Project Charter dan Governance Log. Charter menetapkan tujuan, batas waktu, anggaran nol rupiah, serta wewenang ketua tim dan dosen pengampu, sedangkan Governance Log menyimpan setiap perubahan beserta persetujuannya (Bab 5.3). Manfaat yang kami harapkan paling mudah dilihat dari ketua tim: pekerjaan 30 menit per minggu yang tadinya manual menjadi satu halaman dashboard.

#sec("1.5", "Kriteria Keberhasilan", stage: st-proposal)
Aplikasi kami nyatakan berhasil jika empat entitas utama (`tim`, `anggota`, `checkpoint`, `kontribusi`) saling berelasi dengan data uji yang realistis, peran pengguna berfungsi sesuai hak aksesnya, dan dashboard diperbarui otomatis pada keempat checkpoint. Supaya tidak dinilai dengan perasaan, kami menerjemahkannya menjadi enam ukuran yang bisa dihitung.

Pada Minggu 12, tiga ukuran sudah tercapai. K1 mensyaratkan 13 tabel dan minimal 100 catatan kontribusi, dan kami punya 120 catatan. K2 menuntut empat peran tanpa kebocoran data antar anggota, dan TC-12 lulus. K4 menargetkan kueri dashboard di bawah 100 ms pada 10.120 baris, dan hasil kami 21,3 ms. K3 (dashboard diperbarui otomatis pada 4 dari 4 checkpoint) baru 3 dari 4 karena CP-4 menunggu data. Dua ukuran lain masih terbuka: K5 mensyaratkan minimal 90 persen kasus uji lulus pada laporan akhir dan kami baru di 83 persen (10 dari 12), sedangkan K6 menargetkan median waktu membalas turun minimal 20 persen lewat pengingat dan hasil awal kami baru 15 persen. Keduanya menjadi fokus Minggu 13–15, dan perbandingan akhir akan kami tulis di Bab 4.6 pada laporan akhir.

// =====================================================================
// BAB 2
// =====================================================================
#chapter("Bab 2", "Analisis Kebutuhan dan Perancangan")
#lead[Bab ini memuat kebutuhan pengguna, rancangan basis data, dan tampilan. Keputusan terpenting: skema dibekukan di Minggu 9, dan basis datanya diganti di tengah jalan (Bab 5.3).]

#sec("2.1", "Kebutuhan Pengguna dan Daftar Fitur", stage: st-proposal)
Kebutuhan kami kumpulkan dengan duduk di samping tiga pengguna nyata pada Minggu 2 dan 3, yaitu seorang ketua tim, seorang anggota, dan seorang dosen pengampu. Ketua tim butuh sekitar 30 menit untuk merangkum kontribusi mingguan dari grup dan sering lupa siapa mengerjakan apa. Anggota melapor lewat pesan singkat dan tidak tahu posisinya dibanding rekan. Dosen hanya mengandalkan cerita ketua tim saat checkpoint. Peta proses sebelum dan sesudah SIKAP-PBL ada di @gbr-proses: informasi partisipasi tidak lagi tersebar di grup dan ingatan ketua tim, tetapi tersimpan sebagai data yang bisa dibuka siapa saja yang berhak.

#gambar("gbr-proses", [Peta proses sebelum dan sesudah SIKAP-PBL], [
  #text(font: ui, size: 8pt, fill: muted)[Sebelum]
  #v(0.2em)
  #flow(([Anggota membahas tugas di grup], [Ketua tim mengingat siapa mengerjakan apa], [Ketua tim merangkum secara manual], [Dosen menilai dari cerita lisan]))
  #v(0.6em)
  #text(font: ui, size: 8pt, fill: muted)[Sesudah]
  #v(0.2em)
  #flow(([Anggota mencatat aktivitas dan bukti], [Sistem menyimpan dan merekap otomatis], [Ketua tim memantau dashboard], [Dosen membuka dashboard saat checkpoint]))
])

Dari pengamatan itu kami menetapkan empat peran: anggota tim yang mencatat aktivitas dan bukti, ketua tim yang memantau siapa belum mencatat, dosen pengampu yang melihat dashboard dan mengekspor rekap, serta koordinator PBL yang mengelola checkpoint dan kategori kontribusi. Kebutuhannya kami tuangkan dalam SRS SIKAP-PBL versi 1.2 (Lampiran E) dan kami ringkas di @tbl-srs. Hampir semua kebutuhan berprioritas Tinggi sudah selesai. Yang tersisa adalah unggah berkas besar dan fitur yang memang dijadwalkan pada Minggu 13–15.

#tabel("tbl-srs", [Kebutuhan fungsional (FR) dan non-fungsional (NFR) pada SRS versi 1.2], tbl((0.6fr, 3fr, 0.8fr, 0.8fr),
  ([ID], [Kebutuhan], [Prioritas], [Status]),
  (
    ([FR-01], [Login dan pembedaan hak akses menurut peran], [Tinggi], [Selesai]),
    ([FR-02], [Anggota mencatat, mengubah, dan menghapus catatan aktivitas miliknya], [Tinggi], [Selesai]),
    ([FR-03], [Unggah bukti berupa tautan atau berkas], [Tinggi], [Sebagian]),
    ([FR-04], [Dashboard Partisipasi per tim dan per checkpoint], [Tinggi], [Selesai]),
    ([FR-05], [Validasi isian dan pesan kesalahan yang ramah], [Sedang], [Selesai]),
    ([FR-06], [Rekap Keterlibatan Dosen], [Sedang], [Sebagian]),
    ([FR-07], [Ekspor rekap untuk penilaian dalam format CSV], [Sedang], [Belum]),
    ([FR-08], [Pengingat Otomatis bagi anggota yang belum mencatat], [Rendah], [Belum]),
    ([FR-09], [Koordinator mengelola checkpoint dan kategori kontribusi], [Sedang], [Selesai]),
    ([NFR-01], [Tampilan responsif di ponsel dan laptop], [Tinggi], [Selesai]),
    ([NFR-02], [Sandi di-_hash_ dan semua kueri memakai _prepared statement_], [Tinggi], [Selesai]),
    ([NFR-03], [Dashboard terbuka dalam kurang dari 1 detik pada 10.000 baris], [Sedang], [Selesai]),
    ([NFR-04], [Pesan kesalahan tidak menampilkan detail basis data], [Sedang], [Selesai]),
    ([NFR-05], [Aplikasi tersedia sepanjang Demo Day], [Rendah], [Sebagian]),
  ), sz: 7.8pt))

#sec("2.2", "Susunan Komponen Sistem", stage: st-proposal)
Sistem berjalan sebagai aplikasi web tiga lapis seperti pada @gbr-arsitektur: peramban mengirim permintaan HTTP ke aplikasi PHP, yang menjalankan logika bisnis dan pemeriksaan peran lalu mengakses PostgreSQL lewat PDO. Kami memilih PHP native tanpa framework karena Desain dan Pemrograman Web menilai pemahaman dasar MVC, dan PostgreSQL karena itulah yang dipakai di Basis Data Lanjut.

#gambar("gbr-arsitektur", [Susunan tiga lapis SIKAP-PBL], flow(([Peramban: anggota, ketua tim, dosen], [Aplikasi web: PHP native dengan pola MVC, logika bisnis dan peran akses], [Basis data: PostgreSQL 16 dengan 13 tabel, view, dan trigger])))

Tiap lapis punya satu tanggung jawab: peramban menampilkan dan mengirim isian, aplikasi menentukan siapa boleh melihat apa, dan basis data menjaga kebenaran data lewat kunci dan batasan. Karena itu kueri bisa diuji langsung di PostgreSQL tanpa menjalankan aplikasi (Lampiran G).

#sec("2.3", "Rancangan Basis Data", stage: st-proposal)
Rancangan basis data tumbuh dari empat entitas di proposal (`tim`, `anggota`, `checkpoint`, `kontribusi`) menjadi 13 tabel pada PDM (_physical data model_) di @gbr-pdm. Skemanya melebar karena kami memisahkan akun dan peran pengguna, kelas, dosen beserta mata kuliah yang diampu, kategori kontribusi, bukti, dan respons dosen, yang tadinya menempel pada satu tabel. PDM memuat semua kolom, tipe data, dan tanda kunci (PK, FK, UQ).

Hubungan terpenting ada di antara `anggota`, `kontribusi`, dan `checkpoint`: satu anggota punya banyak kontribusi, satu checkpoint menerima banyak kontribusi, dan satu kontribusi bisa punya beberapa bukti. Relasi banyak-ke-banyak antara dosen, mata kuliah, dan kelas diselesaikan tabel penghubung `pengampu`, yang sekaligus menandai dosen rujukan tiap kelas. PDM dan kamus data versi 1.2 ditautkan di Lampiran E.

#pdm-page("gbr-pdm", [PDM SIKAP-PBL (PostgreSQL 16, 13 tabel)],
  (
    (name: "tim", col: 1, row: 0, cols: (("id", "serial", "PK"), ("kelas_id", "int", "FK"), ("nama_tim", "varchar(60)", "UQ"), ("judul_proyek", "varchar(120)", ""))),
    (name: "kelas", col: 2, row: 0, cols: (("id", "serial", "PK"), ("kode", "varchar(10)", "UQ"), ("semester", "smallint", ""), ("tahun_akademik", "varchar(9)", ""))),
    (name: "pengampu", col: 3, row: 0, cols: (("dosen_id", "int", "PK,FK"), ("mata_kuliah_id", "int", "PK,FK"), ("kelas_id", "int", "PK,FK"), ("dosen_rujukan", "boolean", ""))),
    (name: "mata_kuliah", col: 4, row: 0, cols: (("id", "serial", "PK"), ("kode", "varchar(10)", "UQ"), ("nama", "varchar(60)", ""), ("sks", "smallint", ""))),
    (name: "anggota", col: 1, row: 1, cols: (("id", "serial", "PK"), ("tim_id", "int", "FK"), ("pengguna_id", "int", "FK,UQ"), ("peran_tim", "varchar(30)", ""))),
    (name: "pengguna", col: 2, row: 1, cols: (("id", "serial", "PK"), ("nim_nip", "varchar(18)", "UQ"), ("nama", "varchar(80)", ""), ("email", "varchar(100)", "UQ"), ("kata_sandi", "varchar(255)", ""), ("peran_id", "int", "FK"), ("aktif", "boolean", ""))),
    (name: "dosen", col: 3, row: 1, cols: (("id", "serial", "PK"), ("pengguna_id", "int", "FK,UQ"), ("nidn", "varchar(10)", "UQ"))),
    (name: "bukti", col: 0, row: 2, cols: (("id", "serial", "PK"), ("kontribusi_id", "int", "FK"), ("jenis", "varchar(10)", ""), ("tautan", "varchar(255)", ""), ("nama_berkas", "varchar(120)", ""), ("ukuran_kb", "int", ""), ("diunggah_pada", "timestamptz", ""))),
    (name: "kontribusi", col: 1, row: 2, cols: (("id", "serial", "PK"), ("anggota_id", "int", "FK"), ("checkpoint_id", "int", "FK"), ("kategori_id", "int", "FK"), ("minggu", "smallint", ""), ("deskripsi_tugas", "text", ""), ("waktu_jam", "smallint", ""), ("status_verifikasi", "varchar(20)", ""), ("dibuat_pada", "timestamptz", ""))),
    (name: "checkpoint", col: 2, row: 2, cols: (("id", "serial", "PK"), ("nama", "varchar(20)", ""), ("minggu", "smallint", "UQ"), ("tanggal", "date", ""))),
    (name: "respons_dosen", col: 3, row: 2, cols: (("id", "serial", "PK"), ("checkpoint_id", "int", "FK"), ("dosen_id", "int", "FK"), ("status", "varchar(20)", ""), ("catatan", "text", ""), ("waktu_direspons", "timestamptz", ""))),
    (name: "kategori_kontribusi", col: 1, row: 3, cols: (("id", "serial", "PK"), ("nama", "varchar(40)", "UQ"), ("bobot", "numeric(3,1)", ""))),
    (name: "peran", col: 3, row: 3, cols: (("id", "serial", "PK"), ("nama", "varchar(20)", "UQ"))),
  ),
  (
    (parent: "kelas", child: "tim", fk: "kelas_id", a: "1", b: "N"),
    (parent: "kelas", child: "pengampu", fk: "kelas_id", a: "1", b: "N"),
    (parent: "mata_kuliah", child: "pengampu", fk: "mata_kuliah_id", a: "1", b: "N"),
    (parent: "dosen", child: "pengampu", fk: "dosen_id", a: "1", b: "N"),
    (parent: "peran", child: "pengguna", fk: "peran_id", a: "1", b: "N"),
    (parent: "pengguna", child: "dosen", fk: "pengguna_id", a: "1", b: "1"),
    (parent: "pengguna", child: "anggota", fk: "pengguna_id", a: "1", b: "1"),
    (parent: "tim", child: "anggota", fk: "tim_id", a: "1", b: "N"),
    (parent: "anggota", child: "kontribusi", fk: "anggota_id", a: "1", b: "N"),
    (parent: "checkpoint", child: "kontribusi", fk: "checkpoint_id", a: "1", b: "N"),
    (parent: "kategori_kontribusi", child: "kontribusi", fk: "kategori_id", a: "1", b: "N"),
    (parent: "kontribusi", child: "bukti", fk: "kontribusi_id", a: "1", b: "N"),
    (parent: "checkpoint", child: "respons_dosen", fk: "checkpoint_id", a: "1", b: "N"),
    (parent: "dosen", child: "respons_dosen", fk: "dosen_id", a: "1", b: "N"),
  ), cols: 5)

@tbl-kamus menjelaskan setiap tabel dan kolom pada @gbr-pdm. Tipe dan batasannya sama persis dengan DDL di Lampiran G.1. Nilai yang diizinkan pada kolom berdaftar nilai adalah anggota, ketua_tim, dosen, dan koordinator untuk `peran`, belum, terverifikasi, atau ditolak untuk `status_verifikasi`, serta belum, dibaca, atau ditindaklanjuti untuk status `respons_dosen`.

#tabel("tbl-kamus", [Kamus data: seluruh tabel dan kolom pada PDM], tbl((1.1fr, 1.3fr, 1fr, 2.6fr),
  ([Tabel], [Kolom], [Tipe], [Batasan]),
  (
    ([`peran`], [`id`], [SERIAL], [PK]),
    ([`peran`], [`nama`], [VARCHAR(20)], [NOT NULL, UNIQUE]),
    ([`pengguna`], [`id`], [SERIAL], [PK]),
    ([`pengguna`], [`nim_nip`], [VARCHAR(18)], [NOT NULL, UNIQUE]),
    ([`pengguna`], [`nama`], [VARCHAR(80)], [NOT NULL]),
    ([`pengguna`], [`email`], [VARCHAR(100)], [NOT NULL, UNIQUE]),
    ([`pengguna`], [`kata_sandi`], [VARCHAR(255)], [NOT NULL]),
    ([`pengguna`], [`peran_id`], [INT], [FK ke `peran`, NOT NULL]),
    ([`pengguna`], [`aktif`], [BOOLEAN], [NOT NULL, default TRUE]),
    ([`kelas`], [`id`], [SERIAL], [PK]),
    ([`kelas`], [`kode`], [VARCHAR(10)], [NOT NULL, UNIQUE]),
    ([`kelas`], [`semester`], [SMALLINT], [NOT NULL, CHECK 1 sampai 8]),
    ([`kelas`], [`tahun_akademik`], [VARCHAR(9)], [NOT NULL]),
    ([`tim`], [`id`], [SERIAL], [PK]),
    ([`tim`], [`kelas_id`], [INT], [FK ke `kelas`, NOT NULL]),
    ([`tim`], [`nama_tim`], [VARCHAR(60)], [NOT NULL, UNIQUE]),
    ([`tim`], [`judul_proyek`], [VARCHAR(120)], [NOT NULL]),
    ([`anggota`], [`id`], [SERIAL], [PK]),
    ([`anggota`], [`tim_id`], [INT], [FK ke `tim`, NOT NULL]),
    ([`anggota`], [`pengguna_id`], [INT], [FK ke `pengguna`, NOT NULL, UNIQUE]),
    ([`anggota`], [`peran_tim`], [VARCHAR(30)], [NOT NULL]),
    ([`mata_kuliah`], [`id`], [SERIAL], [PK]),
    ([`mata_kuliah`], [`kode`], [VARCHAR(10)], [NOT NULL, UNIQUE]),
    ([`mata_kuliah`], [`nama`], [VARCHAR(60)], [NOT NULL]),
    ([`mata_kuliah`], [`sks`], [SMALLINT], [NOT NULL, CHECK 1 sampai 6]),
    ([`dosen`], [`id`], [SERIAL], [PK]),
    ([`dosen`], [`pengguna_id`], [INT], [FK ke `pengguna`, NOT NULL, UNIQUE]),
    ([`dosen`], [`nidn`], [VARCHAR(10)], [NOT NULL, UNIQUE]),
    ([`pengampu`], [`dosen_id`], [INT], [PK gabungan, FK ke `dosen`]),
    ([`pengampu`], [`mata_kuliah_id`], [INT], [PK gabungan, FK ke `mata_kuliah`]),
    ([`pengampu`], [`kelas_id`], [INT], [PK gabungan, FK ke `kelas`]),
    ([`pengampu`], [`dosen_rujukan`], [BOOLEAN], [NOT NULL, default FALSE]),
    ([`checkpoint`], [`id`], [SERIAL], [PK]),
    ([`checkpoint`], [`nama`], [VARCHAR(20)], [NOT NULL]),
    ([`checkpoint`], [`minggu`], [SMALLINT], [NOT NULL, UNIQUE, CHECK 1 sampai 16]),
    ([`checkpoint`], [`tanggal`], [DATE], [NOT NULL]),
    ([`kategori_kontribusi`], [`id`], [SERIAL], [PK]),
    ([`kategori_kontribusi`], [`nama`], [VARCHAR(40)], [NOT NULL, UNIQUE]),
    ([`kategori_kontribusi`], [`bobot`], [NUMERIC(3,1)], [NOT NULL, CHECK lebih dari 0]),
    ([`kontribusi`], [`id`], [SERIAL], [PK]),
    ([`kontribusi`], [`anggota_id`], [INT], [FK ke `anggota`, NOT NULL]),
    ([`kontribusi`], [`checkpoint_id`], [INT], [FK ke `checkpoint`, NOT NULL]),
    ([`kontribusi`], [`kategori_id`], [INT], [FK ke `kategori_kontribusi`, NOT NULL]),
    ([`kontribusi`], [`minggu`], [SMALLINT], [NOT NULL, CHECK 1 sampai 16]),
    ([`kontribusi`], [`deskripsi_tugas`], [TEXT], [NOT NULL]),
    ([`kontribusi`], [`waktu_jam`], [SMALLINT], [NOT NULL, CHECK 1 sampai 40]),
    ([`kontribusi`], [`status_verifikasi`], [VARCHAR(20)], [NOT NULL, default 'belum', CHECK daftar nilai]),
    ([`kontribusi`], [`dibuat_pada`], [TIMESTAMPTZ], [NOT NULL, default `now()`]),
    ([`bukti`], [`id`], [SERIAL], [PK]),
    ([`bukti`], [`kontribusi_id`], [INT], [FK ke `kontribusi`, NOT NULL]),
    ([`bukti`], [`jenis`], [VARCHAR(10)], [NOT NULL, CHECK tautan atau berkas]),
    ([`bukti`], [`tautan`], [VARCHAR(255)], [Wajib bila jenis tautan]),
    ([`bukti`], [`nama_berkas`], [VARCHAR(120)], [Wajib bila jenis berkas]),
    ([`bukti`], [`ukuran_kb`], [INT], [CHECK lebih dari 0]),
    ([`bukti`], [`diunggah_pada`], [TIMESTAMPTZ], [NOT NULL, default `now()`]),
    ([`respons_dosen`], [`id`], [SERIAL], [PK]),
    ([`respons_dosen`], [`checkpoint_id`], [INT], [FK ke `checkpoint`, NOT NULL]),
    ([`respons_dosen`], [`dosen_id`], [INT], [FK ke `dosen`, NOT NULL]),
    ([`respons_dosen`], [`status`], [VARCHAR(20)], [NOT NULL, default 'belum', CHECK daftar nilai]),
    ([`respons_dosen`], [`catatan`], [TEXT], [boleh kosong]),
    ([`respons_dosen`], [`waktu_direspons`], [TIMESTAMPTZ], [diisi trigger]),
  ), sz: 7.2pt))

Setiap tabel punya kunci utama dan setiap hubungan pada PDM dijaga kunci asing. Batasan `UNIQUE` ada pada `nim_nip`, `email`, `nama_tim`, dan pasangan `(checkpoint_id, dosen_id)`, sedangkan `CHECK` menjaga `waktu_jam` (1 sampai 40), `minggu` (1 sampai 16), dan daftar nilai `status_verifikasi`. Batasan `ck_bukti_isi` memastikan bukti berjenis tautan selalu punya URL dan bukti berjenis berkas selalu punya nama berkas. Bila catatan dihapus, buktinya ikut terhapus (`ON DELETE CASCADE`), tetapi tim atau anggota yang masih punya catatan tidak bisa dihapus.

Soal normalisasi, bentuk awal kami memuat nama anggota, nama tim, nama kategori, dan tautan bukti dalam satu baris `kontribusi`. Bukti kami pisah ke tabel `bukti` (1NF), `dosen_rujukan` kami taruh di `pengampu` karena hanya bermakna untuk kombinasi dosen, mata kuliah, dan kelas (2NF), lalu nama peran, data kelas, serta nama dan bobot kategori pindah ke tabelnya sendiri (3NF), sehingga tidak ada data yang tersimpan dua kali.

#sec("2.5", "Rancangan Antarmuka", stage: st-proposal)
Rancangan antarmuka kami buat di Figma (versi 1.0, Lampiran E): 4 halaman (token desain, wireframe, layar akhir, komponen) dengan 18 frame, yang utamanya ada di @tbl-figma. Tokennya sederhana: hijau tua `#0F5F4C` untuk tombol dan bilah atas, oranye `#C65A2E` untuk penanda anggota yang belum mencatat, huruf Inter (isi 14 px, judul 20 px), jarak kelipatan 8 px, dan sudut 6 px. Semuanya langsung menjadi variabel CSS, jadi desain dan hasil jadi tidak saling menyimpang.

#block(breakable: false)[#tabel("tbl-figma", [Frame utama pada berkas Figma], tbl((0.5fr, 1.6fr, 1.2fr, 2.2fr),
  ([No], [Frame], [Peran], [Isi singkat]),
  (
    ([1], [Halaman login], [Semua peran], [Isian email dan sandi, pesan kesalahan]),
    ([2], [Formulir Catat Aktivitas], [Anggota], [Pilih checkpoint dan kategori, uraian, jam, bukti]),
    ([3], [Riwayat Catatan Saya], [Anggota], [Daftar catatan dengan tombol ubah dan hapus]),
    ([4], [Dashboard Tim], [Ketua tim], [Kartu posisi, tabel anggota, grafik batang]),
    ([5], [Rekap Dosen], [Dosen, koordinator], [Tabel tim per checkpoint dan status respons]),
    ([6], [Kelola Checkpoint], [Koordinator], [Tambah dan ubah checkpoint dan kategori]),
  ), sz: 8.2pt))]

Alur pengguna utama (@gbr-alur) sengaja pendek karena seorang anggota harus bisa mencatat satu aktivitas dalam kurang dari dua menit. Tiga tampilan yang paling sering dipakai kami buat sebagai wireframe berfidelitas rendah di @gbr-wire.

#gambar("gbr-alur", [Alur pengguna utama], flow(([Masuk dengan email dan sandi], [Beranda sesuai peran], [Buka Formulir Catat Aktivitas], [Isi dan tambah bukti], [Kirim dan lihat konfirmasi], [Dashboard Tim diperbarui])))

#gambar("gbr-wire", [Wireframe Formulir Catat Aktivitas, Dashboard Tim, dan Rekap Dosen], block(breakable: false, grid(columns: (1fr, 1fr, 1.3fr), column-gutter: 6pt, align: center,
  wire("Formulir Catat Aktivitas", (("input", "Checkpoint", 0.9), ("input", "Kategori", 0.9), ("input", "Uraian pekerjaan", 1.6), ("input", "Jam kerja", 0.9), ("input", "Tautan atau berkas bukti", 0.9), ("btn", "Kirim catatan", 0.9)), w: 4.1cm, h: 6.2cm),
  wire("Dashboard Tim", (("card", "Posisi saya: peringkat 2 dari 4", 1.2), ("chart", "Grafik jam per anggota", 2.6), ("list", "Anggota dan jam", 2.4), ("bar", "Belum mencatat minggu ini", 0.8)), w: 4.1cm, h: 6.2cm),
  wire("Rekap Dosen", (("bar", "Filter kelas dan checkpoint", 0.7), ("list", "Tim, jam, dan jumlah catatan", 2.6), ("list", "Status respons dosen", 2.0), ("btn", "Ekspor CSV", 0.7)), w: 5.3cm, h: 6.2cm, kind: "web"),
)))

Setelah mencoba layar sebenarnya, tombol "Kirim catatan" kami pindah ke bawah formulir supaya selalu terlihat di ponsel, dan kami menambah keterangan di bawah isian Checkpoint karena satu calon pengguna bingung dengan istilah itu (Bab 4.5). Tangkapan layar hasil akhirnya ada di Lampiran A.

#sec("2.6", "Rancangan Dashboard", stage: st-proposal)
Dashboard Partisipasi merangkum ratusan catatan menjadi lima indikator: jam kerja per anggota dan checkpoint (Q1) dan anggota yang belum mencatat (Q2) untuk ketua tim, jam kerja per tim (Q3) untuk dosen, kartu "posisi saya" (Q6), dan tren mingguan (Q7). Semua angka datang dari kueri yang sama dengan grafiknya, sehingga tabel dan grafik tidak mungkin berbeda.

Manfaatnya kami hitung dari pengamatan di Bab 2.1: ketua tim yang tadinya butuh sekitar 30 menit per minggu (sekitar 6 jam selama 12 minggu) kini cukup membuka satu halaman. Dosen juga mendapat data yang bisa dicek ke bukti, dan anggota melihat posisinya sebelum checkpoint, bukan sesudahnya.

// =====================================================================
// BAB 3
// =====================================================================
#chapter("Bab 3", "Implementasi")
#lead[Bab ini hanya memuat yang sudah benar-benar berjalan sampai Minggu 12. Fitur yang selesai setelahnya kami tambahkan di laporan akhir.]

#sec("3.1", "Teknologi yang Dipakai", stage: st-m2)
Pilihan teknologi di @tbl-teknologi mengikuti materi kuliah semester ini: PHP native tanpa framework di Desain dan Pemrograman Web, dan PostgreSQL di Basis Data Lanjut. Dengan tumpukan yang sederhana, kami bisa menjelaskan setiap baris kode saat demo, dan anggota yang bukan pengembang utama pun tetap bisa membantu menelusuri bug.

#tabel("tbl-teknologi", [Teknologi yang dipakai SIKAP-PBL], tbl((1.4fr, 0.7fr, 2.6fr),
  ([Komponen], [Versi], [Alasan]),
  (
    ([PHP native (tanpa framework)], [8.3], [Sesuai materi Desain dan Pemrograman Web]),
    ([PostgreSQL dan PDO `pgsql`], [16], [Sesuai Basis Data Lanjut. Mendukung _view_, _trigger_, dan `EXPLAIN ANALYZE`]),
    ([HTML, CSS responsif, dan JavaScript], [–], [Tampilan terbaca di ponsel dan laptop. JavaScript hanya untuk validasi awal dan grafik batang]),
    ([Figma], [–], [Wireframe dan token desain (Bab 2.5)]),
    ([Git dan GitHub], [–], [Riwayat kerja, dan bukti kontribusi untuk Bab 5.2]),
  ), sz: 8.2pt))

Kunci koneksi basis data kami simpan di berkas konfigurasi di luar repositori, supaya sandi tidak ikut terunggah ke GitHub. Versi PHP dan PostgreSQL sama di laptop dan hosting, jadi kueri yang lulus uji di laptop berperilaku sama di server.

#sec("3.2", "Cara Membuat Tiap Fitur", stage: st-m2)
Kami memakai pola MVC sederhana. Folder `models` berisi akses data lewat PDO, `views` berisi tampilan, dan `controllers` (`AuthController`, `CatatController`, `DashboardController`, `DosenController`) berisi logika yang menghubungkan keduanya, sementara `helpers` menyimpan pemeriksaan akses dan validasi. Semua permintaan masuk lewat `public/index.php`, yang memilih controller dari alamat URL, sehingga satu fitur biasanya hanya menyentuh satu controller, satu model, dan satu view. Skrip basis data ada di folder `sql`, dan berkas koneksi di folder `config` di luar repositori.

Login dan pembedaan peran kami bangun lebih dulu. Intinya ada di @kode-login: pengguna dicari berdasarkan email dengan _prepared statement_, sandi dicocokkan dengan `password_verify`, dan peran disimpan di sesi. Pesan gagalnya sengaja sama untuk email salah maupun sandi salah, supaya orang luar tidak bisa menebak email mana yang terdaftar.

#kode("kode-login", [Login dengan prepared statement dan password_verify],
```php
$stmt = $pdo->prepare('SELECT u.id, u.nama, u.kata_sandi, p.nama AS peran
                       FROM pengguna u JOIN peran p ON p.id = u.peran_id
                       WHERE u.email = :email AND u.aktif');
$stmt->execute([':email' => $email]);
$u = $stmt->fetch();
if (!$u || !password_verify($sandi, $u['kata_sandi'])) {
    $_SESSION['galat'] = 'Email atau sandi salah.';
    header('Location: /masuk'); exit;
}
session_regenerate_id(true);
$_SESSION['pengguna_id'] = $u['id'];
$_SESSION['peran'] = $u['peran'];
```
)

Pembatasan akses menurut peran kami pusatkan di satu fungsi, `wajib_peran()` di `helpers/akses.php`, yang dipanggil di awal setiap controller. Formulir Catat Aktivitas hanya terbuka untuk anggota dan ketua tim, Dashboard Tim untuk ketua tim dan dosen, dan Rekap Dosen untuk dosen dan koordinator. Pemeriksaan di server inilah yang membuat TC-12 lulus: mengubah ID anggota di alamat URL tetap ditolak, karena controller membandingkan ID itu dengan ID pada sesi.

Fitur yang sudah ada selain login adalah Formulir Catat Aktivitas, Riwayat Catatan Saya (CRUD penuh atas catatan sendiri), Dashboard Tim, dan Kelola Checkpoint untuk koordinator. Rekap Dosen baru berupa kueri. Controller Dashboard memanggil view `v_rekap_partisipasi` dan mengirim hasilnya ke tampilan, lalu grafik batang digambar dengan JavaScript dari hasil yang sama.

Server memeriksa setiap isian sebelum menyimpan. Jam kerja, misalnya, harus berupa angka 1 sampai 40, dan bila ada yang salah pengguna kembali ke formulir dengan pesan yang jelas, bukan pesan mentah dari basis data. Penyimpanan memakai _prepared statement_ sehingga isian pengguna tidak pernah disambung ke teks SQL, sandi disimpan dengan `password_hash`, dan kesalahan basis data hanya masuk berkas log.

#sec("3.3", "Basis Data", stage: st-m2)
Skema 13 tabel dari Bab 2.3 dibuat lewat `sql/skema.sql`, lalu diisi `sql/data_uji.sql` supaya kueri dan tampilan bisa diuji dengan data yang masuk akal. Tabel acuan berisi 4 peran, 5 kategori kontribusi, dan 4 checkpoint. Ada 2 kelas dengan 4 tim, 20 akun (16 mahasiswa, 3 dosen, dan 1 koordinator), 4 mata kuliah, 3 dosen, dan 8 baris `pengampu`. Untuk transaksi, kami membuat 120 catatan `kontribusi` yang disebar di Minggu 1 sampai 12, 96 `bukti` (tautan commit dan tiga berkas kecil), dan 9 `respons_dosen` dari tiga checkpoint yang sudah lewat. Catatan itu sengaja kami buat tidak rata, misalnya ada anggota yang aktif di awal lalu menurun, supaya dashboard punya sesuatu yang menarik untuk ditampilkan.

Aplikasi memakai basis data lewat tiga jalur: model memanggil kueri biasa untuk menyimpan dan membaca catatan (Q1, Q2, Q5), halaman rekap membaca _view_ `v_rekap_partisipasi`, dan _trigger_ `trg_respons_dosen` bekerja sendiri saat dosen mengubah status. Semua kueri, _view_, _trigger_, transaksi, dan hasil pengujiannya ada di Lampiran G.

#sec("3.5", "Penyambungan antar Bagian dan Deploy", stage: st-m2)
Aplikasi di-_deploy_ ke hosting gratis yang menyediakan PHP dan PostgreSQL, karena server kampus belum tersedia untuk tim kami (Bab 5.3). Kode diunggah dari tag Git `milestone-2`, berkas konfigurasi dibuat langsung di server, dan data uji dimuat sekali pada _deploy_ pertama.

Alur utama kami uji langsung di alamat hosting: masuk sebagai anggota, mencatat aktivitas, lalu membuka dashboard sebagai ketua tim. Hasilnya sama dengan di laptop, kecuali batas unggah berkas yang lebih kecil di hosting. Perbedaan itulah yang ternyata menjadi sumber BUG-03 (Bab 4.3).

// =====================================================================
// BAB 4
// =====================================================================
#chapter("Bab 4", "Pengujian dan Evaluasi")
#lead[Dari 12 kasus uji, 10 lulus dan 2 gagal. Kami juga menjalankan uji awal untuk klaim proposal yang paling berani, yaitu apakah pengingat benar-benar mempercepat respons anggota.]

#sec("4.1", "Rencana Pengujian", stage: st-m2)
Rencana pengujian kami susun di dokumen rencana uji versi 1.0 (Lampiran E) dengan fokus pada alur utama, yaitu mencatat aktivitas sampai angkanya tampil di dashboard. Antarmuka diuji manual dengan Chrome di laptop dan ponsel Android pada Minggu 11–12 (12 kasus uji, tiga di antaranya memakai akun berbeda peran), basis data lewat `psql` dan `EXPLAIN ANALYZE` untuk Q1 sampai Q3 dengan 10.120 baris, dan tiga calon pengguna serta satu mitra mencoba formulir di ponsel sendiri.

Nadia menjadi penguji utama dan tidak ikut menulis kode yang diujinya, sedangkan Raka memperbaiki bug. Uji ulang dijadwalkan pada Minggu 13–14.

#sec("4.2", "Kasus Uji dan Hasil", stage: st-m2)
Dari 12 kasus uji alur utama di @tbl-uji, sepuluh lulus dan dua gagal: TC-07 (BUG-03) dan TC-09 (BUG-05). Keduanya menyentuh unggahan bukti dan ketepatan rekap, dua hal yang menjadi alasan produk ini dibuat.

#block(breakable: false)[#tabel("tbl-uji", [Kasus uji dan hasilnya], tbl((0.55fr, 2.5fr, 1.5fr, 1.9fr, 0.85fr),
  ([ID], [Skenario dan langkah], [Hasil diharapkan], [Hasil aktual], [Status]),
  (
    ([TC-01], [Login anggota dengan email dan sandi], [Masuk ke beranda], [Beranda anggota terbuka], [Lulus]),
    ([TC-02], [Login ketua tim dengan email dan sandi], [Masuk ke dashboard], [Dashboard tim terbuka], [Lulus]),
    ([TC-03], [Login dengan sandi yang salah], [Pesan gagal tampil], [Pesan kesalahan tampil], [Lulus]),
    ([TC-04], [Isi formulir aktivitas, tekan Kirim], [Catatan tersimpan], [Tersimpan, terlihat di riwayat], [Lulus]),
    ([TC-05], [Kirim formulir tanpa deskripsi], [Pesan kesalahan tampil], [Pesan tampil di bawah isian], [Lulus]),
    ([TC-06], [Isi URL commit sebagai bukti], [Tautan tersimpan], [Tersimpan di tabel bukti], [Lulus]),
    ([TC-07], [Unggah berkas bukti 5 MB], [Berkas tersimpan], [Halaman error 500], [Gagal (BUG-03)]),
    ([TC-08], [Buka dashboard setelah mencatat], [Muncul di rekap], [Catatan muncul di rekap], [Lulus]),
    ([TC-09], [Kirim dua catatan untuk Minggu 12], [Rekap menghitung sekali], [Rekap menghitung dua kali], [Gagal (BUG-05)]),
    ([TC-10], [Buka dashboard tim], [Anggota yang belum mencatat tampil], [Daftar tampil lengkap], [Lulus]),
    ([TC-11], [Bandingkan total jam dengan hitungan manual], [Sama dengan hitungan manual], [Angka sama], [Lulus]),
    ([TC-12], [Ubah ID anggota di alamat URL], [Akses ditolak], [Akses ditolak dengan pesan], [Lulus]),
  ), sz: 7.4pt))]

Setiap kasus uji kami kaitkan ke SRS di @tbl-telusur. FR-07 dan FR-08 belum punya kasus uji karena belum dibangun, dan FR-06 baru diuji lewat kueri, sedangkan bagian yang paling lemah ada di unggahan bukti dan perhitungan rekap.

#block(breakable: false)[#tabel("tbl-telusur", [Keterlacakan kebutuhan ke kasus uji], tbl((0.9fr, 2.2fr, 1.4fr),
  ([Kebutuhan], [Kasus uji atau bukti], [Hasil]),
  (
    ([FR-01, NFR-02], [TC-01, TC-02, TC-03, TC-12], [Terpenuhi]),
    ([FR-02], [TC-04, TC-09], [Sebagian (BUG-05)]),
    ([FR-03], [TC-06, TC-07], [Sebagian (BUG-03)]),
    ([FR-04, FR-05], [TC-08, TC-10, TC-11, TC-05], [Terpenuhi]),
    ([FR-06], [Uji kueri Q4 (Lampiran G)], [Kueri terpenuhi, tampilan belum]),
    ([FR-09, NFR-01], [Pemeriksaan manual Nadia, TC-04 di laptop dan ponsel], [Terpenuhi]),
    ([NFR-03], [`EXPLAIN ANALYZE` Q3 (Lampiran G.4)], [Terpenuhi (21,3 ms)]),
    ([NFR-04], [TC-05, TC-07], [Sebagian (BUG-03 menampilkan error 500)]),
  ), sz: 7.2pt))]

#sec("4.3", "Bug yang Ditemukan", stage: st-m2)
Dua bug yang kami temukan tercatat di @tbl-bug, keduanya bertingkat Tinggi karena menyangkut data dasar penilaian. Catatan lengkapnya ada di dokumen kasus uji dan catatan bug (Lampiran E).

#block(breakable: false)[#tabel("tbl-bug", [Catatan bug], tbl((0.7fr, 2.7fr, 0.8fr, 0.8fr, 1.5fr),
  ([ID], [Deskripsi dan langkah reproduksi], [Tingkat], [Status], [Rencana perbaikan]),
  (
    ([BUG-03], [Unggah berkas di atas 2 MB gagal karena batas unggah server. Langkah: unggah berkas 5 MB di formulir], [Tinggi], [Terbuka], [Naikkan batas, tampilkan pesan yang jelas (Minggu 13)]),
    ([BUG-05], [Catatan ganda dalam satu minggu dihitung dua kali di rekap. Langkah: kirim dua catatan untuk minggu yang sama], [Tinggi], [Terbuka], [Tambah aturan unik per anggota per minggu (Minggu 13)]),
  ), sz: 8pt))]

Akar BUG-03 ternyata sepele: `upload_max_filesize` di hosting hanya 2 MB, sedangkan di laptop kami 8 MB. BUG-05 lebih mendasar karena skema belum melarang dua catatan untuk anggota dan minggu yang sama, sehingga perbaikannya berupa batasan `uq_kontribusi_minggu` (Lampiran G.1), bukan sekadar pemeriksaan di PHP.

#sec("4.5", "Masukan Pengguna", stage: st-m2)
Kami meminta masukan dari dua kelompok. Koordinator PBL meninjau dashboard pada Minggu 12 dan meminta ekspor rekap per checkpoint (masuk Ekspor untuk Penilaian, Minggu 14) serta penanda yang lebih jelas untuk anggota yang belum mencatat, yang sudah kami tambahkan dengan warna aksen. Tiga calon pengguna selesai mencatat dalam kurang dari dua menit, tetapi satu orang bingung dengan istilah Checkpoint, jadi kami menambahkan keterangan di bawah isiannya.

#kutipan[Dashboard-nya sudah menjawab kebutuhan lintas tim. Tinggal ekspor per checkpoint dan penanda yang lebih jelas.][Koordinator PBL, tinjauan dashboard Minggu 12]

Kami juga menguji klaim proposal bahwa pengingat mempercepat respons. Fitur otomatisnya belum ada, jadi pesan pengingat H-3 kami kirim manual kepada sembilan anggota dan dibandingkan dengan sembilan anggota tanpa pengingat. Median waktu membalas turun dari 26 jam menjadi 22 jam, selisih yang belum cukup untuk menyimpulkan apa pun, sehingga uji diulang pada Minggu 15.

#sec("4.6", "Ketercapaian Kriteria Keberhasilan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: bandingkan hasil akhir dengan kriteria di Bab 1.5.]

// =====================================================================
// BAB 5
// =====================================================================
#chapter("Bab 5", "Pengelolaan Proyek dan Penutup")
#lead[Bab ini mencatat siapa mengerjakan apa, apa yang berubah, dan apa yang bisa meleset. Kesimpulan dan pelajaran baru kami tulis di laporan akhir.]

#sec("5.1", "Rencana dan Realisasi", stage: st-lanjutan)
Rincian pekerjaan kami susun sebagai WBS tiga tingkat di dokumen WBS dan Gantt versi 1.3 (Lampiran E). @tbl-wbs memuat paket (1, 2, 3), sub-paket (1.1, 1.2, dan seterusnya), dan tugas (1.1.1 dan seterusnya) beserta penanggung jawab, rencana, dan realisasi sampai Minggu 12. Dari 13 tugas, sembilan selesai sesuai rencana dan satu tertinggal, yaitu tampilan Rekap Keterlibatan Dosen. Dokumen tambahan Manajemen Proyek dicatat di Lampiran D (@tbl-artefak).

#tabel("tbl-wbs", [WBS tiga tingkat, rencana, dan realisasi sampai Minggu 12], tbl((0.6fr, 2.4fr, 0.9fr, 1fr, 1.7fr),
  ([Kode], [Paket kerja], [Penanggung jawab], [Rencana], [Realisasi]),
  (
    ([1], [Fondasi: basis data dan formulir], [], [], []),
    ([1.1], [Basis data], [], [], []),
    ([1.1.1], [Rancang PDM dan kamus data], [Raka], [Minggu 5–6], [Selesai pada Minggu 6]),
    ([1.1.2], [Ganti basis data dan bekukan skema], [Raka], [Minggu 9], [Selesai pada Minggu 9]),
    ([1.2], [Formulir], [], [], []),
    ([1.2.1], [Wireframe Figma], [Salsabila], [Minggu 5–6], [Selesai pada Minggu 6]),
    ([1.2.2], [Formulir dan unggah bukti], [Salsabila], [Minggu 6–8], [Selesai pada Minggu 8]),
    ([2], [Dashboard dan rekap], [], [], []),
    ([2.1], [Dashboard tim], [], [], []),
    ([2.1.1], [Kueri rekap per checkpoint], [Farrel], [Minggu 9–10], [Selesai pada Minggu 10]),
    ([2.1.2], [Dashboard dan grafik], [Farrel], [Minggu 10–11], [Selesai pada Minggu 11]),
    ([2.2], [Rekap dosen], [], [], []),
    ([2.2.1], [Kueri Rekap Keterlibatan Dosen], [Farrel], [Minggu 11], [Selesai pada Minggu 11]),
    ([2.2.2], [Tampilan Rekap Keterlibatan Dosen], [Farrel], [Minggu 12], [Belum dimulai (0 persen)]),
    ([2.3], [Ekspor dan pengingat], [], [], []),
    ([2.3.1], [Ekspor untuk Penilaian], [Salsabila], [Minggu 13–14], [Belum dimulai]),
    ([2.3.2], [Pengingat Otomatis], [Raka], [Minggu 15], [Belum dimulai]),
    ([3], [Pengujian dan penutup], [], [], []),
    ([3.1], [Pengujian alur utama], [], [], []),
    ([3.1.1], [Rencana dan kasus uji], [Nadia], [Minggu 9–10], [Selesai pada Minggu 10]),
    ([3.1.2], [Pengujian alur utama], [Nadia], [Minggu 11–12], [Selesai, 12 kasus uji]),
    ([3.2], [Perbaikan dan penutup], [], [], []),
    ([3.2.1], [Perbaikan bug dan uji ulang], [Raka, Nadia], [Minggu 13–14], [Belum dimulai]),
  ), sz: 7.2pt))

#gambar("gbr-gantt", [Diagram Gantt rencana dan realisasi sampai Minggu 12], gantt((
  ("1.1.1", "Rancang PDM dan kamus data", (5, 6), (5, 6)),
  ("1.1.2", "Ganti basis data, bekukan skema", (9, 9), (9, 9)),
  ("1.2.1", "Wireframe Figma", (5, 6), (5, 6)),
  ("1.2.2", "Formulir dan unggah bukti", (6, 8), (6, 8)),
  ("2.1.1", "Kueri rekap per checkpoint", (9, 10), (9, 10)),
  ("2.1.2", "Dashboard dan grafik", (10, 11), (10, 11)),
  ("2.2.1", "Kueri rekap dosen", (11, 11), (11, 11)),
  ("2.2.2", "Tampilan rekap dosen", (12, 12), none),
  ("2.3.1", "Ekspor untuk Penilaian", (13, 14), none),
  ("2.3.2", "Pengingat Otomatis", (15, 15), none),
  ("3.1.1", "Rencana dan kasus uji", (9, 10), (9, 10)),
  ("3.1.2", "Pengujian alur utama", (11, 12), (11, 12)),
  ("3.2.1", "Perbaikan bug dan uji ulang", (13, 14), none),
), now: 12))

Jadwal yang sama kami gambar di @gbr-gantt, selaras dengan empat checkpoint (Minggu 4, 8, 12, dan 16). Rencana Minggu 13–16 ada di Lembar Status (S.6). Revisi skema pada Minggu 9 ternyata memakan waktu lebih lama dari perkiraan, sehingga Farrel baru bisa mulai mengerjakan kueri dashboard setelah skema dibekukan, dan itulah sebabnya tampilan Rekap Keterlibatan Dosen tertinggal.

#sec("5.2", "Kontribusi Anggota", stage: st-lanjutan)
@tbl-kontribusi memuat tugas yang selesai, bukti yang bisa dicek, perkiraan porsi, dan bagian yang dibawakan tiap anggota saat demo. Angkanya perkiraan tim sendiri, jadi tiap angka kami sertai bukti yang bisa diperiksa dosen, yaitu jumlah _commit_, berkas Figma, atau kasus uji.

#tabel("tbl-kontribusi", [Estimasi kontribusi anggota sampai Minggu 12], tbl((1.3fr, 2.2fr, 1.7fr, 0.8fr, 1.4fr),
  ([Nama], [Tugas selesai], [Bukti], [Estimasi], [Bagian saat demo]),
  (
    ([Raka Aditya Pratama], [Basis data, login, perbaikan bug], [31 _commit_, tugas WBS 1.1], [30%], [Alur utama dan kueri]),
    ([Salsabila Rahma Putri], [Formulir, antarmuka dashboard], [24 _commit_, berkas Figma], [25%], [Formulir dan tampilan]),
    ([Farrel Ibrahim Nugroho], [Kueri dashboard, logbook], [22 _commit_, Lampiran B], [25%], [Dashboard dan rekap]),
    ([Nadia Kirana Sari], [Kasus uji dan uji pengingat], [12 kasus uji di Bab 4.2], [20%], [Hasil pengujian]),
  ), sz: 8.2pt))

Porsi Nadia lebih kecil karena kerjanya baru padat sejak Minggu 9, ketika fitur sudah ada untuk diuji. Pekerjaan harian tercatat di logbook (Lampiran B). Selain tabel ini, setiap anggota mengisi form Penilaian 360 secara terpisah pada Minggu 11 sampai 12. Koordinator membandingkan rata-rata poin dari rekan dengan estimasi di atas, lalu mengirim rekapnya kepada dosen pengampu. Hasil penilaian itu bersifat rahasia dan tidak ditulis di laporan.

#sec("5.3", "Perubahan, Risiko, dan Permintaan Tambahan", stage: st-lanjutan)
Setiap perubahan dari proposal kami catat di Governance Log versi 1.3 (Lampiran E) dan harus disetujui dosen terkait sebelum dikerjakan, lalu diringkas di @tbl-perubahan. CR-03 berasal dari satu-satunya permintaan tambahan dosen setelah proposal: dosen Sistem Informasi Manajemen meminta ekspor rekap per checkpoint dalam format CSV. Kebutuhannya sama dengan FR-07, jadi kami memasukkannya ke Ekspor untuk Penilaian tanpa menambah fitur baru.

#tabel("tbl-perubahan", [Governance Log: perubahan dan persetujuannya], tbl((0.6fr, 1.7fr, 2fr, 1.3fr, 1.5fr),
  ([No], [Perubahan], [Alasan dan dampak], [Persetujuan], [Konsultasi]),
  (
    ([CR-01], [Basis data pindah dari MySQL ke PostgreSQL], [Dosen Basis Data Lanjut mengarahkan PostgreSQL agar `EXPLAIN ANALYZE` bisa dipakai. Migrasi memakan dua hari dan skema bertambah menjadi 13 tabel], [Dosen pengampu Basis Data Lanjut, Minggu 9], [Disetujui pada Minggu 9]),
    ([CR-02], [Pengingat Otomatis dipindah ke laporan akhir (Minggu 15)], [Dashboard lebih penting untuk Milestone 2. Tidak mengubah tanggal akhir], [Dosen rujukan, Minggu 9], [Disetujui dosen rujukan]),
    ([CR-03], [Fitur Ekspor untuk Penilaian dipastikan masuk Minggu 14], [Permintaan Sistem Informasi Manajemen pada Minggu 11. Menambah sekitar dua hari kerja], [Dosen rujukan, Minggu 11], [Disetujui dosen rujukan]),
  ), sz: 7.8pt))

Risiko Minggu 13–16 kami nilai dengan skala 1 sampai 5 untuk kemungkinan dan dampak, dan skornya hasil perkalian keduanya (15 ke atas Tinggi, 8 sampai 14 Sedang, di bawahnya Rendah). @tbl-risiko memuat empat risiko terbesar, dengan dua bug yang belum teratasi di urutan teratas karena keduanya menyentuh alur utama yang akan didemokan.

#tabel("tbl-risiko", [Daftar risiko Minggu 13–16], tbl((0.5fr, 2.2fr, 0.9fr, 0.7fr, 0.7fr, 0.8fr, 2.2fr),
  ([No], [Risiko], [Kemungkinan], [Dampak], [Skor], [Tingkat], [Tindakan]),
  (
    ([R1], [BUG-03 dan BUG-05 belum teratasi], [4], [4], [16], [Tinggi], [Perbaiki di Minggu 13, uji ulang oleh Nadia]),
    ([R2], [Anggota tidak konsisten mencatat aktivitas], [3], [4], [12], [Sedang], [Pengingat Otomatis, dan ketua tim meninjau tiap Jumat]),
    ([R3], [Rekap Keterlibatan Dosen tidak selesai], [3], [3], [9], [Sedang], [Kecilkan cakupan menjadi satu tabel tanpa grafik]),
    ([R4], [Server kampus belum tersedia], [3], [3], [9], [Sedang], [Tetap di hosting gratis. Ajukan kebutuhan server ke dosen rujukan]),
  ), sz: 7.8pt))

Cara kerja tim tertulis di Project Charter. Kami bertemu dua kali seminggu (rapat 30 menit hari Selasa untuk membagi tugas, tinjauan singkat hari Jumat), mencatat keputusan teknis sebagai _issue_ di GitHub, meninjau tiap perubahan kode sebelum digabung, dan membalas pesan grup paling lambat 24 jam. Bila pendapat berbeda, ketua tim memutuskan setelah mendengar semua pihak.

#sec("5.4", "Kesimpulan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apakah rumusan masalah di Bab 1.1 terjawab.]

#sec("5.5", "Pelajaran dan Saran", stage: st-akhir)
#pending[Ditulis pada laporan akhir: pelajaran tim dan saran pengembangan.]

// =====================================================================
// LAMPIRAN (tiap lampiran dimulai di halaman baru)
// =====================================================================
#pagebreak()
#part("Lampiran", "Lampiran A–H")
#text(font: ui, size: 8.4pt, fill: muted)[Lampiran F (model ML) hanya untuk tim TI Semester 5, sehingga tidak ada di contoh ini.]
#v(0.6em)

#lamp("A", "Tangkapan Layar", stage: st-m2)
Lampiran ini menampilkan dua layar utama yang sudah berjalan, yaitu Formulir Catat Aktivitas Mingguan (@gbr-ss-form) dan Dashboard Partisipasi tim (@gbr-ss-dash). Tim yang sesungguhnya mengganti kotak kosong ini dengan tangkapan layar dari aplikasinya.
#v(0.3em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  [#shot("gbr-ss-form", [Formulir Catat Aktivitas Mingguan], ht: 7cm)],
  [#shot("gbr-ss-dash", [Dashboard Partisipasi tim], ht: 7cm)],
)

#pagebreak()
#lamp("B", "Logbook", stage: st-lanjutan)
Logbook Minggu 1–8 dipindahkan dari Laporan Kemajuan, dan Minggu 9–12 ditambahkan pada Milestone 2 seperti di @tbl-logbook, dengan kolom "Dikerjakan oleh" supaya terlihat siapa mengerjakan apa.
#v(0.3em)
#tabel("tbl-logbook", [Logbook Minggu 9–12], tbl((0.6fr, 2.2fr, 1.2fr, 1.6fr, 1.6fr),
  ([Minggu], [Pekerjaan selesai], [Dikerjakan oleh], [Kendala], [Rencana berikutnya]),
  (
    ([9], [Skema dibekukan dan basis data diganti ke PostgreSQL], [Raka], [Revisi skema memakan waktu], [Dashboard tim]),
    ([9], [Rencana uji disusun], [Nadia], [Tidak ada], [Kasus uji]),
    ([10], [Kueri Q1 dan Q3 selesai], [Farrel], [Kueri lambat], [Uji dengan EXPLAIN]),
    ([11], [Dashboard tim berjalan, indeks pertama dibuat], [Farrel, Salsabila], [Grafik tidak sinkron dengan tabel], [Rekap dosen]),
    ([12], [12 kasus uji dijalankan, uji pengingat manual], [Nadia], [Dua bug ditemukan], [Perbaikan bug]),
  ), sz: 8.2pt))

#pagebreak()
#lamp("C", "Dokumen Rujukan", stage: st-m2)
Dokumen kerja yang kami buat untuk keempat mata kuliah dan dirujuk laporan ini terdaftar di @tbl-dokumen-rujukan, lengkap dengan versi, pemilik, dan bagian laporan yang merujuknya. Isinya diringkas di bab yang bersangkutan dan tidak ditulis ulang di sini. Tautannya ada di Lampiran E.
#v(0.3em)
#tabel("tbl-dokumen-rujukan", [Dokumen rujukan tim], tbl((0.4fr, 2.1fr, 0.6fr, 1.1fr, 1.4fr, 2.3fr),
  ([No], [Dokumen], [Versi], [Pemilik], [Bagian yang merujuk], [Keterangan]),
  (
    ([1], [SRS (spesifikasi kebutuhan perangkat lunak)], [1.2], [Salsabila], [Bab 2.1, Bab 4.2], [Kebutuhan fungsional FR dan non-fungsional NFR]),
    ([2], [Desain Figma (_wireframe_ dan token desain)], [1.0], [Salsabila], [Bab 2.5], [4 halaman, 18 frame, dan alur pengguna]),
    ([3], [Project Charter dan Pernyataan Ruang Lingkup], [1.1], [Raka], [Bab 1.3, Bab 5.3], [Tujuan, ruang lingkup, dan aturan dasar tim]),
    ([4], [Governance Log], [1.3], [Farrel], [Bab 5.3], [Perubahan beserta persetujuannya]),
    ([5], [Stakeholder Register], [1.1], [Farrel], [Bab 1.4], [Kepentingan, pengaruh, dan cara melibatkan]),
    ([6], [WBS dan Gantt], [1.3], [Raka], [Bab 5.1], [Rincian pekerjaan tiga tingkat dan jadwal]),
    ([7], [PDM dan kamus data], [1.2], [Raka], [Bab 2.3, Lampiran G], [13 tabel, kolom, tipe, dan batasan]),
    ([8], [Rencana uji, kasus uji, dan catatan bug], [1.0], [Nadia], [Bab 4], [12 kasus uji dan 2 bug sampai Minggu 12]),
  ), sz: 7.8pt))

#pagebreak()
#lamp("D", "Dokumen Tambahan dari Dosen", stage: st-m2)
Dosen Manajemen Proyek, Dian Hanifudin Subhi, M.Kom., mengumumkan tiga dokumen tambahan secara tertulis pada 20 Oktober 2026. Dokumen itu dikerjakan pada Minggu 9 sampai 11 dan lebih ringan daripada dokumen Manajemen Proyek di Milestone 1, karena status proyek sudah tercakup di Bab 2 dan Bab 5.

#sec("", "D.1 Manajemen Proyek: Resource Plan, Jadwal Proyek, dan Budget Plan")
Ketiga dokumen kami ekspor ke PDF dan kami tambahkan ke lembar penilaian mandiri yang sudah dipakai sejak UTS, jadi isinya tidak kami salin ke laporan ini. @tbl-artefak mencatat tiap dokumen, siapa yang mengerjakan, kapan diunggah, dan statusnya sampai Minggu 12. Untuk rencana dan realisasi pekerjaan, lihat Bab 5.1.
#v(0.3em)
#tabel("tbl-artefak", [Dokumen tambahan Manajemen Proyek dan tempat pengumpulannya], tbl((2.4fr, 1.2fr, 1.2fr, 2.4fr),
  ([Dokumen], [Penyusun], [Diunggah], [Keterangan]),
  (
    ([Resource Plan dan RACI Matrix], [Raka dan Salsabila], [Minggu 10], [Lima peran, dua orang merangkap peran pengujian]),
    ([Jadwal Proyek (jalur kritis)], [Farrel], [Minggu 11], [Jalur kritis lewat migrasi skema; tampilan Rekap Dosen tertinggal]),
    ([Budget Plan], [Nadia], [Belum], [Masih draf, rencananya diunggah sebelum batas akhir laporan]),
  ), sz: 8.2pt))

Budget Plan paling tertinggal karena kami baru bisa memperkirakan biaya hosting setelah memutuskan pindah ke PostgreSQL di Minggu 9. Kami mengunggahnya sebelum batas akhir laporan Milestone 2, bersama perbaikan bug.

#pagebreak()
#lamp("E", "Daftar Tautan Eksternal", stage: st-m2)
Semua tautan eksternal laporan ini, termasuk untuk dokumen di Lampiran C dan D, terdaftar di @tbl-rujukan. Semuanya sudah diuji dan bisa dibuka tanpa login. Nama berkas yang dikumpulkan adalah `M2_TI-2C_KoyokNgeneLho.pdf`.
#v(0.3em)
#tabel("tbl-rujukan", [Daftar tautan eksternal], tbl((0.4fr, 2.4fr, 1.4fr, 3fr, 1.4fr),
  ([No], [Keterangan], [Bagian], [Tautan], [Jenis akses]),
  (
    ([1], [Repositori (_tag_ `milestone-2`)], [S.5], [`github.com/contoh/sikap-pbl`], [Publik]),
    ([2], [Aplikasi SIKAP-PBL], [S.5], [`sikap-pbl.example.com`], [Publik]),
    ([3], [SRS versi 1.2], [Lampiran C, Bab 2.1], [`docs.example.com/sikap-pbl/srs`], [Siapa saja yang memiliki tautan]),
    ([4], [Desain Figma versi 1.0], [Lampiran C, Bab 2.5], [`figma.example.com/file/sikap-pbl`], [Siapa saja yang memiliki tautan]),
    ([5], [Project Charter versi 1.1], [Lampiran C, Bab 1.3], [`docs.example.com/sikap-pbl/charter`], [Siapa saja yang memiliki tautan]),
    ([6], [Governance Log versi 1.3], [Lampiran C, Bab 5.3], [`docs.example.com/sikap-pbl/governance-log`], [Siapa saja yang memiliki tautan]),
    ([7], [Stakeholder Register versi 1.1], [Lampiran C, Bab 1.4], [`docs.example.com/sikap-pbl/stakeholder`], [Siapa saja yang memiliki tautan]),
    ([8], [WBS dan Gantt versi 1.3], [Lampiran C, Bab 5.1], [`docs.example.com/sikap-pbl/wbs-gantt`], [Siapa saja yang memiliki tautan]),
    ([9], [PDM dan kamus data versi 1.2], [Lampiran C, Bab 2.3], [`docs.example.com/sikap-pbl/pdm`], [Siapa saja yang memiliki tautan]),
    ([10], [Rencana uji, kasus uji, dan catatan bug versi 1.0], [Lampiran C, Bab 4], [`docs.example.com/sikap-pbl/pengujian`], [Siapa saja yang memiliki tautan]),
    ([11], [Resource Plan dan RACI Matrix, Jadwal Proyek, Budget Plan (di lembar penilaian mandiri)], [Lampiran D], [`docs.example.com/sikap-pbl/penilaian-mandiri`], [Siapa saja yang memiliki tautan]),
    ([12], [Video demo (cadangan)], [S.5], [`youtu.example.com/sikap-pbl-demo`], [Siapa saja yang memiliki tautan]),
  ), sz: 7.8pt))

#pagebreak()
#lamp("G", "Dokumentasi Kueri Basis Data", stage: st-m2)
#show raw: set text(size: 6.2pt)
Lampiran ini menjawab tiga hal: kueri apa yang dipakai, fungsinya di aplikasi, dan hasil pengujiannya. Kami menulis skema 13 tabel, sembilan kueri, satu _view_, satu _trigger_, dan satu transaksi, lalu menguji tiga kueri dengan `EXPLAIN ANALYZE`. Semuanya memakai PostgreSQL 16 dan sama dengan PDM serta kamus data di Bab 2.3.

#sec("", "G.1 Skema dan Indeks")
Skema dibuat dalam dua tahap, dan seluruhnya ada di @kode-ddl. Bagian pertama membuat tabel acuan dan akun (peran, pengguna, kelas, mata kuliah, dosen, dan pengampu), bagian kedua membuat tabel inti (tim, anggota, checkpoint, kategori, kontribusi, bukti, dan respons dosen). Urutannya penting karena tabel yang dirujuk kunci asing harus ada lebih dulu.

#kode("kode-ddl", [DDL 13 tabel: tabel acuan dan akun, lalu tabel inti kontribusi],
```sql
CREATE TABLE peran (
  id SERIAL PRIMARY KEY, nama VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE pengguna (
  id SERIAL PRIMARY KEY, nim_nip VARCHAR(18) NOT NULL UNIQUE,
  nama VARCHAR(80) NOT NULL, email VARCHAR(100) NOT NULL UNIQUE,
  kata_sandi VARCHAR(255) NOT NULL, peran_id INT NOT NULL REFERENCES peran(id),
  aktif BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE kelas (
  id SERIAL PRIMARY KEY, kode VARCHAR(10) NOT NULL UNIQUE,
  semester SMALLINT NOT NULL CHECK (semester BETWEEN 1 AND 8),
  tahun_akademik VARCHAR(9) NOT NULL
);
CREATE TABLE mata_kuliah (
  id SERIAL PRIMARY KEY, kode VARCHAR(10) NOT NULL UNIQUE,
  nama VARCHAR(60) NOT NULL, sks SMALLINT NOT NULL CHECK (sks BETWEEN 1 AND 6)
);
CREATE TABLE dosen (
  id SERIAL PRIMARY KEY, pengguna_id INT NOT NULL UNIQUE REFERENCES pengguna(id),
  nidn VARCHAR(10) NOT NULL UNIQUE
);
CREATE TABLE pengampu (
  dosen_id INT NOT NULL REFERENCES dosen(id),
  mata_kuliah_id INT NOT NULL REFERENCES mata_kuliah(id),
  kelas_id INT NOT NULL REFERENCES kelas(id),
  dosen_rujukan BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (dosen_id, mata_kuliah_id, kelas_id)
);
CREATE TABLE tim (
  id SERIAL PRIMARY KEY, kelas_id INT NOT NULL REFERENCES kelas(id),
  nama_tim VARCHAR(60) NOT NULL UNIQUE, judul_proyek VARCHAR(120) NOT NULL
);
CREATE TABLE anggota (
  id SERIAL PRIMARY KEY, tim_id INT NOT NULL REFERENCES tim(id),
  pengguna_id INT NOT NULL UNIQUE REFERENCES pengguna(id),
  peran_tim VARCHAR(30) NOT NULL
);
CREATE TABLE checkpoint (
  id SERIAL PRIMARY KEY, nama VARCHAR(20) NOT NULL,
  minggu SMALLINT NOT NULL UNIQUE CHECK (minggu BETWEEN 1 AND 16),
  tanggal DATE NOT NULL
);
CREATE TABLE kategori_kontribusi (
  id SERIAL PRIMARY KEY, nama VARCHAR(40) NOT NULL UNIQUE,
  bobot NUMERIC(3,1) NOT NULL DEFAULT 1.0 CHECK (bobot > 0)
);
CREATE TABLE kontribusi (
  id SERIAL PRIMARY KEY, anggota_id INT NOT NULL REFERENCES anggota(id),
  checkpoint_id INT NOT NULL REFERENCES checkpoint(id),
  kategori_id INT NOT NULL REFERENCES kategori_kontribusi(id),
  minggu SMALLINT NOT NULL CHECK (minggu BETWEEN 1 AND 16),
  deskripsi_tugas TEXT NOT NULL,
  waktu_jam SMALLINT NOT NULL CHECK (waktu_jam BETWEEN 1 AND 40),
  status_verifikasi VARCHAR(20) NOT NULL DEFAULT 'belum'
    CHECK (status_verifikasi IN ('belum', 'terverifikasi', 'ditolak')),
  dibuat_pada TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE bukti (
  id SERIAL PRIMARY KEY,
  kontribusi_id INT NOT NULL REFERENCES kontribusi(id) ON DELETE CASCADE,
  jenis VARCHAR(10) NOT NULL CHECK (jenis IN ('tautan', 'berkas')),
  tautan VARCHAR(255), nama_berkas VARCHAR(120),
  ukuran_kb INT CHECK (ukuran_kb > 0),
  diunggah_pada TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT ck_bukti_isi CHECK (
    (jenis = 'tautan' AND tautan IS NOT NULL) OR
    (jenis = 'berkas' AND nama_berkas IS NOT NULL))
);
CREATE TABLE respons_dosen (
  id SERIAL PRIMARY KEY, checkpoint_id INT NOT NULL REFERENCES checkpoint(id),
  dosen_id INT NOT NULL REFERENCES dosen(id),
  status VARCHAR(20) NOT NULL DEFAULT 'belum'
    CHECK (status IN ('belum', 'dibaca', 'ditindaklanjuti')),
  catatan TEXT, waktu_direspons TIMESTAMPTZ,
  UNIQUE (checkpoint_id, dosen_id)
);
```
)

Indeks di @kode-indeks dipilih dari pengujian di G.4. Dua indeks pertama mempercepat saringan Q1 dan Q2, sedangkan sisanya mempercepat gabungan lewat kunci asing, yang tidak diindeks otomatis oleh PostgreSQL. Aturan unik untuk memperbaiki BUG-05 sudah kami siapkan sebagai komentar dan akan dijalankan pada Minggu 13.

#kode("kode-indeks", [Indeks dan batasan tambahan],
```sql
CREATE INDEX idx_kontribusi_anggota_checkpoint ON kontribusi (anggota_id, checkpoint_id);
CREATE INDEX idx_kontribusi_anggota_minggu     ON kontribusi (anggota_id, minggu);
CREATE INDEX idx_bukti_kontribusi              ON bukti (kontribusi_id);
CREATE INDEX idx_anggota_tim                   ON anggota (tim_id);
CREATE INDEX idx_respons_dosen_dosen           ON respons_dosen (dosen_id, checkpoint_id);
-- Rencana Minggu 13 (perbaikan BUG-05): satu catatan per anggota per minggu
-- ALTER TABLE kontribusi ADD CONSTRAINT uq_kontribusi_minggu UNIQUE (anggota_id, minggu);
```
)

#sec("", "G.2 Daftar Kueri")
Kolom Jenis di @tbl-daftar-kueri menunjukkan apakah kueri menghitung, membaca, atau mengubah data. Q8 dan Q9 melayani login dan halaman dosen, sedangkan empat baris terakhir adalah objek basis data selain kueri biasa.

#tabel("tbl-daftar-kueri", [Daftar kueri, view, trigger, dan transaksi], tbl((0.8fr, 3fr, 1.9fr, 0.9fr),
  ([No], [Fungsi di aplikasi], [Tabel yang dipakai], [Jenis]),
  (
    ([Q1], [Menghitung catatan dan jam tiap anggota per checkpoint untuk Dashboard Partisipasi], [`anggota`, `pengguna`, `checkpoint`, `kontribusi`], [Hitung]),
    ([Q2], [Menampilkan anggota yang belum mencatat aktivitas minggu ini di dashboard ketua tim], [`anggota`, `pengguna`, `kontribusi`], [Baca data]),
    ([Q3], [Menjumlahkan jam kerja tiap tim per checkpoint untuk grafik batang], [`tim`, `anggota`, `kontribusi`], [Hitung]),
    ([Q4], [Menampilkan status dan waktu respons dosen tiap checkpoint di Rekap Keterlibatan Dosen], [`respons_dosen`, `checkpoint`, `dosen`, `pengguna`], [Baca data]),
    ([Q5], [Menyimpan catatan aktivitas dari formulir], [`kontribusi`], [Ubah data]),
    ([Q6], [Meranking anggota dalam satu tim berdasarkan total jam untuk kartu "posisi saya"], [`anggota`, `pengguna`, `kontribusi`], [Hitung]),
    ([Q7], [Menghitung tren jam kerja tim per minggu untuk grafik garis], [`kontribusi`, `anggota`], [Hitung]),
    ([Q8], [Mencari akun beserta perannya saat login], [`pengguna`, `peran`], [Baca data]),
    ([Q9], [Menampilkan kelas dan mata kuliah yang diampu seorang dosen, termasuk tanda dosen rujukan], [`pengampu`, `dosen`, `kelas`, `mata_kuliah`], [Baca data]),
    ([View], [`v_rekap_partisipasi`: rekap per tim, checkpoint, dan anggota untuk Ekspor Penilaian], [`tim`, `anggota`, `pengguna`, `kontribusi`, `checkpoint`], [Baca data]),
    ([Trigger], [`trg_respons_dosen`: mencatat waktu saat dosen pertama kali mengubah status respons], [`respons_dosen`], [Ubah data]),
    ([Transaksi], [Menyimpan catatan, menambah bukti, dan menandainya terverifikasi bila buktinya tautan GitHub], [`kontribusi`, `bukti`], [Ubah data]),
  ), sz: 7.8pt))

#sec("", "G.3 Kueri dan Fungsinya")
Nilai seperti `tim_id = 3` dan Minggu 12 adalah contoh saat pengujian, dan di aplikasi diganti parameter. Q6 memakai _window function_ dan Q7 memakai CTE, bahan yang dinilai di Basis Data Lanjut.

Kesembilan kueri ada di @kode-kueri. Q1 menampilkan anggota yang belum mencatat dengan nilai nol karena memakai `CROSS JOIN` dan `LEFT JOIN`. Q2 lebih sempit, hanya anggota yang belum mencatat sama sekali pada Minggu 12, dan Q3 menjumlahkan jam per tim untuk grafik batang. Q4 melayani Rekap Keterlibatan Dosen: selisih hari dihitung dari tanggal checkpoint ke waktu respons pertama, dan baris yang belum direspons tidak ikut. Q5 adalah penyimpanan catatan dari formulir, yang dipakai juga di dalam transaksi.

Q6 memakai `RANK()` supaya anggota dengan jam sama mendapat peringkat sama. Q7 memakai CTE `per_minggu` untuk menjumlahkan jam per minggu, lalu `LAG()` di kueri luar menambahkan selisih dari minggu sebelumnya, sehingga dashboard menjawab "posisi saya di tim" dan "apakah tim sedang melambat" tanpa hitungan di PHP. Q8 dan Q9 mendukung login dan halaman dosen, dan Q9 memperlihatkan gunanya tabel penghubung `pengampu`: satu kueri menjawab kelas dan mata kuliah apa saja yang diampu dosen, dan siapa dosen rujukannya.

#kode("kode-kueri", [Kueri Q1 sampai Q9],
```sql
-- Q1: catatan dan jam tiap anggota per checkpoint
SELECT u.nama, c.nama AS checkpoint,
       COUNT(k.id) AS jumlah_catatan,
       COALESCE(SUM(k.waktu_jam), 0) AS total_jam
FROM anggota a
JOIN pengguna u ON u.id = a.pengguna_id
CROSS JOIN checkpoint c
LEFT JOIN kontribusi k ON k.anggota_id = a.id AND k.checkpoint_id = c.id
WHERE a.tim_id = 3
GROUP BY u.nama, c.nama, c.minggu
ORDER BY c.minggu, u.nama;
-- Q2: anggota yang belum mencatat pada Minggu 12
SELECT u.nama
FROM anggota a JOIN pengguna u ON u.id = a.pengguna_id
WHERE a.tim_id = 3
  AND NOT EXISTS (SELECT 1 FROM kontribusi k
                  WHERE k.anggota_id = a.id AND k.minggu = 12);
-- Q3: total jam tiap tim per checkpoint
SELECT t.nama_tim, k.checkpoint_id, SUM(k.waktu_jam) AS total_jam
FROM kontribusi k
JOIN anggota a ON a.id = k.anggota_id
JOIN tim t ON t.id = a.tim_id
GROUP BY t.nama_tim, k.checkpoint_id
ORDER BY t.nama_tim, k.checkpoint_id;
-- Q4: status respons dosen dan selisih hari
SELECT u.nama AS dosen, c.nama AS checkpoint, rd.status,
       rd.waktu_direspons::date - c.tanggal AS selisih_hari
FROM respons_dosen rd
JOIN checkpoint c ON c.id = rd.checkpoint_id
JOIN dosen d ON d.id = rd.dosen_id
JOIN pengguna u ON u.id = d.pengguna_id
WHERE rd.waktu_direspons IS NOT NULL
ORDER BY c.minggu, u.nama;
-- Q5: menyimpan satu catatan dari formulir
INSERT INTO kontribusi (anggota_id, checkpoint_id, kategori_id, minggu,
                        deskripsi_tugas, waktu_jam)
VALUES (7, 3, 2, 12, 'Menyusun kueri dashboard', 4);
-- Q6: peringkat anggota
SELECT u.nama,
       SUM(k.waktu_jam) AS total_jam,
       RANK() OVER (ORDER BY SUM(k.waktu_jam) DESC) AS peringkat
FROM anggota a
JOIN pengguna u ON u.id = a.pengguna_id
JOIN kontribusi k ON k.anggota_id = a.id
WHERE a.tim_id = 3
GROUP BY u.nama;
-- Q7: tren jam kerja tim
WITH per_minggu AS (
  SELECT k.minggu, SUM(k.waktu_jam) AS jam
  FROM kontribusi k JOIN anggota a ON a.id = k.anggota_id
  WHERE a.tim_id = 3
  GROUP BY k.minggu
)
SELECT minggu, jam, jam - LAG(jam) OVER (ORDER BY minggu) AS selisih
FROM per_minggu
ORDER BY minggu;
-- Q8: akun dan peran saat login
SELECT u.id, u.nama, u.kata_sandi, p.nama AS peran
FROM pengguna u JOIN peran p ON p.id = u.peran_id
WHERE u.email = :email AND u.aktif;
-- Q9: kelas dan mata kuliah yang diampu dosen
SELECT k.kode AS kelas, m.nama AS mata_kuliah, pg.dosen_rujukan
FROM pengampu pg
JOIN kelas k ON k.id = pg.kelas_id
JOIN mata_kuliah m ON m.id = pg.mata_kuliah_id
WHERE pg.dosen_id = 1
ORDER BY k.kode, m.nama;
```
)

_View_, _trigger_, dan transaksi ada di @kode-objek. _View_ dipakai Ekspor untuk Penilaian dan Dashboard Partisipasi. _Trigger_ mencatat waktu respons dosen secara otomatis, sehingga Rekap Keterlibatan Dosen tidak bergantung pada isian manual. Transaksi memastikan tiga langkah (catatan, bukti, dan penandaan terverifikasi) berhasil bersamaan atau tidak sama sekali.

#kode("kode-objek", [View, trigger, dan transaksi],
```sql
CREATE VIEW v_rekap_partisipasi AS
SELECT t.nama_tim, c.nama AS checkpoint, u.nama,
       COUNT(k.id) AS jumlah_catatan,
       COALESCE(SUM(k.waktu_jam), 0) AS total_jam
FROM tim t
JOIN anggota a ON a.tim_id = t.id
JOIN pengguna u ON u.id = a.pengguna_id
CROSS JOIN checkpoint c
LEFT JOIN kontribusi k ON k.anggota_id = a.id AND k.checkpoint_id = c.id
GROUP BY t.nama_tim, c.nama, c.minggu, u.nama;
CREATE FUNCTION catat_waktu_respons() RETURNS trigger AS $$
BEGIN
  IF OLD.status = 'belum' AND NEW.status <> 'belum' THEN
    NEW.waktu_direspons := now();
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_respons_dosen
BEFORE UPDATE ON respons_dosen
FOR EACH ROW EXECUTE FUNCTION catat_waktu_respons();
BEGIN;
INSERT INTO kontribusi (anggota_id, checkpoint_id, kategori_id, minggu,
                        deskripsi_tugas, waktu_jam)
VALUES (7, 3, 2, 12, 'Menyusun kueri dashboard', 4)
RETURNING id;                                   -- misalnya 481
INSERT INTO bukti (kontribusi_id, jenis, tautan)
VALUES (481, 'tautan', 'https://github.com/contoh/sikap-pbl/commit/abc');
UPDATE kontribusi SET status_verifikasi = 'terverifikasi'
WHERE id = 481
  AND EXISTS (SELECT 1 FROM bukti b
              WHERE b.kontribusi_id = 481 AND b.tautan LIKE 'https://github.com/%');
COMMIT;
```
)

#sec("", "G.4 Pengujian dengan EXPLAIN ANALYZE")
Pengujian memakai PostgreSQL 16 dengan 120 catatan data uji ditambah 10.000 baris tambahan untuk uji beban, dan `EXPLAIN (ANALYZE, BUFFERS)` kami jalankan di depan tiap kueri. @gbr-q1-sebelum menunjukkan saringan Q1 sebelum ada indeks, @gbr-q1-sesudah sesudah indeks `idx_kontribusi_anggota_checkpoint` dibuat, dan @gbr-q3 memperlihatkan Q3 yang menjumlahkan semua baris.

#console("gbr-q1-sebelum", [Q1 (saringan) sebelum indeks: Seq Scan 2,745 ms], "EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM kontribusi WHERE anggota_id = 7 AND checkpoint_id = 3;

Seq Scan on kontribusi  (cost=0.00..189.20 rows=9 width=88)
                        (actual time=0.031..2.714 rows=11 loops=1)
  Filter: ((anggota_id = 7) AND (checkpoint_id = 3))
  Rows Removed by Filter: 10109
  Buffers: shared hit=79
Planning Time: 0.084 ms
Execution Time: 2.745 ms")

#console("gbr-q1-sesudah", [Q1 (saringan) sesudah indeks: Index Scan 0,063 ms], "Index Scan using idx_kontribusi_anggota_checkpoint on kontribusi
    (cost=0.29..8.51 rows=9 width=88) (actual time=0.022..0.041 rows=11 loops=1)
  Index Cond: ((anggota_id = 7) AND (checkpoint_id = 3))
  Buffers: shared hit=5
Planning Time: 0.112 ms
Execution Time: 0.063 ms")

#console("gbr-q3", [Q3 (total jam per tim): Seq Scan dan HashAggregate 21,3 ms], "HashAggregate  (cost=612.40..615.90 rows=48 width=44)
               (actual time=20.310..20.352 rows=48 loops=1)
  Group Key: t.nama_tim, k.checkpoint_id
  ->  Hash Join  (cost=2.30..512.40 rows=10120 width=12)
                 (actual time=0.110..14.230 rows=10120 loops=1)
        Hash Cond: (a.tim_id = t.id)
        ->  Seq Scan on kontribusi k  (rows=10120)
        ->  Hash on anggota a, tim t
Planning Time: 0.210 ms
Execution Time: 21.310 ms")

Indeks menurunkan waktu saringan Q1 dari 2,7 ms menjadi 0,06 ms, sekitar 40 kali lebih cepat (@tbl-hasil-kueri). Q3 masih memakai Seq Scan, tetapi 21,3 ms jauh di bawah target NFR-03 (satu detik), jadi belum perlu indeks tambahan.

#tabel("tbl-hasil-kueri", [Hasil pengujian EXPLAIN ANALYZE], tbl((0.9fr, 1fr, 1fr, 1fr, 2.4fr),
  ([Kueri], [Baris data uji], [Jenis scan], [Execution time], [Catatan]),
  (
    ([Q1 (saringan)], [10.120], [Seq Scan], [2,7 ms], [Belum ada indeks]),
    ([Q1 (saringan)], [10.120], [Index Scan], [0,06 ms], [Setelah indeks `kontribusi(anggota_id, checkpoint_id)` ditambah]),
    ([Q2], [10.120], [Index Scan], [0,5 ms], [Memakai indeks `kontribusi(anggota_id, minggu)`]),
    ([Q3], [10.120], [Seq Scan], [21,3 ms], [Menjumlahkan semua baris. Cukup untuk saat ini, diuji ulang bila data bertambah]),
  ), sz: 8.2pt))

Untuk membaca keluarannya: _Seq Scan_ berarti PostgreSQL membaca semua baris tabel, sedangkan _Index Scan_ memakai indeks untuk langsung ke baris yang dicari. Angka _Rows Removed by Filter_ yang besar menandakan indeks bisa membantu.

#pagebreak()
#lamp("H", "Deklarasi Penggunaan AI", stage: st-lanjutan)
Seluruh anggota memahami dan mampu menjelaskan bagian yang dibantu AI pada @tbl-ai. Daftar ini bertambah sampai laporan akhir.
#v(0.3em)
#tabel("tbl-ai", [Deklarasi penggunaan AI], tbl((1.6fr, 1.2fr, 2.4fr),
  ([Bagian], [Alat], [Tujuan]),
  (
    ([Kueri dashboard (Q1)], [Asisten kode], [Saran optimasi. Ditinjau dan diuji oleh Farrel dan Nadia]),
    ([Perbaikan bahasa Bab 1], [Asisten menulis], [Merapikan kalimat. Isi ditulis tim]),
  ), sz: 8.2pt))
