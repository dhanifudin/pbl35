#import "contoh-lib.typ": *
#show: doc => contoh(product: "KOSKU", team: "Tim Kos Nyaman",
  title: "Contoh Laporan Milestone 2 PBL (KOSKU, SIB Semester 5)", doc)

// Skema basis data: satu sumber untuk PDM (Bab 2.3), kamus data, dan DDL (Lampiran G).
// Setiap kolom: (nama, tipe, kunci, batasan, keterangan)
#let skema = (
  peran: (
    ("id", "serial", "PK", "Kunci utama", "Identitas peran"),
    ("nama", "varchar(20)", "UQ", "NOT NULL, UNIQUE", "penghuni, pemilik, atau admin"),
    ("keterangan", "varchar(100)", "", "Boleh kosong", "Penjelasan singkat hak akses"),
  ),
  pengguna: (
    ("id", "serial", "PK", "Kunci utama", "Identitas akun"),
    ("peran_id", "int", "FK", "NOT NULL, FK ke peran(id)", "Peran pemilik akun"),
    ("nama", "varchar(100)", "", "NOT NULL", "Nama lengkap"),
    ("email", "varchar(120)", "UQ", "NOT NULL, UNIQUE", "Dipakai untuk login"),
    ("kata_sandi", "varchar(255)", "", "NOT NULL", "Hasil hash bcrypt, bukan teks asli"),
    ("aktif", "boolean", "", "NOT NULL, default true", "Akun nonaktif tidak bisa login"),
    ("dibuat_pada", "timestamptz", "", "NOT NULL, default now()", "Waktu akun dibuat"),
  ),
  token_akses: (
    ("id", "bigserial", "PK", "Kunci utama", "Identitas token"),
    ("pengguna_id", "int", "FK", "NOT NULL, FK ke pengguna(id)", "Pemilik token"),
    ("nama", "varchar(60)", "", "NOT NULL", "Nama perangkat atau klien"),
    ("token", "char(64)", "UQ", "NOT NULL, UNIQUE", "Hash SHA-256 dari token (Sanctum)"),
    ("terakhir_dipakai", "timestamptz", "", "Boleh kosong", "Waktu token terakhir dipakai"),
    ("kedaluwarsa_pada", "timestamptz", "", "NOT NULL", "Dibuat + 2 jam saat login"),
    ("dibuat_pada", "timestamptz", "", "NOT NULL, default now()", "Waktu token diterbitkan"),
  ),
  log_impor: (
    ("id", "serial", "PK", "Kunci utama", "Identitas catatan impor"),
    ("pengguna_id", "int", "FK", "NOT NULL, FK ke pengguna(id)", "Admin yang mengunggah"),
    ("nama_berkas", "varchar(120)", "", "NOT NULL", "Nama berkas CSV"),
    ("baris_total", "int", "", "NOT NULL, minimal 0", "Jumlah baris data"),
    ("baris_masuk", "int", "", "NOT NULL, minimal 0", "Baris yang tersimpan"),
    ("baris_ditolak", "int", "", "NOT NULL, minimal 0", "Baris yang gagal validasi"),
    ("laporan", "jsonb", "", "Boleh kosong", "Daftar nomor baris dan alasan penolakan"),
    ("dibuat_pada", "timestamptz", "", "NOT NULL, default now()", "Waktu impor"),
  ),
  tipe_kamar: (
    ("id", "serial", "PK", "Kunci utama", "Identitas tipe"),
    ("nama", "varchar(40)", "UQ", "NOT NULL, UNIQUE", "Misalnya Standar atau Dengan AC"),
    ("harga_dasar", "numeric(10,2)", "", "NOT NULL, lebih dari 0", "Harga acuan per bulan"),
    ("luas_m2", "numeric(4,1)", "", "Boleh kosong", "Luas kamar dalam meter persegi"),
  ),
  kamar: (
    ("id", "serial", "PK", "Kunci utama", "Identitas kamar"),
    ("tipe_kamar_id", "int", "FK", "NOT NULL, FK ke tipe_kamar(id)", "Tipe kamar"),
    ("nomor", "varchar(10)", "UQ", "NOT NULL, UNIQUE", "Nomor kamar, misalnya A-05"),
    ("lantai", "smallint", "", "NOT NULL", "Lantai tempat kamar berada"),
    ("harga", "numeric(10,2)", "", "NOT NULL, lebih dari 0", "Harga sewa per bulan"),
    ("status", "varchar(10)", "", "NOT NULL, default 'kosong', hanya kosong atau terisi", "Status hunian"),
  ),
  fasilitas: (
    ("id", "serial", "PK", "Kunci utama", "Identitas fasilitas"),
    ("nama", "varchar(40)", "UQ", "NOT NULL, UNIQUE", "Misalnya AC atau kamar mandi dalam"),
  ),
  kamar_fasilitas: (
    ("kamar_id", "int", "PK FK", "Kunci utama gabungan, FK ke kamar(id)", "Kamar yang punya fasilitas"),
    ("fasilitas_id", "int", "PK FK", "Kunci utama gabungan, FK ke fasilitas(id)", "Fasilitas yang dimiliki"),
  ),
  penghuni: (
    ("id", "serial", "PK", "Kunci utama", "Identitas penghuni"),
    ("pengguna_id", "int", "FK UQ", "NOT NULL, UNIQUE, FK ke pengguna(id)", "Satu akun untuk satu penghuni"),
    ("no_telepon", "varchar(20)", "", "NOT NULL", "Nomor yang bisa dihubungi"),
    ("no_identitas", "varchar(20)", "", "Boleh kosong", "Nomor KTP atau kartu mahasiswa"),
    ("pekerjaan", "varchar(60)", "", "Boleh kosong", "Mahasiswa atau pekerja"),
    ("alamat_asal", "text", "", "Boleh kosong", "Alamat asal penghuni"),
  ),
  reservasi: (
    ("id", "serial", "PK", "Kunci utama", "Identitas reservasi"),
    ("penghuni_id", "int", "FK", "NOT NULL, FK ke penghuni(id)", "Penghuni yang memesan"),
    ("kamar_id", "int", "FK", "NOT NULL, FK ke kamar(id)", "Kamar yang dipesan"),
    ("tanggal_masuk", "date", "", "NOT NULL", "Tanggal mulai menghuni"),
    ("tanggal_keluar", "date", "", "Boleh kosong, minimal sama dengan tanggal masuk", "Tanggal berakhir bila sudah diketahui"),
    ("status", "varchar(12)", "", "NOT NULL, default 'menunggu', hanya menunggu, disetujui, ditolak, atau check_in", "Tahap reservasi"),
    ("dibuat_pada", "timestamptz", "", "NOT NULL, default now()", "Waktu pengajuan"),
  ),
  tagihan: (
    ("id", "serial", "PK", "Kunci utama", "Identitas tagihan"),
    ("reservasi_id", "int", "FK", "NOT NULL, FK ke reservasi(id)", "Reservasi yang ditagih"),
    ("periode", "date", "", "NOT NULL", "Tanggal 1 pada bulan yang ditagih"),
    ("jatuh_tempo", "date", "", "NOT NULL", "Batas pembayaran"),
    ("jumlah", "numeric(10,2)", "", "NOT NULL, lebih dari 0", "Nilai tagihan"),
    ("status", "varchar(10)", "", "NOT NULL, default 'belum', hanya belum atau lunas", "Status pembayaran"),
    ("dibuat_pada", "timestamptz", "", "NOT NULL, default now()", "Waktu tagihan dibuat"),
  ),
  pembayaran: (
    ("id", "serial", "PK", "Kunci utama", "Identitas pembayaran"),
    ("tagihan_id", "int", "FK", "NOT NULL, FK ke tagihan(id)", "Tagihan yang dibayar"),
    ("dicatat_oleh", "int", "FK", "NOT NULL, FK ke pengguna(id)", "Pemilik yang mencatat"),
    ("jumlah", "numeric(10,2)", "", "NOT NULL, lebih dari 0", "Nilai yang dibayar"),
    ("metode", "varchar(12)", "", "NOT NULL", "tunai atau transfer"),
    ("dibayar_pada", "timestamptz", "", "NOT NULL", "Waktu pembayaran diterima"),
    ("catatan", "varchar(200)", "", "Boleh kosong", "Keterangan tambahan"),
  ),
)
#let pk(nama, c, r) = (name: nama, col: c, row: r, cols: skema.at(nama).map(k => (k.at(0), k.at(1), k.at(2))))
#let kamus-rows(names) = names.map(n => skema.at(n).enumerate().map(((i, k)) => (
  if i == 0 { text(size: 6.4pt, raw(n)) } else { [] }, text(size: 6.4pt, raw(k.at(0))), k.at(1), k.at(3), k.at(4)))).flatten()


#cover-kosku(
  product: "KOSKU",
  subtitle: "Sistem Reservasi dan Manajemen Rumah Kos",
  prodi: "Program Studi Sistem Informasi Bisnis, Semester 5",
  team: "Tim Kos Nyaman", class-line: "Kelas SIB-3C",
  members: "Hanif Ramadhan, Selvi Oktaviani, Yoga Prasetya, Nabila Khairunnisa",
  year-line: "Tahun Akademik 2026/2027 · November 2026",
  headline: "Kamar Penuh, Tagihan Rapi? Hampir.", accent-word: "Hampir.",
  coverlines: (("Manajemen proyek", "Jadwal mundur sepekan dan cara kami mengejarnya"), ("Data", "Impor CSV, ekspor tagihan"), ("Pengujian", "Delapan belas kasus uji, dua yang gagal"),)
)
#counter(page).update(1)

#usage-note()

// =====================================================================
// LEMBAR STATUS
// =====================================================================
#part("Lembar Status Milestone 2", "Posisi Proyek pada Minggu 12")
#pill(st-hapus)
#v(0.5em)
#fakta((("Status", "Sebagian"), ("Kelas", "SIB-3C"), ("Dosen rujukan", "Dosen Rujukan"), ("Tim", "Tim Kos Nyaman")))

#sec("S.1", "Identitas, Dosen Pengampu, dan Dosen Rujukan")
#tbl((1.6fr, 1.1fr, 1.9fr, 1.3fr),
  ([Nama], [NIM], [Peran saat ini], [Perubahan dari Milestone 1]),
  (
    ([Hanif Ramadhan], [2441 0000 0001], [Ketua Tim dan Pengembang Back-end], [Tidak ada]),
    ([Selvi Oktaviani], [2441 0000 0002], [Manajer Proyek dan Dokumentator], [Tidak ada]),
    ([Yoga Prasetya], [2441 0000 0003], [Pengembang Front-end (SPA)], [Tidak ada]),
    ([Nabila Khairunnisa], [2441 0000 0004], [Penguji (QA) dan Analis Data], [Menambah tugas dasbor sejak Minggu 11]),
  ), sz: 8pt)
