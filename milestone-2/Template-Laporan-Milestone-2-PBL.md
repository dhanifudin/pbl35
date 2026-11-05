# Laporan Milestone 2 PBL

> ⚠️ **PENTING: Dokumen ini hanya menjelaskan struktur laporan, bukan template untuk disalin.**
>
> Susun laporan tim dalam dokumen sendiri dengan format dan gaya penulisan tim. Ikuti urutan dan isi bagian, tetapi **jangan menyalin** gaya dokumen ini, paragraf panduan (cetak miring), contoh SIMPAN, maupun teks penanda bagian. Laporan yang hanya berisi salinan dokumen ini dianggap belum memenuhi ketentuan.

Dokumen ini menjelaskan struktur paket luaran *Project-Based Learning* (PBL) yang dikumpulkan pada Milestone 2 (Minggu 12). Paket terdiri atas **Lembar Status Milestone 2 (Bagian A)** dan **Draf Laporan Akhir (Bagian B)**, sehingga isinya dapat dipakai ulang pada laporan akhir dan tidak ada laporan kemajuan yang terpisah.

## Cara membaca dokumen ini

- Setiap bagian memuat paragraf panduan (cetak miring) dan contoh singkat. Keduanya hanya untuk dipahami dan tidak ikut ditulis di laporan.
- Contoh mengacu pada produk ilustrasi "SIMPAN" (sistem peminjaman ruang dan alat kampus), sama dengan format proposal dan Laporan Kemajuan.
- Bagian bertanda **[TI Sem 3]**, **[TI Sem 5]**, **[Sem 5]**, atau **[SIB]** hanya ditulis oleh tim pada jalur tersebut. Bagian tanpa tanda ditulis semua tim.
- **Bagian bertanda "pilih satu"** memuat beberapa pilihan yang sama-sama diterima. Pilih yang paling sesuai dengan kondisi tim, tanpa pengurangan nilai (lihat SOP Bagian 10).
- Tidak ada dokumen tambahan mata kuliah secara bawaan. Bila ada dokumen yang sudah diumumkan dosen secara tertulis, ikuti SOP Bagian 7 (Lampiran D).
- Prosedur pengumpulan dijelaskan pada dokumen SOP Pengumpulan Luaran Milestone 2 PBL.

---

## Gambaran Umum Struktur

Paket terdiri atas sampul, Bagian A, Bagian B, dan lampiran, yang seluruhnya digabung dalam satu berkas PDF.

### Pertanyaan yang dijawab paket

- **Di mana posisi produk sekarang, dan lolos gerbang?** Dijawab oleh Bagian A.2, A.4, dan A.5.
- **Siapa mengerjakan apa?** Dijawab oleh Bagian A.6 dan Lampiran C.
- **Apa yang dibangun dan bagaimana mutunya?** Dijawab oleh Bagian B.
- **Apa langkah berikutnya?** Dijawab oleh Bagian A.8.

### Ringkasan bagian

