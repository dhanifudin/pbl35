#let horizontalrule = line(start: (25%, 0%), end: (75%, 0%), stroke: 0.5pt + rgb("#c3d8cf"))
#import "style.typ": *
#show: doc => conf(title: "SOP Pelaksanaan Milestone 2 PBL", doc)
= SOP Pengumpulan Laporan Milestone 2 PBL
<sop-pengumpulan-laporan-milestone-2-pbl>
SOP ini berlaku untuk semua tim #emph[Project-Based Learning] (PBL) Program Studi Teknik Informatika (TI) dan Sistem Informasi Bisnis (SIB), Semester 3 dan Semester 5, Jurusan Teknologi Informasi, Politeknik Negeri Malang, Tahun Akademik 2025/2026.

#horizontalrule

== 1. Tujuan
<tujuan>
Milestone 2 (CP-3, titik pemeriksaan ketiga) dilaksanakan pada #strong[Minggu 12];. Pada saat itu, #strong[alur utama produk sudah berjalan dan bisa didemokan];, dan hasil uji awal sudah ada. Fitur lain boleh belum selesai, asalkan sudah masuk rencana Minggu 13--16. Hasil Milestone 2 menunjukkan apakah tim siap masuk ke pengujian akhir dan Demo Day.

SOP ini dibuat agar:

+ Semua tim mengumpulkan #strong[satu laporan yang sama];. Tim tidak perlu membuat dokumen sendiri-sendiri untuk setiap mata kuliah.
+ Laporan Milestone 2 adalah #strong[laporan akhir yang masih dalam proses penulisan];. Tim menulis satu laporan yang berkembang dari proposal ke Milestone 2, lalu ke laporan akhir. Tidak ada bagian yang ditulis ulang, dan tim tidak perlu membuat laporan kemajuan lagi.
+ Setiap dosen tahu bagian laporan yang harus dinilai, sehingga arahan dari beberapa dosen tidak saling bertentangan.
+ Tim yang kesulitan bisa segera mendapat bantuan, lewat Status Milestone 2 dan rencana perbaikan (Bagian 12).

Milestone adalah titik evaluasi dan perbaikan, #strong[bukan hukuman];.

== 2. Prinsip Pelaksanaan
<prinsip-pelaksanaan>
SOP ini disusun dengan tujuh prinsip berikut.

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Prinsip], [Cara SOP menerapkannya],),
    table.hline(),
    [Satu laporan, satu tenggat, satu unggahan], [Semua mata kuliah memakai laporan yang sama (Bagian 3 dan 5)],
    [Tidak ada dokumen tambahan tanpa pengumuman tertulis], [Aturannya ada di Bagian 7],
    [Beban kerja yang wajar], [Target Milestone 2 hanya alur utama (Bagian 15). Laporan ini dipakai lagi sebagai laporan akhir. Tidak ada tugas baru di luar laporan pada pekan Milestone 2 (Bagian 4 dan 7)],
    [Arahan dosen satu suara], [Tabel penilaian per mata kuliah (Bagian 6), dosen rujukan untuk tiap kelas (Bagian 9.1), dan aturan permintaan di luar rencana (Bagian 9.2)],
    [Kontribusi terlihat], [Bukti kontribusi, Penilaian 360 lewat Google Form, dan logbook yang mencatat siapa mengerjakan apa (Bagian 5, 9.3, dan 14)],
    [Penilaian terbuka], [Hal yang dinilai dan rubrik ringkas dibuka lebih dulu (Bagian 16). Dosen menyampaikan porsi nilai PBL (Bagian 6)],
    [Pilihan yang fleksibel], [Bentuk demo, cara #emph[deploy];, bukti pengujian, dan masukan pengguna punya beberapa pilihan yang sama-sama diterima (Bagian 10)],
  )]
  , kind: table
  )

== 3. Siapa yang Mengikuti SOP Ini
<siapa-yang-mengikuti-sop-ini>
- Semua tim PBL TI dan SIB, Semester 3 dan Semester 5, di semua kelas.
- Satu tim mengumpulkan #strong[satu berkas PDF];. Isinya Lembar Status Milestone 2, Bab 1--5 yang terisi sebagian, dan lampiran.
- Struktur laporan mengikuti #strong[Template Laporan Milestone 2 PBL];. Template menjelaskan struktur dan isi tiap bagian. #strong[Contoh Laporan Milestone 2 PBL] menunjukkan hasil akhirnya. Ada empat contoh, satu untuk tiap program studi dan semester.
- SOP, template, dan dokumen pendukung ada di folder dokumen PBL: https:\/\/drive.google.com/drive/folders/15q1RaS64I4VPQ4aTbJetim0Yu0IxdbBt?usp=drive\_link
- Dosen pengampu tidak perlu membuat atau mengirim dokumen apa pun untuk Milestone 2. Dosen hanya menilai bagian laporan yang tercantum di Bagian 6.
- Koordinator mengumumkan jadwal, tabel penilaian (Bagian 6), dan daftar dosen rujukan tiap kelas di folder dokumen PBL dan di LMS kelas.

=== Peta dokumen
<peta-dokumen>
Ada tiga dokumen, dan tiap dokumen punya tugas sendiri.