#v(0.4em)
#tbl((2fr, 2fr, 1.6fr),
  ([Mata kuliah], [Dosen pengampu], [Dosen rujukan kelas]),
  (
    ([Pemrograman Web Lanjut], [Dosen Web Lanjut], [Dosen Rujukan SIB-3C]),
    ([Manajemen Proyek Sistem Informasi], [Dosen Manajemen Proyek], [Dosen Rujukan SIB-3C]),
    ([Penjaminan Mutu Perangkat Lunak], [Dosen Penjaminan Mutu], [Dosen Rujukan SIB-3C]),
  ), sz: 8pt)

#sec("S.2", "Status Milestone 2")
Status kami Sebagian. Alur utama, yaitu penghuni mengajukan reservasi, pemilik menyetujui, check-in, lalu tagihan terbit, sudah berjalan dengan tiga peran dan login berbasis token, dan dasbor okupansi sudah menampilkan data nyata. Tagihan bulanan otomatis belum stabil karena tagihan ganda (BUG-07), dan pendapatan di pergantian bulan salah hitung (BUG-06). Dari 18 kasus uji, 16 lulus dan 2 gagal. Jadwal mundur sekitar satu minggu karena satu anggota sakit. Rencana pemulihan ada di S.6.

#sec("S.3", "Tindak Lanjut Milestone 1")
#tbl((2.2fr, 1.5fr, 2.2fr, 0.8fr),
  ([Umpan balik Milestone 1], [Mata kuliah], [Tindak lanjut], [Status]),
  (
    ([Autentikasi perlu masa berlaku token], [Pemrograman Web Lanjut], [Token kedaluwarsa setelah 2 jam, diuji pada TC-04], [Selesai]),
    ([Risiko belum diberi skor], [Manajemen Proyek Sistem Informasi], [Daftar risiko memakai skor kemungkinan × dampak (Bab 5.3)], [Selesai]),
    ([Bug belum punya catatan regresi], [Penjaminan Mutu Perangkat Lunak], [Setiap bug yang diperbaiki mencatat kasus uji regresinya (Bab 4.3)], [Selesai]),
  ), sz: 8pt)

#sec("S.4", "Capaian Produk")
Sudah berjalan: login tiga peran dengan token, reservasi dan persetujuan, check-in, impor kamar dan ekspor tagihan (CSV), serta dasbor okupansi. Masih sebagian: tagihan bulanan otomatis (BUG-07) dan pendapatan di pergantian bulan (BUG-06). Belum: notifikasi jatuh tempo, pindah ke laporan akhir.

Target SIB Semester 5 terpenuhi: alur utama berjalan dengan login, tiga peran (target minimal dua), jadwal dan risiko tercatat di Bab 5, Bab 1–3 ditulis, dan Bab 4 memuat 18 kasus uji.

#sec("S.5", "Bukti")
#tbl((1.1fr, 2fr, 2.1fr),
  ([Aspek], [Pilihan tim], [Tautan atau keterangan]),
  (
    ([Demo], [Langsung, dengan video cadangan], [Video 4 menit]),
    ([Cara _deploy_], [Hosting gratis], [`kosku-contoh.example.com`]),
    ([Repositori], [Git dengan _tag_ `milestone-2`], [`github.com/contoh/kosku`]),
    ([Masukan pengguna], [Pemilik kos dan tiga penghuni], [Bab 4.5]),
  ), sz: 8pt)

#sec("S.6", "Rencana Minggu 13–16")
#tbl((0.7fr, 3.2fr, 1.2fr),
  ([Minggu], [Target], [Penanggung jawab]),
  (
    ([13], [Memperbaiki BUG-06 dan BUG-07, lalu menjalankan ulang TC-09 dan TC-13], [Hanif, Nabila]),
    ([14], [Uji regresi lengkap; notifikasi jatuh tempo bila waktu cukup], [Nabila, Yoga]),
    ([15], [Merapikan Bab 1–5 dan menyiapkan materi demo], [Seluruh tim]),
    ([16], [Demo Day dan Expo], [Seluruh tim]),
  ), sz: 8pt)

#pagebreak()

#toc-page()

// =====================================================================
// BAB 1
// =====================================================================
#chapter("Bab 1", "Pendahuluan")
#lead[Bab ini menjelaskan masalah yang dialami pemilik kos mitra, batas pekerjaan kami, dan ukuran keberhasilan proyek. Temuan terpentingnya: dua kriteria belum tercapai karena satu bug tagihan.]

#sec("1.1", "Latar Belakang dan Rumusan Masalah", stage: st-proposal)
Pemilik kos kecil di sekitar kampus biasanya menerima reservasi lewat pesan singkat dan mencatat tagihan di buku tulis. Pada Minggu 2 kami mewawancarai pemilik kos mitra, lalu bersama beliau menelusuri catatan tiga bulan terakhir di kos berkamar 20 itu. Ternyata ada lima kamar yang pernah dijanjikan ke dua calon penghuni sekaligus dan tujuh tunggakan yang baru ketahuan di akhir bulan. Setiap awal bulan, beliau juga menghabiskan hampir satu jam untuk menghitung okupansi dan pendapatan dengan kalkulator.

Akar masalahnya sederhana: status kamar, tagihan, dan pembayaran tersimpan di tempat yang berbeda dan tidak saling terhubung. Calon penghuni tidak bisa melihat kamar mana yang kosong, sementara pemilik tidak punya gambaran keuangan yang cepat dibaca. Karena data yang sama dipakai tiga pihak dengan hak yang berbeda, kami memilih sistem web dengan pembagian peran. Rumusan masalahnya: bagaimana mengelola reservasi, penghunian, dan tagihan kos agar status kamar dan keuangan terlihat jelas bagi pemilik, tanpa kamar yang dipesan ganda?

#sec("1.2", "Tujuan", stage: st-proposal)
Menghasilkan aplikasi web yang matang, yaitu SPA dan REST API dengan tiga peran dan autentikasi token, yang dikelola dengan jadwal, risiko, dan perubahan yang terdokumentasi serta diuji secara terstruktur.

#sec("1.3", "Cakupan Fitur dan Batasan", stage: st-proposal)
Cakupan produk tertulis dalam pernyataan cakupan (_scope statement_) di Project Charter versi 1.1 dan disepakati dengan pemilik kos pada Minggu 3. Kami membangun lima kelompok fitur: reservasi dan persetujuan, check-in dan status kamar, tagihan bulanan dan pembayaran, impor data kamar serta ekspor tagihan dalam CSV, dan dasbor okupansi dan pendapatan. Tiga hal sengaja kami tinggalkan supaya proyek muat dalam 16 minggu, yaitu pembayaran daring otomatis, aplikasi ponsel, dan dukungan banyak kos dalam satu akun pemilik. Perubahan atas daftar ini dicatat di Governance Log (Bab 5.3).

Asumsi kami satu kos dengan sekitar 20 kamar, dengan pembayaran dicatat pemilik setelah uang diterima. Karena semua anggota juga menempuh mata kuliah lain, kapasitas kerja kami hitung 12 jam per orang per minggu, atau sekitar 48 jam untuk tim. Batas inilah yang menggeser pembayaran daring dan aplikasi ponsel ke luar cakupan.

Proyek ini sekaligus menjadi bahan tiga mata kuliah. Pemrograman Web Lanjut menilai Bab 3.2 (MVC, CRUD dengan validasi, autentikasi dan otorisasi peran, perancangan API, serta impor dan ekspor CSV), Manajemen Proyek Sistem Informasi menilai Bab 1.4 dan Bab 5 (charter, WBS dan Gantt, risiko, perubahan), dan Penjaminan Mutu Perangkat Lunak menilai Bab 4 (rencana uji, 18 kasus uji, catatan bug dengan regresi).

#sec("1.4", "Pemangku Kepentingan dan Manfaat", stage: st-proposal)
Daftar pemangku kepentingan (Stakeholder Register versi 1.1) kami susun pada Minggu 2 dan diperbarui setelah Minggu 8. Pemilik kos adalah sponsor sekaligus pengguna utama dan berpengaruh paling besar, sehingga ia kami libatkan paling sering: wawancara di Minggu 2 dan mencoba dasbor di Minggu 12. Penghuni berpengaruh sedang dan mencoba alur reservasi. Admin kos diwakili anggota tim sebagai peran uji. Dosen Rujukan SIB-3C dan tiga dosen pengampu ikut menentukan arah dan menilai luaran, jadi mereka dikabari setiap ada perubahan yang menggeser jadwal.

Project Charter menetapkan batas waktu 16 minggu dan tanpa anggaran biaya karena kami memakai hosting gratis. Manfaat bagi pemilik adalah kamar tidak lagi dipesan ganda dan tunggakan terlihat sejak hari jatuh tempo. Penghuni mendapat kepastian status reservasi dan riwayat tagihan, sedangkan admin tidak perlu mengetik data kamar satu per satu karena bisa mengimpornya dari CSV. Dokumen Charter dan Stakeholder Register ditautkan di Lampiran E.

#sec("1.5", "Kriteria Keberhasilan", stage: st-proposal)
Enam kriteria kami tetapkan di Project Charter supaya Bab 4.6 pada laporan akhir bisa dijawab dengan angka. K1: hak akses tiga peran berfungsi tanpa pelanggaran pada uji otorisasi, dan ini tercapai (TC-14, TC-15). K2: tidak ada bug tingkat tinggi yang terbuka di laporan akhir, belum tercapai karena BUG-07 masih terbuka. K3: angka dasbor sama dengan hitungan manual untuk data satu bulan, dan baru okupansi yang sama, sedangkan pendapatan belum. K4: dasbor merespons di bawah 500 ms untuk 10.000 tagihan, tercapai dengan sekitar 120 ms. K5: paling sedikit 90% kasus uji lulus, saat ini 89% (16 dari 18). K6: selisih jadwal akhir paling banyak satu minggu, dan selisih saat ini tepat satu minggu.

Hasil itu menunjukkan keamanan dan kinerja sudah sesuai ukuran, sedangkan ketepatan angka tagihan dan keuangan masih kurang. Karena itu rencana Minggu 13 kami pusatkan pada BUG-06 dan BUG-07, bukan fitur baru. Batas 90% pada K5 kami pilih bersama Dosen Penjaminan Mutu pada Minggu 10: alur utama harus hampir seluruhnya lulus sebelum demo, tetapi bug berisiko rendah boleh diperbaiki belakangan.

// =====================================================================
// BAB 2
// =====================================================================
#chapter("Bab 2", "Analisis Kebutuhan dan Perancangan")
#lead[Bab ini menjelaskan kebutuhan pengguna, susunan sistem, rancangan basis data, dan tampilan. Keputusan terpenting: SPA dan API dipisah supaya aplikasi ponsel bisa menyusul tanpa mengubah logika bisnis.]

