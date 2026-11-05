# Laporan Milestone 2 PBL

> ⚠️ **PENTING: Dokumen ini hanya menjelaskan struktur laporan, bukan template untuk disalin.**
>
> Susun laporan tim dalam dokumen sendiri dengan format dan gaya penulisan tim. Ikuti urutan dan isi bagian, tetapi **jangan menyalin** gaya dokumen ini, paragraf panduan (cetak miring), contoh SIMPAN, maupun teks penanda bagian. Laporan yang hanya berisi salinan dokumen ini dianggap belum memenuhi ketentuan.

Dokumen ini menjelaskan struktur laporan *Project-Based Learning* (PBL) yang dikumpulkan pada Milestone 2 (Minggu 12). Laporan terdiri atas **Lembar Status Milestone 2 (Bagian A, ringkasan kondisi tim dan produk)** dan **Draf Laporan Akhir (Bagian B)**. Isinya bisa dipakai lagi untuk laporan akhir, jadi tidak ada laporan kemajuan yang terpisah.

Pada Milestone 2, **alur utama produk sudah berjalan dan bisa didemokan**. Fitur lain boleh belum selesai, asalkan sudah masuk rencana Minggu 13–16 (lihat SOP Bagian 15).

## Cara membaca dokumen ini

- Setiap bagian memuat paragraf panduan (cetak miring) dan contoh singkat. Keduanya hanya untuk dipahami dan tidak ikut ditulis di laporan.
- Contoh mengacu pada produk ilustrasi "SIMPAN" (sistem peminjaman ruang dan alat kampus), sama dengan format proposal dan Laporan Kemajuan.
- Bagian bertanda **[TI Sem 3]**, **[TI Sem 5]**, **[Sem 5]**, atau **[SIB]** hanya ditulis oleh tim pada program studi dan semester tersebut. Bagian tanpa tanda ditulis semua tim.
- **Bagian bertanda "pilih satu"** memuat beberapa pilihan yang sama-sama diterima. Pilih yang paling sesuai dengan kondisi tim, tanpa pengurangan nilai (lihat SOP Bagian 10).
- Tidak ada dokumen tambahan mata kuliah jika tidak diumumkan. Bila ada dokumen yang sudah diumumkan dosen secara tertulis, ikuti SOP Bagian 7 (Lampiran D).
- Prosedur pengumpulan dijelaskan pada dokumen SOP Pengumpulan Laporan Milestone 2 PBL.

---

## Gambaran Umum Struktur

Laporan terdiri atas sampul, Bagian A, Bagian B, dan lampiran, yang seluruhnya digabung dalam satu berkas PDF.

### Pertanyaan yang dijawab laporan

- **Di mana posisi produk sekarang, dan apa Status Milestone 2-nya?** Dijawab oleh Bagian A.2, A.4, dan A.5.
- **Siapa mengerjakan apa?** Dijawab oleh Bagian A.6 dan Lampiran C.
- **Apa yang dibangun dan bagaimana mutunya?** Dijawab oleh Bagian B.
- **Apa langkah berikutnya?** Dijawab oleh Bagian A.8.

### Ringkasan bagian

| Bagian | Isi yang dituliskan | Bentuk | Berlaku untuk |
|---|---|---|---|
| Sampul | Judul laporan, judul produk, identitas tim, logo dan institusi, bulan dan tahun | Halaman penuh, tanpa nomor | Semua tim |
| **A. Lembar Status Milestone 2** | | | |
| A.1 Peran dan dosen | Peran terkini tiap anggota dan dosen pengampu | Tabel | Semua tim; ditulis bila ada perubahan dari Milestone 1 |
| A.2 Status Milestone 2 | Status Lengkap, Sebagian, atau Kritis, maksimal 200 kata | Satu paragraf | Semua tim; ditulis paling akhir |
| A.3 Tindak lanjut Milestone 1 | Umpan balik Milestone 1 dan tindak lanjutnya | Tabel | Semua tim |
| A.4 Capaian produk | Status fitur dan daftar periksa target program studi dan semester | Tabel | Semua tim; daftar periksa sesuai program studi dan semester |
| A.5 Bukti | Bentuk demo, cara *deploy*, repositori, masukan pengguna | Tabel tautan | Semua tim; "pilih satu" |
| A.6 Kontribusi individu | Tugas, bukti, dan estimasi Minggu 9–12 | Tabel | Semua tim |
| A.7 Risiko dan perubahan cakupan fitur | Perubahan dari proposal dan risiko | Uraian dan tabel | Semua tim |
| A.8 Rencana Minggu 13–16 | Target dan penanggung jawab | Tabel | Semua tim |
| A.9 Rekap logbook Minggu 9–12 | Pekerjaan, kendala, rencana | Tabel | Semua tim |
| A.10 Deklarasi AI | Bagian yang dibantu AI | Tabel | Semua tim |
| **B. Draf Laporan Akhir** | | | |
| Bab 1 Pendahuluan | Latar belakang, tujuan, cakupan fitur, manfaat | Uraian | Semua tim |
| Bab 2 Analisis Kebutuhan dan Perancangan | Kebutuhan, susunan komponen sistem, rancangan basis data, rancangan tampilan | Uraian dan diagram | Semua tim; 2.4 **[TI Sem 5]**, 2.5 **[SIB]** |
| Bab 3 Implementasi | Teknologi, cara membuat tiap fitur, basis data, penyambungan antar bagian | Uraian dan potongan kode | Semua tim; 3.4 **[TI Sem 5]** |
| Bab 4 Pengujian dan Evaluasi (awal) | Rencana uji, kasus uji (minimal 10), hasil, bug | Tabel dan uraian | Semua tim; 4.4 **[TI Sem 5]** |
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