#figure(
  align(left)[#table(
    columns: (33.33%, 33.33%, 33.33%),
    align: (auto,auto,auto,),
    table.header([Dokumen], [Isinya], [Baca untuk menjawab],),
    table.hline(),
    [#strong[SOP ini];], [Aturan, waktu, peran, pilihan, dan penilaian], [Apa yang wajib, kapan, dan siapa yang mengerjakan?],
    [#strong[Template Laporan Milestone 2 PBL];], [Struktur laporan dan panduan isi tiap bagian], [Bagian apa saja yang harus ada, dan isinya apa?],
    [#strong[Contoh Laporan Milestone 2 PBL] (empat contoh: TI Semester 3, TI Semester 5, SIB Semester 3, SIB Semester 5)], [Satu laporan lengkap yang sudah terisi, untuk tiap program studi dan semester], [Seperti apa hasil akhirnya, dan seberapa dalam isinya?],
  )]
  , kind: table
  )

Mulai dari mana: baca SOP ini dulu, lalu Template, lalu lihat Contoh Laporan yang sesuai dengan program studi dan semester tim. Setelah itu, tulis laporan tim sendiri.

== 4. Waktu
<waktu>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Kegiatan], [Waktu],),
    table.hline(),
    [SOP dan template diterbitkan], [#strong[\[tanggal\]];],
    [Daftar dosen rujukan tiap kelas diumumkan], [#strong[\[tanggal\]];, bersama SOP],
    [Daftar dokumen tambahan dari dosen, bila ada (Bagian 7)], [#strong[\[tanggal\]];, bersama SOP],
    [Form Penilaian 360 dibuka], [#strong[Minggu 11];, ditutup bersama batas akhir pengumpulan laporan],
    [Sesi tinjau proyek (sekitar 15 menit per tim)], [Pertemuan terdekat sebelum demo, dijadwalkan dosen],
    [Pekan Milestone 2], [Tidak ada tugas baru di luar laporan],
    [Batas akhir pengumpulan Laporan Milestone 2], [#strong[\[tanggal\]];, pukul 23.59 WIB],
    [Demo dan review], [#strong[Minggu 12];, sesuai jadwal kelas],
    [Umpan balik dari dosen], [Paling lambat 1 minggu setelah batas pengumpulan, tertulis dan sampai ke tim],
    [Kalender tenggat PBL untuk sisa semester], [Disusun koordinator setelah Milestone 2],
  )]
  , kind: table
  )

== 5. Isi Laporan
<isi-laporan>
Laporan terdiri dari sampul, Lembar Status, Bab 1--5, dan lampiran, dalam satu berkas PDF bernama `M2_<Kelas>_<NamaTim>.pdf`. Contohnya `M2_TI-2A_SIMPAN.pdf`. Tata letak, warna, huruf, dan desain sampul bebas. Yang diperiksa hanya kelengkapan struktur dan isinya.

#figure(
  align(left)[#table(
    columns: (33.33%, 33.33%, 33.33%),
    align: (auto,auto,auto,),
    table.header([Bagian], [Isi], [Pada laporan akhir],),
    table.hline(),
    [Sampul], [Judul, identitas tim, logo, bulan dan tahun], [Dipakai kembali],
    [#strong[Lembar Status Milestone 2] (1--2 halaman)], [Identitas dan dosen rujukan, Status Milestone 2, tindak lanjut Milestone 1, capaian produk, bukti, rencana Minggu 13--16], [#strong[Dihapus];],
    [Bab 1 Pendahuluan, Bab 2 Analisis Kebutuhan dan Perancangan], [Dipindahkan dari proposal, lalu diperbarui], [Dirapikan],
    [Bab 3 Implementasi, Bab 4 Pengujian dan Evaluasi], [Hasil kerja dan hasil uji awal sampai Minggu 12], [Dilengkapi, lalu Bab 4.6 ditulis],
    [Bab 5 Pengelolaan Proyek dan Penutup], [5.1 rencana dan realisasi, 5.2 kontribusi anggota, 5.3 perubahan, risiko, dan permintaan tambahan], [Dilengkapi, lalu 5.4 Kesimpulan dan 5.5 Pelajaran dan Saran ditulis],
    [Lampiran], [A tangkapan layar; B logbook; C dokumen rujukan tim (misalnya SRS dan desain Figma); D dokumen tambahan dari dosen, bila ada (D.1, D.2, dan seterusnya, lihat Bagian 7); E daftar tautan eksternal; F dokumentasi model ML #strong[\[TI Sem 5\]];; G dokumentasi kueri basis data #strong[\[Sem 3\]];; H deklarasi AI], [Dipakai kembali dan dilengkapi],
  )]
  , kind: table
  )

Tim tidak menulis ulang apa pun di tahap akhir. Pada laporan akhir, tim melengkapi Bab 3--4, menulis Bab 4.6 dan Bab 5.4--5.5, menambah logbook Minggu 13--16, lalu menghapus Lembar Status. Template memuat tabel yang menunjukkan ke bagian mana isi proposal dan Laporan Kemajuan dipindahkan.

Lampiran F dan G menggantikan penjelasan yang sama di Bab 2--4. Lampiran F memuat dokumentasi model ML (dataset, praproses, eksperimen pembanding, evaluasi rinci, dan analisisnya) dan paling banyak 4 halaman. Tulis sekali di lampiran, lalu rujuk dari bab. Bahannya diambil dari pekerjaan yang sudah dilakukan tim, yaitu kode, notebook, kueri, dan hasil uji.

=== Kerangka laporan akhir (sama untuk semua program studi)
<kerangka-laporan-akhir-sama-untuk-semua-program-studi>
#figure(
  align(left)[#table(
    columns: (33.33%, 33.33%, 33.33%),
    align: (auto,auto,auto,),
    table.header([Bab], [Isi], [Keterangan],),
    table.hline(),
    [\1. Pendahuluan], [Latar belakang masalah, tujuan, cakupan fitur, manfaat, susunan laporan], [Diambil dari proposal, lalu disesuaikan dengan perubahan cakupan fitur],
    [\2. Analisis Kebutuhan dan Perancangan], [Kebutuhan pengguna dan daftar fitur, susunan komponen sistem, rancangan basis data, rancangan tampilan. #strong[\[TI Sem 5\]] ditambah rancangan model ML. #strong[\[SIB\]] ditambah prototipe atau #emph[wireframe];], [Dinilai oleh mata kuliah basis data, UI/UX, dan sistem informasi],
    [\3. Implementasi], [Teknologi yang dipakai, cara membuat tiap fitur, basis data, dan penyambungan antar bagian. #strong[\[TI Sem 5\]] ditambah model dan cara memasangnya ke aplikasi. Cukup menulis bagian yang sudah dibuat], [Dinilai oleh mata kuliah pemrograman],
    [\4. Pengujian dan Evaluasi], [Rencana pengujian, daftar kasus uji (skenario yang dicoba), hasil uji awal, bug dan statusnya. #strong[\[TI Sem 5\]] ditambah hasil awal model], [Di Milestone 2 berisi hasil awal, lalu dilengkapi di Minggu 13--15],
    [\5. Penutup], [Kesimpulan, keterbatasan, saran], [Ditulis di tahap akhir, tidak diminta di Milestone 2],
  )]
  , kind: table
  )

== 6. Tabel Penilaian per Mata Kuliah
<tabel-penilaian-per-mata-kuliah>
Koordinator menyusun tabel ini dari peran tiap mata kuliah di RPP PBL, jadi #strong[dosen tidak perlu memberi masukan];. Setiap dosen menilai bagian yang tercantum di bawah, memakai kriteria mata kuliahnya sendiri.

Setiap dosen menyampaikan porsi nilai PBL dan rubrik mata kuliahnya kepada kelas sebelum demo, lewat RPS atau LMS.

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([Program studi dan semester], [Mata kuliah], [Bagian laporan yang dinilai], [Bukti yang dilihat],),
    table.hline(),
    [TI Semester 3], [Manajemen Proyek], [Lembar Status; Bab 5 (rencana dan realisasi, kontribusi, perubahan dan risiko)], [Lembar Status, Bab 5, logbook, kontribusi],
    [TI Semester 3], [Desain dan Pemrograman Web], [Bab 3 (pembuatan aplikasi web) dan demo], [Demo, repositori, Bab 3],
    [TI Semester 3], [Basis Data Lanjut], [Bab 2 (rancangan basis data) dan Bab 3 (pembuatan basis data); uji kebenaran data di Bab 4; Lampiran G (kueri dan hasil #emph[EXPLAIN ANALYZE];)], [Demo basis data dan kueri, Bab 2--3, Lampiran G],
    [TI Semester 3], [Sistem Informasi Manajemen], [Bab 2 (kebutuhan informasi, rancangan laporan dan dasbor) dan masukan pengguna atas laporan atau dasbor], [Bab 2, demo laporan atau dasbor],
    [TI Semester 5], [Pemrograman Mobile], [Bab 3 (pembuatan aplikasi mobile) dan demo], [Demo aplikasi, repositori, Bab 3],
    [TI Semester 5], [Pembelajaran Mesin], [Bab 2 dan Bab 3 (model), hasil awal model di Bab 4; Lampiran F (dokumentasi model: F.1--F.5)], [Demo model di dalam aplikasi, hasil awal model, Lampiran F],
    [TI Semester 5], [Penjaminan Mutu Perangkat Lunak], [Bab 4 (rencana uji, kasus uji, laporan uji awal)], [Laporan uji awal, daftar bug],
    [SIB Semester 3 #emph[(acuan awal)];], [Pemrograman Web], [Bab 3 dan demo alur bisnis utama], [Demo, repositori, Bab 3],
    [SIB Semester 3 #emph[(acuan awal)];], [Basis Data Lanjut], [Bab 2 dan Bab 3 (basis data); Lampiran G (kueri dan hasil #emph[EXPLAIN ANALYZE];)], [Demo basis data dan kueri, Lampiran G],
    [SIB Semester 3 #emph[(acuan awal)];], [Desain UI/UX], [Bab 2 (prototipe, #emph[wireframe];) dan kesesuaian tampilan dengan prototipe], [Prototipe, demo tampilan],
    [SIB Semester 5 #emph[(acuan awal)];], [Pemrograman Web Lanjut], [Bab 3 (login, peran pengguna, API) dan demo], [Demo, repositori, Bab 3],
    [SIB Semester 5 #emph[(acuan awal)];], [Manajemen Proyek Sistem Informasi], [Lembar Status; Bab 5 (rencana dan realisasi, kontribusi, perubahan dan risiko)], [Lembar Status, Bab 5, logbook, kontribusi],
    [SIB Semester 5 #emph[(acuan awal)];], [Penjaminan Mutu Perangkat Lunak], [Bab 4 (rencana uji, kasus uji yang dijalankan, penanganan bug)], [Laporan uji awal, daftar bug],
  )]
  , kind: table
  )

Baris SIB bertanda #emph[(acuan awal)] disusun dari kriteria produk pada materi sosialisasi. Koordinator mengonfirmasinya bersama Kaprodi SIB dan dosen pengampu SIB sebelum SOP diterbitkan. Tanda itu dihapus setelah baris dikonfirmasi.

== 7. Dokumen Tambahan Mata Kuliah
<dokumen-tambahan-mata-kuliah>
Pada dasarnya, #strong[tidak ada dokumen tambahan];. Laporan di Bagian 5 sudah memuat bagian yang dinilai tiap mata kuliah (Bagian 6).

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Jika], [Maka],),
    table.hline(),
    [Dosen belum mengumumkan dokumen tambahan secara tertulis sampai #strong[\[tanggal SOP diterbitkan\]];], [Tidak ada dokumen tambahan. Tim tidak perlu bertanya atau menyiapkan apa pun],
    [Dosen sudah mengumumkan dokumen tambahan secara tertulis sebelum tanggal itu], [Dokumen tetap wajib. Tim melampirkannya sebagai sub-lampiran di Lampiran D, atau menautkannya di Lampiran E bila dokumennya panjang atau berbentuk berkas lain, sesuai aturan dosen],
    [Mata kuliah punya tempat pengumpulan sendiri (misalnya folder Manajemen Proyek)], [Tim mengumpulkan di sana sesuai aturan dosen, lalu menulis tautannya di sub-lampiran D yang sesuai dan di Lampiran E],
    [Dokumen baru diumumkan setelah tanggal SOP diterbitkan], [Belum wajib untuk Milestone 2. Mulai berlaku di tahap berikutnya],
  )]
  , kind: table
  )

=== Susunan Lampiran D
<susunan-lampiran-d>
Setiap dokumen tambahan menjadi #strong[satu sub-lampiran untuk satu mata kuliah];: D.1, D.2, dan seterusnya. Aturannya:

- Tiap sub-lampiran dimulai di halaman baru. Baris pertamanya memuat mata kuliah, nama dosen, nama dokumen, dan tanggal pengumuman tertulisnya.
- Format dokumen ditentukan oleh dosen mata kuliah itu, bukan oleh koordinator.
- Dokumen tambahan #strong[tidak mengulang isi laporan];. Dokumen itu hanya memuat rincian yang tidak diminta SOP ini. Untuk hal yang sudah ada di laporan, dokumen cukup merujuk ke bab yang bersangkutan.
- Koordinator menerbitkan daftar dokumen tambahan bersama SOP (Bagian 4), supaya tim tahu sejak awal dokumen apa saja yang diminta.

=== Yang bukan dokumen tambahan
<yang-bukan-dokumen-tambahan>
Dokumentasi model ML bukan dokumen tambahan, karena sudah menjadi Lampiran F untuk semua tim TI Semester 5. Dokumen kerja yang memang sudah dibuat tim untuk mata kuliah juga bukan dokumen tambahan. Contohnya SRS, desain Figma, Project Charter, WBS dan jadwal, rancangan basis data, serta rencana dan kasus uji. Tim cukup mendaftarkannya di Lampiran C, menautkannya di Lampiran E, dan meringkasnya di bab yang sesuai, tanpa menulisnya ulang.

Dokumen tambahan tidak menggantikan Laporan Milestone 2. Pada pekan Milestone 2, dosen tidak memberi tugas baru di luar laporan.

== 8. Cek Awal Tim (Mulai Semester Berikutnya)
<cek-awal-tim-mulai-semester-berikutnya>
#strong[Cek awal tidak dipakai pada semester ini];, karena waktunya sudah lewat. Cek awal mulai dipakai pada semester berikutnya, dan dicantumkan di sini agar sudah siap.

Cek awal adalah form singkat (sekitar 2 menit) yang diisi Ketua Tim pada Minggu 10. Tujuannya agar koordinator tahu kendala tim sebelum review Minggu 12, tanpa menunggu balasan dosen.

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pertanyaan], [Jawaban],),
    table.hline(),
    [Status fitur], [Persentase fitur yang selesai dibanding proposal],
    [Status tim], [Sesuai Rencana, Perlu Perhatian, atau Kritis],
    [Kendala utama], [Teknis; waktu dan beban kerja; koordinasi tim; kontribusi anggota; fasilitas dan server; mitra atau pengguna; arahan dosen; lainnya],
    [Bantuan yang dibutuhkan], [Konsultasi dosen (sebutkan mata kuliah), konsultasi koordinator, fasilitas, atau tidak ada],
    [Jumlah konsultasi dengan dosen sejak Minggu 8], [0, 1--2, atau 3 kali atau lebih],
  )]
  , kind: table
  )