| Bagian | Isi yang dituliskan | Bentuk | Berlaku untuk |
|---|---|---|---|
| Sampul | Judul laporan, judul produk, identitas tim, logo dan institusi, bulan dan tahun | Halaman penuh, tanpa nomor | Semua tim |
| **A. Lembar Status Milestone 2** | | | |
| A.1 Peran dan dosen | Peran terkini tiap anggota dan dosen pengampu | Tabel | Semua tim; ditulis bila ada perubahan dari Milestone 1 |
| A.2 Status dan keputusan gerbang | Status Lengkap, Sebagian, atau Kritis, maksimal 200 kata | Satu paragraf | Semua tim; ditulis paling akhir |
| A.3 Tindak lanjut Milestone 1 | Umpan balik Milestone 1 dan tindak lanjutnya | Tabel | Semua tim |
| A.4 Capaian produk | Status fitur dan daftar periksa target jalur | Tabel | Semua tim; daftar periksa sesuai jalur |
| A.5 Bukti | Bentuk demonstrasi, cara *deploy*, repositori, validasi pengguna | Tabel tautan | Semua tim; "pilih satu" |
| A.6 Kontribusi individu | Tugas, bukti, dan estimasi Minggu 9–12 | Tabel | Semua tim |
| A.7 Risiko dan perubahan lingkup | Perubahan dari proposal dan risiko | Uraian dan tabel | Semua tim |
| A.8 Rencana Minggu 13–16 | Target dan penanggung jawab | Tabel | Semua tim |
| A.9 Rekap logbook Minggu 9–12 | Pekerjaan, kendala, rencana | Tabel | Semua tim |
| A.10 Deklarasi AI | Bagian yang dibantu AI | Tabel | Semua tim |
| **B. Draf Laporan Akhir** | | | |
| Bab 1 Pendahuluan | Latar belakang, tujuan, lingkup, manfaat | Uraian | Semua tim |
| Bab 2 Analisis Kebutuhan dan Perancangan | Kebutuhan, arsitektur, basis data, antarmuka | Uraian dan diagram | Semua tim; 2.4 **[TI Sem 5]**, 2.5 **[SIB]** |
| Bab 3 Implementasi | Teknologi, implementasi per modul, integrasi | Uraian dan cuplikan | Semua tim; 3.4 **[TI Sem 5]** |
| Bab 4 Pengujian dan Evaluasi (awal) | Rencana uji, kasus uji, hasil, bug | Tabel dan uraian | Semua tim; 4.4 **[TI Sem 5]** |
| Lampiran | A tangkapan layar; B logbook Minggu 9–12; C cek kontribusi tengah; D dokumen tambahan (bila ada); E daftar tautan | Lampiran | A, B, C, E semua tim; D bila ada |

### Susunan berkas akhir

```
M2_<Kelas>_<NamaTim>.pdf
├── Sampul
├── Bagian A   (Lembar Status Milestone 2, A.1–A.10)
├── Bagian B   (Draf Laporan Akhir, Bab 1–4)
└── Lampiran
    ├── A  Tangkapan layar
    ├── B  Logbook Minggu 9–12
    ├── C  Cek kontribusi tengah
    ├── D  Dokumen tambahan mata kuliah (bila ada)
    └── E  Daftar tautan eksternal
```

### Urutan penulisan yang disarankan

Kembangkan Bab 1–3 dari proposal lebih dahulu, lalu Bab 4 dari hasil uji, kemudian Bagian A, dan tulis A.2 (status dan keputusan gerbang) paling akhir.

---

<div style="page-break-before:always"></div>

## Sampul

Sampul sama dengan Laporan Kemajuan, dengan judul **LAPORAN MILESTONE 2 *PROJECT-BASED LEARNING* (PBL)**. Urutan dari atas ke bawah: judul laporan, judul produk, identitas tim (nama tim; kelas, semester, tahun akademik; tabel anggota dengan nomor, nama, NIM), logo dan institusi, serta bulan dan tahun pengumpulan. Halaman sampul tidak diberi nomor halaman.

---

# Bagian A: Lembar Status Milestone 2

*Bagian A ringkas, sekitar 2–4 halaman isi, dan sebisa mungkin diisi dari bahan yang sudah ada (logbook, proposal, laporan kemajuan). Hindari menulis ulang hal yang sama.*

### A.1 Peran dan Dosen Pengampu

*Tuliskan hanya perubahan peran sejak Milestone 1 dan dosen pengampu per mata kuliah. Bila tidak ada perubahan, tuliskan "Tidak ada perubahan dari Laporan Kemajuan".*

| Nama | Peran saat ini | Perubahan dari Milestone 1 |
|---|---|---|
| Ahmad Fauzi | Ketua Tim & Pengembang Utama | Tidak ada |
| Citra Ayu | Sekretaris/Dokumentator | Menambah tugas penguji sejak Minggu 10 |

_(Bagian ini ditulis di laporan tim.)_

### A.2 Status dan Keputusan Gerbang

*Tuliskan satu paragraf (maksimal 200 kata) tentang posisi produk. Cantumkan status yang menurut tim paling sesuai: **Lengkap** (target jalur tercapai), **Sebagian** (satu atau dua target utama belum, produk berjalan), atau **Kritis** (produk inti belum berjalan atau tim sulit bekerja sama). Jujur menuliskan status "Sebagian" atau "Kritis" tidak dikenai sanksi dan membantu tim mendapat dukungan (SOP Bagian 12). Tulis bagian ini paling akhir.*

