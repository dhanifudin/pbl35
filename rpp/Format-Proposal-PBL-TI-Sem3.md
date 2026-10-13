# Format Proposal Produk: PBL Terintegrasi TI Semester 3

Dokumen ini adalah panduan penyusunan proposal produk, membantu tim merumuskan rencana produk sebelum memasuki tahap pengembangan, sekitar Minggu 4. Bagian 4 di bawah memuat struktur perencanaan proyek: tujuan, ruang lingkup, pemangku kepentingan, asumsi, batasan, dan kriteria keberhasilan.

Setiap bagian di bawah disertai paragraf penjelasan (dicetak miring) tentang apa yang bisa ditulis tim pada bagian tersebut, disertai contoh singkat sebagai gambaran konkret. Contoh pada dokumen ini mengacu pada satu produk ilustrasi yang sama, yaitu "SIMPAN" (sistem peminjaman ruang dan alat kampus), agar tim mendapat gambaran yang konsisten; tim tetap bebas mengusulkan produk yang berbeda sesuai masalah nyata yang mereka temukan, dan bebas menyesuaikan struktur bagian ini bila ada kebutuhan lain yang lebih relevan. Hapus paragraf penjelasan dan contoh setelah tim memahami maksudnya, lalu isi dengan konten proposal yang sebenarnya pada ruang yang disediakan.

---

## 1. Sampul dan Identitas Tim

### 1.1 Judul Produk

*Tuliskan judul produk yang singkat dan mencerminkan fungsi utamanya. Judul ini akan dipakai berulang kali di seluruh dokumen berikutnya (logbook, laporan pengujian, laporan akhir, slide presentasi, bahkan nama repositori kode), sehingga sebaiknya ditetapkan sejak awal dan tidak berubah tanpa alasan kuat. Judul boleh disesuaikan pada tahap pengembangan bila diperlukan, tetapi sebaiknya tetap konsisten dengan deskripsi masalah yang diajukan di Bagian 3. Judul yang baik langsung menjelaskan fungsi produk hanya dari namanya; hindari judul yang terlalu umum (mis. "Aplikasi Kampus") karena tidak membedakan produk timmu dari tim lain.*

**Contoh:** "SIMPAN: Sistem Informasi Manajemen Peminjaman Alat dan Ruang" (aplikasi untuk mengelola peminjaman ruang kelas dan alat laboratorium oleh mahasiswa dan staf kampus).

_(Isi bagian ini di sini.)_

### 1.2 Identitas Tim

*Cantumkan nama lengkap dan NIM seluruh anggota tim beserta peran yang dipegang (Ketua Tim, Sekretaris/Dokumentator, Pengembang Utama, Analis/Desainer, QA/Penguji, sesuai model tim pada RPP). Satu orang boleh merangkap lebih dari satu peran jika jumlah anggota tim kurang dari lima, namun sebaiknya beban peran dibagi serata mungkin. Peran yang dicantumkan di sini menjadi acuan pembagian tanggung jawab pada Bagian 7.3 dan salah satu rujukan penilaian kontribusi individu, sehingga sebaiknya mencerminkan pembagian kerja yang sebenarnya, bukan sekadar formalitas.*

**Contoh:**

| Nama | NIM | Peran |
|---|---|---|
| Ahmad Fauzi | 2141720001 | Ketua Tim & Pengembang Utama |
| Budi Santoso | 2141720002 | Analis/Desainer |
| Citra Ayu | 2141720003 | Sekretaris/Dokumentator |
| Dewi Lestari | 2141720004 | QA/Penguji |

_(Isi bagian ini di sini.)_

### 1.3 Mata Kuliah Terintegrasi dan Dosen Pengampu

*Sebutkan keempat mata kuliah yang terintegrasi pada proyek ini (Manajemen Proyek, Desain dan Pemrograman Web, Basis Data Lanjut, Sistem Informasi Manajemen) beserta nama dosen pengampu masing-masing, kelas, dan semester/tahun akademik berjalan. Informasi ini menentukan siapa saja yang akan memeriksa dan menilai proposal, serta menjadi acuan saat proposal perlu direvisi karena tim perlu tahu ke dosen mana revisi tertentu bisa dikonsultasikan.*

