#import "contoh-lib.typ": *
#show: doc => contoh(product: "CUCIKU", team: "Tim Cuci Kilat",
  title: "Contoh Laporan Milestone 2 PBL (CUCIKU, SIB Semester 3)", doc)

// subjudul kecil di dalam lampiran
#let sub(t) = block(sticky: true, above: 1.1em, below: 0.5em, text(font: serif, size: 10.6pt, style: "italic")[#t])

#cover-cucik(
  product: "CUCIKU",
  subtitle: "Sistem Pemesanan dan Manajemen Laundry Kiloan",
  prodi: "Program Studi Sistem Informasi Bisnis, Semester 3",
  team: "Tim Cuci Kilat", class-line: "Kelas SIB-2A",
  members: "Rizky Ananta Putra, Maya Safitri Dewi, Fajar Nugraha Adi, Anisa Zahra Maulida",
  year-line: "Tahun Akademik 2026/2027 · November 2026",
  headline: "Nota yang Tak Lagi Hilang", accent-word: "Tak Lagi Hilang",
  coverlines: (("Alur", "Pesan, timbang, bayar, ambil dalam satu alur"), ("Desain", "Empat beda antara prototipe dan hasil akhir"), ("Basis data", "Indeks yang memangkas kueri dari 5,9 ke 0,1 milidetik"),)
)
#counter(page).update(1)

#usage-note()

// =====================================================================
// LEMBAR STATUS
// =====================================================================
#part("Lembar Status Milestone 2", "Posisi Proyek pada Minggu 12")
#pill(st-hapus)
#v(0.5em)
#{ set par(justify: false); fakta((("Status", "Lengkap"), ("Kelas", "SIB-2A"), ("Dosen rujukan", "Dosen Rujukan SIB-2A"), ("Tim", "Tim Cuci Kilat"))) }

#sec("S.1", "Identitas dan Dosen")
#tbl((1.6fr, 1.1fr, 2fr, 1.3fr),
  ([Nama], [NIM], [Peran saat ini], [Perubahan dari Milestone 1]),
  (
    ([Rizky Ananta Putra], [2541 0000 0001], [Ketua Tim, back-end], [Tidak ada]),
    ([Maya Safitri Dewi], [2541 0000 0002], [Perancang UI/UX], [Tidak ada]),
    ([Fajar Nugraha Adi], [2541 0000 0003], [Front-end], [Tidak ada]),
    ([Anisa Zahra Maulida], [2541 0000 0004], [Basis data dan dokumentasi], [Menjadi penguji sejak Minggu 10]),
  ), sz: 8pt)
#v(0.3em)
Mata kuliah yang dinilai: Pemrograman Web, Basis Data Lanjut, dan Desain UI/UX, masing-masing dengan dosen pengampu sendiri dan Dosen Rujukan SIB-2A sebagai dosen rujukan kelas.

#sec("S.2", "Status Milestone 2")
Lengkap. Alur utama, yaitu pelanggan memesan, kasir menimbang, pembayaran dicatat, lalu pesanan diambil, sudah berjalan dari awal sampai akhir di atas PostgreSQL. Tampilan mengikuti prototipe Figma dengan empat perbedaan yang dicatat di Bab 2.5. Dari 14 kasus uji, 13 lulus dan satu gagal (BUG-01, tombol terpotong di layar 320 px). Laporan bulanan menyusul di Minggu 13.

#sec("S.3", "Tindak Lanjut Milestone 1")
#tbl((2.4fr, 1.4fr, 2.4fr, 0.8fr),
  ([Umpan balik], [Mata kuliah], [Tindak lanjut], [Status]),
  (
    ([Hubungan `item_pesanan` dan `layanan` perlu dinormalisasi], [Basis Data Lanjut], [Harga dipisah ke `layanan`, skema dibekukan di Minggu 9], [Selesai]),
    ([Kontras tombol prototipe kurang], [Desain UI/UX], [Warna tombol utama diganti (Bab 2.5)], [Selesai]),
  ), sz: 8pt)

#sec("S.4", "Capaian Produk")
#tbl((1fr, 1fr),
  ([Sudah berjalan], [Sebagian atau belum]),
  (
    ([Login tiga peran, pesan laundry, timbang dan ubah status, catat pembayaran dan nota, kelola layanan dan pengguna, laporan pendapatan harian], [Laporan bulanan dan per layanan (Minggu 13), pengingat jemput lewat surel (Minggu 15), QRIS sengaja dihapus dari cakupan]),
  ), sz: 8pt)
#v(0.3em)
Target SIB Semester 3 terpenuhi seluruhnya: satu alur bisnis utama berjalan, tampilan mengikuti prototipe dengan perbedaan yang dicatat, Bab 1 sampai 3 selesai, dan Bab 4 memuat 14 kasus uji.

#sec("S.5", "Bukti")
#tbl((1.1fr, 2fr, 2.1fr),
  ([Aspek], [Pilihan tim], [Tautan atau keterangan]),
  (
    ([Demo], [Langsung di kelas], [Jadwal SIB-2A, Minggu 12]),
    ([Deploy], [Hosting gratis], [`cuciku.example.com`]),
    ([Repositori], [Git, _tag_ `milestone-2`], [`github.com/contoh/cuciku`]),
    ([Masukan pengguna], [Pemilik laundry], [Bab 4.5]),
    ([Pengujian], [Uji manual dan uji kueri], [Bab 4 dan Lampiran G]),
  ), sz: 8pt)

#sec("S.6", "Rencana Minggu 13–16")
#tbl((0.7fr, 3.2fr, 1.2fr),
  ([Minggu], [Target], [Penanggung jawab]),
  (
    ([13], [Laporan bulanan dan per layanan, perbaikan BUG-01], [Rizky, Fajar]),
    ([14], [Pengujian lanjutan dan uji kueri dengan data lebih besar], [Anisa]),
    ([15], [Pengingat jemput, penyempurnaan Bab 1–5, materi demo], [Seluruh tim]),
    ([16], [Demo Day dan Expo], [Seluruh tim]),
  ), sz: 8pt)

#pagebreak()
#toc-page()

// =====================================================================
// BAB 1
// =====================================================================
#chapter("Bab 1", "Pendahuluan")
#lead[Bab ini menjelaskan masalah pencatatan di laundry mitra, cakupan produk, dan lima ukuran keberhasilan. Temuan yang paling kuat: enam dari 40 nota yang kami periksa tidak lengkap atau hilang.]

#sec("1.1", "Latar Belakang dan Rumusan Masalah", stage: st-proposal)
Mitra kami adalah laundry kiloan kecil di sekitar kampus. Semua pesanan dicatat di buku nota: kasir menulis nama pelanggan, jenis layanan, berat cucian, dan tanggal jemput, lalu menyobek satu lembar untuk pelanggan. Selama dua hari pengamatan kami memeriksa 40 nota bulan sebelumnya dan menemukan enam yang tidak lengkap atau tidak bisa ditemukan lagi, sekitar 15 persen. Bagi pemilik, nota yang hilang berarti pendapatan yang tidak tercatat, dan ia baru tahu pendapatan hari itu setelah menjumlah nota satu per satu pada malam hari.

Bagi pelanggan masalahnya lain. Mereka sering datang atau menelepon hanya untuk bertanya apakah cuciannya sudah selesai, dan kasir harus berhenti bekerja untuk membolak-balik buku. Kasir memperkirakan ada sekitar sepuluh pertanyaan seperti itu setiap hari. Nota yang hilang, pendapatan yang lambat diketahui, dan status cucian yang tidak jelas ternyata berakar dari hal yang sama: tidak ada catatan pesanan yang terpusat dan mudah dicari.

Rumusan masalah kami: bagaimana mencatat pesanan laundry dari awal sampai diambil, sehingga status pesanan dan pendapatan bisa dilihat kapan saja oleh pihak yang berhak?

#sec("1.2", "Tujuan", stage: st-proposal)
Menghasilkan aplikasi web bisnis dengan satu alur utuh (pesan, timbang, bayar, ambil), antarmuka yang rapi di berbagai ukuran layar, dan basis data yang terancang dengan baik.

#sec("1.3", "Cakupan Fitur dan Batasan", stage: st-proposal)
Cakupan produk kami tulis di Project Charter versi 1.1, yang disetujui mitra dan Dosen Rujukan SIB-2A pada Minggu 2. Isinya sederhana: semester ini kami mengejar satu alur bisnis yang utuh dan bisa didemokan, bukan fitur sebanyak mungkin. Yang masuk adalah pemesanan oleh pelanggan, penimbangan dan perubahan status oleh kasir, pencatatan pembayaran dan nota, pengelolaan layanan dan pengguna oleh pemilik, serta laporan pendapatan.

Tiga hal sengaja kami tinggalkan. Pembayaran QRIS butuh akun penyedia yang tidak mungkin diurus dalam satu semester, aplikasi ponsel tidak perlu karena web responsif sudah cukup, dan banyak cabang tidak relevan karena mitra hanya punya satu. Asumsinya juga disederhanakan: satu kasir aktif pada satu waktu, dan pembayaran dicatat setelah uang diterima langsung, bukan ditagih lewat sistem. Setiap perubahan cakupan sejak proposal, termasuk keputusan menghapus QRIS, tercatat di Governance Log dan dirangkum di Bab 5.3.

#sec("1.4", "Pemangku Kepentingan dan Manfaat", stage: st-proposal)
Stakeholder Register versi 1.0 mendaftar lima pihak. Pemilik laundry punya pengaruh terbesar karena dialah pemberi kebutuhan dan penerima laporan; ia kami temui untuk wawancara awal, meninjau prototipe di Minggu 4, dan menguji laporan di Minggu 12. Kasir memakai aplikasi setiap hari, jadi mereka mencoba dasbor di setiap pekan pengembangan. Tiga pelanggan ikut mencoba alur pesan, sedangkan dosen pengampu dan Dosen Rujukan SIB-2A kami temui dua minggu sekali.

Ketika ada benturan prioritas, masukan pemilik kami dahulukan. Permintaan laporan bulanan dan pengingat jemput, misalnya, tidak ada di proposal tetapi masuk rencana Minggu 13 sampai 15. Kasir dan pelanggan memang tidak ikut memutuskan, tetapi merekalah yang menentukan apakah alurnya nyaman, sehingga mereka kami libatkan dalam uji kegunaan di Bab 4.5.

#sec("1.5", "Kriteria Keberhasilan", stage: st-proposal)
Kami menetapkan lima ukuran yang bisa diperiksa supaya penilaian akhir tidak bergantung pada kesan. K1: satu pesanan selesai dari pemesanan sampai pengambilan tanpa bantuan pengembang pada tiga dari tiga pelanggan uji, dan sampai Minggu 12 ketiganya berhasil. K2: tampilan rapi tanpa gulir samping dari 360 sampai 1280 px, yang tercapai, sedangkan layar 320 px masih terpotong (BUG-01). K3: pendapatan harian di laporan sama dengan hitungan manual selama tujuh hari data uji, dengan selisih Rp 0 (TC-12).