#sec("2.1", "Kebutuhan Pengguna dan Daftar Fitur", stage: st-proposal)
Kebutuhan sistem tertulis di dokumen SRS (spesifikasi kebutuhan perangkat lunak) versi 1.2, yang ditautkan di Lampiran E. Dari wawancara dengan pemilik kos kami mencatat dua keluhan yang terus muncul: tidak ada bukti siapa memesan kamar lebih dulu, dan tunggakan baru terlihat di akhir bulan. Keduanya menjadi dasar 12 kebutuhan fungsional (FR) dan 4 kebutuhan non-fungsional (NFR) di @tbl-srs, dengan prioritas dan status masing-masing. Dari 12 FR, sembilan selesai, dua sebagian, dan satu belum dibangun.

#tabel("tbl-srs", [Ringkasan kebutuhan pada SRS versi 1.2], tbl((0.6fr, 3.4fr, 0.8fr, 0.8fr),
  ([ID], [Kebutuhan], [Prioritas], [Status]),
  (
    ([FR-01], [Pengguna masuk dengan email dan kata sandi, lalu menerima token], [Tinggi], [Selesai]),
    ([FR-02], [Hak akses dibatasi menurut peran (otorisasi)], [Tinggi], [Selesai]),
    ([FR-03], [Admin mengelola data kamar dan tipe kamar, dengan validasi], [Tinggi], [Selesai]),
    ([FR-04], [Penghuni mengajukan reservasi kamar yang kosong], [Tinggi], [Selesai]),
    ([FR-05], [Pemilik menyetujui atau menolak reservasi], [Tinggi], [Selesai]),
    ([FR-06], [Pemilik mencatat check-in dan status kamar berubah], [Tinggi], [Selesai]),
    ([FR-07], [Sistem membuat tagihan bulanan secara otomatis], [Tinggi], [Sebagian]),
    ([FR-08], [Pemilik mencatat pembayaran atas tagihan], [Tinggi], [Selesai]),
    ([FR-09], [Admin mengimpor data kamar dari CSV dengan laporan per baris], [Sedang], [Selesai]),
    ([FR-10], [Pemilik mengekspor tagihan satu bulan ke CSV], [Sedang], [Selesai]),
    ([FR-11], [Dasbor menampilkan okupansi, pendapatan per bulan, dan tunggakan], [Sedang], [Sebagian]),
    ([FR-12], [Notifikasi tagihan yang akan jatuh tempo], [Rendah], [Belum]),
    ([NFR-01], [Dasbor merespons di bawah 500 ms untuk 10.000 tagihan], [Sedang], [Selesai]),
    ([NFR-02], [Kata sandi di-hash dan token kedaluwarsa setelah 2 jam], [Tinggi], [Selesai]),
    ([NFR-03], [API terdokumentasi dan bisa diuji ulang di Postman], [Sedang], [Selesai]),
    ([NFR-04], [Penghuni dapat menyelesaikan reservasi tanpa bantuan], [Sedang], [Selesai]),
  ), sz: 7.8pt))

Satu-satunya FR berprioritas tinggi yang masih sebagian adalah FR-07, dan itu sejalan dengan BUG-07. FR-12 berprioritas rendah sehingga kami tunda ke laporan akhir (perubahan P-1 di Bab 5.3). Sistem mengenal tiga peran. Penghuni melihat kamar, mengajukan reservasi, dan membuka tagihannya sendiri. Pemilik memutuskan reservasi, mencatat check-in dan pembayaran, mengekspor tagihan, dan membaca dasbor. Admin mengurus akun dan data kamar, termasuk impor CSV. Pembagian ini menjadi dasar kasus uji di Bab 4.2.

#sec("2.2", "Susunan Komponen Sistem", stage: st-proposal)
KOSKU terdiri dari tiga lapis seperti pada @gbr-arsitektur. SPA (Vue 3) berjalan di peramban dan hanya berbicara dengan API lewat HTTP dan JSON. REST API dibangun dengan Laravel 11 dalam pola MVC: model Eloquent untuk data, controller untuk alur, dan resource JSON sebagai lapisan tampilan (_view_). Basis datanya PostgreSQL 16.

#gambar("gbr-arsitektur", [Arsitektur tiga lapis KOSKU], flow(([SPA (Vue 3) \ Penghuni, Pemilik, Admin], [REST API (Laravel 11, Sanctum) \ token, peran, logika bisnis], [PostgreSQL 16 \ 12 tabel])))

Ada dua alasan memisahkan SPA dari API. Pertama, mata kuliah Pemrograman Web Lanjut meminta API yang dirancang dan dikonsumsi klien, bukan halaman yang dirender di server. Kedua, aturan seperti pemeriksaan bentrok reservasi cukup ditulis sekali di API, sehingga aplikasi ponsel di semester berikutnya bisa memakai API yang sama. SPA tidak pernah mengakses basis data langsung, dan API tidak menyimpan sesi karena identitas ada di token. Karena itu API bisa diuji sendiri lewat Postman tanpa SPA. Kami memilih token pribadi Sanctum karena sederhana, bisa diberi masa berlaku, dan tersimpan di tabel `token_akses`.

#sec("2.3", "Rancangan Basis Data", stage: st-proposal)
Rancangan basis data digambar sebagai PDM (_physical data model_) di @gbr-pdm. Ada 12 tabel PostgreSQL dalam empat kelompok: akses (`peran`, `pengguna`, `token_akses`), data kamar (`tipe_kamar`, `kamar`, `fasilitas`, `kamar_fasilitas`), hunian (`penghuni`, `reservasi`), dan keuangan (`tagihan`, `pembayaran`). Tabel `log_impor` menyimpan jejak setiap impor CSV oleh admin. Hanif menyelesaikan skema dan migrasinya di Minggu 6.

Hubungannya dibaca dari induk ke anak. Satu `peran` punya banyak `pengguna`, dan satu `pengguna` boleh punya banyak `token_akses` karena bisa login dari beberapa perangkat. Satu `penghuni` mengajukan banyak `reservasi`, dan satu `reservasi` menghasilkan satu `tagihan` per bulan. Hubungan banyak-ke-banyak antara kamar dan fasilitas dipecah oleh `kamar_fasilitas`. Kolom `dicatat_oleh` pada `pembayaran` (FK ke `pengguna`) tidak digambar supaya garis tidak saling memotong, tetapi tetap ada di kamus data.

#pdm-page("gbr-pdm", [PDM KOSKU: 12 tabel PostgreSQL dengan kolom, tipe, kunci (PK, FK, UQ), dan relasi `1` ke `N`],
  (
    pk("peran", 0, 0), pk("pengguna", 1, 0), pk("penghuni", 2, 0), pk("reservasi", 3, 0), pk("tagihan", 4, 0),
    pk("token_akses", 0, 1), pk("log_impor", 1, 1), pk("tipe_kamar", 2, 1), pk("kamar", 3, 1), pk("pembayaran", 4, 1),
    pk("fasilitas", 2, 2), pk("kamar_fasilitas", 3, 2),
  ),
  (
    (parent: "peran", child: "pengguna", fk: "peran_id", a: "1", b: "N"),
    (parent: "pengguna", child: "penghuni", fk: "pengguna_id", a: "1", b: "1"),
    (parent: "penghuni", child: "reservasi", fk: "penghuni_id", a: "1", b: "N"),
    (parent: "reservasi", child: "tagihan", fk: "reservasi_id", a: "1", b: "N"),
    (parent: "tagihan", child: "pembayaran", fk: "tagihan_id", a: "1", b: "N"),
    (parent: "pengguna", child: "token_akses", fk: "pengguna_id", a: "1", b: "N"),
    (parent: "pengguna", child: "log_impor", fk: "pengguna_id", a: "1", b: "N"),
    (parent: "tipe_kamar", child: "kamar", fk: "tipe_kamar_id", a: "1", b: "N"),
    (parent: "kamar", child: "reservasi", fk: "kamar_id", a: "1", b: "N"),
    (parent: "kamar", child: "kamar_fasilitas", fk: "kamar_id", a: "1", b: "N"),
    (parent: "fasilitas", child: "kamar_fasilitas", fk: "fasilitas_id", a: "1", b: "N"),
  ), cols: 5)

Kamus data ada di @tbl-kamus-1 (akses, log impor, penghuni) dan @tbl-kamus-2 (kamar, reservasi, keuangan), dengan tipe PostgreSQL 16. DDL yang sama ada di Lampiran G. Semua relasi didukung kunci asing sehingga basis data menolak data yatim, kolom `nomor` pada `kamar` dan `email` pada `pengguna` dibuat unik, dan kolom status dibatasi dengan `CHECK`. Satu aturan masih kami tunda: pasangan `reservasi_id` dan `periode` pada `tagihan` baru akan dibuat unik di Minggu 13, dan ketiadaan aturan itulah penyebab BUG-07.

#tabel("tbl-kamus-1", [Kamus data (1): akses, log impor, dan penghuni], tbl((1.35fr, 1.45fr, 1.05fr, 2fr, 1.9fr),
  ([Tabel], [Kolom], [Tipe], [Batasan], [Keterangan]),
  kamus-rows(("peran", "pengguna", "token_akses", "log_impor", "penghuni")), sz: 7.2pt))

#tabel("tbl-kamus-2", [Kamus data (2): kamar, reservasi, dan keuangan], tbl((1.35fr, 1.45fr, 1.05fr, 2fr, 1.9fr),
  ([Tabel], [Kolom], [Tipe], [Batasan], [Keterangan]),
  kamus-rows(("tipe_kamar", "kamar", "fasilitas", "kamar_fasilitas", "reservasi", "tagihan", "pembayaran")), sz: 7.2pt))

Soal normalisasi, rancangan awal kami menaruh tipe kamar dan fasilitas langsung di tabel `kamar`, bahkan sempat berupa satu kolom teks berisi fasilitas yang dipisah koma. Itu melanggar bentuk normal pertama karena satu sel memuat banyak nilai, jadi fasilitas kami pecah menjadi `fasilitas` dan `kamar_fasilitas`. Harga dasar dan luas yang bergantung pada tipe, bukan pada kamar, kami pindahkan ke `tipe_kamar` (bentuk normal ketiga). Data diri penghuni juga kami pisahkan dari `pengguna` ke `penghuni`, supaya akun admin dan pemilik tidak membawa kolom yang tidak mereka perlukan.

#sec("2.5", "Rancangan Antarmuka", stage: st-proposal)
Rancangan antarmuka dibuat Yoga di Figma dalam satu berkas berisi 6 halaman dan 34 _frame_ (ditautkan di Lampiran E). Halamannya Token Desain, Komponen, Penghuni, Pemilik, Admin, dan Prototipe Alur. Enam frame utama di @tbl-frame menjadi acuan saat membangun SPA, dan semuanya dirancang untuk komputer maupun ponsel karena penghuni lebih sering membuka lewat ponsel. Token desainnya sederhana: warna utama `#0F766E`, aksen `#F59E0B` untuk tunggakan dan peringatan, huruf Inter 14 px, jarak kelipatan 8 px, dan sudut 8 px. Nilai-nilai itu kami salin ke variabel CSS di SPA supaya tidak ada yang dikarang ulang di kode.

