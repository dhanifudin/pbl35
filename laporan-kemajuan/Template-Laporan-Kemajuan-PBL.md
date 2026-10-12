# Laporan Kemajuan PBL (Milestone 1)

Dokumen ini adalah template Laporan Kemajuan PBL yang dikumpulkan pada Milestone 1 (Minggu 8). Laporan membantu tim dan dosen pengampu melihat posisi proyek dibandingkan dengan proposal, serta menyusun langkah menuju Milestone 2.

Setiap bagian disertai paragraf panduan (dicetak miring) dan contoh singkat. Contoh mengacu pada produk ilustrasi yang sama dengan format proposal, yaitu "SIMPAN" (sistem peminjaman ruang dan alat kampus); tim tentu mengisi dengan produknya sendiri. Bagian bertanda **[TI Sem 5]**, **[Sem 5]**, atau **[SIB]** hanya diisi oleh tim pada jalur tersebut. Hapus paragraf panduan dan contoh setelah bagian diisi. Prosedur pengumpulan ada di dokumen SOP Laporan Kemajuan PBL.

---

## 1. Identitas Tim

### 1.1 Judul Produk dan Kelas

*Tuliskan judul produk sesuai proposal (bila berubah, jelaskan di Bagian 8), program studi, semester, dan kelas.*

**Contoh:** "SIMPAN: Sistem Informasi Manajemen Peminjaman Alat dan Ruang", Teknik Informatika, Semester 3, kelas TI-3A.

_(Isi bagian ini di sini.)_

### 1.2 Anggota Tim

*Cantumkan nama, NIM, dan peran seluruh anggota sesuai proposal. Bila ada perubahan peran, tuliskan peran yang berlaku sekarang.*

**Contoh:**

| Nama | NIM | Peran |
|---|---|---|
| Ahmad Fauzi | 2141720001 | Ketua Tim & Pengembang Utama |
| Budi Santoso | 2141720002 | Analis/Desainer |
| Citra Ayu | 2141720003 | Sekretaris/Dokumentator |
| Dewi Lestari | 2141720004 | QA/Penguji |

_(Isi bagian ini di sini.)_

### 1.3 Dosen Pengampu

*Sebutkan mata kuliah terintegrasi dan dosen pengampunya sesuai kelas.*

**Contoh:**

| Mata Kuliah | Dosen Pengampu |
|---|---|
| Manajemen Proyek | _(nama dosen)_ |
| Desain dan Pemrograman Web | _(nama dosen)_ |
| Basis Data Lanjut | _(nama dosen)_ |
| Sistem Informasi Manajemen | _(nama dosen)_ |

_(Isi bagian ini di sini.)_

---

## 2. Ringkasan Kemajuan

*Tulis satu paragraf (maksimal 200 kata) tentang posisi proyek saat ini: apa yang sudah berjalan, apa yang tertinggal, dan apa fokus berikutnya. Tambahkan status keseluruhan: **Hijau** (sesuai atau lebih cepat dari rencana), **Kuning** (ada keterlambatan yang masih dapat dikejar), atau **Merah** (butuh penyesuaian rencana). Tulis bagian ini terakhir agar mencerminkan isi laporan.*

**Contoh:** "Status: Kuning. Hingga Minggu 8, modul pengajuan peminjaman dan verifikasi staf sudah berjalan dan terhubung ke basis data dengan data uji. Modul laporan pemakaian belum dimulai karena perubahan skema pada Minggu 6 menyita waktu. Pada iterasi kedua tim memprioritaskan laporan bulanan dan peran kedua (Admin), serta menunda fitur notifikasi yang memang di luar lingkup."

_(Isi bagian ini di sini.)_

---

## 3. Rencana dan Realisasi

### 3.1 Kemajuan Rincian Pekerjaan

*Salin rincian pekerjaan (WBS) dari proposal, lalu isi persentase penyelesaian dan status (Selesai, Berjalan, Belum). Persentase dihitung dari tugas rinci yang benar-benar selesai dan dapat dibuktikan, bukan perkiraan optimis.*

**Contoh:**

| Bagian Besar | Tugas Rinci | Penanggung Jawab | Status | Selesai |
|---|---|---|---|---|
| 1. Modul Peminjaman | 1.1.1 Rancang ERD | Ahmad | Selesai | 100% |
| | 1.1.2 Implementasi skema dan migrasi | Ahmad | Selesai | 100% |
| | 1.2.2 Implementasi form pengajuan | Budi | Berjalan | 70% |
| 2. Modul Laporan | 2.1.1 Query rekap pemakaian bulanan | Citra | Belum | 0% |

_(Isi bagian ini di sini.)_

