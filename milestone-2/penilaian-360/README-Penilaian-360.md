# Form Penilaian 360 (Milestone 2)

Berkas `Buat-Form-Penilaian-360.gs` membuat Google Form Penilaian 360 dari daftar tim dan membuat **Rekap otomatis** untuk dosen, sesuai SOP Bagian 9.3 dan Form 3 pada `Draft-Google-Form-Milestone-2.md`.

**Tujuan:** mengumpulkan informasi lengkap tentang kontribusi nyata tiap anggota (tim 4–6 orang) untuk memberi kredit dan memvalidasi kontribusi. Setiap anggota menilai seluruh rekan **dan dirinya sendiri** (360 derajat). Tidak ada pembatasan privasi penilai: koordinator dan dosen pengampu melihat siapa menilai siapa. Rekan satu tim tidak melihat hasilnya.

## Langkah

1. Siapkan daftar tim: satu baris per anggota, kolom Kelas, Tim, Nama Anggota, dipisah titik koma, misalnya `TI-2A;Tim Contoh Satu;Anggota A1`. Untuk kelas TI, daftar ini dapat dibuat dari data proposal dengan `python3 -I milestone-2/penilaian-360/buat_daftar_tim.py <keluaran.txt>` (dari akar repo). Skrip memberi peringatan untuk nama tim yang berantakan, tim di luar rentang 4–6 anggota, nama tim ganda, dan kelas yang belum ada datanya (kelas SIB dan kelas TI yang belum terekstrak harus ditambah dari daftar lain). Keluaran berisi nama mahasiswa, jadi simpan di luar repo dan jangan di-commit.
2. Buka https://script.google.com dengan akun Polinema koordinator, lalu buat proyek baru dan tempel isi `Buat-Form-Penilaian-360.gs`.
3. Ganti isi `DAFTAR_TIM`, dan pastikan `BATAS_AKHIR` berisi 27 November 2026, pukul 23.59 WIB (sudah terisi).
4. Jalankan `buatFormPenilaian360` dan beri izin. Execution log memuat: tautan form untuk peserta, tautan edit, spreadsheet **data mentah** (hanya koordinator), dan spreadsheet **Rekap**.
5. Jalankan `pasangTrigger` satu kali. Fungsi ini memasang pemicu agar Rekap dihitung ulang tiap ada tanggapan baru, lalu menghitungnya sekali.
6. Kirim satu tanggapan uji, pastikan Rekap terisi, lalu hapus tanggapan uji dari data mentah dan jalankan `hitungRekap` lagi.
7. Untuk membagikan Rekap kepada dosen per kelas, jalankan `salinPerKelas`. Skrip membuat satu spreadsheet per kelas; bagikan tautannya (baca saja) kepada dosen kelas itu. Jangan bagikan data mentah atau spreadsheet Rekap utama.

## Isi form

Tiap tim punya satu bagian sendiri yang memuat nama anggotanya. Semua isian wajib kecuali yang tertulis opsional.

- **Nama Anda** (dropdown anggota tim).
- **Empat kisi skala 1–5** untuk seluruh anggota termasuk diri sendiri: kontribusi pekerjaan; tanggung jawab dan ketepatan waktu; kerja sama dan komunikasi; kehadiran dan keterlibatan dalam rapat.
- **Pembagian 100 poin** (angka 0–100 per anggota, termasuk diri sendiri). Form tidak dapat memeriksa jumlah antar isian, jadi sistem menormalkan poin ke 100 secara proporsional di Rekap.
- **Uraian pekerjaan** tiap anggota (termasuk diri sendiri): tugas konkret dan buktinya.
- **Bukti kontribusi diri sendiri** (opsional): tautan commit, berkas, atau dokumen.
- **Siapa yang paling berkontribusi dan mengapa**, serta **adakah anggota yang hampir tidak berkontribusi** (tulis "Tidak ada" bila tidak ada).
- Komentar tambahan (opsional).

Estimasi waktu pengisian sekitar 10–15 menit untuk tim 6 orang. Pengaturan form: email dikumpulkan, satu tanggapan per akun, jawaban bisa diubah sampai batas akhir.

## Isi Rekap

Spreadsheet Rekap berisi lima tab:

- **Rekap Mahasiswa**: satu baris per mahasiswa, memuat nilai diri, poin diri, rerata rekan (tiap aspek dan keseluruhan, poin, jumlah penilai rekan), **Skor 360** dan **Poin 360** (rerata seluruh penilai termasuk diri sendiri; Poin 360 dijumlahkan menjadi 100 per tim), selisih poin diri dan rekan, peringkat dalam tim, berapa rekan yang menyebutnya paling berkontribusi atau hampir tidak berkontribusi, dan **Penanda**.
- **Rincian Penilai**: satu baris per penilai per anggota yang dinilai (termasuk penilaian diri), lengkap dengan email penilai, skor, poin asli dan poin dinormalkan, uraian pekerjaan, serta penanda penilai.
- **Rangkuman Pekerjaan**: seluruh uraian pekerjaan tentang tiap mahasiswa dari dirinya dan dari rekan, beserta bukti dari diri sendiri, agar dosen membaca siapa mengerjakan apa.
- **Rekap Tim**: jumlah anggota dan pengisi, anggota yang belum mengisi, jawaban "paling berkontribusi" dan "hampir tidak berkontribusi", dan penanda tim.
- **Penanda**: daftar penanda dan artinya.

`BOBOT_DIRI` di bagian atas skrip (bawaan 1) mengatur bobot penilaian diri pada Skor 360 dan Poin 360. Atur 0 bila penilaian diri tidak boleh masuk hasil akhir. Ambang penanda ada pada konstanta `AMBANG`.

Penanda adalah petunjuk untuk diperiksa, bukan kesimpulan. Pencocokan nama pada "Dituduh pasif" memakai pencarian teks sehingga nama yang pendek atau saling menumpang dapat memberi peringatan keliru; baca uraiannya sebelum mengambil keputusan.

## Yang perlu diperiksa sendiri

- **Pembatasan akun Polinema** (`setRequireLogin`) hanya berlaku di akun Google Workspace. Bila akun skrip bukan Workspace Polinema, atur di Pengaturan form: batasi ke pengguna di organisasi.
- Apps Script ini belum dijalankan pada akun sebenarnya. Ujilah dengan satu tanggapan uji (langkah 6) sebelum form dibagikan, dan periksa bahwa tab Rekap terisi.
- Hanya koordinator yang boleh punya akses edit form dan akses ke data mentah. Jangan bagikan tautan edit.
- Bila tim di luar rentang 4–6 anggota, skrip hanya memberi peringatan di Execution log. Tim di bawah 2 anggota ditolak.
