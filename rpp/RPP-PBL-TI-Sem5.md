# Rencana Pelaksanaan Pembelajaran (RPP): PBL Terintegrasi
## Program Studi Teknik Informatika · Semester 5

---

## 1. Identitas

| Item | Keterangan |
|---|---|
| Perguruan Tinggi | Politeknik Negeri Malang |
| Jurusan | Teknologi Informasi |
| Program Studi | Teknik Informatika (TI) |
| Semester | 5 |
| Tahun Akademik | 2025/2026 |
| Bentuk Pembelajaran | Project-Based Learning (PBL) Terintegrasi Lintas Mata Kuliah |
| Tema Proyek Semester | Aplikasi mobile dengan minimal satu fitur berbasis machine learning, teruji mutunya |
| Koordinator PBL | Dian Hanifudin Subhi, S.Kom., M.Kom. (dhanifudin@polinema.ac.id) |

### Mata Kuliah Terintegrasi

| Mata Kuliah | Kategori |
|---|---|
| Pemrograman Mobile | 🔵 Inti |
| Pembelajaran Mesin | 🔵 Inti |
| Penjaminan Mutu Perangkat Lunak | 🟡 Pendukung |

---

## 2. Deskripsi Pembelajaran Berbasis Proyek

PBL (*Project-Based Learning*) di Jurusan Teknologi Informasi Polinema bersifat **product-based**: setiap tim mahasiswa menghasilkan satu **produk digital yang berfungsi penuh**, dikerjakan secara terintegrasi lintas beberapa mata kuliah dalam satu semester, bukan tugas-tugas terpisah per mata kuliah.

Pada Semester 5, skala proyek naik dari Semester 3: dari web ke **aplikasi mobile ber-fitur machine learning**, dengan pengujian yang lebih terstruktur. Tantangannya adalah mengintegrasikan model ML (klasifikasi, deteksi, rekomendasi, prediksi, dll.) ke dalam aplikasi mobile yang benar-benar berjalan (bukan sekadar eksperimen di notebook), sambil menerapkan penjaminan mutu perangkat lunak secara formal.

Tim terdiri dari **4–5 mahasiswa**, dibentuk di dalam kelas per program studi, dan mendapat **arahan bersama dari seluruh dosen pengampu** mata kuliah terintegrasi pada semester ini, bukan dari satu dosen pembimbing tunggal. Pembelajaran berjalan mengikuti lima fase PjBL selama 16 minggu, dengan empat checkpoint (proposal dan tiga milestone) sebagai titik evaluasi dan revisi, bukan sebagai hukuman.

---

## 3. Tujuan Pembelajaran

### 3.1 Tujuan Umum

Melalui pengerjaan proyek PBL product-based, mahasiswa Semester 5 diharapkan mampu:

- Membangun aplikasi mobile yang berjalan nyata di perangkat, bukan hanya prototipe.
- Membangun fitur machine learning yang memberi output nyata di dalam aplikasi (bukan sekadar eksperimen di notebook) dan mengevaluasinya dengan metrik yang terukur.
- Merencanakan dan mengeksekusi pengujian perangkat lunak secara terstruktur sampai menghasilkan laporan mutu (QA).
- Mengintegrasikan hasil kerja lintas bidang teknis (aplikasi, model, pengujian) menjadi satu produk yang utuh.
- Bekerja secara kolaboratif dalam tim, mendokumentasikan proses kerja, dan mempresentasikan produk secara meyakinkan.

### 3.2 Kemampuan yang Dibangun di Tiap Fase PBL

