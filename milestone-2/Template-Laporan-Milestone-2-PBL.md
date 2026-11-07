# Template Laporan Proyek PBL: Tahap Milestone 2

> ⚠️ **PENTING: Ikuti susunannya, tulis isinya dari proyek tim sendiri.**
>
> Susun laporan tim dalam dokumen sendiri. Ikuti urutan bagian, bentuk tabel, dan kedalaman isinya, tetapi isinya harus berasal dari proyek tim. **Jangan menulis** paragraf panduan (cetak miring), contoh SIMPAN, atau label catatan (misalnya "dipindahkan dari proposal") di laporan. Laporan yang hanya menyalin dokumen ini atau Contoh Laporan tidak diterima.
>
> Tata letak, warna, huruf, dan gaya sampul **bebas**. Yang diperiksa hanyalah susunan bagian dan kelengkapan isinya.

Tim hanya menulis **satu laporan** untuk seluruh PBL. Pada Milestone 2 (Minggu 12), laporan itu berisi **Lembar Status** dan **Bab 1–5 yang sudah terisi sebagian**. Pada laporan akhir, tim melengkapi bab yang sama dan menghapus Lembar Status. Tidak ada bagian yang ditulis ulang dari awal.

Pada Milestone 2, **alur utama produk sudah berjalan dan bisa didemokan**. Fitur lain boleh belum selesai, asalkan sudah masuk rencana Minggu 13–16 (lihat SOP Bagian 15).

## Cara membaca dokumen ini

- Template ini menjawab "bagian apa saja dan isinya apa". Aturan ada di SOP. Untuk melihat hasil akhirnya, buka **Contoh Laporan Milestone 2 PBL** yang sesuai dengan program studi dan semester tim. Ada empat contoh (TI Semester 3, TI Semester 5, SIB Semester 3, SIB Semester 5), masing-masing satu laporan lengkap yang sudah terisi.
- Setiap bagian memuat paragraf panduan (cetak miring) dan contoh singkat. Keduanya hanya untuk dipahami dan tidak ikut ditulis di laporan.
- Contoh singkat di template ini memakai produk ilustrasi "SIMPAN" (sistem peminjaman ruang dan alat kampus). Tiap Contoh Laporan memakai produknya sendiri.
- Di samping judul bagian terdapat **label catatan** (lihat tabel di bawah) yang menunjukkan asal isi bagian itu dan apa yang dilakukan pada laporan akhir. Label ini hanya keterangan untuk pembaca dokumen ini dan **tidak ditulis di laporan**.
- Setiap gambar, tabel, dan potongan kode diberi nomor dan judul (tabel di atas, gambar dan kode di bawah), lalu dirujuk di paragraf yang menjelaskannya. Penomoran mengikuti bab, misalnya Tabel 4.2 atau Gambar 2.3, dan lampiran memakai hurufnya, misalnya Tabel F.4. Tabel di Lembar Status tidak perlu bernomor.
- Bagian bertanda **[TI Sem 3]**, **[TI Sem 5]**, **[Sem 3]**, **[Sem 5]**, atau **[SIB]** hanya ditulis oleh tim pada program studi dan semester tersebut. Bagian tanpa tanda ditulis semua tim.
- **Bagian bertanda "pilih satu"** memuat beberapa pilihan yang sama-sama diterima. Pilih yang paling sesuai dengan kondisi tim, tanpa pengurangan nilai (lihat SOP Bagian 10).
- Hal yang dinilai dosen ada di SOP Bagian 16 (rubrik).
- Tidak ada dokumen tambahan mata kuliah jika tidak diumumkan. Bila ada dokumen yang sudah diumumkan dosen secara tertulis, ikuti SOP Bagian 7 (Lampiran D).
- Prosedur pengumpulan dijelaskan pada dokumen SOP Pengumpulan Laporan Milestone 2 PBL.

---

## Satu Laporan, Tiga Tahap

Laporan dimulai dari proposal, bertambah isi pada Milestone 2, dan selesai pada laporan akhir.

### Label catatan

Label berikut hanya keterangan bagi pembaca dokumen ini dan contoh laporan. Tim tidak menuliskannya di laporan.

| Label | Artinya | Pada Milestone 2 | Pada laporan akhir |
|---|---|---|---|
| *dipindahkan dari proposal* | Isinya berasal dari proposal | Gunakan isi proposal, lalu perbarui | Dirapikan |
| *dilanjutkan dari Laporan Kemajuan* | Isinya berasal dari Laporan Kemajuan (Milestone 1) | Gunakan isi lama, lalu perbarui sampai Minggu 12 | Diperbarui sampai Minggu 16 |
| *ditulis pada Milestone 2* | Mulai ditulis pada Milestone 2 | Ditulis | Dilengkapi |
| *ditulis pada laporan akhir* | Baru ditulis pada laporan akhir | Cukup judulnya | Ditulis |
| *dihapus pada laporan akhir* | Hanya untuk Milestone 2 | Ditulis | Dihapus |

### Susunan laporan

```
Laporan Proyek PBL: <Produk>
├── Sampul
├── Lembar Status Milestone 2 (S.1–S.6)   dihapus pada laporan akhir
├── Daftar Isi
├── Bab 1  Pendahuluan
├── Bab 2  Analisis Kebutuhan dan Perancangan
├── Bab 3  Implementasi
├── Bab 4  Pengujian dan Evaluasi
├── Bab 5  Pengelolaan Proyek dan Penutup
└── Lampiran A–H
```

### Dari mana isi laporan berasal

