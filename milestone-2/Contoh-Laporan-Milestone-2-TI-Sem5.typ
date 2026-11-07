#import "contoh-lib.typ": *
#show: doc => contoh(product: "CELAH", team: "Tim Peka Pasar",
  title: "Contoh Laporan Milestone 2 PBL (CELAH, TI Semester 5)", doc)
#show figure.where(kind: "kode"): set block(breakable: false)

// subjudul di dalam Lampiran F (F.1 sampai F.5)
#let fsub(t) = block(sticky: true, above: 1em, below: 0.4em, text(font: serif, size: 10.4pt, weight: 700, fill: ink)[#t])

#cover-celah(
  product: "CELAH",
  subtitle: "Analisis Otomatis Ulasan Google Maps untuk Peluang Usaha",
  prodi: "Program Studi Teknik Informatika, Semester 5",
  team: "Tim Peka Pasar", class-line: "Kelas TI-3B",
  members: "Bagas Wicaksono, Intan Permata Sari, Dimas Arya Pratama, Laras Anindita Putri",
  year-line: "Tahun Akademik 2026/2027 · November 2026",
  headline: "Peluang Usaha Tersembunyi di Balik Ulasan Maps", accent-word: "",
  coverlines: (("Di ponsel", "Model 2 MB yang berjalan tanpa server"), ("Evaluasi", "Mengapa \"Kebersihan\" paling sulit ditebak"), ("Biaya", "Operasional nol rupiah"),)
)
#counter(page).update(1)

#usage-note()

// =====================================================================
// LEMBAR STATUS
// =====================================================================
#part("Lembar Status Milestone 2", "Posisi Proyek pada Minggu 12")
#pill(st-hapus)
#v(0.5em)
#fakta((("Status", "Sebagian"), ("Kelas", "TI-3B"), ("Dosen rujukan", "Rujukan TI-3B"), ("Tim", "Tim Peka Pasar")))

#sec("S.1", "Identitas dan Dosen")
#tbl((1.6fr, 1.1fr, 1.9fr, 1.5fr),
  ([Nama], [NIM], [Peran saat ini], [Perubahan dari Milestone 1]),
  (
    ([Bagas Wicaksono], [2441 0000 0001], [Ketua Tim, pengembang mobile], [Tidak ada]),
    ([Intan Permata Sari], [2441 0000 0002], [Pengembang model ML], [Tidak ada]),
    ([Dimas Arya Pratama], [2441 0000 0003], [Penguji (QA)], [Tidak ada]),
    ([Laras Anindita Putri], [2441 0000 0004], [Desainer dan dokumentator], [Menambah pelabelan data sejak Minggu 9]),
  ), sz: 8.2pt)
#v(0.3em)
#text(size: 9.4pt)[Dosen pengampu: Pemrograman Mobile, Pembelajaran Mesin, dan Penjaminan Mutu Perangkat Lunak. Dosen rujukan kelas: Dosen Rujukan TI-3B.]

#sec("S.2", "Status Milestone 2")
Status kami Sebagian. Aplikasi Flutter berjalan di dua ponsel uji: pengguna memilih lokasi dan kategori, model TFLite di ponsel mengklasifikasikan topik keluhan pada ulasan, lalu aplikasi menampilkan daftar peluang usaha. Macro-F1 model pada data uji 0,82 (target 0,80), tetapi recall kelas "Kebersihan" baru 0,73 (target 0,75). Dari 15 kasus uji, 13 lulus dan 2 gagal (BUG-02 dan BUG-04). Rencana perbaikan ada di Bab 4.4 dan S.6.

#sec("S.3", "Tindak Lanjut Milestone 1")
#tbl((2.2fr, 1.4fr, 2.3fr, 0.8fr),
  ([Umpan balik Milestone 1], [Mata kuliah], [Tindak lanjut], [Status]),
  (
    ([Tambahkan pembanding selain Naive Bayes], [Pembelajaran Mesin], [Logistic Regression dan 1D-CNN ditambahkan (Lampiran F.3)], [Selesai]),
    ([Rencana uji belum memuat uji kecepatan], [Penjaminan Mutu], [Uji waktu analisis ditambahkan sebagai TC-14], [Selesai]),
  ), sz: 8.2pt)

#sec("S.4", "Capaian Produk")
Sudah berjalan: izin dan deteksi lokasi (dengan pilihan manual), daftar tempat per kategori, klasifikasi keluhan di perangkat, daftar peluang berurut skor, dan riwayat yang bisa dibuka tanpa internet. Sebagian atau belum: recall "Kebersihan", ulasan dengan dua keluhan (BUG-02), ulasan campur bahasa (BUG-04), dan ekspor ringkasan ke PDF yang dijadwalkan di Minggu 15. Untuk target TI Semester 5, alur utama aplikasi sudah berjalan, model sudah bisa dipanggil dari aplikasi, hasil awal model tertulis di Lampiran F, Bab 1 sampai 3 selesai, dan Bab 4 memuat 15 kasus uji.

#sec("S.5", "Bukti")
#tbl((1.1fr, 2fr, 2.1fr),
  ([Aspek], [Pilihan tim], [Tautan atau keterangan]),
  (
    ([Bentuk demo], [Langsung di kelas], [Jadwal kelas TI-3B, Minggu 12]),
    ([Cara pasang], [Berkas instalasi (APK)], [`github.com/contoh/celah/releases`]),
    ([Repositori], [Git dengan _tag_ `milestone-2`], [`github.com/contoh/celah`]),
    ([Masukan pengguna], [Mitra dan calon pengguna (4 orang)], [Bab 4.5]),
    ([Bukti pengujian], [Uji manual dan hasil awal model], [Bab 4 dan Lampiran F]),
  ), sz: 8.2pt)

#sec("S.6", "Rencana Minggu 13–16")
#tbl((0.7fr, 3.2fr, 1.2fr),
  ([Minggu], [Target], [Penanggung jawab]),
  (
    ([13], [Menambah sekitar 150 ulasan "Kebersihan", melabel ulang batas kelas bersama mitra, dan memperbaiki BUG-04 dengan kamus normalisasi], [Intan, Laras]),
    ([14], [Melatih ulang model (class weight 2,0), menampilkan topik kedua untuk BUG-02, dan menguji ulang di dua ponsel], [Intan, Bagas, Dimas]),
    ([15], [Membuat ekspor ringkasan, menyempurnakan Bab 1–5, dan menyiapkan materi demo], [Seluruh tim]),
    ([16], [Demo Day dan Expo], [Seluruh tim]),
  ), sz: 8.2pt)

#pagebreak()

#toc-page()

// =====================================================================
// BAB 1
// =====================================================================
#chapter("Bab 1", "Pendahuluan")
#lead[Bab ini menjelaskan masalah riset pasar usaha kecil, batas produk yang kami bangun, dan lima ukuran keberhasilan. Empat dari lima ukuran itu sudah tercapai pada Minggu 12.]

#sec("1.1", "Latar Belakang dan Rumusan Masalah", stage: st-proposal)
Calon pemilik usaha kecil, misalnya yang ingin membuka kafe, warung makan, atau laundry, biasanya memilih lokasi dan jenis usaha dengan berkeliling area dan bertanya ke pemilik usaha lain. Tiga pemilik usaha mitra yang kami wawancarai menyebut riset seperti itu memakan tiga sampai empat hari untuk satu area, dan hasilnya sulit dibandingkan antar area karena bergantung pada kesan pribadi.

Padahal keluhan yang jujur sudah tertulis di ulasan Google Maps: antrean lama, harga tidak sepadan, tempat kotor. Dari 2.400 ulasan yang kami kumpulkan dan beri label untuk 60 tempat usaha di Malang, 58,3% memuat keluhan (Lampiran F.1). Keluhan yang berulang di satu area menandakan kebutuhan yang belum dilayani, tetapi tidak ada orang yang sanggup membaca ratusan ulasan untuk setiap area.

Dari sisi biaya, riset manual memakan beberapa hari per area, sedangkan CELAH menyelesaikannya dalam hitungan detik. Biaya operasional kami hampir nol. Skrip terjadwal mengambil ulasan sekali sehari lewat Google Places API (kuota gratis) dan ekspor ulasan dari tiga mitra, hasilnya disimpan sebagai berkas JSON di hosting statis gratis, dan model berjalan di ponsel pengguna. Kami tidak memakai server atau layanan berbayar. Rumusan masalahnya: bagaimana menemukan peluang usaha di suatu area secara otomatis dari keluhan pada ulasan Google Maps, dengan biaya operasional hampir nol?

#sec("1.2", "Tujuan", stage: st-proposal)
Menghasilkan aplikasi _mobile_ yang mengklasifikasikan keluhan pada ulasan tempat usaha di sekitar pengguna, lalu mengurutkan peluang usaha di area itu, dengan model yang berjalan di perangkat dan dievaluasi dengan metrik yang jelas.

#sec("1.3", "Cakupan Fitur dan Batasan", stage: st-proposal)
Cakupan produk sudah kami tetapkan sejak awal dalam Project Charter versi 1.1 (Lampiran C). Kami membangun aplikasi Android yang memilih lokasi dan kategori, mengklasifikasikan keluhan di perangkat, lalu menyusun peluang usaha dan menyimpan riwayatnya untuk dibuka tanpa internet. Beberapa hal sengaja kami tinggalkan supaya tim berempat bisa menyelesaikannya dalam satu semester: scraping halaman Maps (melanggar ketentuan layanan), prediksi omzet atau keuntungan, akun pengguna dan server berbayar, serta versi iOS.

Asumsinya, ulasan berbahasa Indonesia, kategori awal ada tiga (kafe, warung makan, laundry), dan data per area diperbarui sekali sehari. Perubahan cakupan sejak proposal dicatat di Governance Log dan diringkas pada Bab 5.3.

Soal etika data, kami hanya memakai Google Places API resmi, yang mengembalikan paling banyak 5 ulasan per tempat per panggilan. Ekspor ulasan dari mitra kami pakai dengan izin tertulis. Dari setiap ulasan hanya teks dan jumlah bintang yang disimpan, tanpa nama atau identitas pengulas, sehingga data tidak bisa ditelusuri ke orang tertentu.

#sec("1.4", "Pemangku Kepentingan dan Manfaat", stage: st-proposal)
Daftar lengkapnya ada di Stakeholder Register versi 1.0 (Lampiran C). Yang paling menentukan bentuk produk ada dua. Pertama tiga pemilik usaha mitra, yang memberi ekspor ulasan, menilai apakah topik keluhan terasa benar, dan kami temui dua minggu sekali dengan izin tertulis. Kedua penyedia Places API, yang ketentuan layanannya membatasi data yang boleh kami ambil, sehingga dokumentasinya kami pantau tiap minggu.

