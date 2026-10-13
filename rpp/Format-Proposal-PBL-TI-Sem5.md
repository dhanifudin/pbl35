# Format Proposal Produk: PBL Terintegrasi TI Semester 5

Dokumen ini adalah panduan penyusunan proposal produk, membantu tim merumuskan rencana produk sebelum memasuki tahap pengembangan, sekitar Minggu 4. Bagian 4 di bawah memuat struktur perencanaan proyek: tujuan, ruang lingkup, pemangku kepentingan, asumsi, batasan, dan kriteria keberhasilan.

Setiap bagian di bawah disertai paragraf penjelasan (dicetak miring) tentang apa yang bisa ditulis tim pada bagian tersebut, disertai contoh singkat sebagai gambaran konkret. Contoh pada dokumen ini mengacu pada satu produk ilustrasi yang sama, yaitu "TaniLens" (aplikasi deteksi hama tanaman dari foto), agar tim mendapat gambaran yang konsisten; tim tetap bebas mengusulkan produk yang berbeda sesuai masalah nyata yang mereka temukan, dan bebas menyesuaikan struktur bagian ini bila ada kebutuhan lain yang lebih relevan. Hapus paragraf penjelasan dan contoh setelah tim memahami maksudnya, lalu isi dengan konten proposal yang sebenarnya pada ruang yang disediakan.

---

## 1. Sampul dan Identitas Tim

### 1.1 Judul Produk

*Tuliskan judul produk yang singkat dan mencerminkan fitur ML utamanya. Judul ini akan dipakai berulang kali di seluruh dokumen berikutnya (logbook, laporan QA, laporan evaluasi model, laporan akhir, slide presentasi, repositori kode), sehingga sebaiknya ditetapkan sejak awal. Judul boleh disesuaikan pada tahap pengembangan, tetapi sebaiknya tetap konsisten dengan deskripsi masalah yang diajukan di Bagian 3. Judul yang baik langsung menunjukkan domain masalah dan bahwa ada fitur cerdas di dalamnya; hindari judul generik yang tidak membedakan produk timmu dari tim lain.*

**Contoh:** "TaniLens: Deteksi Hama Tanaman dari Foto" (aplikasi mobile yang membantu petani mengidentifikasi hama pada tanaman hanya dari foto daun yang difoto dengan kamera ponsel).

_(Isi bagian ini di sini.)_

### 1.2 Identitas Tim

*Cantumkan nama lengkap dan NIM seluruh anggota tim beserta peran yang dipegang (Ketua Tim, Sekretaris/Dokumentator, Pengembang Utama, ML Engineer/Arsitek Sistem, QA/Penguji, sesuai model tim pada RPP). Satu orang boleh merangkap lebih dari satu peran jika jumlah anggota tim kurang dari lima, namun sebaiknya beban peran dibagi serata mungkin. Peran yang dicantumkan di sini menjadi acuan pembagian tanggung jawab pada Bagian 8.2 dan salah satu rujukan penilaian kontribusi individu.*

**Contoh:**

| Nama | NIM | Peran |
|---|---|---|
| Eka Prasetyo | 2141720011 | Ketua Tim & Pengembang Utama (Flutter) |
| Fajar Ramadhan | 2141720012 | ML Engineer/Arsitek Sistem |
| Gita Puspita | 2141720013 | Sekretaris/Dokumentator |
| Hana Kartika | 2141720014 | QA/Penguji |

_(Isi bagian ini di sini.)_

### 1.3 Mata Kuliah Terintegrasi dan Dosen Pengampu

*Sebutkan ketiga mata kuliah yang terintegrasi pada proyek ini (Pemrograman Mobile, Pembelajaran Mesin, Penjaminan Mutu Perangkat Lunak) beserta nama dosen pengampu masing-masing, kelas, dan semester/tahun akademik berjalan. Informasi ini menentukan siapa saja yang akan memeriksa dan menilai proposal, serta menjadi acuan saat proposal perlu direvisi.*

**Contoh:**

| Mata Kuliah | Dosen Pengampu | Kelas |
|---|---|---|
| Pemrograman Mobile | _(nama dosen)_ | TI-5A |
| Pembelajaran Mesin | _(nama dosen)_ | TI-5A |
| Penjaminan Mutu Perangkat Lunak | _(nama dosen)_ | TI-5A |

