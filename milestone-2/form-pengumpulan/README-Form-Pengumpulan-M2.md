# Form Pengumpulan Laporan Milestone 2

Berkas `Buat-Form-Pengumpulan-M2.gs` membuat Google Form pengumpulan laporan secara otomatis, sesuai Form 2 pada `Draft-Google-Form-Milestone-2.md`. Batas akhir pengumpulan: **27 November 2026, pukul 23.59 WIB**. Penilaian 360 adalah form terpisah (lihat `../penilaian-360/`).

## Langkah

1. Buka https://script.google.com dengan akun Polinema koordinator, lalu buat proyek baru.
2. Tempel isi `Buat-Form-Pengumpulan-M2.gs`, jalankan `buatFormPengumpulanM2`, dan beri izin.
3. Tautan form untuk peserta dan tautan edit muncul di Execution log.
4. **Tambahkan pertanyaan unggah berkas secara manual**, karena Apps Script tidak bisa membuatnya:
   1. Buka tautan edit form, lalu buka bagian "Berkas".
   2. Klik "Tambahkan pertanyaan" dan ubah jenisnya menjadi "Upload file".
   3. Judul: `Berkas Laporan Milestone 2 (PDF)`. Aktifkan "Wajib diisi".
   4. Jenis berkas yang diizinkan: hanya PDF. Jumlah maksimum berkas: 1. Ukuran maksimum: 50 MB.
   5. Seret pertanyaan ini ke posisi tepat di bawah judul bagian "Berkas", sebelum "Pernyataan kelengkapan".
5. Buka tab Tanggapan, hubungkan ke Google Sheets, dan simpan lembar tanggapan.
6. Kirim satu tanggapan uji, pastikan berkas PDF-nya bisa dibuka, lalu hapus tanggapan uji.
7. Bagikan hanya tautan peserta. Hanya koordinator PBL yang punya akses edit.

## Pengaturan yang dipakai

- Email dikumpulkan, jawaban boleh diubah sampai form ditutup, tidak ada batas satu tanggapan per akun (satu tim satu jawaban; entri ganda diperiksa dengan kombinasi Kelas dan Nama Tim, pakai entri terbaru).
- Pertanyaan unggah berkas mewajibkan peserta masuk dengan akun Google. Karena itu pembatasan ke akun Polinema sebaiknya diatur juga di Pengaturan form.
- Form tidak ditutup otomatis. Setelah **27 November 2026, pukul 23.59 WIB**, tutup form secara manual: tab Tanggapan, matikan "Menerima tanggapan". Untuk tim yang terlambat tetapi sudah menghubungi koordinator sebelum batas akhir, aktifkan kembali sementara atau terima berkasnya lewat jalur lain, sesuai aturan mata kuliah.
- Pertanyaan "Bentuk demo yang diusulkan tim" hanya usulan. Dosen tiap kelas menentukan jadwal dan bentuk akhir demo (SOP Bagian 10.6).

## Daftar periksa sebelum membagikan

- [ ] Pertanyaan unggah berkas sudah ditambahkan, wajib, hanya PDF, 1 berkas, 50 MB.
- [ ] Tanggapan uji terkirim dan berkasnya terbaca, lalu tanggapan uji dihapus.
- [ ] Lembar tanggapan terhubung dan hanya koordinator yang punya akses.
- [ ] Tautan peserta dikirim ke grup WhatsApp, dan SOP Bagian 11 (langkah 8) serta pengumuman memakai tautan yang sama.