| Fase PBL | Kemampuan Akhir yang Diharapkan |
|---|---|
| 1. Identifikasi | Mahasiswa mampu mengidentifikasi masalah nyata, menilai kelayakan teknis (termasuk ketersediaan dataset), dan menentukan produk serta teknologi yang akan dipakai. Mobile: menilai kelayakan platform & runtime di perangkat; ML: mengeksplorasi sumber dataset & menetapkan target baseline; PMPL: mengidentifikasi ruang lingkup pengujian awal. |
| 2. Perencanaan | Mahasiswa mampu menyusun rencana proyek, proposal produk (arsitektur, fitur, metodologi ML), dan rencana pengujian awal (QA plan). Mobile: merancang arsitektur aplikasi; ML: merancang metodologi pelatihan model; PMPL: menyusun QA plan awal selaras dengan fitur yang direncanakan. |
| 3. Pengembangan | Mahasiswa mampu melatih dan mengintegrasikan model ML ke aplikasi mobile secara bertahap, serta memperbarui rencana pengujian seiring perkembangan produk. Mobile: membangun scaffolding & mengintegrasikan model; ML: melatih & menyempurnakan model dari baseline ke versi terintegrasi; PMPL: menyusun test case dan mulai eksekusi uji interim. |
| 4. Pengujian & Pengemasan | Mahasiswa mampu mengeksekusi rencana uji, mengevaluasi performa model ML dengan metrik yang jelas, dan menyusun laporan QA serta laporan akhir. Mobile: mengoptimasi performa aplikasi; ML: mengevaluasi model final dengan metrik terukur; PMPL: menuntaskan eksekusi test case dan menyusun laporan QA final. |
| 5. Diseminasi | Mahasiswa mampu mempresentasikan dan mendemonstrasikan produk final (termasuk fitur ML) secara meyakinkan kepada penguji/mitra, serta mengevaluasi capaian proyek secara reflektif lintas ketiga mata kuliah terintegrasi. |

---

## 4. Peran dan Kontribusi Mata Kuliah

### 4.1 Matriks Peran

| Mata Kuliah | Kategori | Peran dalam PBL | Luaran yang Dinilai dari MK Ini |
|---|---|---|---|
| Pemrograman Mobile | 🔵 Inti | Implementasi aplikasi mobile | Aplikasi mobile berjalan di perangkat/emulator, kualitas dan struktur kode |
| Pembelajaran Mesin | 🔵 Inti | Model ML yang terintegrasi ke produk | Model terlatih, evaluasi metrik (akurasi/precision/recall), integrasi ke aplikasi |
| Penjaminan Mutu Perangkat Lunak | 🟡 Pendukung | Rencana uji, test case, laporan pengujian | QA plan, test case, laporan hasil uji, bug log |

### 4.2 Pemrograman Mobile

- **Peran:** implementasi aplikasi mobile dengan **Flutter** (target utama Android; iOS opsional bila tersedia perangkat/lingkungan build) sebagai wujud teknis produk.
- **Bahan kajian/topik pendukung:** dasar bahasa Dart, arsitektur aplikasi Flutter (struktur project & widget tree), UI/layout dengan widget Flutter (Material/Cupertino), navigasi (Navigator 2.0 atau package `go_router`), manajemen state terstruktur (Provider, Riverpod, atau BLoC), akses data lokal (`shared_preferences`/`sqflite`/Hive) & remote (`http`/`dio`), integrasi model ML (`tflite_flutter` atau `google_ml_kit`), build & rilis aplikasi (`flutter build apk`/`appbundle`).
- **Persyaratan Produk dari MK Ini:**
  - Aplikasi dibangun dengan **Flutter (Dart)**, ter-install dan berjalan di perangkat Android fisik atau emulator (target iOS bersifat opsional).
  - Minimal 4 layar/route fungsional dengan navigasi terstruktur (Navigator 2.0 atau `go_router`), bukan sekadar tumpukan `Navigator.push` tanpa pola.
  - Manajemen state menggunakan pendekatan yang terstruktur dan konsisten (mis. Provider, Riverpod, atau BLoC), bukan `setState` tersebar tanpa pola yang jelas.
  - Akses data lokal (mis. `shared_preferences`, `sqflite`, atau Hive) dan/atau akses data remote via REST API (mis. package `http` atau `dio`) sesuai kebutuhan fitur.
  - Penanganan izin perangkat menggunakan package seperti `permission_handler` bila fitur memerlukan kamera/lokasi/penyimpanan, termasuk penanganan kasus izin ditolak.
  - Model ML diintegrasikan melalui package seperti `tflite_flutter` atau `google_ml_kit`, dengan output ditampilkan langsung ke pengguna di antarmuka (bukan hanya di log/console).
  - Artefak build dihasilkan melalui `flutter build apk` atau `flutter build appbundle` (dan `flutter build ios` bila menyasar iOS), tersedia untuk instalasi/demo, bukan hanya berjalan dari mode debug IDE.