_(Isi bagian ini di sini.)_

---

## 2. Ringkasan Eksekutif

*Tulis satu paragraf (maksimal 200 kata) yang merangkum keseluruhan proposal: masalah yang diangkat, fitur ML dan aplikasi mobile yang diusulkan sebagai solusi, dan hasil akhir yang diharapkan. Ringkasan ini ditulis terakhir, setelah seluruh bagian lain selesai, agar benar-benar mencerminkan isi proposal secara utuh. Pembaca (dosen pengampu) idealnya bisa memahami keseluruhan proyek hanya dari membaca bagian ini saja.*

**Contoh:** "Petani skala kecil sering kesulitan mengenali jenis hama pada tanaman sejak dini karena keterbatasan akses ke ahli pertanian. TaniLens adalah aplikasi mobile berbasis Flutter yang memungkinkan petani memotret daun tanaman dan langsung mendapatkan hasil klasifikasi jenis hama beserta rekomendasi penanganan, menggunakan model machine learning yang berjalan pada perangkat. Produk ini dikembangkan selama 16 minggu dengan target model tercapai akurasi minimal 80 persen dan fitur pengujian mutu terdokumentasi lengkap."

_(Isi bagian ini di sini.)_

---

## 3. Latar Belakang dan Rumusan Masalah

### 3.1 Latar Belakang

*Jelaskan konteks masalah: situasi nyata yang menjadi latar proyek ini, dan mengapa solusi berbasis mobile dan machine learning relevan untuk masalah tersebut. Jika ada calon mitra, sebutkan di sini. Latar belakang sebaiknya menunjukkan masalah nyata dengan fakta atau kejadian konkret, bukan asumsi umum yang tidak bisa diverifikasi.*

**Contoh:** "Kelompok tani di sekitar kampus melaporkan bahwa serangan hama pada tanaman cabai sering baru diketahui setelah kerusakan meluas, karena mereka harus menunggu kunjungan penyuluh pertanian yang jadwalnya tidak menentu. Padahal deteksi dini hama dari ciri-ciri pada daun dapat dilakukan lebih cepat jika ada alat bantu identifikasi yang bisa dipakai langsung di lahan."

_(Isi bagian ini di sini.)_

### 3.2 Rumusan Masalah

*Rumuskan masalah secara spesifik dalam bentuk pernyataan atau pertanyaan. Rumusan masalah yang baik bersifat spesifik dan dapat dijawab lewat sebuah produk, bukan pernyataan umum. Rumusan masalah inilah yang akan dijawab oleh produk yang diusulkan di Bagian 5, dan menjadi tolok ukur untuk menilai apakah produk akhir benar-benar menjawab persoalan yang diangkat.*

**Contoh:** "Bagaimana membantu petani mendeteksi hama tanaman secara cepat dari foto tanpa perlu menunggu kunjungan ahli pertanian?"

_(Isi bagian ini di sini.)_

### 3.3 Studi Kelayakan Teknis dan Data

*Jelaskan hasil studi kelayakan awal dari kegiatan Minggu 1-3 pada RPP: sumber dataset yang tersedia atau akan dikumpulkan, perkiraan jumlah data, dan penilaian apakah model ML yang dibutuhkan realistis dibangun dan dijalankan pada perangkat mobile dalam 16 minggu. Studi kelayakan yang jujur di tahap ini mencegah tim baru menyadari dataset tidak mencukupi setelah beberapa minggu berjalan, yang jauh lebih sulit diperbaiki.*

**Contoh:** "Dataset kandidat: kumpulan citra daun cabai berhama dari Kaggle (sekitar 2.000 gambar, 4 kelas hama) ditambah 200 foto lapangan yang akan diambil tim sendiri. Model klasifikasi gambar dengan transfer learning (mis. MobileNet) dinilai realistis dilatih dan dikonversi ke TensorFlow Lite untuk berjalan di perangkat Android kelas menengah dalam waktu 16 minggu."

_(Isi bagian ini di sini.)_

---

## 4. Tujuan dan Ruang Lingkup Proyek

> Bagian ini menjadi acuan bersama tim dan dosen pengampu sepanjang proyek berjalan.

### 4.1 Tujuan Proyek