Pemangku kepentingan lain adalah tiga calon pelaku usaha sebagai pengguna utama, tiga dosen pengampu sebagai penilai, dan Dosen Rujukan TI-3B yang menyetujui perubahan lewat Governance Log. Calon pelaku usaha sengaja baru kami libatkan setelah alur utama berjalan, supaya masukan mereka berasal dari aplikasi yang sudah bisa dicoba. Pembagian komunikasi juga sudah jelas: Bagas menghubungi dosen rujukan, Laras menghubungi mitra, dan Intan memantau dokumentasi API.

#sec("1.5", "Kriteria Keberhasilan", stage: st-proposal)
Ada lima kriteria yang kami ambil dari proposal tanpa diubah. Macro-F1 pada data uji minimal 0,80, dan recall tiap kelas keluhan minimal 0,75; keduanya diukur dengan notebook evaluasi (Lampiran F.4). Analisis 50 ulasan di ponsel kelas menengah harus selesai kurang dari 5 detik (kasus uji TC-14). Tidak boleh ada bug tingkat tinggi yang terbuka (Bab 4.3), dan biaya operasional tetap Rp0.

Pada Minggu 12 empat kriteria sudah terpenuhi: macro-F1 0,82, waktu analisis 2,1 detik di ponsel A dan 3,4 detik di ponsel B, tidak ada bug tingkat tinggi yang terbuka, dan biaya Rp0. Yang belum adalah recall "Kebersihan" yang baru 0,73. Kami sengaja tidak melonggarkan target itu, karena rencana Minggu 13 dan 14 dibuat untuk mengejarnya.

Kriteria ini saling tarik. Model yang lebih besar mungkin lebih akurat tetapi lebih lambat di ponsel, dan data tambahan berarti lebih banyak kuota API. Karena itu kelimanya kami periksa bersama setiap ada perubahan besar. Perbandingan akhirnya ditulis di Bab 4.6 pada laporan akhir.

// =====================================================================
// BAB 2
// =====================================================================
#chapter("Bab 2", "Analisis Kebutuhan dan Perancangan")
#lead[Bab ini memuat kebutuhan, susunan sistem, basis data, model, dan antarmuka. Keputusan terpenting: pengumpulan data dipisahkan dari aplikasi, sehingga tidak ada server yang perlu dibayar.]

#sec("2.1", "Kebutuhan Pengguna dan Daftar Fitur", stage: st-proposal)
Kebutuhan produk tertulis di SRS versi 1.2 (Lampiran C). Perannya ada tiga: calon pelaku usaha sebagai pengguna utama, pemilik usaha yang ingin melihat keluhan di tempatnya sendiri, dan skrip pengumpul data yang memperbarui data tiap hari. Dari wawancara dengan mitra dan tujuan di Bab 1 kami menyusun sepuluh kebutuhan fungsional dan lima non-fungsional, seperti di @tbl-srs.

#tabel("tbl-srs", [Kebutuhan dari SRS versi 1.2, prioritas, dan status pada Minggu 12],
  tbl((0.6fr, 3.8fr, 0.8fr, 0.8fr),
  ([Kode], [Kebutuhan], [Prioritas], [Status]),
  (
    ([FR-01], [Pengguna memilih lokasi (GPS atau manual) dan kategori usaha], [Tinggi], [Selesai]),
    ([FR-02], [Aplikasi meminta izin lokasi dan tetap bisa dipakai bila izin ditolak], [Tinggi], [Selesai]),
    ([FR-03], [Aplikasi menampilkan daftar tempat per kategori beserta bintang rata-rata], [Tinggi], [Selesai]),
    ([FR-04], [Aplikasi mengklasifikasikan tiap ulasan ke lima topik di perangkat], [Tinggi], [Selesai]),
    ([FR-05], [Aplikasi menampilkan grafik topik keluhan per tempat atau per area], [Tinggi], [Selesai]),
    ([FR-06], [Aplikasi menampilkan peluang usaha berurut skor beserta saran singkat], [Tinggi], [Selesai]),
    ([FR-07], [Pengguna menyimpan hasil ke riwayat dan membukanya tanpa internet], [Sedang], [Selesai]),
    ([FR-08], [Ulasan dengan dua keluhan menampilkan topik kedua], [Sedang], [Belum]),
    ([FR-09], [Pemilik usaha melihat keluhan terbanyak di tempatnya sendiri], [Sedang], [Sebagian]),
    ([FR-10], [Pengguna mengekspor ringkasan analisis ke PDF], [Rendah], [Belum]),
    ([NFR-01], [Analisis 50 ulasan selesai kurang dari 5 detik di ponsel kelas menengah], [Tinggi], [Selesai]),
    ([NFR-02], [Macro-F1 minimal 0,80 dan recall tiap kelas keluhan minimal 0,75], [Tinggi], [Sebagian]),
    ([NFR-03], [Aplikasi berjalan di Android 8 ke atas pada dua ponsel uji], [Sedang], [Selesai]),
    ([NFR-04], [Hanya teks dan bintang yang disimpan, biaya operasional Rp0], [Tinggi], [Selesai]),
    ([NFR-05], [Ukuran model TFLite tidak lebih dari 5 MB], [Sedang], [Selesai]),
  ), sz: 7.8pt))

Tujuh kebutuhan fungsional sudah selesai. FR-09 baru berupa filter sederhana, sedangkan FR-08 dan FR-10 belum dikerjakan dan masuk rencana Minggu 14 dan 15. Dari kebutuhan non-fungsional, hanya NFR-02 yang masih Sebagian karena recall "Kebersihan" belum mencapai target.

#sec("2.2", "Susunan Komponen Sistem", stage: st-proposal)
Sistem CELAH terdiri atas tiga bagian, seperti terlihat pada @gbr-arsitektur. Job harian di GitHub Actions menjalankan skrip Python yang mengambil ulasan lewat Places API dan menggabungkannya dengan ekspor mitra. Hasilnya terbit sebagai JSON statis per area di hosting gratis, yang diunduh aplikasi Flutter. Model TFLite di ponsel lalu mengklasifikasikan tiap ulasan.

#gambar("gbr-arsitektur", [Tiga komponen CELAH: job harian, JSON statis, dan aplikasi di ponsel],
  flow(([Job harian (Python, GitHub Actions, Places API)], [JSON ulasan per area di hosting statis], [Aplikasi Flutter dengan model TFLite])))

Satu-satunya bagian yang berjalan terus adalah job harian, dan itu hanya aktif beberapa menit sehari. Aplikasi tidak pernah memanggil Places API langsung, sehingga kuota gratis tidak habis oleh jumlah pengguna dan kunci API tidak tertanam di ponsel. Konsekuensinya, data terbaru yang bisa dilihat pengguna adalah data kemarin. Kami menilai itu cukup untuk keputusan membuka usaha.

Klasifikasi di ponsel juga menjaga biaya tetap nol. Harganya, ukuran model dan kecepatan analisis harus sesuai kemampuan ponsel kelas menengah, dan itu diperiksa lewat NFR-01 dan NFR-05.

#sec("2.3", "Rancangan Basis Data", stage: st-proposal)
Aplikasi menyimpan data lokal di SQLite dengan delapan tabel: `area`, `kategori`, `tempat`, `ulasan`, `topik`, `analisis`, `analisis_topik`, dan `peluang`. Rancangan fisiknya ada pada @gbr-pdm di halaman terakhir bab ini, lengkap dengan tipe data SQLite, tanda kunci (PK, FK, UQ), dan kardinalitas relasi. Tabel `analisis`, `analisis_topik`, dan `peluang` menyimpan hasil yang dibuka lagi di layar Riwayat. Gambar, kamus data (@tbl-kamus1 dan @tbl-kamus2), dan DDL (@kode-ddl di Bab 3.3) kami buat identik supaya mudah dicocokkan.

Semua kunci asing aktif lewat `PRAGMA foreign_keys = ON`. Menghapus sebuah `area` ikut menghapus `tempat` dan `ulasan` miliknya, dan menghapus sebuah `analisis` menghapus hitungan topik dan peluangnya. Pasangan `tempat_id` dan `hash_teks` unik, sehingga ulasan yang sama tidak masuk dua kali ketika JSON diunduh ulang. Berkas JSON dan dataset pelatihan berada di luar SQLite (Lampiran F).

Rancangan proposal sebenarnya menyimpan hitungan topik sebagai satu kolom JSON di tabel `analisis`. Itu melanggar bentuk normal pertama, jadi kami memecahnya menjadi baris di `analisis_topik` dengan kunci utama gabungan. Nama area dan kategori dirujuk lewat `area_id` dan `kategori_id`. Dua kolom sengaja tidak dinormalisasi: `tempat.bintang_rata` dan `jumlah_ulasan` berasal dari Places API yang menghitung semua ulasan, dan `peluang.saran` disimpan supaya riwayat tidak berubah ketika templat saran diperbarui.

#tabel("tbl-kamus1", [Kamus data (1): tabel `area`, `kategori`, `tempat`, dan `ulasan`],
  tbl((1.3fr, 1.2fr, 0.8fr, 1.5fr, 2.5fr),
  ([Tabel], [Kolom], [Tipe], [Batasan], [Keterangan]),
  (
    ([`area`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor area]),
    ([`area`], [`nama`], [TEXT], [UQ, NOT NULL], [Nama area, misalnya Lowokwaru]),
    ([`area`], [`lat`, `lon`], [REAL], [NOT NULL], [Titik tengah area]),
    ([`area`], [`tanggal_data`], [TEXT], [NOT NULL], [Tanggal JSON terakhir yang diunduh (ISO 8601), dipakai untuk memperbarui cache]),
    ([`kategori`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor kategori]),
    ([`kategori`], [`nama`], [TEXT], [UQ, NOT NULL], [Kafe, Warung makan, atau Laundry]),
    ([`kategori`], [`kata_kunci`], [TEXT], [NOT NULL], [Kata kunci pencarian Places API]),
    ([`tempat`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor tempat]),
    ([`tempat`], [`area_id`], [INTEGER], [FK ke `area`, NOT NULL], [Area tempat berada]),
    ([`tempat`], [`kategori_id`], [INTEGER], [FK ke `kategori`, NOT NULL], [Kategori usaha]),
    ([`tempat`], [`place_id`], [TEXT], [UQ, NOT NULL], [Pengenal tempat dari Places API]),
    ([`tempat`], [`nama`, `alamat`], [TEXT], [`nama` NOT NULL], [Nama dan alamat tempat]),
    ([`tempat`], [`bintang_rata`], [REAL], [1 sampai 5], [Bintang rata-rata dari Places API (semua ulasan)]),
    ([`tempat`], [`jumlah_ulasan`], [INTEGER], [NOT NULL, bawaan 0], [Jumlah ulasan di Google Maps]),
    ([`ulasan`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor ulasan]),
    ([`ulasan`], [`tempat_id`], [INTEGER], [FK ke `tempat`, NOT NULL], [Tempat yang diulas]),
    ([`ulasan`], [`teks`], [TEXT], [NOT NULL], [Isi ulasan tanpa identitas pengulas]),
    ([`ulasan`], [`bintang`], [INTEGER], [1 sampai 5], [Jumlah bintang]),
    ([`ulasan`], [`tanggal`], [TEXT], [NOT NULL], [Tanggal ulasan (ISO 8601)]),
    ([`ulasan`], [`hash_teks`], [TEXT], [UQ bersama `tempat_id`], [Ringkasan SHA-1 teks, mencegah ulasan ganda]),
  ), sz: 7.2pt))