**Contoh:**

| Mata Kuliah | Dosen Pengampu | Kelas |
|---|---|---|
| Manajemen Proyek | _(nama dosen)_ | TI-3A |
| Desain dan Pemrograman Web | _(nama dosen)_ | TI-3A |
| Basis Data Lanjut | _(nama dosen)_ | TI-3A |
| Sistem Informasi Manajemen | _(nama dosen)_ | TI-3A |

_(Isi bagian ini di sini.)_

---

## 2. Ringkasan Eksekutif

*Tulis satu paragraf (maksimal 200 kata) yang merangkum keseluruhan proposal: masalah yang diangkat, solusi yang diusulkan, dan hasil akhir yang diharapkan. Ringkasan ini ditulis terakhir, setelah seluruh bagian lain selesai, agar benar-benar mencerminkan isi proposal secara utuh, bukan rencana awal yang mungkin sudah berubah selama penyusunan. Pembaca (dosen pengampu) idealnya bisa memahami keseluruhan proyek hanya dari membaca bagian ini saja, tanpa perlu membuka bagian lain.*

**Contoh:** "Peminjaman ruang dan alat laboratorium di kampus saat ini dicatat di buku terpisah oleh masing-masing pengelola ruang, sehingga tidak ada satu sumber data yang menunjukkan jadwal mana yang sudah terisi, dan dua kegiatan bisa dijadwalkan pada ruang dan waktu yang sama tanpa disadari. SIMPAN adalah aplikasi web yang menyatukan data peminjaman ke satu sistem dan secara otomatis menolak pengajuan yang bentrok dengan jadwal yang sudah disetujui, serta menghasilkan laporan pemakaian ruang dan alat bulanan. Produk ini dikembangkan dengan kaidah manajemen proyek selama 16 minggu, dengan target seluruh alur peminjaman berjalan penuh dan teruji pada akhir semester."

_(Isi bagian ini di sini.)_

---

## 3. Latar Belakang dan Rumusan Masalah

### 3.1 Latar Belakang

*Jelaskan konteks masalah: organisasi, komunitas, atau situasi nyata yang menjadi latar proyek ini. Jika ada calon mitra (instansi, UMKM, organisasi kampus), sebutkan di sini beserta bagaimana tim terhubung dengannya. Latar belakang sebaiknya menunjukkan bahwa masalah ini nyata, bukan rekaan semata; sertakan fakta atau kejadian konkret (mis. keluhan yang pernah didengar, kejadian yang pernah dialami tim) daripada asumsi umum yang tidak bisa diverifikasi.*

**Contoh:** "Jurusan Teknologi Informasi memiliki lebih dari 15 ruang kelas dan 8 laboratorium yang dipinjam mahasiswa untuk kegiatan organisasi maupun praktikum tambahan. Proses peminjaman saat ini dilakukan dengan mengisi buku catatan di ruang tata usaha, yang beberapa kali menyebabkan dua kegiatan dijadwalkan pada ruang dan waktu yang sama karena tidak ada rekapitulasi terpusat."

_(Isi bagian ini di sini.)_

### 3.2 Rumusan Masalah

*Rumuskan masalah secara spesifik dalam bentuk pernyataan atau pertanyaan. Rumusan masalah yang baik bersifat spesifik dan dapat dijawab lewat sebuah produk, bukan pernyataan umum seperti "sistem yang ada belum optimal". Rumusan masalah inilah yang akan dijawab oleh produk yang diusulkan di Bagian 5, dan menjadi tolok ukur untuk menilai apakah produk akhir benar-benar menjawab persoalan yang diangkat.*

**Contoh:** "Bagaimana mencegah tabrakan jadwal peminjaman ruang dan alat kampus yang terjadi karena setiap pengelola ruang mencatat jadwalnya sendiri-sendiri tanpa satu sumber data yang sama?"

_(Isi bagian ini di sini.)_