*Nyatakan tujuan proyek secara terukur: apa yang ingin dicapai tim pada akhir Minggu 16, selaras dengan rumusan masalah di Bagian 3.2 dan kriteria keberhasilan di Bagian 4.5. Rumuskan dengan kata kerja yang dapat diverifikasi (mis. "menghasilkan", "mencapai akurasi X persen") alih-alih kata yang sulit diukur.*

**Contoh:** "Menghasilkan aplikasi mobile yang dapat mengklasifikasikan minimal 3 jenis hama tanaman cabai dari foto daun dengan akurasi model minimal 80 persen, terintegrasi penuh ke dalam aplikasi dan teruji secara fungsional."

_(Isi bagian ini di sini.)_

### 4.2 Ruang Lingkup (Yang Dikerjakan dan Yang Tidak Dikerjakan)

*Daftar secara eksplisit fitur/fungsi apa saja yang **dikerjakan** dalam proyek ini, dan apa saja yang secara sadar **tidak dikerjakan** meskipun relevan. Ruang lingkup mengacu pada kriteria ruang lingkup yang ideal pada RPP: satu fitur ML yang matang dan benar-benar terintegrasi lebih baik daripada banyak fitur ML setengah jadi. Menuliskan yang tidak dikerjakan secara eksplisit mencegah ekspektasi berlebihan dari dosen pengampu atau mitra.*

**Contoh:** Dikerjakan: klasifikasi hama dari foto daun (1 fitur ML), riwayat hasil deteksi, rekomendasi penanganan sederhana berbasis hasil klasifikasi. Tidak dikerjakan: deteksi penyakit tanaman selain hama, prediksi hasil panen, dukungan multi-bahasa (karena kompleksitasnya melebihi kapasitas tim dalam 16 minggu).

_(Isi bagian ini di sini.)_

### 4.3 Pemangku Kepentingan

*Identifikasi siapa saja yang berkepentingan terhadap proyek ini: pengguna akhir, mitra (bila ada, mis. penyedia data), dosen pengampu, dan anggota tim sendiri.*

**Contoh:**

| Pemangku Kepentingan | Kepentingan |
|---|---|
| Petani (pengguna) | Deteksi hama cepat tanpa menunggu penyuluh |
| Kelompok Tani (mitra data) | Menyediakan sampel foto daun berhama untuk dataset |
| Dosen Pengampu | Memastikan model ML terintegrasi nyata dan teruji |
| Tim Pengembang | Menyelesaikan proyek tepat waktu sesuai kriteria keberhasilan |

_(Isi bagian ini di sini.)_

### 4.4 Asumsi dan Batasan

*Sebutkan asumsi yang diambil tim (mis. ketersediaan dataset, akses perangkat untuk pengujian) dan batasan yang dihadapi (mis. waktu 16 minggu, kapasitas komputasi untuk training model, target platform Android sebagai prioritas). Asumsi berbeda dari fakta: jika asumsi ini keliru di kemudian hari, tim punya alasan sah untuk merevisi rencana.*

**Contoh:** Asumsi: kelompok tani bersedia menyediakan sampel foto tambahan bila dataset publik kurang bervariasi. Batasan: pelatihan model dilakukan pada laptop tim tanpa GPU khusus sehingga arsitektur model dipilih yang ringan; target platform hanya Android, iOS tidak menjadi prioritas.

_(Isi bagian ini di sini.)_

### 4.5 Kriteria Keberhasilan

*Nyatakan kriteria konkret yang menandakan proyek ini berhasil, mengacu pada kriteria produk berjalan yang dijelaskan pada RPP (aplikasi mobile terpasang dan berjalan, minimal 1 fitur ML dengan output nyata di aplikasi, model dievaluasi dengan metrik jelas, rencana pengujian dieksekusi dengan hasil, alur utama stabil). Tim dapat menambahkan kriteria spesifik produk sendiri, dan sebaiknya tetap mempertahankan kriteria minimum dari RPP.*

**Contoh:** Aplikasi TaniLens terpasang dan berjalan di perangkat Android; fitur klasifikasi hama memberi hasil nyata di layar dengan akurasi model minimal 80 persen (dilaporkan lengkap dengan confusion matrix); rencana uji dieksekusi dengan minimal 15 test case dan hasilnya terdokumentasi.

_(Isi bagian ini di sini.)_

---

## 5. Deskripsi Produk yang Diusulkan

