# Form Penilaian 360 (Milestone 2)

Berkas `Buat-Form-Penilaian-360.gs` membuat Google Form Penilaian 360 secara otomatis dari daftar tim, sesuai SOP Bagian 9.3 dan Form 3 pada `Draft-Google-Form-Milestone-2.md`. Koordinator tidak perlu membuat bagian tiap tim satu per satu.

## Langkah

1. Siapkan daftar tim dari spreadsheet: satu baris per anggota, kolom Kelas, Tim, Nama Anggota. Gabungkan kolomnya dengan titik koma, misalnya `TI-2A;Tim Contoh Satu;Anggota A1`.
2. Buka https://script.google.com dengan akun Polinema koordinator, lalu buat proyek baru.
3. Tempel isi `Buat-Form-Penilaian-360.gs`. Ganti isi `DAFTAR_TIM` dengan daftar tadi, dan isi `BATAS_AKHIR`.
4. Jalankan `buatFormPenilaian360`, lalu beri izin. Tautan form untuk peserta dan tautan edit muncul di Execution log.
5. Buka tautan edit, tab Tanggapan, dan hubungkan ke Google Sheets.

## Isi form

- Pengaturan: email dikumpulkan, satu tanggapan per akun, jawaban bisa diubah sampai batas akhir, pesan terima kasih sesuai draf.
- Alur: pilih Kelas, lalu Tim, lalu bagian tim itu. Tiap tim hanya melihat nama anggotanya sendiri, dan form langsung selesai setelah bagian tim.
- Bagian tim: Nama Anda, empat kisi skala 1–5 (kontribusi pekerjaan, tanggung jawab dan ketepatan waktu, kerja sama dan komunikasi, kehadiran dan keterlibatan), satu isian poin (0–100) untuk tiap anggota, dan komentar opsional.

## Yang perlu diperiksa sendiri

- **Jumlah poin harus 100.** Google Form tidak bisa memeriksa jumlah antar isian, jadi hanya tiap isian yang dibatasi 0–100. Periksa jumlahnya di spreadsheet dan minta pengisi memperbaiki bila bukan 100 (Panduan Koordinator, Form 3).
- **Pembatasan akun Polinema** (`setRequireLogin`) hanya berlaku di akun Google Workspace. Bila akun skrip bukan Workspace Polinema, atur di Pengaturan form: batasi ke pengguna di organisasi.
- Kirim satu tanggapan uji, pastikan terbaca di spreadsheet, lalu hapus tanggapan itu.
- Hanya koordinator yang boleh punya akses edit dan akses ke tanggapan. Jangan bagikan tautan edit.
- Skrip ini tidak membuat rekap. Rekap per mahasiswa (rata-rata skor dan poin dari rekan, tanpa penilaian diri) dibuat dari spreadsheet tanggapan.