Setelah form diisi, koordinator memeriksa jawaban dalam 3 hari. Koordinator menghubungi tim yang berstatus Perlu Perhatian atau Kritis untuk menyepakati langkah berikutnya: konsultasi, perubahan cakupan fitur, atau rencana perbaikan. Cek awal tidak dinilai.

== 9. Peran dan Tanggung Jawab
<peran-dan-tanggung-jawab>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pihak], [Tanggung jawab],),
    table.hline(),
    [Ketua Tim], [Memastikan laporan lengkap dan tepat waktu, lalu mengunggahnya lewat Google Form],
    [Sekretaris/Dokumentator], [Menyusun laporan sesuai Template, merekap logbook, dan mengelola daftar tautan serta dokumen rujukan],
    [Semua anggota], [Menulis bagian masing-masing, menulis bukti kontribusi, dan mengisi Penilaian 360 lewat Google Form (Bagian 9.3). Anggota yang tidak setuju dengan pembagian kontribusi boleh langsung menghubungi koordinator],
    [Dosen pengampu], [Hadir dan menilai demo. Menilai bagian laporan sesuai Bagian 6, memberi umpan balik, menyampaikan porsi nilai dan rubrik, menyediakan materi pendukung sebelum milestone, dan menyediakan sesi tinjau proyek (sekitar 15 menit per tim). Memakai rekap Penilaian 360 sebagai bahan nilai kontribusi individu],
    [Dosen rujukan], [Satu dosen untuk tiap kelas. Tempat bertanya pertama bagi tim (Bagian 9.1)],
    [Koordinator PBL], [Menetapkan dan menerbitkan tabel penilaian, daftar dosen rujukan, dan daftar dokumen tambahan. Merekap pengumpulan, menjalankan form Penilaian 360 lalu mengirim rekapnya ke dosen, dan membantu tim yang perlu perbaikan],
  )]
  , kind: table
  )