#tabel("tbl-frame", [Frame utama pada desain Figma], tbl((0.5fr, 1.8fr, 1fr, 2.6fr),
  ([No], [Frame], [Peran], [Fungsi]),
  (
    ([1], [Halaman masuk], [Semua], [Formulir email dan kata sandi, pesan galat dari API]),
    ([2], [Daftar kamar dan reservasi], [Penghuni], [Kartu kamar dengan filter status, tombol Ajukan]),
    ([3], [Tagihan saya], [Penghuni], [Daftar tagihan, status, dan riwayat pembayaran]),
    ([4], [Persetujuan reservasi], [Pemilik], [Daftar menunggu, tombol Setujui, Tolak, dan Check-in]),
    ([5], [Dasbor pemilik], [Pemilik], [Kartu okupansi, grafik pendapatan, daftar tunggakan]),
    ([6], [Pengelolaan kamar dan impor], [Admin], [Tabel kamar, formulir ubah, unggah CSV, laporan impor]),
  ), sz: 8pt))

Alur pengguna utama ada di @gbr-alur, dan empat layar terpenting digambar sebagai _wireframe_ di @gbr-wire. Alurnya berurutan: penghuni memilih kamar dan mengajukan reservasi, pemilik memutuskannya, lalu dasbor merangkum hasilnya.

#gambar("gbr-alur", [Alur pengguna utama: penghuni (atas) dan pemilik (bawah)], block(breakable: false, {
  flow(([Buka halaman masuk], [Lihat daftar kamar], [Pilih kamar dan tanggal], [Ajukan reservasi], [Lihat status dan tagihan]))
  v(0.5em)
  flow(([Buka daftar menunggu], [Setujui atau tolak], [Check-in penghuni], [Catat pembayaran], [Baca dasbor]))
}))

#gambar("gbr-wire", [Wireframe empat layar utama KOSKU pada versi web], grid(columns: (1fr, 1fr), column-gutter: 10pt, row-gutter: 10pt,
  wire("Daftar kamar dan reservasi (Penghuni)", (("bar", "Filter: status, tipe, harga", 0.5), ("card", "Kamar A-05, Standar, Rp 900.000", 0.8), ("card", "Kamar A-06, Dengan AC, Rp 1.200.000", 0.8), ("btn", "Ajukan reservasi", 0.5)), w: 6.9cm, h: 4.6cm, kind: "web"),
  wire("Persetujuan reservasi (Pemilik)", (("bar", "Reservasi menunggu (3)", 0.5), ("list", "Nama penghuni, kamar, tanggal masuk", 0.8), ("list", "Nama penghuni, kamar, tanggal masuk", 0.8), ("btn", "Setujui / Tolak", 0.5)), w: 6.9cm, h: 4.6cm, kind: "web"),
  wire("Dasbor pemilik", (("card", "Okupansi", 0.7), ("chart", "Pendapatan per bulan", 1.5), ("list", "Tunggakan: nama, jatuh tempo, jumlah", 0.8)), w: 6.9cm, h: 4.6cm, kind: "web"),
  wire("Pengelolaan kamar dan impor (Admin)", (("bar", "Tabel kamar: nomor, tipe, harga, status", 0.6), ("input", "Pilih berkas CSV", 0.5), ("btn", "Impor", 0.5), ("card", "Laporan: berhasil dan ditolak", 0.8)), w: 6.9cm, h: 4.6cm, kind: "web"),
))

Beberapa hal berubah dari wireframe ke layar akhir. Kalender kamar yang semula kami rencanakan diganti daftar kartu dengan filter, karena dengan 20 kamar daftar jauh lebih cepat dipindai dan lebih mudah dibuat responsif. Tombol Setujui dan Tolak pindah dari halaman detail ke baris daftar, sebab pemilik biasanya memutuskan beberapa reservasi sekaligus. Keadaan kosong (_empty state_) dan pesan galat dari API juga baru kami tambahkan setelah wireframe jadi.

#sec("2.6", "Rancangan Dasbor", stage: st-proposal)
Dasbor pemilik menjawab tiga pertanyaan yang paling sering diajukan pemilik: berapa persen kamar terisi (Q1), berapa pendapatan tiap bulan (Q2), dan siapa yang menunggak (Q3). Ketiganya dihitung dengan kueri SQL yang dijelaskan di Lampiran G, dijalankan setiap kali dasbor dibuka. Angka dihitung di basis data, bukan di SPA, supaya hasilnya sama di perangkat mana pun dan bisa dibandingkan dengan hitungan manual pemilik.

Pada pengujian Minggu 12, okupansi sama dengan hitungan manual, tetapi pendapatan di pergantian bulan masih salah karena batas bulan dihitung dengan zona waktu UTC (BUG-06). Sesuai masukan pemilik di Bab 4.5, daftar tunggakan akan dibuat bisa diurutkan. Dasbor ini juga menjadi bahan uji non-fungsional TC-18, yaitu waktu respons dengan 10.000 tagihan.

// =====================================================================
// BAB 3
// =====================================================================
#chapter("Bab 3", "Implementasi")
#lead[Bab ini memuat yang sudah berjalan sampai Minggu 12: API Laravel dengan token Sanctum, tiga peran, impor dan ekspor CSV, dan SPA Vue yang memanggil API itu. Dua bagian masih sebagian, yaitu tagihan otomatis dan pendapatan di pergantian bulan.]

#sec("3.1", "Teknologi yang Dipakai", stage: st-m2)
Pilihan teknologi mengikuti dua pertimbangan: cocok dengan mata kuliah Pemrograman Web Lanjut dan bisa dikuasai tim dalam 16 minggu. Laravel 11 kami pakai untuk REST API karena sudah menyediakan MVC, validasi, migrasi, dan middleware, dan Sanctum menangani token pribadi dengan masa berlaku. SPA memakai Vue 3.4 supaya komponennya bisa dipakai ulang dan memakai API yang sama. Data disimpan di PostgreSQL 16, yang kami pilih juga karena tipe `jsonb` cocok untuk laporan impor. Postman 10 kami pakai untuk dokumentasi API dan uji ulang, Git dan GitHub untuk versi dengan _tag_ `milestone-2`, serta Composer dan npm untuk paket.

Basis data lokal memakai PostgreSQL 16 yang sama dengan di server. Kami menyamakannya setelah BUG-05, ketika tanggal check-in bergeser sehari hanya karena komputer pengembang dan hosting memakai zona waktu yang berbeda.

#sec("3.2", "Cara Membuat Tiap Fitur", stage: st-m2)
Pada API dengan pola MVC, setiap permintaan melewati rute, middleware, controller, lalu model. Controller kami buat tipis: ia memanggil validasi, menjalankan aturan bisnis, dan mengembalikan resource JSON sebagai lapisan tampilan, sehingga kolom basis data tidak pernah bocor langsung ke klien. Delapan endpoint utama beserta kode status dan keadaannya ada di @tbl-endpoint, dan semuanya terdokumentasi di koleksi Postman (26 permintaan).

#tabel("tbl-endpoint", [Endpoint API, peran, kode status, dan status pengerjaan], tbl((1.9fr, 0.9fr, 1.9fr, 1.3fr),
  ([Endpoint], [Peran], [Kode status], [Pengerjaan]),
  (
    ([`POST /api/login`], [Semua], [200, 401, 422], [Berjalan]),
    ([`GET /api/kamar`], [Semua], [200, 401], [Berjalan]),
    ([`POST /api/reservasi`], [Penghuni], [201, 401, 403, 409, 422], [Berjalan]),
    ([`PATCH /api/reservasi/{id}`], [Pemilik], [200, 401, 403, 404, 422], [Berjalan]),
    ([`GET /api/tagihan`], [Penghuni, Pemilik], [200, 401, 403], [Sebagian (BUG-07)]),
    ([`GET /api/tagihan/ekspor`], [Pemilik], [200, 401, 403], [Berjalan]),
    ([`POST /api/kamar/impor`], [Admin], [200, 401, 403, 422], [Berjalan]),
    ([`GET /api/dasbor`], [Pemilik], [200, 401, 403], [Sebagian (BUG-06)]),
  ), sz: 8pt))

Aturan peran dipasang pada rute (@kode-rute). Rute di bawah `auth:sanctum` menolak permintaan tanpa token sah dengan kode 401, sedangkan middleware `peran` menolak peran yang tidak berhak dengan 403. Bagi klien bedanya jelas: 401 berarti login ulang, 403 berarti pengguna memang tidak boleh membuka sumber daya itu.

#kode("kode-rute", [Rute API dengan token Sanctum dan pembatasan peran (`routes/api.php`)],
```php
Route::post('/login', [AuthController::class, 'login']);

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/kamar', [KamarController::class, 'index']);
    Route::post('/reservasi', [ReservasiController::class, 'store'])
         ->middleware('peran:penghuni');
    Route::patch('/reservasi/{id}', [ReservasiController::class, 'putuskan'])
         ->middleware('peran:pemilik');
    Route::post('/kamar/impor', [KamarController::class, 'impor'])
         ->middleware('peran:admin');
    Route::get('/dasbor', DasborController::class)
         ->middleware('peran:pemilik');
});
```
)

Data masuk divalidasi dengan _form request_ sebelum menyentuh basis data. @kode-validasi memperlihatkan aturan pengajuan reservasi, termasuk pemeriksaan bahwa kamar belum dipesan pada tanggal yang sama. Pemeriksaan itu dijalankan di dalam transaksi dengan kunci baris, dan inilah perbaikan BUG-03: awalnya dua penghuni yang mengajukan kamar sama hampir bersamaan sama-sama lolos. Bila validasi gagal, API mengembalikan kode 422 dengan format galat seragam berisi `pesan` dan daftar `galat` per kolom, sehingga SPA cukup punya satu fungsi untuk menampilkannya. CRUD data kamar oleh admin memakai pola yang sama.

#kode("kode-validasi", [Aturan validasi dan pemeriksaan bentrok pada pengajuan reservasi],
```php
public function rules(): array
{
    return [
        'kamar_id'      => ['required', 'integer', 'exists:kamar,id'],
        'tanggal_masuk' => ['required', 'date', 'after_or_equal:today'],
    ];
}

// ReservasiController::store, di dalam DB::transaction
$kamar = Kamar::lockForUpdate()->findOrFail($data['kamar_id']);
if ($kamar->status !== 'kosong' || $kamar->reservasiBentrok($data['tanggal_masuk'])) {
    return response()->json(['pesan' => 'Kamar tidak tersedia'], 409);
}
```
)