### 4.3 Pembelajaran Mesin

- **Peran:** membangun model ML yang terintegrasi nyata ke dalam produk mobile, bukan sekadar eksperimen notebook.
- **Bahan kajian/topik pendukung:** praproses data, supervised learning, evaluasi model, transfer learning, konversi model (mis. TFLite/ONNX), inferensi on-device vs. via API.
- **Persyaratan Produk dari MK Ini:**
  - Dataset terdokumentasi: sumber, jumlah data, proses pengumpulan/pembersihan.
  - Train/test split dijelaskan beserta rasionya, mencegah data leakage.
  - Minimal satu model baseline dilatih sebagai pembanding sebelum model final.
  - Model final dievaluasi dengan metrik sesuai jenis masalah (akurasi/precision/recall/F1 untuk klasifikasi; RMSE/MAE untuk regresi), disertai confusion matrix atau visualisasi hasil.
  - Analisis kesalahan sederhana: kasus prediksi salah dan kemungkinan penyebabnya.
  - Model dikonversi/dikemas ke format yang berjalan di mobile (mis. TensorFlow Lite/ONNX/via API) dengan ukuran & waktu inferensi wajar untuk perangkat mobile.
  - Metodologi (algoritma & alasan pemilihan, hyperparameter utama) didokumentasikan dalam laporan evaluasi model.

### 4.4 Penjaminan Mutu Perangkat Lunak

- **Peran:** menyusun rencana uji, test case, dan laporan pengujian secara formal.
- **Bahan kajian/topik pendukung:** konsep kualitas perangkat lunak, penyusunan test plan, desain test case, pengujian fungsional & non-fungsional dasar, bug tracking, pelaporan QA.
- **Persyaratan Produk dari MK Ini:**
  - Test plan tertulis: ruang lingkup, jenis pengujian, jadwal selaras milestone.
  - Minimal 15–20 test case mencakup fitur utama aplikasi (termasuk fitur ML), dengan langkah, data uji, dan hasil yang diharapkan.
  - Pengujian fungsional dieksekusi untuk seluruh test case dengan hasil pass/fail tercatat.
  - Minimal satu jenis pengujian non-fungsional dasar (usability sederhana, kompatibilitas perangkat, atau performa/response time).
  - Bug/temuan dicatat dalam bug log (severity, langkah reproduksi, status resolusi) dan dilacak hingga selesai atau didokumentasikan sebagai known issue.
  - Laporan QA akhir merangkum cakupan pengujian, hasil, bug yang ditangani, dan rekomendasi kualitas produk.

---

## 5. Metode dan Model Pembelajaran

### 5.1 Alur 5 Fase Project-Based Learning

| Fase | Fokus Kegiatan | Minggu |
|---|---|---|
| 1. Identifikasi | Menemukan masalah nyata, menentukan ide produk & teknologi, studi kelayakan (termasuk dataset untuk ML) | 1–3 |
| 2. Perencanaan | Menyusun rencana produk: arsitektur, fitur, rencana QA awal, pembagian kerja | 3–4 |
| 3. Pengembangan | Membangun produk bertahap (iterasi), melatih & mengintegrasikan model ML, mencatat kemajuan di logbook | 5–12 |
| 4. Pengujian & Pengemasan | Mengeksekusi rencana uji, mengevaluasi model ML, menyiapkan dokumentasi | 13–15 |
| 5. Diseminasi | Menampilkan produk final lewat demo/expo | 16 |