### 3.3 Hasil Observasi/Wawancara Calon Pengguna

*Ringkas hasil observasi atau wawancara terhadap minimal 3 calon pengguna atau mitra, sesuai persyaratan yang diharapkan dari Sistem Informasi Manajemen pada RPP. Cantumkan siapa yang diwawancarai, pertanyaan kunci yang diajukan, dan temuan utama yang memengaruhi rancangan produk. Temuan di sini idealnya terlihat jejaknya pada Bagian 5.3 (Daftar Fitur Utama); jika sebuah fitur diusulkan tanpa ada temuan yang mendasarinya, dosen pengampu SIM dapat mempertanyakan dasar kebutuhannya.*

**Contoh:**

| Responden | Pertanyaan Kunci | Temuan Utama |
|---|---|---|
| Staf Tata Usaha | Bagaimana proses pencatatan peminjaman saat ini? | Dicatat di buku terpisah tiap pengelola ruang; tidak ada satu sumber data bersama sehingga sulit direkap untuk laporan bulanan |
| Ketua Himpunan Mahasiswa | Kendala apa yang sering dialami saat meminjam ruang? | Tidak tahu jadwal ruang yang sudah dipinjam pihak lain |
| Laboran | Apa yang paling sering hilang dari peminjaman alat? | Kabel HDMI dan proyektor portabel, karena tidak ada bukti serah terima |

_(Isi bagian ini di sini.)_

---

## 4. Tujuan dan Ruang Lingkup Proyek

> Bagian ini menjadi acuan bersama tim dan dosen pengampu Manajemen Proyek sepanjang proyek berjalan, termasuk saat mendiskusikan apa yang sebaiknya (tidak) dikerjakan tim.

### 4.1 Tujuan Proyek

*Nyatakan tujuan proyek secara terukur: apa yang ingin dicapai tim pada akhir Minggu 16. Tujuan sebaiknya selaras dengan rumusan masalah di Bagian 3.2 dan kriteria keberhasilan di Bagian 4.5, serta dirumuskan dengan kata kerja yang dapat diverifikasi (mis. "menghasilkan", "mengurangi", "mengintegrasikan") alih-alih kata yang sulit diukur seperti "meningkatkan kualitas".*

**Contoh:** "Menghasilkan aplikasi web peminjaman ruang dan alat kampus yang berjalan penuh, mengurangi tabrakan jadwal peminjaman menjadi nol melalui validasi otomatis, dan menyediakan laporan pemakaian bulanan bagi staf tata usaha."

_(Isi bagian ini di sini.)_

### 4.2 Ruang Lingkup (Yang Dikerjakan dan Yang Tidak Dikerjakan)

*Daftar secara eksplisit fitur/fungsi apa saja yang **dikerjakan** dalam proyek ini, dan apa saja yang secara sadar **tidak dikerjakan** meskipun relevan, misalnya karena keterbatasan waktu 16 minggu atau kapasitas tim. Batasan ruang lingkup ini mengacu pada kriteria ruang lingkup yang ideal pada RPP (sekitar 3-5 entitas berelasi, 2-3 peran, 1-2 laporan). Menuliskan yang tidak dikerjakan secara eksplisit sama pentingnya dengan yang dikerjakan, karena mencegah ekspektasi berlebihan dari dosen pengampu atau mitra terhadap fitur yang memang tidak direncanakan.*

**Contoh:** Dikerjakan: pengajuan peminjaman daring, verifikasi oleh staf, jadwal ruang/alat, laporan pemakaian bulanan. Tidak dikerjakan: notifikasi WhatsApp otomatis, integrasi dengan sistem akademik kampus, pembayaran denda daring (karena kompleksitasnya melebihi kapasitas tim dalam 16 minggu).

_(Isi bagian ini di sini.)_

### 4.3 Pemangku Kepentingan

*Identifikasi siapa saja yang berkepentingan terhadap proyek ini: pengguna akhir, mitra (bila ada), dosen pengampu, dan anggota tim sendiri. Jelaskan singkat kepentingan/peran masing-masing pihak. Daftar ini membantu tim mengingat siapa saja yang perlu dimintai persetujuan atau masukan sebelum mengubah sesuatu yang signifikan pada produk.*