=== 9.1 Dosen Rujukan
<dosen-rujukan>
Dosen rujukan adalah satu dosen untuk tiap kelas yang ditunjuk sebagai tempat bertanya pertama bagi tim. Koordinator mengumumkan daftarnya.

- Tim bertanya ke dosen rujukan lebih dulu. Dosen rujukan menjawab, atau meneruskan pertanyaan ke dosen mata kuliah yang tepat.
- Jika arahan dari beberapa dosen berbeda, dosen rujukan membantu menyelesaikannya bersama koordinator.
- Dosen rujukan mengikuti kondisi tim di kelasnya, supaya masalah tim cepat diketahui.

=== 9.2 Permintaan di Luar Rencana
<permintaan-di-luar-rencana>
Setelah proposal disetujui, dosen bisa meminta fitur atau perubahan di luar proposal. Aturannya:

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Jenis permintaan], [Cara menyampaikan],),
    table.hline(),
    [Fitur baru atau perubahan alur yang besar], [Dibahas dulu dengan dosen rujukan atau koordinator, disampaikan secara tertulis, dan diberikan paling lambat 1 minggu sebelum review],
    [Saran atau perbaikan kecil], [Boleh disampaikan saat review],
  )]
  , kind: table
  )

Tim mencatat permintaan yang masuk di Bab 5.3 laporan, lalu memasukkannya ke rencana Minggu 13--16 jika disepakati.

