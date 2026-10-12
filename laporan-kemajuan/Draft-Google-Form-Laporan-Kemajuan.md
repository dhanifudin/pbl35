# Draf Google Form: Pengumpulan Laporan Kemajuan PBL (Milestone 1)

Dokumen ini adalah draf untuk koordinator PBL dalam membuat Google Form pengumpulan Laporan Kemajuan. Isinya mengikuti SOP Pengumpulan Laporan Kemajuan PBL: satu tim mengumpulkan satu berkas PDF (laporan beserta lampiran), dan form hanya memiliki satu kolom unggah berkas.

Hal yang diperbaiki dari form pengumpulan proposal sebelumnya:

- Kolom kelas dibuat sebagai pilihan terbatas (dropdown), karena pada form proposal kolom ini diisi bebas dan hasilnya tidak seragam ("G", "Kelompok 5", "TI3H#1").
- Label ditulis dalam satu bahasa (Indonesia) agar form lebih ringkas.
- Ditambahkan pernyataan kelengkapan agar tim memeriksa laporan sebelum mengirim.

---

## 1. Pengaturan Form

| Pengaturan | Nilai |
|---|---|
| Judul form | Pengumpulan Laporan Kemajuan PBL (Milestone 1) |
| Kumpulkan alamat email | Aktif (verifikasi) |
| Wajib masuk akun Google | Ya (diperlukan oleh fitur unggah berkas) |
| Izinkan ubah jawaban setelah dikirim | Aktif, agar revisi sebelum batas akhir tidak menghasilkan entri ganda |
| Batasi satu tanggapan | Tidak dipakai; entri ganda diperiksa saat rekap (lihat Bagian 5) |
| Batas akhir | **[tanggal], pukul 23.59 WIB**; tutup penerimaan jawaban pada batas akhir |

### Deskripsi form (teks yang ditampilkan di bagian atas)

> Form ini digunakan untuk mengumpulkan **Laporan Kemajuan PBL (Milestone 1)**.
>
> - Satu tim mengumpulkan **satu berkas PDF** (laporan beserta seluruh lampirannya). Form diisi oleh Ketua Tim.
> - Batas akhir pengumpulan: **[tanggal], pukul 23.59 WIB**.
> - Struktur laporan dan ketentuan pengumpulan (SOP dan Template Laporan Kemajuan PBL) tersedia pada folder berikut: https://drive.google.com/drive/folders/15q1RaS64I4VPQ4aTbJetim0Yu0IxdbBt?usp=drive_link
> - Template hanya menjelaskan struktur laporan dan tidak untuk disalin.

---

## 2. Bagian 1: Identitas Tim

Semua pertanyaan pada bagian ini wajib diisi.

| No | Pertanyaan | Jenis | Isian dan validasi |
|---|---|---|---|
| 1 | Program Studi | Pilihan ganda | Teknik Informatika (TI); Sistem Informasi Bisnis (SIB) |
| 2 | Tingkat dan Semester | Pilihan ganda | Tingkat 2, Semester 3; Tingkat 3, Semester 5 |
| 3 | Kelas | Dropdown | TI: TI-2A sampai TI-2I (Semester 3) dan TI-3A sampai TI-3I (Semester 5); SIB: **[daftar kelas SIB diisi koordinator, misalnya SIB-3G]** |
| 4 | Nama Tim | Jawaban singkat | Sama dengan nama tim pada proposal dan sampul laporan |
| 5 | Judul Produk | Jawaban singkat | Sama dengan judul produk pada sampul laporan |
| 6 | Nama Ketua Tim | Jawaban singkat | Nama lengkap sesuai data akademik |
| 7 | NIM Ketua Tim | Jawaban singkat | Hanya angka, 12 digit (validasi: angka, panjang tepat 12 karakter) |

---

## 3. Bagian 2: Berkas Laporan

| No | Pertanyaan | Jenis | Ketentuan |
|---|---|---|---|
| 8 | Berkas Laporan Kemajuan (PDF) | Unggah berkas (wajib) | Hanya PDF; maksimum 1 berkas; ukuran maksimum 50 MB (dokumen besar cukup ditautkan sesuai SOP Bagian 7). Nama berkas `LapKemajuan_<Kelas>_<NamaTim>.pdf`. Ini satu-satunya kolom unggah pada form. |
| 9 | Pernyataan kelengkapan | Kotak centang (semua wajib dicentang) | Lihat daftar pernyataan di bawah |
| 10 | Catatan Tambahan | Paragraf (opsional) | Kendala atau informasi yang perlu disampaikan kepada koordinator |

### Pernyataan kelengkapan (pertanyaan 9)

Pernyataan berikut ditampilkan sebagai kotak centang, dan seluruhnya wajib dicentang sebelum form dikirim:

1. Berkas PDF memuat sampul, Bagian 1–11, dan lampiran sesuai struktur Template Laporan Kemajuan PBL.
2. Seluruh tautan eksternal sudah diuji di jendela penyamaran (*incognito*) dan dapat dibuka tanpa login.
3. Dokumen tambahan mata kuliah (bila ada) sudah dilampirkan atau ditautkan pada Lampiran D.
4. Laporan disusun mengikuti struktur template dan bukan salinan template.

---

## 4. Pesan Setelah Form Dikirim

> Terima kasih. Laporan tim telah diterima. Jawaban dapat diubah hingga batas akhir pengumpulan melalui tautan "Edit jawaban".

---

## 5. Panduan Koordinator

- Hubungkan jawaban form ke Google Sheets. Urutan kolom hasil mengikuti urutan pertanyaan di atas.
- Periksa entri ganda dengan kombinasi Kelas dan Nama Tim, dan gunakan entri terbaru.
- Berkas unggahan tersimpan pada folder Google Drive milik form. Salin tautannya ke rekap atau rubrik bila diperlukan.
- Dokumen mata kuliah yang dikumpulkan pada jalurnya sendiri (misalnya folder Snapshot_UTS pada Manajemen Proyek) tidak dikumpulkan melalui form ini.

## 6. Daftar Periksa Sebelum Membagikan Form

- [ ] Isi `[tanggal]` pada deskripsi form dan pengaturan penutupan.
- [ ] Isi daftar kelas SIB pada pertanyaan 3.
- [ ] Kirim satu data uji, lalu pastikan berkas unggahan dapat dibuka.
- [ ] Ganti `[tautan Google Form]` pada SOP (langkah 9) dan pengumuman untuk dosen.
- [ ] Pastikan hanya koordinator PBL yang memiliki akses edit form.