Untuk impor, admin mengunggah CSV daftar kamar. API memeriksa tiap baris dengan aturan yang sama seperti form tambah kamar, yaitu nomor kamar unik dan harga angka positif, lalu menyimpan baris yang benar dan menolak yang salah (@kode-impor). Laporannya berisi jumlah baris masuk, jumlah ditolak, serta nomor baris dan alasannya, dan disimpan juga di `log_impor`. Ekspor berjalan sebaliknya: pemilik memilih satu bulan, lalu API menulis tagihan bulan itu sebagai CSV dengan kolom yang sama seperti tampilan tagihan di SPA, jadi bisa langsung dibuka di aplikasi lembar kerja.

#kode("kode-impor", [Impor CSV dengan validasi per baris dan laporan penolakan],
```php
foreach ($baris as $no => $data) {
    $v = Validator::make($data, [
        'nomor' => ['required', 'max:10', 'unique:kamar,nomor'],
        'harga' => ['required', 'numeric', 'gt:0'],
    ]);
    if ($v->fails()) {
        $ditolak[] = ['baris' => $no + 2, 'alasan' => $v->errors()->first()];
        continue;
    }
    Kamar::create($data);
    $masuk++;
}
LogImpor::create(compact('masuk', 'ditolak') + ['pengguna_id' => $admin->id]);
```
)

Di sisi klien, SPA memanggil API lewat satu modul kecil yang menambahkan token ke setiap permintaan dan menangani kode 401 (@kode-klien). Bila token kedaluwarsa, pengguna diarahkan ke halaman masuk, dan galat validasi ditampilkan di bawah kolom isian yang bersangkutan. Yoga sempat menaruh pengecekan token di setiap halaman sebelum memindahkannya ke modul ini di Minggu 10.

#kode("kode-klien", [Modul klien API pada SPA Vue (`src/api.js`)],
```js
export async function panggil(path, opsi = {}) {
  const token = localStorage.getItem('token')
  const res = await fetch(import.meta.env.VITE_API_URL + path, {
    ...opsi,
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
  })
  if (res.status === 401) { window.location.href = '/masuk'; return }
  const isi = await res.json()
  if (!res.ok) throw isi
  return isi
}
```
)

#sec("3.3", "Basis Data", stage: st-m2)
Skema dibuat lewat migrasi Laravel yang mengikuti PDM di @gbr-pdm, sehingga setiap anggota bisa membangun ulang basis data dengan satu perintah. _Seeder_ mengisi data uji berupa 20 kamar, 12 penghuni, 40 reservasi, dan enam bulan tagihan. Untuk uji kinerja kami menambahkan generator yang membuat 10.000 tagihan, supaya waktu respons dasbor bisa diukur.

Sebagian besar akses data memakai Eloquent. Tiga kueri dasbor kami tulis sebagai SQL mentah karena fungsi agregatnya lebih jelas dibaca langsung. Ketiganya dibahas di Lampiran G bersama skema, indeks, dan hasil `EXPLAIN ANALYZE`, sedangkan rancangan dan kamus data lengkap tetap di Bab 2.3.

#sec("3.5", "Penyambungan antar Bagian dan Deploy", stage: st-m2)
SPA dan API di-_deploy_ terpisah ke hosting gratis (alamat di Lampiran E). SPA membaca alamat API dari variabel lingkungan `VITE_API_URL`, dan API hanya membuka CORS untuk alamat SPA sehingga situs lain tidak bisa memanggilnya dari peramban. PostgreSQL berjalan sebagai basis data terkelola paket gratis yang hanya bisa diakses dari API.

Hosting gratis kadang lambat saat pertama diakses, jadi kami menyiapkan video cadangan empat menit dan memeriksa akses sehari sebelum demo (risiko di Bab 5.3). Koleksi Postman berisi 26 permintaan dengan 58 pernyataan uji, dan koleksi itulah dokumentasi API yang kami serahkan ke Dosen Web Lanjut.

// =====================================================================
// BAB 4
// =====================================================================
#chapter("Bab 4", "Pengujian dan Evaluasi")
#lead[Dari 18 kasus uji, 16 lulus dan 2 gagal. Selama Minggu 9–12 kami mencatat 6 bug, memperbaiki 4, dan menyisakan 2 yang tingkatnya tinggi dan sedang.]

#sec("4.1", "Rencana Pengujian", stage: st-m2)
Nabila menulis rencana uji pada Minggu 9 (Rencana Uji versi 1.0) dan memperbaruinya tiap minggu. Fokusnya alur utama dari login sampai dasbor, ditambah satu uji non-fungsional untuk waktu respons dasbor. Uji manual fungsional berjalan di Chrome dan ponsel Android pada Minggu 9–12. Uji API dan otorisasi memakai koleksi Postman pada Minggu 10–12, yaitu kode status, akses tanpa token, dan akses dengan peran yang salah. Uji impor dan ekspor memakai berkas CSV dengan baris sengaja salah di Minggu 12, dan uji waktu respons memakai 10.000 tagihan dengan Postman dan `EXPLAIN ANALYZE`.

Setiap bug yang diperbaiki memicu uji regresi pada kasus uji terkait, dan hasilnya dicatat di Bab 4.3. Hasil uji awal dirangkum di Laporan QA Interim versi 1.0 (Lampiran E). Data uji memakai basis data yang sama dengan Bab 3.3 supaya anggota lain bisa mengulang hasilnya.

#sec("4.2", "Kasus Uji dan Hasil", stage: st-m2)
Dari 18 kasus uji yang kami jalankan, 16 lulus dan 2 gagal, yaitu TC-09 (karena BUG-07) dan TC-13 (karena BUG-06). Kasus-kasus itu disusun dari kasus penggunaan dan kebutuhan di @tbl-srs, dan hasilnya ada di @tbl-uji. Keduanya yang gagal menyangkut angka keuangan, bukan keamanan atau alur reservasi, sesuai posisi K2 dan K3 di Bab 1.5.

#tabel("tbl-uji", [Kasus uji dan hasil sampai Minggu 12], tbl((0.6fr, 1.4fr, 1.8fr, 1.3fr, 1.2fr, 1fr),
  ([ID], [Skenario], [Langkah singkat], [Hasil diharapkan], [Hasil aktual], [Status]),
  (
    ([TC-01], [Login pemilik], [POST login dengan akun pemilik], [Token diterima, masuk dasbor], [Token diterima dan dasbor terbuka], [Lulus]),
    ([TC-02], [Login penghuni], [POST login dengan akun penghuni], [Masuk ke daftar kamar], [Daftar kamar terbuka], [Lulus]),
    ([TC-03], [Login admin], [POST login dengan akun admin], [Masuk ke pengelolaan kamar], [Halaman pengelolaan terbuka], [Lulus]),
    ([TC-04], [Token berumur 2 jam], [Pakai token berumur 3 jam untuk GET kamar], [Ditolak, diarahkan ke login], [Ditolak dan diarahkan ke login], [Lulus]),
    ([TC-05], [Reservasi kamar kosong], [Penghuni memilih kamar 5, lalu mengajukan], [Reservasi tersimpan], [Reservasi tersimpan berstatus menunggu], [Lulus]),
    ([TC-06], [Kamar yang sudah dipesan], [Ajukan kamar 5 pada tanggal yang terisi], [Ditolak dengan kode 409], [Ditolak dengan kode 409], [Lulus]),
    ([TC-07], [Pemilik menyetujui], [PATCH reservasi dengan status disetujui], [Status menjadi disetujui], [Status berubah menjadi disetujui], [Lulus]),
    ([TC-08], [Check-in], [Pemilik menekan Check-in], [Kamar menjadi terisi], [Status kamar menjadi terisi], [Lulus]),
    ([TC-09], [Tagihan bulanan otomatis], [Jalankan penagihan bulan ini], [Satu tagihan per penghuni], [Dua tagihan untuk satu penghuni], [Gagal (BUG-07)]),
    ([TC-10], [Penghuni melihat tagihan], [Buka menu Tagihan], [Daftar tagihan sendiri tampil], [Daftar tagihan sendiri tampil], [Lulus]),
    ([TC-11], [Pencatatan pembayaran], [Pemilik mencatat pembayaran penuh], [Tagihan menjadi lunas], [Status tagihan menjadi lunas], [Lulus]),
    ([TC-12], [Okupansi di dasbor], [Buka dasbor, bandingkan hitungan manual], [Sama dengan hitungan manual], [Angka okupansi sama], [Lulus]),
    ([TC-13], [Pendapatan saat bulan berganti], [Catat pembayaran 31 Okt dan 1 Nov, buka dasbor], [Dipisah per bulan], [Pendapatan tergabung di satu bulan], [Gagal (BUG-06)]),
    ([TC-14], [Penghuni membuka dasbor pemilik], [Buka dasbor dengan token penghuni], [Ditolak dengan kode 403], [Ditolak dengan kode 403], [Lulus]),
    ([TC-15], [Akses API tanpa token], [GET kamar tanpa token], [Ditolak dengan kode 401], [Ditolak dengan kode 401], [Lulus]),
    ([TC-16], [Impor kamar dari CSV], [Unggah CSV 20 baris dengan 2 baris salah], [18 masuk, 2 ditolak dengan alasan], [18 baris masuk dan 2 ditolak dengan alasan], [Lulus]),
    ([TC-17], [Ekspor tagihan], [Pemilik mengekspor tagihan Oktober], [CSV berisi semua tagihan bulan itu], [Isi CSV sesuai tampilan tagihan], [Lulus]),
    ([TC-18], [Waktu respons dasbor (non-fungsional)], [GET dasbor dengan 10.000 tagihan], [Di bawah 500 ms], [Respons sekitar 120 ms], [Lulus]),
  ), sz: 7.2pt))

Ketertelusuran kebutuhan ke kasus uji ada di @tbl-trace, dan dari situ kami melihat kebutuhan mana yang belum diuji. FR-12 belum dibangun jadi belum punya kasus uji, sedangkan NFR-03 diperiksa lewat koleksi Postman, bukan kasus uji tersendiri.

#tabel("tbl-trace", [Ketertelusuran kebutuhan SRS ke kasus uji], tbl((1fr, 1.2fr, 1.1fr),
  ([Kebutuhan], [Kasus uji], [Hasil]),
  (
    ([FR-01, NFR-02], [TC-01 sampai TC-04], [Lulus semua]),
    ([FR-02], [TC-14, TC-15], [Lulus semua]),
    ([FR-03, FR-09], [TC-16], [Lulus]),
    ([FR-04], [TC-05, TC-06], [Lulus semua]),
    ([FR-05, FR-06], [TC-07, TC-08], [Lulus semua]),
    ([FR-07], [TC-09, TC-10], [TC-09 gagal (BUG-07)]),
    ([FR-08], [TC-11], [Lulus]),
    ([FR-10], [TC-17], [Lulus]),
    ([FR-11], [TC-12, TC-13], [TC-13 gagal (BUG-06)]),
    ([NFR-01], [TC-18], [Lulus]),
    ([NFR-04], [Uji pengguna (Bab 4.5)], [Terpenuhi]),
  ), sz: 8pt))