=== 9.3 Penilaian 360
<penilaian-360>
Laporan ditulis oleh tim itu sendiri, sehingga laporan tidak bisa membuktikan bahwa pembagian kontribusi benar. Karena itu, kontribusi anggota diperiksa lewat #strong[form Penilaian 360] yang terpisah dari laporan.

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Hal], [Ketentuan],),
    table.hline(),
    [Waktu], [Form dibuka pada Minggu 11 dan ditutup bersama batas akhir pengumpulan laporan],
    [Pengisi], [Setiap anggota mengisi sendiri, satu kali, dengan akun Polinema. Satu akun hanya bisa mengirim satu tanggapan],
    [Isi], [Penilaian diri sendiri dan tiap rekan satu tim dengan skala 1--5 pada empat aspek: kontribusi pekerjaan, tanggung jawab dan ketepatan waktu, kerja sama dan komunikasi, serta kehadiran dan keterlibatan dalam rapat. Lalu pembagian #strong[100 poin] kontribusi untuk seluruh anggota, termasuk diri sendiri. Komentar singkat boleh diisi],
    [Kerahasiaan], [Hanya koordinator dan dosen pengampu kelas yang melihat hasilnya. Rekan satu tim tidak melihat hasilnya, dan hasilnya tidak ditulis di laporan],
    [Pemakaian], [Koordinator mengirim rekap per mahasiswa kepada dosen pengampu: rata-rata penilaian dan rata-rata poin dari rekan tim, tanpa penilaian diri. Dosen memakainya sebagai bahan nilai kontribusi individu],
    [Pemeriksaan], [Koordinator membandingkan rata-rata poin dengan estimasi kontribusi di Bab 5.2. Jika selisih untuk satu anggota lebih dari 15 poin, koordinator menghubungi tim untuk menjelaskan sebabnya],
  )]
  , kind: table
  )

Koordinator memeriksa daftar tanggapan terhadap daftar anggota tim, bukan terhadap laporan. Anggota yang belum mengisi diingatkan satu hari sebelum batas akhir. Anggota yang tetap tidak mengisi diproses sesuai aturan mata kuliah, dan nilai kontribusinya hanya berdasarkan penilaian rekan. Penilaian rekan pada Demo Day (Minggu 16) sesuai RPP tetap berjalan dan terpisah dari Penilaian 360 ini.

== 10. Pilihan yang Diterima
<pilihan-yang-diterima>
Tabel berikut memastikan tidak ada tim yang keluar dari standar karena kondisi teknis atau kondisi di lapangan. Setiap tim memilih satu pilihan yang paling sesuai, lalu menulisnya di Lembar Status (S.5).

=== 10.1 Bentuk Demo
<bentuk-demo>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pilihan], [Keterangan],),
    table.hline(),
    [Langsung], [Demo di sesi kelas yang dijadwalkan dosen],
    [Video], [Video maksimal 5 menit dan ditautkan. Boleh dipilih jika tim tidak bisa hadir atau aplikasi tidak bisa dijalankan di kelas],
    [Gabungan], [Demo langsung, ditambah video untuk bagian yang tidak stabil di kelas],
  )]
  , kind: table
  )