**Contoh:** "Status: Sebagian. Modul pengajuan, verifikasi staf, dan peran Admin sudah berjalan dan terhubung ke basis data. Modul laporan bulanan baru 60% karena kueri agregasi diubah setelah uji integritas. Pada Minggu 13, tim menyelesaikan laporan bulanan dan memperbaiki 4 bug berprioritas tinggi dari hasil uji awal."

_(Bagian ini ditulis di laporan tim.)_

### A.3 Tindak Lanjut Milestone 1

*Daftarkan umpan balik dosen pada Milestone 1 beserta tindak lanjutnya. Bila tidak ada umpan balik tertulis, tuliskan catatan konsultasi yang relevan.*

| Umpan balik Milestone 1 | Dari mata kuliah | Tindak lanjut | Status |
|---|---|---|---|
| Normalisasi relasi Peminjaman–Alat | Basis Data Lanjut | Skema direvisi dan dikunci pada Minggu 9 | Selesai |

_(Bagian ini ditulis di laporan tim.)_

### A.4 Capaian Produk

*Daftarkan fitur dari proposal beserta statusnya (selesai, sebagian, belum), lalu centang target jalur dan beri catatan singkat untuk yang belum tercapai.*

**Contoh status fitur:**

| Fitur | Status | Catatan |
|---|---|---|
| Pengajuan peminjaman | Selesai | Dapat didemonstrasikan |
| Laporan pemakaian bulanan | Sebagian | Kueri selesai, tampilan belum |

**Daftar periksa target Milestone 2 (SOP Bagian 15):**

- **[TI Sem 3]:** [ ] produk web fungsional lengkap · [ ] beberapa peran pengguna · [ ] modul laporan atau dasbor · [ ] skema dan kueri basis data lengkap · [ ] hasil uji fungsional awal · [ ] draf Bab 1–3
- **[TI Sem 5]:** [ ] aplikasi *mobile* fungsional lengkap · [ ] model ML terintegrasi · [ ] laporan QA interim · [ ] evaluasi model awal · [ ] draf Bab 1–3
- **[SIB Sem 3]:** [ ] alur bisnis utama tuntas · [ ] CRUD beberapa entitas bisnis · [ ] antarmuka konsisten dan responsif sesuai prototipe · [ ] hasil uji awal · [ ] draf Bab 1–3
- **[SIB Sem 5]:** [ ] arsitektur web matang · [ ] sedikitnya tiga peran atau kompleksitas setara · [ ] kasus uji dieksekusi dan bug ditangani · [ ] pengelolaan proyek terdokumentasi · [ ] dasbor atau analitik dengan data nyata · [ ] draf Bab 1–3

_(Bagian ini ditulis di laporan tim.)_

### A.5 Bukti

*Pilih satu pada setiap baris dan jelaskan secara singkat. Seluruh pilihan diterima tanpa pengurangan nilai (SOP Bagian 10).*

| Aspek | Pilih satu | Tautan atau keterangan |
|---|---|---|
| Bentuk demonstrasi | Langsung / video rekaman (maks. 5 menit) / gabungan | _(URL video bila ada)_ |
| Cara *deploy* | Server kampus / *cloud* gratis atau hosting pribadi / lokal dengan video / berkas instalasi (APK) | _(URL aplikasi atau berkas)_ |
| Repositori | Git dengan *tag* `milestone-2` | _(URL *tag*)_ |
| Validasi pengguna | Mitra / calon pengguna (min. 3 orang) / pengguna pengganti (jelaskan alasan) | _(ringkasan masukan)_ |
| Bukti pengujian | Uji manual / uji otomatis / UAT / uji integritas data / evaluasi model / laporan QA | Bab 4 |

_(Bagian ini ditulis di laporan tim.)_

### A.6 Kontribusi Individu

*Catat pekerjaan setiap anggota pada Minggu 9–12 beserta bukti yang dapat ditelusuri (*commit*, berkas, tugas pada WBS). Tabel ini harus konsisten dengan cek kontribusi tengah (Lampiran C). Anggota yang tidak aktif dicatat apa adanya beserta buktinya.*