### 5.2 Model Tim

| Ketentuan | Detail |
|---|---|
| Ukuran tim | 4–5 mahasiswa per tim |
| Penyesuaian jumlah tim | Menyesuaikan total mahasiswa dalam kelas |
| Pembentukan | Di dalam kelas, per program studi |
| Pembimbingan | Arahan bersama dari seluruh dosen pengampu mata kuliah terintegrasi (bukan satu pembimbing tunggal) |

**Peran dalam tim** (satu orang boleh merangkap):

| Peran | Tanggung Jawab Utama |
|---|---|
| Ketua Tim | Koordinasi antar-anggota, penghubung ke dosen pengampu, penjaga timeline |
| Sekretaris/Dokumentator | Logbook, laporan, notulensi, dan manajemen dokumen QA |
| Pengembang Utama | Penanggung jawab teknis aplikasi mobile (Flutter) |
| ML Engineer/Arsitek Sistem | Model ML, integrasi API, arsitektur sistem |
| QA/Penguji | Menyusun rencana & dokumen pengujian, eksekusi test case |

Di Semester 5, peran QA lebih formal: ada dokumen pengujian yang dinilai tersendiri. Pembagian tugas dituangkan dalam proposal pada Fase 2.

### 5.3 Mekanisme Bimbingan Bersama

- Bimbingan dilakukan bersama oleh seluruh dosen pengampu mata kuliah terintegrasi, sesuai jadwal masing-masing mata kuliah.
- Tim mengisi **logbook mingguan** (kemajuan, hambatan, rencana berikutnya) dan memperbarui **rencana pengujian (QA plan)** seiring perkembangan produk.
- **Proposal produk (termasuk QA plan awal) sebaiknya disetujui** sebelum tim melanjutkan ke tahap pengembangan; bila belum disetujui, tim merevisi dan mengajukan ulang **paling lambat Minggu 5**.
- Bentuk penyampaian proposal menyesuaikan ketentuan mata kuliah terkait; presentasi/sidang formal tidak selalu diperlukan.

---

## 6. Target Produk dan Kriteria Keberhasilan

### 6.1 Deskripsi Produk

Aplikasi mobile dengan minimal satu fitur berbasis machine learning, teruji mutunya.

### 6.2 Kriteria "Produk Berjalan"

- ☑️ Aplikasi mobile terpasang & berjalan di perangkat atau emulator (demo live)
- ☑️ Minimal 1 fitur ML memberi output nyata di dalam aplikasi (mis. hasil klasifikasi tampil ke pengguna)
- ☑️ Model dievaluasi dengan metrik jelas (akurasi, precision, recall)
- ☑️ Rencana pengujian dieksekusi: ada test case dan hasilnya, bukan sekadar rencana
- ☑️ Alur utama stabil saat didemokan

> Model yang hanya ada di notebook tanpa terintegrasi ke aplikasi belum memenuhi kriteria.

### 6.3 Kriteria Ruang Lingkup

| Skala | Ciri |
|---|---|
| ❌ Terlalu kecil | Hanya notebook ML tanpa aplikasi; atau aplikasi CRUD tanpa fitur ML |
| ✅ Pas (ideal) | 1 fitur ML matang, terintegrasi ke aplikasi mobile, ditambah pengujian dan fitur pendukung |
| ❌ Terlalu besar | Banyak model kompleks + video real-time + backend skala besar sekaligus |

> Satu fitur ML yang benar-benar berjalan lebih baik daripada banyak fitur setengah jadi.

### 6.4 Contoh Ide Produk (Non-Mengikat)