**Contoh:**

| Pemangku Kepentingan | Kepentingan |
|---|---|
| Mahasiswa (peminjam) | Kemudahan mengajukan peminjaman dan mengecek status |
| Staf Tata Usaha | Kemudahan verifikasi dan pembuatan laporan bulanan |
| Dosen Pengampu | Memastikan proyek dikelola sesuai kaidah manajemen proyek |
| Tim Pengembang | Menyelesaikan proyek tepat waktu sesuai kriteria keberhasilan |

_(Isi bagian ini di sini.)_

### 4.4 Asumsi dan Batasan

*Sebutkan asumsi yang diambil tim (mis. ketersediaan data uji, akses ke mitra, teknologi yang dipakai) dan batasan yang dihadapi (mis. waktu 16 minggu, jumlah anggota tim, keterbatasan akses ke sistem mitra yang sudah ada). Asumsi berbeda dari fakta: asumsi adalah hal yang dianggap benar oleh tim tetapi belum tentu terverifikasi, sehingga jika asumsi ini keliru di kemudian hari, tim punya alasan sah untuk merevisi rencana.*

**Contoh:** Asumsi: staf tata usaha bersedia menggunakan aplikasi baru sebagai satu-satunya sumber data peminjaman, menggantikan catatan terpisah yang selama ini dipakai. Batasan: proyek hanya dikerjakan selama 16 minggu oleh 4 anggota tim; tidak ada akses ke server kampus sehingga aplikasi di-deploy pada layanan hosting gratis untuk keperluan demo.

_(Isi bagian ini di sini.)_

### 4.5 Kriteria Keberhasilan

*Nyatakan kriteria konkret yang menandakan proyek ini berhasil, mengacu pada kriteria produk berjalan yang dijelaskan pada RPP (aplikasi web berjalan penuh, CRUD pada minimal 3 entitas berelasi, minimal 2 peran pengguna, ada laporan/dashboard sesuai konsep SIM, dikelola dengan kaidah manajemen proyek, data uji terisi dan alur utama stabil). Tim dapat menambahkan kriteria spesifik produk sendiri di luar kriteria minimum tersebut, dan sebaiknya tetap mempertahankan kriteria minimum dari RPP.*

**Contoh:** Aplikasi web SIMPAN berjalan penuh dengan entitas Peminjaman, Alat, dan Ruang saling berelasi; peran Admin (verifikasi, laporan) dan Peminjam (ajukan, lihat status) berfungsi penuh; tersedia laporan pemakaian bulanan; seluruh proses dikelola dengan rencana proyek dan logbook mingguan.

_(Isi bagian ini di sini.)_

---

## 5. Deskripsi Produk yang Diusulkan

### 5.1 Gambaran Umum Solusi

*Jelaskan secara naratif bagaimana produk yang diusulkan menjawab rumusan masalah. Uraikan alur penggunaan utama (main flow) dari sudut pandang pengguna, dari awal hingga tujuan pengguna tercapai. Bagian ini adalah "cerita" produk secara utuh, sehingga pembaca yang belum tahu apa-apa tentang produk timmu bisa membayangkan cara kerjanya hanya dari paragraf ini.*

**Contoh:** "Mahasiswa membuka SIMPAN, memilih ruang atau alat yang ingin dipinjam beserta tanggal dan waktu, lalu mengajukan permintaan. Staf tata usaha menerima notifikasi di dashboard, memeriksa ketersediaan (sistem otomatis menolak jadwal yang bentrok), dan menyetujui atau menolak permintaan. Setelah disetujui, mahasiswa dapat melihat status peminjamannya, dan staf dapat mencetak laporan pemakaian bulanan untuk keperluan evaluasi jurusan."

_(Isi bagian ini di sini.)_

### 5.2 Pengguna dan Peran Pengguna

*Identifikasi minimal 2 peran pengguna (sesuai kriteria produk pada RPP) beserta hak akses dan kebutuhan masing-masing peran terhadap sistem.*