K4 mengukur waktu pelanggan baru membuat pesanan, dengan target kurang dari 2 menit, dan rata-ratanya 1 menit 40 detik. K5 menargetkan paling sedikit 90 persen kasus uji lulus, dan hasilnya 13 dari 14. Targetnya sengaja tidak 100 persen karena bug tampilan di perangkat yang sangat kecil mungkin baru muncul pada pengujian lanjutan. Posisi Minggu 12 ini hanya gambaran sementara; perbandingan resminya ditulis di Bab 4.6 pada laporan akhir.

// =====================================================================
// BAB 2
// =====================================================================
#chapter("Bab 2", "Analisis Kebutuhan dan Perancangan")
#lead[Bab ini menjelaskan kebutuhan pengguna, rancangan basis data, dan tampilan. Keputusan terpenting: skema sepuluh tabel dibekukan di Minggu 9, sebelum fitur laporan dikerjakan.]

#sec("2.1", "Kebutuhan Pengguna dan Daftar Fitur", stage: st-proposal)
Anisa menyusun SRS (spesifikasi kebutuhan perangkat lunak) versi 1.2 bersama pemilik laundry, dan dokumen lengkapnya tertaut di Lampiran E. Bab ini merangkum 11 kebutuhan fungsional dan 5 non-fungsional dalam @tbl-srs, dan kodenya dipakai lagi di Bab 4 untuk menelusuri kebutuhan ke kasus uji. Ada tiga peran pengguna (pelanggan, kasir, pemilik) dan enam use case utama, UC-01 sampai UC-06, lengkap dengan alur alternatif seperti pelanggan mengosongkan tanggal jemput atau kasir memasukkan berat nol.

#tabel("tbl-srs", [Kebutuhan fungsional dan non-fungsional dalam SRS versi 1.2], tbl((0.7fr, 4.4fr, 0.8fr, 0.8fr),
  ([ID], [Kebutuhan], [Prioritas], [Status]),
  (
    ([FR-01], [Pengguna masuk dengan email dan kata sandi, akses halaman dibatasi menurut peran], [Tinggi], [Selesai]),
    ([FR-02], [Pelanggan membuat pesanan: memilih layanan, mengisi perkiraan berat, menentukan tanggal jemput], [Tinggi], [Selesai]),
    ([FR-03], [Pelanggan melihat status dan riwayat pesanannya], [Tinggi], [Selesai]),
    ([FR-04], [Kasir menimbang cucian dan memperbarui berat sebenarnya], [Tinggi], [Selesai]),
    ([FR-05], [Kasir mengubah status pesanan (diterima, dicuci, siap, diambil)], [Tinggi], [Selesai]),
    ([FR-06], [Kasir mencatat pembayaran (tunai atau transfer) dan mencetak nota], [Tinggi], [Selesai]),
    ([FR-07], [Pemilik menambah, mengubah, dan menghapus layanan beserta harganya], [Sedang], [Selesai]),
    ([FR-08], [Pemilik menambah, mengubah, dan menonaktifkan pengguna], [Sedang], [Selesai]),
    ([FR-09], [Pemilik melihat laporan pendapatan harian], [Tinggi], [Selesai]),
    ([FR-10], [Pemilik melihat laporan bulanan dan per layanan], [Sedang], [Sebagian]),
    ([FR-11], [Sistem mengirim pengingat jemput lewat surel], [Rendah], [Belum]),
    ([NFR-01], [Tampilan responsif di ponsel dan laptop, rapi pada 320 sampai 1280 px], [Tinggi], [Sebagian]),
    ([NFR-02], [Kata sandi di-hash (`password_hash`) dan semua kueri memakai _prepared statement_], [Tinggi], [Selesai]),
    ([NFR-03], [Halaman utama termuat kurang dari 2 detik di hosting uji], [Sedang], [Selesai]),
    ([NFR-04], [Warna, huruf, dan jarak mengikuti _design tokens_ Figma di semua halaman], [Sedang], [Selesai]),
    ([NFR-05], [Pesanan tersimpan utuh atau tidak sama sekali (satu transaksi)], [Tinggi], [Selesai]),
  ), sz: 7.8pt))

Sembilan kebutuhan fungsional sudah selesai. FR-10 baru sebagian karena baru laporan harian yang ada, dan FR-11 belum disentuh; keduanya kami geser ke belakang karena prioritasnya lebih rendah dari alur pesan sampai bayar. Di sisi non-fungsional hanya NFR-01 yang belum penuh, gara-gara BUG-01.

#sec("2.2", "Susunan Komponen Sistem", stage: st-proposal)
CUCIKU adalah aplikasi web tiga lapis seperti pada @gbr-arsitektur. Peramban mengirim permintaan ke server, router PHP meneruskannya ke controller, model mengakses basis data lewat PDO, dan PostgreSQL menyimpan semua data. Kami memakai PHP native tanpa framework karena itu yang diajarkan di Pemrograman Web, dan struktur MVC sederhananya kami buat sendiri supaya setiap anggota paham tiap lapisan.

#gambar("gbr-arsitektur", [Susunan komponen CUCIKU], flow(([Peramban \ HTML, CSS, JavaScript], [Router dan controller PHP], [Model dengan PDO `pgsql`], [PostgreSQL 16])))

PostgreSQL dipilih karena dipelajari di Basis Data Lanjut dan menyediakan `EXPLAIN ANALYZE`, trigger, serta window function untuk laporan. Pemisahan lapisan memudahkan pembagian kerja: Fajar mengerjakan tampilan, Rizky controller dan model, Anisa skema dan kueri.

#sec("2.3", "Rancangan Basis Data", stage: st-proposal)
Rancangan basis data kami susun sebagai PDM (_physical data model_) untuk PostgreSQL 16 dengan sepuluh tabel dalam tiga kelompok: pengguna (`peran`, `pengguna`, `pelanggan`), data master (`kategori_layanan`, `layanan`, `metode_pembayaran`), dan transaksi (`pesanan`, `item_pesanan`, `pembayaran`, `status_pesanan_log`). Di Milestone 1 skema kami baru lima tabel. Dosen Basis Data meminta kami memecahnya sampai 3NF, dan itu memakan waktu sampai skemanya dibekukan di Minggu 9.

@gbr-pdm di halaman berikut memuat seluruh tabel dengan kolom, tipe, dan kuncinya. PK berarti kunci primer, FK kunci asing, UQ kolom unik, dan garis antartabel memakai notasi kaki gagak dengan `1` di sisi induk dan `N` di sisi anak. Rincian kolom beserta batasannya ada di kamus data pada @tbl-kamus-1 dan @tbl-kamus-2, dan skrip DDL lengkapnya di Lampiran G.

Batasan pada skema kami tegakkan di basis data, bukan hanya di aplikasi: `email`, `nama_layanan`, dan `kode` unik, harga dan berat dijaga `CHECK`, dan `ON DELETE CASCADE` hanya dipakai untuk data yang tak berarti tanpa induknya (`item_pesanan`, `status_pesanan_log`, `pelanggan`). Layanan yang sudah dipakai pesanan tidak bisa dihapus, dan `UNIQUE` pada `pembayaran.pesanan_id` memastikan satu pesanan hanya dibayar sekali.

Normalisasi kami kerjakan bertahap. Untuk 1NF, baris layanan dipisah dari pesanan karena semula satu kolom menyimpan daftar layanan. Untuk 2NF, profil pelanggan dipisah dari `pengguna` karena hanya pelanggan yang punya telepon dan alamat, dan untuk 3NF nama peran, kategori, dan metode bayar pindah ke tabel sendiri. Dua keputusan kami ambil dengan sadar: `harga_satuan` disimpan di `item_pesanan` sebagai fakta historis karena harga di `layanan` bisa berubah, dan `pesanan.total` disimpan sebagai nilai turunan supaya laporan cepat, dengan konsistensi dijaga transaksi di Bab 3.2.

#pdm-page("gbr-pdm", [PDM CUCIKU (PostgreSQL 16, sepuluh tabel)],
  (
    (name: "peran", col: 0, row: 0, cols: (("id", "smallserial", "PK"), ("nama", "varchar(20)", "UQ"))),
    (name: "pengguna", col: 1, row: 0, cols: (("id", "serial", "PK"), ("peran_id", "smallint", "FK"), ("nama", "varchar(80)", ""), ("email", "varchar(100)", "UQ"), ("kata_sandi", "varchar(255)", ""), ("aktif", "boolean", ""), ("dibuat_pada", "timestamptz", ""))),
    (name: "pelanggan", col: 1, row: 1, cols: (("pengguna_id", "int", "PK,FK"), ("no_telepon", "varchar(20)", ""), ("alamat", "text", ""))),
    (name: "pesanan", col: 2, row: 0, cols: (("id", "serial", "PK"), ("kode", "varchar(20)", "UQ"), ("pelanggan_id", "int", "FK"), ("kasir_id", "int", "FK"), ("status", "status_pesanan", ""), ("tanggal_masuk", "timestamptz", ""), ("tanggal_jemput", "date", ""), ("total", "numeric(12,2)", ""))),
    (name: "status_pesanan_log", col: 2, row: 1, cols: (("id", "bigserial", "PK"), ("pesanan_id", "int", "FK"), ("status_lama", "status_pesanan", ""), ("status_baru", "status_pesanan", ""), ("diubah_oleh", "int", "FK"), ("diubah_pada", "timestamptz", ""))),
    (name: "item_pesanan", col: 3, row: 0, cols: (("id", "serial", "PK"), ("pesanan_id", "int", "FK"), ("layanan_id", "int", "FK"), ("berat_kg", "numeric(5,2)", ""), ("harga_satuan", "numeric(10,2)", ""), ("subtotal", "numeric(12,2)", ""))),
    (name: "pembayaran", col: 3, row: 1, cols: (("id", "serial", "PK"), ("pesanan_id", "int", "FK,UQ"), ("metode_id", "smallint", "FK"), ("jumlah", "numeric(12,2)", ""), ("dibayar_pada", "timestamptz", ""))),
    (name: "metode_pembayaran", col: 3, row: 2, cols: (("id", "smallserial", "PK"), ("nama", "varchar(20)", "UQ"), ("aktif", "boolean", ""))),
    (name: "layanan", col: 4, row: 0, cols: (("id", "serial", "PK"), ("kategori_id", "smallint", "FK"), ("nama_layanan", "varchar(50)", "UQ"), ("harga_per_kg", "numeric(10,2)", ""), ("durasi_jam", "int", ""), ("aktif", "boolean", ""))),
    (name: "kategori_layanan", col: 4, row: 1, cols: (("id", "smallserial", "PK"), ("nama", "varchar(40)", "UQ"), ("keterangan", "text", ""))),
  ),
  (
    (parent: "peran", child: "pengguna", fk: "peran_id", a: "1", b: "N"),
    (parent: "pengguna", child: "pelanggan", fk: "pengguna_id", a: "1", b: "1"),
    (parent: "pengguna", child: "pesanan", fk: "kasir_id", a: "1", b: "N"),
    (parent: "pelanggan", child: "pesanan", fk: "pelanggan_id", pk: "pengguna_id", a: "1", b: "N"),
    (parent: "pengguna", child: "status_pesanan_log", fk: "diubah_oleh", a: "1", b: "N"),
    (parent: "pesanan", child: "status_pesanan_log", fk: "pesanan_id", a: "1", b: "N"),
    (parent: "pesanan", child: "item_pesanan", fk: "pesanan_id", a: "1", b: "N"),
    (parent: "pesanan", child: "pembayaran", fk: "pesanan_id", a: "1", b: "1"),
    (parent: "layanan", child: "item_pesanan", fk: "layanan_id", a: "1", b: "N"),
    (parent: "kategori_layanan", child: "layanan", fk: "kategori_id", a: "1", b: "N"),
    (parent: "metode_pembayaran", child: "pembayaran", fk: "metode_id", a: "1", b: "N"),
  ))