Setiap anggota membawakan minimal satu bagian demo atau satu bagian video.

=== 10.2 Cara #emph[Deploy]
<cara-deploy>
#emph[Deploy] berarti menaruh aplikasi di tempat yang bisa dibuka orang lain.

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pilihan], [Keterangan],),
    table.hline(),
    [Server kampus], [Jika tersedia dan tim sudah punya akses],
    [Hosting gratis atau milik sendiri], [Tulis alamat aplikasi],
    [Lokal dengan video], [Aplikasi dijalankan di komputer tim dan ditunjukkan lewat video. Wajib untuk bagian yang tidak di-#emph[deploy];],
    [Aplikasi #emph[mobile];], [Berkas instalasi (APK) atau tautan uji. Jika tidak bisa dibagikan, gunakan video],
  )]
  , kind: table
  )

Tidak punya server kampus #strong[tidak mengurangi nilai];, selama tim bisa membuktikan aplikasinya berjalan. Jika tim butuh server kampus tetapi belum mendapatkannya, tulis di Bab 5.3 sebagai risiko supaya kebutuhannya bisa didata.

=== 10.3 Bukti Pengujian
<bukti-pengujian>
Semua tim wajib menulis #strong[minimal 10 kasus uji untuk alur utama] di Bab 4, lengkap dengan hasilnya. Jenis uji lain di bawah ini boleh ditambahkan sesuai kebutuhan tim.

#figure(
  align(left)[#table(
    columns: (33.33%, 33.33%, 33.33%),
    align: (auto,auto,auto,),
    table.header([Jenis], [Cocok untuk], [Bukti],),
    table.hline(),
    [Uji manual], [Semua tim], [Tabel kasus uji: ID, skenario, langkah, hasil yang diharapkan, hasil sebenarnya, status],
    [Uji otomatis], [Semua tim], [Ringkasan hasil dan tautan ke kode pengujian],
    [Uji coba oleh pengguna], [Semua tim], [Ringkasan sesi, jumlah pengguna, temuan],
    [Uji kebenaran data], [Tim dengan mata kuliah basis data], [Skenario kueri, hasil, perbaikan],
    [Uji kueri dengan #emph[EXPLAIN ANALYZE];], [Tim dengan mata kuliah basis data #strong[\[Sem 3\]];], [Tabel hasil dan tangkapan layar dari PostgreSQL di Lampiran G],
    [Hasil awal model], [#strong[\[TI Sem 5\]];], [Dataset yang dipakai, ukuran hasil model (misalnya akurasi), hasil awal, rencana perbaikan. Rinciannya di Lampiran F],
    [Laporan uji awal], [TI Semester 5 dan SIB Semester 5], [Rencana uji, kasus uji yang dijalankan, daftar bug],
  )]
  , kind: table
  )

=== 10.4 Masukan dari Mitra atau Pengguna
<masukan-dari-mitra-atau-pengguna>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pilihan], [Keterangan],),
    table.hline(),
    [Mitra], [Mitra menanggapi demo atau memberi masukan tertulis],
    [Calon pengguna], [Minimal 3 calon pengguna mencoba produk dan memberi masukan],
    [Pengguna pengganti], [Jika mitra tidak ada, teman di luar tim atau dosen berperan sebagai pengguna. Tulis alasannya],
  )]
  , kind: table
  )

=== 10.5 Kondisi Tim
<kondisi-tim>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Kondisi], [Ketentuan],),
    table.hline(),
    [Cakupan fitur berubah], [Catat di Bab 5.3 dan konsultasikan dengan dosen yang mengampu bagian terkait],
    [Anggota tidak aktif atau keluar], [Catat di tabel kontribusi beserta buktinya. Tim menghubungi koordinator sebelum batas pengumpulan],
    [Mitra tidak bisa dihubungi lagi], [Pakai pilihan pengguna pengganti (10.4). Nilai tidak dikurangi],
    [Arahan dosen berbeda], [Tanyakan ke dosen rujukan. Ikuti arahan tertulis terakhir dari dosen rujukan atau koordinator, lalu catat di Bab 5.3],
    [Terlambat mengumpulkan], [Hubungi koordinator #strong[sebelum] batas akhir. Keterlambatan tanpa pemberitahuan diproses sesuai aturan mata kuliah],
  )]
  , kind: table
  )