### 3.2 Jadwal Rencana dan Aktual

*Bandingkan jadwal pada proposal dengan yang benar-benar terjadi. Jelaskan setiap deviasi dan penyebabnya secara jujur; deviasi yang dijelaskan baik tidak dihukum.*

**Contoh:**

| Minggu | Rencana | Aktual | Deviasi dan Alasan |
|---|---|---|---|
| 5-6 | Skema basis data final | Final pada Minggu 7 | Revisi relasi Peminjaman-Alat setelah masukan dosen |
| 7-8 | Fitur inti peminjaman | Pengajuan selesai, verifikasi 70% | Terdampak keterlambatan skema |

_(Isi bagian ini di sini.)_

---

## 4. Capaian Produk

### 4.1 Status Fitur

*Daftarkan fitur dari proposal beserta statusnya: selesai, sebagian, atau belum. Tuliskan apa yang sudah bisa didemokan pada Minggu 8.*

**Contoh:**

| Fitur | Status | Catatan |
|---|---|---|
| Pengajuan peminjaman | Selesai | Bisa didemokan |
| Verifikasi oleh staf | Sebagian | Tombol setujui berfungsi, tolak belum |
| Laporan pemakaian bulanan | Belum | Direncanakan Minggu 10 |

_(Isi bagian ini di sini.)_

### 4.2 Checklist Target Milestone 1

*Centang target sesuai jalur tim Anda (lihat SOP Bagian 6) dan beri catatan singkat untuk yang belum tercapai.*

- TI Sem 3: [ ] CRUD entitas utama berjalan · [ ] terintegrasi basis data · [ ] data uji terisi · [ ] kemajuan terlacak terhadap WBS
- TI Sem 5: [ ] model ML baseline terlatih · [ ] akurasi awal terdokumentasi · [ ] aplikasi mobile berjalan · [ ] integrasi awal model-aplikasi · [ ] QA plan diperbarui
- SIB Sem 3: [ ] prototipe/wireframe sebagai acuan · [ ] alur bisnis utama mulai berjalan · [ ] CRUD entitas domain bisnis sebagian berfungsi · [ ] UI konsisten
- SIB Sem 5: [ ] arsitektur web berjalan (API/autentikasi) · [ ] fitur multi-peran mulai berfungsi · [ ] rencana pengujian awal · [ ] jadwal, risiko, perubahan terdokumentasi

_(Isi bagian ini di sini.)_

### 4.3 Hasil Model Baseline **[TI Sem 5]**

*Jelaskan dataset, model baseline, metrik (akurasi, precision, recall), dan hasil awalnya. Sebutkan juga rencana perbaikan model.*

**Contoh:** "Model klasifikasi gambar baseline (CNN sederhana) pada 2.000 data latih menghasilkan akurasi 78%, precision 0,76, recall 0,74. Perbaikan direncanakan lewat augmentasi data dan transfer learning."

_(Isi bagian ini di sini.)_

### 4.4 Status Rencana Pengujian **[Sem 5]**

*Ringkas kondisi QA plan atau rencana pengujian: ruang lingkup, jumlah test case yang sudah disusun, dan yang sudah dieksekusi (bila ada).*

**Contoh:** "QA plan versi 2: 18 test case fungsional disusun, 6 sudah dieksekusi dengan 2 bug tercatat dan 1 sudah diperbaiki."

_(Isi bagian ini di sini.)_

### 4.5 Prototipe dan Antarmuka **[SIB]**

*Tunjukkan kesesuaian antarmuka yang dibangun dengan prototipe atau wireframe, dan catat bagian yang berbeda beserta alasannya.*

_(Isi bagian ini di sini.)_

---

## 5. Bukti Kemajuan

*Cantumkan tautan yang dapat diakses dosen pengampu: repositori Git (dengan riwayat commit seluruh anggota), tautan demo atau video singkat, tangkapan layar fitur yang berjalan, dan URL aplikasi bila sudah di-deploy. Tautan yang tidak dapat dibuka dianggap tidak ada.*

**Contoh:**

| Jenis Bukti | Tautan/Keterangan |
|---|---|
| Repositori Git | _(URL repositori)_ |
| Video demo (maks. 3 menit) | _(URL video)_ |
| Aplikasi ter-deploy | _(URL aplikasi)_ |
| Tangkapan layar | Lampiran A |

_(Isi bagian ini di sini.)_

---

## 6. Kontribusi Individu

*Catat apa yang dikerjakan setiap anggota sampai Minggu 8, beserta bukti yang dapat ditelusuri (commit, berkas dokumen, tugas pada WBS). Bagian ini menjadi rujukan dosen untuk menilai kontribusi individu dan sebaiknya disepakati bersama seluruh anggota.*