**Contoh:**

| Nama | Tugas selesai (Minggu 9–12) | Bukti | Estimasi kontribusi |
|---|---|---|---|
| Ahmad Fauzi | Modul verifikasi dan Admin | 28 *commit* | 30% |
| Budi Santoso | Formulir dan antarmuka laporan | 19 *commit*, berkas Figma | 25% |

_(Bagian ini ditulis di laporan tim.)_

### A.7 Risiko dan Perubahan Lingkup

*Sebutkan perubahan dari proposal atau Milestone 1 (fitur, teknologi, peran), alasannya, dan apakah sudah dikonsultasikan dengan dosen terkait. Daftarkan maksimal 5 risiko terbesar untuk Minggu 13–16 beserta tingkat dan tindakannya. Bila mitra tidak lagi tersedia, jelaskan dan gunakan pilihan pengguna pengganti.*

| Risiko | Tingkat | Tindakan |
|---|---|---|
| Modul laporan belum selesai | Tinggi | Selesaikan Minggu 13; prioritaskan satu laporan |

_(Bagian ini ditulis di laporan tim.)_

### A.8 Rencana Minggu 13–16

*Susun target dan penanggung jawab per minggu hingga Demo Day. Tim berstatus Sebagian atau Kritis menambahkan rencana pemulihan di sini (SOP Bagian 12).*

| Minggu | Target | Penanggung jawab |
|---|---|---|
| 13 | Menyelesaikan modul laporan; perbaiki bug prioritas tinggi | Ahmad, Budi |
| 14 | Pengujian lanjutan dan perbaikan | Dewi |
| 15 | Penyempurnaan Bab 1–4, Bab 5, dan materi demo | Seluruh tim |
| 16 | Demo Day / Expo | Seluruh tim |

_(Bagian ini ditulis di laporan tim.)_

### A.9 Rekap Logbook Minggu 9–12

*Rangkum logbook mingguan dalam satu tabel. Logbook lengkap dilampirkan pada Lampiran B.*

| Minggu | Pekerjaan selesai | Kendala | Rencana berikutnya |
|---|---|---|---|
| 9 | Verifikasi staf selesai | Revisi skema | Mulai peran Admin |

_(Bagian ini ditulis di laporan tim.)_

### A.10 Deklarasi Penggunaan AI

*Sebutkan bagian yang dibantu AI, alat, dan tujuannya. Seluruh anggota harus memahami dan mampu menjelaskan hasil yang dibantu AI.*

| Bagian | Alat | Tujuan |
|---|---|---|
| Kueri laporan | Asisten kode | Saran optimasi; ditinjau dan diuji tim |

_(Bagian ini ditulis di laporan tim.)_

---

# Bagian B: Draf Laporan Akhir

*Bagian B adalah draf laporan akhir. Bab 1–3 dikembangkan dari proposal dan perkembangan produk, dan Bab 4 berisi hasil uji awal. Bab 5 (Penutup) tidak diminta pada Milestone 2. Seluruh isi dipakai ulang pada laporan akhir, sehingga bagian ini tidak ditulis ulang pada tahap akhir.*

## Bab 1. Pendahuluan

*Latar belakang masalah, tujuan, ruang lingkup, manfaat, dan sistematika. Ambil dari proposal dan sesuaikan dengan perubahan lingkup (A.7).*

_(Bagian ini ditulis di laporan tim.)_

## Bab 2. Analisis Kebutuhan dan Perancangan

*Dinilai terutama oleh mata kuliah basis data, UI/UX, dan sistem informasi (SOP Bagian 6).*

- **2.1 Kebutuhan pengguna dan fungsional:** peran pengguna, kebutuhan, dan *use case* atau daftar fitur.
- **2.2 Arsitektur sistem:** komponen dan teknologi beserta alasannya.
- **2.3 Perancangan basis data:** ERD dan skema akhir.
- **2.4 Perancangan model ML [TI Sem 5]:** dataset, praproses, arsitektur model, dan metrik target.
- **2.5 Prototipe dan perancangan antarmuka [SIB]:** *wireframe* atau prototipe dan alasan setiap perbedaan dengan hasil akhir.
- **2.6 Perancangan laporan atau dasbor** bila produk memilikinya.