== 11. Langkah Pengumpulan
<langkah-pengumpulan>
+ #strong[Pahami strukturnya.] Baca Template Laporan Milestone 2 PBL, mulai dari bagian #emph[Gambaran Umum Struktur];. Setelah itu, buka Contoh Laporan yang sesuai dengan program studi dan semester tim untuk melihat hasil akhirnya. Susun dokumen tim sendiri dengan urutan yang sama. Ikuti susunan, bentuk tabel, dan kedalaman isinya, tetapi tulis isi dari proyek tim sendiri. Gaya visual dan sampul tidak perlu meniru contoh. Paragraf panduan (cetak miring), label catatan seperti \"dipindahkan dari proposal\", dan isi contoh tidak ditulis di laporan. Laporan yang hanya menyalin contoh tidak diterima.
+ #strong[Gunakan bahan yang sudah ada.] Gunakan isi proposal untuk Bab 1--2, lalu perbarui. Tulis Bab 3--4 dari hasil kerja dan hasil uji, serta Bab 5 dari logbook dan Laporan Kemajuan. Isi Lembar Status paling akhir. Ambil isi Lampiran F dan G dari notebook, kueri, dan hasil uji yang sudah ada, dan tautkan dokumen kerja tim di Lampiran E.
+ #strong[Siapkan bukti.] Siapkan repositori Git dengan #emph[tag] `milestone-2` (penanda versi kode pada saat Milestone 2), bukti demo, bukti pengujian (Bagian 10.3), dan alamat aplikasi jika sudah di-#emph[deploy];.
+ #strong[Isi Penilaian 360.] Setiap anggota mengisi Google Form Penilaian 360 secara pribadi (Bagian 9.3). Hasilnya tidak ditulis di laporan, tetapi tabel kontribusi di Bab 5.2 tetap diisi tim dengan bukti yang bisa dicek.
+ #strong[Uji tautan.] Buka semua tautan di mode #emph[incognito];. Pastikan tautan bisa dibuka tanpa login (Bagian 13).
+ #strong[Periksa kelengkapan] memakai daftar di Bagian 14.
+ #strong[Ekspor menjadi satu PDF] bernama `M2_<Kelas>_<NamaTim>.pdf`. Pastikan tautan tetap bisa diklik.
+ #strong[Unggah] lewat Google Form Milestone 2: #strong[\[tautan form\]];.
+ #strong[Ikuti demo] sesuai jadwal kelas.
+ #strong[Terima umpan balik];, lalu susun rencana Minggu 13--16 berdasarkan masukan.

== 12. Status Milestone 2
<status-milestone-2>
Setelah demo dan pemeriksaan laporan, tim mendapat salah satu status berikut.