- Deteksi dini penyakit dari foto (kulit, mata, daun tanaman)
- Prediksi hasil panen atau deteksi hama dari foto
- Pengenalan bahasa isyarat lewat kamera
- Analisis sentimen catatan harian (kesehatan mental)
- Deteksi kerusakan kendaraan dari foto (bengkel)
- Klasifikasi mutu atau kematangan buah untuk sortir UMKM
- Klasifikasi jenis sampah untuk edukasi daur ulang
- Chatbot FAQ layanan dengan NLP sederhana

---

## 7. Rencana Kegiatan Mingguan (16 Minggu)

| Mg | Tahap PBL | Aktivitas Tim | Luaran/Deliverable | Checkpoint |
|---|---|---|---|---|
| 1 | 1. Identifikasi | Pembentukan tim; brainstorming masalah nyata; mulai eksplorasi dataset yang tersedia (Kaggle, data mitra, data publik) | Daftar anggota tim, peran awal, arah domain masalah | - |
| 2 | 1. Identifikasi | Analisis kelayakan teknis (apakah model bisa dibuat, data cukup, runtime di mobile memadai) | Catatan kelayakan teknis; sumber dataset kandidat | - |
| 3 | 1. Identifikasi | Menetapkan ide produk & pernyataan masalah; penentuan arsitektur kasar; mulai menyusun draf proposal (termasuk tujuan dan ruang lingkup proyek) | Pernyataan masalah, sumber dataset, target baseline akurasi | - |
| 4 | 2. Perencanaan | Menyusun proposal produk lengkap (termasuk tujuan dan ruang lingkup proyek, arsitektur, fitur, metodologi ML), dan rencana QA awal; review proposal | Proposal produk (lengkap), QA plan awal | **CP-1 Proposal** |
| 5 | 2→3. Perencanaan/Pengembangan | Revisi proposal (bila belum disetujui); mulai scaffolding aplikasi mobile | Proposal final; struktur aplikasi mobile awal | Batas akhir revisi proposal |
| 6 | 3. Pengembangan (Iterasi 1) | Training model ML baseline; pengembangan scaffolding aplikasi mobile | Model ML baseline; struktur aplikasi berjalan | - |
| 7 | 3. Pengembangan (Iterasi 1) | Penyempurnaan model baseline; integrasi awal model ke aplikasi mobile | Integrasi awal model-aplikasi | - |
| 8 | 3. Pengembangan (Iterasi 1) | Demo progres: fitur inti/model baseline berjalan; evaluasi kemajuan bersama dosen pengampu | Model baseline terdokumentasi (akurasi awal); demo scaffolding mobile; logbook Minggu 1–8 lengkap | **CP-2 Milestone 1** |
| 9 | 3. Pengembangan (Iterasi 2) | Integrasi model ke aplikasi mobile secara penuh; mulai penyusunan test case | Fitur ML terintegrasi sebagian | - |
| 10 | 3. Pengembangan (Iterasi 2) | Penyempurnaan fitur aplikasi; pembaruan rencana pengujian (QA plan) sesuai progres | QA plan terbarui; fitur aplikasi lebih lengkap | - |
| 11 | 3. Pengembangan (Iterasi 2) | Mulai eksekusi pengujian (interim); pencatatan bug awal | Draf laporan QA interim | - |
| 12 | 3→4. Pengembangan/Pengujian | Demo produk fungsional lengkap dengan model terintegrasi + laporan QA interim | Demo produk fungsional; laporan QA interim; draf laporan akhir Bab 1–3 | **CP-3 Milestone 2** |
| 13 | 4. Pengujian & Pengemasan | Eksekusi test case dari QA plan; bug tracking & perbaikan | Laporan QA terupdate; bug log | - |
| 14 | 4. Pengujian & Pengemasan | Evaluasi final model ML (akurasi, precision, recall); optimasi performa di mobile | Laporan evaluasi model ML | - |
| 15 | 4. Pengujian & Pengemasan | Penulisan laporan akhir (termasuk bab QA dan evaluasi ML); penyiapan materi demo/expo | Laporan akhir (draf lengkap); laporan QA final; materi presentasi | - |
| 16 | 5. Diseminasi | Demo Day/Expo/sidang akhir; presentasi & demo langsung (live, bukan video); peer assessment | Produk final, laporan akhir, laporan QA final, kode sumber (Git), slide presentasi, peer assessment | **CP-4 Final/Expo** |

