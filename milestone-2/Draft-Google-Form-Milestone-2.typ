#let horizontalrule = line(start: (25%, 0%), end: (75%, 0%), stroke: 0.5pt + rgb("#c3d8cf"))
#import "style.typ": *
#show: doc => conf(title: "Draf Google Form Milestone 2 PBL", doc)
= Draf Google Form: Milestone 2 PBL
<draf-google-form-milestone-2-pbl>
Dokumen ini berisi tiga draf form untuk koordinator PBL: #strong[Form 1 (Cek Awal Minggu 10, dipakai mulai semester berikutnya, tidak dipakai semester ini)];, #strong[Form 2 (Pengumpulan Laporan Milestone 2)];, dan #strong[Form 3 (Penilaian 360, dipakai semester ini)];. Isinya mengikuti SOP Pengumpulan Laporan Milestone 2 PBL. Form 1 dan Form 2 diisi oleh Ketua Tim, sedangkan Form 3 diisi oleh setiap anggota tim. Dosen tidak mengisi form apa pun.

Perbaikan dibanding form Milestone 1:

- Kolom kelas tetap berupa pilihan terbatas (dropdown) agar hasil rekap seragam.
- Ditambahkan form cek awal agar kendala tim diketahui sebelum Minggu 12 (dipakai mulai semester berikutnya).
- Ditambahkan pilihan bentuk demo, cara #emph[deploy];, dan Status Milestone 2 pada form pengumpulan, sehingga semua kondisi tim tertampung.

#horizontalrule

= Form 1: Cek Awal Minggu 10 (Mulai Semester Berikutnya)
<form-1-cek-awal-minggu-10-mulai-semester-berikutnya>
#emph[Form ini tidak dibuat dan tidak dibagikan pada semester ini. Draf disimpan agar siap dipakai semester berikutnya.]

== 1. Pengaturan Form
<pengaturan-form>
#figure(
  align(left)[#table(
    columns: 2,
    align: (auto,auto,),
    table.header([Pengaturan], [Nilai],),
    table.hline(),
    [Judul form], [Cek Awal Milestone 2 PBL (Minggu 10)],
    [Kumpulkan alamat email], [Aktif (verifikasi)],
    [Izinkan ubah jawaban setelah dikirim], [Aktif],
    [Estimasi waktu], [Sekitar 2 menit],
    [Batas akhir], [#strong[27 November 2026, pukul 23.59 WIB];],
  )]
  , kind: table
  )

=== Deskripsi form
<deskripsi-form>
#quote(block: true)[
Form singkat ini dipakai koordinator untuk mengetahui kendala tim lebih awal agar dapat dibantu sebelum Milestone 2. #strong[Jawaban tidak dinilai.] Diisi oleh Ketua Tim, satu kali per tim.
]

== 2. Pertanyaan
<pertanyaan>
#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Isian],),
    table.hline(),
    [1], [Program Studi], [Pilihan ganda], [Teknik Informatika (TI); Sistem Informasi Bisnis (SIB)],
    [2], [Tingkat dan Semester], [Pilihan ganda], [Tingkat 2, Semester 3; Tingkat 3, Semester 5],
    [3], [Kelas], [Dropdown], [TI-2A sampai TI-2I (Semester 3), TI-3A sampai TI-3I (Semester 5); SIB-2A sampai SIB-2G (Semester 3), SIB-3A sampai SIB-3G (Semester 5)],
    [4], [Nama Tim], [Jawaban singkat], [Sama dengan proposal],
    [5], [Persentase fitur proposal yang sudah selesai], [Skala linear], [0--100% dalam kelipatan 10],
    [6], [Status keseluruhan], [Pilihan ganda], [Sesuai rencana; Perlu Perhatian; Kritis],
    [7], [Kendala utama (pilih maksimal 2)], [Kotak centang], [Kendala teknis; waktu dan beban kerja; koordinasi tim; kontribusi anggota tidak seimbang; fasilitas dan server; mitra atau pengguna; arahan dosen tidak selaras; tidak ada; lainnya (sebutkan)],
    [8], [Konsultasi dengan dosen sejak Minggu 8], [Pilihan ganda], [0 kali; 1--2 kali; 3 kali atau lebih],
    [9], [Bantuan yang dibutuhkan], [Kotak centang], [Konsultasi dosen (sebutkan mata kuliah); konsultasi koordinator; fasilitas atau server; perubahan cakupan fitur; tidak ada],
    [10], [Catatan], [Paragraf (opsional)], [],
  )]
  , kind: table
  )