#tabel("tbl-kamus2", [Kamus data (2): tabel `topik`, `analisis`, `analisis_topik`, dan `peluang`],
  tbl((1.3fr, 1.2fr, 0.8fr, 1.5fr, 2.5fr),
  ([Tabel], [Kolom], [Tipe], [Batasan], [Keterangan]),
  (
    ([`topik`], [`id`], [INTEGER], [PK], [Nomor topik, diisi saat basis data dibuat]),
    ([`topik`], [`kode`], [TEXT], [UQ, NOT NULL], [Kode tetap: BK, PL, WT, HG, KB]),
    ([`topik`], [`nama`], [TEXT], [NOT NULL], [Bukan keluhan, Pelayanan, Waktu tunggu, Harga, atau Kebersihan]),
    ([`analisis`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor analisis]),
    ([`analisis`], [`area_id`], [INTEGER], [FK ke `area`, NOT NULL], [Area yang dianalisis]),
    ([`analisis`], [`kategori_id`], [INTEGER], [FK ke `kategori`, NOT NULL], [Kategori yang dianalisis]),
    ([`analisis`], [`waktu`], [TEXT], [NOT NULL], [Waktu analisis dijalankan (ISO 8601)]),
    ([`analisis`], [`jumlah_ulasan`], [INTEGER], [NOT NULL], [Banyaknya ulasan yang dianalisis]),
    ([`analisis_topik`], [`analisis_id`], [INTEGER], [PK, FK ke `analisis`], [Analisis pemilik hitungan]),
    ([`analisis_topik`], [`topik_id`], [INTEGER], [PK, FK ke `topik`], [Topik yang dihitung]),
    ([`analisis_topik`], [`jumlah`], [INTEGER], [NOT NULL], [Jumlah ulasan pada topik itu]),
    ([`analisis_topik`], [`persen`], [REAL], [0 sampai 100], [Persentase topik dari seluruh ulasan]),
    ([`peluang`], [`id`], [INTEGER], [PK, otomatis naik], [Nomor peluang]),
    ([`peluang`], [`analisis_id`], [INTEGER], [FK ke `analisis`, NOT NULL], [Analisis asal peluang]),
    ([`peluang`], [`topik_id`], [INTEGER], [FK ke `topik`, NOT NULL], [Topik keluhan yang menjadi peluang]),
    ([`peluang`], [`skor`], [REAL], [NOT NULL], [Skor peluang (Bab 2.6)]),
    ([`peluang`], [`peringkat`], [INTEGER], [NOT NULL], [Urutan tampil, 1 untuk skor tertinggi]),
    ([`peluang`], [`saran`], [TEXT], [NOT NULL], [Saran singkat dari templat topik]),
  ), sz: 7.2pt))

#sec("2.4", "Rancangan Model ML", stage: st-proposal)
Tugas model adalah klasifikasi teks Bahasa Indonesia ke lima kelas: Bukan keluhan, Pelayanan, Waktu tunggu, Harga, dan Kebersihan. Masukannya satu ulasan sepanjang paling banyak 80 token, keluarannya lima skor yang dijumlahkan menjadi satu. Kami memilih 1D-CNN dengan lapisan _embedding_ karena modelnya kecil, cepat di ponsel, dan lebih peka pada konteks kata dibanding model berbasis frekuensi kata.

Arsitekturnya _embedding_ 64 dimensi, dua lapisan konvolusi 1D, dropout 0,4, dan keluaran softmax, dengan kosakata 8.000 kata. Pembandingnya TF-IDF dengan Naive Bayes (baseline) dan Logistic Regression. Targetnya sama dengan kriteria di Bab 1.5, ditambah ukuran model maksimal 5 MB (NFR-05). Rincian data, praproses, dan evaluasi ada di Lampiran F.

#sec("2.5", "Rancangan Antarmuka", stage: st-proposal)
Desain dibuat di Figma dalam satu berkas (versi 1.0, tautan di Lampiran E) dengan tiga halaman: Alur, Komponen, dan Layar. Isinya 19 frame, yaitu 1 alur pengguna, 6 komponen, dan 12 layar termasuk kondisi kosong, memuat, dan kesalahan. Lima layar utama dan rutenya di aplikasi tercantum pada @tbl-frame.

#tabel("tbl-frame", [Frame utama pada berkas Figma],
  tbl((1.3fr, 0.9fr, 3fr),
  ([Frame], [Rute], [Isi]),
  (
    ([Pilih lokasi dan kategori], [`/`], [Izin lokasi, pilihan area manual bila izin ditolak, pilihan kategori]),
    ([Daftar tempat], [`/tempat`], [Tempat usaha di area itu beserta bintang rata-rata, juga kondisi kosong]),
    ([Analisis keluhan], [`/analisis`], [Grafik batang topik keluhan satu tempat atau satu area, juga kondisi memuat]),
    ([Peluang usaha], [`/peluang`], [Kartu peluang berurut skor dengan saran singkat]),
    ([Riwayat], [`/riwayat`], [Analisis yang pernah disimpan, bisa dibuka tanpa internet]),
  ), sz: 8pt))

Warna, huruf, dan jarak kami tetapkan sebagai _design token_ di Figma lalu kami salin ke tema Flutter: biru petrol `#0B6E8A` untuk bilah judul, tombol, dan batang grafik, aksen `#F2A33A` untuk skor peluang, `#B3261E` untuk kesalahan, huruf Inter (judul 20, isi 14), dan jarak kelipatan 8 dp. Alur pengguna dari membuka aplikasi sampai menyimpan hasil tergambar pada @gbr-alur.

#gambar("gbr-alur", [Alur pengguna utama CELAH],
  flow(([Buka aplikasi dan beri izin lokasi], [Pilih area dan kategori], [Lihat daftar tempat], [Analisis topik keluhan], [Lihat peluang usaha], [Simpan ke riwayat])))

Laras menggambar lima wireframe sederhana lebih dulu (@gbr-wire). Dua hal berubah di layar jadi: layar Pilih lokasi mendapat dialog penjelasan sebelum dialog izin sistem karena dua mitra bingung mengapa lokasi diminta, dan kartu peluang diberi tombol "Lihat saran" karena calon pengguna ingin saran yang lebih konkret (Bab 4.5).

#gambar("gbr-wire", [Wireframe lima layar utama],
  grid(columns: (1fr,) * 5, column-gutter: 6pt,
    wire("Pilih lokasi", (("bar", "CELAH", 0.5), ("img", "Peta area (Malang)", 1.2), ("input", "Pilih area manual", 0.5), ("list", "3 kategori", 0.6), ("btn", "Mulai analisis", 0.55)), w: 2.6cm, h: 4.8cm),
    wire("Daftar tempat", (("input", "Cari tempat", 0.5), ("list", "Kafe Senja, 4,4", 0.6), ("list", "Kopi Lawang, 4,2", 0.6), ("list", "Kedai Rindu, 4,0", 0.6), ("btn", "Analisis area", 0.55)), w: 2.6cm, h: 4.8cm),
    wire("Analisis keluhan", (("bar", "Kafe Senja", 0.5), ("chart", "Grafik batang topik", 1.3), ("list", "Waktu tunggu 38%", 0.55), ("list", "Pelayanan 24%", 0.55), ("btn", "Simpan", 0.55)), w: 2.6cm, h: 4.8cm),
    wire("Peluang usaha", (("card", "1. Waktu tunggu 1,82", 0.6), ("card", "2. Harga 1,20", 0.6), ("card", "3. Pelayanan 0,95", 0.6), ("btn", "Lihat saran", 0.55)), w: 2.6cm, h: 4.8cm),
    wire("Riwayat", (("list", "Kafe, Lowokwaru", 0.6), ("list", "Laundry, Sukun", 0.6), ("list", "Warung, Klojen", 0.6), ("list", "Kafe, Blimbing", 0.6), ("btn", "Hapus riwayat", 0.55)), w: 2.6cm, h: 4.8cm),
  ))

#sec("2.6", "Rancangan Dasbor Peluang", stage: st-proposal)
Skor peluang sebuah topik di suatu area adalah persentase topik itu di antara semua keluhan, dikalikan logaritma natural jumlah ulasan area tersebut. Logaritma mencegah area dengan ulasan sangat sedikit menang otomatis. Bila 38% keluhan di area kafe soal waktu tunggu dan areanya punya 120 ulasan, skornya 0,38 dikali 4,79, yaitu sekitar 1,82.

Kartu peluang menampilkan topik, persentase, skor, dan satu kalimat saran dari templat. Urutannya mengikuti skor tertinggi, dan hitungan di aplikasi dicocokkan dengan spreadsheet pada TC-10.