---

## 8. Matriks Kontribusi Mata Kuliah per Minggu

> Topik berikut bersifat indikatif; dosen pengampu masing-masing mata kuliah dapat menyesuaikannya dengan RPS dan urutan materi kelas selama tetap selaras dengan tahap PBL pada minggu tersebut.

| Mg | Pemrograman Mobile (Inti) | Pembelajaran Mesin (Inti) | Penjaminan Mutu Perangkat Lunak (Pendukung) |
|---|---|---|---|
| 1 | Pengantar Flutter & Dart, pembentukan tim | Eksplorasi sumber dataset (Kaggle, data mitra, data publik) | Pengantar konsep kualitas perangkat lunak |
| 2 | Instalasi & setup lingkungan pengembangan Flutter (SDK, emulator/perangkat) | Evaluasi kelayakan data & kelayakan model | Identifikasi ruang lingkup pengujian awal |
| 3 | Rancangan arsitektur aplikasi mobile secara kasar | Penentuan target metrik & baseline akurasi | Pemetaan risiko kualitas produk |
| 4 | Proposal arsitektur & fitur aplikasi | Proposal metodologi ML & rencana dataset | Penyusunan QA plan awal |
| 5 | Scaffolding struktur aplikasi mobile | Persiapan & praproses data training | Penyelarasan QA plan dengan arsitektur produk |
| 6 | Implementasi struktur & layout aplikasi | Training model ML baseline | Penyusunan kerangka test case awal |
| 7 | Integrasi awal model ke aplikasi (uji coba inferensi) | Evaluasi & penyempurnaan model baseline | Penyusunan test case fungsional inti |
| 8 | Demo scaffolding & integrasi awal Milestone 1 | Dokumentasi akurasi model baseline Milestone 1 | Review kesesuaian QA plan dengan progres Milestone 1 |
| 9 | Integrasi model penuh ke antarmuka aplikasi | Perbaikan/tuning model pasca-Milestone 1 | Penyusunan test case tambahan untuk fitur ML |
| 10 | Penyempurnaan fitur & navigasi aplikasi | Validasi model dengan data uji tambahan | Pembaruan QA plan sesuai fitur terbaru |
| 11 | Optimasi akses data & manajemen state | Validasi model lanjutan & analisis kesalahan (error analysis) | Eksekusi pengujian interim & pencatatan bug awal |
| 12 | Demo produk fungsional lengkap Milestone 2 | Demo integrasi model pada Milestone 2 | Laporan QA interim Milestone 2 |
| 13 | Perbaikan bug hasil pengujian interim | Analisis lanjutan performa model pada data nyata | Eksekusi test case lengkap & bug tracking |
| 14 | Optimasi performa aplikasi di perangkat mobile | Evaluasi final model (akurasi, precision, recall) | Verifikasi resolusi bug |
| 15 | Persiapan build & rilis aplikasi | Penyusunan laporan evaluasi model ML | Penyusunan laporan QA final |
| 16 | Presentasi & demo aplikasi mobile final | Presentasi hasil evaluasi model ML final | Presentasi ringkasan hasil QA final |

---

## 9. Milestone, Checkpoint, dan Deliverable

### 9.1 Checkpoint