Tabel ini menunjukkan ke bagian mana isi proposal dan Laporan Kemajuan dipindahkan. Tim tidak menulisnya ulang, cukup menggunakan isi lama lalu memperbaruinya.

| Bagian asal | Masuk ke | Yang dilakukan di Milestone 2 | Yang dilakukan di laporan akhir |
|---|---|---|---|
| Proposal 3 (latar belakang, rumusan masalah) | Bab 1.1 | Gunakan isi proposal, lalu sesuaikan dengan perubahan | Dirapikan |
| Proposal 4.1 (tujuan) | Bab 1.2 | Gunakan isi proposal | Dirapikan |
| Proposal 4.2 dan 4.4 (ruang lingkup, asumsi) | Bab 1.3 | Gunakan isi proposal, lalu sesuaikan dengan Bab 5.3 | Disesuaikan dengan hasil akhir |
| Proposal 4.3 (pemangku kepentingan) | Bab 1.4 | Gunakan isi proposal | Dirapikan |
| Proposal 4.5 (kriteria keberhasilan) | Bab 1.5 | Gunakan isi proposal | Dipakai untuk Bab 4.6 |
| Proposal 5 (pengguna, fitur) | Bab 2.1 | Gunakan isi proposal, lalu perbarui daftar fitur | Dirapikan |
| Proposal 6.1 (basis data awal) | Bab 2.3 | Perbarui dengan struktur terbaru | Diperbarui bila berubah |
| Proposal 6.2 (antarmuka awal) | Bab 2.5 | Ganti dengan tampilan yang sudah jadi | Dirapikan |
| Proposal 7 (rincian pekerjaan, jadwal) | Bab 5.1 | Tambahkan kolom realisasi | Lengkapi sampai Minggu 16 |
| Laporan Kemajuan 3 dan 9 (rencana dan realisasi) | Bab 5.1 | Diperbarui sampai Minggu 12 | Diperbarui sampai Minggu 16 |
| Laporan Kemajuan 6 (kontribusi) | Bab 5.2 | Diperbarui untuk Minggu 9–12 | Diperbarui sampai Minggu 16 |
| Laporan Kemajuan 7 dan 8 (kendala, risiko, perubahan) | Bab 5.3 | Diperbarui | Diperbarui |
| Laporan Kemajuan 4 dan 5 (capaian, bukti) | Lembar Status S.4 dan S.5 | Diperbarui | Dihapus |
| Laporan Kemajuan 10 (logbook) | Lampiran B | Tambahkan Minggu 9–12 | Tambahkan Minggu 13–16 |
| Laporan Kemajuan 11 (deklarasi AI) | Lampiran H | Diperbarui | Diperbarui |

### Pertanyaan yang dijawab laporan

- **Di mana posisi produk sekarang, dan apa Status Milestone 2-nya?** Dijawab oleh Lembar Status (S.2, S.4, S.5).
- **Apa yang dibangun dan bagaimana mutunya?** Dijawab oleh Bab 1–4.
- **Siapa mengerjakan apa?** Dijawab oleh Bab 5.2. Kebenarannya diperiksa lewat form Penilaian 360 yang terpisah dari laporan (SOP Bagian 9.3).
- **Apa yang berubah, apa risikonya, dan siapa dosen rujukannya?** Dijawab oleh S.1 dan Bab 5.3.
- **Apa langkah berikutnya?** Dijawab oleh S.6 dan Bab 5.1.
- **Model dan kueri apa yang dipakai, dan bagaimana mengujinya?** Dijawab oleh Lampiran F dan G.

### Ringkasan bagian

| Bagian | Isi yang dituliskan | Label catatan | Berlaku untuk |
|---|---|---|---|
| Sampul | Judul laporan, judul produk, identitas tim, logo, bulan dan tahun | dilanjutkan dari Laporan Kemajuan | Semua tim |
| **Lembar Status Milestone 2** | 1–2 halaman | dihapus pada laporan akhir | |
| S.1 Identitas dan dosen | Peran, dosen pengampu, dosen rujukan | dihapus | Semua tim |
| S.2 Status Milestone 2 | Lengkap, Sebagian, atau Kritis, maksimal 150 kata | dihapus | Semua tim; ditulis paling akhir |
| S.3 Tindak lanjut Milestone 1 | Umpan balik dan tindak lanjutnya | dihapus | Semua tim |
| S.4 Capaian produk | Status fitur dan daftar periksa target | dihapus | Semua tim; daftar periksa sesuai program studi dan semester |
| S.5 Bukti | Bentuk demo, cara *deploy*, repositori, masukan pengguna | dihapus | Semua tim; "pilih satu" |
| S.6 Rencana Minggu 13–16 | Target dan penanggung jawab | dihapus | Semua tim |
| Bab 1 Pendahuluan | Latar belakang, tujuan, cakupan, pemangku kepentingan, kriteria keberhasilan | dipindahkan dari proposal | Semua tim |
| Bab 2 Analisis Kebutuhan dan Perancangan | Kebutuhan, komponen sistem, basis data, antarmuka | dipindahkan dari proposal | Semua tim; 2.4 **[TI Sem 5]** |
| Bab 3 Implementasi | Teknologi, cara membuat fitur, basis data, penyambungan | ditulis pada Milestone 2 | Semua tim; 3.4 **[TI Sem 5]** |
| Bab 4 Pengujian dan Evaluasi | Rencana uji, kasus uji (minimal 10), bug, masukan pengguna; 4.6 ditulis pada laporan akhir | ditulis pada Milestone 2 | Semua tim; 4.4 **[TI Sem 5]** |
| Bab 5 Pengelolaan Proyek dan Penutup | 5.1 rencana dan realisasi; 5.2 kontribusi; 5.3 perubahan dan risiko; 5.4 dan 5.5 ditulis pada laporan akhir | dilanjutkan dari Laporan Kemajuan | Semua tim |
| Lampiran | A tangkapan layar; B logbook; C dokumen rujukan; D dokumen tambahan dari dosen (D.1, D.2, dan seterusnya, bila ada); E daftar tautan eksternal; F model ML; G kueri basis data; H deklarasi AI | beragam | A, B, C, E, H semua tim; D bila ada; F **[TI Sem 5]**; G **[Sem 3]** |