== 3. Pesan Setelah Form Dikirim
<pesan-setelah-form-dikirim>
#quote(block: true)[
Terima kasih. Koordinator akan menghubungi tim berstatus Perlu Perhatian atau Kritis dalam tiga hari.
]

== 4. Panduan Koordinator
<panduan-koordinator>
- Hubungkan jawaban ke Google Sheets dan beri warna pada status Perlu Perhatian (kuning) dan Kritis (merah).
- Hubungi tim Perlu Perhatian atau Kritis dalam tiga hari dan catat langkah yang disepakati (konsultasi, perubahan cakupan fitur, atau rencana perbaikan).
- Tim yang belum mengisi diingatkan melalui pengumuman kelas.

#horizontalrule

= Form 2: Pengumpulan Laporan Milestone 2
<form-2-pengumpulan-laporan-milestone-2>
== 1. Pengaturan Form
<pengaturan-form-1>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pengaturan], [Nilai],),
    table.hline(),
    [Judul form], [Pengumpulan Laporan Milestone 2 PBL],
    [Kumpulkan alamat email], [Aktif (verifikasi)],
    [Wajib masuk akun Google], [Ya (diperlukan oleh fitur unggah berkas)],
    [Izinkan ubah jawaban setelah dikirim], [Aktif],
    [Batas akhir], [#strong[27 November 2026, pukul 23.59 WIB];. Form tidak ditutup otomatis; koordinator menutupnya secara manual setelah batas akhir],
  )]
  , kind: table
  )

=== Deskripsi form
<deskripsi-form-1>
#quote(block: true)[
Form ini digunakan untuk mengumpulkan #strong[Laporan Milestone 2 PBL];.

- Satu tim mengumpulkan #strong[satu berkas PDF] (Lembar Status, Bab 1--5, dan lampiran). Form diisi oleh Ketua Tim.
- Batas akhir pengumpulan: #strong[27 November 2026, pukul 23.59 WIB];.
- SOP dan Template Laporan Milestone 2 tersedia pada folder berikut: https:\/\/drive.google.com/drive/folders/1ihojXCwWLVCHyIHmGIm5OHN0xkZ8PXPU?usp=sharing
- Ikuti susunan Template, tetapi tulis isi dari proyek tim sendiri.
]

== 2. Bagian 1: Identitas Tim
<bagian-1-identitas-tim>
Semua pertanyaan wajib diisi.

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Isian dan aturan],),
    table.hline(),
    [1], [Program Studi], [Pilihan ganda], [Teknik Informatika (TI); Sistem Informasi Bisnis (SIB)],
    [2], [Tingkat dan Semester], [Pilihan ganda], [Tingkat 2, Semester 3; Tingkat 3, Semester 5],
    [3], [Kelas], [Dropdown], [TI-2A sampai TI-2I (Semester 3), TI-3A sampai TI-3I (Semester 5); SIB-2A sampai SIB-2G (Semester 3), SIB-3A sampai SIB-3G (Semester 5)],
    [4], [Nama Tim], [Jawaban singkat], [Sama dengan proposal dan sampul],
    [5], [Judul Produk], [Jawaban singkat], [Sama dengan sampul],
    [6], [Nama Ketua Tim], [Jawaban singkat], [Nama lengkap sesuai data akademik],
    [7], [NIM Ketua Tim], [Jawaban singkat], [Hanya angka, 12 digit],
  )]
  , kind: table
  )