Dalam kamus data, kolom `subtotal` berstatus _generated_: PostgreSQL menghitungnya dari berat dan harga satuan, jadi aplikasi tidak perlu melakukannya.

#tabel("tbl-kamus-1", [Kamus data: pengguna dan data master], wide(tbl((1.5fr, 1.2fr, 1.3fr, 3fr),
  ([Tabel], [Kolom], [Tipe], [Batasan dan keterangan]),
  (
    ([`peran`], [`id`], [SMALLSERIAL], [PK], [Kunci peran]),
    ([], [`nama`], [VARCHAR(20)], [NOT NULL, UNIQUE], [Pelanggan, kasir, pemilik]),
    ([`pengguna`], [`id`], [SERIAL], [PK], [Kunci pengguna]),
    ([], [`peran_id`], [SMALLINT], [FK ke `peran.id`, NOT NULL], [Peran pengguna]),
    ([], [`nama`], [VARCHAR(80)], [NOT NULL], [Nama lengkap]),
    ([], [`email`], [VARCHAR(100)], [NOT NULL, UNIQUE], [Dipakai untuk login]),
    ([], [`kata_sandi`], [VARCHAR(255)], [NOT NULL], [Hasil `password_hash`]),
    ([], [`aktif`], [BOOLEAN], [NOT NULL, DEFAULT TRUE], [Akun nonaktif tidak bisa masuk]),
    ([], [`dibuat_pada`], [TIMESTAMPTZ], [NOT NULL, DEFAULT now()], [Waktu akun dibuat]),
    ([`pelanggan`], [`pengguna_id`], [INT], [PK, FK ke `pengguna.id`, CASCADE], [Profil satu-satu dengan pengguna]),
    ([], [`no_telepon`], [VARCHAR(20)], [NOT NULL], [Kontak pelanggan]),
    ([], [`alamat`], [TEXT], [Boleh kosong], [Alamat penjemputan]),
    ([`kategori_layanan`], [`id`], [SMALLSERIAL], [PK], [Kunci kategori]),
    ([], [`nama`], [VARCHAR(40)], [NOT NULL, UNIQUE], [Reguler atau Ekspres]),
    ([], [`keterangan`], [TEXT], [Boleh kosong], [Penjelasan kategori]),
    ([`layanan`], [`id`], [SERIAL], [PK], [Kunci layanan]),
    ([], [`kategori_id`], [SMALLINT], [FK ke `kategori_layanan.id`, NOT NULL], [Kategori layanan]),
    ([], [`nama_layanan`], [VARCHAR(50)], [NOT NULL, UNIQUE], [Nama di formulir]),
    ([], [`harga_per_kg`], [NUMERIC(10,2)], [NOT NULL, CHECK lebih dari 0], [Harga per kilogram]),
    ([], [`durasi_jam`], [INT], [NOT NULL, CHECK lebih dari 0], [Perkiraan lama pengerjaan]),
    ([], [`aktif`], [BOOLEAN], [NOT NULL, DEFAULT TRUE], [Nonaktif tidak tampil]),
    ([`metode_pembayaran`], [`id`], [SMALLSERIAL], [PK], [Kunci metode]),
    ([], [`nama`], [VARCHAR(20)], [NOT NULL, UNIQUE], [Tunai atau Transfer]),
    ([], [`aktif`], [BOOLEAN], [NOT NULL, DEFAULT TRUE], [Metode yang masih dipakai]),
  ), sz: 7.4pt)))

#tabel("tbl-kamus-2", [Kamus data: tabel transaksi], wide(tbl((1.5fr, 1.2fr, 1.3fr, 3fr),
  ([Tabel], [Kolom], [Tipe], [Batasan dan keterangan]),
  (
    ([`pesanan`], [`id`], [SERIAL], [PK], [Kunci pesanan]),
    ([], [`kode`], [VARCHAR(20)], [NOT NULL, UNIQUE], [Kode nota, misalnya PSN-0301]),
    ([], [`pelanggan_id`], [INT], [FK ke `pelanggan.pengguna_id`, NOT NULL], [Pemilik pesanan]),
    ([], [`kasir_id`], [INT], [FK ke `pengguna.id`, boleh kosong], [Kasir yang menangani]),
    ([], [`status`], [status_pesanan], [NOT NULL, DEFAULT diterima], [ENUM: diterima, dicuci, siap, diambil]),
    ([], [`tanggal_masuk`], [TIMESTAMPTZ], [NOT NULL, DEFAULT now()], [Waktu pesanan dibuat]),
    ([], [`tanggal_jemput`], [DATE], [NOT NULL], [Pilihan pelanggan]),
    ([], [`total`], [NUMERIC(12,2)], [NOT NULL, CHECK tidak negatif], [Jumlah subtotal]),
    ([`item_pesanan`], [`id`], [SERIAL], [PK], [Kunci baris]),
    ([], [`pesanan_id`], [INT], [FK ke `pesanan.id`, NOT NULL, CASCADE], [Pesanan induk]),
    ([], [`layanan_id`], [INT], [FK ke `layanan.id`, NOT NULL], [Layanan yang dipilih]),
    ([], [`berat_kg`], [NUMERIC(5,2)], [NOT NULL, CHECK lebih dari 0], [Berat cucian]),
    ([], [`harga_satuan`], [NUMERIC(10,2)], [NOT NULL, CHECK lebih dari 0], [Harga saat pesanan dibuat]),
    ([], [`subtotal`], [NUMERIC(12,2)], [GENERATED, berat kali harga], [Dihitung otomatis]),
    ([`pembayaran`], [`id`], [SERIAL], [PK], [Kunci pembayaran]),
    ([], [`pesanan_id`], [INT], [FK ke `pesanan.id`, NOT NULL, UNIQUE], [Satu pembayaran per pesanan]),
    ([], [`metode_id`], [SMALLINT], [FK ke `metode_pembayaran.id`, NOT NULL], [Cara membayar]),
    ([], [`jumlah`], [NUMERIC(12,2)], [NOT NULL, CHECK lebih dari 0], [Jumlah diterima]),
    ([], [`dibayar_pada`], [TIMESTAMPTZ], [NOT NULL, DEFAULT now()], [Waktu pembayaran]),
    ([`status_pesanan_log`], [`id`], [BIGSERIAL], [PK], [Kunci catatan]),
    ([], [`pesanan_id`], [INT], [FK ke `pesanan.id`, NOT NULL, CASCADE], [Pesanan yang berubah]),
    ([], [`status_lama`], [status_pesanan], [Boleh kosong], [Kosong saat pesanan baru]),
    ([], [`status_baru`], [status_pesanan], [NOT NULL], [Status sesudah perubahan]),
    ([], [`diubah_oleh`], [INT], [FK ke `pengguna.id`, boleh kosong], [Kasir yang mengubah]),
    ([], [`diubah_pada`], [TIMESTAMPTZ], [NOT NULL, DEFAULT now()], [Waktu perubahan]),
  ), sz: 7.4pt)))

#sec("2.5", "Rancangan Antarmuka dan Perbedaan dengan Prototipe", stage: st-proposal)
Rancangan antarmuka ada di satu berkas Figma (tertaut di Lampiran E) dengan tiga halaman: Wireframe, Prototipe yang bisa diklik, dan Hasil Akhir beserta komponen, total 26 frame. Maya membuat wireframe di Minggu 3 lalu prototipe dan design tokens di Minggu 4, dan keduanya ditinjau Dosen UI/UX dan pemilik laundry sebelum pengodean. Frame utamanya ada di @tbl-frame.

#tabel("tbl-frame", [Frame utama pada berkas Figma CUCIKU], wide(tbl((1.6fr, 1.2fr, 0.9fr, 2.6fr),
  ([Frame], [Halaman Figma], [Peran], [Isi]),
  (
    ([Halaman masuk], [Prototipe], [Semua], [Formulir email dan kata sandi, pesan galat]),
    ([Pesan laundry], [Prototipe, Hasil Akhir], [Pelanggan], [Pilih layanan, berat, tanggal jemput, perkiraan total]),
    ([Status pesanan], [Prototipe], [Pelanggan], [Daftar pesanan dengan lencana status]),
    ([Dasbor kasir], [Prototipe, Hasil Akhir], [Kasir], [Tabel pesanan, ubah status, catat pembayaran]),
    ([Nota], [Hasil Akhir], [Kasir], [Rincian pesanan dan pembayaran untuk dicetak]),
    ([Kelola layanan], [Prototipe], [Pemilik], [Tabel layanan, formulir tambah dan ubah]),
    ([Laporan pemilik], [Prototipe, Hasil Akhir], [Pemilik], [Pendapatan harian dan layanan terlaris]),
    ([Komponen], [Hasil Akhir], [Semua], [Tombol, input, kartu, lencana, tabel]),
  ), sz: 8pt)))

Gaya visualnya dirangkum sebagai design tokens supaya konsisten, dan nilai yang sama menjadi variabel CSS di Bab 3.2. Warna utama hasil akhir `#17704B` dipakai untuk tombol dan judul, dengan latar `#F4F8F6`, aksen status siap `#F2A93B`, dan warna galat `#B3261E`. Hurufnya Poppins dan Inter, jarak dan sudut berkelipatan 8 px, dan titik lebar layarnya 360, 768, dan 1280 px. Warna utama juga satu dari empat perbedaan dengan prototipe: hijau prototipe (`#2E9E6B`) hanya 3,4 : 1 kontrasnya terhadap teks putih, jadi kami gelapkan sampai 6,2 : 1.