Seluruhnya digabung dalam satu berkas PDF dengan nama `M2_<Kelas>_<NamaTim>.pdf`.

### Urutan penulisan yang disarankan

Gunakan isi proposal untuk Bab 1–2 lebih dulu, lalu tulis Bab 3 dan Bab 4 dari hasil kerja dan uji. Lanjutkan dengan Bab 5.1–5.3 dari logbook dan laporan kemajuan, lalu Lembar Status, dan tulis S.2 paling akhir. Isi Lampiran F dan G dari notebook, kueri, dan hasil uji yang sudah ada, lalu daftarkan dokumen kerja tim di Lampiran C dan tautannya di Lampiran E. Lampiran F dan G menggantikan penjelasan yang sama di Bab 2–4, jadi tulis sekali di lampiran dan rujuk dari bab.

---

<div style="page-break-before:always"></div>

## Sampul

Tim bebas merancang sampulnya, baik gaya, warna, gambar, maupun letaknya. Tulis hanya unsur berikut, dalam urutan dan tata letak apa pun:

- judul laporan (**Laporan Proyek *Project-Based Learning* (PBL), Tahap Milestone 2**);
- judul produk;
- identitas tim: nama tim, kelas, semester, tahun akademik, dan daftar anggota (nama dan NIM);
- logo dan nama institusi;
- bulan dan tahun pengumpulan.

Halaman sampul tidak diberi nomor halaman. Pada laporan akhir, judul tahap diganti menjadi "Laporan Akhir". Keempat Contoh Laporan memakai sampul yang berbeda-beda. Itu sengaja, untuk menunjukkan bahwa gaya sampul tidak diatur.

---

# Lembar Status Milestone 2 *[Catatan: dihapus pada laporan akhir]*

*Lembar Status ringkas, 1–2 halaman, dan diletakkan tepat setelah sampul. Isinya ringkasan posisi tim bagi dosen. Sebisa mungkin diisi dari bahan yang sudah ada. Pada laporan akhir, lembar ini dihapus.*

### S.1 Identitas, Dosen Pengampu, dan Dosen Rujukan *[Catatan: dihapus pada laporan akhir]*

*Tuliskan perubahan peran sejak Milestone 1, dosen pengampu per mata kuliah, dan dosen rujukan kelas. Dosen rujukan adalah dosen yang ditunjuk koordinator sebagai tempat bertanya pertama (SOP Bagian 9.1). Peran lengkap tiap anggota ada di Bab 5.2.*

| Nama | Peran saat ini | Perubahan dari Milestone 1 |
|---|---|---|
| Ahmad Fauzi | Ketua Tim & Pengembang Utama | Tidak ada |
| Citra Ayu | Sekretaris/Dokumentator | Menambah tugas penguji sejak Minggu 10 |

| Mata kuliah | Dosen pengampu | Dosen rujukan kelas |
|---|---|---|
| Basis Data Lanjut | _(nama dosen)_ | _(nama dosen rujukan)_ |

_(Bagian ini ditulis di laporan tim.)_

### S.2 Status Milestone 2 *[Catatan: dihapus pada laporan akhir]*

*Tulis satu paragraf (maksimal 150 kata) tentang posisi produk. Pilih status yang menurut tim paling sesuai: **Lengkap** (alur utama berjalan dengan baik dan semua dokumen wajib sudah ada), **Sebagian** (alur utama berjalan tetapi sering gagal, atau ada dokumen wajib yang belum ada), atau **Kritis** (alur utama belum berjalan atau tim sulit bekerja sama). Menulis status "Sebagian" atau "Kritis" dengan jujur tidak dikenai sanksi dan membantu tim mendapat dukungan (SOP Bagian 12). Tulis bagian ini paling akhir.*

**Contoh:** "Status: Lengkap. Alur utama, yaitu mengajukan peminjaman sampai disetujui staf, sudah berjalan dan tersambung ke basis data. Modul laporan bulanan baru 60% dan belum bisa didemokan, tetapi sudah masuk rencana Minggu 13. Dari 12 kasus uji, 10 lulus dan 2 gagal. Keduanya masuk daftar bug."

_(Bagian ini ditulis di laporan tim.)_

### S.3 Tindak Lanjut Milestone 1 *[Catatan: dihapus pada laporan akhir]*

*Daftarkan umpan balik dosen pada Milestone 1 beserta tindak lanjutnya. Bila tidak ada umpan balik tertulis, tuliskan catatan konsultasi yang relevan.*

| Umpan balik Milestone 1 | Dari mata kuliah | Tindak lanjut | Status |
|---|---|---|---|
| Hubungan tabel Peminjaman dan Alat perlu diperbaiki | Basis Data Lanjut | Struktur tabel diperbaiki dan dibekukan pada Minggu 9 | Selesai |

_(Bagian ini ditulis di laporan tim.)_

### S.4 Capaian Produk *[Catatan: dihapus pada laporan akhir]*

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

### S.5 Bukti *[Catatan: dihapus pada laporan akhir]*