#figure(
  align(left)[#table(
    columns: (33.33%, 33.33%, 33.33%),
    align: (auto,auto,auto,),
    table.header([Status], [Ciri], [Tindak lanjut],),
    table.hline(),
    [#strong[Lengkap];], [Alur utama berjalan dengan baik saat demo, dan semua dokumen wajib sudah ada (Bagian 14)], [Lanjut ke tahap pengujian akhir],
    [#strong[Sebagian];], [Alur utama berjalan, tetapi sering gagal saat demo, atau ada dokumen wajib yang belum ada], [Tim menulis rencana perbaikan di Minggu 13 dan berkonsultasi dengan koordinator. Koordinator memantau di Minggu 14],
    [#strong[Kritis];], [Alur utama belum berjalan, atau tim tidak bisa bekerja sama], [Tim bertemu koordinator dan dosen, lalu menyesuaikan cakupan fitur dan menyusun rencana perbaikan sebelum maju ke sidang akhir],
  )]
  , kind: table
  )

Fitur yang belum selesai tidak membuat status turun, selama fitur itu sudah masuk rencana Minggu 13--16. Status ini bukan hukuman. Dosen pengampu dan koordinator menentukannya bersama, lalu menyampaikannya kepada tim secara tertulis.

== 13. Aturan Tautan Eksternal
<aturan-tautan-eksternal>
Aturannya sama dengan SOP Laporan Kemajuan PBL.

+ #strong[Bisa diklik.] Tulis tautan sebagai teks aktif, dan tampilkan juga alamat lengkapnya.
+ #strong[Dikumpulkan dalam satu tabel] di Lampiran E: nomor, keterangan, bagian yang merujuk, tautan, dan jenis akses. Tautan dokumen rujukan (Lampiran C) dan dokumen tambahan (Lampiran D) juga masuk ke tabel ini.
+ #strong[Akses terbuka.] Dosen bisa membuka tautan tanpa login. Pada Google Drive, pilih \"Siapa saja yang memiliki link\" (Pelihat). Utamakan tautan ke berkas.
+ #strong[Diuji sebelum dikumpulkan.] Buka semua tautan di mode #emph[incognito];. Tautan yang tidak bisa dibuka dianggap tidak ada.
+ #strong[Isi tidak diubah] setelah batas akhir. Untuk bukti yang tetap, gunakan tautan ke #emph[commit] atau #emph[tag] tertentu di Git.
+ #strong[Laporan bisa dipahami tanpa tautan.] Lembar Status dan Bab 1--5 harus bisa dipahami tanpa membuka tautan apa pun.

== 14. Daftar Periksa Kelengkapan
<daftar-periksa-kelengkapan>
- ☐ Sampul memuat judul laporan, judul produk, identitas tim, logo dan institusi, serta bulan dan tahun.
- ☐ Lembar Status (S.1--S.6) lengkap, termasuk Status Milestone 2 dan rencana Minggu 13--16.
- ☐ Bab 1--3 terisi, Bab 4 memuat hasil uji awal, dan Bab 5.1--5.3 terisi (kontribusi, perubahan, risiko). Bab 4.6, 5.4, dan 5.5 cukup berupa judul.
- ☐ Bab 4 memuat minimal 10 kasus uji untuk alur utama, beserta hasilnya.
- ☐ Alur utama sudah bisa didemokan. Bentuk demo sudah dipilih (Bagian 10.1), dan setiap anggota membawakan minimal satu bagian.
- ☐ Tautan repositori Git dengan #emph[tag] `milestone-2`.
- ☐ Lampiran A (tangkapan layar), B (logbook), C (dokumen rujukan, misalnya SRS dan desain Figma), E (tautan eksternal), dan H (deklarasi AI).
- ☐ Setiap anggota sudah mengisi Penilaian 360 lewat Google Form. Koordinator memeriksanya dari daftar tanggapan, bukan dari laporan.
- ☐ Setiap gambar, tabel, dan potongan kode punya nomor dan judul, lalu dirujuk di paragraf yang menjelaskannya. Tabel di Lembar Status tidak perlu bernomor.
- ☐ Logbook mencatat siapa mengerjakan apa.
- ☐ Permintaan tambahan dari dosen, jika ada, tercatat di Bab 5.3.
- ☐ Lampiran F lengkap, untuk tim TI Semester 5: F.1 sampai F.5 (dataset, praproses, minimal dua eksperimen pembanding, evaluasi rinci, kesimpulan analisis), paling banyak 4 halaman.
- ☐ Lampiran G lengkap, untuk tim Semester 3: minimal 5 kueri beserta fungsinya, dan hasil #emph[EXPLAIN ANALYZE] untuk minimal 3 kueri, lengkap dengan tangkapan layar.
- ☐ Deklarasi penggunaan AI.
- ☐ Lampiran D.1, D.2, dan seterusnya untuk tiap dokumen tambahan yang diumumkan dosen (Bagian 7), bila ada.
- ☐ Semua tautan sudah diuji di mode #emph[incognito];.

== 15. Target Milestone 2 per Program Studi dan Semester
<target-milestone-2-per-program-studi-dan-semester>
Pada Minggu 12, #strong[alur utama produk sudah berjalan dan bisa didemokan];. Alur utama adalah kegiatan terpenting yang dilakukan pengguna di produk, misalnya mengajukan peminjaman sampai disetujui. Fitur lain boleh belum selesai, asalkan sudah masuk rencana Minggu 13--16.

Target di bawah ini adalah syarat minimal. Target TI mengacu pada RPP. Target SIB adalah acuan awal dan dapat disesuaikan.

#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Program studi dan semester], [Target Milestone 2],),
    table.hline(),
    [#strong[TI Semester 3];], [Alur utama aplikasi web berjalan dari awal sampai akhir dan tersambung ke basis data. Minimal 2 peran pengguna bisa login. Laporan atau dasbor boleh belum selesai, tetapi sudah direncanakan],
    [#strong[TI Semester 5];], [Alur utama aplikasi #emph[mobile] berjalan. Model ML sudah bisa dipanggil dari aplikasi, dengan hasil awal yang boleh belum bagus],
    [#strong[SIB Semester 3] #emph[(acuan awal)];], [Satu alur bisnis utama berjalan dari awal sampai akhir, misalnya pesan, bayar, lalu konfirmasi. Tampilan mengikuti prototipe],
    [#strong[SIB Semester 5] #emph[(acuan awal)];], [Alur utama web berjalan dengan login dan minimal 2 peran. Jadwal dan risiko proyek sudah dicatat],
  )]
  , kind: table
  )

Semua tim juga mengumpulkan Bab 1--3, hasil uji awal (Bab 4), dan Bab 5.1--5.3.

== 16. Hal yang Dinilai Dosen
<hal-yang-dinilai-dosen>
Dosen menilai tujuh hal berikut dengan rubrik yang sama. Porsi nilai tiap mata kuliah mengikuti aturan mata kuliah itu.

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([Hal yang dinilai], [Baik], [Cukup], [Perlu perbaikan],),
    table.hline(),
    [\1. Alur utama saat demo], [Berjalan stabil dan sesuai target Milestone 2], [Berjalan, tetapi sesekali gagal], [Belum berjalan],
    [\2. Kualitas demo], [Semua anggota paham dan bisa menjelaskan bagiannya], [Sebagian anggota paham bagiannya], [Banyak anggota tidak bisa menjelaskan bagiannya],
    [\3. Bab 1--3], [Jelas, lengkap, dan sesuai produk yang dibuat], [Lengkap, tetapi sebagian tidak sesuai produk], [Banyak bagian kosong atau tidak sesuai produk],
    [\4. Hasil pengujian], [Minimal 10 kasus uji, hasil apa adanya, bug dicatat], [Kasus uji ada, tetapi bug belum dicatat lengkap], [Kasus uji kurang atau hasilnya tidak jelas],
    [\5. Kontribusi tiap anggota (Bab 5.2 dan Penilaian 360)], [Ada bukti dan sesuai hasil Penilaian 360], [Bukti ada, tetapi sebagian tidak sesuai], [Bukti tidak ada atau bertentangan],
    [\6. Rencana Minggu 13--16 (S.6, Bab 5.1)], [Jelas, termasuk fitur yang belum selesai], [Ada, tetapi kurang rinci], [Tidak ada atau tidak realistis],
    [\7. Logbook (Lampiran B) dan tautan bukti], [Rapi, dan semua tautan bisa dibuka], [Sebagian kurang rapi atau ada tautan bermasalah], [Tidak lengkap atau tautan tidak bisa dibuka],
  )]
  , kind: table
  )

== 17. Etika Akademik dan Penggunaan AI
<etika-akademik-dan-penggunaan-ai>
Aturan orisinalitas dan penggunaan AI mengikuti RPP PBL. AI boleh dipakai sebagai alat bantu. Semua anggota harus paham dan bisa menjelaskan hasilnya. Penggunaan AI ditulis di bagian khusus dalam laporan.

== 18. Kontak
<kontak>
Koordinator PBL: Dian Hanifudin Subhi, S.Kom., M.Kom. (dhanifudin\@polinema.ac.id)

Dosen rujukan kelas: lihat daftar yang diumumkan koordinator.

Folder dokumen PBL: https:\/\/drive.google.com/drive/folders/15q1RaS64I4VPQ4aTbJetim0Yu0IxdbBt?usp=drive\_link