== 3. Bagian 2: Kondisi Tim
<bagian-2-kondisi-tim>
Semua pertanyaan wajib diisi. Seluruh pilihan diterima tanpa pengurangan nilai.

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Isian],),
    table.hline(),
    [8], [Status Milestone 2 menurut tim], [Pilihan ganda], [Lengkap (alur utama berjalan dan dokumen wajib lengkap); Sebagian (alur utama berjalan tetapi sering gagal, atau ada dokumen yang belum ada); Kritis (alur utama belum berjalan)],
    [9], [Bentuk demo yang diusulkan tim], [Pilihan ganda], [Langsung; video; gabungan. Keterangan di bawah pertanyaan: dosen tiap kelas yang menentukan jadwal dan bentuk akhir demo (SOP Bagian 10.6)],
    [10], [Cara #emph[deploy];], [Pilihan ganda], [Server kampus; hosting gratis atau milik sendiri; lokal dengan video; berkas instalasi (APK)],
    [11], [Masukan pengguna], [Pilihan ganda], [Mitra; calon pengguna (min. 3 orang); pengguna pengganti],
    [12], [Jenis bukti pengujian (boleh lebih dari satu)], [Kotak centang], [Uji manual (minimal 10 kasus uji); uji otomatis; uji coba oleh pengguna; uji kebenaran data; hasil awal model; laporan uji awal],
    [13], [Dokumen tambahan mata kuliah], [Pilihan ganda], [Tidak ada; ada dan sudah dilampirkan pada Lampiran D; ada dan sudah dikumpulkan di tempat pengumpulan mata kuliah (misalnya lembar penilaian mandiri Manajemen Proyek) dan dicatat di Lampiran D],
  )]
  , kind: table
  )

== 4. Bagian 3: Berkas
<bagian-3-berkas>
#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Ketentuan],),
    table.hline(),
    [14], [Berkas Laporan Milestone 2 (PDF)], [Unggah berkas (wajib)], [Hanya PDF; maksimum 1 berkas; ukuran maksimum 50 MB (berkas besar cukup ditautkan sesuai SOP Bagian 13). Nama berkas `M2_<Kelas>_<NamaTim>.pdf`. Satu-satunya kolom unggah],
    [15], [Pernyataan kelengkapan], [Kotak centang (semua wajib dicentang)], [Lihat daftar di bawah],
    [16], [Catatan tambahan], [Paragraf (opsional)], [Kendala atau informasi untuk koordinator],
  )]
  , kind: table
  )

=== Pernyataan kelengkapan (pertanyaan 15)
<pernyataan-kelengkapan-pertanyaan-15>
+ Berkas memuat sampul, Lembar Status, Bab 1--5, dan lampiran sesuai struktur Template. Bab 4 memuat minimal 10 kasus uji.
+ Setiap anggota sudah diminta mengisi Penilaian 360 lewat form terpisah. Hasilnya tidak perlu dilampirkan di laporan.
+ Seluruh tautan eksternal sudah diuji di mode #emph[incognito] dan dapat dibuka tanpa login.
+ Laporan disusun mengikuti struktur Template dan bukan salinan Template.

== 5. Pesan Setelah Form Dikirim
<pesan-setelah-form-dikirim-1>
#quote(block: true)[
Terima kasih. Laporan Milestone 2 tim telah diterima. Jawaban dapat diubah hingga batas akhir pengumpulan melalui tautan \"Edit jawaban\".
]

== 6. Panduan Koordinator
<panduan-koordinator-1>
- Hubungkan jawaban form ke Google Sheets dan periksa entri ganda dengan kombinasi Kelas dan Nama Tim; gunakan entri terbaru.
- Bandingkan Status Milestone 2 yang dipilih tim (pertanyaan 8) dengan hasil cek awal Minggu 10 untuk melihat perubahan (jika cek awal dipakai).
- Rekap pilihan demo, #emph[deploy];, dan masukan pengguna untuk menjadwalkan sesi demo dan mengetahui kebutuhan fasilitas.
- Dokumen mata kuliah yang dikumpulkan di tempat pengumpulan mata kuliah itu sendiri tidak dikumpulkan melalui form ini.

== 7. Daftar Periksa Sebelum Membagikan Form
<daftar-periksa-sebelum-membagikan-form>
- ☐ Tanggal batas akhir (27 November 2026) dan daftar kelas SIB sudah terisi pada Form 2 dan Form 3. Form 1 diisi nanti, saat dipakai pada semester berikutnya.
- ☐ Kirim satu data uji pada masing-masing form, lalu pastikan berkas unggahan dapat dibuka dan hapus data uji.
- ☒ Tautan Form 2 (https:\/\/forms.gle/px8Yna7koVGcBzd89) sudah dicantumkan pada SOP (Bagian 11, langkah 8) dan pengumuman.
- ☐ Pastikan hanya koordinator PBL yang memiliki akses edit form.

#horizontalrule