*Pilih satu pada setiap baris dan jelaskan secara singkat. Seluruh pilihan diterima tanpa pengurangan nilai (SOP Bagian 10).*

| Aspek | Pilih satu | Tautan atau keterangan |
|---|---|---|
| Bentuk demo | Langsung / video (maks. 5 menit) / gabungan | _(URL video bila ada)_ |
| Cara *deploy* | Server kampus / hosting gratis atau milik sendiri / lokal dengan video / berkas instalasi (APK) | _(URL aplikasi atau berkas)_ |
| Repositori | Git dengan *tag* `milestone-2` | _(URL *tag*)_ |
| Masukan pengguna | Mitra / calon pengguna (min. 3 orang) / pengguna pengganti (jelaskan alasan) | Bab 4.5 |
| Bukti pengujian | Uji manual (minimal 10 kasus uji) / uji otomatis / uji coba oleh pengguna / uji kebenaran data / uji kueri / hasil awal model / laporan uji awal | Bab 4 |

_(Bagian ini ditulis di laporan tim.)_

### S.6 Rencana Minggu 13–16 *[Catatan: dihapus pada laporan akhir]*

*Susun target dan penanggung jawab per minggu sampai Demo Day. Masukkan fitur yang belum selesai. Tim berstatus Sebagian atau Kritis juga menulis rencana perbaikan di sini (SOP Bagian 12). Rencana yang lebih rinci ada di Bab 5.1.*

| Minggu | Target | Penanggung jawab |
|---|---|---|
| 13 | Menyelesaikan modul laporan; perbaiki bug prioritas tinggi | Ahmad, Budi |
| 14 | Pengujian lanjutan dan perbaikan | Dewi |
| 15 | Penyempurnaan Bab 1–5 dan materi demo | Seluruh tim |
| 16 | Demo Day / Expo | Seluruh tim |

_(Bagian ini ditulis di laporan tim.)_

---

<div style="page-break-before:always"></div>

# Isi Laporan: Bab 1–5

*Bab 1–5 adalah laporan akhir yang sedang tumbuh. Bab 1–2 dipindahkan dari proposal dan diperbarui. Bab 3–4 ditulis dari hasil kerja dan uji sampai Minggu 12. Bab 5 berisi pengelolaan proyek, dan penutupnya baru ditulis di laporan akhir. Tim tidak menulis ulang apa pun pada tahap akhir.*

## Bab 1. Pendahuluan *[Catatan: dipindahkan dari proposal]*

*Gunakan isi proposal, lalu perbarui sesuai perubahan cakupan (Bab 5.3).*

- **1.1 Latar belakang dan rumusan masalah:** masalah, siapa yang mengalaminya, dan pertanyaan yang dijawab produk.
- **1.2 Tujuan:** apa yang ingin dicapai produk.
- **1.3 Cakupan fitur dan batasan:** apa yang dikerjakan, apa yang sengaja tidak, dan asumsi.
- **1.4 Pemangku kepentingan dan manfaat:** siapa yang terlibat dan apa manfaatnya bagi mereka.
- **1.5 Kriteria keberhasilan:** ukuran konkret yang dipakai tim di Bab 4.6.

_(Bagian ini ditulis di laporan tim.)_

## Bab 2. Analisis Kebutuhan dan Perancangan *[Catatan: dipindahkan dari proposal]*

*Dinilai terutama oleh mata kuliah basis data, UI/UX, dan sistem informasi (SOP Bagian 6). Gunakan isi proposal, lalu perbarui dengan rancangan terbaru.*

- **2.1 Kebutuhan pengguna dan daftar fitur:** peran pengguna, apa yang bisa dilakukan tiap peran, dan ringkasan kebutuhan fungsional serta non-fungsional dari dokumen SRS tim. Tim **[TI Sem 3]** menambahkan pemetaan proses sebelum dan sesudah sistem ada.
- **2.2 Susunan komponen sistem:** bagian-bagian sistem dan teknologinya, beserta alasan memilihnya.
- **2.3 Rancangan basis data:** diagram basis data dalam bentuk PDM (*physical data model*, yaitu tabel beserta kolom, tipe data, kunci, dan relasinya), kamus data (tabel, kolom, tipe, batasan), dan penjelasan normalisasi.
- **2.4 Rancangan model ML [TI Sem 5]:** ringkasan singkat tentang data, jenis model, dan ukuran hasil yang ditargetkan (misalnya akurasi). Rinciannya di Lampiran F.
- **2.5 Rancangan antarmuka:** tampilan yang sudah jadi, beserta ringkasan desain Figma (daftar halaman, alur pengguna, dan warna serta huruf yang dipakai). Tim **[SIB]** menambahkan *wireframe* atau prototipe, dan alasan setiap perbedaannya dengan hasil akhir.
- **2.6 Rancangan laporan atau dasbor**, jika produk memilikinya.

_(Bagian ini ditulis di laporan tim.)_

## Bab 3. Implementasi *[Catatan: ditulis pada Milestone 2]*

*Dinilai terutama oleh mata kuliah pemrograman (SOP Bagian 6). Tulis dalam bentuk uraian, dengan potongan kode atau tangkapan layar yang penting saja, bukan seluruh kode. Cukup tulis bagian yang sudah dibuat. Pada laporan akhir, tambahkan fitur yang selesai setelah Milestone 2.*

- **3.1 Teknologi yang dipakai:** versi, *framework*, dan alat bantu.
- **3.2 Cara membuat tiap fitur:** alur, struktur, dan potongan kode penting.
- **3.3 Basis data:** struktur tabel dan data uji. Kueri penting dicatat di Lampiran G **[Sem 3]**.
- **3.4 Model dan cara memasangnya ke aplikasi [TI Sem 5]:** ringkasan pelatihan, penyimpanan model, dan cara aplikasi memanggilnya. Rinciannya di Lampiran F.
- **3.5 Penyambungan antar bagian dan *deploy*:** sesuai pilihan pada S.5.