#pdm-page("gbr-pdm", [PDM basis data SQLite di perangkat (8 tabel)],
  (
    (name: "area", col: 0, row: 1, cols: (("id", "INTEGER", "PK"), ("nama", "TEXT", "UQ"), ("lat", "REAL", ""), ("lon", "REAL", ""), ("tanggal_data", "TEXT", ""))),
    (name: "tempat", col: 1, row: 0, cols: (("id", "INTEGER", "PK"), ("area_id", "INTEGER", "FK"), ("kategori_id", "INTEGER", "FK"), ("place_id", "TEXT", "UQ"), ("nama", "TEXT", ""), ("alamat", "TEXT", ""), ("bintang_rata", "REAL", ""), ("jumlah_ulasan", "INTEGER", ""))),
    (name: "ulasan", col: 0, row: 0, cols: (("id", "INTEGER", "PK"), ("tempat_id", "INTEGER", "FK"), ("teks", "TEXT", ""), ("bintang", "INTEGER", ""), ("tanggal", "TEXT", ""), ("hash_teks", "TEXT", "UQ"))),
    (name: "analisis", col: 1, row: 1, cols: (("id", "INTEGER", "PK"), ("area_id", "INTEGER", "FK"), ("kategori_id", "INTEGER", "FK"), ("waktu", "TEXT", ""), ("jumlah_ulasan", "INTEGER", ""))),
    (name: "kategori", col: 2, row: 0, cols: (("id", "INTEGER", "PK"), ("nama", "TEXT", "UQ"), ("kata_kunci", "TEXT", ""))),
    (name: "analisis_topik", col: 0, row: 2, cols: (("analisis_id", "INTEGER", "PK,FK"), ("topik_id", "INTEGER", "PK,FK"), ("jumlah", "INTEGER", ""), ("persen", "REAL", ""))),
    (name: "peluang", col: 2, row: 2, cols: (("id", "INTEGER", "PK"), ("analisis_id", "INTEGER", "FK"), ("topik_id", "INTEGER", "FK"), ("skor", "REAL", ""), ("peringkat", "INTEGER", ""), ("saran", "TEXT", ""))),
    (name: "topik", col: 1, row: 2, cols: (("id", "INTEGER", "PK"), ("kode", "TEXT", "UQ"), ("nama", "TEXT", ""))),
  ),
  (
    (parent: "area", child: "tempat", fk: "area_id", a: "1", b: "N"),
    (parent: "kategori", child: "tempat", fk: "kategori_id", a: "1", b: "N"),
    (parent: "topik", child: "peluang", fk: "topik_id", a: "1", b: "N"),
    (parent: "tempat", child: "ulasan", fk: "tempat_id", a: "1", b: "N"),
    (parent: "analisis", child: "peluang", fk: "analisis_id", a: "1", b: "N"),
    (parent: "area", child: "analisis", fk: "area_id", a: "1", b: "N"),
    (parent: "kategori", child: "analisis", fk: "kategori_id", a: "1", b: "N"),
    (parent: "analisis", child: "analisis_topik", fk: "analisis_id", a: "1", b: "N"),
    (parent: "topik", child: "analisis_topik", fk: "topik_id", a: "1", b: "N"),
  ), cols: 3)

// =====================================================================
// BAB 3
// =====================================================================
#chapter("Bab 3", "Implementasi")
#lead[Bab ini memuat apa yang sudah berjalan sampai Minggu 12. Pekerjaan tersulit ternyata bukan melatih model, melainkan membuat pra-proses teks di Dart sama persis dengan di Python.]

#sec("3.1", "Teknologi yang Dipakai", stage: st-m2)
Aplikasi dibuat dengan Flutter karena satu basis kode cukup untuk Android dan sesuai materi Pemrograman Mobile. Sisi data dan model memakai Python (scikit-learn untuk pembanding, TensorFlow untuk model akhir), seperti di @tbl-teknologi.

#tabel("tbl-teknologi", [Teknologi yang dipakai],
  tbl((1.5fr, 1fr, 2.5fr),
  ([Komponen], [Versi], [Alasan]),
  (
    ([Flutter dan Dart], [3.22 dan 3.4], [Sesuai materi Pemrograman Mobile, satu kode untuk Android]),
    ([`go_router`, `provider`], [14 dan 6], [Navigasi terstruktur dan state yang konsisten]),
    ([`http`, `sqflite`], [1.2 dan 2.3], [Mengunduh JSON, menyimpan riwayat dan cache]),
    ([`geolocator`, `permission_handler`], [12 dan 11], [Lokasi dan penanganan izin, termasuk izin ditolak]),
    ([`tflite_flutter`], [0.10], [Menjalankan model di perangkat]),
    ([Python, scikit-learn, TensorFlow], [3.11, 1.4, 2.15], [Pelatihan model dan skrip pengumpul data]),
    ([GitHub Actions], [-], [Job harian terjadwal, gratis]),
  ), sz: 8pt))

Versi paket dibekukan di `pubspec.lock` supaya setiap anggota membangun aplikasi dengan hasil yang sama. Semua paket Flutter berasal dari yang dibahas di kelas, kecuali `tflite_flutter`. Kami sempat mencoba layanan inferensi di awan, tetapi membatalkannya karena melanggar kriteria biaya nol.

#sec("3.2", "Cara Membuat Tiap Fitur", stage: st-m2)
`AnalisisProvider` menyimpan area, kategori, dan hasil analisis yang sedang dibuka. Layar membaca state itu lewat Provider, dan `go_router` mengatur perpindahan antara lima layar. Layar Peluang jadi cukup membaca hasil yang sudah dihitung.

Izin lokasi diminta lewat `permission_handler` saat layar pertama dibuka (@kode-lokasi). Bila izin ditolak, fungsi mengembalikan `null` dan layar meminta pengguna memilih area manual. Penanganan inilah yang diuji pada TC-02, dan versi pertamanya yang menutup aplikasi menjadi BUG-01.

#kode("kode-lokasi", [Mengambil lokasi dengan penanganan izin ditolak],
```dart
Future<Posisi?> ambilLokasi() async {
  final izin = await Permission.location.request();
  if (izin.isGranted) {
    final p = await Geolocator.getCurrentPosition();
    return Posisi(p.latitude, p.longitude);
  }
  return null;   // izin ditolak: layar meminta pengguna memilih area manual
}
```)

Setelah ulasan diklasifikasikan, aplikasi menghitung persentase tiap topik dan skor peluangnya dengan fungsi pada @kode-skor, lalu menampilkan kartu berurut skor.

#kode("kode-skor", [Menghitung skor peluang satu topik],
```dart
double skorPeluang(int jumlahTopik, int totalKeluhan, int totalUlasan) {
  final persen = jumlahTopik / totalKeluhan;   // bagian topik di antara keluhan
  return persen * log(totalUlasan);            // log natural dari dart:math
}
```)

#sec("3.3", "Basis Data", stage: st-m2)
Aplikasi memakai SQLite lewat `sqflite` untuk data area, tempat, ulasan, dan hasil analisis (Bab 2.3). Skema dibuat sekali saat basis data pertama dibuka dengan perintah pada @kode-ddl. Tabel `topik` langsung diisi lima baris tetap (BK, PL, WT, HG, KB), dan `PRAGMA foreign_keys = ON` dijalankan setiap koneksi dibuka supaya kunci asing ditegakkan.

#kode("kode-ddl", [DDL SQLite untuk delapan tabel CELAH],
{ set text(size: 6.6pt); ```sql
PRAGMA foreign_keys = ON;

CREATE TABLE area (
  id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT NOT NULL UNIQUE,
  lat REAL NOT NULL, lon REAL NOT NULL, tanggal_data TEXT NOT NULL);
CREATE TABLE kategori (
  id INTEGER PRIMARY KEY AUTOINCREMENT, nama TEXT NOT NULL UNIQUE,
  kata_kunci TEXT NOT NULL);
CREATE TABLE tempat (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  area_id INTEGER NOT NULL REFERENCES area(id) ON DELETE CASCADE,
  kategori_id INTEGER NOT NULL REFERENCES kategori(id),
  place_id TEXT NOT NULL UNIQUE, nama TEXT NOT NULL, alamat TEXT,
  bintang_rata REAL CHECK (bintang_rata BETWEEN 1 AND 5),
  jumlah_ulasan INTEGER NOT NULL DEFAULT 0);
CREATE TABLE ulasan (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  tempat_id INTEGER NOT NULL REFERENCES tempat(id) ON DELETE CASCADE,
  teks TEXT NOT NULL, bintang INTEGER NOT NULL CHECK (bintang BETWEEN 1 AND 5),
  tanggal TEXT NOT NULL, hash_teks TEXT NOT NULL,
  UNIQUE (tempat_id, hash_teks));
CREATE TABLE topik (
  id INTEGER PRIMARY KEY, kode TEXT NOT NULL UNIQUE, nama TEXT NOT NULL);
CREATE TABLE analisis (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  area_id INTEGER NOT NULL REFERENCES area(id) ON DELETE CASCADE,
  kategori_id INTEGER NOT NULL REFERENCES kategori(id),
  waktu TEXT NOT NULL, jumlah_ulasan INTEGER NOT NULL);
CREATE TABLE analisis_topik (
  analisis_id INTEGER NOT NULL REFERENCES analisis(id) ON DELETE CASCADE,
  topik_id INTEGER NOT NULL REFERENCES topik(id),
  jumlah INTEGER NOT NULL, persen REAL NOT NULL CHECK (persen BETWEEN 0 AND 100),
  PRIMARY KEY (analisis_id, topik_id));
CREATE TABLE peluang (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  analisis_id INTEGER NOT NULL REFERENCES analisis(id) ON DELETE CASCADE,
  topik_id INTEGER NOT NULL REFERENCES topik(id),
  skor REAL NOT NULL, peringkat INTEGER NOT NULL, saran TEXT NOT NULL,
  UNIQUE (analisis_id, topik_id));
CREATE INDEX idx_ulasan_tempat ON ulasan (tempat_id);
CREATE INDEX idx_tempat_area_kategori ON tempat (area_id, kategori_id);
``` })

Saat pengguna memilih area, aplikasi membandingkan `area.tanggal_data` dengan tanggal pada JSON terbaru dan hanya menulis ulang `tempat` dan `ulasan` bila datanya lebih baru. Perbandingan inilah yang memperbaiki BUG-03, ketika cache tidak ikut berubah setelah job harian. Saat pengguna menekan Simpan, satu transaksi menulis baris `analisis`, lima baris `analisis_topik`, dan baris `peluang`, sehingga riwayat tidak pernah tersimpan setengah-setengah.
 Data uji berasal dari JSON tiga area (Lowokwaru, Klojen, Sukun) dengan 60 tempat. Hasil klasifikasi per ulasan tidak disimpan, hanya hitungan per topik, agar riwayat tidak berubah ketika model diperbarui.

#sec("3.4", "Model dan Cara Memasangnya ke Aplikasi", stage: st-m2)
Model dilatih di Colab dengan Keras, diekspor ke TFLite berukuran 2,1 MB, lalu disalin ke folder `assets` bersama berkas kosakata 8.000 kata. Satu ulasan selesai diklasifikasikan dalam sekitar 40 ms di ponsel A, dan 50 ulasan selesai dalam 2,1 detik (TC-14), jauh di bawah batas 5 detik.

Bagian yang paling lama justru menyamakan pra-proses. Model hanya benar bila teks diubah menjadi token dengan aturan yang sama persis seperti saat pelatihan. Intan menulis ulang langkah huruf kecil, normalisasi, dan tokenisasi di Dart, dan pada percobaan pertama token di Dart berbeda dari Python untuk sebagian ulasan bergaya gaul. Setelah aturan normalisasi disamakan, hasilnya identik pada 200 ulasan uji (Lampiran F.2). Fungsi pada @kode-klasifikasi memanggil model dengan masukan yang sudah ditokenisasi dan mengambil topik dengan skor tertinggi.