= Form 3: Penilaian 360
<form-3-penilaian-360>
Form ini mengumpulkan informasi lengkap tentang #strong[kontribusi nyata tiap anggota] untuk memberi kredit dan memvalidasi kontribusi, karena tim tidak bisa membuktikan sendiri pembagian kontribusinya di dalam laporan. Tim terdiri atas 4--6 anggota. Setiap anggota menilai seluruh rekan #strong[dan dirinya sendiri] (360 derajat). Aturannya ada di SOP Bagian 9.3. Form dan Rekap dibuat otomatis oleh `penilaian-360/Buat-Form-Penilaian-360.gs`, tanpa daftar tim.

== 1. Pengaturan Form
<pengaturan-form-2>
#figure(
  align(left)[#table(
    columns: (50%, 50%),
    align: (auto,auto,),
    table.header([Pengaturan], [Nilai],),
    table.hline(),
    [Judul form], [Penilaian 360 PBL (Milestone 2)],
    [Kumpulkan alamat email], [Aktif (verifikasi akun Polinema)],
    [Batasi satu tanggapan per akun], [Aktif],
    [Izinkan ubah jawaban setelah dikirim], [Aktif sampai batas akhir],
    [Estimasi waktu], [Sekitar 10--15 menit untuk tim 6 orang],
    [Dibuka], [Minggu 11],
    [Batas akhir], [Sama dengan batas akhir pengumpulan laporan: #strong[27 November 2026, pukul 23.59 WIB];],
  )]
  , kind: table
  )

=== Deskripsi form
<deskripsi-form-2>
#quote(block: true)[
Form ini mengumpulkan informasi tentang kontribusi nyata setiap anggota tim, untuk memberi kredit dan memvalidasi kontribusi. Anda menilai seluruh rekan satu tim #strong[dan diri Anda sendiri] (penilaian 360 derajat). #strong[Isi sendiri, jujur, dan jangan berdiskusi dengan rekan satu tim.] Tulis juga pekerjaan konkret tiap orang beserta buktinya.

Hasil dilihat koordinator PBL dan dosen pengampu, termasuk siapa memberi penilaian apa. Rekan satu tim tidak melihat hasilnya.
]

== 2. Pertanyaan
<pertanyaan-1>
Form ini #strong[tidak memakai daftar tim];. Pengisi memilih kelas, mengetik nama tim, lalu mengisi anggota satu per satu (termasuk dirinya sendiri) dengan mengetik nama. Semua isian wajib kecuali yang tertulis opsional.

#strong[Halaman identitas]

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Isian dan aturan],),
    table.hline(),
    [1], [Kelas], [Dropdown], [Daftar kelas, sama dengan Form 2],
    [2], [Nama Tim], [Jawaban singkat], [Ditulis persis seperti proposal. Semua anggota satu tim menulis nama tim yang sama. Ada pengingat untuk menyiapkan lebih dulu pembagian 100 poin untuk seluruh anggota],
  )]
  , kind: table
  )

#strong[Halaman Anggota 1 sampai 6] (satu halaman per anggota; halaman 1--4 pasti diisi, halaman 5 dan 6 muncul bila ada anggota berikutnya)

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan di tiap halaman anggota], [Jenis], [Isian dan aturan],),
    table.hline(),
    [3], [Nama anggota ke-N (nama lengkap)], [Jawaban singkat], [Wajib],
    [4], [Apakah anggota ini adalah Anda sendiri?], [Pilihan ganda], [Ya, ini saya; Bukan, ini rekan saya. Tepat satu halaman harus dijawab Ya],
    [5], [Penilaian anggota ke-N], [Kisi pilihan ganda], [Baris: kontribusi pekerjaan; tanggung jawab dan ketepatan waktu; kerja sama dan komunikasi; kehadiran dan keterlibatan dalam rapat. Kolom: 1 (sangat kurang) sampai 5 (sangat baik)],
    [6], [Poin kontribusi anggota ke-N], [Jawaban singkat (angka 0--100)], [Usahakan jumlah seluruh anggota 100; bila tidak tepat 100, Rekap menyesuaikan secara proporsional],
    [7], [Apa saja yang dikerjakan anggota ke-N?], [Paragraf], [Tugas konkret dan buktinya (modul, halaman laporan, #emph[commit];, dokumen). Untuk diri sendiri: apa yang Anda kerjakan],
    [8], [Apakah masih ada anggota berikutnya? (hanya pada halaman 4 dan 5)], [Pilihan ganda], [Ya, ada anggota ke-N+1 (lanjut ke halaman berikutnya); Tidak, ini anggota terakhir (lanjut ke Penutup)],
  )]
  , kind: table
  )