_(Bagian ini ditulis di laporan tim.)_

## Bab 4. Pengujian dan Evaluasi *[Catatan: ditulis pada Milestone 2]*

*Dinilai terutama oleh mata kuliah penjaminan mutu (SOP Bagian 6). Pilih jenis pengujian yang sesuai (SOP Bagian 10.3) dan tulis hasilnya apa adanya, termasuk bug yang belum diperbaiki. Tulis minimal 10 kasus uji untuk alur utama. Pada laporan akhir, perbarui hasilnya dan tulis 4.6.*

- **4.1 Rencana pengujian:** apa yang diuji, jenis uji, dan alat atau perangkat yang dipakai.
- **4.2 Kasus uji dan hasil:** tabel seperti contoh di bawah, minimal 10 kasus uji, ditambah tabel yang memetakan kasus uji ke kebutuhan di SRS.
- **4.3 Bug yang ditemukan:** tingkat keparahan, langkah mereproduksi, status, dan rencana perbaikan.
- **4.4 Hasil awal model [TI Sem 5]:** ringkasan ukuran hasil model (misalnya akurasi) dan rencana perbaikan. Tabel evaluasi lengkapnya di Lampiran F.4.
- **4.5 Masukan pengguna:** ringkasan masukan dari mitra, calon pengguna, atau pengguna pengganti.
- **Uji kueri [Sem 3]:** hasil *EXPLAIN ANALYZE* ditulis di Lampiran G.4. Bab 4 cukup merujuknya.
- **4.6 Ketercapaian kriteria keberhasilan** *[Catatan: ditulis pada laporan akhir]*: bandingkan hasil akhir dengan kriteria di Bab 1.5. Di Milestone 2, cukup tulis judulnya.

**Contoh (4.2):**

| ID | Skenario | Langkah singkat | Hasil diharapkan | Hasil aktual | Status |
|---|---|---|---|---|---|
| TC-01 | Pengajuan peminjaman | Isi formulir dan kirim | Pengajuan tersimpan | Tersimpan | Lulus |
| TC-07 | Verifikasi tolak | Staf menolak pengajuan | Status berubah | Error 500 | Gagal (BUG-03) |

_(Bagian ini ditulis di laporan tim.)_

## Bab 5. Pengelolaan Proyek dan Penutup *[Catatan: dilanjutkan dari Laporan Kemajuan]*

*Bab ini juga bahan untuk mata kuliah manajemen proyek. Pada Milestone 2, tulis 5.1–5.3. Bagian 5.4 dan 5.5 baru ditulis di laporan akhir.*

### 5.1 Rencana dan Realisasi *[Catatan: dilanjutkan dari Laporan Kemajuan]*

*Gunakan rincian pekerjaan (WBS tiga tingkat) dan jadwal dari proposal, lalu tambahkan kolom realisasi sampai Minggu 12. Jadwal boleh ditampilkan sebagai diagram Gantt. Rencana Minggu 13–16 ada di S.6.*

| Tugas | Penanggung jawab | Rencana | Realisasi (sampai Minggu 12) |
|---|---|---|---|
| Modul verifikasi | Ahmad | Minggu 9–11 | Selesai Minggu 11 |
| Modul laporan bulanan | Budi | Minggu 10–12 | 60%, lanjut Minggu 13 |

_(Bagian ini ditulis di laporan tim.)_

### 5.2 Kontribusi Anggota *[Catatan: dilanjutkan dari Laporan Kemajuan]*

*Catat pekerjaan setiap anggota beserta bukti yang bisa dicek (*commit*, berkas, tugas pada rincian pekerjaan atau WBS). Tulis juga bagian yang dibawakan tiap anggota saat demo. Dosen boleh bertanya kepada anggota mana pun tentang bagiannya. Estimasi ini dibandingkan koordinator dengan hasil Penilaian 360, yaitu form yang diisi tiap anggota secara pribadi (SOP Bagian 9.3). Hasil Penilaian 360 tidak ditulis di laporan. Anggota yang tidak aktif ditulis apa adanya beserta buktinya.*

**Contoh:**

| Nama | Tugas selesai | Bukti | Estimasi kontribusi | Bagian saat demo |
|---|---|---|---|---|
| Ahmad Fauzi | Modul verifikasi dan Admin | 28 *commit* | 30% | Alur verifikasi staf |
| Budi Santoso | Formulir dan antarmuka laporan | 19 *commit*, berkas Figma | 25% | Formulir pengajuan |

_(Bagian ini ditulis di laporan tim.)_

### 5.3 Perubahan, Risiko, dan Permintaan Tambahan *[Catatan: dilanjutkan dari Laporan Kemajuan]*

*Tulis perubahan dari proposal atau Milestone 1 (fitur, teknologi, peran), alasannya, dan apakah sudah dikonsultasikan dengan dosen terkait. Tulis maksimal 5 risiko terbesar untuk Minggu 13–16, beserta kemungkinan, dampak, tingkat risiko, dan tindakannya. Jika tim butuh fasilitas yang belum didapat (misalnya server kampus atau perangkat), tulis juga sebagai risiko. Jika mitra tidak bisa dihubungi lagi, jelaskan dan gunakan pilihan pengguna pengganti.*