Alur pengguna di @gbr-alur sengaja dibuat pendek untuk pelanggan karena mereka hanya memakai aplikasi sesekali. Alur kasir dan pemilik lebih panjang karena menyangkut penimbangan, pembayaran, dan laporan.

#gambar("gbr-alur", [Alur pengguna dalam rancangan Figma], [
  #text(font: ui, size: 8pt, fill: muted)[Pelanggan]
  #v(0.2em)
  #flow(([Halaman masuk], [Pilih layanan], [Isi berat dan tanggal jemput], [Kirim pesanan], [Lihat status]))
  #v(0.6em)
  #text(font: ui, size: 8pt, fill: muted)[Kasir dan pemilik]
  #v(0.2em)
  #flow(([Halaman masuk], [Buka dasbor kasir], [Timbang dan ubah status], [Catat pembayaran], [Cetak nota], [Pemilik membaca laporan]))
])

Empat perbedaan antara prototipe dan hasil akhir dirangkum di @tbl-beda. Tiga di antaranya digambar berdampingan di @gbr-banding-pesan dan @gbr-banding-web, sedangkan yang keempat, warna tombol, tidak terlihat pada gambar hitam-putih dan hanya tercatat di paragraf sebelumnya. Semuanya berasal dari uji kegunaan dengan tiga pelanggan dan dari masukan Dosen UI/UX (Bab 4.5), bukan dari selera tim.

#tabel("tbl-beda", [Perbedaan prototipe dan hasil akhir beserta alasannya], tbl((1.2fr, 1.8fr, 1.7fr, 2.4fr),
  ([Layar], [Prototipe], [Hasil akhir], [Alasan]),
  (
    ([Halaman pesan], [Tiga langkah terpisah], [Satu halaman], [Dua dari tiga pelanggan uji berhenti di langkah dua]),
    ([Dasbor kasir], [Tombol di halaman detail], [Tombol "Ubah status" di tiap baris], [Kasir tak perlu membuka detail tiap pesanan]),
    ([Laporan pemilik], [Grafik batang], [Grafik garis dan tabel], [Tren lebih mudah dibaca dari garis, angka pasti di tabel]),
    ([Tombol utama], [Hijau `#2E9E6B`], [Hijau tua `#17704B`], [Kontras 3,4 : 1 jadi 6,2 : 1 (Dosen UI/UX)]),
  ), sz: 8pt))

#gambar("gbr-banding-pesan", [Halaman pesan: prototipe dan hasil akhir], grid(columns: (1fr, 1fr), column-gutter: 14pt, align: center + top,
  wire("Prototipe: langkah 1 dari 3", (("bar", "Langkah 1 dari 3: pilih layanan", 0.55), ("card", "Cuci Setrika Rp 7.000/kg", 0.75), ("card", "Cuci Kering Rp 5.000/kg", 0.75), ("card", "Setrika Saja Rp 4.000/kg", 0.75), ("btn", "Lanjut", 0.6)), w: 4.4cm, h: 4.6cm),
  wire("Hasil akhir: satu halaman", (("input", "Layanan (pilih)", 0.6), ("input", "Perkiraan berat (kg)", 0.6), ("input", "Tanggal jemput", 0.6), ("card", "Perkiraan total Rp 24.500", 0.75), ("btn", "Kirim pesanan", 0.6)), w: 4.4cm, h: 4.6cm),
))

#gambar("gbr-banding-web", [Dasbor kasir dan laporan pemilik: prototipe (kiri) dan hasil akhir (kanan)], grid(columns: (1fr, 1fr), column-gutter: 12pt, row-gutter: 10pt, align: center + top,
  wire("Prototipe: tombol di halaman detail", (("bar", "Dasbor kasir", 0.45), ("list", "Tabel: kode, nama, status", 1.4), ("btn", "Buka detail", 0.5)), w: 6.9cm, h: 3.2cm, kind: "web"),
  wire("Hasil akhir: tombol di tiap baris", (("bar", "Dasbor kasir", 0.45), ("list", "PSN-0301 | Rina | dicuci | Ubah status", 0.55), ("list", "PSN-0302 | Budi | siap | Ubah status", 0.55), ("list", "PSN-0303 | Sari | diterima | Ubah status", 0.55)), w: 6.9cm, h: 3.2cm, kind: "web"),
  wire("Prototipe: grafik batang", (("bar", "Laporan pendapatan", 0.45), ("chart", "Grafik batang pendapatan per hari", 1.5), ("list", "Layanan terlaris", 0.6)), w: 6.9cm, h: 3.4cm, kind: "web"),
  wire("Hasil akhir: garis dan tabel", (("bar", "Laporan pendapatan", 0.45), ("chart", "Grafik garis pendapatan per hari", 1.0), ("list", "Tabel pendapatan harian", 0.9), ("list", "Layanan terlaris", 0.6)), w: 6.9cm, h: 3.4cm, kind: "web"),
))

Pelajarannya: prototipe yang bisa diklik jauh lebih jujur daripada wireframe, karena tombol yang tidak ditemukan atau langkah yang terasa berulang baru kelihatan ketika orang sungguhan mencoba.

#sec("2.6", "Rancangan Laporan", stage: st-proposal)
Laporan untuk pemilik dirancang menjawab dua pertanyaan: berapa pendapatan hari ini dibanding hari-hari sebelumnya, dan layanan apa yang paling banyak dipakai. Jawabannya berupa grafik garis dan tabel pendapatan harian dengan rata-rata tujuh hari (Q2 dan view `v_laporan_pemilik`), serta peringkat layanan per kategori menurut total kilogram (Q3). Keduanya sudah selesai, sedangkan laporan per metode bayar (Q5) dan laporan bulanan masih sebagian.

Semua hitungan dilakukan di basis data dan tampilan hanya menyajikannya (kuerinya ada di Lampiran G). Pemilik meminta laporan bulanan setelah melihat laporan harian di Minggu 12. Karena view harian sudah ada, laporan itu hanya butuh satu filter dan satu halaman baru, jadi kami jadwalkan di Minggu 13.

// =====================================================================
// BAB 3
// =====================================================================
#chapter("Bab 3", "Implementasi")
#lead[Bab ini mencatat cara fitur dibuat sampai Minggu 12. Satu pelajaran yang mengubah cara kerja kami: total pesanan lebih aman dihitung di basis data daripada di tampilan.]

#sec("3.1", "Teknologi yang Dipakai", stage: st-m2)
Pilihan teknologi mengikuti tiga mata kuliah yang dinilai di Milestone 2. Dari Pemrograman Web kami memakai PHP 8.3 native tanpa framework, supaya alur permintaan, validasi, dan akses data bisa dijelaskan baris demi baris. Dari Basis Data Lanjut kami memakai PostgreSQL 16 lewat PDO `pgsql`, dan dari Desain UI/UX kami memakai Figma. Tampilannya HTML dan CSS responsif, dengan JavaScript hanya untuk perkiraan total dan validasi awal, dan kerja tim memakai Git dan GitHub dengan cabang per fitur.

Tanpa framework CSS maupun PHP, kami menulis CSS sendiri dengan variabel dari design tokens Figma, jadi mengganti warna atau jarak cukup di satu tempat. Pekerjaan awalnya lebih banyak, tetapi setiap anggota jadi paham dasar yang dipakai sebelum berpindah ke framework di semester berikutnya.

#sec("3.2", "Cara Membuat Tiap Fitur", stage: st-m2)
Strukturnya MVC sederhana. Semua permintaan masuk lewat `public/index.php` yang meneruskannya ke router, sehingga berkas lain tidak bisa dibuka langsung dari peramban. Folder `app/controllers` berisi logika tiap halaman, `app/models` akses data dengan PDO, `app/views` tampilan, dan `app/core` memuat koneksi, router, dan validator. Kunci koneksi ada di `config/config.php`, sedangkan skema dan data uji ada di folder `database`.

Fitur pertama yang selesai adalah login. Server mencari pengguna dengan _prepared statement_, memeriksa kata sandi dengan `password_verify`, lalu membuat ulang ID sesi supaya sesi lama tidak bisa dipakai lagi. Peran disimpan di sesi dan diperiksa setiap controller sebelum menjalankan tindakan apa pun.

Fitur utamanya adalah pemesanan. Pelanggan memilih layanan dan mengisi perkiraan berat, lalu server menyimpan pesanan, barisnya, dan total dalam satu transaksi (@kode-pesan). Harga diambil dari `layanan` pada saat itu dan disalin ke `harga_satuan`, jadi perubahan harga di kemudian hari tidak menyentuh pesanan lama. Kalau satu langkah gagal, `rollBack` membatalkan semuanya dan pelanggan mendapat pesan yang jelas, bukan pesanan setengah jadi. Di Minggu 10 total sempat tidak sinkron setelah kasir mengubah berat; itu yang membuat kami memindahkan perhitungan ke basis data.