**Contoh:** Admin/Staf Tata Usaha (verifikasi peminjaman, kelola data ruang/alat, lihat laporan) dan Peminjam/Mahasiswa (ajukan peminjaman, lihat status pengajuan sendiri).

_(Isi bagian ini di sini.)_

### 5.3 Daftar Fitur Utama

*Susun daftar fitur utama produk dalam bentuk poin, dikelompokkan per peran pengguna bila relevan. Setiap fitur idealnya dapat ditelusuri ke satu atau lebih entitas data pada Bagian 6.1 dan ke temuan wawancara pada Bagian 3.3; fitur yang tidak bisa ditelusuri ke keduanya patut dipertanyakan apakah benar-benar dibutuhkan.*

**Contoh:** Peminjam: (1) ajukan peminjaman ruang/alat, (2) lihat riwayat dan status peminjaman. Admin: (3) verifikasi/tolak pengajuan, (4) kelola data master ruang dan alat, (5) lihat dan unduh laporan pemakaian bulanan.

_(Isi bagian ini di sini.)_

---

## 6. Rancangan Teknis Awal

> Ilustrasi pada kedua bagian di bawah adalah salah satu cara menggambarkan rancangan. Struktur, jumlah kotak/kolom, dan tingkat detail dapat disesuaikan sepenuhnya dengan kebutuhan produk tim; tidak harus sama persis dengan contoh.

### 6.1 Rancangan Basis Data Awal

*Sajikan entitas-entitas data utama (minimal 3 entitas berelasi, sesuai persyaratan produk Basis Data Lanjut pada RPP) beserta relasi kasarnya (1-N dan/atau N-N). Diagram ERD awal berupa sketsa sudah cukup pada tahap ini; detail normalisasi disempurnakan pada tahap pengembangan. Entitas yang dicantumkan di sini sebaiknya konsisten dengan fitur yang disebutkan pada Bagian 5.3.*

**Contoh:** Entitas `Pengguna` (1-N ke `Peminjaman`), `Peminjaman` (N-1 ke `Ruang` atau `Alat`), `Ruang`, dan `Alat`. Satu `Peminjaman` merujuk ke satu `Pengguna` dan satu `Ruang`/`Alat`; satu `Ruang`/`Alat` dapat memiliki banyak riwayat `Peminjaman`.

<svg viewBox="0 0 640 220" xmlns="http://www.w3.org/2000/svg" style="width:100%;max-width:600px;height:auto;font-family:'Segoe UI','DejaVu Sans',sans-serif;">
  <rect x="20" y="80" width="150" height="50" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="95" y="110" text-anchor="middle" font-size="14" font-weight="600" fill="#1a1a2e">Pengguna</text>
  <rect x="260" y="80" width="160" height="50" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="340" y="110" text-anchor="middle" font-size="14" font-weight="600" fill="#1a1a2e">Peminjaman</text>
  <rect x="490" y="20" width="130" height="50" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="555" y="50" text-anchor="middle" font-size="14" font-weight="600" fill="#1a1a2e">Ruang</text>
  <rect x="490" y="150" width="130" height="50" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="555" y="180" text-anchor="middle" font-size="14" font-weight="600" fill="#1a1a2e">Alat</text>
  <line x1="170" y1="105" x2="260" y2="105" stroke="#003b7a" stroke-width="1.5"/>
  <text x="215" y="98" text-anchor="middle" font-size="11" fill="#b3760c">1 : N</text>
  <line x1="420" y1="95" x2="490" y2="55" stroke="#003b7a" stroke-width="1.5"/>
  <text x="470" y="68" text-anchor="middle" font-size="11" fill="#b3760c">N : 1</text>
  <line x1="420" y1="120" x2="490" y2="165" stroke="#003b7a" stroke-width="1.5"/>
  <text x="470" y="150" text-anchor="middle" font-size="11" fill="#b3760c">N : 1</text>
</svg>

_(Isi bagian ini di sini; sertakan sketsa ERD.)_

### 6.2 Rancangan Antarmuka Awal