| Checkpoint | Minggu | Fokus Evaluasi | Konsekuensi |
|---|---|---|---|
| CP-1 Proposal | 4 | Proposal produk lengkap (termasuk tujuan, ruang lingkup, arsitektur, metodologi ML), QA plan awal | Proposal yang belum disetujui sebaiknya direvisi dan diajukan ulang paling lambat Minggu 5 |
| CP-2 Milestone 1 | 8 | Apakah fondasi teknis sudah kokoh: model ML baseline ada, scaffolding mobile berjalan; logbook Minggu 1–8 | Tim tanpa fondasi teknis yang memadai disarankan segera berkonsultasi dengan koordinator untuk menyesuaikan rencana |
| CP-3 Milestone 2 | 12 | Produk fungsional lengkap dengan model terintegrasi, laporan QA interim, draf laporan akhir Bab 1–3 | Milestone 2 adalah *quality gate*: idealnya QA plan sudah berjalan, bukan baru dimulai; produk yang belum lengkap sebaiknya belum maju ke sidang akhir tanpa berdiskusi dengan koordinator |
| CP-4 Final/Expo | 16 | Produk final, laporan QA lengkap, laporan evaluasi model ML, laporan akhir, presentasi, peer assessment | Menjadi penanda kelulusan tahap PBL semester berjalan |

### 9.2 Checklist Deliverable per Milestone

| Deliverable | Proposal (Mg 4) | Milestone 1 (Mg 8) | Milestone 2 (Mg 12) | Final (Mg 16) |
|---|---|---|---|---|
| Proposal Produk | ✅ | - | - | - |
| QA Plan | ✅ Awal | ✅ Update | ✅ Lengkap | ✅ Final |
| Logbook Mingguan | - | ✅ Mg 1–8 | ✅ Mg 9–12 | ✅ Lengkap |
| Demo Produk | - | ✅ Fitur inti/baseline | ✅ Fitur lengkap | ✅ Produk final |
| Laporan Pengujian (QA) | - | - | ✅ Interim | ✅ Final |
| Evaluasi Model ML | - | ✅ Baseline | ✅ Iterasi | ✅ Final |
| Laporan Akhir | - | - | ✅ Draf Bab 1–3 | ✅ Lengkap (Bab 1–5) |
| Slide Presentasi | ✅ Proposal | - | - | ✅ Final |
| Kode Sumber (Git) | - | - | - | ✅ |
| Peer Assessment | - | - | - | ✅ |

---

## 10. Etika Akademik dan Ketentuan Penggunaan AI

**Orisinalitas**
- Produk dan dokumentasi merupakan karya tim sendiri.
- Aset atau library pihak ketiga (kode, gambar, dataset, model pre-trained) diatribusi dan sesuai lisensi. Fine-tuning model pre-trained (transfer learning) diperbolehkan dan dihargai: yang dinilai adalah kemampuan integrasi, pemahaman model, dan evaluasinya.

**Penggunaan AI**
- Boleh digunakan sebagai alat bantu (coding assistant, brainstorming, debugging, penulisan).
- Pahami dan mampu menjelaskan seluruh kode, model, atau produk yang dihasilkan.
- Deklarasikan penggunaan AI di dokumentasi (bagian apa, untuk apa).
- Hindari menyerahkan output AI mentah tanpa pemahaman.

> Prinsip: AI mempercepat, bukan menggantikan pemahaman mahasiswa.

---

## 11. Mitra Industri (Opsional, Dianjurkan)

**Mengapa sangat dianjurkan di Semester 5:** produk ML lebih berarti dengan data dan konteks nyata; validasi model oleh pengguna nyata memberi nilai akademik dan praktis lebih tinggi; memberi pengalaman deploying ke lingkungan produksi.

**Siapa yang bisa jadi mitra:** UMKM, klinik, toko, institusi pendidikan, komunitas; perusahaan IT (pemberi data atau co-tester); instansi pemerintah/dinas (data publik).

**Mekanisme:**
1. Identifikasi mitra pada Minggu 1–2.
2. Sampaikan ke dosen pengampu atau koordinator PBL.
3. Mitra terlibat minimal saat validasi kebutuhan (Fase 1), review Milestone 2, dan Demo Day.
