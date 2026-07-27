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
    background: linear-gradient(145deg, #1a1a2e 60%, #003b7a 100%);
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

# 📗 Sosialisasi PBL
## *Project-Based Learning* Product-Based
### Semester 5 — Teknik Informatika & Sistem Informasi Bisnis
#### Jurusan Teknologi Informasi · Politeknik Negeri Malang · 2025/2026

---

# Agenda

1. Recap PBL & apa yang berbeda di Semester 5
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
## Semester 5: PBL di Level yang Lebih Tinggi

---

# PBL di Semester 5 — Apa yang Berbeda?

Di Semester 3 Anda sudah punya dasar. Di Semester 5, **skalanya naik.**

| Aspek | Semester 3 | Semester 5 |
|---|---|---|
| Teknologi | Web + BD | **Mobile + ML** (TI) / **Web Lanjut** (SIB) |
| Kompleksitas produk | Fitur inti, satu konteks | Fitur kompleks, integrasi, siap pakai |
| Pengujian | Pengujian fungsional dasar | **Penjaminan Mutu** terstruktur (QA formal) |
| Kedalaman analisis | Kebutuhan pengguna | Kebutuhan + performa + kualitas kode |
| Ekspektasi laporan | Sistematis | Sistematis & **analitis mendalam** |

> Semester 5 adalah batu loncatan menuju Tugas Akhir. Produk yang baik bisa dilanjutkan sebagai **fondasi TA/Skripsi**.

---

# Mengapa PBL Masih Relevan di Semester 5?

- Mata kuliah Semester 5 saling berkaitan erat (Mobile ↔ ML, Web Lanjut ↔ Mutu)
- Industri mencari lulusan yang bisa **mengintegrasikan** teknologi, bukan hanya menguasai satu MK
- Proyek di Semester 5 memberi portofolio yang **lebih matang & kompleks**
- Pengalaman QA formal (PMPL) sangat dicari di dunia kerja

---

# Model & Aturan Tim

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
| **Sekretaris / Dokumentator** | Logbook, laporan, notulensi, dan manajemen dokumen QA |
| **Pengembang Utama** | Penanggungjawab teknis (mobile dev / web dev / ML model) |
| **ML Engineer / Arsitek Sistem** | Model ML / integrasi API / arsitektur sistem (TI); Arsitek web lanjut (SIB) |
| **QA / Penguji** | Menyusun rencana & dokumen pengujian (PMPL), eksekusi test case |

> Di Sem 5, peran **QA lebih formal** — ada dokumen pengujian yang dinilai tersendiri.

---

<!-- _class: divider -->

# Bagian 3
## Integrasi Mata Kuliah

---

# Integrasi MK — Teknik Informatika (Sem 5)

Produk PBL dikerjakan **dalam konteks** mata kuliah berikut:

| Mata Kuliah | Peran dalam PBL | Kategori |
|---|---|---|
| **Pemrograman Mobile** | Implementasi aplikasi mobile (Android/iOS/multiplatform) | 🔵 **Inti** |
| **Pembelajaran Mesin** | Model ML terintegrasi ke dalam produk mobile | 🔵 **Inti** |
| **Penjaminan Mutu Perangkat Lunak** | Perencanaan pengujian, test case, laporan QA, bug tracking | 🟡 Pendukung |

> **Tantangan TI Sem 5:** mengintegrasikan ML (model, data, prediksi) ke dalam aplikasi mobile yang benar-benar berjalan — bukan hanya eksperimen Jupyter Notebook.

---

# Integrasi MK — Sistem Informasi Bisnis (Sem 5)

| Mata Kuliah | Peran dalam PBL | Kategori |
|---|---|---|
| **Pemrograman Web Lanjut** | Implementasi aplikasi web kompleks (SPA, API, auth, dsb.) | 🔵 **Inti** |
| **Manajemen Proyek** | Perencanaan proyek, WBS, manajemen risiko & perubahan | 🟡 Pendukung |
| **Penjaminan Mutu Perangkat Lunak** | Perencanaan pengujian, test case, laporan QA, bug tracking | 🟡 Pendukung |

> **Tantangan SIB Sem 5:** membangun aplikasi web bisnis yang kompleks (mis. multi-role, dashboard analitik, atau integrasi layanan) dengan proses pengujian formal dan manajemen proyek yang terstruktur.

---

<!-- _class: divider -->

# Bagian 4
## Target Produk Semester 5

---

# Target Produk — Teknik Informatika

### 📱🤖 Aplikasi Mobile ber-Fitur Machine Learning

Produk yang Anda kembangkan adalah **aplikasi mobile yang mengintegrasikan setidaknya satu fitur berbasis ML** dan telah melalui pengujian mutu yang terstruktur.

**Kriteria minimum produk TI Sem 5:**
- ✅ Aplikasi mobile berjalan di perangkat (Android/iOS/emulator)
- ✅ Mengandung **minimal 1 fitur berbasis ML** (klasifikasi, deteksi, rekomendasi, prediksi, dll.)
- ✅ Model ML **diintegrasikan ke dalam aplikasi** (bukan hanya notebook)
- ✅ Ada dokumentasi pengujian QA (rencana uji, test case, hasil)
- ✅ Performa model ML didokumentasikan (akurasi, confusion matrix, dll.)

---

# Contoh Ide Produk — TI Sem 5

> Ini **contoh** — Anda bebas mengusulkan ide lain selama sesuai kriteria.

- 🩺 Aplikasi deteksi dini penyakit dari foto (klasifikasi gambar — kulit, mata, dll.)
- 🌾 Aplikasi mobile untuk petani: prediksi hasil panen / deteksi hama dari foto
- 🗣️ Aplikasi bantu komunikasi: pengenalan bahasa isyarat via kamera
- 😊 Aplikasi kesehatan mental: analisis sentimen catatan harian
- 🚗 Aplikasi deteksi kerusakan kendaraan dari foto (untuk UMKM bengkel)
- 📚 Aplikasi rekomendasi belajar adaptif berdasarkan performa pengguna
- 🏠 Aplikasi prediksi harga properti berbasis lokasi & fitur rumah

> 💡 Pilih domain yang **ada datanya** atau bisa Anda kumpulkan — data adalah fondasi ML.

---

# Target Produk — Sistem Informasi Bisnis

### 🌐⚙️ Aplikasi Web Bisnis Lanjut — Terkelola & Teruji

Produk yang Anda kembangkan adalah **aplikasi web bisnis yang kompleks**, dikelola dengan manajemen proyek yang baik, dan telah melalui pengujian mutu terstruktur.

**Kriteria minimum produk SIB Sem 5:**
- ✅ Aplikasi web berjalan penuh dengan arsitektur yang lebih matang (mis. API-first, SPA, atau fullstack framework modern)
- ✅ Minimal **3 peran pengguna** atau kompleksitas fitur yang signifikan
- ✅ Ada **dokumentasi QA** (rencana uji, test case, hasil uji, bug tracking)
- ✅ Proses dikelola dengan prinsip **Manajemen Proyek** (WBS, risiko, perubahan didokumentasikan)
- ✅ Dashboard / laporan / fitur analitik (minimal sederhana)

---

# Contoh Ide Produk — SIB Sem 5

> Ini **contoh** — Anda bebas mengusulkan ide lain selama sesuai kriteria.

- 🛒 Platform e-commerce multi-vendor dengan manajemen stok & laporan penjualan
- 🏨 Sistem reservasi & manajemen properti/penginapan (hotel kecil, kos)
- 🏥 Sistem informasi klinik: antrian, rekam medis dasar, laporan kunjungan
- 📊 Dashboard analitik bisnis untuk rantai toko / UMKM multi-cabang
- 🎓 Sistem manajemen pelatihan/kursus: pendaftaran, materi, progres, sertifikat
- 🤝 Portal manajemen proyek internal tim (seperti mini Trello/Jira)
- 📦 Sistem pengadaan & manajemen vendor untuk instansi kecil

> 💡 Di Sem 5, produk yang diteruskan dari Sem 3 (**upgrade/rekonstruksi besar**) sangat diperbolehkan dan diapresiasi.

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
| Fase 1 | Ide produk, pernyataan masalah, studi kelayakan (termasuk data/dataset untuk ML) |
| Fase 2 | *Project charter*, proposal produk, rencana QA awal |
| Fase 3 | Produk bertahap (iterasi 1 & 2), logbook mingguan, rencana uji |
| Fase 4 | Produk final teruji, laporan QA lengkap, laporan akhir |
| Fase 5 | Demo/expo, presentasi, serah terima ke mitra (bila ada) |

---

# Fase 1 — Identifikasi Masalah & Ide Produk (Mgg 1–3)

**Tujuan:** menemukan masalah nyata dan menentukan produk + teknologi yang akan dipakai.

**Aktivitas:**
- Brainstorming ide dalam tim
- **TI:** eksplorasi dataset yang tersedia (Kaggle, data mitra, data publik)
- Analisis kelayakan teknis (apakah modelnya bisa dibuat? data cukup? runtime di mobile?)
- Penentuan arsitektur kasar

**Output untuk Fase 1:**
- ✅ Pernyataan masalah & deskripsi produk
- ✅ **TI:** sumber dataset & baseline akurasi target
- ✅ **SIB:** daftar kebutuhan bisnis & fitur utama

---

# Fase 2 — Perencanaan (Mgg 3–4)

**Tujuan:** menetapkan rencana yang matang sebelum mulai membangun.

**Aktivitas:**
- Menyusun *project charter* (tujuan, lingkup, tim, risiko, rencana manajemen perubahan)
- Menyusun proposal produk (arsitektur sistem, fitur, teknologi, metodologi ML jika ada)
- Menyusun **rencana pengujian awal** (QA plan) — untuk semua prodi di Sem 5
- Sidang/review proposal → **MILESTONE PROPOSAL (Minggu 4)**

**Output untuk Fase 2:**
- ✅ *Project charter*
- ✅ Proposal produk + arsitektur + rencana QA awal
- ✅ Timeline & pembagian tugas

---

# Fase 3 — Pengembangan Iteratif (Mgg 5–12)

**Iterasi 1 (Mgg 5–8):**
- **TI:** training model ML baseline + scaffolding aplikasi mobile → demo Milestone 1
- **SIB:** modul utama aplikasi web lanjut berjalan → demo Milestone 1

**Iterasi 2 (Mgg 9–12):**
- **TI:** integrasi model ke mobile, fitur lengkap, mulai QA → demo Milestone 2
- **SIB:** fitur lengkap, integrasi, pengujian QA dimulai → demo Milestone 2

**Aktivitas rutin:**
- Logbook mingguan (kemajuan, hambatan, rencana)
- Bimbingan berkala dengan dosen pembimbing
- **Update rencana pengujian** seiring perkembangan produk

---

# Fase 4 — Pengujian & Pengemasan (Mgg 13–15)

**Tujuan:** memastikan produk berkualitas dan siap dipresentasikan.

**Aktivitas:**
- Eksekusi test case dari QA plan
- Bug tracking & perbaikan
- **TI:** evaluasi final model ML (akurasi, recall, precision), optimasi performa di mobile
- Penulisan laporan akhir (termasuk bab QA dan analisis hasil)
- Penyiapan demo/expo

**Output:**
- ✅ Laporan QA lengkap (rencana uji, hasil uji, bug, resolusi)
- ✅ **TI:** laporan evaluasi model ML
- ✅ Laporan akhir proyek
- ✅ Produk siap demo

---

# Fase 5 — Presentasi & Diseminasi (Mgg 16)

**Tujuan:** menampilkan produk kepada penguji, dosen, dan (bila ada) mitra.

**Aktivitas:**
- **Sidang akhir / Demo Day / Expo**
- Presentasi + demo langsung produk (live demo wajib)
- Tanya jawab dengan dosen penguji
- Serah terima produk ke mitra (jika ada)
- *Peer assessment* antar-anggota tim

**Output:**
- ✅ Presentasi final + demo (live, bukan video)
- ✅ *Peer assessment* diisi semua anggota
- ✅ Semua dokumen final dikumpulkan (termasuk laporan QA & kode sumber)

---

<!-- _class: divider -->

# Bagian 6
## Timeline 16 Minggu & 4 Milestone

---

# Timeline 16 Minggu

| Minggu | Kegiatan | Milestone |
|---|---|---|
| 1 – 3 | Pembentukan tim · Identifikasi masalah · Eksplorasi data/teknologi | — |
| **4** | **Sidang/review proposal + QA plan awal** | 🟡 **PROPOSAL** |
| 5 – 7 | Iterasi 1: fitur inti / model ML baseline / scaffolding | — |
| **8** | **Demo progres: fitur inti / model baseline berjalan** | 🟠 **MILESTONE 1** |
| 9 – 11 | Iterasi 2: integrasi, fitur lengkap, pengujian dimulai | — |
| **12** | **Demo: produk fungsional lengkap + laporan QA interim** | 🔵 **MILESTONE 2** |
| 13 – 15 | Perbaikan · Laporan QA final · Laporan akhir · Persiapan expo | — |
| **16** | **Sidang akhir / Demo Day / Expo** | 🟢 **MILESTONE 3 (FINAL)** |

---

<!-- _class: milestone -->

# 🟡 PROPOSAL — Minggu 4

### Yang harus siap saat review proposal:

| Item | Keterangan |
|---|---|
| *Project Charter* | Lingkup, tim, peran, risiko, rencana manajemen perubahan |
| Proposal Produk | Fitur, arsitektur sistem, teknologi yang dipilih |
| **Rencana QA awal** | Jenis pengujian yang akan dilakukan, scope QA |
| **TI:** Dataset / sumber data | Dataset yang dipakai, baseline akurasi yang ditargetkan |
| **SIB:** Arsitektur web lanjut | Diagram arsitektur, framework, rencana API/modul |
| WBS / Timeline | Rencana kerja 16 minggu |

> Proposal yang **tidak disetujui** direvisi paling lambat **Minggu 5**.

---

<!-- _class: milestone -->

# 🟠 MILESTONE 1 — Minggu 8

### Yang harus siap saat demo Milestone 1:

| Item | Keterangan |
|---|---|
| **TI: Model ML baseline** | Model terlatih, akurasi awal terdokumentasi |
| **TI: Scaffolding mobile** | Struktur aplikasi berjalan, integrasi awal model |
| **SIB: Modul utama berjalan** | Fitur inti aplikasi web lanjut dapat di-demo |
| Logbook Mgg 1–8 | Terisi lengkap tiap minggu |
| Update QA plan | Disesuaikan dengan progress aktual |

> Evaluasi: **apakah fondasi teknis sudah kokoh?** TI: model ada + mobile berjalan. SIB: modul inti berfungsi.

---

<!-- _class: milestone -->

# 🔵 MILESTONE 2 — Minggu 12

### Yang harus siap saat demo Milestone 2:

| Item | Keterangan |
|---|---|
| **Produk fungsional lengkap** | Semua fitur utama berjalan dan terintegrasi |
| **TI:** Model ML terintegrasi | Prediksi/klasifikasi berjalan dalam aplikasi mobile |
| **Laporan QA interim** | Test case terdokumentasi, bug yang ditemukan, status resolusi |
| Logbook Mgg 9–12 | Terisi lengkap |
| Draft laporan akhir | Minimal Bab 1–3 tersedia |

> Milestone 2 adalah **quality gate** — QA plan harus sudah berjalan, bukan baru dimulai.

---

<!-- _class: milestone -->

# 🟢 MILESTONE 3 (FINAL) — Minggu 16

### Yang harus siap saat sidang akhir / Demo Day:

| Item | Keterangan |
|---|---|
| **Produk final** | Semua fitur, diperbaiki, demo live siap |
| **Laporan QA lengkap** | Rencana uji, hasil uji, bug log, resolusi, analisis kualitas |
| **TI:** Laporan evaluasi model ML | Akurasi, confusion matrix, analisis performa di mobile |
| **Laporan akhir** | Lengkap (cover, daftar isi, Bab 1–5, lampiran) |
| **Presentasi** | Slide + demo langsung (maks 20 menit/tim) |
| **Peer assessment** | Diisi oleh semua anggota tim secara individual |
| Kode sumber | Repositori (Git) terkumpul / diserahkan |

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
| 📄 **Dokumentasi / Laporan** (termasuk laporan QA & ML) | **15%** | Milestone 2 & Final |
| 🎤 **Presentasi / Demo / Sidang** | **20%** | Proposal & Final |
| | **100%** | |

> Di Semester 5, **kualitas dokumen QA** masuk dalam komponen Dokumentasi (dinilai lebih ketat dibanding Sem 3).

---

# Distribusi Nilai ke Mata Kuliah — TI Sem 5

| Mata Kuliah | Komponen yang Diperhitungkan | Proporsi |
|---|---|---|
| Pemrograman Mobile | Produk (aplikasi mobile) + Proses + Presentasi | Besar |
| Pembelajaran Mesin | Produk (model ML + integrasinya) + Dokumentasi (eval model) | Besar |
| Penjaminan Mutu PL | Dokumentasi QA (rencana, hasil, bug) + Proses | Sedang |

> Detail formula per MK ditetapkan oleh koordinator & dosen pengampu sesuai RPS.

---

# Distribusi Nilai ke Mata Kuliah — SIB Sem 5

| Mata Kuliah | Komponen yang Diperhitungkan | Proporsi |
|---|---|---|
| Pemrograman Web Lanjut | Produk (aplikasi web) + Proses + Presentasi | Besar |
| Manajemen Proyek | Proses (charter, WBS, manajemen perubahan) + Dokumentasi | Sedang |
| Penjaminan Mutu PL | Dokumentasi QA (rencana, hasil, bug) + Proses | Sedang |

> Detail formula per MK ditetapkan oleh koordinator & dosen pengampu sesuai RPS.

---

# Rubrik Penilaian — Ringkasan Sem 5

| Aspek | Kurang (1) | Cukup (2) | Baik (3) | Sangat Baik (4) |
|---|---|---|---|---|
| **Produk** | Tidak berjalan | Berjalan sebagian / tanpa ML terintegrasi | Semua fitur inti + ML/fitur lanjut berjalan | Lengkap, stabil, performa baik, inovatif |
| **Proses** | Logbook kosong / tidak aktif | Logbook tidak rutin | Logbook rutin, kontribusi merata | Konsisten, reflektif, manajemen proyek solid |
| **QA / Laporan** | Tidak ada dokumen QA | Ada QA plan tapi tidak dieksekusi | QA plan + test case + hasil uji ada | Komprehensif, bug tertangani, analisis mendalam |
| **Presentasi** | Tidak presentasi | Presentasi tanpa demo live | Presentasi jelas, demo berjalan | Percaya diri, demo mulus, Q&A mendalam |

---

<!-- _class: divider -->

# Bagian 8
## Mitra Industri (Opsional)

---

# Mitra Industri — Lebih Strategis di Sem 5

### Mengapa sangat dianjurkan di Semester 5?
- Produk ML / web lanjut lebih berarti dengan **data dan konteks nyata**
- Validasi model ML oleh pengguna nyata = nilai akademik & praktis lebih tinggi
- Pengalaman deploying ke lingkungan produksi (bukan hanya dev)
- Dokumen QA yang diverifikasi pengguna = portofolio yang kuat

### Siapa bisa menjadi mitra?
- UMKM, klinik, toko, institusi pendidikan, komunitas
- Perusahaan IT (bisa sebagai pemberi data atau co-tester)
- Instansi pemerintah / dinas (data publik + konteks nyata)

### Mekanisme:
1. Identifikasi mitra di **Minggu 1–2**
2. Lapor ke pembimbing → koordinator bantu fasilitasi
3. Mitra terlibat minimal di: validasi kebutuhan (Fase 1), review Milestone 2, dan Demo Day

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
| QA Plan | ✅ Awal | ✅ Update | ✅ Lengkap | ✅ Final |
| Logbook Mingguan | — | ✅ Mgg 1–8 | ✅ Mgg 9–12 | ✅ Lengkap |
| Demo Produk | — | ✅ Fitur inti/baseline | ✅ Fitur lengkap | ✅ Produk final |
| Lap. Pengujian (QA) | — | — | ✅ Interim | ✅ Final |
| **TI:** Eval Model ML | — | ✅ Baseline | ✅ Iterasi | ✅ Final |
| Laporan Akhir | — | — | ✅ Draft Bab 1–3 | ✅ Lengkap |
| Slide Presentasi | ✅ Proposal | — | — | ✅ Final |
| Kode Sumber (Git) | — | — | — | ✅ |
| Peer Assessment | — | — | — | ✅ |

---

<!-- _class: divider -->

# Bagian 10
## FAQ

---

# FAQ — Pertanyaan Umum (1/2)

**Q: Apakah model ML harus buatan sendiri atau boleh pakai pre-trained model?**
A: **Boleh keduanya.** Fine-tuning pre-trained model (transfer learning) tetap dihargai — yang dinilai adalah kemampuan integrasi, pemahaman model, dan evaluasinya.

**Q: Dataset harus seberapa besar?**
A: Tidak ada minimum angka pasti, tapi harus cukup untuk menghasilkan model yang dapat di-evaluasi. Konsultasikan ke dosen ML Anda di Fase 1.

**Q: Bolehkah aplikasi mobile hanya di Android (tidak iOS)?**
A: **Boleh.** Android (native atau via framework seperti Flutter/React Native) sudah cukup. Yang penting bisa di-demo di perangkat atau emulator.

**Q: Apakah QA harus pakai tools tertentu (Selenium, Jest, dll.)?**
A: Tidak diwajibkan tools spesifik. Yang dinilai adalah **proses** (rencana uji, test case, hasil, bug tracking) — tools menyesuaikan tumpukan teknologi produk.

---

# FAQ — Pertanyaan Umum (2/2)

**Q: Jika produk dari Sem 3 ingin dilanjutkan/di-upgrade, apakah boleh?**
A: **Sangat boleh dan diapresiasi**, selama ada **peningkatan signifikan** (fitur baru, teknologi lebih kompleks, QA formal). Tidak boleh hanya menyerahkan produk Sem 3 tanpa perubahan berarti.

**Q: Apakah Laporan QA terpisah dari Laporan Akhir?**
A: Laporan QA bisa menjadi bagian (bab) dari Laporan Akhir atau dokumen terpisah — tergantung ketentuan koordinator. Yang penting isinya ada dan lengkap.

**Q: Bagaimana jika anggota tim tidak aktif?**
A: Laporkan ke pembimbing. Anggota tidak aktif akan dikurangi nilainya melalui *peer assessment* dan evaluasi pembimbing.

**Q: Di mana template dokumen bisa diunduh?**
A: Di portal akademik jurusan atau hubungi koordinator PBL prodi Anda.

---

# Kontak & Informasi

### Koordinator PBL Semester 5

| Prodi | Koordinator | Kontak |
|---|---|---|
| Teknik Informatika | *(isi nama koordinator)* | *(email/WA)* |
| Sistem Informasi Bisnis | *(isi nama koordinator)* | *(email/WA)* |

### Tautan Penting
- 📂 Template dokumen: *(isi link)*
- 📋 Portal pengumpulan: *(isi link)*
- 📅 Jadwal bimbingan: *(isi link)*
- 🗂️ Repository kode (panduan): *(isi link)*

---

<!-- _class: cover -->
<!-- _paginate: false -->

# Selamat Berkarya! 🚀

### Semester 5 adalah momen Anda membuktikan bahwa
### **teknologi kompleks pun bisa dikuasai dan diintegrasikan.**

**Jurusan Teknologi Informasi · Politeknik Negeri Malang**
*ti@polinema.ac.id*