| Risiko | Tingkat | Tindakan |
|---|---|---|
| Modul laporan belum selesai | Tinggi | Selesaikan Minggu 13; prioritaskan satu laporan |
| Server kampus belum tersedia | Sedang | Pakai hosting gratis sementara; ajukan lagi ke dosen rujukan |

*Catat permintaan fitur atau perubahan dari dosen setelah proposal disetujui (SOP Bagian 9.2). Jika tidak ada, tulis "Tidak ada permintaan tambahan".*

| Permintaan | Dari mata kuliah | Waktu | Keputusan tim dan dosen rujukan |
|---|---|---|---|
| Tambah filter laporan per bulan | Sistem Informasi | Minggu 10 | Masuk rencana Minggu 13 |

_(Bagian ini ditulis di laporan tim.)_

### 5.4 Kesimpulan *[Catatan: ditulis pada laporan akhir]*

*Ditulis di laporan akhir: apa yang berhasil dibangun dan apakah rumusan masalah di Bab 1.1 terjawab. Di Milestone 2, cukup tulis judulnya.*

### 5.5 Pelajaran dan Saran *[Catatan: ditulis pada laporan akhir]*

*Ditulis di laporan akhir: apa yang dipelajari tim (*lessons learned*), apa yang akan dilakukan berbeda, dan saran pengembangan berikutnya. Di Milestone 2, cukup tulis judulnya.*

---

# Lampiran

*Setiap lampiran dimulai di halaman baru.*

- *Lampiran A: tangkapan layar fitur yang berjalan.*
- *Lampiran B: logbook mingguan, dengan kolom "Dikerjakan oleh" supaya terlihat siapa mengerjakan apa. Pada Milestone 2 logbook mencakup Minggu 1–12, dan pada laporan akhir ditambah Minggu 13–16.*
- *Lampiran C: daftar dokumen rujukan tim, yaitu dokumen kerja yang sudah dibuat untuk mata kuliah (misalnya SRS, desain Figma, Project Charter, WBS dan jadwal, rancangan basis data, serta rencana dan kasus uji). Dokumen cukup didaftarkan di sini dan diringkas di bab yang sesuai, tidak ditulis ulang.*
- *Lampiran D: dokumen tambahan dari dosen. Lampiran ini hanya ada bila dosen sudah mengumumkan dokumen tambahan secara tertulis sebelum tanggal terbit SOP (SOP Bagian 7). Jika tidak ada, tulis "Tidak ada dokumen tambahan".*
- *Lampiran E: daftar semua tautan eksternal di dalam laporan, termasuk tautan dokumen di Lampiran C dan D. Tautan harus dapat diklik, dapat dibuka tanpa login, sudah diuji di mode* incognito*, dan tidak diubah setelah batas akhir.*

**Contoh (Lampiran B):**

| Minggu | Pekerjaan selesai | Dikerjakan oleh | Kendala | Rencana berikutnya |
|---|---|---|---|---|
| 9 | Verifikasi staf selesai | Ahmad Fauzi | Revisi skema | Mulai peran Admin |

<div style="page-break-before:always"></div>

## Lampiran C. Dokumen Rujukan

*Daftarkan dokumen kerja tim yang dirujuk laporan. Tulis nama dokumen, versinya, siapa pemiliknya, dan bagian laporan yang merujuknya. Tautan dokumen ditulis di Lampiran E, bukan di sini. Dokumen yang tidak dirujuk laporan tidak perlu didaftarkan.*

| No | Dokumen | Versi | Pemilik | Bagian yang merujuk | Keterangan |
|---|---|---|---|---|---|
| 1 | SRS (spesifikasi kebutuhan perangkat lunak) | 1.2 | Citra Ayu | Bab 2.1, Bab 4.2 | Kebutuhan fungsional dan non-fungsional |
| 2 | Desain Figma (*wireframe* dan prototipe) | 1.0 | Budi Santoso | Bab 2.5 | Daftar halaman dan alur pengguna |
| 3 | Project Charter dan Governance Log | 1.1 | Ahmad Fauzi | Bab 1, Bab 5.3 | Tujuan, ruang lingkup, dan catatan perubahan |
| 4 | WBS dan jadwal | 1.3 | Ahmad Fauzi | Bab 5.1 | Rincian pekerjaan tiga tingkat |
| 5 | PDM dan kamus data | 1.2 | Dewi Lestari | Bab 2.3, Lampiran G | Model data fisik dan kamus data |
| 6 | Rencana uji, kasus uji, dan catatan bug | 1.0 | Citra Ayu | Bab 4 | Hasil uji sampai Minggu 12 |

_(Lampiran disertakan di laporan tim.)_

<div style="page-break-before:always"></div>

## Lampiran D. Dokumen Tambahan dari Dosen

*Lampiran ini hanya ada bila ada dokumen tambahan yang diumumkan dosen secara tertulis (SOP Bagian 7). Setiap dokumen menjadi satu sub-lampiran untuk satu mata kuliah: D.1, D.2, dan seterusnya. Format isinya mengikuti yang ditentukan dosen. Dokumen tambahan tidak mengulang isi laporan. Untuk hal yang sudah ada di laporan, cukup rujuk bab yang bersangkutan. Jika tidak ada dokumen tambahan, tulis satu kalimat: "Tidak ada dokumen tambahan."*

### D.1 *(nama dokumen)*

*Mulai dengan satu tabel yang memuat mata kuliah, dosen, nama dokumen, dan tanggal pengumuman tertulisnya. Isi dokumen mengikuti format dosen.*

| Mata kuliah | Dosen | Dokumen | Tanggal pengumuman |
|---|---|---|---|
| Manajemen Proyek | _(nama dosen)_ | Ringkasan status artefak proyek | _(tanggal)_ |

