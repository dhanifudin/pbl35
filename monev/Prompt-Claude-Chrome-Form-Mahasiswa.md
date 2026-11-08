# Prompt Claude di Chrome: Membuat Google Form Survei Monev PBL untuk Mahasiswa

Cara memakai: buka Google Forms pada akun yang akan menjadi pemilik form, buka ekstensi Claude di Chrome, lalu tempel seluruh teks di dalam blok kode di bawah. Isi `[daftar kelas SIB]` bila sudah ada; bila belum, ekstensi akan menanyakannya. Teks dalam prompt ditulis dalam Bahasa Inggris untuk instruksi, sedangkan seluruh label form tetap dwibahasa ("Indonesia / English") dan harus disalin persis.

```
You are helping me build a Google Form in my own Google account. Create ONE new form and follow the specification below exactly. Rules:
- Do NOT submit any response, do NOT share the form with anyone, and do NOT turn the form into a quiz (no answer key, no points).
- Copy every label exactly as written ("Bahasa Indonesia / English"), including punctuation and capitalization.
- If anything is unclear or cannot be done, stop and ask me before continuing.
- When finished, open the preview, check every section, and report: the edit link, the responder link, the number of questions per section, and anything you could not do.

=== FORM SETTINGS ===
Title: Survei Monev PBL untuk Mahasiswa / PBL Monitoring and Evaluation Survey for Students
Description (paste exactly, keep the blank lines):
Survei ini bertujuan mengetahui pendapat mahasiswa tentang pelaksanaan PBL: hal yang sudah baik, hal yang perlu diperbaiki, dan saran menuju Milestone 2. Pengisian membutuhkan sekitar 8 menit.

Privasi. Data yang terkumpul akan disimpan dalam bentuk anonim dan data individu tidak akan ditampilkan kepada siapa pun. Alamat email hanya dipakai untuk memastikan satu orang mengisi satu kali, lalu dipisahkan dari jawaban sebelum analisis. Hasil dilaporkan kepada manajemen jurusan hanya dalam bentuk gabungan (agregat), sehingga jawaban satu orang tidak dapat dikenali. Survei ini tidak memengaruhi nilai. Mohon menjawab dengan jujur.

This survey aims to find out students' opinions on PBL operations: what works well, what needs improvement, and suggestions toward Milestone 2. It takes about 8 minutes.

Privacy. Collected data will be stored in anonymous form and individual data will not be displayed to anyone. Your email address is used only to ensure one response per person and is separated from your answers before analysis. Results are reported to the department management only in aggregate form, so no individual's answers can be identified. This survey does not affect your grades. Please answer honestly.

Settings: Responses > Collect email addresses = Verified. Responses > Limit to 1 response = On. Presentation > Show progress bar = On. Do not turn on "Allow response editing" unless I ask.
Confirmation message (after submit):
Terima kasih telah mengisi survei. Jawaban disimpan secara anonim dan tidak ditampilkan secara individual. Masukan digunakan untuk memperbaiki pelaksanaan PBL menuju Milestone 2. / Thank you for completing the survey. Your answers are stored anonymously and are not displayed individually. Your input will be used to improve PBL implementation toward Milestone 2.

=== SECTION 1: Persetujuan dan Identitas / Consent and Identity ===
(all required)
C0. Checkboxes (one option only): "Saya telah membaca pernyataan privasi dan bersedia mengisi survei ini. / I have read the privacy statement and agree to take part in this survey."
I2. Multiple choice: "Program studi / Study program". Options: "Teknik Informatika (TI) / Informatics Engineering"; "Sistem Informasi Bisnis (SIB) / Business Information Systems".
I3. Multiple choice: "Semester / Semester". Options: "3"; "5".
I4. Dropdown: "Kelas / Class". Options: TI-2A, TI-2B, TI-2C, TI-2D, TI-2E, TI-2F, TI-2G, TI-2H, TI-2I, TI-3A, TI-3B, TI-3C, TI-3D, TI-3E, TI-3F, TI-3G, TI-3H, TI-3I, then the SIB classes: [daftar kelas SIB]. If I did not fill in the SIB list, STOP and ask me for it before adding options.
(The email address is collected automatically by the setting above; do not add an email question.)

=== SECTION 2: Pemahaman dan Pengalaman PBL / Understanding and Experience of PBL ===
(all required)
K1. Multiple choice: "Seberapa paham saya tentang konsep PBL saat ini? / How well do I understand the PBL concept now?" Options: "1 - Sangat tidak paham / Not at all familiar"; "2 - Kurang paham / Slightly familiar"; "3 - Cukup paham / Moderately familiar"; "4 - Paham / Familiar"; "5 - Sangat paham / Very familiar".
K2. Multiple choice (one answer): "Manakah yang paling tepat menggambarkan PBL? / Which of the following best describes PBL?" Options, in this order and without marking any as correct:
 a) "Pembelajaran yang berangkat dari masalah nyata dan menghasilkan produk yang berfungsi, dikerjakan tim secara bertahap dengan milestone dan refleksi. / Learning that starts from a real problem and produces a working product, done by a team in stages with milestones and reflection."
 b) "Praktikum dengan soal latihan terstruktur yang sudah ada jawabannya. / A lab course with structured practice exercises that have set answers."
 c) "Tugas besar individu yang dikumpulkan di akhir semester. / A large individual assignment submitted at the end of the semester."
 d) "Ujian studi kasus tertulis. / A written case-study exam."
 e) "Saya belum tahu. / I do not know yet."
K3. Multiple choice: "Berapa kali saya pernah mengikuti pembelajaran dengan PBL sebelum semester ini? (hitung per mata kuliah atau semester yang menerapkan PBL) / How many times have I taken part in PBL before this semester? (count per course or semester that applied PBL)". Options: "Belum pernah / Never"; "1 kali / Once"; "2 kali / Twice"; "3 kali atau lebih / Three times or more".

=== SECTION 3: Opini tentang Pelaksanaan PBL / Opinions on PBL Operations ===
O. Create ONE "Multiple choice grid" question titled "Seberapa setuju saya dengan pernyataan berikut? / How much do I agree with the following statements?" Settings: Require a response in each row = On; Limit to one response per column = Off.
Columns (in order): "1 - Sangat tidak setuju / Strongly disagree"; "2 - Tidak setuju / Disagree"; "3 - Netral / Neutral"; "4 - Setuju / Agree"; "5 - Sangat setuju / Strongly agree"; "Tidak dapat menilai / Not applicable".
Rows (in order):
 O1: "Alur PBL dan target setiap milestone dijelaskan dengan jelas. / The PBL flow and the target of each milestone were explained clearly."
 O2: "SOP dan template laporan membantu saya memahami hal yang harus dikerjakan. / The SOP and report template help me understand what needs to be done."
 O3: "Jadwal dan tenggat milestone realistis. / The milestone schedule and deadlines are realistic."
 O4: "Bimbingan dosen memadai. / Lecturer supervision is adequate."
 O5: "Materi yang diajarkan di kelas mendukung pengerjaan proyek. / The material taught in class supports the project work."
 O6: "Tugas dan penilaian antar-mata kuliah selaras dengan proyek dan tidak tumpang tindih. / Assignments and assessments across courses are aligned with the project and do not overlap."
 O7: "Arahan dosen dari berbagai mata kuliah konsisten satu sama lain. / Guidance from lecturers of different courses is consistent with one another."
 O8: "Rubrik dan kriteria penilaian PBL jelas. / The PBL assessment rubric and criteria are clear."
 O9: "Penilaian adil terhadap kontribusi individu maupun tim. / Assessment is fair to both individual and team contributions."
 O10: "Umpan balik dari dosen diterima tepat waktu. / Feedback from lecturers is received on time."
 O11: "Umpan balik dari dosen membantu saya memperbaiki proyek. / Feedback from lecturers helps me improve the project."
 O12: "Fasilitas dan sumber daya (perangkat, server, data) memadai. / Facilities and resources (devices, servers, data) are adequate."
M1. Checkboxes, required, response validation "Select at most 2": "Mata kuliah mana yang paling membantu pengerjaan proyek? (pilih sesuai program studi dan semester, maksimal 2) / Which courses help the project work the most? (choose according to your study program and semester, up to 2)". Options: the 13 course options listed under COURSE OPTIONS below, plus "Tidak ada / None".
M2. Checkboxes, required, "Select at most 2": "Mata kuliah mana yang paling perlu diselaraskan dengan proyek? (maksimal 2) / Which courses need to be aligned most with the project? (up to 2)". Same options as M1.

COURSE OPTIONS (13, use for M1 and M2 exactly):
 "TI Sem 3 - Manajemen Proyek / Project Management"
 "TI Sem 3 - Desain dan Pemrograman Web / Web Design and Programming"
 "TI Sem 3 - Basis Data Lanjut / Advanced Databases"
 "TI Sem 3 - Sistem Informasi Manajemen / Management Information Systems"
 "TI Sem 5 - Pemrograman Mobile / Mobile Programming"
 "TI Sem 5 - Pembelajaran Mesin / Machine Learning"
 "TI Sem 5 - Penjaminan Mutu Perangkat Lunak / Software Quality Assurance"
 "SIB Sem 3 - Pemrograman Web / Web Programming"
 "SIB Sem 3 - Basis Data Lanjut / Advanced Databases"
 "SIB Sem 3 - Desain UI/UX / UI/UX Design"
 "SIB Sem 5 - Pemrograman Web Lanjut / Advanced Web Programming"
 "SIB Sem 5 - Manajemen Proyek Sistem Informasi / Information Systems Project Management"
 "SIB Sem 5 - Penjaminan Mutu Perangkat Lunak / Software Quality Assurance"

=== SECTION 4: Opini tentang Manfaat PBL / Opinions on the Benefits of PBL ===
L. ONE "Multiple choice grid", required in each row, same six columns as section 3. Title: "Seberapa setuju saya dengan pernyataan berikut? / How much do I agree with the following statements?"
 L1: "PBL meningkatkan keterampilan teknis saya. / PBL improves my technical skills."
 L2: "PBL meningkatkan kemampuan kerja sama dan komunikasi saya. / PBL improves my teamwork and communication skills."
 L3: "PBL membuat saya lebih siap menghadapi dunia kerja. / PBL makes me better prepared for the world of work."
 L4: "Secara keseluruhan saya puas dengan pelaksanaan PBL. / Overall, I am satisfied with how PBL is run."
 L5: "Saya setuju PBL dilanjutkan pada semester berikutnya. / I agree that PBL should continue in the following semesters."

=== SECTION 5: Hal yang Baik dan yang Perlu Diperbaiki / What Works Well and What Needs Improvement ===
G1. Checkboxes, required, "Select at most 3": "Hal apa yang paling baik dari pelaksanaan PBL sejauh ini? (maksimal 3) / What has been best about PBL operations so far? (up to 3)". Options:
 "Alur dan target milestone jelas / Clear flow and milestone targets"
 "SOP dan template laporan membantu / Helpful SOP and report template"
 "Bimbingan dosen / Lecturer supervision"
 "Materi kelas mendukung proyek / Class material supports the project"
 "Rubrik dan penilaian jelas dan adil / Clear and fair rubric and assessment"
 "Umpan balik dosen / Lecturer feedback"
 "Kerja sama tim / Teamwork"
 "Fasilitas dan sumber daya / Facilities and resources"
 "Keterlibatan mitra atau calon pengguna / Partner or prospective user involvement"
 "Pengalaman dan keterampilan baru yang saya peroleh / New experience and skills I gained"
 "Lainnya (sebutkan) / Other (please specify)" (use the built-in "Other" option)
P1. Checkboxes, required, "Select at most 3": "Hal apa yang paling bermasalah dan perlu diperbaiki? (maksimal 3) / What is most problematic and needs improvement? (up to 3)". Options:
 "Kendala teknis (teknologi, kode, bug) / Technical problems (technology, code, bugs)"
 "Waktu dan beban kerja / Time and workload"
 "Pemahaman materi / Understanding of the course material"
 "Koordinasi tim / Team coordination"
 "Kontribusi anggota tidak seimbang / Unbalanced contribution among members"
 "Kejelasan ketentuan (SOP dan rubrik) / Clarity of the rules (SOP and rubric)"
 "Bimbingan atau umpan balik dosen / Lecturer supervision or feedback"
 "Keselarasan tugas antar-mata kuliah / Alignment of assignments across courses"
 "Fasilitas dan sumber daya (server, data, perangkat) / Facilities and resources (servers, data, devices)"
 "Mitra atau calon pengguna / Partners or prospective users"
 "Penggunaan AI / Use of AI"
 "Lainnya (sebutkan) / Other (please specify)" (use the built-in "Other" option)
P2. Multiple choice, required: "Seberapa besar dampak hal tersebut terhadap kemajuan proyek tim? / How large is the impact of these problems on your team's project progress?" Options: "1 - Tidak berdampak / No impact"; "2 - Kecil / Small"; "3 - Sedang / Moderate"; "4 - Besar / Large"; "5 - Sangat besar / Very large".
P3. Multiple choice, required: "Bagaimana beban kerja PBL dibandingkan dengan waktu yang tersedia? / How is the PBL workload compared with the time available?" Options: "1 - Sangat ringan / Very light"; "2 - Ringan / Light"; "3 - Sesuai / Appropriate"; "4 - Berat / Heavy"; "5 - Sangat berat / Very heavy".
P4. Paragraph, required: "Jelaskan hal yang paling bermasalah dan saran perbaikan konkret sebelum Milestone 2. / Describe the most problematic issue and a concrete improvement suggestion before Milestone 2."
G2. Paragraph, optional: "Hal apa yang paling membantu dan sebaiknya dipertahankan? / What helps the most and should be kept?"

=== FINAL CHECK (do this before reporting) ===
- Sections: 1 (4 questions), 2 (3 questions), 3 (3 questions: the grid, M1, M2), 4 (1 grid), 5 (6 questions: G1, P1, P2, P3, P4, G2). Email is collected by the setting, not by a question.
- "Select at most 3" is active on G1 and P1; "Select at most 2" is active on M1 and M2.
- Both grids require a response in each row and have the 6 columns in the order given.
- The form is NOT a quiz and no answer is marked as correct in K2.
- Report the edit link and the responder link. Do not publish or share anything else.
```

## Catatan untuk koordinator

- Sebelum membagikan, buka pratinjau dan uji kirim satu respons, lalu hapus respons uji tersebut.
- Jumlah pertanyaan pada pemeriksaan akhir (4, 3, 3, 1, 6) sesuai dokumen Survei Monev PBL untuk Mahasiswa. Bila dokumen berubah, sesuaikan prompt ini.
- Isi `[tanggal akhir]` pada deskripsi form bila diperlukan, dan tutup penerimaan jawaban pada tanggal tersebut.