#sec("4.3", "Bug yang Ditemukan", stage: st-m2)
Kami mencatat enam bug dalam catatan bug versi 1.0, bernomor BUG-03 sampai BUG-08 karena BUG-01 dan BUG-02 sudah ditutup pada Milestone 1. Setiap catatan memuat langkah reproduksi, tingkat keparahan, status, dan rencana perbaikan (@tbl-bug). Dua yang masih terbuka, BUG-07 (tinggi) dan BUG-06 (sedang), terjadwal di Minggu 13.

#tabel("tbl-bug", [Catatan bug sampai Minggu 12], tbl((0.7fr, 3.1fr, 0.8fr, 1fr, 1.5fr),
  ([ID], [Deskripsi dan langkah reproduksi], [Tingkat], [Status], [Rencana dan regresi]),
  (
    ([BUG-03], [Dua reservasi untuk kamar yang sama pada tanggal yang sama. Langkah: dua penghuni mengajukan kamar 5 pada tanggal yang sama hampir bersamaan], [Tinggi], [Diperbaiki Minggu 10], [Kunci baris dalam transaksi. Regresi TC-05 sampai TC-08 lulus]),
    ([BUG-04], [Token tidak kedaluwarsa. Langkah: pakai token berumur 3 jam untuk GET kamar], [Tinggi], [Diperbaiki Minggu 10], [Masa berlaku diterapkan. TC-04 lulus]),
    ([BUG-05], [Tanggal check-in bergeser sehari. Langkah: pilih 1 Desember, simpan, lalu lihat tanggalnya], [Sedang], [Diperbaiki Minggu 11], [Zona waktu disamakan. Uji tanggal ditambah]),
    ([BUG-06], [Pendapatan pada pergantian bulan tergabung. Langkah: catat pembayaran 31 Okt dan 1 Nov, lalu buka dasbor], [Sedang], [Terbuka], [Minggu 13: potong bulan dengan zona waktu lokal. Uji ulang TC-13]),
    ([BUG-07], [Tagihan bulanan dibuat dua kali. Langkah: jalankan penagihan dua kali pada bulan yang sama], [Tinggi], [Terbuka], [Minggu 13: kunci unik per bulan. Uji ulang TC-09]),
    ([BUG-08], [Label status reservasi tidak tampil. Langkah: buka daftar reservasi penghuni], [Rendah], [Diperbaiki Minggu 11], [Label ditambahkan. Tidak perlu regresi lain]),
  ), sz: 7.6pt))

Catatan regresi menjadi kebiasaan sejak Dosen Penjaminan Mutu memintanya di Minggu 10 (Bab 5.3). Setelah BUG-03 diperbaiki kami menjalankan ulang TC-05 sampai TC-08 dan semuanya lulus, dan setelah BUG-04 diperbaiki TC-04 dijalankan ulang dengan hasil yang sama. Polanya juga memberi pelajaran: tiga dari enam bug berkaitan dengan waktu atau kebersamaan, yaitu dua permintaan hampir serentak, zona waktu, dan penjadwal yang berjalan dua kali. Pengujian berikutnya kami arahkan ke dua hal itu.

#sec("4.5", "Masukan Pengguna", stage: st-m2)
Pada Minggu 12 pemilik kos mencoba dasbor langsung, dan tiga penghuni mencoba alur reservasi tanpa bantuan kami. Ketiganya menyelesaikan reservasi sendiri dari awal sampai akhir, sehingga NFR-04 terpenuhi. Pemilik langsung memakai kartu okupansi, tetapi ia berhenti agak lama di daftar tunggakan. Masukan lainnya dirangkum di @tbl-masukan beserta tindak lanjutnya.

#kutipan[Kalau tunggakan bisa diurutkan dari yang paling lama, saya tidak perlu buka buku lagi.][Pemilik kos mitra, saat mencoba dasbor di Minggu 12]

#tabel("tbl-masukan", [Masukan pengguna dan tindak lanjut], tbl((1.1fr, 2.7fr, 2fr),
  ([Dari], [Masukan], [Tindak lanjut]),
  (
    ([Pemilik kos], [Daftar tunggakan perlu bisa diurutkan menurut jatuh tempo atau jumlah], [Masuk rencana Minggu 14 (Bab 5.3)]),
    ([Pemilik kos], [Perlu penanda kamar yang akan kosong bulan depan], [Dicatat, dikerjakan bila waktu cukup]),
    ([Penghuni (2 dari 3)], [Riwayat pembayaran sudah ada, tetapi menunya kurang jelas], [Menu diganti nama menjadi Riwayat Pembayaran]),
    ([Penghuni (3 dari 3)], [Reservasi dapat diselesaikan tanpa bantuan], [Tidak ada tindak lanjut]),
  ), sz: 8pt))

Dua permintaan pemilik tidak termasuk cakupan awal, jadi keduanya lewat proses perubahan di Governance Log sebelum masuk rencana. Penggantian nama menu dari penghuni kami kerjakan langsung karena ringan dan tidak memengaruhi jadwal.

#sec("4.6", "Ketercapaian Kriteria Keberhasilan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: bandingkan hasil akhir dengan kriteria K1–K6 di Bab 1.5. Pada Milestone 2, cukup tulis judulnya.]

// =====================================================================
// BAB 5
// =====================================================================
#chapter("Bab 5", "Pengelolaan Proyek dan Penutup")
#lead[Bab ini mencatat jadwal yang mundur, risiko yang jadi kenyataan, dan perubahan yang disetujui. Jadwal mundur sekitar satu minggu, dan pemulihannya bertumpu pada satu orang yang fokus pada BUG-07.]

#sec("5.1", "Rencana dan Realisasi", stage: st-lanjutan)
Rincian pekerjaan (_work breakdown structure_, WBS) kami susun tiga tingkat pada Minggu 3 dan simpan di dokumen WBS dan Jadwal versi 1.3. Tingkat ketiganya berupa tugas yang bisa dikerjakan satu orang dalam satu sampai tiga minggu. Rencana dan realisasi sampai Minggu 12 ada di @tbl-wbs, dan jadwal yang sama digambar sebagai diagram Gantt di @gbr-gantt.

#tabel("tbl-wbs", [WBS tiga tingkat dengan rencana dan realisasi sampai Minggu 12], tbl((0.6fr, 2.5fr, 0.9fr, 0.9fr, 1.2fr, 1.1fr),
  ([Kode], [Tugas], [PJ], [Rencana], [Realisasi], [Selisih]),
  (
    ([1], [Platform API], [], [], [], []),
    ([1.1], [Basis data], [], [], [], []),
    ([1.1.1], [Skema basis data dan migrasi], [Hanif], [Minggu 5–6], [Selesai Minggu 6], [0]),
    ([1.2], [Autentikasi dan peran], [], [], [], []),
    ([1.2.1], [API autentikasi dengan token], [Hanif], [Minggu 6–7], [Selesai Minggu 7], [0]),
    ([1.2.2], [Aturan peran (middleware)], [Hanif], [Minggu 7–8], [Selesai Minggu 8], [0]),
    ([2], [Fitur bisnis], [], [], [], []),
    ([2.1.1], [SPA: login dan daftar kamar], [Yoga], [Minggu 7–9], [Selesai Minggu 10], [+1 minggu (sakit)]),
    ([2.1.2], [SPA: reservasi dan persetujuan], [Hanif, Yoga], [Minggu 9–10], [Selesai Minggu 11], [+1 minggu]),
    ([2.2.1], [Tagihan bulanan otomatis], [Hanif], [Minggu 10–11], [Belum stabil], [+2 minggu]),
    ([2.2.2], [Impor kamar dan ekspor tagihan], [Hanif], [Minggu 11–12], [Selesai Minggu 12], [0]),
    ([2.3.1], [Kueri dasbor], [Nabila], [Minggu 11], [Selesai Minggu 11], [0]),
    ([2.3.2], [Dasbor okupansi dan pendapatan], [Nabila], [Minggu 11–12], [Sebagian], [+1 minggu]),
    ([3], [Mutu], [], [], [], []),
    ([3.1.1], [Rencana uji], [Nabila], [Minggu 9], [Selesai Minggu 9], [0]),
    ([3.1.2], [Eksekusi uji dan catatan bug], [Nabila], [Minggu 9–12], [Selesai Minggu 12], [0]),
    ([3.2.1], [Perbaikan BUG-06 dan BUG-07 serta regresi], [Hanif, Nabila], [Minggu 13–14], [Belum dimulai], [–]),
    ([4], [Penutupan], [], [], [], []),
    ([4.1.1], [Notifikasi jatuh tempo (bila waktu cukup)], [Yoga], [Minggu 14], [Belum dimulai], [–]),
    ([4.1.2], [Laporan akhir dan materi demo], [Seluruh tim], [Minggu 15–16], [Belum dimulai], [–]),
  ), sz: 7.4pt))

Tujuh dari sebelas tugas yang jatuh tempo sampai Minggu 12 selesai sesuai rencana, dan empat terlambat satu sampai dua minggu. Semuanya berawal dari tugas 2.1.1: Yoga sakit di Minggu 8–9, lalu keterlambatan merambat sepanjang jalur kritis 2.1.1, 2.1.2, 2.2.1, dan 2.3.2.

#gambar("gbr-gantt", [Diagram Gantt rencana dan realisasi sampai Minggu 12, dengan proyeksi sampai Minggu 16], gantt((
  ("1.1.1", "Skema basis data dan migrasi", (5, 6), (5, 6)),
  ("1.2", "Autentikasi token dan aturan peran", (6, 8), (6, 8)),
  ("2.1.1", "SPA: login dan daftar kamar", (7, 9), (7, 10)),
  ("2.1.2", "SPA: reservasi dan persetujuan", (9, 10), (10, 11)),
  ("2.2.1", "Tagihan bulanan otomatis", (10, 11), (10, 13)),
  ("2.2.2", "Impor kamar dan ekspor tagihan", (11, 12), (11, 12)),
  ("2.3.1", "Kueri dasbor", (11, 11), (11, 11)),
  ("2.3.2", "Dasbor okupansi dan pendapatan", (11, 12), (11, 13)),
  ("3.1.1", "Rencana uji", (9, 9), (9, 9)),
  ("3.1.2", "Eksekusi uji dan catatan bug", (9, 12), (9, 12)),
  ("3.2.1", "Perbaikan bug dan regresi", (13, 14), none),
  ("4.1.1", "Notifikasi jatuh tempo", (14, 14), none),
  ("4.1.2", "Laporan akhir dan demo", (15, 16), none),
), now: 12))

Selisih terbesar ada di tugas 2.2.1, dua minggu, karena tagihan otomatis bergantung pada reservasi yang sudah disetujui sehingga baru bisa diuji penuh setelah 2.1.2 selesai, dan setelah itu muncul BUG-07. Batang yang melewati garis Minggu 12 adalah proyeksi. Untuk memulihkan jadwal kami menempuh tiga langkah: menunda notifikasi jatuh tempo (P-1), membatasi uji otomatis pada aturan peran (P-3), dan memberi Hanif satu minggu penuh untuk BUG-07 tanpa tugas lain.