#kode("kode-klasifikasi", [Memanggil model TFLite untuk satu ulasan],
```dart
Topik klasifikasi(String ulasan) {
  final token = _tokenizer.ke(ulasan, panjang: 80);   // sama dengan pelatihan
  final keluaran = List.filled(5, 0.0).reshape([1, 5]);
  _interpreter.run([token], keluaran);
  final skor = (keluaran[0] as List).cast<double>();
  return Topik.values[skor.indexOf(skor.reduce(max))];
}
```)

#sec("3.5", "Penyambungan antar Bagian dan Pemasangan", stage: st-m2)
Job harian berjalan pukul 03.00 WIB lewat GitHub Actions dengan jadwal pada @kode-job. Skrip Python mengambil ulasan, menggabungkannya dengan ekspor mitra, lalu menerbitkan JSON ke hosting statis. Aplikasi mengunduh berkas itu dengan paket `http` dan menyimpannya ke SQLite, jadi satu-satunya sambungan antara dua bagian adalah berkas JSON.

#kode("kode-job", [Jadwal job harian pada GitHub Actions],
```yaml
on:
  schedule:
    - cron: "0 20 * * *"   # pukul 20.00 UTC = 03.00 WIB
  workflow_dispatch: {}
jobs:
  kumpulkan:
    runs-on: ubuntu-latest
    steps:
      - run: git clone --depth 1 "$REPO_URL" .
      - run: python kumpulkan.py && python terbitkan.py
```)

Aplikasi dibangun dengan `flutter build apk --release` dan dipasang lewat berkas APK dari halaman rilis (S.5). Kami mencoba pemasangan di dua ponsel dan satu emulator. Karena tidak ada server yang dikelola, tidak ada langkah deploy selain menerbitkan JSON dan APK.

// =====================================================================
// BAB 4
// =====================================================================
#chapter("Bab 4", "Pengujian dan Evaluasi")
#lead[Dari 15 kasus uji, 13 lulus dan 2 gagal. Model mencapai macro-F1 0,82, tetapi kelas "Kebersihan" masih di bawah target recall.]

#sec("4.1", "Rencana Pengujian", stage: st-m2)
Dimas menyusun Rencana Pengujian (QA Plan) versi 1.0 (Lampiran C). Isinya tiga jenis uji. Uji fungsional manual pada alur utama dan uji waktu analisis (TC-14) dijalankan di ponsel A (Android 13, RAM 8 GB) dan ponsel B (Android 10, RAM 3 GB) pada Minggu 11 dan 12. Pemasangan APK dicoba di kedua ponsel dan satu emulator Pixel 6. Evaluasi model dijalankan Intan di Colab pada Minggu 11.

Ponsel B sengaja dipilih sebagai batas bawah ponsel kelas menengah. Emulator hanya untuk memeriksa pemasangan, tidak untuk mengukur waktu, karena waktunya tidak mewakili ponsel sungguhan. Pembuat model bukan satu-satunya yang menilainya, dan kasus uji ditulis sebelum fitur terakhir selesai agar tidak disesuaikan dengan hasil. Ringkasan hasil ada di Laporan QA Sementara (Lampiran E).

#sec("4.2", "Kasus Uji dan Hasil", stage: st-m2)
Kami menjalankan 15 kasus uji untuk alur utama, termasuk satu uji non-fungsional (TC-14). Hasilnya 13 lulus dan 2 gagal, yaitu TC-08 (BUG-02) dan TC-15 (BUG-04), seperti terlihat di @tbl-uji.

#tabel("tbl-uji", [Kasus uji dan hasilnya pada Minggu 12],
  tbl((0.6fr, 1.4fr, 1.7fr, 1.3fr, 1.5fr, 1fr),
  ([ID], [Skenario], [Langkah singkat], [Hasil diharapkan], [Hasil aktual], [Status]),
  (
    ([TC-01], [Izin lokasi diminta], [Buka aplikasi pertama kali], [Dialog izin tampil], [Dialog izin tampil di layar pertama], [Lulus]),
    ([TC-02], [Izin lokasi ditolak], [Tolak izin di dialog], [Layar pilih area manual], [Layar pilih area manual tampil], [Lulus]),
    ([TC-03], [Izin lokasi diberikan], [Beri izin lokasi], [Area terdeteksi], [Area terdeteksi sebagai Lowokwaru], [Lulus]),
    ([TC-04], [Pilih kategori kafe], [Pilih "Kafe"], [Daftar tempat tampil], [Daftar tempat kafe tampil], [Lulus]),
    ([TC-05], [Analisis satu tempat], [Ketuk satu tempat], [Grafik topik keluhan tampil], [Grafik topik keluhan tampil], [Lulus]),
    ([TC-06], [Ulasan keluhan harga], [Analisis "Harganya mahal untuk porsi segitu"], [Topik Harga], [Terklasifikasi sebagai Harga], [Lulus]),
    ([TC-07], [Ulasan memuji], [Analisis "Enak, tempatnya nyaman"], [Bukan keluhan], [Terklasifikasi sebagai Bukan keluhan], [Lulus]),
    ([TC-08], [Ulasan dengan dua keluhan], [Analisis "Meja lengket dan pelayannya cuek"], [Topik utama Kebersihan], [Hanya Pelayanan yang muncul], [Gagal (BUG-02)]),
    ([TC-09], [Peluang berurut skor], [Buka layar Peluang], [Urut dari skor tertinggi], [Kartu tampil urut dari skor tertinggi], [Lulus]),
    ([TC-10], [Skor sama dengan hitungan manual], [Bandingkan dengan spreadsheet], [Skor sama], [Skor sama dengan spreadsheet], [Lulus]),
    ([TC-11], [Simpan ke riwayat], [Tekan Simpan di layar analisis], [Hasil ada di riwayat], [Hasil tersimpan dan terlihat di riwayat], [Lulus]),
    ([TC-12], [Buka hasil tanpa internet], [Matikan data, buka riwayat], [Hasil tampil dari cache], [Hasil tampil dari basis data lokal], [Lulus]),
    ([TC-13], [Area tanpa data], [Pilih area yang belum punya JSON], [Pesan "data belum tersedia"], [Pesan data belum tersedia tampil], [Lulus]),
    ([TC-14], [Waktu analisis (non-fungsional)], [Analisis 50 ulasan di ponsel A dan B], [Kurang dari 5 detik], [2,1 detik di ponsel A dan 3,4 detik di ponsel B], [Lulus]),
    ([TC-15], [Ulasan campur bahasa], [Analisis "waiting time lama banget"], [Topik Waktu tunggu], [Terklasifikasi sebagai Bukan keluhan], [Gagal (BUG-04)]),
  ), sz: 7.4pt))

Kedua kasus yang gagal berkaitan dengan isi ulasan, bukan alur aplikasi. TC-08 gagal karena model hanya mengeluarkan satu topik per ulasan, dan TC-15 karena kata Inggris pada ulasan tidak ada di kosakata. Kami membiarkan keduanya terbuka dan menjadwalkan perbaikannya di Minggu 13 dan 14, daripada mengubah hasil yang diharapkan agar uji terlihat lulus.

Keterlacakan kebutuhan ke kasus uji ada di @tbl-jejak. Hampir semua kebutuhan sudah punya kasus uji. Pengecualiannya FR-09 dan FR-10 yang belum selesai, NFR-04 yang diperiksa lewat tinjauan desain data, serta NFR-02 dan NFR-05 yang diperiksa lewat evaluasi model di Lampiran F.

#tabel("tbl-jejak", [Keterlacakan kebutuhan SRS ke kasus uji],
  tbl((1fr, 2.4fr, 2fr),
  ([Kebutuhan], [Kasus uji], [Keterangan]),
  (
    ([FR-01], [TC-03, TC-04], [Lulus]),
    ([FR-02], [TC-01, TC-02], [Lulus (BUG-01 diperbaiki)]),
    ([FR-03], [TC-04, TC-13], [Lulus]),
    ([FR-04], [TC-06, TC-07, TC-15], [TC-15 gagal (BUG-04)]),
    ([FR-05], [TC-05], [Lulus]),
    ([FR-06], [TC-09, TC-10], [Lulus]),
    ([FR-07], [TC-11, TC-12], [Lulus (BUG-03 diperbaiki)]),
    ([FR-08], [TC-08], [Gagal (BUG-02)]),
    ([FR-09, FR-10], [Belum ada], [Fitur belum selesai]),
    ([NFR-01, NFR-03], [TC-14], [Lulus di dua ponsel]),
    ([NFR-02, NFR-05], [Evaluasi model (Lampiran F)], [NFR-02 sebagian, NFR-05 tercapai]),
    ([NFR-04], [Tinjauan desain data], [Tercapai]),
  ), sz: 7.8pt))

#sec("4.3", "Bug yang Ditemukan", stage: st-m2)
Selama pengujian kami menemukan empat bug dan mencatat semuanya di catatan bug (Lampiran C) dengan tingkat keparahan, langkah reproduksi, dan status, seperti di @tbl-bug. BUG-01 dan BUG-03 sudah diperbaiki di Minggu 11 dan 12, sedangkan BUG-02 dan BUG-04 masih terbuka.

#tabel("tbl-bug", [Catatan bug sampai Minggu 12],
  tbl((0.7fr, 3fr, 0.8fr, 1.1fr, 1.5fr),
  ([ID], [Deskripsi dan langkah reproduksi], [Tingkat], [Status], [Rencana atau perbaikan]),
  (
    ([BUG-01], [Aplikasi menutup saat izin lokasi ditolak. Langkah: tolak izin di dialog pertama. Ditemukan lewat TC-02], [Tinggi], [Diperbaiki, Minggu 11], [TC-02 lulus pada uji ulang]),
    ([BUG-02], [Ulasan berisi dua keluhan hanya mendapat satu topik. Langkah: analisis "Meja lengket dan pelayannya cuek". Ditemukan lewat TC-08], [Sedang], [Terbuka], [Menampilkan topik kedua (Minggu 14)]),
    ([BUG-03], [Cache tidak diperbarui setelah job harian. Langkah: buka area yang sama dua hari berturut-turut], [Sedang], [Diperbaiki, Minggu 12], [Membandingkan `tanggal_data`]),
    ([BUG-04], [Ulasan campur Inggris dan Indonesia tidak dikenali. Langkah: analisis "waiting time lama banget". Ditemukan lewat TC-15], [Sedang], [Terbuka], [Menambah kamus normalisasi (Minggu 13)]),
  ), sz: 7.8pt))