*Lampirkan wireframe atau sketsa alur layar untuk halaman-halaman utama (minimal 3 halaman/view selain login, sesuai persyaratan produk Desain dan Pemrograman Web pada RPP). Wireframe tidak perlu berupa desain visual akhir; sketsa tangan atau mockup sederhana sudah memadai pada tahap proposal.*

**Contoh:** Halaman (1) Formulir Pengajuan Peminjaman, (2) Daftar Status Peminjaman Saya, (3) Dashboard Verifikasi (Admin), (4) Laporan Pemakaian Bulanan (Admin).

<svg viewBox="0 0 400 320" xmlns="http://www.w3.org/2000/svg" style="width:100%;max-width:380px;height:auto;font-family:'Segoe UI','DejaVu Sans',sans-serif;">
  <rect x="10" y="10" width="380" height="300" rx="10" fill="#ffffff" stroke="#003b7a" stroke-width="2"/>
  <rect x="10" y="10" width="380" height="42" rx="10" fill="#003b7a"/>
  <rect x="10" y="34" width="380" height="18" fill="#003b7a"/>
  <text x="26" y="37" font-size="15" font-weight="700" fill="#ffffff">SIMPAN</text>
  <text x="374" y="37" text-anchor="end" font-size="12" fill="#ffffff">Profil &#9662;</text>
  <text x="26" y="82" font-size="14" font-weight="600" fill="#1a1a2e">Ajukan Peminjaman</text>
  <text x="26" y="108" font-size="11" fill="#4a5568">Pilih Ruang/Alat</text>
  <rect x="26" y="114" width="348" height="28" rx="4" fill="#ffffff" stroke="#c5d4e8" stroke-width="1.5"/>
  <text x="40" y="133" font-size="12" fill="#1a1a2e">Ruang B301</text>
  <text x="358" y="133" font-size="12" fill="#4a5568">&#9662;</text>
  <text x="26" y="164" font-size="11" fill="#4a5568">Tanggal</text>
  <rect x="26" y="170" width="160" height="28" rx="4" fill="#ffffff" stroke="#c5d4e8" stroke-width="1.5"/>
  <text x="40" y="189" font-size="12" fill="#1a1a2e">12 / 09 / 2026</text>
  <text x="26" y="222" font-size="11" fill="#4a5568">Jam Mulai - Selesai</text>
  <rect x="26" y="228" width="80" height="28" rx="4" fill="#ffffff" stroke="#c5d4e8" stroke-width="1.5"/>
  <text x="36" y="247" font-size="12" fill="#1a1a2e">08:00</text>
  <text x="112" y="247" font-size="12" fill="#4a5568">-</text>
  <rect x="124" y="228" width="80" height="28" rx="4" fill="#ffffff" stroke="#c5d4e8" stroke-width="1.5"/>
  <text x="134" y="247" font-size="12" fill="#1a1a2e">10:00</text>
  <rect x="110" y="270" width="180" height="34" rx="17" fill="#f5a623"/>
  <text x="200" y="292" text-anchor="middle" font-size="13" font-weight="600" fill="#ffffff">Ajukan Peminjaman</text>
</svg>

_(Isi bagian ini di sini; sertakan wireframe/sketsa.)_

---

## 7. Rencana Kerja dan Organisasi Tim

### 7.1 Rincian Pekerjaan Tim

*Pecah proyek menjadi bagian-bagian pekerjaan yang lebih kecil, minimal 3 tingkat kedalaman, sesuai persyaratan produk Manajemen Proyek pada RPP: mulai dari bagian besar pekerjaan, dipecah lagi menjadi sub-bagian, hingga tugas rinci yang cukup kecil untuk dikerjakan satu orang. Rincian yang baik membuat setiap anggota tim tahu persis apa yang menjadi tanggung jawabnya tanpa perlu bertanya lagi.*

**Contoh:**