#sec("5.2", "Kontribusi Anggota", stage: st-lanjutan)
Estimasi kontribusi dan buktinya ada di @tbl-kontribusi: _commit_ di repositori, tugas di WBS, berkas dokumen, dan bagian yang dibawakan tiap anggota saat demo. Karena tabel ini kami tulis sendiri, ia belum cukup untuk membuktikan pembagiannya adil. Itu sebabnya setiap anggota juga mengisi Penilaian 360 lewat Google Form secara terpisah pada Minggu 11 sampai 12.

#tabel("tbl-kontribusi", [Kontribusi anggota sampai Minggu 12], tbl((1.3fr, 2.2fr, 1.7fr, 0.8fr, 1.4fr),
  ([Nama], [Tugas selesai], [Bukti], [Estimasi], [Bagian saat demo]),
  (
    ([Hanif Ramadhan], [API, autentikasi, tagihan, impor dan ekspor], [38 _commit_, WBS 1.1 sampai 2.2], [30%], [Alur reservasi di API]),
    ([Selvi Oktaviani], [Jadwal, risiko, Governance Log, dokumentasi], [Bab 5, logbook, Project Charter], [20%], [Pengelolaan proyek]),
    ([Yoga Prasetya], [SPA dan antarmuka, desain Figma], [27 _commit_, WBS 2.1, berkas Figma], [25%], [Alur penghuni di SPA]),
    ([Nabila Khairunnisa], [Pengujian, kueri, dan dasbor], [Bab 4, koleksi Postman, Lampiran G], [25%], [Hasil uji dan dasbor]),
  ), sz: 8pt))

Hanif memegang bagian terbesar karena API menjadi dasar hampir semua fitur lain. Selvi mengerjakan hal yang jarang meninggalkan _commit_ tetapi menentukan arah proyek, yaitu jadwal, risiko, dan catatan perubahan. Nabila mengambil tugas dasbor sejak Minggu 11 untuk meringankan Yoga yang baru pulih, dan itu tercatat sebagai P-2. Logbook di Lampiran B mencatat siapa mengerjakan apa tiap minggu, dan angka estimasi adalah hasil pembicaraan tim.

Setiap anggota menyiapkan satu bagian demo dan siap menjawab soal bagian lain. Form Penilaian 360 diisi tanpa dilihat rekan satu tim. Koordinator membandingkan rata-rata poinnya dengan estimasi di @tbl-kontribusi, lalu mengirim rekapnya ke dosen pengampu. Hasil form tidak ditulis di laporan ini.

#sec("5.3", "Perubahan, Risiko, dan Permintaan Tambahan", stage: st-lanjutan)
Perubahan yang memengaruhi cakupan, jadwal, atau peran dicatat di Governance Log versi 1.4 dan baru berlaku setelah disetujui, lengkap dengan tanggalnya. Sejak Milestone 1 ada tiga perubahan (@tbl-perubahan). Selain itu ada satu permintaan tambahan dari Dosen Penjaminan Mutu pada Minggu 10, yaitu mencatat kasus uji regresi pada setiap bug. Permintaan itu disepakati dengan Dosen Rujukan SIB-3C, sudah dikerjakan, dan hasilnya ada di Bab 4.3.

#tabel("tbl-perubahan", [Catatan perubahan (Governance Log) dengan persetujuan], tbl((0.5fr, 1.6fr, 1.8fr, 1.1fr, 1.5fr),
  ([ID], [Perubahan], [Alasan], [Dampak jadwal], [Persetujuan]),
  (
    ([P-1], [Notifikasi jatuh tempo ditunda ke laporan akhir], [Jadwal mundur dan tagihan lebih penting], [Mengurangi beban 1 minggu], [Dosen Rujukan SIB-3C, Minggu 10]),
    ([P-2], [Dasbor dikerjakan Nabila, bukan Yoga], [Yoga baru pulih dari sakit], [Netral], [Ketua tim, Minggu 11]),
    ([P-3], [Uji otomatis dibatasi pada aturan peran], [Waktu uji terbatas], [Mengurangi beban 0,5 minggu], [Dosen Penjaminan Mutu, Minggu 11]),
  ), sz: 8pt))

Daftar risiko versi 1.2 ditinjau tiap pekan. Skornya kemungkinan dikali dampak, masing-masing skala 1 sampai 5, jadi skor tertinggi 25. @tbl-risiko memuat lima risiko terbesar untuk Minggu 13–16. BUG-07 sebenarnya sudah menjadi masalah nyata, tetapi tetap kami nilai karena belum teratasi, dan skornya, 15, menentukan prioritas Minggu 13.

#tabel("tbl-risiko", [Daftar risiko Minggu 13–16 (skor = kemungkinan × dampak)], tbl((1.9fr, 1.15fr, 0.85fr, 0.6fr, 2.2fr),
  ([Risiko], [Kemungkinan], [Dampak], [Skor], [Tindakan]),
  (
    ([BUG-07 tidak selesai pada Minggu 13], [3], [5], [15], [Kunci unik per bulan, Hanif fokus penuh satu minggu]),
    ([Hosting gratis tidak stabil saat demo], [3], [3], [9], [Video cadangan dan uji akses sehari sebelum demo]),
    ([Beban ujian mata kuliah lain pada Minggu 14], [3], [3], [9], [Kegiatan Minggu 14 dibatasi pada regresi dan perbaikan]),
    ([Anggota sakit lagi], [2], [4], [8], [Dua anggota menguasai tiap modul]),
    ([Dasbor salah hitung pada data besar], [2], [4], [8], [Uji kueri dengan data 10.000 baris (Lampiran G)]),
  ), sz: 8pt))

Aturan kerja tim ada di Project Charter: rapat tiap Senin 30 menit untuk jadwal dan risiko, setiap perubahan kode lewat _pull request_ yang ditinjau satu anggota lain, dan anggota yang berhalangan memberi kabar sehari sebelumnya.

#sec("5.4", "Kesimpulan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang berhasil dibangun, dan apakah rumusan masalah di Bab 1.1 terjawab.]

#sec("5.5", "Pelajaran dan Saran", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang dipelajari tim, apa yang akan dilakukan berbeda, dan saran pengembangan berikutnya.]

#pagebreak()

// =====================================================================
// LAMPIRAN
// =====================================================================
#part("Lampiran", "Lampiran A–H")
Lampiran F (model ML) hanya untuk tim TI Semester 5, jadi tidak ada di contoh ini.
#v(0.6em)

#lamp("A", "Tangkapan Layar", stage: st-m2)
Dua tangkapan layar dari aplikasi yang berjalan: layar penghuni saat mengajukan reservasi (@gbr-ss-reservasi) dan dasbor pemilik dengan data nyata (@gbr-ss-dasbor).

#shot("gbr-ss-reservasi", [Reservasi kamar oleh penghuni], ht: 5.5cm)
#shot("gbr-ss-dasbor", [Dasbor okupansi dan pendapatan pemilik], ht: 5.5cm)

#pagebreak()
#lamp("B", "Logbook", stage: st-lanjutan)
Logbook Minggu 1–8 dipindahkan dari Laporan Kemajuan, dan @tbl-logbook menambahkan Minggu 9–12 beserta siapa mengerjakan apa.

#tabel("tbl-logbook", [Logbook Minggu 9–12], tbl((0.6fr, 2.2fr, 1.2fr, 1.6fr, 1.6fr),
  ([Minggu], [Pekerjaan selesai], [Dikerjakan oleh], [Kendala], [Rencana berikutnya]),
  (
    ([9], [SPA daftar kamar dan rencana uji], [Yoga, Nabila], [Yoga baru pulih dari sakit], [Reservasi]),
    ([10], [Reservasi, BUG-03 dan BUG-04 diperbaiki], [Hanif, Yoga], [Reservasi ganda], [Tagihan]),
    ([11], [Persetujuan, check-in, BUG-05 dan BUG-08 diperbaiki, kueri dasbor], [Hanif, Yoga, Nabila], [Zona waktu], [Dasbor]),
    ([12], [Impor dan ekspor CSV, 18 kasus uji, dasbor awal], [Hanif, Nabila], [BUG-06 dan BUG-07], [Perbaikan bug]),
  ), sz: 8pt))

#pagebreak()
#lamp("C", "Dokumen Rujukan", stage: st-m2)
Dokumen kerja tim yang dirujuk laporan ini terdaftar di @tbl-rujukan, lengkap dengan versi, pemilik, dan bagian yang merujuknya. Tautannya ada di Lampiran E. Dokumen-dokumen ini kami buat untuk tiga mata kuliah dan hanya diringkas di bab yang bersangkutan.

#tabel("tbl-rujukan", [Dokumen rujukan tim], tbl((0.4fr, 2fr, 0.6fr, 1.1fr, 1.3fr, 2fr),
  ([No], [Dokumen], [Versi], [Pemilik], [Bagian yang merujuk], [Keterangan]),
  (
    ([1], [SRS (spesifikasi kebutuhan perangkat lunak)], [1.2], [Selvi], [Bab 2.1, Bab 4.2], [Kebutuhan FR dan NFR beserta prioritas]),
    ([2], [Desain Figma (wireframe dan prototipe)], [1.0], [Yoga], [Bab 2.5], [6 halaman, 34 frame, token desain]),
    ([3], [Koleksi Postman (dokumentasi API)], [1.3], [Nabila], [Bab 3.2, Bab 4.1], [26 permintaan dan 58 pernyataan uji]),
    ([4], [Project Charter dan Stakeholder Register], [1.1], [Selvi], [Bab 1.3, Bab 1.4], [Tujuan, cakupan, dan pemangku kepentingan]),
    ([5], [Governance Log (catatan perubahan)], [1.4], [Selvi], [Bab 5.3], [Perubahan P-1 sampai P-3 dengan persetujuan]),
    ([6], [Daftar risiko], [1.2], [Selvi], [Bab 5.3], [Skor kemungkinan × dampak]),
    ([7], [WBS dan Gantt], [1.3], [Selvi], [Bab 5.1], [Rincian tiga tingkat dan jadwal]),
    ([8], [PDM dan kamus data], [1.2], [Hanif], [Bab 2.3, Lampiran G], [12 tabel PostgreSQL]),
    ([9], [Rencana uji, kasus uji, dan catatan bug], [1.0], [Nabila], [Bab 4.1 sampai 4.3], [18 kasus uji dan 6 bug]),
    ([10], [Laporan QA Interim], [1.0], [Nabila], [Bab 4], [Ringkasan hasil uji awal]),
  ), sz: 7.6pt))