BUG-01 adalah satu-satunya bug tingkat Tinggi dan sudah ditutup, sehingga kriteria "tidak ada bug tingkat tinggi yang terbuka" di Bab 1.5 terpenuhi. BUG-02 dan BUG-04 kami nilai Sedang karena aplikasi tetap bisa dipakai dan hasilnya hanya kurang lengkap, tidak menyesatkan.
 BUG-04 dikerjakan lebih dulu karena kamusnya juga membantu kelas lain, sedangkan BUG-02 menunggu latih ulang agar skor topik kedua dikalibrasi dengan model baru.

#sec("4.4", "Hasil Awal Model", stage: st-m2)
Model terpilih (E3, 1D-CNN) mencapai akurasi 0,84 dan macro-F1 0,82 pada data uji, sejalan dengan macro-F1 validasi 0,84. Ukuran TFLite-nya 2,1 MB dan satu ulasan selesai dalam sekitar 40 ms di ponsel A. Dibanding target di Bab 2.4, macro-F1 dan ukuran model tercapai, tetapi recall kelas "Kebersihan" 0,73, di bawah target 0,75. Penyebab utamanya ada di data: kelas ini paling kecil (8,3%) dan sebagian ulasannya memuat dua keluhan (Lampiran F.5).

Rencananya, kami menambah sekitar 150 ulasan "Kebersihan", melabel ulang batas kelas bersama mitra, menaikkan class weight kelas itu menjadi 2,0, dan menampilkan topik kedua bila skornya di atas 0,35. Model dilatih ulang dan diuji pada Minggu 14. Bila recall tetap di bawah 0,75, keterbatasan itu kami laporkan apa adanya pada laporan akhir.

Arsitektur model tidak kami ganti, karena analisis kesalahan di Lampiran F menunjuk pada label, bukan kemampuan model.

#sec("4.5", "Masukan Pengguna", stage: st-m2)
Pada Minggu 12 kami meminta satu pemilik usaha mitra dan tiga calon pelaku usaha mencoba aplikasi di ponsel uji. Tiap orang diminta mencari peluang usaha di area pilihannya tanpa bantuan, lalu menceritakan apa yang ditemukan. Pemilik usaha mitra mengatakan topik keluhan yang tampil sesuai dengan yang ia dengar dari pelanggan, tetapi ia ingin keluhan soal kebersihan lebih akurat dan ringkasan bisa dibawa dalam bentuk PDF. Masukan itu menguatkan arah perbaikan model, karena kebersihan adalah keluhan yang paling sering ia dengar sekaligus yang paling lemah di model kami. Tindak lanjutnya: perbaikan data "Kebersihan" di Minggu 13 dan ekspor PDF di Minggu 15.

Ketiga calon pelaku usaha menemukan peluang di area mereka dalam kurang dari dua menit, dan mereka paham grafik batangnya.

#kutipan[Saya langsung tahu keluhan apa yang paling banyak. Tapi habis itu saya mau tahu harus mulai dari mana.][Calon pelaku usaha, uji coba Minggu 12]

Dua dari tiga menyampaikan hal serupa, sehingga templat saran pada layar Peluang kami tulis ulang dengan kalimat tindakan, misalnya membuka layanan pesan-antar bila keluhan waktu tunggu tinggi. Tombol "Lihat saran" ditambahkan, dan hasilnya diuji ulang pada Minggu 14.

#sec("4.6", "Ketercapaian Kriteria Keberhasilan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: bandingkan hasil akhir dengan kriteria di Bab 1.5. Pada Milestone 2, cukup tulis judulnya.]

// =====================================================================
// BAB 5
// =====================================================================
#chapter("Bab 5", "Pengelolaan Proyek dan Penutup")
#lead[Bab ini mencatat siapa mengerjakan apa, apa yang berubah dari proposal, dan risiko untuk empat minggu terakhir. Kesimpulan dan pelajaran baru ditulis di laporan akhir.]

#sec("5.1", "Rencana dan Realisasi", stage: st-lanjutan)
Pekerjaan kami rinci dalam WBS tiga tingkat yang tersimpan bersama jadwal di dokumen WBS dan Gantt versi 1.3 (Lampiran C). Lima paket kerja tingkat pertama dibagi menjadi paket tingkat kedua dan tugas tingkat ketiga seperti 1.1.1. Rencana dan realisasi sampai Minggu 12 ada di @tbl-wbs dan digambar sebagai Gantt pada @gbr-gantt.

#tabel("tbl-wbs", [WBS tiga tingkat, rencana, dan realisasi sampai Minggu 12],
  tbl((0.6fr, 2.8fr, 0.9fr, 1.1fr, 1.5fr),
  ([WBS], [Tugas], [PJ], [Rencana], [Realisasi sampai Minggu 12]),
  (
    ([1], [Data dan Model], [Intan], [Minggu 5–11], [Selesai, Minggu 11]),
    ([1.1.1], [Data: kumpulkan ulasan (API dan ekspor mitra)], [Intan], [Minggu 5–8], [Selesai, Minggu 8]),
    ([1.1.2], [Data: pelabelan dan pedoman kelas], [Laras, Intan], [Minggu 6–8], [Selesai, Minggu 9 (terlambat 1 minggu)]),
    ([1.2.1], [Model: eksperimen E1 sampai E3], [Intan], [Minggu 9–11], [Selesai, Minggu 11]),
    ([1.2.2], [Model: konversi TFLite dan uji waktu], [Intan], [Minggu 11], [Selesai, Minggu 11]),
    ([2], [Aplikasi Mobile], [Bagas], [Minggu 6–12], [Selesai, Minggu 12]),
    ([2.1.1], [Layar: lokasi dan daftar tempat], [Bagas], [Minggu 6–9], [Selesai, Minggu 9]),
    ([2.1.2], [Layar: analisis dan peluang], [Bagas], [Minggu 9–11], [Selesai, Minggu 11]),
    ([2.2.1], [Integrasi: model ke aplikasi], [Bagas, Intan], [Minggu 11], [Selesai, Minggu 11]),
    ([2.2.2], [Integrasi: riwayat dan cache luring], [Bagas], [Minggu 11–12], [Selesai, Minggu 12]),
    ([3], [Penjaminan Mutu], [Dimas], [Minggu 9–12], [Selesai, Minggu 12]),
    ([3.1.1], [Pengujian: rencana uji dan kasus uji], [Dimas], [Minggu 9–10], [Selesai, Minggu 10]),
    ([3.1.2], [Pengujian: eksekusi uji dan catatan bug], [Dimas], [Minggu 11–12], [Selesai, 15 kasus uji]),
    ([4], [Desain dan Dokumentasi], [Laras], [Minggu 4–6], [Selesai, Minggu 6]),
    ([4.1.1], [Desain: Figma dan wireframe], [Laras], [Minggu 4–6], [Selesai, Minggu 6]),
    ([5], [Perbaikan dan Penutup], [Seluruh tim], [Minggu 13–16], [Belum dimulai]),
    ([5.1.1], [Perbaikan: data tambahan, latih ulang, BUG-02 dan BUG-04], [Intan, Bagas, Dimas], [Minggu 13–14], [Belum dimulai]),
    ([5.1.2], [Penutup: ekspor ringkasan, laporan akhir, materi demo], [Seluruh tim], [Minggu 15–16], [Belum dimulai]),
  ), sz: 7.6pt))

#gambar("gbr-gantt", [Diagram Gantt rencana dan realisasi sampai Minggu 12],
  gantt((
    ("4.1.1", "Desain Figma dan wireframe", (4, 6), (4, 6)),
    ("1.1.1", "Kumpulkan ulasan", (5, 8), (5, 8)),
    ("1.1.2", "Pelabelan dan pedoman kelas", (6, 8), (6, 9)),
    ("2.1.1", "Layar lokasi dan daftar tempat", (6, 9), (6, 9)),
    ("1.2.1", "Eksperimen model E1 sampai E3", (9, 11), (9, 11)),
    ("2.1.2", "Layar analisis dan peluang", (9, 11), (9, 11)),
    ("3.1.1", "Rencana uji dan kasus uji", (9, 10), (9, 10)),
    ("1.2.2", "Konversi TFLite dan uji waktu", (11, 11), (11, 11)),
    ("2.2.1", "Integrasi model ke aplikasi", (11, 11), (11, 11)),
    ("2.2.2", "Riwayat dan cache luring", (11, 12), (11, 12)),
    ("3.1.2", "Eksekusi uji dan catatan bug", (11, 12), (11, 12)),
    ("5.1.1", "Perbaikan data dan latih ulang", (13, 14), none),
    ("5.1.2", "Ekspor, laporan akhir, materi demo", (15, 16), none),
  ), now: 12))

Hanya satu tugas yang meleset, yaitu pelabelan (1.1.2), yang lebih lama satu minggu karena batas kelas "Pelayanan" dan "Waktu tunggu" harus disepakati lebih dulu. Keterlambatan itu tidak menggeser tugas berikutnya karena eksperimen model baru dimulai di Minggu 9. Rencana Minggu 13–16 ada di Lembar Status (S.6).

#sec("5.2", "Kontribusi Anggota", stage: st-lanjutan)
Kontribusi dicatat bersama bukti yang bisa diperiksa dosen, seperti jumlah _commit_, notebook, dan tugas pada WBS (@tbl-kontribusi). Persentasenya perkiraan tim sendiri. Bagas dan Intan masing-masing 30% karena aplikasi dan model adalah dua bagian terbesar, sedangkan Dimas dan Laras 20% dengan pekerjaan yang lebih terukur, yaitu pengujian serta desain dan dokumentasi. Laras menambah pelabelan data sejak Minggu 9, dan itu sudah termasuk dalam persentasenya.

#tabel("tbl-kontribusi", [Kontribusi anggota sampai Minggu 12],
  tbl((1.3fr, 2.2fr, 1.7fr, 0.8fr, 1.4fr),
  ([Nama], [Tugas selesai], [Bukti], [Estimasi], [Bagian saat demo]),
  (
    ([Bagas Wicaksono], [Aplikasi, integrasi model], [34 _commit_, WBS 2.1–2.2], [30%], [Alur utama di aplikasi]),
    ([Intan Permata Sari], [Data, eksperimen model], [Notebook, Lampiran F], [30%], [Model dan evaluasi]),
    ([Dimas Arya Pratama], [Rencana uji, 15 kasus uji], [Bab 4.2, catatan bug], [20%], [Hasil pengujian]),
    ([Laras Anindita Putri], [Pelabelan, desain, dokumentasi], [Berkas Figma, logbook], [20%], [Antarmuka dan data]),
  ), sz: 8pt))

