# Laporan Kemajuan PBL (Milestone 1)

> ⚠️ **PENTING: Dokumen ini hanya menjelaskan struktur laporan, bukan template untuk disalin.**
>
> Susun Laporan Kemajuan tim dalam dokumen sendiri dengan format dan gaya penulisan tim. Ikuti urutan dan isi bagian 1–12, tetapi **jangan menyalin** gaya dokumen ini, paragraf panduan (cetak miring), contoh SIMPAN, maupun teks penanda bagian. Laporan yang hanya berisi salinan dokumen ini dianggap belum memenuhi ketentuan.

Dokumen ini menjelaskan struktur Laporan Kemajuan *Project-Based Learning* (PBL) yang dikumpulkan pada Milestone 1 (Minggu 8). Laporan membantu tim dan dosen pengampu melihat posisi proyek dibandingkan dengan proposal, serta menyusun langkah menuju Milestone 2.

## Cara membaca dokumen ini

- Setiap bagian memuat paragraf panduan (cetak miring) dan contoh singkat. Keduanya hanya untuk dipahami dan tidak ikut ditulis di laporan.
- Contoh mengacu pada produk ilustrasi "SIMPAN" (sistem peminjaman ruang dan alat kampus), sama dengan format proposal. Tim menuliskan produknya sendiri.
- Bagian bertanda **[TI Sem 5]**, **[Sem 5]**, atau **[SIB]** hanya ditulis oleh tim pada jalur tersebut.
- Tim **[Manpro]** (TI Semester 3 dan SIB Semester 5) yang telah menyusun Laporan Tengah Semester (LTS) untuk mata kuliah Manajemen Proyek cukup merujuk ke LTS pada bagian yang diberi catatan **[Manpro]**, serta melampirkan LTS sebagai Lampiran D.
- Prosedur pengumpulan dijelaskan pada dokumen SOP Pengumpulan Laporan Kemajuan PBL.

---

## 1. Identitas Tim

### 1.1 Judul Produk dan Kelas

*Tuliskan judul produk sesuai proposal (bila berubah, jelaskan pada Bagian 8), program studi, semester, dan kelas.*

**Contoh:** "SIMPAN: Sistem Informasi Manajemen Peminjaman Alat dan Ruang", Teknik Informatika, Semester 3, kelas TI-3A.

_(Bagian ini ditulis di laporan tim.)_

### 1.2 Anggota Tim

*Cantumkan nama, NIM, dan peran seluruh anggota sesuai proposal. Bila ada perubahan peran, tuliskan peran yang berlaku saat ini.*

**Contoh:**

| Nama | NIM | Peran |
|---|---|---|
| Ahmad Fauzi | 2141720001 | Ketua Tim & Pengembang Utama |
| Budi Santoso | 2141720002 | Analis/Desainer |
| Citra Ayu | 2141720003 | Sekretaris/Dokumentator |
| Dewi Lestari | 2141720004 | QA/Penguji |

_(Bagian ini ditulis di laporan tim.)_

### 1.3 Dosen Pengampu

*Sebutkan mata kuliah terintegrasi beserta dosen pengampunya sesuai kelas.*

**Contoh:**

| Mata Kuliah | Dosen Pengampu |
|---|---|
| Manajemen Proyek | _(nama dosen)_ |
| Desain dan Pemrograman Web | _(nama dosen)_ |
| Basis Data Lanjut | _(nama dosen)_ |
| Sistem Informasi Manajemen | _(nama dosen)_ |

_(Bagian ini ditulis di laporan tim.)_

---

## 2. Ringkasan Kemajuan

*Tuliskan satu paragraf (maksimal 200 kata) tentang posisi proyek saat ini: apa yang sudah berjalan, apa yang tertinggal, dan apa fokus berikutnya. Cantumkan status keseluruhan: **On Track** (sesuai atau lebih cepat dari rencana), **Perlu Perhatian** (ada keterlambatan yang masih dapat dikejar), atau **Kritis** (rencana perlu disesuaikan). Istilah status ini sama dengan yang dipakai pada LTS Manajemen Proyek. Tulis bagian ini paling akhir agar mencerminkan seluruh isi laporan.*

