# Form Penilaian 360 (Milestone 2)

Berkas `Buat-Form-Penilaian-360.gs` membuat satu Google Form Penilaian 360 dan **Rekap otomatis** untuk dosen, sesuai SOP Bagian 9.3 dan Form 3 pada `Draft-Google-Form-Milestone-2.md`.

**Tujuan:** mengumpulkan informasi lengkap tentang kontribusi nyata tiap anggota (tim 4–6 orang) untuk memberi kredit dan memvalidasi kontribusi. Setiap anggota menilai seluruh rekan **dan dirinya sendiri** (360 derajat). Tidak ada pembatasan privasi penilai: koordinator dan dosen pengampu melihat siapa menilai siapa. Rekan satu tim tidak melihat hasilnya.

**Tanpa daftar tim.** Form tidak memakai daftar tim. Pengisi memilih kelas, mengetik nama tim, lalu mengisi anggota satu per satu (termasuk dirinya sendiri) dengan mengetik nama. Rekap mengenali tim dan anggota dari ketikan pengisi.

## Langkah

1. Buka https://script.google.com dengan akun Polinema koordinator, lalu buat proyek baru dan tempel isi `Buat-Form-Penilaian-360.gs`.
2. Pastikan `BATAS_AKHIR` berisi 27 November 2026, pukul 23.59 WIB (sudah terisi) dan daftar `KELAS` sesuai kelas yang ada.
3. Jalankan `buatFormPenilaian360` dan beri izin. Execution log memuat: tautan form untuk peserta, tautan edit, spreadsheet **data mentah** (hanya koordinator), dan spreadsheet **Rekap**.
4. Jalankan `pasangTrigger` satu kali. Fungsi ini memasang pemicu agar Rekap dihitung ulang tiap ada tanggapan baru, lalu menghitungnya sekali.
5. Kirim satu tanggapan uji (isi empat anggota), pastikan Rekap terisi, lalu hapus tanggapan uji dari data mentah dan jalankan `hitungRekap` lagi.
6. Setelah tanggapan masuk, buka tab **Rekap Tim** dan periksa kolom Penanda (lihat "Memeriksa pengenalan tim dan nama" di bawah).
7. Untuk membagikan Rekap kepada dosen per kelas, jalankan `salinPerKelas`. Skrip membuat satu spreadsheet per kelas; bagikan tautannya (baca saja) kepada dosen kelas itu. Jangan bagikan data mentah atau spreadsheet Rekap utama.

## Alur pengisian

1. **Halaman identitas:** kelas (dropdown) dan nama tim (ketik). Semua anggota satu tim harus menulis nama tim yang sama. Ada pengingat untuk menyiapkan lebih dulu pembagian 100 poin untuk seluruh anggota.
2. **Halaman Anggota 1 sampai 6**, satu halaman per anggota. Tiap halaman memuat, dan semuanya wajib:
   - nama anggota (ketik nama lengkap);
   - pertanyaan "Apakah anggota ini adalah Anda sendiri?" (tepat satu halaman harus dijawab "Ya, ini saya");
   - kisi skala 1–5 untuk empat aspek: kontribusi pekerjaan; tanggung jawab dan ketepatan waktu; kerja sama dan komunikasi; kehadiran dan keterlibatan dalam rapat;
   - poin kontribusi (0–100);
   - uraian pekerjaan konkret anggota itu beserta buktinya.
   Setelah anggota ke-4 dan ke-5 ada pertanyaan "Apakah masih ada anggota berikutnya?" yang menentukan apakah halaman berikutnya muncul atau form lanjut ke penutup.
3. **Halaman penutup:** bukti kontribusi diri sendiri (opsional), siapa yang paling berkontribusi dan mengapa, adakah anggota yang hampir tidak berkontribusi (tulis "Tidak ada" bila tidak ada), dan komentar tambahan (opsional).

Estimasi waktu pengisian sekitar 10–15 menit untuk tim 6 orang. Pengaturan form: email dikumpulkan, satu tanggapan per akun, jawaban bisa diubah sampai batas akhir.

Form tidak dapat memeriksa jumlah poin antar halaman, jadi Rekap menormalkan poin tiap penilai ke 100 secara proporsional.

## Isi Rekap

Spreadsheet Rekap berisi lima tab:

- **Rekap Mahasiswa**: satu baris per mahasiswa, memuat nilai diri, poin diri, rerata rekan (tiap aspek dan keseluruhan, poin, jumlah penilai rekan), **Skor 360** dan **Poin 360** (rerata seluruh penilai termasuk diri sendiri; Poin 360 dijumlahkan menjadi 100 per tim), selisih poin diri dan rekan, peringkat dalam tim, berapa rekan yang menyebutnya paling berkontribusi atau hampir tidak berkontribusi, dan **Penanda**.
- **Rincian Penilai**: satu baris per penilai per anggota yang dinilai (termasuk penilaian diri), lengkap dengan email penilai, skor, poin asli dan poin dinormalkan, uraian pekerjaan, serta penanda penilai.
- **Rangkuman Pekerjaan**: seluruh uraian pekerjaan tentang tiap mahasiswa dari dirinya dan dari rekan, beserta bukti dari diri sendiri, agar dosen membaca siapa mengerjakan apa.
- **Rekap Tim**: jumlah anggota yang dikenali, pengisi, dan tanggapan; anggota yang belum mengisi; jawaban "paling berkontribusi" dan "hampir tidak berkontribusi"; ejaan lain nama tim dan nama anggota; serta penanda tim.
- **Penanda**: daftar penanda dan artinya.

`BOBOT_DIRI` di bagian atas skrip (bawaan 1) mengatur bobot penilaian diri pada Skor 360 dan Poin 360. Atur 0 bila penilaian diri tidak boleh masuk hasil akhir. Ambang penanda dan kemiripan nama ada pada konstanta `AMBANG`.

## Memeriksa pengenalan tim dan nama

Karena nama diketik bebas, Rekap mengelompokkan tim dan anggota otomatis:

- **Tim:** kelas yang sama dan nama tim yang sama setelah huruf besar kecil, tanda baca, dan spasi disamakan.
- **Anggota:** nama dari semua pengisi satu tim dianggap orang yang sama bila identik, bila kata-kata nama yang lebih pendek termuat di nama yang lebih panjang (misalnya "Budi" atau "Budi S." dengan "Budi Santoso"), atau bila ejaannya sangat mirip. Nama baku adalah ejaan yang paling sering diketik.

Periksa tab **Rekap Tim** setelah tanggapan masuk:

| Penanda | Tindakan |
|---|---|
| Daftar anggota tidak konsisten (n nama berbeda) | Ada lebih dari 6 atau kurang dari 4 nama berbeda, biasanya salah ketik. Lihat kolom "Ejaan lain nama anggota", lalu tambahkan koreksi ke `ALIAS_NAMA` |
| Nama tim mirip: X | Dua nama tim dalam satu kelas hampir sama atau anggotanya banyak yang sama. Bila itu tim yang sama, tambahkan ke `ALIAS_TIM` |
| Nama ambigu: X | Nama X cocok dengan lebih dari satu anggota, misalnya dua orang bernama depan sama. Minta anggota menulis nama lengkap atau atur `ALIAS_NAMA` |
| Penilai kurang | Pengisi kurang dari separuh anggota; ingatkan tim |

`ALIAS_TIM` dan `ALIAS_NAMA` berisi pasangan ejaan yang salah (ditulis huruf kecil, tanpa tanda baca) dan nama baku, misalnya `'tim jwa': 'Tim Jawa'` dan `'budi s': 'Budi Santoso'`. Setelah mengubahnya, jalankan `hitungRekap`.

Pada Rincian Penilai, penanda **Penanda diri tidak tepat** berarti penilai tidak menandai tepat satu halaman sebagai dirinya (nama penilai menjadi "(tidak diketahui)"), dan **Penilaian tidak lengkap** berarti penilai tidak mengisi semua anggota yang dikenali.

Penanda adalah petunjuk untuk diperiksa, bukan kesimpulan. Pencocokan nama pada "Dituduh pasif" memakai pencarian teks; nama depan hanya dicocokkan bila tidak ada anggota lain bernama depan sama, sehingga bacalah uraiannya sebelum mengambil keputusan.

## Yang perlu diperiksa sendiri

- **Pembatasan akun Polinema** (`setRequireLogin`) hanya berlaku di akun Google Workspace. Bila akun skrip bukan Workspace Polinema, atur di Pengaturan form: batasi ke pengguna di organisasi.
- Apps Script ini belum dijalankan pada akun sebenarnya. Ujilah dengan satu tanggapan uji (langkah 5) sebelum form dibagikan, dan periksa bahwa tab Rekap terisi.
- Hanya koordinator yang boleh punya akses edit form dan akses ke data mentah. Jangan bagikan tautan edit.
- Tim yang melaporkan kurang dari 4 anggota (tidak mengisi halaman ke-4) tidak dicegah oleh form; Rekap Tim menandainya sebagai "Daftar anggota tidak konsisten".