### 5.1 Gambaran Umum Solusi

*Jelaskan secara naratif bagaimana produk yang diusulkan menjawab rumusan masalah, termasuk bagaimana fitur ML terlibat dalam alur penggunaan utama (main flow) dari sudut pandang pengguna. Bagian ini adalah "cerita" produk secara utuh, sehingga pembaca bisa membayangkan cara kerjanya hanya dari paragraf ini.*

**Contoh:** "Petani membuka aplikasi TaniLens dan memotret daun tanaman yang dicurigai terserang hama. Aplikasi mengirim foto tersebut ke model klasifikasi yang berjalan di perangkat, lalu menampilkan hasil berupa nama hama yang terdeteksi beserta tingkat keyakinan model dan rekomendasi penanganan sederhana. Riwayat deteksi tersimpan sehingga petani dapat memantau perkembangan kondisi tanaman dari waktu ke waktu."

_(Isi bagian ini di sini.)_

### 5.2 Pengguna dan Skenario Penggunaan

*Jelaskan siapa pengguna utama aplikasi dan skenario penggunaan tipikal, dari membuka aplikasi hingga menerima output dari fitur ML.*

**Contoh:** "Petani membuka aplikasi, memotret daun tanaman -> aplikasi menampilkan hasil klasifikasi hama beserta tingkat keyakinan dan rekomendasi penanganan -> petani menyimpan hasil ke riwayat untuk dipantau."

_(Isi bagian ini di sini.)_

### 5.3 Daftar Fitur Utama (Termasuk Fitur ML)

*Susun daftar fitur utama produk, dengan menandai secara jelas fitur mana yang berbasis ML (klasifikasi/deteksi/rekomendasi/prediksi) dan fitur pendukung lain di sekitarnya (autentikasi, riwayat, pengaturan, dsb). Setiap fitur idealnya dapat ditelusuri ke rencana dataset pada Bagian 6.2.*

**Contoh:** (1) [ML] Klasifikasi jenis hama dari foto daun, (2) [ML] Rekomendasi penanganan berdasarkan hasil klasifikasi, (3) Riwayat hasil deteksi, (4) Login/registrasi akun petani.

_(Isi bagian ini di sini.)_

---

## 6. Rancangan Teknis Awal

> Ilustrasi pada kedua bagian di bawah adalah salah satu cara menggambarkan rancangan. Struktur, jumlah kotak/tahapan, dan tingkat detail dapat disesuaikan sepenuhnya dengan kebutuhan produk tim; tidak harus sama persis dengan contoh.

### 6.1 Rancangan Arsitektur Aplikasi Mobile (Flutter)

*Gambarkan arsitektur aplikasi secara kasar: struktur navigasi antar layar (minimal 4 layar, sesuai persyaratan produk Pemrograman Mobile pada RPP), pendekatan manajemen state yang akan dipakai (Provider/Riverpod/BLoC), dan rencana penyimpanan data (lokal via `shared_preferences`/`sqflite`/Hive dan/atau remote via API). Rancangan ini tidak perlu final, tetapi sebaiknya cukup jelas untuk menjadi acuan saat scaffolding aplikasi dimulai pada Minggu 5.*

**Contoh:** Layar: (1) Login, (2) Kamera/Ambil Foto, (3) Hasil Deteksi, (4) Riwayat Deteksi. Navigasi menggunakan `go_router`. State management menggunakan Riverpod untuk mengelola status hasil klasifikasi dan riwayat. Riwayat deteksi disimpan lokal menggunakan `sqflite`.

<svg viewBox="0 0 560 230" xmlns="http://www.w3.org/2000/svg" style="width:100%;max-width:560px;height:auto;font-family:'Segoe UI','DejaVu Sans',sans-serif;">
  <rect x="20" y="20" width="520" height="64" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="280" y="44" text-anchor="middle" font-size="14" font-weight="700" fill="#003b7a">UI (Flutter Widgets)</text>
  <text x="280" y="68" text-anchor="middle" font-size="11" fill="#1a1a2e">Login | Kamera/Ambil Foto | Hasil Deteksi | Riwayat</text>
  <rect x="20" y="94" width="520" height="46" rx="6" fill="#fff8e6" stroke="#f5a623" stroke-width="1.5"/>
  <text x="280" y="122" text-anchor="middle" font-size="13" font-weight="700" fill="#b3760c">State Management (Riverpod)</text>
  <rect x="20" y="150" width="255" height="56" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="147" y="182" text-anchor="middle" font-size="12" font-weight="600" fill="#1a1a2e">Model ML (tflite_flutter)</text>
  <rect x="285" y="150" width="255" height="56" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="412" y="182" text-anchor="middle" font-size="12" font-weight="600" fill="#1a1a2e">Data Lokal (sqflite)</text>