**Contoh:**

| Nama | Tugas Selesai | Bukti | Estimasi Kontribusi |
|---|---|---|---|
| Ahmad Fauzi | Skema basis data, API pengajuan | 34 commit, berkas migrasi | 30% |
| Budi Santoso | Wireframe, form pengajuan | 21 commit, Figma | 25% |
| Citra Ayu | Logbook, dokumentasi, data uji | Logbook Mg 1-8 | 20% |
| Dewi Lestari | Test case fungsional awal | Dokumen test case | 25% |

_(Isi bagian ini di sini.)_

---

## 7. Kendala dan Solusi

*Uraikan kendala utama (teknis, waktu, koordinasi tim, data/mitra) beserta cara tim mengatasinya atau rencana mengatasinya. Tuliskan juga bantuan yang dibutuhkan dari dosen pengampu atau koordinator.*

**Contoh:**

| Kendala | Dampak | Solusi/Rencana | Bantuan Dibutuhkan |
|---|---|---|---|
| Relasi Peminjaman-Alat berubah | Skema dibuat ulang, lambat 1 minggu | Perubahan dikunci setelah review dosen BDL | Konsultasi normalisasi |

_(Isi bagian ini di sini.)_

---

## 8. Perubahan Lingkup dan Risiko

### 8.1 Perubahan dari Proposal

*Sebutkan perubahan judul, fitur, teknologi, atau peran sejak proposal disetujui, alasannya, dan apakah sudah dikonsultasikan dengan dosen pengampu.*

**Contoh:** "Fitur ekspor PDF laporan ditambahkan atas permintaan staf Tata Usaha; fitur pelacakan kondisi alat ditunda ke luar lingkup. Keduanya sudah disetujui dosen SIM."

_(Isi bagian ini di sini.)_

### 8.2 Risiko Utama

*Daftar maksimal 5 risiko terbesar untuk iterasi berikutnya, disertai tingkat (Tinggi/Sedang/Rendah) dan tindakan pencegahannya.*

**Contoh:**

| Risiko | Tingkat | Tindakan |
|---|---|---|
| Modul laporan belum dimulai | Tinggi | Mulai Minggu 9, prioritaskan satu laporan |
| Data uji kurang realistis | Sedang | Minta contoh data ke Tata Usaha |

_(Isi bagian ini di sini.)_

---

## 9. Rencana Menuju Milestone 2 (Minggu 9-12)

*Susun target dan penanggung jawab per minggu hingga Milestone 2, yaitu produk fungsional lengkap dan hasil uji awal. Rencana harus realistis terhadap kemajuan sebenarnya pada Bagian 3.*

**Contoh:**

| Minggu | Target | Penanggung Jawab |
|---|---|---|
| 9 | Selesaikan verifikasi staf; mulai peran Admin | Ahmad, Budi |
| 10 | Modul laporan pemakaian bulanan | Citra, Ahmad |
| 11 | Integrasi dan pengujian fungsional mandiri | Dewi |
| 12 | Demo produk fungsional dan draf laporan pengujian | Seluruh tim |

_(Isi bagian ini di sini.)_

---

## 10. Rekap Logbook Minggu 1-8

*Ringkas logbook mingguan dalam satu tabel (pekerjaan selesai, kendala, rencana berikutnya). Logbook lengkap dilampirkan pada Lampiran B.*

**Contoh:**

| Minggu | Pekerjaan Selesai | Kendala | Rencana Berikutnya |
|---|---|---|---|
| 1 | Pembentukan tim, brainstorming masalah | Belum ada mitra | Wawancara calon pengguna |
| 2 | Wawancara 3 narasumber | Jadwal bentrok | Tetapkan ide produk |

_(Isi bagian ini di sini.)_

---

## 11. Deklarasi Penggunaan AI

*Sebutkan bagian apa yang dibantu AI (kode, desain, dokumentasi, dll.), alat yang dipakai, dan untuk tujuan apa. Seluruh anggota harus memahami dan mampu menjelaskan hasil yang dibantu AI.*

**Contoh:**

| Bagian | Alat | Tujuan |
|---|---|---|
| Query laporan | Asisten kode | Saran optimasi; telah ditinjau dan diuji tim |
| Logbook | Asisten penulisan | Merapikan kalimat |

_(Isi bagian ini di sini.)_

---

## 12. Lampiran

*Lampiran A: tangkapan layar fitur. Lampiran B: logbook mingguan lengkap Minggu 1-8. Lampiran C (opsional): dokumen pendukung seperti catatan konsultasi dengan dosen atau mitra.*

_(Lampirkan dokumen pendukung di sini.)_