Kembangkan Bab 1–3 dari proposal lebih dahulu, lalu Bab 4 dari hasil uji, kemudian Bagian A, dan tulis A.2 (Status Milestone 2) paling akhir.

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

### A.2 Status Milestone 2

*Tulis satu paragraf (maksimal 200 kata) tentang posisi produk. Pilih status yang menurut tim paling sesuai: **Lengkap** (alur utama berjalan dengan baik dan semua dokumen wajib sudah ada), **Sebagian** (alur utama berjalan tetapi sering gagal, atau ada dokumen wajib yang belum ada), atau **Kritis** (alur utama belum berjalan atau tim sulit bekerja sama). Menulis status "Sebagian" atau "Kritis" dengan jujur tidak dikenai sanksi dan membantu tim mendapat dukungan (SOP Bagian 12). Tulis bagian ini paling akhir.*

**Contoh:** "Status: Lengkap. Alur utama, yaitu mengajukan peminjaman sampai disetujui staf, sudah berjalan dan tersambung ke basis data. Modul laporan bulanan baru 60% dan belum bisa didemokan, tetapi sudah masuk rencana Minggu 13. Dari 12 kasus uji, 10 lulus dan 2 gagal. Keduanya masuk daftar bug."

_(Bagian ini ditulis di laporan tim.)_

### A.3 Tindak Lanjut Milestone 1

*Daftarkan umpan balik dosen pada Milestone 1 beserta tindak lanjutnya. Bila tidak ada umpan balik tertulis, tuliskan catatan konsultasi yang relevan.*

| Umpan balik Milestone 1 | Dari mata kuliah | Tindak lanjut | Status |
|---|---|---|---|
| Hubungan tabel Peminjaman dan Alat perlu diperbaiki | Basis Data Lanjut | Struktur tabel diperbaiki dan dikunci pada Minggu 9 | Selesai |

_(Bagian ini ditulis di laporan tim.)_

### A.4 Capaian Produk

*Daftarkan fitur dari proposal beserta statusnya (selesai, sebagian, belum). Lalu centang target untuk program studi dan semester tim, dan beri catatan singkat untuk yang belum tercapai. Fitur yang belum selesai tidak apa-apa, asalkan masuk rencana Minggu 13–16.*

**Contoh status fitur:**

| Fitur | Status | Catatan |
|---|---|---|
| Pengajuan peminjaman | Selesai | Bisa didemokan |
| Laporan pemakaian bulanan | Sebagian | Kueri selesai, tampilan belum |

**Daftar periksa target Milestone 2 (SOP Bagian 15):**

- **[TI Sem 3]:** [ ] alur utama aplikasi web berjalan dari awal sampai akhir · [ ] tersambung ke basis data · [ ] minimal 2 peran pengguna bisa login · [ ] laporan atau dasbor sudah direncanakan · [ ] draf Bab 1–3 · [ ] Bab 4 dengan minimal 10 kasus uji
- **[TI Sem 5]:** [ ] alur utama aplikasi *mobile* berjalan · [ ] model ML bisa dipanggil dari aplikasi · [ ] hasil awal model tertulis · [ ] draf Bab 1–3 · [ ] Bab 4 dengan minimal 10 kasus uji
- **[SIB Sem 3]:** [ ] satu alur bisnis utama berjalan dari awal sampai akhir · [ ] tampilan mengikuti prototipe · [ ] draf Bab 1–3 · [ ] Bab 4 dengan minimal 10 kasus uji
- **[SIB Sem 5]:** [ ] alur utama web berjalan dengan login · [ ] minimal 2 peran pengguna · [ ] jadwal dan risiko proyek dicatat · [ ] draf Bab 1–3 · [ ] Bab 4 dengan minimal 10 kasus uji