</svg>

_(Isi bagian ini di sini; sertakan sketsa alur layar/wireframe.)_

### 6.2 Rencana Dataset dan Metodologi Machine Learning

*Jelaskan sumber dataset (nama, tautan, atau rencana pengumpulan mandiri), jumlah data yang tersedia/ditargetkan, rencana pembagian data latih/uji, algoritma atau pendekatan yang akan dicoba (termasuk kemungkinan transfer learning), dan target metrik evaluasi awal (mis. target akurasi minimal). Rencana ini akan dibandingkan dengan hasil aktual pada laporan evaluasi model di Milestone 1 dan 2.*

**Contoh:** Dataset: kombinasi dataset publik Kaggle (sekitar 2.000 citra, 4 kelas hama) dan 200 foto lapangan tambahan, dibagi 80 persen latih dan 20 persen uji. Pendekatan: transfer learning dari MobileNetV2, dikonversi ke TensorFlow Lite. Target akurasi awal: minimal 75 persen pada data uji, ditingkatkan menuju 80 persen pada iterasi final.

<svg viewBox="0 0 800 320" xmlns="http://www.w3.org/2000/svg" style="width:100%;max-width:640px;height:auto;font-family:'Segoe UI','DejaVu Sans',sans-serif;">
  <defs>
    <marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M0,0 L10,5 L0,10 z" fill="#003b7a"/>
    </marker>
  </defs>
  <rect x="20" y="20" width="230" height="70" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="135" y="50" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Dataset Kaggle +</text>
  <text x="135" y="68" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Foto Lapangan</text>
  <rect x="285" y="20" width="230" height="70" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="400" y="50" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Praproses &amp;</text>
  <text x="400" y="68" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Split 80/20</text>
  <rect x="550" y="20" width="230" height="70" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="665" y="50" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Transfer Learning</text>
  <text x="665" y="68" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">MobileNetV2</text>
  <rect x="20" y="220" width="230" height="70" rx="6" fill="#fff8e6" stroke="#f5a623" stroke-width="1.5"/>
  <text x="135" y="250" text-anchor="middle" font-size="13" font-weight="600" fill="#b3760c">Integrasi ke</text>
  <text x="135" y="268" text-anchor="middle" font-size="13" font-weight="600" fill="#b3760c">Aplikasi</text>
  <rect x="285" y="220" width="230" height="70" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="400" y="250" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Konversi ke</text>
  <text x="400" y="268" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">TensorFlow Lite</text>
  <rect x="550" y="220" width="230" height="70" rx="6" fill="#e8f0fb" stroke="#003b7a" stroke-width="1.5"/>
  <text x="665" y="255" text-anchor="middle" font-size="13" font-weight="600" fill="#1a1a2e">Evaluasi Model</text>
  <line x1="250" y1="55" x2="280" y2="55" stroke="#003b7a" stroke-width="2" marker-end="url(#arrow)"/>
  <line x1="515" y1="55" x2="545" y2="55" stroke="#003b7a" stroke-width="2" marker-end="url(#arrow)"/>
  <line x1="665" y1="90" x2="665" y2="215" stroke="#003b7a" stroke-width="2" marker-end="url(#arrow)"/>
  <line x1="545" y1="255" x2="520" y2="255" stroke="#003b7a" stroke-width="2" marker-end="url(#arrow)"/>
  <line x1="280" y1="255" x2="255" y2="255" stroke="#003b7a" stroke-width="2" marker-end="url(#arrow)"/>
</svg>

_(Isi bagian ini di sini.)_

---

## 7. Rencana Pengujian Awal (QA Plan Awal)