_(Bagian ini ditulis di laporan tim.)_

## Bab 3. Implementasi

*Dinilai terutama oleh mata kuliah pemrograman (SOP Bagian 6). Uraikan secara naratif disertai cuplikan atau tangkapan layar yang relevan, bukan seluruh kode.*

- **3.1 Lingkungan dan teknologi:** versi, *framework*, dan alat bantu.
- **3.2 Implementasi fitur per modul:** alur, struktur, dan cuplikan kode penting.
- **3.3 Implementasi basis data:** skema, kueri penting, dan data uji.
- **3.4 Implementasi model dan integrasi [TI Sem 5]:** pelatihan, penyimpanan model, dan integrasi ke aplikasi.
- **3.5 Integrasi dan *deploy*:** sesuai pilihan pada A.5.

_(Bagian ini ditulis di laporan tim.)_

## Bab 4. Pengujian dan Evaluasi (Hasil Awal)

*Dinilai terutama oleh mata kuliah penjaminan mutu (SOP Bagian 6). Pilih jenis pengujian yang sesuai (SOP Bagian 10.3) dan laporkan hasil apa adanya, termasuk bug yang belum diperbaiki.*

- **4.1 Rencana pengujian:** ruang lingkup, jenis uji, dan lingkungan.
- **4.2 Kasus uji dan hasil:** tabel di bawah.
- **4.3 Bug yang ditemukan:** tingkat keparahan, status, dan rencana perbaikan.
- **4.4 Evaluasi model [TI Sem 5]:** dataset, metrik (akurasi, *precision*, *recall*), hasil awal, dan rencana perbaikan.
- **4.5 Validasi pengguna:** ringkasan masukan dari mitra, calon pengguna, atau pengguna pengganti.

**Contoh (4.2):**

| ID | Skenario | Langkah singkat | Hasil diharapkan | Hasil aktual | Status |
|---|---|---|---|---|---|
| TC-01 | Pengajuan peminjaman | Isi formulir dan kirim | Pengajuan tersimpan | Tersimpan | Lulus |
| TC-07 | Verifikasi tolak | Staf menolak pengajuan | Status berubah | Error 500 | Gagal (BUG-03) |

_(Bagian ini ditulis di laporan tim.)_

---

# Lampiran

*Lampiran A: tangkapan layar fitur yang berjalan. Lampiran B: logbook mingguan lengkap Minggu 9–12. Lampiran D hanya ada bila dosen sudah mengumumkan dokumen tambahan secara tertulis sebelum tanggal terbit SOP (SOP Bagian 7); jika tidak, tuliskan "Tidak ada dokumen tambahan". Lampiran E: daftar seluruh tautan eksternal yang ditanam di dalam laporan, yang harus dapat diklik, dapat dibuka tanpa login, sudah diuji di jendela penyamaran, dan tidak diubah setelah batas akhir.*

## Lampiran C. Cek Kontribusi Tengah

*Setiap anggota memeriksa tabel kontribusi pada A.6 dan menyatakan persetujuannya. Anggota yang keberatan dapat menghubungi koordinator PBL langsung (dhanifudin@polinema.ac.id) tanpa perlu menuliskannya di laporan. Lampiran ini singkat dan menjadi bahan untuk mendeteksi ketimpangan kontribusi lebih awal, bukan untuk menghukum.*

| Nama | Persentase menurut A.6 | Pernyataan | Catatan (opsional) |
|---|---|---|---|
| Ahmad Fauzi | 30% | Setuju / Ada keberatan | |
| Budi Santoso | 25% | Setuju / Ada keberatan | |

_(Lampiran disertakan di laporan tim.)_

**Contoh (Lampiran E):**

| No | Keterangan | Bagian | Tautan | Jenis akses |
|---|---|---|---|---|
| 1 | Repositori (tag milestone-2) | A.5 | _(URL tag Git)_ | Publik |
| 2 | Video demonstrasi | A.5 | _(URL video)_ | Siapa saja yang memiliki link |

---

> ⚠️ **Ingat:** yang dikumpulkan adalah laporan tim dengan struktur di atas, bukan salinan dokumen ini.