_(Lampiran ini ditulis di laporan tim bila ada dokumen tambahan.)_

<div style="page-break-before:always"></div>

## Lampiran E. Daftar Tautan Eksternal

*Tulis semua tautan yang ada di laporan dalam satu tabel. Tautan dokumen di Lampiran C dan D juga ditulis di sini.*

| No | Keterangan | Bagian | Tautan | Jenis akses |
|---|---|---|---|---|
| 1 | Repositori (*tag* milestone-2) | S.5 | _(URL tag Git)_ | Publik |
| 2 | SRS versi 1.2 | Lampiran C, Bab 2.1 | _(URL dokumen)_ | Siapa saja yang memiliki link |
| 3 | Desain Figma versi 1.0 | Lampiran C, Bab 2.5 | _(URL Figma)_ | Siapa saja yang memiliki link |
| 4 | WBS dan jadwal versi 1.3 | Lampiran C, Bab 5.1 | _(URL dokumen)_ | Siapa saja yang memiliki link |
| 5 | Video demo | S.5 | _(URL video)_ | Siapa saja yang memiliki link |

<div style="page-break-before:always"></div>

## Lampiran F. Dokumentasi Model Pembelajaran Mesin **[TI Sem 5]**

*Wajib untuk tim TI Semester 5. Tim lain yang memakai model ML boleh melampirkannya. Lampiran ini memuat rincian teknis yang tidak ditulis di Bab 2–4: dataset, praproses, eksperimen pembanding, evaluasi rinci, dan analisisnya. Bab 2.4, 3.4, dan 4.4 cukup berisi ringkasan dan rujukan ke sini. Bahannya dari notebook dan hasil percobaan yang sudah ada.*

*Aturan penulisan:*

- *Panjang paling banyak 4 halaman.*
- *Angka harus sama dengan keluaran notebook pada* tag *`milestone-2`.*
- *Tabel diberi judul Tabel F.n di atas tabel. Gambar diberi judul Gambar F.n di bawah gambar.*
- *Paragraf Analisis menjelaskan mengapa hasilnya demikian dan apa artinya, bukan mengulang angka di tabel. Jawab dalam 2–4 kalimat dan rujuk tabel atau gambar sebagai bukti.*
- *Untuk regresi atau klasterisasi, Tabel F.2 diganti statistik deskriptif fitur utama, dan Tabel F.5 serta Gambar F.2 diganti metrik dan grafik prediksi dibanding nilai sebenarnya.*

Contoh lengkap yang sudah terisi ada di Contoh Laporan TI Semester 5.

### F.1 Dataset

*Isi Tabel F.1 (sumber dan lisensi, cara pelabelan, jumlah total, pembagian data), Tabel F.2 (sebaran data per kelas: latih, validasi, uji), dan Gambar F.1 (minimal tiga contoh sampel untuk setiap kelas beserta labelnya). Tutup dengan paragraf Analisis Dataset yang menjawab: (1) apakah sebaran kelas seimbang, (2) bagaimana kualitas datanya (duplikat, noise, label yang meragukan, kondisi pengambilan data), (3) apa dampaknya bagi model dan apa yang sudah dilakukan (misalnya class weight, oversampling, pembersihan).*

| Hal | Isi |
|---|---|
| Sumber dan lisensi | _(kumpulan sendiri, atau sumber publik beserta lisensi dan rujukan)_ |
| Cara pelabelan | _(berlabel dari sumber, atau dilabeli tim: alat dan jumlah pelabel)_ |
| Jumlah total | _(jumlah sampel, format, dan ukuran)_ |
| Pembagian data | _(latih / validasi / uji, acak atau berstrata, seed)_ |

### F.2 Praproses Data

*Isi Tabel F.3 dengan minimal dua langkah, sesuai urutan di kode. Augmentasi termasuk di sini.*

| No | Langkah | Alasan | Parameter | Diterapkan pada |
|---|---|---|---|---|
| 1 | _(misalnya: ubah ukuran)_ | _(menyamakan ukuran input)_ | _(224×224)_ | _(latih, validasi, uji)_ |

### F.3 Eksperimen Pembanding

*Isi Tabel F.4 dengan minimal dua eksperimen (algoritma atau konfigurasi berbeda) pada data validasi yang sama. Tulis metrik pada data latih dan validasi agar overfitting terlihat, dan tandai model terpilih. Tutup dengan Analisis Eksperimen: (1) perubahan apa yang paling berpengaruh dan mengapa, (2) apakah ada tanda overfitting atau underfitting, (3) mengapa model terpilih paling sesuai dengan kebutuhan aplikasi.*

| ID | Model dan konfigurasi | Hiperparameter utama | Metrik (latih) | Metrik (validasi) | Terpilih |
|---|---|---|---|---|---|
| E1 | _(baseline)_ | | | | |
| E2 | | | | | |

### F.4 Evaluasi Rinci pada Data Uji

*Rincian hasil pada data uji. Ringkasannya sudah ada di Bab 4.4. Isi Tabel F.5 (presisi, recall, F1 per kelas), Gambar F.2 (confusion matrix), dan Tabel F.6 (minimal tiga contoh prediksi yang salah beserta dugaan penyebabnya). Tutup dengan Analisis Hasil Evaluasi: (1) kelas mana yang paling lemah dan tertukar dengan kelas apa, (2) apakah pola kesalahan berkaitan dengan temuan di F.1 atau F.2, (3) seberapa jauh hasil dari target dan apakah konsisten dengan hasil validasi.*