*Susun rencana pengujian awal: ruang lingkup pengujian (fitur mana saja yang akan diuji, termasuk fitur ML), jenis pengujian yang direncanakan (fungsional dan minimal satu jenis non-fungsional: usability/kompatibilitas/performa), serta jadwal pengujian yang selaras dengan milestone (interim di Minggu 12, final di Minggu 16, sesuai persyaratan produk Penjaminan Mutu Perangkat Lunak pada RPP). Rencana ini akan diperbarui seiring perkembangan produk, sehingga tidak perlu terlalu rinci pada tahap proposal, cukup menunjukkan arah pengujian yang akan dilakukan.*

**Contoh:** Ruang lingkup: fitur ambil foto, klasifikasi hama, riwayat deteksi, login. Jenis pengujian: fungsional (setiap fitur berjalan sesuai skenario), dan performa (waktu inferensi model tidak lebih dari 3 detik per foto pada perangkat kelas menengah). Jadwal: draf test case pada Minggu 9, eksekusi interim Minggu 12, eksekusi final Minggu 15.

_(Isi bagian ini di sini.)_

---

## 8. Rencana Kerja dan Organisasi Tim

### 8.1 Jadwal dan Milestone

*Sajikan jadwal kerja (Gantt chart atau tabel) untuk 16 minggu, dengan milestone yang selaras dengan 4 checkpoint PBL yang dijelaskan pada RPP (Proposal Minggu 4, Milestone 1 Minggu 8, Milestone 2 Minggu 12, Final Minggu 16). Buat perkiraan yang realistis, karena jadwal ini akan dibandingkan dengan realisasi aktual pada logbook mingguan.*

**Contoh:**

| Minggu | Aktivitas | Milestone |
|---|---|---|
| 1-3 | Eksplorasi dataset, studi kelayakan | - |
| 4 | Finalisasi proposal dan QA plan awal | CP-1 Proposal |
| 5-8 | Training model baseline, scaffolding aplikasi | CP-2 Milestone 1 |
| 9-12 | Integrasi model ke aplikasi, mulai pengujian | CP-3 Milestone 2 |
| 13-16 | Evaluasi final model, pengujian, demo akhir | CP-4 Final |

_(Isi bagian ini di sini.)_

### 8.2 Pembagian Peran dan Tanggung Jawab

*Petakan pekerjaan utama proyek (pengembangan aplikasi, pengembangan model ML, integrasi, pengujian) ke anggota tim yang bertanggung jawab, mengacu pada peran masing-masing anggota di Bagian 1.2. Pembagian ini menjadi salah satu rujukan dosen pengampu saat menilai kontribusi individu.*

**Contoh:** Eka (Ketua Tim & Pengembang Utama): aplikasi Flutter dan integrasi model. Fajar (ML Engineer): pengumpulan data, training, dan evaluasi model. Gita (Sekretaris/Dokumentator): logbook, laporan akhir. Hana (QA/Penguji): rencana uji dan eksekusi pengujian.

_(Isi bagian ini di sini.)_

---

## 9. Rencana Mitra Industri (Opsional)

*Bila proyek melibatkan mitra nyata (UMKM, klinik, institusi pendidikan, komunitas), jelaskan siapa mitranya, bagaimana keterlibatannya direncanakan (mis. penyedia data, validasi kebutuhan, uji coba model), dan kontak penghubung. Bila tidak ada mitra, tuliskan "Tidak ada mitra pada tahap proposal"; ketiadaan mitra tidak mengurangi nilai proposal karena mitra bersifat opsional.*

**Contoh:** Mitra: Kelompok Tani _(nama kelompok)_. Keterlibatan: menyediakan sampel foto daun tambahan pada Fase 1, menguji coba aplikasi di lapangan pada Milestone 2, dan memberi umpan balik pada demo akhir. Kontak: Bapak/Ibu _(nama)_, ketua kelompok tani.

_(Isi bagian ini di sini.)_

---

## 10. Lampiran

*Sertakan dokumen pendukung yang relevan: contoh data/dataset, referensi metodologi ML yang digunakan, atau dokumen tambahan lain yang memperkuat proposal. Lampiran memperkuat kredibilitas klaim pada Bagian 3.3, dengan menunjukkan bukti bahwa studi kelayakan data benar-benar dilakukan.*

**Contoh:** Tautan dataset Kaggle yang digunakan, contoh 5 foto daun dari dataset, referensi jurnal/artikel tentang transfer learning untuk klasifikasi citra pertanian.

_(Lampirkan dokumen pendukung di sini.)_