#pagebreak()
#lamp("D", "Dokumen Tambahan dari Dosen", stage: st-m2)
Tidak ada dokumen tambahan. Sampai SOP diterbitkan, tidak ada dosen yang mengumumkan dokumen tambahan secara tertulis. Bila ada, setiap dokumen menjadi satu sub-lampiran (D.1, D.2, dan seterusnya) dan tidak mengulang isi laporan, sesuai SOP Bagian 7.

#pagebreak()
#lamp("E", "Daftar Tautan Eksternal", stage: st-m2)
@tbl-tautan mendaftar semua tautan eksternal di laporan, termasuk tautan tiap dokumen pada Lampiran C. Semua tautan sudah kami uji di mode incognito.

#tabel("tbl-tautan", [Daftar tautan eksternal], tbl((0.4fr, 2.2fr, 1.4fr, 2.6fr, 1.4fr),
  ([No], [Keterangan], [Bagian], [Tautan], [Jenis akses]),
  (
    ([1], [Repositori (_tag_ milestone-2)], [S.5], [`github.com/contoh/kosku`], [Publik]),
    ([2], [Aplikasi KOSKU], [S.5, Bab 3.5], [`kosku-contoh.example.com`], [Publik]),
    ([3], [SRS versi 1.2], [Lampiran C, Bab 2.1], [`docs.example.com/kosku/srs`], [Siapa saja yang memiliki link]),
    ([4], [Desain Figma versi 1.0], [Lampiran C, Bab 2.5], [`figma.example.com/kosku`], [Siapa saja yang memiliki link]),
    ([5], [Koleksi Postman versi 1.3], [Lampiran C, Bab 3.2], [`postman.example.com/kosku`], [Siapa saja yang memiliki link]),
    ([6], [Project Charter dan Stakeholder Register], [Lampiran C, Bab 1.4], [`docs.example.com/kosku/charter`], [Siapa saja yang memiliki link]),
    ([7], [Governance Log], [Lampiran C, Bab 5.3], [`docs.example.com/kosku/governance`], [Siapa saja yang memiliki link]),
    ([8], [Daftar risiko], [Lampiran C, Bab 5.3], [`docs.example.com/kosku/risiko`], [Siapa saja yang memiliki link]),
    ([9], [WBS dan Gantt versi 1.3], [Lampiran C, Bab 5.1], [`docs.example.com/kosku/wbs`], [Siapa saja yang memiliki link]),
    ([10], [PDM dan kamus data], [Lampiran C, Bab 2.3], [`docs.example.com/kosku/pdm`], [Siapa saja yang memiliki link]),
    ([11], [Rencana uji, kasus uji, dan catatan bug], [Lampiran C, Bab 4], [`docs.example.com/kosku/uji`], [Siapa saja yang memiliki link]),
    ([12], [Laporan QA Interim], [Lampiran C, Bab 4], [`docs.example.com/kosku/qa`], [Siapa saja yang memiliki link]),
  ), sz: 7.6pt))

Nama berkas yang dikumpulkan adalah `M2_SIB-3C_TimKosNyaman.pdf`.

#pagebreak()
#lamp("G", "Dokumentasi Kueri Basis Data", stage: st-m2)
SIB Semester 5 tidak punya mata kuliah basis data, jadi lampiran ini opsional dan kami tulis ringkas: skema dan indeks (G.1), tiga kueri dasbor (G.2), dan satu pengujian dengan `EXPLAIN ANALYZE` (G.3). Kamus data dan PDM lengkap tetap di Bab 2.3. Lampiran ini hanya memuat DDL tujuh tabel yang dipakai alur utama dan kueri dasbor; lima tabel lain (`peran`, `token_akses`, `fasilitas`, `kamar_fasilitas`, `log_impor`) dibuat migrasi dengan kolom seperti di @tbl-kamus-1 dan @tbl-kamus-2.

G.1 Skema dan indeks (PostgreSQL 16): @kode-ddl memuat DDL tabel utama dan indeks yang kami tambahkan setelah pengujian di G.3.

#kode("kode-ddl", [DDL tabel utama dan indeks],
```sql
CREATE TABLE pengguna (
  id SERIAL PRIMARY KEY, peran_id INT NOT NULL REFERENCES peran(id),
  nama VARCHAR(100) NOT NULL, email VARCHAR(120) NOT NULL UNIQUE,
  kata_sandi VARCHAR(255) NOT NULL, aktif BOOLEAN NOT NULL DEFAULT TRUE,
  dibuat_pada TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE tipe_kamar (
  id SERIAL PRIMARY KEY, nama VARCHAR(40) NOT NULL UNIQUE,
  harga_dasar NUMERIC(10,2) NOT NULL CHECK (harga_dasar > 0), luas_m2 NUMERIC(4,1));
CREATE TABLE kamar (
  id SERIAL PRIMARY KEY, tipe_kamar_id INT NOT NULL REFERENCES tipe_kamar(id),
  nomor VARCHAR(10) NOT NULL UNIQUE, lantai SMALLINT NOT NULL,
  harga NUMERIC(10,2) NOT NULL CHECK (harga > 0),
  status VARCHAR(10) NOT NULL DEFAULT 'kosong' CHECK (status IN ('kosong','terisi')));
CREATE TABLE penghuni (
  id SERIAL PRIMARY KEY, pengguna_id INT NOT NULL UNIQUE REFERENCES pengguna(id),
  no_telepon VARCHAR(20) NOT NULL, no_identitas VARCHAR(20),
  pekerjaan VARCHAR(60), alamat_asal TEXT);
CREATE TABLE reservasi (
  id SERIAL PRIMARY KEY, penghuni_id INT NOT NULL REFERENCES penghuni(id),
  kamar_id INT NOT NULL REFERENCES kamar(id), tanggal_masuk DATE NOT NULL,
  tanggal_keluar DATE CHECK (tanggal_keluar >= tanggal_masuk),
  status VARCHAR(12) NOT NULL DEFAULT 'menunggu'
    CHECK (status IN ('menunggu','disetujui','ditolak','check_in')),
  dibuat_pada TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE tagihan (
  id SERIAL PRIMARY KEY, reservasi_id INT NOT NULL REFERENCES reservasi(id),
  periode DATE NOT NULL, jatuh_tempo DATE NOT NULL,
  jumlah NUMERIC(10,2) NOT NULL CHECK (jumlah > 0),
  status VARCHAR(10) NOT NULL DEFAULT 'belum' CHECK (status IN ('belum','lunas')),
  dibuat_pada TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE TABLE pembayaran (
  id SERIAL PRIMARY KEY, tagihan_id INT NOT NULL REFERENCES tagihan(id),
  dicatat_oleh INT NOT NULL REFERENCES pengguna(id),
  jumlah NUMERIC(10,2) NOT NULL CHECK (jumlah > 0), metode VARCHAR(12) NOT NULL,
  dibayar_pada TIMESTAMPTZ NOT NULL, catatan VARCHAR(200));

CREATE INDEX idx_tagihan_status_jatuh_tempo ON tagihan (status, jatuh_tempo);
CREATE INDEX idx_reservasi_kamar ON reservasi (kamar_id, tanggal_masuk);
-- Direncanakan Minggu 13 (perbaikan BUG-07):
-- CREATE UNIQUE INDEX uq_tagihan_reservasi_periode ON tagihan (reservasi_id, periode);
```
)

G.2 Kueri dasbor: @kode-kueri memuat ketiganya. Q1 memakai `FILTER` agar okupansi dihitung dalam satu pemindaian, Q2 mengelompokkan pembayaran per bulan dengan `date_trunc`, dan Q3 menghubungkan empat tabel untuk menampilkan nama penunggak. Di Q2 inilah BUG-06 berasal: `date_trunc` bekerja pada zona waktu sesi, sehingga pembayaran 31 Oktober malam bergeser ke November. Perbaikannya, menambahkan `AT TIME ZONE 'Asia/Jakarta'`, dijadwalkan di Minggu 13.

#kode("kode-kueri", [Tiga kueri dasbor],
```sql
-- Q1: okupansi
SELECT ROUND(100.0 * COUNT(*) FILTER (WHERE status = 'terisi') / COUNT(*), 1) AS okupansi_persen
FROM kamar;

-- Q2: pendapatan per bulan
SELECT date_trunc('month', dibayar_pada) AS bulan, SUM(jumlah) AS pendapatan
FROM pembayaran
GROUP BY 1
ORDER BY 1;

-- Q3: tunggakan
SELECT u.nama, t.jatuh_tempo, t.jumlah
FROM tagihan t
JOIN reservasi r ON r.id = t.reservasi_id
JOIN penghuni p ON p.id = r.penghuni_id
JOIN pengguna u ON u.id = p.pengguna_id
WHERE t.status = 'belum' AND t.jatuh_tempo < CURRENT_DATE
ORDER BY t.jatuh_tempo;
```
)

G.3 Pengujian dengan `EXPLAIN ANALYZE`: kami mengukur Q3 pada 10.000 tagihan sebelum dan sesudah indeks `idx_tagihan_status_jatuh_tempo` (@gbr-explain). Waktunya turun dari sekitar 5 ms menjadi 0,3 ms, atau sekitar 16 kali lebih cepat. Q1 (20 kamar) dan Q2 (10.000 pembayaran, sekitar 7 ms) cukup cepat tanpa indeks tambahan. Seluruh dasbor merespons sekitar 120 ms pada TC-18, jauh di bawah batas 500 ms. Q2 akan kami ukur lagi setelah BUG-06 diperbaiki karena kuerinya berubah.

#[
#show figure: set align(left)
#console("gbr-explain", [Q3 sebelum indeks (Seq Scan, sekitar 5 ms) dan sesudah indeks (Index Scan, sekitar 0,3 ms)], "Sebelum:
Seq Scan on tagihan t  (actual time=0.028..4.310 rows=212 loops=1)
  Filter: ((status = 'belum') AND (jatuh_tempo < CURRENT_DATE))
  Rows Removed by Filter: 9788
Execution Time: 4.9 ms

Sesudah:
Index Scan using idx_tagihan_status_jatuh_tempo on tagihan t
    (actual time=0.021..0.190 rows=212 loops=1)
  Index Cond: ((status = 'belum') AND (jatuh_tempo < CURRENT_DATE))
Execution Time: 0.31 ms")
]

#pagebreak()
#lamp("H", "Deklarasi Penggunaan AI", stage: st-lanjutan)
Bagian yang dibantu AI tercatat di @tbl-ai. Seluruh anggota memahami dan dapat menjelaskan hasilnya.

#tabel("tbl-ai", [Deklarasi penggunaan AI], tbl((1.6fr, 1.2fr, 2.4fr),
  ([Bagian], [Alat], [Tujuan]),
  (
    ([Koleksi uji Postman], [Asisten kode], [Contoh awal skrip uji. Ditulis ulang dan dijalankan oleh Nabila]),
    ([Perbaikan bahasa Bab 1 dan Bab 5], [Asisten menulis], [Merapikan kalimat. Isi ditulis tim]),
  ), sz: 8pt))