#strong[Halaman Penutup]

#figure(
  align(left)[#table(
    columns: (25%, 25%, 25%, 25%),
    align: (auto,auto,auto,auto,),
    table.header([No], [Pertanyaan], [Jenis], [Isian dan aturan],),
    table.hline(),
    [9], [Bukti kontribusi Anda], [Paragraf (opsional)], [Tautan #emph[commit];, berkas, atau dokumen pendukung],
    [10], [Siapa yang paling berkontribusi dalam tim, dan mengapa?], [Paragraf], [Wajib],
    [11], [Adakah anggota yang hampir tidak berkontribusi? Jelaskan], [Paragraf], [Wajib. Bila tidak ada, tulis \"Tidak ada\"],
    [12], [Komentar tambahan], [Paragraf (opsional)], [Hal lain yang perlu diketahui koordinator],
  )]
  , kind: table
  )

== 3. Pesan Setelah Form Dikirim
<pesan-setelah-form-dikirim-2>
#quote(block: true)[
Terima kasih. Penilaian Anda sudah tercatat dan dilihat koordinator PBL serta dosen pengampu. Jawaban dapat diubah sampai batas akhir lewat tautan \"Edit jawaban\".
]

== 4. Rekap Otomatis untuk Dosen
<rekap-otomatis-untuk-dosen>
Skrip membuat spreadsheet Rekap yang diperbarui otomatis tiap ada tanggapan baru. Isinya:

- #strong[Rekap Mahasiswa];: nilai diri, rerata rekan, #strong[Skor 360] dan #strong[Poin 360] (termasuk penilaian diri; Poin 360 dijumlahkan menjadi 100 per tim), peringkat dalam tim, jumlah rekan yang menyebutnya paling berkontribusi atau hampir tidak berkontribusi, dan penanda.
- #strong[Rincian Penilai];: siapa menilai siapa, lengkap dengan skor, poin, dan uraian pekerjaan.
- #strong[Rangkuman Pekerjaan];: seluruh uraian pekerjaan tentang tiap mahasiswa dari dirinya dan dari rekan, beserta bukti.
- #strong[Rekap Tim] dan #strong[Penanda];.

Penanda yang dipakai: Menonjol, Rendah, Menilai diri tinggi atau rendah, Dituduh pasif, Uraian pendek, Tanpa bukti, Belum mengisi, Poin dinormalkan, Skor seragam, Poin sama rata, Nama ganda, dan Penilai kurang. Penanda adalah petunjuk untuk diperiksa, bukan kesimpulan.

== 5. Panduan Koordinator
<panduan-koordinator-2>
- Jalankan `buatFormPenilaian360`, lalu `pasangTrigger` satu kali (langkah lengkap ada di `penilaian-360/README-Penilaian-360.md`). Daftar tim tidak diperlukan.
- Setelah tanggapan masuk, periksa kolom Penanda di Rekap Tim (Daftar anggota tidak konsisten, Nama tim mirip, Nama ambigu) dan perbaiki ejaan lewat `ALIAS_TIM` dan `ALIAS_NAMA` bila perlu.
- Periksa Rekap Tim: ingatkan anggota yang belum mengisi satu hari sebelum batas akhir (nama anggota dikenali dari ketikan pengisi, jadi daftar \"Belum mengisi\" hanya mencakup nama yang sudah diketik oleh rekan).
- Bagikan Rekap per kelas kepada dosen pengampu dengan `salinPerKelas` (baca saja). Data mentah dan Rekap utama tidak dibagikan.
- Bandingkan Poin 360 dengan estimasi kontribusi di Bab 5.2 laporan. Jika selisih untuk satu anggota lebih dari 15 poin, hubungi tim untuk menjelaskan sebabnya.
- Penilaian rekan pada Demo Day (Minggu 16) berjalan terpisah menurut RPP.

== 6. Daftar Periksa Sebelum Membagikan Form
<daftar-periksa-sebelum-membagikan-form-1>
- ☐ Batas akhir 27 November 2026 dan daftar kelas pada skrip sudah benar.
- ☐ Kirim satu tanggapan uji, pastikan Rekap terisi dan terbaca, lalu hapus tanggapan uji.
- ☐ Pastikan hanya koordinator PBL yang memiliki akses edit dan akses ke data mentah.
- ☐ Cantumkan tautan Form 3 pada SOP (Bagian 9.3) dan pengumuman.