Pekerjaan mingguan tercatat di logbook (Lampiran B dan Laporan Kemajuan), dan setiap anggota harus bisa menjelaskan bagian anggota lain bila dosen bertanya. Di luar laporan, setiap anggota mengisi Google Form Penilaian 360 secara terpisah pada Minggu 11 sampai 12, sesuai SOP Bagian 9.3. Koordinator PBL membandingkan rata-rata poin dari form itu dengan estimasi pada tabel di atas, lalu mengirim ringkasannya kepada dosen. Hasil penilaian tersebut tidak ditulis di laporan.

#sec("5.3", "Perubahan, Risiko, dan Permintaan Tambahan", stage: st-lanjutan)
Setiap perubahan dari proposal kami catat di Governance Log (Lampiran C) beserta alasan dan persetujuannya. Ada tiga perubahan sampai Minggu 12 (@tbl-perubahan), dan semuanya dikonsultasikan dengan dosen terkait sebelum dikerjakan.

#tabel("tbl-perubahan", [Governance Log: perubahan dari proposal],
  tbl((0.6fr, 2.3fr, 2.3fr, 1.5fr),
  ([ID], [Perubahan], [Alasan], [Persetujuan]),
  (
    ([CR-01], [Sumber data pindah dari scraping halaman Maps ke Places API dan ekspor mitra], [Scraping melanggar ketentuan layanan, dan API resmi cukup untuk 60 tempat per area], [Dosen Rujukan TI-3B, Minggu 7]),
    ([CR-02], [Kategori awal dikurangi dari lima menjadi tiga], [Ulasan untuk dua kategori lain terlalu sedikit untuk dilatih], [Dosen Pembelajaran Mesin, Minggu 8]),
    ([CR-03], [Model akhir 1D-CNN, bukan Naive Bayes], [Naive Bayes hanya mencapai macro-F1 validasi 0,71 (Lampiran F.3)], [Dosen Pembelajaran Mesin, Minggu 10]),
  ), sz: 7.8pt))

Untuk Minggu 13–16 ada empat risiko terbesar di @tbl-risiko. Skornya kemungkinan dikali dampak dengan skala 1 sampai 5: 12 ke atas Tinggi, 6 sampai 11 Sedang, di bawah 6 Rendah. Risiko recall "Kebersihan" paling tinggi karena langsung menentukan status Milestone 2 dan satu kriteria keberhasilan.

#tabel("tbl-risiko", [Daftar risiko Minggu 13–16],
  tbl((0.5fr, 1.8fr, 1.2fr, 0.8fr, 0.8fr, 2.2fr),
  ([ID], [Risiko], [Kemungkinan], [Dampak], [Skor], [Tindakan]),
  (
    ([R-01], [Recall "Kebersihan" tetap di bawah 0,75], [4], [4], [16, Tinggi], [Menambah data dan class weight. Bila gagal, keterbatasannya dilaporkan apa adanya]),
    ([R-02], [Kuota gratis Places API habis], [2], [3], [6, Sedang], [Membatasi 60 tempat per area, memperbarui sekali sehari, memakai ekspor mitra bila kuota habis]),
    ([R-03], [Ketentuan layanan data berubah], [2], [4], [8, Sedang], [Menyimpan hanya teks dan bintang, memantau dokumentasi API tiap minggu]),
    ([R-04], [Ponsel uji terbatas (dua perangkat)], [2], [2], [4, Rendah], [Meminjam satu ponsel dari teman kelas dan menguji di Minggu 14]),
  ), sz: 7.8pt))

Dosen Penjaminan Mutu meminta satu tambahan setelah proposal disetujui, yaitu uji waktu analisis di ponsel (Minggu 10). Permintaan itu masuk rencana uji sebagai TC-14 tanpa mengubah jadwal.

Aturan kerja tim ada di Project Charter. Kami bertemu setiap Rabu sore selama satu jam untuk meninjau WBS dan menentukan prioritas minggu berikutnya. Setiap perubahan kode lewat _pull request_ yang ditinjau minimal satu anggota lain, dan keputusan yang mengubah cakupan dicatat di Governance Log lebih dulu. Bila ada dua pendapat berbeda, Bagas sebagai ketua memutuskan setelah mendengar keduanya, dan bertanya ke dosen rujukan bila dampaknya menyentuh nilai.

#sec("5.4", "Kesimpulan", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang berhasil dibangun, dan apakah rumusan masalah di Bab 1.1 terjawab.]

#sec("5.5", "Pelajaran dan Saran", stage: st-akhir)
#pending[Ditulis pada laporan akhir: apa yang dipelajari tim, apa yang akan dilakukan berbeda, dan saran pengembangan berikutnya.]

// =====================================================================
// LAMPIRAN (tiap lampiran dimulai di halaman baru)
// =====================================================================
#pagebreak()
#part("Lampiran", "Lampiran A–H")
Tidak ada Lampiran G (kueri basis data), karena lampiran itu hanya untuk tim Semester 3. Skema SQLite tim ini ada di Bab 2.3 dan 3.3, dan data pelatihan dijelaskan di Lampiran F.
#v(0.6em)

#lamp("A", "Tangkapan Layar", stage: st-m2)
Dua tangkapan layar berikut memperlihatkan fitur yang sudah berjalan: @gbr-shot1 untuk analisis keluhan satu area dan @gbr-shot2 untuk daftar peluang usaha berurut skor.
#v(0.3em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  [#shot("gbr-shot1", [Analisis keluhan satu area], ht: 7cm)],
  [#shot("gbr-shot2", [Daftar peluang usaha], ht: 7cm)],
)

#pagebreak()
#lamp("B", "Logbook", stage: st-lanjutan)
Logbook Minggu 1–8 berasal dari Laporan Kemajuan dan tidak diulang di sini. Minggu 9–12 ada di @tbl-logbook.
#v(0.3em)
#tabel("tbl-logbook", [Logbook Minggu 9–12],
  tbl((0.8fr, 2.2fr, 1.2fr, 1.6fr, 1.6fr),
  ([Minggu], [Pekerjaan selesai], [Dikerjakan oleh], [Kendala], [Rencana berikutnya]),
  (
    ([9], [2.400 ulasan selesai dilabel], [Intan, Laras], [Batas kelas kabur], [Eksperimen model]),
    ([10], [E1 dan E2 dilatih, rencana uji selesai], [Intan, Dimas], [Naive Bayes lemah], [Mencoba CNN]),
    ([11], [E3 dipilih, model masuk aplikasi, BUG-01 diperbaiki], [Intan, Bagas], [Pra-proses Dart berbeda], [Uji alur utama]),
    ([12], [15 kasus uji dijalankan, BUG-03 diperbaiki], [Dimas, Bagas], [Dua bug terbuka], [Menambah data]),
  ), sz: 8.2pt))

#pagebreak()
#lamp("C", "Dokumen Rujukan", stage: st-m2)
Sepuluh dokumen kerja berikut dirujuk di bab-bab laporan (@tbl-rujukan). Tautannya ada di Lampiran E, dan isinya diringkas di bab yang sesuai, tidak diulang di sini.
#v(0.3em)
#tabel("tbl-rujukan", [Dokumen rujukan tim],
  tbl((0.4fr, 2.2fr, 0.7fr, 0.8fr, 1.3fr, 2fr),
  ([No], [Dokumen], [Versi], [Pemilik], [Bagian yang merujuk], [Keterangan]),
  (
    ([1], [SRS (spesifikasi kebutuhan perangkat lunak)], [1.2], [Bagas], [Bab 2.1, 4.2], [Daftar FR dan NFR beserta prioritas]),
    ([2], [Desain Figma], [1.0], [Laras], [Bab 2.5], [3 halaman, 19 frame, design token]),
    ([3], [Kartu dataset (dokumentasi dataset)], [1.1], [Intan], [Bab 2.4, Lampiran F.1], [Sumber, pelabelan, pembagian data]),
    ([4], [Notebook pelatihan (E1 sampai E3)], [M2], [Intan], [Lampiran F.3, F.4], [Angka sama dengan Lampiran F]),
    ([5], [Rencana Pengujian dan kasus uji], [1.0], [Dimas], [Bab 4.1, 4.2], [15 kasus uji beserta langkahnya]),
    ([6], [Catatan bug], [Minggu 12], [Dimas], [Bab 4.3], [BUG-01 sampai BUG-04]),
    ([7], [Laporan QA sementara], [1.0], [Dimas], [Bab 4.1], [Ringkasan hasil uji sampai Minggu 12]),
    ([8], [Deskripsi JSON ulasan per area], [1.0], [Intan], [Bab 2.3, Lampiran F.1], [Struktur berkas JSON yang diunduh aplikasi]),
    ([9], [WBS dan Gantt], [1.3], [Bagas], [Bab 5.1], [Rencana dan realisasi tiga tingkat]),
    ([10], [Project Charter (dengan Governance Log dan Stakeholder Register)], [1.1], [Laras], [Bab 1.3, 1.4, 5.3], [Ruang lingkup, perubahan, pemangku kepentingan]),
  ), sz: 7.6pt))

#pagebreak()
#lamp("D", "Dokumen Tambahan Mata Kuliah", stage: st-m2)
Tidak ada dokumen tambahan yang diumumkan dosen secara tertulis. Bila ada, dokumen itu ditulis sebagai D.1, D.2, dan seterusnya, dan tidak mengulang isi laporan (SOP Bagian 7). Dokumentasi model Pembelajaran Mesin ditulis di Lampiran F.

#pagebreak()
#lamp("E", "Daftar Tautan Eksternal", stage: st-m2)
Berkas laporan ini dikumpulkan dengan nama `M2_TI-3B_TimPekaPasar.pdf`. Semua tautan di @tbl-dokumen dapat dibuka tanpa login.
#v(0.3em)
#tabel("tbl-dokumen", [Daftar tautan eksternal],
  tbl((0.4fr, 2.6fr, 1.2fr, 2.8fr, 1.3fr),
  ([No], [Keterangan], [Bagian], [Tautan], [Jenis akses]),
  (
    ([1], [Repositori (_tag_ `milestone-2`)], [S.5], [`github.com/contoh/celah`], [Publik]),
    ([2], [Berkas APK], [S.5, Bab 3.5], [`github.com/contoh/celah/releases`], [Publik]),
    ([3], [SRS versi 1.2], [Bab 2.1], [`docs.example.com/celah/srs`], [Siapa saja dengan tautan]),
    ([4], [Desain Figma versi 1.0], [Bab 2.5], [`figma.example.com/celah`], [Siapa saja dengan tautan]),
    ([5], [Kartu dataset versi 1.1], [Lampiran F.1], [`docs.example.com/celah/kartu-dataset`], [Siapa saja dengan tautan]),
    ([6], [Notebook pelatihan], [Lampiran F.3], [`colab.example.com/celah`], [Siapa saja dengan tautan]),
    ([7], [Rencana Pengujian dan kasus uji], [Bab 4.1, 4.2], [`docs.example.com/celah/qa-plan`], [Siapa saja dengan tautan]),
    ([8], [Catatan bug], [Bab 4.3], [`docs.example.com/celah/bug-log`], [Siapa saja dengan tautan]),
    ([9], [Laporan QA sementara], [Bab 4.1], [`docs.example.com/celah/qa-sementara`], [Siapa saja dengan tautan]),
    ([10], [Deskripsi JSON ulasan per area], [Bab 2.3], [`celah.example.com/data/README`], [Publik]),
    ([11], [JSON ulasan per area (harian)], [Bab 2.2], [`celah.example.com/data`], [Publik]),
    ([12], [WBS dan Gantt versi 1.3], [Bab 5.1], [`docs.example.com/celah/wbs-gantt`], [Siapa saja dengan tautan]),
    ([13], [Project Charter versi 1.1], [Bab 1.3, 5.3], [`docs.example.com/celah/charter`], [Siapa saja dengan tautan]),
    ([14], [PDM SQLite dan kamus data], [Bab 2.3], [`docs.example.com/celah/pdm`], [Siapa saja dengan tautan]),
  ), sz: 7.6pt))