_(Bagian ini ditulis di laporan tim.)_

### A.5 Bukti

*Pilih satu pada setiap baris dan jelaskan secara singkat. Seluruh pilihan diterima tanpa pengurangan nilai (SOP Bagian 10).*

| Aspek | Pilih satu | Tautan atau keterangan |
|---|---|---|
| Bentuk demo | Langsung / video (maks. 5 menit) / gabungan | _(URL video bila ada)_ |
| Cara *deploy* | Server kampus / hosting gratis atau milik sendiri / lokal dengan video / berkas instalasi (APK) | _(URL aplikasi atau berkas)_ |
| Repositori | Git dengan *tag* `milestone-2` | _(URL *tag*)_ |
| Masukan pengguna | Mitra / calon pengguna (min. 3 orang) / pengguna pengganti (jelaskan alasan) | _(ringkasan masukan)_ |
| Bukti pengujian | Uji manual (minimal 10 kasus uji) / uji otomatis / uji coba oleh pengguna / uji kebenaran data / hasil awal model / laporan uji awal | Bab 4 |

_(Bagian ini ditulis di laporan tim.)_

### A.6 Kontribusi Individu

*Catat pekerjaan setiap anggota pada Minggu 9–12 beserta bukti yang bisa dicek (*commit*, berkas, tugas pada rincian pekerjaan atau WBS). Tabel ini harus sama dengan cek kontribusi tengah (Lampiran C). Anggota yang tidak aktif ditulis apa adanya beserta buktinya.*

**Contoh:**

| Nama | Tugas selesai (Minggu 9–12) | Bukti | Estimasi kontribusi |
|---|---|---|---|
| Ahmad Fauzi | Modul verifikasi dan Admin | 28 *commit* | 30% |
| Budi Santoso | Formulir dan antarmuka laporan | 19 *commit*, berkas Figma | 25% |

_(Bagian ini ditulis di laporan tim.)_

### A.7 Risiko dan Perubahan Cakupan Fitur

*Tulis perubahan dari proposal atau Milestone 1 (fitur, teknologi, peran), alasannya, dan apakah sudah dikonsultasikan dengan dosen terkait. Tulis maksimal 5 risiko terbesar untuk Minggu 13–16, beserta tingkat risiko dan tindakannya. Jika mitra tidak bisa dihubungi lagi, jelaskan dan gunakan pilihan pengguna pengganti.*

| Risiko | Tingkat | Tindakan |
|---|---|---|
| Modul laporan belum selesai | Tinggi | Selesaikan Minggu 13; prioritaskan satu laporan |

_(Bagian ini ditulis di laporan tim.)_

### A.8 Rencana Minggu 13–16

*Susun target dan penanggung jawab per minggu sampai Demo Day. Masukkan fitur yang belum selesai. Tim berstatus Sebagian atau Kritis juga menulis rencana perbaikan di sini (SOP Bagian 12).*

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

*Tulis latar belakang masalah, tujuan, cakupan fitur, manfaat, dan susunan laporan. Sebagian besar isi bisa diambil dari proposal, lalu diperbarui sesuai perubahan cakupan fitur (A.7).*

_(Bagian ini ditulis di laporan tim.)_

## Bab 2. Analisis Kebutuhan dan Perancangan

*Dinilai terutama oleh mata kuliah basis data, UI/UX, dan sistem informasi (SOP Bagian 6).*

- **2.1 Kebutuhan pengguna dan daftar fitur:** peran pengguna dan apa yang bisa dilakukan tiap peran.
- **2.2 Susunan komponen sistem:** bagian-bagian sistem dan teknologinya, beserta alasan memilihnya.
- **2.3 Rancangan basis data:** diagram basis data (ERD) dan struktur tabel terbaru.
- **2.4 Rancangan model ML [TI Sem 5]:** data yang dipakai, cara menyiapkan data, jenis model, dan ukuran hasil yang ditargetkan (misalnya akurasi).
- **2.5 Prototipe dan rancangan tampilan [SIB]:** *wireframe* atau prototipe, dan alasan setiap perbedaannya dengan hasil akhir.
- **2.6 Rancangan laporan atau dasbor**, jika produk memilikinya.