**Contoh:** "Status: Perlu Perhatian. Hingga Minggu 8, modul pengajuan peminjaman dan verifikasi staf sudah berjalan dan terhubung ke basis data dengan data uji. Modul laporan pemakaian belum dimulai karena perubahan skema pada Minggu 6 menyita waktu. Pada iterasi kedua, tim memprioritaskan laporan bulanan dan peran kedua (Admin), serta menunda fitur notifikasi yang memang berada di luar lingkup."

_(Bagian ini ditulis di laporan tim.)_

---

## 3. Rencana dan Realisasi

*(**[Manpro]** Tim Manpro boleh merujuk ke LTS bagian C.6–C.7 dan G untuk status dan jadwal manajemen proyek, tanpa menulis ulang. Tabel pekerjaan tingkat produk di bawah ini tetap ditulis.)*

### 3.1 Kemajuan Rincian Pekerjaan

*Ambil rincian pekerjaan (work breakdown structure, WBS) dari proposal, lalu tuliskan persentase penyelesaian dan status (Selesai, Berjalan, Belum). Persentase dihitung dari tugas rinci yang benar-benar selesai dan dapat dibuktikan, bukan dari perkiraan yang terlalu optimistis.*

**Contoh:**

| Bagian Besar | Tugas Rinci | Penanggung Jawab | Status | Selesai |
|---|---|---|---|---|
| 1. Modul Peminjaman | 1.1.1 Rancang ERD | Ahmad | Selesai | 100% |
| | 1.1.2 Implementasi skema dan migrasi | Ahmad | Selesai | 100% |
| | 1.2.2 Implementasi formulir pengajuan | Budi | Berjalan | 70% |
| 2. Modul Laporan | 2.1.1 Kueri rekap pemakaian bulanan | Citra | Belum | 0% |

_(Bagian ini ditulis di laporan tim.)_

### 3.2 Jadwal Rencana dan Aktual

*Bandingkan jadwal pada proposal dengan realisasinya. Jelaskan setiap deviasi beserta penyebabnya secara jujur; deviasi yang dijelaskan dengan baik tidak dikenai sanksi.*

**Contoh:**

| Minggu | Rencana | Aktual | Deviasi dan Alasan |
|---|---|---|---|
| 5–6 | Skema basis data final | Final pada Minggu 7 | Revisi relasi Peminjaman–Alat setelah masukan dosen |
| 7–8 | Fitur inti peminjaman | Pengajuan selesai, verifikasi 70% | Terdampak keterlambatan skema |

_(Bagian ini ditulis di laporan tim.)_

---

## 4. Capaian Produk

### 4.1 Status Fitur

*Daftarkan fitur dari proposal beserta statusnya: selesai, sebagian, atau belum. Tuliskan fitur yang sudah dapat didemonstrasikan pada Minggu 8.*

**Contoh:**

| Fitur | Status | Catatan |
|---|---|---|
| Pengajuan peminjaman | Selesai | Dapat didemonstrasikan |
| Verifikasi oleh staf | Sebagian | Tombol setujui berfungsi, tombol tolak belum |
| Laporan pemakaian bulanan | Belum | Direncanakan pada Minggu 10 |

_(Bagian ini ditulis di laporan tim.)_

### 4.2 Daftar Periksa Target Milestone 1

*Centang target sesuai jalur tim (lihat SOP Bagian 7) dan beri catatan singkat untuk target yang belum tercapai.*

- TI Semester 3: [ ] operasi tambah, baca, ubah, dan hapus data pada entitas utama berjalan · [ ] terintegrasi dengan basis data · [ ] data uji terisi · [ ] kemajuan terlacak terhadap WBS
- TI Semester 5: [ ] model ML dasar (*baseline*) telah dilatih · [ ] akurasi awal terdokumentasi · [ ] aplikasi *mobile* berjalan · [ ] integrasi awal model dan aplikasi · [ ] rencana penjaminan mutu (QA plan) diperbarui
- SIB Semester 3: [ ] prototipe atau *wireframe* menjadi acuan · [ ] alur bisnis utama mulai berjalan · [ ] pengelolaan data entitas domain bisnis berfungsi sebagian · [ ] antarmuka konsisten
- SIB Semester 5: [ ] arsitektur web berjalan (API dan autentikasi) · [ ] fitur multiperan mulai berfungsi · [ ] rencana pengujian awal tersusun · [ ] jadwal, risiko, dan perubahan terdokumentasi