| Bagian Besar | Sub-bagian | Tugas Rinci | Penanggung Jawab |
|---|---|---|---|
| 1. Modul Peminjaman | 1.1 Desain Basis Data | 1.1.1 Rancang ERD entitas Peminjaman, Alat, Ruang | Ahmad |
| | | 1.1.2 Implementasi skema dan migrasi | Ahmad |
| | 1.2 Antarmuka Peminjaman | 1.2.1 Wireframe halaman ajukan peminjaman | Budi |
| | | 1.2.2 Implementasi form pengajuan | Budi |
| 2. Modul Laporan | 2.1 Rancangan Laporan | 2.1.1 Desain query rekap pemakaian bulanan | Citra |

_(Isi bagian ini di sini.)_

### 7.2 Jadwal dan Milestone

*Sajikan jadwal kerja (Gantt chart atau tabel) untuk 16 minggu, dengan milestone yang selaras dengan 4 checkpoint PBL yang dijelaskan pada RPP (Proposal Minggu 4, Milestone 1 Minggu 8, Milestone 2 Minggu 12, Final Minggu 16). Jadwal ini akan dibandingkan dengan realisasi aktual pada laporan kemajuan mingguan, jadi buat perkiraan yang realistis, bukan yang terlalu optimis.*

**Contoh:**

| Minggu | Aktivitas | Milestone |
|---|---|---|
| 1-3 | Identifikasi masalah, wawancara pengguna | - |
| 4 | Finalisasi proposal | CP-1 Proposal |
| 5-8 | Implementasi modul peminjaman inti | CP-2 Milestone 1 |
| 9-12 | Implementasi modul laporan, integrasi | CP-3 Milestone 2 |
| 13-16 | Pengujian, perbaikan, demo akhir | CP-4 Final |

_(Isi bagian ini di sini.)_

### 7.3 Pembagian Peran dan Tanggung Jawab

*Petakan setiap tugas rinci pada Bagian 7.1 ke anggota tim yang bertanggung jawab, mengacu pada peran masing-masing anggota di Bagian 1.2. Pembagian ini menjadi salah satu rujukan dosen pengampu saat menilai kontribusi individu, sehingga sebaiknya cukup rinci untuk membedakan siapa mengerjakan apa.*

**Contoh:** Ahmad (Ketua Tim & Pengembang Utama): back-end dan basis data. Budi (Analis/Desainer): wireframe dan front-end. Citra (Sekretaris/Dokumentator): logbook, laporan, query laporan. Dewi (QA/Penguji): rencana uji dan eksekusi pengujian.

_(Isi bagian ini di sini.)_

---

## 8. Rencana Mitra Industri (Opsional)

*Bila proyek melibatkan mitra nyata (UMKM, organisasi, instansi), jelaskan siapa mitranya, bagaimana keterlibatannya direncanakan (mis. validasi kebutuhan, uji coba produk, penyerahan akhir), dan kontak penghubung. Bila tidak ada mitra, tuliskan "Tidak ada mitra pada tahap proposal"; ketiadaan mitra tidak mengurangi nilai proposal, karena mitra bersifat opsional.*

**Contoh:** Mitra: Tata Usaha Jurusan Teknologi Informasi. Keterlibatan: memvalidasi kebutuhan pada Fase 1, menguji coba aplikasi pada Milestone 2, dan menerima serah terima aplikasi pada demo akhir. Kontak: Bapak/Ibu _(nama)_, staf Tata Usaha.

_(Isi bagian ini di sini.)_

---

## 9. Lampiran

*Sertakan dokumen pendukung yang relevan: transkrip/catatan hasil wawancara, foto observasi, referensi yang digunakan, atau dokumen tambahan lain yang memperkuat proposal. Lampiran memperkuat kredibilitas klaim pada bagian-bagian sebelumnya, terutama Bagian 3.3, dengan menunjukkan bukti bahwa observasi/wawancara benar-benar dilakukan.*

**Contoh:** Transkrip wawancara dengan staf Tata Usaha (2 halaman), foto kondisi buku catatan peminjaman yang terpisah-pisah antar pengelola ruang, tangkapan layar contoh sistem sejenis sebagai referensi desain.

_(Lampirkan dokumen pendukung di sini.)_
