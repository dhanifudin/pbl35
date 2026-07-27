---
marp: true
theme: default
paginate: true
backgroundColor: #ffffff
color: #1a1a2e
style: |
  :root {
    --color-primary: #003b7a;
    --color-accent:  #f5a623;
    --color-light:   #e8f0fb;
    --color-muted:   #4a5568;
  }
  section {
    font-family: 'Segoe UI', 'Arial', sans-serif;
    font-size: 22px;
    padding: 40px 56px;
  }
  h1 { color: var(--color-primary); font-size: 1.9em; border-bottom: 4px solid var(--color-accent); padding-bottom: 8px; }
  h2 { color: var(--color-primary); font-size: 1.45em; }
  h3 { color: var(--color-accent); font-size: 1.1em; margin-top: 0.4em; }
  strong { color: var(--color-primary); }
  em { color: #b45309; }
  table { width: 100%; border-collapse: collapse; font-size: 0.85em; }
  th { background: var(--color-primary); color: #fff; padding: 7px 12px; }
  td { padding: 6px 12px; border: 1px solid #c5d4e8; }
  tr:nth-child(even) td { background: var(--color-light); }
  ul li, ol li { margin-bottom: 4px; }
  .chip {
    display: inline-block;
    background: var(--color-accent);
    color: #fff;
    border-radius: 20px;
    padding: 2px 14px;
    font-size: 0.75em;
    font-weight: bold;
    margin-right: 6px;
  }
  section.cover {
    background: linear-gradient(145deg, #003b7a 60%, #1a6bbf 100%);
    color: #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  section.cover h1, section.cover h2, section.cover h3 { color: #fff; border: none; }
  section.cover h1 { font-size: 2.2em; }
  section.cover h3 { color: var(--color-accent); font-size: 1.1em; }
  section.divider {
    background: var(--color-primary);
    color: #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  section.divider h1, section.divider h2 { color: #fff; border-color: var(--color-accent); }
  section.milestone {
    background: #fffbea;
    border-left: 8px solid var(--color-accent);
  }
  footer { font-size: 0.65em; color: var(--color-muted); }
---

<!-- _class: cover -->
<!-- _paginate: false -->

# 📘 Sosialisasi PBL
## *Project-Based Learning* Product-Based
### Semester 3 — Teknik Informatika & Sistem Informasi Bisnis
#### Jurusan Teknologi Informasi · Politeknik Negeri Malang · 2025/2026

---

# Agenda

1. Apa itu PBL dan mengapa *product-based*?
2. Model & aturan tim
3. Integrasi mata kuliah — **TI** dan **SIB**
4. Target produk semester ini
5. Alur 5 fase PjBL
6. Timeline 16 minggu & 4 milestone
7. Komponen & bobot penilaian
8. Mitra industri (opsional)
9. Deliverable & checklist per milestone
10. FAQ

---

<!-- _class: divider -->

# Bagian 1
## Apa itu PBL & Mengapa Product-Based?

---

# Apa itu PBL?

**Project-Based Learning (PBL)** adalah metode pembelajaran di mana mahasiswa belajar melalui **pengerjaan proyek nyata** yang menjawab permasalahan atau kebutuhan nyata.

> 💡 Bukan sekedar tugas. Bukan sekedar presentasi. **Anda membangun produk.**

### Ciri khas PBL di Jurusan TI Polinema:
- Terintegrasi dengan beberapa mata kuliah sekaligus
- Berorientasi **produk digital** yang berfungsi penuh
- Tim kecil, kolaboratif, terstruktur
- Ada milestone bertahap dan penilaian proses
- Mitra industri dianjurkan (namun tidak wajib)

---

# Mengapa Product-Based?

| Pembelajaran Konvensional | PBL Product-Based |
|---|---|
| Tugas per MK, terpisah | Proyek terintegrasi lintas MK |
| Ujian sebagai ukuran utama | Produk + proses + presentasi |
| Belajar teori, baru praktek | Belajar **sambil** membangun |
| Individu dominan | Tim dengan peran nyata |
| Luaran: nilai | Luaran: **produk yang bisa dipakai** |

### Manfaat langsung:
- Portofolio nyata saat melamar kerja/magang
- Pengalaman kerja tim seperti di industri
- Memahami konteks antar-MK secara organik

---

# Prinsip PBL yang Dipakai

1. **Pertanyaan penggerak** — proyek dimulai dari masalah/kebutuhan nyata
2. **Inkuiri berkelanjutan** — bukan resep, tapi eksplorasi & solusi
3. **Autentisitas** — produk berfungsi, bukan hanya mockup
4. **Refleksi** — logbook & bimbingan berkala
5. **Kritik & revisi** — milestone adalah checkpoint, bukan hukuman
6. **Produk publik** — demo/expo di akhir semester

---

<!-- _class: divider -->

# Bagian 2
## Model & Aturan Tim

---

# Model Tim

| Ketentuan | Detail |
|---|---|
| **Ukuran tim** | Maksimal **5 mahasiswa** per tim |
| **Pembentukan** | Di dalam kelas, per program studi |
| **Prodi campuran?** | Tidak — TI dengan TI, SIB dengan SIB |
| **Pilih sendiri?** | Ya, mahasiswa memilih tim secara mandiri |
| **Ganti tim?** | Tidak diperbolehkan setelah Minggu 2 |

> ⚠️ Tim dengan anggota < 3 orang setelah Minggu 2 akan **digabungkan** oleh koordinator.

---

# Peran dalam Tim

Setiap tim **wajib** menetapkan peran berikut (satu orang boleh merangkap):

| Peran | Tanggung Jawab Utama |
|---|---|
| **Ketua Tim** | Koordinasi antar-anggota, penghubung ke pembimbing, penjaga timeline |
| **Sekretaris / Dokumentator** | Menulis & mengumpulkan logbook, laporan, dan notulensi |
| **Pengembang Utama** | Penanggungjawab teknis produk (kode/sistem utama) |
| **Analis / Desainer** | Kebutuhan pengguna, alur sistem, UI/UX |
| **QA / Penguji** | Pengujian fungsional dan dokumentasi hasil uji |

> Pembagian tugas dituangkan dalam *project charter* pada Fase 2.

---

# Dosen Pembimbing & Koordinator

- Setiap tim mendapat **1 Dosen Pembimbing** (merangkap pengampu MK terintegrasi)
- Bimbingan minimal **2× per fase** atau sesuai jadwal MK terkait
- Koordinator PBL prodi bertanggung jawab atas kelancaran lintas tim
- Mitra industri (bila ada) berperan sebagai **klien dan co-assessor**

---

<!-- _class: divider -->

# Bagian 3
## Integrasi Mata Kuliah

---

# Integrasi MK — Teknik Informatika (Sem 3)

Produk PBL dikerjakan **dalam konteks** mata kuliah berikut:

| Mata Kuliah | Peran dalam PBL | Kategori |
|---|---|---|
| **Desain dan Pemrograman Web** | Implementasi front-end & back-end produk | 🔵 **Inti** |
| **Basis Data Lanjut** | Perancangan & implementasi basis data produk | 🔵 **Inti** |
| **Sistem Informasi Manajemen** | Analisis kebutuhan, konteks bisnis/organisasi produk | 🟡 Pendukung |
| **Manajemen Proyek** | Perencanaan proyek, manajemen risiko, WBS | 🟡 Pendukung |

> Nilai PBL **didistribusikan** ke tiap MK sesuai kontribusi komponen. Detail distribusi ada di slide Penilaian.

---

# Integrasi MK — Sistem Informasi Bisnis (Sem 3)

| Mata Kuliah | Peran dalam PBL | Kategori |
|---|---|---|
| **Pemrograman Web** | Implementasi aplikasi web produk | 🔵 **Inti** |
| **Basis Data Lanjut** | Perancangan & implementasi basis data produk | 🔵 **Inti** |
| **Desain UI/UX** | Perancangan antarmuka, wireframe, prototipe, usability | 🟡 Pendukung |

> Nilai PBL **didistribusikan** ke tiap MK sesuai kontribusi komponen.

---

<!-- _class: divider -->

# Bagian 4
## Target Produk Semester 3

---

# Target Produk — Teknik Informatika

### 🖥️ Aplikasi Web Berbasis Data untuk Kebutuhan Manajemen / SIM

Produk yang Anda kembangkan adalah **aplikasi web fungsional** yang menjawab kebutuhan manajemen informasi nyata, didukung basis data yang dirancang baik.

**Kriteria minimum produk TI Sem 3:**
- ✅ Aplikasi web berjalan penuh (bukan mockup)
- ✅ Terhubung ke basis data relasional (CRUD lengkap)
- ✅ Punya setidaknya 2 peran pengguna (mis. admin & user)
- ✅ Menerapkan konsep SIM yang dipelajari (mis. laporan/dashboard sederhana)
- ✅ Dikelola dengan prinsip manajemen proyek

---

# Contoh Ide Produk — TI Sem 3

> Ini **contoh** — Anda bebas mengusulkan ide lain selama sesuai kriteria.

- 📦 Sistem manajemen inventaris barang (sekolah, koperasi, UMKM)
- 🏫 Aplikasi peminjaman ruang/peralatan kampus
- 📋 Sistem pendaftaran & absensi kegiatan organisasi
- 🧾 Aplikasi pencatatan transaksi dan laporan keuangan sederhana
- 🔧 Sistem tiket layanan IT internal (helpdesk)
- 📅 Aplikasi penjadwalan dan monitoring tugas tim

> 💡 **Mitra nyata = nilai lebih!** Jika ada UMKM, instansi, atau organisasi yang mau dibantu, ajukan ke pembimbing.

---

# Target Produk — Sistem Informasi Bisnis

### 🛍️ Aplikasi Web Bisnis dengan UI/UX Baik & Basis Data

Produk yang Anda kembangkan adalah **aplikasi web bisnis** yang memperhatikan kualitas antarmuka dan pengalaman pengguna, didukung basis data yang terancang.

**Kriteria minimum produk SIB Sem 3:**
- ✅ Aplikasi web berjalan penuh (bukan mockup)
- ✅ Terhubung ke basis data (CRUD relevan dengan domain bisnis)
- ✅ Desain UI konsisten, responsif, dan mempertimbangkan UX
- ✅ Ada prototipe/wireframe yang menjadi acuan implementasi
- ✅ Menjawab kebutuhan proses bisnis nyata (bisa UMKM/komunitas)

---

# Contoh Ide Produk — SIB Sem 3

> Ini **contoh** — Anda bebas mengusulkan ide lain selama sesuai kriteria.

- 🛒 Aplikasi toko online sederhana (UMKM lokal)
- 📑 Sistem pemesanan & manajemen jasa (salon, laundry, bengkel)
- 🎓 Portal pendaftaran kursus/pelatihan online
- 🍽️ Aplikasi pemesanan makanan/katering
- 📊 Dashboard laporan penjualan untuk UMKM
- 🤝 Platform penghubung relawan dan komunitas sosial

> 💡 Produk terbaik lahir dari masalah yang benar-benar Anda (atau mitra Anda) rasakan.

---

<!-- _class: divider -->

# Bagian 5
## Alur 5 Fase PjBL

---

# Alur 5 Fase PjBL

```
┌─────────────────┐   ┌──────────────┐   ┌────────────────┐   ┌───────────────┐   ┌────────────────────┐
│  FASE 1         │ → │  FASE 2      │ → │  FASE 3        │ → │  FASE 4       │ → │  FASE 5            │
│  Identifikasi   │   │  Perencanaan │   │  Pengembangan  │   │  Pengujian &  │   │  Presentasi &      │
│  Masalah & Ide  │   │              │   │                │   │  Pengemasan   │   │  Diseminasi        │
└─────────────────┘   └──────────────┘   └────────────────┘   └───────────────┘   └────────────────────┘
   Minggu 1–3            Minggu 3–4          Minggu 5–12         Minggu 12–15          Minggu 16
```

| Fase | Luaran Utama |
|---|---|
| Fase 1 | Ide produk, deskripsi masalah, identifikasi pengguna |
| Fase 2 | *Project charter*, proposal produk, pembagian peran |
| Fase 3 | Produk bertahap (iterasi 1 & 2), logbook mingguan |
| Fase 4 | Produk final teruji, dokumentasi, laporan |
| Fase 5 | Demo/expo, presentasi, serah terima ke mitra (bila ada) |

---

# Fase 1 — Identifikasi Masalah & Ide Produk (Mgg 1–3)

**Tujuan:** menemukan masalah/kebutuhan nyata dan menentukan produk yang akan dibangun.

**Aktivitas:**
- Brainstorming ide dalam tim
- Observasi/wawancara calon pengguna (atau mitra)
- Analisis kelayakan (teknologi, waktu, anggota tim)
- Deskripsi masalah & solusi awal (1–2 halaman)

**Output untuk Fase 1:**
- ✅ Dokumen identifikasi masalah & deskripsi produk
- ✅ Nama tim, anggota, dan calon mitra (jika ada)

---

# Fase 2 — Perencanaan (Mgg 3–4)

**Tujuan:** menetapkan rencana yang matang sebelum mulai membangun.

**Aktivitas:**
- Menyusun *project charter* (tujuan, lingkup, tim, risiko)
- Menyusun proposal produk (kebutuhan fungsional, desain awal)
- Membuat WBS / rencana iterasi / timeline
- Sidang/review proposal oleh dosen → **MILESTONE PROPOSAL (Minggu 4)**

**Output untuk Fase 2:**
- ✅ *Project charter* (ditandatangani tim & pembimbing)
- ✅ Proposal produk (dikumpul + dipresentasikan)
- ✅ Timeline & pembagian tugas

---

# Fase 3 — Pengembangan Iteratif (Mgg 5–12)

**Tujuan:** membangun produk secara bertahap dalam dua iterasi.

**Iterasi 1 (Mgg 5–8):** Fokus fitur inti (core) → demo Milestone 1
**Iterasi 2 (Mgg 9–12):** Lengkapi fitur, integrasikan, siapkan pengujian → demo Milestone 2

**Aktivitas rutin tiap minggu:**
- Mengisi logbook mingguan (kemajuan, hambatan, rencana berikutnya)
- Bimbingan berkala dengan dosen pembimbing
- Review antar-anggota tim

**Output:**
- ✅ Logbook mingguan (tiap anggota / tim)
- ✅ Demo produk di Milestone 1 & 2

---

# Fase 4 — Pengujian & Pengemasan (Mgg 13–15)

**Tujuan:** memastikan produk benar-benar berfungsi dan siap dipresentasikan.

**Aktivitas:**
- Pengujian fungsional (*testing* sistematis)
- Perbaikan bug & penyempurnaan UX
- Penulisan laporan akhir
- Penyiapan demo/expo

**Output:**
- ✅ Laporan hasil pengujian
- ✅ Laporan akhir proyek
- ✅ Produk siap demo

---

# Fase 5 — Presentasi & Diseminasi (Mgg 16)

**Tujuan:** menampilkan produk kepada penguji, dosen, dan (bila ada) mitra.

**Aktivitas:**
- **Sidang akhir / Demo Day / Expo**
- Presentasi + demo langsung produk
- Tanya jawab dengan dosen penguji
- Serah terima produk ke mitra (jika ada)
- *Peer assessment* antar-anggota tim

**Output:**
- ✅ Presentasi final + demo (rekaman/live)
- ✅ *Peer assessment* diisi semua anggota
- ✅ Semua dokumen final dikumpulkan

---

<!-- _class: divider -->

# Bagian 6
## Timeline 16 Minggu & 4 Milestone

---

# Timeline 16 Minggu

| Minggu | Kegiatan | Milestone |
|---|---|---|
| 1 – 3 | Pembentukan tim · Identifikasi masalah · Penyusunan proposal | — |
| **4** | **Sidang/review proposal** | 🟡 **PROPOSAL** |
| 5 – 7 | Perancangan BD & UI · Pembangunan fitur inti (iterasi 1) | — |
| **8** | **Demo progres tengah semester** | 🟠 **MILESTONE 1** |
| 9 – 11 | Pengembangan lanjut · Integrasi · Mulai pengujian | — |
| **12** | **Demo produk fungsional + laporan hasil uji** | 🔵 **MILESTONE 2** |
| 13 – 15 | Perbaikan · Penulisan laporan akhir · Persiapan expo | — |
| **16** | **Sidang akhir / Demo Day / Expo** | 🟢 **MILESTONE 3 (FINAL)** |

---

<!-- _class: milestone -->

# 🟡 PROPOSAL — Minggu 4

### Yang harus siap saat review proposal:

| Item | Keterangan |
|---|---|
| *Project Charter* | Lingkup, tim, peran, risiko — ditandatangani |
| Proposal Produk | Deskripsi masalah, fitur, teknologi yang dipakai |
| Desain awal | Wireframe / sketsa alur sistem |
| WBS / Timeline | Rencana kerja 16 minggu |
| Data calon pengguna | Hasil observasi/wawancara (minimal 3 responden) |

> Proposal yang **tidak disetujui** harus direvisi dan dipresentasikan ulang paling lambat **Minggu 5**.

---

<!-- _class: milestone -->

# 🟠 MILESTONE 1 — Minggu 8

### Yang harus siap saat demo Milestone 1:

| Item | Keterangan |
|---|---|
| **Produk berjalan** | Fitur inti (core) berfungsi — bisa di-demo secara live |
| Basis data | Skema & data uji sudah ada |
| Logbook Mgg 1–8 | Terisi lengkap tiap minggu |
| Catatan progres | Apa yang sudah, belum, dan rencana iterasi 2 |

> Evaluasi: **apakah produk inti sudah ada?** Tim yang belum memiliki produk berjalan akan mendapat **surat peringatan** dari koordinator.

---

<!-- _class: milestone -->

# 🔵 MILESTONE 2 — Minggu 12

### Yang harus siap saat demo Milestone 2:

| Item | Keterangan |
|---|---|
| **Produk fungsional lengkap** | Semua fitur utama berjalan |
| **Laporan pengujian** | Minimal pengujian fungsional (test case + hasil) |
| Logbook Mgg 9–12 | Terisi lengkap |
| Draft laporan akhir | Bab 1–3 minimal sudah ada |

> Milestone 2 adalah **quality gate** — produk yang belum lengkap tidak dapat maju ke sidang akhir tanpa persetujuan koordinator.

---

<!-- _class: milestone -->

# 🟢 MILESTONE 3 (FINAL) — Minggu 16

### Yang harus siap saat sidang akhir / Demo Day:

| Item | Keterangan |
|---|---|
| **Produk final** | Semua fitur, diperbaiki, siap demo live |
| **Laporan akhir** | Lengkap (cover, daftar isi, bab 1–5, lampiran) |
| **Presentasi** | Slide + demo langsung (maks 20 menit/tim) |
| **Peer assessment** | Diisi oleh semua anggota tim secara individual |
| Serah terima mitra | Bila ada mitra — serahkan produk + dokumentasi |

---

<!-- _class: divider -->

# Bagian 7
## Komponen & Bobot Penilaian

---

# Komponen Penilaian PBL

| Komponen | Bobot | Kapan Dinilai |
|---|---|---|
| 🛠️ **Produk** (fungsionalitas, kualitas teknis, inovasi) | **40%** | Milestone 1, 2, Final |
| 🤝 **Proses & Kolaborasi** (logbook, keaktifan, *peer assessment*) | **25%** | Tiap minggu / per milestone |
| 📄 **Dokumentasi / Laporan** | **15%** | Milestone 2 & Final |
| 🎤 **Presentasi / Demo / Sidang** | **20%** | Proposal & Final |
| | **100%** | |

> Nilai PBL dihitung dari keempat komponen, kemudian **didistribusikan ke tiap MK** sesuai tabel berikut.

---

# Distribusi Nilai ke Mata Kuliah — TI Sem 3

| Mata Kuliah | Komponen yang Diperhitungkan | Proporsi |
|---|---|---|
| Desain dan Pemrograman Web | Produk (fungsi web) + Proses + Presentasi | Besar |
| Basis Data Lanjut | Produk (BD) + Dokumentasi + Proses | Besar |
| Sistem Informasi Manajemen | Laporan (analisis SIM) + Proses | Sedang |
| Manajemen Proyek | Proses (charter/WBS/logbook) + Dokumentasi | Sedang |

> Detail formula per MK ditetapkan oleh koordinator & dosen pengampu masing-masing MK sesuai RPS.

---

# Distribusi Nilai ke Mata Kuliah — SIB Sem 3

| Mata Kuliah | Komponen yang Diperhitungkan | Proporsi |
|---|---|---|
| Pemrograman Web | Produk (fungsi web) + Proses + Presentasi | Besar |
| Basis Data Lanjut | Produk (BD) + Dokumentasi + Proses | Besar |
| Desain UI/UX | Produk (desain UI) + Dokumentasi (wireframe/prototipe) | Sedang |

> Detail formula per MK ditetapkan oleh koordinator & dosen pengampu masing-masing MK sesuai RPS.

---

# Rubrik Penilaian — Ringkasan

| Aspek | Kurang (1) | Cukup (2) | Baik (3) | Sangat Baik (4) |
|---|---|---|---|---|
| **Produk** | Tidak berjalan / tidak ada fitur | Berjalan sebagian | Semua fitur inti berjalan | Lengkap, stabil, inovatif |
| **Proses** | Logbook kosong / tidak aktif | Logbook tidak rutin | Logbook rutin, kontribusi merata | Konsisten, reflektif, tim solid |
| **Laporan** | Tidak ada / tidak lengkap | Ada tapi minim konten | Lengkap, sistematis | Lengkap, analitis, berkualitas |
| **Presentasi** | Tidak presentasi | Presentasi tidak siap | Presentasi jelas, demo berjalan | Percaya diri, demo mulus, Q&A baik |

> Rubrik lengkap tersedia di portal akademik / koordinator PBL.

---

<!-- _class: divider -->

# Bagian 8
## Mitra Industri (Opsional)

---

# Mitra Industri — Mengapa & Bagaimana?

### Mengapa dianjurkan?
- Produk menjawab masalah **nyata**, bukan fiktif
- Pengalaman berkomunikasi dengan klien profesional
- Nilai tambah di portofolio & SKPI
- Mitra bisa menjadi co-assessor (bobotnya masuk komponen Produk)

### Siapa bisa menjadi mitra?
- UMKM, toko, kafe, bengkel, dll.
- Organisasi mahasiswa / komunitas / yayasan
- Instansi pemerintah daerah / dinas
- Perusahaan (melalui jaringan dosen/alumni)

### Mekanisme:
1. Identifikasi mitra di **Minggu 1–2**
2. Lapor ke pembimbing → koordinator membantu MoU ringkas
3. Mitra hadir / dihubungi minimal di Proposal dan Milestone Final

---

<!-- _class: divider -->

# Bagian 9
## Deliverable & Checklist per Milestone

---

# Checklist Deliverable — Semua Milestone

| Deliverable | Proposal (Mgg 4) | M1 (Mgg 8) | M2 (Mgg 12) | Final (Mgg 16) |
|---|---|---|---|---|
| Project Charter | ✅ | — | — | — |
| Proposal Produk | ✅ | — | — | — |
| Logbook Mingguan | — | ✅ Mgg 1–8 | ✅ Mgg 9–12 | ✅ Lengkap |
| Demo Produk | — | ✅ Fitur inti | ✅ Fitur lengkap | ✅ Produk final |
| Laporan Pengujian | — | — | ✅ | ✅ Final |
| Laporan Akhir | — | — | ✅ Draft Bab 1–3 | ✅ Lengkap |
| Slide Presentasi | ✅ Proposal | — | — | ✅ Final |
| Peer Assessment | — | — | — | ✅ |

---

<!-- _class: divider -->

# Bagian 10
## FAQ

---

# FAQ — Pertanyaan Umum (1/2)

**Q: Apakah produk harus di-deploy ke server?**
A: Tidak wajib, tetapi sangat dianjurkan. Demo live jauh lebih kuat daripada screenshot.

**Q: Bolehkah menggunakan framework / library (React, Laravel, Bootstrap, dll.)?**
A: **Ya, boleh dan dianjurkan.** Fokus PBL pada produk dan proses, bukan reinventing the wheel.

**Q: Bagaimana jika anggota tim tidak aktif?**
A: Laporkan ke pembimbing. Anggota yang tidak aktif akan dikurangi nilainya melalui mekanisme *peer assessment* dan evaluasi pembimbing.

**Q: Apakah bisa satu tim, dua prodi (TI + SIB)?**
A: Di Semester 3 ini **tidak** — tim dibentuk per prodi. Kolaborasi lintas prodi akan dipertimbangkan di semester yang lebih tinggi.

---

# FAQ — Pertanyaan Umum (2/2)

**Q: Jika tidak punya mitra, apakah nilai dikurangi?**
A: Tidak. Mitra bersifat opsional. Namun proyek tetap harus menjawab kebutuhan nyata (bisa simulasi/internal kampus).

**Q: Apakah logbook diisi tiap hari atau tiap minggu?**
A: **Tiap minggu** — satu entri per minggu per tim (bisa ditambah catatan harian bila mau).

**Q: Bolehkah topik/produk diganti setelah proposal disetujui?**
A: **Tidak**, kecuali ada alasan sangat mendasar dan sudah disetujui koordinator & pembimbing secara tertulis.

**Q: Di mana template dokumen bisa diunduh?**
A: Di portal akademik jurusan atau hubungi koordinator PBL prodi Anda.

---

# Kontak & Informasi

### Koordinator PBL Semester 3

| Prodi | Koordinator | Kontak |
|---|---|---|
| Teknik Informatika | *(isi nama koordinator)* | *(email/WA)* |
| Sistem Informasi Bisnis | *(isi nama koordinator)* | *(email/WA)* |

### Tautan Penting
- 📂 Template dokumen: *(isi link)*
- 📋 Portal pengumpulan: *(isi link)*
- 📅 Jadwal bimbingan: *(isi link)*

---

<!-- _class: cover -->
<!-- _paginate: false -->

# Selamat Berkarya! 🚀

### PBL bukan tentang kesempurnaan di awal.
### PBL tentang **belajar, membangun, dan bertumbuh** — bersama.

**Jurusan Teknologi Informasi · Politeknik Negeri Malang**
*ti@polinema.ac.id*