_(Bagian ini ditulis di laporan tim.)_

### 4.3 Hasil Model Dasar (*Baseline*) **[TI Sem 5]**

*Jelaskan dataset, model dasar, metrik (akurasi, *precision*, *recall*), dan hasil awalnya. Sebutkan pula rencana perbaikan model.*

**Contoh:** "Model klasifikasi gambar dasar (CNN sederhana) pada 2.000 data latih menghasilkan akurasi 78%, *precision* 0,76, dan *recall* 0,74. Perbaikan direncanakan melalui augmentasi data dan *transfer learning*."

_(Bagian ini ditulis di laporan tim.)_

### 4.4 Status Rencana Pengujian **[Sem 5]**

*Ringkas kondisi rencana penjaminan mutu (QA plan) atau rencana pengujian: ruang lingkup, jumlah kasus uji (*test case*) yang sudah disusun, dan yang sudah dieksekusi (bila ada).*

**Contoh:** "QA plan versi 2: 18 kasus uji fungsional telah disusun, 6 di antaranya sudah dieksekusi dengan 2 *bug* tercatat dan 1 sudah diperbaiki."

_(Bagian ini ditulis di laporan tim.)_

### 4.5 Prototipe dan Antarmuka **[SIB]**

*Tunjukkan kesesuaian antarmuka yang dibangun dengan prototipe atau *wireframe*, dan catat bagian yang berbeda beserta alasannya.*

_(Bagian ini ditulis di laporan tim.)_

---

## 5. Bukti Kemajuan

*Cantumkan tautan yang dapat diakses dosen pengampu: repositori Git (dengan riwayat *commit* seluruh anggota), tautan demonstrasi atau video singkat, tangkapan layar fitur yang berjalan, dan alamat aplikasi bila sudah diunggah ke server (*deploy*). Tautan yang tidak dapat dibuka dianggap tidak ada.*

**Contoh:**

| Jenis Bukti | Tautan/Keterangan |
|---|---|
| Repositori Git | _(URL repositori)_ |
| Video demonstrasi (maksimal 3 menit) | _(URL video)_ |
| Aplikasi yang sudah di-*deploy* | _(URL aplikasi)_ |
| Tangkapan layar | Lampiran A |

_(Bagian ini ditulis di laporan tim.)_

---

## 6. Kontribusi Individu

*Catat pekerjaan setiap anggota sampai Minggu 8 beserta bukti yang dapat ditelusuri (*commit*, berkas dokumen, tugas pada WBS). Bagian ini menjadi rujukan dosen dalam menilai kontribusi individu dan sebaiknya disepakati bersama oleh seluruh anggota.*

**Contoh:**

| Nama | Tugas Selesai | Bukti | Estimasi Kontribusi |
|---|---|---|---|
| Ahmad Fauzi | Skema basis data, API pengajuan | 34 *commit*, berkas migrasi | 30% |
| Budi Santoso | *Wireframe*, formulir pengajuan | 21 *commit*, berkas Figma | 25% |
| Citra Ayu | Logbook, dokumentasi, data uji | Logbook Minggu 1–8 | 20% |
| Dewi Lestari | Kasus uji fungsional awal | Dokumen kasus uji | 25% |

_(Bagian ini ditulis di laporan tim.)_

---

## 7. Kendala dan Solusi

*(**[Manpro]** Cukup merujuk ke LTS bagian F, lalu tambahkan hanya kendala yang khusus menyangkut pengembangan produk.)*

*Uraikan kendala utama (teknis, waktu, koordinasi tim, data atau mitra) beserta cara tim mengatasinya atau rencana penanganannya. Tuliskan pula bantuan yang dibutuhkan dari dosen pengampu atau koordinator.*

**Contoh:**

| Kendala | Dampak | Solusi/Rencana | Bantuan yang Dibutuhkan |
|---|---|---|---|
| Relasi Peminjaman–Alat berubah | Skema dibuat ulang, terlambat 1 minggu | Perubahan dikunci setelah ditinjau dosen Basis Data Lanjut | Konsultasi normalisasi |