| Kelas | Presisi | Recall | F1 | Jumlah data |
|---|---|---|---|---|
| _(kelas A)_ | | | | |
| *Rata-rata makro* | | | | |

### F.5 Kesimpulan Analisis

*Dalam 3–4 kalimat, simpulkan sumber masalah utama model saat ini: data, praproses, atau model, beserta buktinya dari F.1–F.4. Kesimpulan ini menjadi dasar rencana perbaikan di Bab 4.4, jadi rencananya tidak ditulis ulang di sini.*

_(Lampiran ini ditulis di laporan tim TI Semester 5.)_

---

<div style="page-break-before:always"></div>

## Lampiran G. Dokumentasi Kueri Basis Data **[Sem 3]**

*Wajib untuk tim Semester 3 (TI dan SIB) yang mengikuti Basis Data Lanjut. Tim lain boleh melampirkannya. Lampiran ini menjawab tiga pertanyaan: kueri apa saja yang dipakai, fungsinya menampilkan atau menghitung apa di aplikasi, dan bagaimana pengujiannya. Tulis minimal 5 kueri utama dan hasil *EXPLAIN ANALYZE* untuk minimal 3 kueri terpenting. Tangkapan layar diambil dari PostgreSQL sendiri.*

### G.1 Skema dan Indeks

*Tulis skema tabel secara ringkas: `CREATE TABLE` beserta kunci dan batasan (PK, FK, `UNIQUE`, `CHECK`, `NOT NULL`), lalu indeks yang dibuat. Skema ini harus sama dengan PDM dan kamus data di Bab 2.3.*

```sql
CREATE TABLE peminjaman (
  id             SERIAL PRIMARY KEY,
  ruang_id       INT NOT NULL REFERENCES ruang(id),
  status         VARCHAR(12) NOT NULL DEFAULT 'menunggu',
  tanggal_pinjam DATE NOT NULL
);
CREATE INDEX idx_peminjaman_status ON peminjaman (status);
```

### G.2 Daftar Kueri

| No | Fungsi di aplikasi | Tabel yang dipakai | Jenis |
|---|---|---|---|
| Q1 | Menampilkan daftar pengajuan yang menunggu verifikasi di halaman staf | `peminjaman`, `pengguna` | Tampil |
| Q2 | Menghitung jumlah peminjaman per ruang tiap bulan untuk laporan bulanan | `peminjaman`, `ruang` | Hitung |
| Q3 | Mengubah status pengajuan menjadi disetujui | `peminjaman` | Ubah data |

### G.3 Kueri dan Fungsinya

*Tulis satu blok SQL untuk tiap kueri dan satu kalimat penjelasan. Kueri yang panjang boleh berupa tautan ke berkas di repositori. Kueri yang memakai fungsi lanjutan (misalnya `JOIN`, fungsi agregat, *window function*, atau transaksi) lebih baik dicantumkan, karena itu bahan yang dinilai.*

**Q2.** Menghitung peminjaman per ruang tiap bulan untuk halaman laporan bulanan.

```sql
SELECT r.nama_ruang,
       DATE_TRUNC('month', p.tanggal_pinjam) AS bulan,
       COUNT(*) AS jumlah_peminjaman
FROM peminjaman p
JOIN ruang r ON r.id = p.ruang_id
GROUP BY r.nama_ruang, bulan
ORDER BY bulan, r.nama_ruang;
```

### G.4 Pengujian dengan *EXPLAIN ANALYZE*

*Jalankan `EXPLAIN (ANALYZE, BUFFERS)` di depan kueri, lalu ambil tangkapan layar hasil lengkapnya dari PostgreSQL dengan *execution time* yang terlihat. Catat versi PostgreSQL. Tim yang memakai DBMS lain melampirkan perintah dan keluaran yang setara.*

```sql
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM peminjaman WHERE status = 'menunggu';
```

| Kueri | Jumlah baris data uji | Jenis *scan* | *Execution time* | Catatan |
|---|---|---|---|---|
| Q1 | 10.000 | Seq Scan | 12,4 ms | Belum ada indeks |
| Q1 | 10.000 | Index Scan | 0,6 ms | Setelah indeks `status` ditambah |
| Q2 | 10.000 | Seq Scan | 18,9 ms | Cukup untuk saat ini |

*(Angka pada contoh hanya ilustrasi. Tim memakai hasil dari basis datanya sendiri.)*

**Cara membaca hasilnya:**

- **Seq Scan:** PostgreSQL membaca semua baris tabel. Cepat untuk tabel kecil, lambat untuk tabel besar.
- **Index Scan:** PostgreSQL memakai indeks untuk langsung ke baris yang dicari.
- ***Execution time*:** waktu nyata kueri dijalankan. Angka ini ada di baris paling bawah keluaran.

Tempelkan tangkapan layar tiap hasil di sini (Gambar G.1, G.2, dan seterusnya). Keluaran yang berupa teks boleh disajikan sebagai gambar bertitel.

_(Lampiran ini ditulis di laporan tim Semester 3.)_

---

<div style="page-break-before:always"></div>

## Lampiran H. Deklarasi Penggunaan AI

*Sebutkan bagian yang dibantu AI, alat, dan tujuannya. Seluruh anggota harus memahami dan mampu menjelaskan hasil yang dibantu AI. Daftar ini bertambah sampai laporan akhir.*

| Bagian | Alat | Tujuan |
|---|---|---|
| Kueri laporan | Asisten kode | Saran optimasi; ditinjau dan diuji tim |

_(Lampiran disertakan di laporan tim.)_

---

> ⚠️ **Ingat:** yang dikumpulkan adalah laporan tim dengan struktur di atas dan isi dari proyek tim sendiri.
