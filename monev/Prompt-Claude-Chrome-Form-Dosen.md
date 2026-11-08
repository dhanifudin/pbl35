# Prompt Claude di Chrome: Membuat Google Form Survei Monev PBL untuk Dosen

Cara memakai: buka Google Forms pada akun yang akan menjadi pemilik form, buka ekstensi Claude di Chrome, lalu tempel seluruh teks di dalam blok kode di bawah. Seluruh label form ditulis dalam Bahasa Indonesia dan harus disalin persis.

```
You are helping me build a Google Form in my own Google account. Create ONE new form and follow the specification below exactly. Rules:
- Do NOT submit any response, do NOT share the form with anyone, and do NOT turn the form into a quiz (no answer key, no points).
- Copy every label exactly as written, including punctuation and capitalization (all labels are in Indonesian).
- If anything is unclear or cannot be done, stop and ask me before continuing.
- When finished, open the preview, check every section, and report: the edit link, the responder link, the number of questions per section, and anything you could not do.

=== FORM SETTINGS ===
Title: Survei Monev PBL untuk Dosen
Description (paste exactly, keep the blank line):
Survei ini bertujuan mengetahui pendapat dosen pengampu tentang pelaksanaan PBL: hal yang sudah baik, hal yang perlu diperbaiki, dan saran menuju Milestone 2. Pengisian membutuhkan sekitar 8 menit. Bagi dosen yang mengampu lebih dari satu kelas, jawablah berdasarkan gambaran umum seluruh kelas yang diampu.

Privasi. Data yang terkumpul akan disimpan dalam bentuk anonim dan data individu tidak akan ditampilkan kepada siapa pun. Alamat email hanya dipakai untuk memastikan satu dosen mengisi satu kali, lalu dipisahkan dari jawaban sebelum analisis. Hasil dilaporkan kepada manajemen jurusan hanya dalam bentuk gabungan (agregat), sehingga jawaban satu orang tidak dapat dikenali.

Settings: Responses > Collect email addresses = Verified. Responses > Limit to 1 response = On. Presentation > Show progress bar = On.
Confirmation message: Terima kasih telah mengisi survei. Jawaban disimpan secara anonim dan tidak ditampilkan secara individual. Masukan Bapak/Ibu digunakan untuk memperbaiki pelaksanaan PBL menuju Milestone 2.

COURSE OPTIONS (13, used in I4, M1, and M2 exactly):
 "TI Sem 3 - Manajemen Proyek"
 "TI Sem 3 - Desain dan Pemrograman Web"
 "TI Sem 3 - Basis Data Lanjut"
 "TI Sem 3 - Sistem Informasi Manajemen"
 "TI Sem 5 - Pemrograman Mobile"
 "TI Sem 5 - Pembelajaran Mesin"
 "TI Sem 5 - Penjaminan Mutu Perangkat Lunak"
 "SIB Sem 3 - Pemrograman Web"
 "SIB Sem 3 - Basis Data Lanjut"
 "SIB Sem 3 - Desain UI/UX"
 "SIB Sem 5 - Pemrograman Web Lanjut"
 "SIB Sem 5 - Manajemen Proyek Sistem Informasi"
 "SIB Sem 5 - Penjaminan Mutu Perangkat Lunak"

=== SECTION 1: Persetujuan dan Identitas ===
(all required)
C0. Checkboxes (one option only): "Saya telah membaca pernyataan privasi dan bersedia mengisi survei ini."
I2. Checkboxes: "Program studi yang diampu". Options: "Teknik Informatika (TI)"; "Sistem Informasi Bisnis (SIB)".
I3. Checkboxes: "Semester yang diampu". Options: "3"; "5".
I4. Checkboxes: "Mata kuliah terintegrasi yang diampu". Options: the 13 COURSE OPTIONS.
I5. Short answer: "Kelas yang diampu (contoh: TI-3A, TI-3B)".
I6. Multiple choice: "Berapa semester Bapak/Ibu telah mengampu PBL sebelum semester ini?" Options: "Belum pernah"; "1 semester"; "2 semester"; "3 semester atau lebih".
(The email address is collected by the setting; do not add an email question.)

=== SECTION 2: Opini tentang Pelaksanaan PBL ===
O. ONE "Multiple choice grid" titled "Seberapa setuju Bapak/Ibu dengan pernyataan berikut?" Require a response in each row = On.
Columns (in order): "1 - Sangat tidak setuju"; "2 - Tidak setuju"; "3 - Netral"; "4 - Setuju"; "5 - Sangat setuju"; "Tidak dapat menilai".
Rows (in order):
 O1: "Alur PBL dan target setiap milestone jelas bagi saya sebagai dosen pengampu."
 O2: "SOP dan template laporan membantu mahasiswa dan saya dalam proses bimbingan."
 O3: "Jadwal dan tenggat milestone realistis."
 O4: "Waktu yang tersedia bagi saya untuk membimbing mahasiswa memadai."
 O5: "Materi mata kuliah yang saya ampu mendukung pengerjaan proyek PBL."
 O6: "Tugas dan penilaian antar-mata kuliah selaras dengan proyek dan tidak tumpang tindih."
 O7: "Koordinasi dan arahan antar dosen pengampu berjalan konsisten."
 O8: "Rubrik dan kriteria penilaian PBL jelas dan mudah diterapkan."
 O9: "Penilaian terhadap kontribusi individu maupun tim dapat dilakukan secara adil."
 O10: "Saya dapat memberikan umpan balik kepada tim secara tepat waktu."
 O11: "Umpan balik yang saya berikan membantu tim memperbaiki proyek."
 O12: "Fasilitas dan sumber daya (perangkat, server, data) memadai."
M1. Checkboxes, required, "Select at most 2": "Mata kuliah mana yang paling membantu pengerjaan proyek? (maksimal 2)". Options: the 13 COURSE OPTIONS plus "Tidak ada".
M2. Checkboxes, required, "Select at most 2": "Mata kuliah mana yang paling perlu diselaraskan dengan proyek? (maksimal 2)". Same options as M1.

=== SECTION 3: Opini tentang Manfaat PBL ===
L. ONE "Multiple choice grid" titled "Seberapa setuju Bapak/Ibu dengan pernyataan berikut?", same six columns as section 2, required in each row.
 L1: "PBL meningkatkan keterampilan teknis mahasiswa."
 L2: "PBL meningkatkan kemampuan kerja sama dan komunikasi mahasiswa."
 L3: "PBL membuat mahasiswa lebih siap menghadapi dunia kerja."
 L4: "Secara keseluruhan saya puas dengan pelaksanaan PBL."
 L5: "Saya setuju PBL dilanjutkan pada semester berikutnya."

=== SECTION 4: Hal yang Baik dan yang Perlu Diperbaiki ===
G1. Checkboxes, required, "Select at most 3": "Hal apa yang paling baik dari pelaksanaan PBL sejauh ini? (maksimal 3)". Options:
 "Alur dan target milestone jelas"; "SOP dan template laporan membantu"; "Waktu dan model bimbingan"; "Keselarasan materi kelas dengan proyek"; "Rubrik dan penilaian jelas dan adil"; "Proses umpan balik kepada tim"; "Kerja sama tim mahasiswa"; "Fasilitas dan sumber daya"; "Keterlibatan mitra atau calon pengguna"; "Perkembangan keterampilan mahasiswa"; and the built-in "Other" option ("Lainnya (sebutkan)").
P1. Checkboxes, required, "Select at most 3": "Hal apa yang paling bermasalah dan perlu diperbaiki? (maksimal 3)". Options:
 "Kendala teknis mahasiswa (teknologi, kode, bug)"; "Waktu dan beban kerja mahasiswa"; "Pemahaman materi oleh mahasiswa"; "Koordinasi tim mahasiswa"; "Kontribusi anggota tim tidak seimbang"; "Kejelasan ketentuan (SOP dan rubrik)"; "Keterbatasan waktu untuk bimbingan atau umpan balik"; "Keselarasan tugas dan penilaian antar-mata kuliah"; "Fasilitas dan sumber daya (server, data, perangkat)"; "Mitra atau calon pengguna"; "Penggunaan AI oleh mahasiswa"; "Beban mengampu dan membimbing PBL"; and the built-in "Other" option ("Lainnya (sebutkan)").
P2. Multiple choice, required: "Seberapa besar dampak hal tersebut terhadap kemajuan tim?" Options: "1 - Tidak berdampak"; "2 - Kecil"; "3 - Sedang"; "4 - Besar"; "5 - Sangat besar".
P3. Multiple choice, required: "Bagaimana beban mengampu dan membimbing PBL dibandingkan dengan beban kerja Bapak/Ibu yang lain?" Options: "1 - Sangat ringan"; "2 - Ringan"; "3 - Sesuai"; "4 - Berat"; "5 - Sangat berat".
P4. Paragraph, required: "Jelaskan hal yang paling bermasalah dan saran perbaikan konkret sebelum Milestone 2."
G2. Paragraph, optional: "Praktik apa yang sudah berjalan baik dan sebaiknya dipertahankan?"

=== FINAL CHECK (do this before reporting) ===
- Sections: 1 (6 questions: C0, I2-I6), 2 (3 questions: the grid, M1, M2), 3 (1 grid), 4 (6 questions: G1, P1, P2, P3, P4, G2).
- "Select at most 3" is active on G1 and P1; "Select at most 2" is active on M1 and M2.
- Both grids require a response in each row and have the 6 columns in the order given.
- The form is NOT a quiz.
- Report the edit link and the responder link. Do not publish or share anything else.
```

## Catatan untuk koordinator

- Uji kirim satu respons dari pratinjau, lalu hapus respons uji tersebut.
- Jumlah pertanyaan pada pemeriksaan akhir sesuai dokumen Survei Monev PBL untuk Dosen; sesuaikan bila dokumen berubah.