_(Bagian ini ditulis di laporan tim.)_

---

## 8. Perubahan Lingkup dan Risiko

### 8.1 Perubahan dari Proposal

*Sebutkan perubahan judul, fitur, teknologi, atau peran sejak proposal disetujui, alasannya, dan apakah perubahan tersebut sudah dikonsultasikan dengan dosen pengampu.*

**Contoh:** "Fitur ekspor PDF laporan ditambahkan atas permintaan staf Tata Usaha; fitur pelacakan kondisi alat dikeluarkan dari lingkup. Keduanya telah disetujui dosen Sistem Informasi Manajemen."

_(Bagian ini ditulis di laporan tim.)_

### 8.2 Risiko Utama

*(**[Manpro]** Boleh merujuk ke LTS bagian E dan F; cantumkan di sini hanya risiko produk yang belum tercakup.)*

*Daftarkan maksimal 5 risiko terbesar untuk iterasi berikutnya, disertai tingkat risiko (Tinggi/Sedang/Rendah) dan tindakan pencegahannya.*

**Contoh:**

| Risiko | Tingkat | Tindakan |
|---|---|---|
| Modul laporan belum dimulai | Tinggi | Mulai pada Minggu 9 dan prioritaskan satu laporan |
| Data uji kurang realistis | Sedang | Meminta contoh data kepada Tata Usaha |

_(Bagian ini ditulis di laporan tim.)_

---

## 9. Rencana Menuju Milestone 2 (Minggu 9–12)

*(**[Manpro]** Rencana manajemen proyek cukup dirujuk ke LTS bagian G; tuliskan di sini target pengembangan produk pada Minggu 9–12.)*

*Susun target dan penanggung jawab per minggu hingga Milestone 2, yaitu produk fungsional lengkap dan hasil uji awal. Rencana harus layak dilaksanakan berdasarkan kemajuan sebenarnya pada Bagian 3.*

**Contoh:**

| Minggu | Target | Penanggung Jawab |
|---|---|---|
| 9 | Menyelesaikan verifikasi staf; memulai peran Admin | Ahmad, Budi |
| 10 | Modul laporan pemakaian bulanan | Citra, Ahmad |
| 11 | Integrasi dan pengujian fungsional mandiri | Dewi |
| 12 | Demonstrasi produk fungsional dan draf laporan pengujian | Seluruh tim |

_(Bagian ini ditulis di laporan tim.)_

---

## 10. Rekap Logbook Minggu 1–8

*Ringkas logbook mingguan dalam satu tabel (pekerjaan selesai, kendala, rencana berikutnya). Logbook lengkap dilampirkan pada Lampiran B.*

**Contoh:**

| Minggu | Pekerjaan Selesai | Kendala | Rencana Berikutnya |
|---|---|---|---|
| 1 | Pembentukan tim, curah gagasan masalah | Belum ada mitra | Wawancara calon pengguna |
| 2 | Wawancara 3 narasumber | Jadwal bentrok | Menetapkan ide produk |

_(Bagian ini ditulis di laporan tim.)_

---

## 11. Deklarasi Penggunaan AI

*Sebutkan bagian yang dibantu AI (kode, desain, dokumentasi, dan lain-lain), alat yang digunakan, serta tujuannya. Seluruh anggota harus memahami dan mampu menjelaskan hasil yang dibantu AI.*

**Contoh:**

| Bagian | Alat | Tujuan |
|---|---|---|
| Kueri laporan | Asisten kode | Saran optimasi; telah ditinjau dan diuji tim |
| Logbook | Asisten penulisan | Merapikan kalimat |

_(Bagian ini ditulis di laporan tim.)_

---

## 12. Lampiran

*Lampiran A: tangkapan layar fitur. Lampiran B: logbook mingguan lengkap Minggu 1–8. Lampiran C (opsional): dokumen pendukung, misalnya catatan konsultasi dengan dosen atau mitra. Lampiran D **[Manpro]**: Laporan Tengah Semester (`M08a_LaporanTengahSemester.pdf`).*

_(Lampiran disertakan di laporan tim.)_

---

> ⚠️ **Ingat:** yang dikumpulkan adalah laporan tim dengan struktur di atas, bukan salinan dokumen ini.