#kode("kode-pesan", [Penyimpanan pesanan dalam satu transaksi], ```php
$pdo->beginTransaction();
try {
    $st = $pdo->prepare('INSERT INTO pesanan (kode, pelanggan_id, tanggal_jemput)
                         VALUES (:k, :p, :t) RETURNING id');
    $st->execute([':k' => buatKode(), ':p' => $pelangganId, ':t' => $tanggalJemput]);
    $pesananId = (int) $st->fetchColumn();

    $item = $pdo->prepare('INSERT INTO item_pesanan
                             (pesanan_id, layanan_id, berat_kg, harga_satuan)
                           SELECT :o, id, :b, harga_per_kg
                           FROM layanan WHERE id = :l AND aktif');
    foreach ($daftarItem as $i) {
        $item->execute([':o' => $pesananId, ':l' => $i['layanan_id'], ':b' => $i['berat']]);
        if ($item->rowCount() !== 1) { throw new RuntimeException('Layanan tidak tersedia'); }
    }
    $pdo->prepare('UPDATE pesanan p SET total =
                     (SELECT SUM(subtotal) FROM item_pesanan i WHERE i.pesanan_id = p.id)
                   WHERE p.id = :o')->execute([':o' => $pesananId]);
    $pdo->commit();
} catch (Throwable $e) {
    $pdo->rollBack();
    $_SESSION['galat'] = 'Pesanan gagal disimpan. Silakan coba lagi.';
}
```)

Dasbor kasir menampilkan pesanan yang belum diambil dengan tombol ubah status di setiap baris. Setiap perubahan status dicatat trigger ke `status_pesanan_log`, jadi riwayat tidak bergantung pada kode aplikasi. Pembayaran dicatat saat pelanggan mengambil cucian, dan nota dibuat dari satu kueri atas `pesanan`, `item_pesanan`, dan `pembayaran`.

Pemilik mengelola data master lewat CRUD layanan dan pengguna. Validasi dilakukan di server: harga harus angka lebih dari nol, dan layanan yang sudah dipakai pesanan tidak bisa dihapus karena dijaga kunci asing. Daripada menampilkan galat basis data, aplikasi menangkap kode `23503` dan menyarankan pemilik menonaktifkan layanan itu.

Tampilan memakai CSS responsif dengan variabel dari design tokens: `--warna-utama` bernilai hijau tua hasil perbaikan kontras, dan kisi kartu memakai `auto-fit` dengan lebar minimum 16 rem sehingga kolomnya menyesuaikan, dari satu di ponsel sampai tiga di laptop. Keamanan dasar berlaku di semua halaman: _prepared statement_, `password_hash`, `htmlspecialchars` pada keluaran, dan penolakan akses bila peran di sesi tidak sesuai.

#sec("3.3", "Basis Data", stage: st-m2)
Skema dibuat dari `skema.sql` (DDL, indeks, view, trigger) lalu diisi `data_uji.sql`. Isinya sama dengan skrip di Lampiran G, sehingga basis data di laptop tiap anggota dan di server seragam. Setelah Minggu 9, perubahan skema harus disetujui Anisa dan dicatat di Governance Log.

Data uji berisi 24 pengguna (20 pelanggan, 3 kasir, 1 pemilik), 6 layanan dalam 3 kategori, 2 metode pembayaran, dan 300 pesanan lengkap dengan item, pembayaran, dan riwayat status. Untuk uji kinerja di Lampiran G.3 kami menambah 20.000 pesanan buatan sehingga `pesanan` berisi 20.300 baris. Hitungan penting seperti total pesanan dan pendapatan harian dikerjakan PostgreSQL, bukan PHP atau JavaScript.

#sec("3.5", "Penyambungan antar Bagian dan Deploy", stage: st-m2)
Aplikasi di-_deploy_ ke hosting gratis yang menyediakan PHP 8.3 dan PostgreSQL 16, dengan alamat di Lampiran E. Langkahnya kami tulis sebagai urutan tetap supaya siapa pun bisa mengulanginya tanpa Rizky: tarik _tag_ `milestone-2`, salin `config.php`, jalankan `skema.sql`, isi `data_uji.sql`, lalu uji cepat alur utama. Anisa menjalankan `pg_dump` sebelum setiap _deploy_.

Sehari sebelum demo kami menguji akses dari ponsel dan laptop dan menyiapkan video cadangan kalau hosting gratisnya lambat; risikonya tercatat di Bab 5.3.

// =====================================================================
// BAB 4
// =====================================================================
#chapter("Bab 4", "Pengujian dan Evaluasi")
#lead[Dari 14 kasus uji, 13 lulus dan satu gagal. Kegagalan itu, BUG-01, hanya terjadi di layar selebar 320 px, tetapi tetap kami catat.]

#sec("4.1", "Rencana Pengujian", stage: st-m2)
Rencana Uji versi 1.0 (tertaut di Lampiran E) memusatkan pengujian pada alur bisnis utama karena itu target Milestone 2. Anisa menjalankan uji fungsional manual atas login, pesan, timbang, bayar, dan kelola layanan di Chrome laptop dan ponsel Android pada Minggu 10 sampai 12, ditambah uji validasi dan akses antarperan. Uji tampilan di lebar 320, 360, 768, dan 1280 px dikerjakan Fajar dan Maya.

Dua jenis lain menjadi bahan penilaian mata kuliah: uji kueri dengan `EXPLAIN ANALYZE` (Lampiran G) dan uji kegunaan oleh Maya di Minggu 12. Hasil yang diharapkan kami tulis sebelum kasus dijalankan, supaya hasil aktual tidak disesuaikan dengan kebetulan.

#sec("4.2", "Kasus Uji dan Hasil", stage: st-m2)
Ke-14 kasus uji ada di @tbl-uji: tiga untuk login ketiga peran, lalu alur dari pemesanan sampai pembayaran, dan sisanya pengelolaan layanan, laporan, dan tampilan di beberapa lebar layar. Hasilnya 13 lulus dan satu gagal.

#tabel("tbl-uji", [Kasus uji dan hasilnya], wide(tbl((0.6fr, 2.4fr, 1.6fr, 2.2fr, 1fr),
  ([ID], [Skenario dan langkah], [Diharapkan], [Hasil aktual], [Status]),
  (
    ([TC-01], [Login pelanggan: isi email dan sandi, tekan Masuk], [Halaman pesan], [Halaman pesan terbuka], [Lulus]),
    ([TC-02], [Login kasir], [Dasbor kasir], [Dasbor kasir terbuka], [Lulus]),
    ([TC-03], [Login pemilik], [Halaman laporan], [Halaman laporan terbuka], [Lulus]),
    ([TC-04], [Pesan dua layanan: pilih dua layanan, isi berat, kirim], [Pesanan dan dua baris tersimpan], [Pesanan dan dua baris tersimpan di basis data], [Lulus]),
    ([TC-05], [Pesan tanpa tanggal jemput], [Pesan galat tampil], [Pesan galat tampil di bawah kolom tanggal], [Lulus]),
    ([TC-06], [Kasir mengubah berat pesanan], [Total dihitung ulang], [Total berubah sesuai berat baru], [Lulus]),
    ([TC-07], [Kasir mengubah status ke "siap"], [Status tampil ke pelanggan], [Pelanggan melihat status "siap"], [Lulus]),
    ([TC-08], [Catat pembayaran: isi jumlah, tekan Simpan], [Pembayaran tersimpan, nota tampil], [Pembayaran tersimpan dan nota terbuka], [Lulus]),
    ([TC-09], [Catat pembayaran dua kali untuk satu pesanan], [Ditolak], [Ditolak dengan pesan jelas], [Lulus]),
    ([TC-10], [Tambah layanan baru dengan harga 8000], [Muncul di daftar], [Muncul di daftar dan formulir pesan], [Lulus]),
    ([TC-11], [Layanan dengan harga -500], [Ditolak dengan pesan], [Penyimpanan ditolak dengan pesan galat], [Lulus]),
    ([TC-12], [Buka laporan pendapatan harian], [Sama dengan hitungan manual], [Angka sama dengan hitungan manual], [Lulus]),
    ([TC-13], [Halaman pesan di lebar 768 dan 1280 px], [Rapi, tanpa gulir samping], [Rapi, tanpa gulir samping], [Lulus]),
    ([TC-14], [Halaman pesan di lebar 320 px], [Tombol utuh], [Tombol Kirim terpotong di sisi kanan], [Gagal (BUG-01)]),
  ), sz: 7.6pt)))

Untuk memastikan semua kebutuhan SRS teruji, kami memetakan kasus uji ke kodenya di @tbl-telusur. Pemetaan itu memperlihatkan celah: FR-08 baru teruji tidak langsung lewat TC-03, jadi kasus uji khusus untuk kelola pengguna dijadwalkan di Minggu 13, sedangkan FR-10 dan FR-11 belum punya kasus uji karena fiturnya belum selesai.

#tabel("tbl-telusur", [Keterlacakan kebutuhan SRS ke kasus uji], wide(tbl((1.1fr, 2.2fr, 1.5fr, 1.7fr),
  ([Kebutuhan], [Ringkasan], [Kasus uji], [Keterangan]),
  (
    ([FR-01], [Login dan pembatasan akses], [TC-01 sampai TC-03], [Lulus]),
    ([FR-02], [Membuat pesanan], [TC-04, TC-05], [Lulus]),
    ([FR-03 sampai 05], [Melihat status, menimbang, mengubah status], [TC-06, TC-07], [Lulus]),
    ([FR-06, FR-07], [Pembayaran dan nota, kelola layanan], [TC-08 sampai TC-11], [Lulus]),
    ([FR-08], [Kelola pengguna], [TC-03 (tidak langsung)], [Kasus khusus di Minggu 13]),
    ([FR-09], [Laporan harian], [TC-12], [Lulus]),
    ([FR-10, FR-11], [Laporan bulanan, pengingat], [Belum ada], [Fitur belum selesai]),
    ([NFR-01], [Responsif], [TC-13, TC-14], [Sebagian (BUG-01)]),
    ([NFR-02 sampai 05], [Keamanan, kecepatan, gaya, penyimpanan atomik], [TC-01, TC-11, TC-13, TC-04, Lampiran G.3], [Lulus]),
  ), sz: 7.8pt)))

#sec("4.3", "Bug yang Ditemukan", stage: st-m2)
Sampai Minggu 12 baru satu bug yang terbuka, BUG-01 di @tbl-bug. Bug ini hanya muncul pada layar 320 px yang jarang dipakai, tetapi masuk NFR-01. Dampaknya hanya pada tombol dan tidak menghalangi alur pesan, jadi kami menetapkan tingkatnya rendah dan menjadwalkan perbaikannya di Minggu 13.

#tabel("tbl-bug", [Catatan bug], tbl((0.7fr, 2.7fr, 0.8fr, 0.8fr, 1.5fr),
  ([ID], [Deskripsi dan langkah reproduksi], [Tingkat], [Status], [Rencana perbaikan]),
  (
    ([BUG-01], [Tombol "Kirim pesanan" terpotong pada lebar 320 px. Langkah: buka halaman pesan dengan lebar layar 320 px dan lihat sisi kanan tombol], [Rendah], [Terbuka], [Tombol selebar penuh pada layar kecil (Minggu 13, Fajar)]),
  ), sz: 8pt))

Dua masalah lain, total yang tidak sinkron (Minggu 10) dan kueri laporan yang lambat (Minggu 11), sudah diperbaiki sebelum pengujian resmi sehingga tidak tercatat sebagai bug.

#sec("4.5", "Masukan Pengguna", stage: st-m2)
Masukan datang dari pemilik laundry dan tiga pelanggan. Pemilik menilai alurnya sudah bisa menggantikan buku nota, dengan dua permintaan tambahan, laporan per bulan dan pengingat jemput, yang masuk rencana Minggu 13 dan 15.

#kutipan[Kalau begini buku nota sudah bisa saya simpan. Tinggal laporan per bulan dan pengingat untuk yang lupa mengambil cucian.][Pemilik laundry, Minggu 12]

Maya menjalankan uji kegunaan di Minggu 12 dengan satu tugas: memesan dua layanan dengan tanggal jemput lusa. Ketiga pelanggan berhasil tanpa bantuan dalam 1 menit 25 detik, 1 menit 40 detik, dan 1 menit 55 detik, sehingga rata-ratanya memenuhi K4 di Bab 1.5. Pelanggan kedua mencari tombol Lihat status selama sekitar 20 detik, jadi tombolnya kami pindahkan ke beranda.

#sec("4.6", "Ketercapaian Kriteria Keberhasilan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: bandingkan hasil akhir dengan kriteria di Bab 1.5. Di Milestone 2, cukup tulis judulnya.]

// =====================================================================
// BAB 5
// =====================================================================
#chapter("Bab 5", "Pengelolaan Proyek dan Penutup")
#lead[Bab ini mencatat siapa mengerjakan apa, apa yang berubah, dan apa yang bisa meleset. Satu-satunya keterlambatan sampai Minggu 12 ada di perancangan basis data.]

#sec("5.1", "Rencana dan Realisasi", stage: st-lanjutan)
Rincian pekerjaan kami susun sebagai WBS tiga tingkat (WBS dan jadwal versi 1.3, tertaut di Lampiran E), dan @tbl-wbs memuat rencana dan realisasinya sampai Minggu 12. Hampir semua tugas selesai sesuai rencana. Pengecualiannya PDM dan kamus data (1.3.1): umpan balik Milestone 1 menuntut normalisasi ulang, sehingga skema baru dibekukan seminggu lebih lambat.

#tabel("tbl-wbs", [WBS tiga tingkat: rencana dan realisasi sampai Minggu 12], tbl((0.6fr, 2.6fr, 1.1fr, 1fr, 1.8fr),
  ([Kode], [Tugas], [Penanggung jawab], [Rencana], [Realisasi]),
  (
    ([1], [Perancangan], [], [], []),
    ([1.1.1], [Wawancara mitra dan SRS], [Anisa], [Minggu 1–3], [Selesai Minggu 3]),
    ([1.1.2], [Project Charter dan Stakeholder Register], [Rizky], [Minggu 2–3], [Selesai Minggu 3]),
    ([1.2.1], [Wireframe], [Maya], [Minggu 3], [Selesai Minggu 3]),
    ([1.2.2], [Prototipe dan design tokens Figma], [Maya], [Minggu 3–4], [Selesai Minggu 4]),
    ([1.3.1], [PDM dan kamus data], [Anisa], [Minggu 5–8], [Selesai Minggu 9]),
    ([1.3.2], [DDL dan data uji], [Anisa], [Minggu 8–9], [Selesai Minggu 9]),
    ([2], [Implementasi], [], [], []),
    ([2.1.1], [Login dan peran], [Rizky], [Minggu 8–9], [Selesai Minggu 9]),
    ([2.1.2], [Pesan laundry dan transaksi], [Rizky], [Minggu 9–11], [Selesai Minggu 11]),
    ([2.1.3], [Dasbor kasir dan pembayaran], [Fajar], [Minggu 9–11], [Selesai Minggu 11]),
    ([2.2.1], [CRUD layanan dan pengguna], [Fajar, Rizky], [Minggu 10–12], [Selesai Minggu 12]),
    ([2.3.1], [Laporan harian], [Fajar], [Minggu 11–12], [Selesai Minggu 12]),
    ([2.3.2], [Laporan bulanan dan per layanan], [Rizky, Fajar], [Minggu 12–13], [Sebagian, lanjut Minggu 13]),
    ([2.3.3], [Pengingat jemput lewat surel], [Rizky], [Minggu 14–15], [Belum dimulai]),
    ([3], [Pengujian], [], [], []),
    ([3.1.1], [Kasus uji dan uji kueri], [Anisa], [Minggu 11–12], [Selesai, 14 kasus uji]),
    ([3.1.2], [Uji kegunaan tiga pelanggan], [Maya], [Minggu 12], [Selesai Minggu 12]),
    ([3.2.1], [Pengujian lanjutan dan perbaikan bug], [Anisa, Fajar], [Minggu 13–14], [Belum dimulai]),
    ([4], [Dokumentasi dan penutup], [], [], []),
    ([4.1.1], [Laporan Milestone 2], [Anisa], [Minggu 9–12], [Selesai Minggu 12]),
    ([4.1.2], [Laporan akhir dan demo], [Seluruh tim], [Minggu 15–16], [Belum dimulai]),
  ), sz: 7.6pt))

Jadwal yang sama digambar sebagai Gantt di @gbr-gantt. Pada perancangan basis data batang realisasi lebih panjang satu minggu dari batang rencana, dan keterlambatan itu tidak menggeser implementasi karena pengodean login sudah berjalan paralel.

#gambar("gbr-gantt", [Jadwal proyek: rencana dan realisasi sampai Minggu 12], gantt((
  ("1.1.1", "Wawancara mitra dan SRS", (1, 3), (1, 3)),
  ("1.2.2", "Wireframe dan prototipe Figma", (3, 4), (3, 4)),
  ("1.3.1", "PDM dan kamus data", (5, 8), (5, 9)),
  ("1.3.2", "DDL dan data uji", (8, 9), (8, 9)),
  ("2.1.2", "Pesan laundry dan transaksi", (9, 11), (9, 11)),
  ("2.1.3", "Dasbor kasir dan pembayaran", (9, 11), (9, 11)),
  ("2.2.1", "CRUD layanan dan pengguna", (10, 12), (10, 12)),
  ("2.3.1", "Laporan harian", (11, 12), (11, 12)),
  ("2.3.2", "Laporan bulanan dan per layanan", (12, 13), (12, 12)),
  ("3.1.1", "Kasus uji dan uji kueri", (11, 12), (11, 12)),
  ("3.2.1", "Pengujian lanjutan", (13, 14), none),
  ("2.3.3", "Pengingat jemput lewat surel", (14, 15), none),
  ("4.1.2", "Laporan akhir dan demo", (15, 16), none),
), now: 12))

#sec("5.2", "Kontribusi Anggota", stage: st-lanjutan)
Tabel kontribusi adalah estimasi tim sendiri, jadi setiap barisnya kami sertai bukti yang bisa diperiksa: jumlah _commit_, berkas Figma, kode WBS, dan lampiran. @tbl-kontribusi juga mencantumkan bagian yang dibawakan tiap anggota saat demo. Karena kami yang menulisnya, dosen sebaiknya mencocokkannya dengan riwayat repositori dan berkas Figma.

#tabel("tbl-kontribusi", [Kontribusi anggota sampai Minggu 12], tbl((1.3fr, 2.1fr, 1.7fr, 0.8fr, 1.5fr),
  ([Nama], [Tugas selesai], [Bukti], [Estimasi], [Bagian saat demo]),
  (
    ([Rizky Ananta Putra], [Back-end, transaksi pesanan, Project Charter], [30 _commit_, WBS 2.1.2], [30%], [Alur pesan sampai bayar]),
    ([Maya Safitri Dewi], [Wireframe, prototipe, design tokens, uji kegunaan], [Berkas Figma, 12 _commit_], [20%], [Prototipe dan perbedaan]),
    ([Fajar Nugraha Adi], [Dasbor kasir, CRUD, laporan harian, CSS responsif], [24 _commit_, WBS 2.1.3], [25%], [Dasbor kasir]),
    ([Anisa Zahra Maulida], [PDM, DDL, kueri, SRS, kasus uji], [Lampiran G, 14 kasus uji], [25%], [Kueri dan pengujian]),
  ), sz: 8pt))

Selain tabel ini, setiap anggota mengisi form Penilaian 360 secara terpisah pada Minggu 11 sampai 12. Koordinator PBL membandingkan rata-rata poin dari form itu dengan estimasi pada tabel, lalu mengirim ringkasannya kepada dosen. Hasil penilaian tidak ditulis di laporan ini. Catatan mingguan siapa mengerjakan apa ada pada logbook di Lampiran B, dan setiap anggota siap menjelaskan bagiannya saat demo.

#sec("5.3", "Perubahan, Risiko, dan Permintaan Tambahan", stage: st-lanjutan)
Setiap perubahan dari proposal kami catat di Governance Log, yang tertaut di Lampiran E bersama Project Charter, dan baru berlaku setelah disetujui dosen terkait. @tbl-perubahan memuat empat perubahan sampai Minggu 12, dua di antaranya menyangkut cakupan dan skema: QRIS dikeluarkan dan kolom `tanggal_jemput` ditambahkan. Dosen juga mengajukan dua permintaan setelah proposal disetujui. Kontras tombol utama dinaikkan setelah tinjauan prototipe (CL-04, selesai di Minggu 11), dan trigger pencatat status ditambahkan Anisa di Minggu 11 atas saran Dosen Basis Data sehingga kini ada di Lampiran G.

#tabel("tbl-perubahan", [Governance Log: perubahan dari proposal], tbl((0.5fr, 2fr, 2fr, 1.6fr),
  ([ID], [Perubahan], [Alasan], [Persetujuan]),
  (
    ([CL-01], [Pembayaran QRIS dikeluarkan dari cakupan], [Butuh akun penyedia yang tidak bisa diurus semester ini], [Dosen Rujukan SIB-2A, Minggu 8]),
    ([CL-02], [Kolom `tanggal_jemput` ditambahkan ke pesanan], [Mitra meminta tanggal jemput di pesanan], [Dosen Basis Data, Minggu 9]),
    ([CL-03], [Skema dipecah menjadi sepuluh tabel (3NF)], [Umpan balik Milestone 1 tentang normalisasi], [Dosen Basis Data, Minggu 9]),
    ([CL-04], [Warna tombol utama diganti hijau tua], [Kontras prototipe kurang], [Dosen UI/UX, Minggu 10]),
  ), sz: 8pt))

Risiko untuk Minggu 13–16 kami nilai dengan skala 1 sampai 5 untuk kemungkinan dan dampak, lalu dikalikan menjadi skor (1–6 rendah, 7–12 sedang, 15 ke atas tinggi). Di @tbl-risiko, dua risiko bersekor sedang yang paling kami perhatikan di rapat mingguan adalah laporan bulanan yang bisa tidak selesai dan hosting gratis yang lambat saat demo.

#tabel("tbl-risiko", [Daftar risiko Minggu 13–16], tbl((0.5fr, 2fr, 1.2fr, 0.8fr, 0.9fr, 2.2fr),
  ([ID], [Risiko], [Kemungkinan], [Dampak], [Skor], [Tindakan]),
  (
    ([R1], [Laporan bulanan tidak selesai], [3], [3], [9, sedang], [Pakai view yang sama dengan laporan harian, tambah satu filter]),
    ([R2], [Hosting gratis lambat saat demo], [3], [4], [12, sedang], [Uji akses H-1 dan siapkan video cadangan]),
    ([R3], [Jadwal ujian anggota bertabrakan dengan tugas], [2], [4], [8, sedang], [Bagi ulang tugas di rapat Minggu 13]),
    ([R4], [BUG-01 dan bug tampilan lain belum selesai], [2], [2], [4, rendah], [Perbaiki di Minggu 13 dan uji ulang TC-14]),
  ), sz: 8pt))

Cara kerja tim diatur dalam team charter di Project Charter. Kami bertemu dua kali seminggu, Senin untuk membagi tugas dan Kamis untuk meninjau hasil, dan komunikasi harian lewat grup percakapan dengan balasan paling lambat sehari. Keputusan soal cakupan atau skema harus tercatat di Governance Log sebelum dikerjakan, setiap perubahan kode masuk lewat cabang dan ditinjau satu anggota lain, dan anggota yang terhambat lebih dari dua hari wajib memberi tahu ketua supaya tugasnya bisa dibagi ulang.

#sec("5.4", "Kesimpulan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang berhasil dibangun, dan apakah rumusan masalah di Bab 1.1 terjawab.]

#sec("5.5", "Pelajaran dan Saran", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang dipelajari tim, apa yang akan dilakukan berbeda, dan saran pengembangan berikutnya.]

// =====================================================================
// LAMPIRAN (tiap lampiran dimulai di halaman baru)
// =====================================================================
#pagebreak()
#part("Lampiran", "Lampiran A–H")
#text(font: ui, size: 8.4pt, fill: muted)[Lampiran F (model ML) hanya untuk tim TI Semester 5, sehingga tidak ada di contoh ini.]
#v(0.6em)

#lamp("A", "Tangkapan Layar", stage: st-m2)
Lampiran ini memuat tangkapan layar fitur yang sudah berjalan: halaman pesan pelanggan pada @gbr-shot-pesan dan dasbor kasir pada @gbr-shot-kasir. Tangkapan layar lain ada di repositori dan bisa diperlihatkan saat demo.
#v(0.4em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  [#shot("gbr-shot-pesan", [Halaman pesan pelanggan], ht: 7cm)],
  [#shot("gbr-shot-kasir", [Dasbor kasir], ht: 7cm)],
)

#pagebreak()
#lamp("B", "Logbook", stage: st-lanjutan)
Logbook Minggu 1–8 dipindahkan dari Laporan Kemajuan, sedangkan @tbl-logbook memuat Minggu 9–12 yang ditambahkan pada Milestone 2.
#v(0.3em)
#tabel("tbl-logbook", [Logbook Minggu 9–12], tbl((0.6fr, 2.2fr, 1.2fr, 1.6fr, 1.6fr),
  ([Minggu], [Pekerjaan selesai], [Dikerjakan oleh], [Kendala], [Rencana berikutnya]),
  (
    ([9], [Skema dibekukan, `tanggal_jemput` ditambah], [Anisa], [Revisi skema], [Alur pesan]),
    ([10], [Alur pesan dan dasbor kasir], [Rizky, Fajar], [Total tidak sinkron], [Transaksi pesanan]),
    ([11], [Transaksi, indeks, trigger, kontras tombol, kelola layanan], [Rizky, Anisa, Maya], [Kueri lambat], [Uji alur utama]),
    ([12], [14 kasus uji, laporan harian, uji kegunaan], [Anisa, Fajar, Maya], [BUG-01], [Laporan bulanan]),
  ), sz: 8pt))

#pagebreak()
#lamp("C", "Dokumen Rujukan", stage: st-m2)
Lampiran ini mendaftar dokumen kerja tim yang dirujuk laporan, lengkap dengan versi, pemilik, dan bagian yang merujuknya (@tbl-rujukan). Tautannya ada di Lampiran E.
#v(0.3em)
#tabel("tbl-rujukan", [Dokumen rujukan tim], tbl((0.35fr, 2.2fr, 0.6fr, 1.2fr, 1.3fr, 2fr),
  ([No], [Dokumen], [Versi], [Pemilik], [Bagian yang merujuk], [Keterangan]),
  (
    ([1], [SRS (spesifikasi kebutuhan perangkat lunak)], [1.2], [Anisa], [Bab 2.1, Bab 4.2], [Kebutuhan fungsional dan non-fungsional]),
    ([2], [Desain Figma (wireframe, prototipe, hasil akhir)], [1.0], [Maya], [Bab 2.5], [Frame, design tokens, alur pengguna]),
    ([3], [PDM dan kamus data], [1.2], [Anisa], [Bab 2.3, Lampiran G], [Model data fisik dan kamus data]),
    ([4], [Rencana uji, kasus uji, dan catatan bug], [1.0], [Anisa], [Bab 4], [Hasil uji sampai Minggu 12]),
    ([5], [WBS dan jadwal (Gantt)], [1.3], [Rizky], [Bab 5.1], [Rincian pekerjaan tiga tingkat]),
    ([6], [Project Charter, Governance Log, Stakeholder Register], [1.1], [Rizky], [Bab 1.3, 1.4, 5.3], [Ruang lingkup, perubahan, pemangku kepentingan]),
  ), sz: 7.8pt))

#pagebreak()
#lamp("D", "Dokumen Tambahan Mata Kuliah", stage: st-m2)
Tidak ada dokumen tambahan, karena sampai batas waktu SOP belum ada dokumen tambahan yang diumumkan dosen secara tertulis. Jika ada, setiap dokumen dari dosen menjadi satu sub-lampiran (D.1, D.2, dan seterusnya) dan tidak mengulang isi laporan; untuk hal yang sudah ada di laporan, cukup rujuk babnya (SOP Bagian 7).

#pagebreak()
#lamp("E", "Daftar Tautan Eksternal", stage: st-m2)
Semua tautan di bawah ini bisa dibuka tanpa login, sudah kami uji di mode _incognito_, dan tidak akan diubah setelah batas akhir. @tbl-tautan memuat repositori, aplikasi, dan setiap dokumen yang didaftarkan di Lampiran C.
#v(0.3em)
#tabel("tbl-tautan", [Tautan eksternal], tbl((0.35fr, 2.2fr, 1.3fr, 2.5fr, 1.3fr),
  ([No], [Keterangan], [Bagian], [Tautan], [Jenis akses]),
  (
    ([1], [Repositori (_tag_ `milestone-2`)], [S.5, Bab 3], [`github.com/contoh/cuciku`], [Publik]),
    ([2], [Aplikasi CUCIKU], [S.5, Bab 3.5], [`cuciku.example.com`], [Publik]),
    ([3], [SRS], [Lampiran C, Bab 2.1], [`docs.example.com/cuciku/srs`], [Siapa saja dengan link]),
    ([4], [Desain Figma], [Lampiran C, Bab 2.5], [`figma.example.com/cuciku`], [Siapa saja dengan link]),
    ([5], [PDM dan kamus data], [Lampiran C, Bab 2.3], [`docs.example.com/cuciku/pdm`], [Siapa saja dengan link]),
    ([6], [Rencana uji, kasus uji, catatan bug], [Lampiran C, Bab 4], [`docs.example.com/cuciku/uji`], [Siapa saja dengan link]),
    ([7], [WBS dan jadwal (Gantt)], [Lampiran C, Bab 5.1], [`docs.example.com/cuciku/wbs`], [Siapa saja dengan link]),
    ([8], [Project Charter, Governance Log, Stakeholder Register], [Lampiran C, Bab 1.3], [`docs.example.com/cuciku/charter`], [Siapa saja dengan link]),
  ), sz: 7.8pt))
#v(0.3em)
#text(font: ui, size: 8.4pt, fill: muted)[Nama berkas yang dikumpulkan: `M2_SIB-2A_TimCuciKilat.pdf`.]

#pagebreak()
#lamp("G", "Dokumentasi Kueri Basis Data", stage: st-m2)
Lampiran ini memuat skema dan indeks, enam kueri, satu transaksi, satu _view_, dan satu trigger beserta fungsinya di aplikasi, lalu hasil uji `EXPLAIN ANALYZE` pada PostgreSQL 16. Semua skrip sama dengan `skema.sql` di repositori dan konsisten dengan PDM serta kamus data di Bab 2.3.

#show raw.where(block: true): set text(size: 6.8pt)
#show figure.where(kind: "kode"): set block(breakable: false)
#sub("G.1 Skema dan Indeks")
Skema dibuat dengan dua skrip. @kode-ddl-1 membuat tipe ENUM serta tabel pengguna dan data master, sedangkan @kode-ddl-2 membuat tabel transaksi, indeks, dan trigger pencatat status.

#kode("kode-ddl-1", [DDL: tipe, tabel pengguna, dan data master], ```sql
CREATE TYPE status_pesanan AS ENUM ('diterima', 'dicuci', 'siap', 'diambil');

CREATE TABLE peran (
  id    SMALLSERIAL PRIMARY KEY,
  nama  VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE pengguna (
  id           SERIAL PRIMARY KEY,
  peran_id     SMALLINT NOT NULL REFERENCES peran(id),
  nama         VARCHAR(80) NOT NULL,
  email        VARCHAR(100) NOT NULL UNIQUE,
  kata_sandi   VARCHAR(255) NOT NULL,
  aktif        BOOLEAN NOT NULL DEFAULT TRUE,
  dibuat_pada  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE pelanggan (
  pengguna_id  INT PRIMARY KEY REFERENCES pengguna(id) ON DELETE CASCADE,
  no_telepon   VARCHAR(20) NOT NULL,
  alamat       TEXT
);
CREATE TABLE kategori_layanan (
  id          SMALLSERIAL PRIMARY KEY,
  nama        VARCHAR(40) NOT NULL UNIQUE,
  keterangan  TEXT
);
CREATE TABLE layanan (
  id            SERIAL PRIMARY KEY,
  kategori_id   SMALLINT NOT NULL REFERENCES kategori_layanan(id),
  nama_layanan  VARCHAR(50) NOT NULL UNIQUE,
  harga_per_kg  NUMERIC(10,2) NOT NULL CHECK (harga_per_kg > 0),
  durasi_jam    INT NOT NULL CHECK (durasi_jam > 0),
  aktif         BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE metode_pembayaran (
  id     SMALLSERIAL PRIMARY KEY,
  nama   VARCHAR(20) NOT NULL UNIQUE,
  aktif  BOOLEAN NOT NULL DEFAULT TRUE
);
```)

#[
#show figure.where(kind: "kode"): set block(breakable: true)
#kode("kode-ddl-2", [DDL: tabel transaksi, indeks, dan trigger], ```sql
CREATE TABLE pesanan (
  id              SERIAL PRIMARY KEY,
  kode            VARCHAR(20) NOT NULL UNIQUE,
  pelanggan_id    INT NOT NULL REFERENCES pelanggan(pengguna_id),
  kasir_id        INT REFERENCES pengguna(id),
  status          status_pesanan NOT NULL DEFAULT 'diterima',
  tanggal_masuk   TIMESTAMPTZ NOT NULL DEFAULT now(),
  tanggal_jemput  DATE NOT NULL,
  total           NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (total >= 0)
);
CREATE TABLE item_pesanan (
  id            SERIAL PRIMARY KEY,
  pesanan_id    INT NOT NULL REFERENCES pesanan(id) ON DELETE CASCADE,
  layanan_id    INT NOT NULL REFERENCES layanan(id),
  berat_kg      NUMERIC(5,2) NOT NULL CHECK (berat_kg > 0),
  harga_satuan  NUMERIC(10,2) NOT NULL CHECK (harga_satuan > 0),
  subtotal      NUMERIC(12,2) GENERATED ALWAYS AS (berat_kg * harga_satuan) STORED
);
CREATE TABLE pembayaran (
  id            SERIAL PRIMARY KEY,
  pesanan_id    INT NOT NULL UNIQUE REFERENCES pesanan(id),
  metode_id     SMALLINT NOT NULL REFERENCES metode_pembayaran(id),
  jumlah        NUMERIC(12,2) NOT NULL CHECK (jumlah > 0),
  dibayar_pada  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE status_pesanan_log (
  id           BIGSERIAL PRIMARY KEY,
  pesanan_id   INT NOT NULL REFERENCES pesanan(id) ON DELETE CASCADE,
  status_lama  status_pesanan,
  status_baru  status_pesanan NOT NULL,
  diubah_oleh  INT REFERENCES pengguna(id),
  diubah_pada  TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_pesanan_status_jemput ON pesanan (status, tanggal_jemput);
CREATE INDEX idx_pesanan_pelanggan     ON pesanan (pelanggan_id);
CREATE INDEX idx_item_pesanan_pesanan  ON item_pesanan (pesanan_id);
CREATE INDEX idx_item_pesanan_layanan  ON item_pesanan (layanan_id);
CREATE INDEX idx_log_pesanan_waktu     ON status_pesanan_log (pesanan_id, diubah_pada);

CREATE FUNCTION catat_status_pesanan() RETURNS trigger AS $$
BEGIN
  IF TG_OP = 'INSERT' OR NEW.status IS DISTINCT FROM OLD.status THEN
    INSERT INTO status_pesanan_log (pesanan_id, status_lama, status_baru, diubah_oleh)
    VALUES (NEW.id, CASE WHEN TG_OP = 'UPDATE' THEN OLD.status END,
            NEW.status, NEW.kasir_id);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_status_pesanan
AFTER INSERT OR UPDATE OF status ON pesanan
FOR EACH ROW EXECUTE FUNCTION catat_status_pesanan();
```)
]

Indeks `idx_pesanan_status_jemput` dibuat untuk Q1 dan Q4 yang menyaring menurut status dan tanggal jemput, indeks kunci asing mempercepat gabungan tabel, dan `idx_log_pesanan_waktu` mempercepat Q6.

#sub("G.2 Kueri dan Fungsinya")
Trigger pencatat status sudah ada di @kode-ddl-2.

Q1 menampilkan pesanan yang belum diambil, terdekat dulu, untuk dasbor kasir (@kode-q1).

#kode("kode-q1", [Q1: pesanan yang belum diambil], ```sql
SELECT p.kode, u.nama, p.status, p.tanggal_jemput
FROM pesanan p JOIN pengguna u ON u.id = p.pelanggan_id
WHERE p.status <> 'diambil'
ORDER BY p.tanggal_jemput;
```)

Q2 menghitung pendapatan per hari dan rata-rata bergerak tujuh hari dengan window function (@kode-q2). Jendela `ROWS BETWEEN 6 PRECEDING AND CURRENT ROW` membuat garis tren di laporan lebih halus.

#kode("kode-q2", [Q2: pendapatan harian dan rata-rata bergerak], ```sql
SELECT tanggal, pendapatan,
       ROUND(AVG(pendapatan) OVER (ORDER BY tanggal
             ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 0) AS rata_rata_7_hari
FROM (SELECT dibayar_pada::date AS tanggal, SUM(jumlah) AS pendapatan
      FROM pembayaran GROUP BY dibayar_pada::date) h
ORDER BY tanggal;
```)

Q3 meranking layanan terlaris di dalam tiap kategori. `RANK()` memberi peringkat yang sama untuk total yang sama, dan `PARTITION BY` memulai peringkat dari awal pada setiap kategori (@kode-q3).

#kode("kode-q3", [Q3: layanan terlaris per kategori], ```sql
SELECT k.nama AS kategori, l.nama_layanan,
       SUM(i.berat_kg) AS total_kg,
       RANK() OVER (PARTITION BY k.nama ORDER BY SUM(i.berat_kg) DESC) AS peringkat
FROM item_pesanan i
JOIN layanan l ON l.id = i.layanan_id
JOIN kategori_layanan k ON k.id = l.kategori_id
GROUP BY k.nama, l.nama_layanan;
```)

Q4 mencari pesanan siap yang belum diambil melewati tanggal jemput, sebagai bahan pengingat (@kode-q4). Kueri inilah yang paling terbantu oleh indeks gabungan.

#kode("kode-q4", [Q4: pesanan siap yang terlambat diambil], ```sql
SELECT p.kode, u.nama, p.tanggal_jemput,
       CURRENT_DATE - p.tanggal_jemput AS terlambat_hari
FROM pesanan p JOIN pengguna u ON u.id = p.pelanggan_id
WHERE p.status = 'siap' AND p.tanggal_jemput < CURRENT_DATE;
```)

Q5 menjumlahkan pendapatan per metode bayar dan hanya menampilkan bulan yang memiliki pembayaran, memakai `GROUP BY` dengan `HAVING` (@kode-q5).

#kode("kode-q5", [Q5: pendapatan per metode pembayaran], ```sql
SELECT DATE_TRUNC('month', b.dibayar_pada) AS bulan, m.nama AS metode,
       COUNT(*) AS jumlah_transaksi, SUM(b.jumlah) AS pendapatan
FROM pembayaran b JOIN metode_pembayaran m ON m.id = b.metode_id
GROUP BY DATE_TRUNC('month', b.dibayar_pada), m.nama
HAVING SUM(b.jumlah) > 0
ORDER BY bulan, metode;
```)

Q6 memakai `LAG` untuk menghitung berapa lama sebuah pesanan berada pada setiap status, dari riwayat yang dicatat trigger (@kode-q6).

#kode("kode-q6", [Q6: lama setiap status pesanan], ```sql
SELECT pesanan_id, status_baru, diubah_pada,
       diubah_pada - LAG(diubah_pada) OVER (PARTITION BY pesanan_id
                                            ORDER BY diubah_pada) AS durasi_status_sebelumnya
FROM status_pesanan_log
WHERE pesanan_id = 301
ORDER BY diubah_pada;
```)

Transaksi pada @kode-trx menyimpan pesanan, barisnya, dan total sekaligus, atau tidak sama sekali. Angka 301 adalah nomor pesanan yang dihasilkan pada data uji.

#kode("kode-trx", [Transaksi penyimpanan pesanan], ```sql
BEGIN;
INSERT INTO pesanan (kode, pelanggan_id, tanggal_jemput)
VALUES ('PSN-0301', 5, '2026-11-20') RETURNING id;   -- 301
INSERT INTO item_pesanan (pesanan_id, layanan_id, berat_kg, harga_satuan)
VALUES (301, 1, 3.5, 7000), (301, 2, 1.0, 12000);
UPDATE pesanan p SET total = (SELECT SUM(subtotal) FROM item_pesanan i
                              WHERE i.pesanan_id = p.id)
WHERE p.id = 301;
COMMIT;
```)

View `v_laporan_pemilik` pada @kode-view menyimpan hitungan pendapatan harian sehingga halaman laporan cukup membaca satu tabel virtual.

#kode("kode-view", [View untuk laporan pemilik], ```sql
CREATE VIEW v_laporan_pemilik AS
SELECT b.dibayar_pada::date AS tanggal,
       COUNT(*) AS jumlah_pesanan,
       SUM(b.jumlah) AS pendapatan
FROM pembayaran b
GROUP BY b.dibayar_pada::date;
```)

#sub("G.3 Pengujian dengan EXPLAIN ANALYZE")
Pengujian memakai data uji 300 pesanan ditambah 20.000 pesanan buatan, sehingga `pesanan` berisi 20.300 baris. @gbr-q4-sebelum menunjukkan Q4 sebelum indeks dan @gbr-q4-sesudah sesudah `idx_pesanan_status_jemput` dibuat; perbandingan keduanya adalah bukti utama pengaruh indeks.

#console("gbr-q4-sebelum", [Q4 sebelum indeks: Seq Scan, 5,951 ms], "EXPLAIN ANALYZE
SELECT p.kode FROM pesanan p WHERE p.status = 'siap' AND p.tanggal_jemput < CURRENT_DATE;

Seq Scan on pesanan p  (cost=0.00..412.00 rows=38 width=10)
                       (actual time=0.040..5.912 rows=41 loops=1)
  Filter: ((status = 'siap'::status_pesanan) AND (tanggal_jemput < CURRENT_DATE))
  Rows Removed by Filter: 20259
Execution Time: 5.951 ms")

#console("gbr-q4-sesudah", [Q4 sesudah `idx_pesanan_status_jemput`: Index Scan, 0,104 ms], "Index Scan using idx_pesanan_status_jemput on pesanan p
    (cost=0.29..9.84 rows=38 width=10) (actual time=0.025..0.083 rows=41 loops=1)
  Index Cond: ((status = 'siap'::status_pesanan) AND (tanggal_jemput < CURRENT_DATE))
Execution Time: 0.104 ms")

Hasil pengujian ada di @tbl-g-hasil, termasuk Q2 dan Q3. Hanya Q4 yang berubah menjadi Index Scan dan mendapat percepatan besar, dari 5,9 ms menjadi 0,10 ms, lebih dari 50 kali lebih cepat. Seq Scan membaca semua baris tabel, sedangkan Index Scan langsung menuju baris yang dicari. Q2 dan Q3 sudah cukup cepat untuk data saat ini.

#tabel("tbl-g-hasil", [Hasil pengujian EXPLAIN ANALYZE], tbl((0.6fr, 1fr, 1fr, 1fr, 2.4fr),
  ([Kueri], [Baris data uji], [Jenis _scan_], [_Execution time_], [Catatan]),
  (
    ([Q4], [20.300], [Seq Scan], [5,9 ms], [Belum ada indeks]),
    ([Q4], [20.300], [Index Scan], [0,10 ms], [Setelah indeks gabungan ditambah]),
    ([Q2], [20.300], [Seq Scan], [9,7 ms], [Cukup cepat untuk saat ini]),
    ([Q3], [20.300], [Seq Scan], [14,2 ms], [Cukup cepat untuk saat ini]),
  ), sz: 8pt))

#pagebreak()
#lamp("H", "Deklarasi Penggunaan AI", stage: st-lanjutan)
Daftar berikut menyebutkan bagian yang dibantu AI, alatnya, dan tujuannya pada @tbl-ai. Seluruh anggota memahami dan dapat menjelaskan hasil yang dibantu AI.
#v(0.3em)
#tabel("tbl-ai", [Deklarasi penggunaan AI], tbl((1.6fr, 1.2fr, 2.4fr),
  ([Bagian], [Alat], [Tujuan]),
  (
    ([Kueri laporan (Q2, Q3)], [Asisten kode], [Saran penulisan; ditinjau dan diuji oleh Anisa]),
    ([Perbaikan bahasa Bab 1], [Asisten menulis], [Merapikan kalimat; isi ditulis tim]),
  ), sz: 8pt))