#pagebreak()

// ---------------------------------------------------------------- Lampiran F
#lamp("F", "Dokumentasi Model Pembelajaran Mesin", stage: st-m2)
Rincian teknis model yang tidak ditulis di Bab 2 sampai 4. Semua angka sama dengan keluaran notebook pada _tag_ `milestone-2`.

#fsub("F.1 Dataset")
Sumber, pelabelan, dan pembagian dataset ada di @tbl-f-dataset, sedangkan sebaran per kelas beserta contoh ulasannya di @tbl-f-kelas.

#tabel("tbl-f-dataset", [Karakteristik dan pembagian dataset],
  tbl((1.2fr, 3.4fr),
  ([Hal], [Isi]),
  (
    ([Sumber dan lisensi], [Ulasan publik 60 tempat usaha di Malang lewat Google Places API (kuota gratis), ditambah ekspor ulasan dari tiga mitra dengan izin tertulis. Hanya teks dan bintang yang disimpan]),
    ([Cara pelabelan], [Dilabeli tim dengan pedoman lima kelas. Dua pelabel per ulasan, selisih diselesaikan lewat diskusi (kesepakatan Cohen's kappa 0,78)]),
    ([Jumlah total], [2.400 ulasan Bahasa Indonesia, format JSON]),
    ([Pembagian data], [Latih 1.680, validasi 360, uji 360. Dibagi per tempat usaha, bukan per ulasan, supaya ulasan satu tempat tidak muncul di dua bagian. Proporsi kelas dijaga hampir sama, seed 42]),
  ), sz: 7.8pt))

#tabel("tbl-f-kelas", [Sebaran data per kelas dan contoh ulasan],
  tbl((1.1fr, 0.6fr, 0.7fr, 0.5fr, 1.1fr, 2.6fr),
  ([Kelas], [Latih], [Validasi], [Uji], [Total (%)], [Contoh ulasan]),
  (
    ([Bukan keluhan], [700], [150], [150], [1.000 (41,7%)], ["Kopinya enak dan tempatnya nyaman buat kerja."]),
    ([Pelayanan], [350], [75], [75], [500 (20,8%)], ["Pelayannya cuek, ditanya malah ngeloyor."]),
    ([Waktu tunggu], [252], [54], [54], [360 (15,0%)], ["Nunggu 40 menit cuma buat kopi."]),
    ([Harga], [238], [51], [51], [340 (14,2%)], ["Harganya mahal buat porsi segitu."]),
    ([Kebersihan], [140], [30], [30], [200 (8,3%)], ["Mejanya lengket dan toiletnya bau."]),
    ([Total], [1.680], [360], [360], [2.400], []),
  ), sz: 7.6pt))

Sebaran kelasnya tidak seimbang: "Kebersihan" hanya 8,3% dari data, sedangkan "Bukan keluhan" 41,7% (@tbl-f-kelas). Sekitar 12% ulasan memuat dua keluhan tetapi hanya diberi satu label, dan banyak yang bercampur bahasa Inggris. Akibatnya model cenderung memilih kelas besar saat ragu. Class weight dan kamus normalisasi (F.2) membantu, tetapi data kelas kecil belum cukup.

#fsub("F.2 Praproses Data")
Praproses terdiri atas empat langkah berurutan: huruf kecil dengan penghapusan URL dan emoji, normalisasi kata gaul dan singkatan dengan kamus 320 entri, tokenisasi dengan padding (kosakata 8.000, panjang 80 token), dan class weight 0,6 / 1,0 / 1,2 / 1,3 / 2,0 menurut urutan kelas pada @tbl-f-kelas. Tiga langkah pertama berlaku untuk data latih, validasi, dan uji, dan ditulis ulang di Dart dengan hasil yang sama persis (diuji pada 200 ulasan).

#fsub("F.3 Eksperimen Pembanding")
Tiga model dibandingkan pada data validasi yang sama (@tbl-f-eksperimen), dengan praproses dan pembagian data yang sama. Hanya data validasi yang dipakai untuk memilih model, sehingga data uji tetap bersih.

#tabel("tbl-f-eksperimen", [Hasil eksperimen pembanding (macro-F1)],
  tbl((0.5fr, 2fr, 2.4fr, 0.9fr, 1fr, 0.9fr),
  ([ID], [Model dan konfigurasi], [Hiperparameter utama], [Latih], [Validasi], [Terpilih]),
  (
    ([E1], [TF-IDF + Naive Bayes (baseline)], [n-gram 1–2, alpha 0,5], [0,83], [0,71], [Tidak]),
    ([E2], [TF-IDF + Logistic Regression], [n-gram 1–2, C = 2], [0,91], [0,79], [Tidak]),
    ([E3], [1D-CNN dengan _embedding_], [embedding 64, 2 lapisan konvolusi, dropout 0,4, 25 epoch, lr 1e-3], [0,90], [0,84], [Ya]),
  ), sz: 7.8pt))

Perubahan yang paling berpengaruh adalah beralih dari Naive Bayes ke model yang memakai konteks kata: macro-F1 validasi naik dari 0,71 (E1) menjadi 0,79 (E2) dan 0,84 (E3). Selisih latih dan validasi E2 mencapai 0,12 (tanda overfitting), sedangkan E3 hanya 0,06. Kami memilih E3 karena validasinya tertinggi, TFLite-nya hanya 2,1 MB, dan satu ulasan selesai dalam sekitar 40 ms.

#fsub("F.4 Evaluasi Rinci pada Data Uji")
Evaluasi pada 360 ulasan uji: metrik per kelas di @tbl-f-metrik, confusion matrix di @gbr-confmat, dan contoh kesalahan di @tbl-f-salah.

#tabel("tbl-f-metrik", [Metrik per kelas pada data uji],
  tbl((1.6fr, 1fr, 1fr, 1fr, 1.2fr),
  ([Kelas], [Presisi], [Recall], [F1], [Jumlah data]),
  (
    ([Bukan keluhan], [0,88], [0,93], [0,90], [150]),
    ([Pelayanan], [0,77], [0,77], [0,77], [75]),
    ([Waktu tunggu], [0,84], [0,76], [0,80], [54]),
    ([Harga], [0,84], [0,84], [0,84], [51]),
    ([Kebersihan], [0,88], [0,73], [0,80], [30]),
    ([Rata-rata makro], [0,84], [0,81], [0,82], [360]),
  ), sz: 7.8pt))

#gambar("gbr-confmat", [Confusion matrix pada data uji. Baris adalah kelas sebenarnya, kolom adalah prediksi. Akurasi keseluruhan 304 dari 360, yaitu 0,84],
  block(breakable: false, align(center, confmat(("Bukan", "Pelay.", "Tunggu", "Harga", "Bersih"), ((140, 4, 2, 3, 1), (8, 58, 5, 2, 2), (4, 6, 41, 3, 0), (5, 2, 1, 43, 0), (3, 5, 0, 0, 22))))))

#tabel("tbl-f-salah", [Contoh kesalahan prediksi],
  tbl((0.4fr, 2.4fr, 1.2fr, 1.2fr, 2.2fr),
  ([No], [Ulasan], [Label sebenarnya], [Prediksi], [Dugaan penyebab]),
  (
    ([1], ["Mejanya lengket, toiletnya bau, pelayannya juga cuek"], [Kebersihan], [Pelayanan], [Satu ulasan memuat dua keluhan, label hanya satu]),
    ([2], ["Kopinya enak, tapi lantainya licin dan banyak sampah"], [Kebersihan], [Bukan keluhan], [Kalimat pembuka memuji menutupi keluhan]),
  ), sz: 7.6pt))

Kelas terlemah adalah "Kebersihan" (recall 0,73), yang paling sering tertukar dengan "Pelayanan" (5 dari 30 ulasan pada @gbr-confmat). Pola ini sejalan dengan temuan F.1: kelasnya paling kecil dan sebagian ulasannya memuat dua keluhan, seperti kesalahan 1 dan 2 pada @tbl-f-salah. Macro-F1 uji (0,82) mendekati validasi (0,84), jadi tidak ada tanda overfitting. Macro-F1 memenuhi target 0,80, tetapi recall "Kebersihan" belum memenuhi 0,75.

#fsub("F.5 Kesimpulan Analisis")
Masalah utama ada di data, bukan di model atau praproses. Kelas "Kebersihan" hanya 8,3% data (@tbl-f-kelas), 8 dari 30 ulasannya salah diklasifikasikan (@gbr-confmat), sementara E3 sudah mencapai macro-F1 validasi 0,84 (@tbl-f-eksperimen). Karena itu perbaikan di Bab 4.4 berfokus pada penambahan data, pelabelan ulang batas kelas, dan penanganan ulasan dua keluhan.

#pagebreak()
#lamp("H", "Deklarasi Penggunaan AI", stage: st-lanjutan)
Bagian laporan dan kode yang dibantu AI tercatat pada @tbl-ai. Seluruh anggota memahami dan dapat menjelaskan hasil yang dibantu AI tersebut.
#v(0.3em)
#tabel("tbl-ai", [Deklarasi penggunaan AI],
  tbl((1.6fr, 1.2fr, 2.4fr),
  ([Bagian], [Alat], [Tujuan]),
  (
    ([Kerangka skrip pengumpul data (Python)], [Asisten kode], [Contoh awal. Ditulis ulang dan diuji oleh Intan]),
    ([Perbaikan bahasa Bab 1], [Asisten menulis], [Merapikan kalimat. Isi ditulis tim]),
  ), sz: 8.2pt))