_(Bagian ini ditulis di laporan tim.)_

## Bab 3. Implementasi

*Dinilai terutama oleh mata kuliah pemrograman (SOP Bagian 6). Tulis dalam bentuk uraian, dengan potongan kode atau tangkapan layar yang penting saja, bukan seluruh kode. Cukup tulis bagian yang sudah dibuat.*

- **3.1 Teknologi yang dipakai:** versi, *framework*, dan alat bantu.
- **3.2 Cara membuat tiap fitur:** alur, struktur, dan potongan kode penting.
- **3.3 Basis data:** struktur tabel, kueri penting, dan data uji.
- **3.4 Model dan cara memasangnya ke aplikasi [TI Sem 5]:** pelatihan model, penyimpanan model, dan cara aplikasi memanggilnya.
- **3.5 Penyambungan antar bagian dan *deploy*:** sesuai pilihan pada A.5.

_(Bagian ini ditulis di laporan tim.)_

## Bab 4. Pengujian dan Evaluasi (Hasil Awal)

*Dinilai terutama oleh mata kuliah penjaminan mutu (SOP Bagian 6). Pilih jenis pengujian yang sesuai (SOP Bagian 10.3) dan tulis hasilnya apa adanya, termasuk bug yang belum diperbaiki. Tulis minimal 10 kasus uji untuk alur utama.*

- **4.1 Rencana pengujian:** apa yang diuji, jenis uji, dan alat atau perangkat yang dipakai.
- **4.2 Kasus uji dan hasil:** tabel di bawah, minimal 10 kasus uji.
- **4.3 Bug yang ditemukan:** seberapa parah, statusnya, dan rencana perbaikan.
- **4.4 Hasil awal model [TI Sem 5]:** data yang dipakai, ukuran hasil model (misalnya akurasi), hasil awal, dan rencana perbaikan.
- **4.5 Masukan pengguna:** ringkasan masukan dari mitra, calon pengguna, atau pengguna pengganti.

**Contoh (4.2):**

| ID | Skenario | Langkah singkat | Hasil diharapkan | Hasil aktual | Status |
|---|---|---|---|---|---|
| TC-01 | Pengajuan peminjaman | Isi formulir dan kirim | Pengajuan tersimpan | Tersimpan | Lulus |
| TC-07 | Verifikasi tolak | Staf menolak pengajuan | Status berubah | Error 500 | Gagal (BUG-03) |

_(Bagian ini ditulis di laporan tim.)_

---

# Lampiran

*Lampiran A: tangkapan layar fitur yang berjalan. Lampiran B: logbook mingguan lengkap Minggu 9–12. Lampiran D hanya ada bila dosen sudah mengumumkan dokumen tambahan secara tertulis sebelum tanggal terbit SOP (SOP Bagian 7); jika tidak, tuliskan "Tidak ada dokumen tambahan". Lampiran E: daftar seluruh tautan eksternal yang ditanam di dalam laporan, yang harus dapat diklik, dapat dibuka tanpa login, sudah diuji di mode *incognito*, dan tidak diubah setelah batas akhir.*

## Lampiran C. Cek Kontribusi Tengah

*Setiap anggota memeriksa tabel kontribusi pada A.6 dan menyatakan persetujuannya. Anggota yang keberatan dapat menghubungi koordinator PBL langsung (dhanifudin@polinema.ac.id) tanpa perlu menuliskannya di laporan. Lampiran ini singkat. Gunanya agar ketimpangan kontribusi diketahui lebih awal, bukan untuk menghukum.*

| Nama | Persentase menurut A.6 | Pernyataan | Catatan (opsional) |
|---|---|---|---|
| Ahmad Fauzi | 30% | Setuju / Ada keberatan | |
| Budi Santoso | 25% | Setuju / Ada keberatan | |

_(Lampiran disertakan di laporan tim.)_

**Contoh (Lampiran E):**

| No | Keterangan | Bagian | Tautan | Jenis akses |
|---|---|---|---|---|
| 1 | Repositori (tag milestone-2) | A.5 | _(URL tag Git)_ | Publik |
| 2 | Video demo | A.5 | _(URL video)_ | Siapa saja yang memiliki link |

---

> ⚠️ **Ingat:** yang dikumpulkan adalah laporan tim dengan struktur di atas, bukan salinan dokumen ini.
