# Analisis masalah dan solusi PBL: draf untuk ditinjau

Status: **draf ketiga**. Memuat fakta dari koordinator PBL: kuis dan UTS berasal dari mata kuliah non-PBL, dan deployment wajib untuk aplikasi web dan untuk pengujian di Penjaminan Mutu. Wawancara mahasiswa dicatat sebagai sampel acak tanpa jumlah yang tercatat. Dasar: survei monev Semester Ganjil 2026/2027, mahasiswa 177 dari 806 (22,0%) dan dosen 22 dari 34 (64,7%). Semua angka berasal dari `data/analisis.json`, yang dihasilkan oleh `analisis_masalah.py` dari data mentah dan hanya berisi agregat. Angka dasar yang sama dengan laporan (kepuasan, beban berat, tenggat, korelasi, tingkat respons) dicocokkan ulang dan semuanya sama (15 dari 15 pemeriksaan).

Dokumen ini sengaja ditulis sebelum bahan presentasi. Tujuannya menguji tiap masalah dan tiap usulan solusi terhadap data, lalu memutuskan apa yang layak dibawa ke rapat.

## 0. Ringkasan: apa yang berubah dari kerangka sebelumnya

Sembilan temuan yang paling memengaruhi isi presentasi:

1. **Dua hal yang paling berpengaruh pada kepuasan dan keinginan melanjutkan PBL adalah fasilitas dan beban.** Setelah semua faktor lain dikontrol, mahasiswa yang tidak setuju fasilitas memadai (47,7%) kepuasannya lebih rendah 0,45 poin, dan yang menilai beban berat (40,7%) lebih rendah 0,36 poin. Keduanya juga menurunkan keinginan melanjutkan (0,59 dan 0,56 poin).
2. **Fasilitas berarti biaya server untuk deployment yang ditanggung mahasiswa** (mereka membeli VPS sendiri), dan deployment wajib: aplikasi web memerlukannya, dan proses pengujian di Penjaminan Mutu Perangkat Lunak (TI dan SIB Semester 5) mensyaratkan aplikasi yang sudah ter-deploy. Skor fasilitas sama rendah di TI (3,42) dan SIB (3,46), dan tidak berbeda antara semester dengan Penjaminan Mutu dan tanpa (+0,07 [-0,24; 0,40]). Jadi ini biaya struktural, bukan keluhan satu program. Kebutuhan server dan biayanya belum tertulis di SOP, dan jumlah biaya per tim tidak ada di survei.
3. **Beban terasa berat terutama ketika tenggat bertabrakan, bukan karena banyaknya tugas di luar proyek.** Mahasiswa yang sering mengalami tenggat bertabrakan menilai beban berat pada 58% kasus, dibanding 29% pada yang tidak. Jumlah tugas di luar proyek tidak membedakan siapa yang merasa berat setelah faktor lain dikontrol. Beban dan jadwal sebaiknya dibaca sebagai satu masalah.
4. **Jadwal milestone jatuh di minggu yang sama dengan kuis dan UTS mata kuliah non-PBL.** Proposal berjadwal sama dengan kuis 1, Milestone 1 sama dengan UTS, Milestone 2 sama dengan kuis 2. Persepsi bahwa jadwal milestone realistis adalah pendorong terkuat keinginan melanjutkan (+0,48 poin per poin skor [0,21; 0,80]). Sebanyak 35,5% mahasiswa tidak setuju jadwal realistis. Dosen menilai jadwal lebih realistis (4,27) daripada mahasiswa (3,72), dan separuh dosen (11 dari 22) jarang atau tidak pernah menyamakan deadline tugas dengan dosen lain. Butir survei tentang tenggat tidak membedakan mata kuliah PBL dari non-PBL.
5. **Klaim "tugas yang terpisah dari proyek memicu keluhan beban" tidak didukung data.** Porsi tugas yang menjadi bagian proyek tidak berkaitan dengan beban (r = -0,05) maupun kepuasan (r = 0,06). Satu-satunya kaitan: porsi itu berkaitan dengan lebih sedikit tenggat bertabrakan (r = -0,17 [-0,32; -0,03]). Mata kuliah PIC punya kegiatan PBL lebih sering (+17 poin), tetapi tugasnya tidak lebih sering menjadi bagian proyek.
6. **Kejelasan rubrik adalah penentu utama persepsi bahwa nilai adil** (r = 0,73; koefisien baku 0,62). Rubrik beserta contoh lebih kuat didukung daripada penilaian 360.
7. **Koordinasi antar dosen adalah keluhan yang paling luas (68,4% menilai arahan tidak konsisten), tetapi pengaruhnya pada kepuasan belum pasti.** Setelah faktor lain dikontrol, pengaruhnya tidak bisa dibedakan dari nol. Yang berkaitan dengan kepuasan adalah mengetahui harus bertanya ke dosen siapa. Konsistensi arahan sangat berbeda antar kelas, dari 0% sampai 54% pada kelas SIB Semester 5 yang punya 5 responden atau lebih. Belum dipastikan apakah PIC tiap kelas sudah diberi tahu perannya.
8. **Tim yang belum pernah berkonsultasi (23,2%) tidak lebih rendah kepuasannya**, dan malah cenderung lebih ingin melanjutkan. Yang berkaitan dengan kepuasan adalah persepsi bahwa bimbingan memadai. Usulan "sesi konsultasi dengan jadwal tetap" kurang didukung sebagai cara menaikkan kepuasan.
9. **Respons yang rendah mengurangi ketepatan, tetapi tidak terlihat membiaskan temuan utama.** Komposisi responden miring (SIB Semester 5 adalah 49% responden dan 19% populasi), namun pembobotan hanya menggeser angka 0 sampai 5 poin. Kelas yang dipantau dan yang tidak dipantau tidak berbeda dalam kepuasan, beban, tenggat, maupun konsistensi arahan.

Dampak pada usulan solusi di deck: **beban dan jadwal** bergeser dari "kurangi tugas di luar proyek" ke "jangan biarkan tenggat milestone jatuh di minggu kuis dan UTS mata kuliah non-PBL", yang membutuhkan keputusan di rapat monev; **fasilitas** adalah biaya deployment yang wajib, jadi pertanyaannya siapa menyediakan lingkungan dan sejak fase mana, bukan apakah perlu; **keselarasan** kehilangan dasar klaim bebannya dan turun menjadi pekerjaan semester depan; **penilaian** sebaiknya mendahulukan rubrik beserta contoh; **bimbingan** perlu dipisah dari fasilitas dan konsultasi jadwal tetap diturunkan prioritasnya; **peran PIC** dipakai sebagai pemilik pekerjaan koordinasi, setelah dipastikan PIC tahu perannya.

## 1. Data dan cara membaca angka

**Sumber dan ukuran.** Mahasiswa 177 dari 806, terbagi TI Semester 3 (44), TI Semester 5 (25), SIB Semester 3 (21), SIB Semester 5 (87). Dosen 22 dari 34 (TI 17, SIB 11, enam mengajar di keduanya). Kelompok kurang dari 5 orang tidak ditampilkan di mana pun.

**Ketidakpastian.** Setiap persentase diberi selang Wilson 95%, ditulis `[bawah; atas]`. Setiap rata-rata, selisih, korelasi, dan koefisien regresi diberi selang bootstrap 95% (2000 pengulangan, 600 untuk model). Selisih yang selangnya mencakup nol dianggap **belum terbukti**, apa pun besarnya.

**Dua cara melihat pengaruh.** *Mentah* membandingkan dua kelompok apa adanya. *Terkontrol* memperhitungkan faktor lain secara bersamaan lewat regresi linear. Dua hal yang sering berkaitan dengan satu sama lain (rubrik jelas dan nilai adil, misalnya) saling "memakan" pengaruh dalam model terkontrol, jadi pengaruh mentah bisa nyata sementara pengaruh terkontrolnya mengecil. Skor 1 sampai 5 diperlakukan sebagai angka; ini pendekatan, bukan fakta.

**Asosiasi bukan sebab-akibat.** Survei satu kali dan jawaban diri sendiri. Kata "berkaitan" dipakai sengaja.

**Definisi "terdampak"** untuk perbandingan prioritas: beban berat (jawaban Berat atau Sangat berat); jadwal bertabrakan (sering atau selalu); jadwal tidak realistis, tugas tidak selaras, penilaian tidak adil, fasilitas tidak memadai, bimbingan tidak memadai (tidak setuju, skor 3 ke bawah); arahan dosen tidak konsisten; tidak tahu harus menghubungi dosen siapa; belum pernah konsultasi.

**Yang tidak ada di data.** Jumlah dan rincian wawancara mahasiswa (sampel acak, jumlah belum tercatat), biaya server yang ditanggung tiap tim, dan kalender kuis dan UTS mata kuliah non-PBL per semester. Tempat-tempat yang membutuhkannya ditandai **[ISI]**.

### 1.1 Seberapa mewakili respondennya

| Kelompok | Responden | Populasi (roster) | % responden | % populasi | Bobot |
|---|---|---|---|---|---|
| TI Semester 3 | 44 | 248 | 24,9 | 30,8 | 5,64 |
| TI Semester 5 | 25 | 230 | 14,1 | 28,5 | 9,20 |
| SIB Semester 3 | 21 | 173 | 11,9 | 21,5 | 8,24 |
| SIB Semester 5 | 87 | 155 | 49,2 | 19,2 | 1,78 |

SIB Semester 5 sangat berlebih. Pembobotan ke ukuran populasi (pasca-stratifikasi per program dan semester) menggeser angka utama sedikit:

| Indikator | Mentah | Terbobot [selang] | Pergeseran |
|---|---|---|---|
| Rata-rata kepuasan (1-5) | 3,48 | 3,48 [3,30; 3,66] | 0,00 |
| % puas | 48,6 | 51,2 [42,8; 59,8] | +2,6 |
| % beban berat | 40,7 | 42,4 [34,4; 51,6] | +1,7 |
| % tenggat sering bertabrakan | 40,1 | 42,5 [33,4; 50,1] | +2,4 |
| % arahan dosen konsisten | 31,6 | 36,8 [28,8; 45,3] | +5,1 |
| % setuju fasilitas memadai | 52,3 | 51,7 [43,4; 60,6] | -0,6 |
| % belum pernah konsultasi | 23,2 | 26,0 [18,6; 33,0] | +2,9 |

Artinya komposisi bukan ancaman utama bagi angka tingkat jurusan. Ancaman yang tersisa tidak bisa diuji: perbedaan antara yang mengisi dan yang tidak mengisi **di dalam** kelas yang sama.

### 1.2 Pendorong kepuasan dan keinginan melanjutkan (model gabungan)

Regresi kepuasan dan keinginan melanjutkan pada delapan butir pelaksanaan ditambah beban, konsultasi, konsistensi arahan, kejelasan dosen rujukan, dan tenggat bertabrakan. Koefisien mentah `b` adalah perubahan skor 1 sampai 5 per kenaikan satu poin (atau satu kategori untuk faktor ya atau tidak).

| Faktor | Kepuasan: b [selang] | Keinginan melanjutkan: b [selang] |
|---|---|---|
| Fasilitas memadai | **+0,30 [0,13; 0,48]** | **+0,28 [0,02; 0,52]** |
| Jadwal dan tenggat realistis | +0,25 [0,03; 0,49] (rapuh, lihat 1.4) | **+0,48 [0,21; 0,80]** |
| Belum pernah konsultasi | +0,25 [-0,07; 0,55] | **+0,69 [0,34; 1,04]** |
| Beban berat | -0,23 [-0,56; 0,10] | -0,39 [-0,83; 0,07] |
| Bimbingan dosen memadai | +0,16 [-0,08; 0,41] | -0,14 [-0,40; 0,23] |
| Rubrik jelas | +0,14 [-0,11; 0,35] | +0,21 [-0,13; 0,59] |
| Butir lain (SOP, alur, selaras, adil, konsisten, kejelasan rujukan, tenggat bertabrakan) | selang mencakup nol | selang mencakup nol |

R² = 0,40 untuk kepuasan (n = 153) dan 0,32 untuk keinginan melanjutkan (n = 150): model menjelaskan sebagian, tidak semua. Perhatikan "belum pernah konsultasi": tandanya positif, artinya tim yang belum pernah berkonsultasi cenderung **lebih** ingin melanjutkan.

### 1.3 Peta prioritas: seberapa luas dikali seberapa besar

Skor = persentase mahasiswa terdampak dikali kehilangan kepuasan terkontrol. Selang efek terkontrol mencakup nol berarti peringkatnya belum pasti.

| Masalah (terdampak) | Terdampak | Efek mentah pada kepuasan | Efek terkontrol pada kepuasan [selang] | Skor | Skor untuk keinginan melanjutkan |
|---|---|---|---|---|---|
| Fasilitas tidak memadai | 47,7% | -0,70 | -0,45 [-0,75; -0,17] | 0,215 | 0,281 |
| Beban berat | 40,7% | -0,58 | -0,36 [-0,66; -0,02] | 0,147 | 0,228 |
| Arahan tidak konsisten | 68,4% | -0,23 (belum terbukti) | -0,13 [-0,42; 0,15] | 0,089 | tidak positif |
| Bimbingan dinilai kurang | 31,1% | -0,75 | -0,27 [-0,68; 0,11] | 0,084 | 0,096 |
| Jadwal tidak realistis | 35,5% | -0,62 | -0,15 [-0,56; 0,22] | 0,053 | **0,138** |
| Penilaian tidak adil | 42,9% | -0,66 | -0,12 [-0,47; 0,22] | 0,051 | tidak positif |
| Tugas tidak selaras | 44,2% | -0,54 | -0,05 [-0,31; 0,24] | 0,022 | 0,071 |
| Tenggat bertabrakan | 40,1% | -0,29 (belum terbukti) | -0,01 [-0,31; 0,30] | 0,004 | 0,052 |
| Tidak tahu menghubungi dosen siapa | 30,5% | -0,39 | +0,01 [-0,32; 0,37] | tidak positif | tidak positif |
| Belum pernah konsultasi | 23,2% | +0,04 (nol) | +0,26 [-0,10; 0,60] | tidak positif | tidak positif |

Hanya **fasilitas** dan **beban** punya efek terkontrol yang selangnya tidak mencakup nol untuk kepuasan maupun keinginan melanjutkan. Banyak masalah lain nyata secara mentah tetapi berbagi pengaruh satu sama lain, sehingga tidak bisa dipisahkan dengan 177 responden.

### 1.4 Uji ketahanan

- **Benih acak lain.** Dari 46 perbandingan berbasis selang (10 prioritas dan 13 pendorong, masing-masing untuk kepuasan dan keinginan melanjutkan), satu berubah: pengaruh jadwal realistis pada kepuasan (batas bawah 0,02 atau 0,00). Pengaruhnya pada keinginan melanjutkan tetap. Jadi klaim tentang kepuasan ditulis "kemungkinan", klaim tentang keinginan melanjutkan ditulis tegas.
- **Tanpa SIB Semester 5** (n = 90): fasilitas dan jadwal realistis tetap di empat pendorong teratas. Rubrik jelas naik menjadi pendorong utama (0,28), SOP dan template turun. Efek beban (-0,74) dan penilaian tidak adil (-0,86) lebih besar di luar SIB Semester 5. Arah semua temuan sama; besarnya bergantung pada kelompok.

## 2. Masalah 1: respons survei rendah

**a. Seberapa luas.** 22,0% mahasiswa mengisi (target 70%). Dari 32 kelas, 12 punya 5 responden atau lebih dan 8 tidak punya responden sama sekali. Dosen mengisi 22 dari 34 (64,7%).

**b. Siapa.** SIB Semester 5 tinggi (56,1%, 87 dari 155); TI Semester 3 17,7%, SIB Semester 3 12,1%, TI Semester 5 10,9%. Kelas yang dipantau langsung (5 kelas) mengisi 81,5% dari roster, kelas lain 11,6%.

**c. Seberapa penting.** Ini masalah mutu data, bukan penggerak kepuasan. Kelas yang dipantau dan yang tidak dipantau **tidak berbeda** pada: kepuasan (selisih +0,01 [-0,28; 0,31]), beban berat (-1 poin [-15; +13]), tenggat bertabrakan (-7 poin [-21; +8]), arahan konsisten (-4 poin [-18; +10]), skor fasilitas (-0,04 [-0,34; 0,24]). Satu-satunya beda: belum pernah konsultasi, 16% di kelas dipantau melawan 31% di kelas lain (-15 poin [-28; -2]).

**d. Penyebab.** Tingkat respons 81,5% melawan 11,6% di periode yang sama sangat mendukung dugaan "pengisian yang dikawal di kelas berhasil". Batasnya: kelas yang dipantau adalah kelas yang diajar koordinator, jadi efek pemantauan tidak bisa dipisahkan dari efek dosen. Perbedaan konsultasi (16% melawan 31%) menunjukkan kelas itu memang berjalan berbeda. Data tidak bisa membuktikan bahwa formulir yang panjang atau pengingat di grup berpengaruh.

**e. Sisi dosen.** Respons dosen 64,7% sudah baik. n = 22.

**f. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| Sesi pengisian 10 menit di kelas lewat QR, dipandu PIC | **Kuat**: satu-satunya praktik yang terbukti (81,5% melawan 11,6%) | Rendah; PIC sudah ada di tiap kelas | PIC | Semester depan |
| PIC memantau pengisian dan melapor ke koordinator | Sedang: cara yang sama dengan kelas dipantau | Satu laporan per kelas | PIC | Semester depan |
| Formulir dipersingkat | Tidak bisa diuji: pengaruh panjang formulir tidak diukur | Mengurangi cakupan butir | Koordinator | Semester depan |
| Pengingat berkala di grup kelas | Lemah: kelas tidak dipantau hanya 11,6% | Murah | Ketua kelas, dosen | Kapan saja |

Tambahan dari analisis: sasar dulu **8 kelas tanpa responden** dan kelas dengan kurang dari 5 responden, supaya tiap kelas punya data cukup untuk dibaca.

**Ukuran keberhasilan.** Tingkat respons per kelas minimal 70%; semua 32 kelas punya sedikitnya 5 responden; butir yang sama diulang.

**g. Pertanyaan terbuka.** Apakah kelas yang tidak dipantau mendapat pengingat yang setara? Apakah dosen pengampu di kelas itu tahu ada survei? **[ISI]**

## 3. Masalah 2: beban terasa berat

**a. Seberapa luas.** 40,7% mahasiswa menilai beban berat atau sangat berat [33,7; 48,0]; 66,1% menyebut tugas mata kuliah menambah beban di luar proyek [58,9; 72,7]. Dosen yang menilai beban berat 18,2%.

**b. Siapa.**

| Kelompok | Beban berat [selang] | n |
|---|---|---|
| SIB Semester 3 | 57,1% [36,5; 75,5] | 21 |
| TI Semester 5 | 44,0% [26,7; 62,9] | 25 |
| SIB Semester 5 | 40,2% [30,6; 50,7] | 87 |
| TI Semester 3 | 31,8% [20,0; 46,6] | 44 |

Selang saling tumpang tindih, jadi urutan antar semester belum terbukti. Antar kelas (n = 5 atau lebih) variasinya lebar: dari 26% (SIB-3A, 19 responden) sampai 64% (SIB-2F, 11 responden).

**c. Seberapa penting.** Mahasiswa yang menilai beban berat memberi kepuasan 3,14 melawan 3,72 (selisih -0,58 [-0,85; -0,29]) dan keinginan melanjutkan 2,96 melawan 3,68 (-0,72 [-1,07; -0,38]). Setelah kontrol, efek tetap nyata (-0,36 dan -0,56): beban adalah **prioritas kedua** setelah fasilitas.

**d. Penyebab yang didukung data.**

| Dugaan | Bukti | Penilaian |
|---|---|---|
| Tenggat yang menumpuk membuat beban terasa berat | Beban berat 58% pada yang sering mengalami tenggat bertabrakan melawan 29% (+29 poin [+14; +42]). Dalam model terkontrol +0,28 [0,14; 0,44]. | **Kuat** |
| Kontribusi tim tidak seimbang menaikkan beban individu | +0,17 [0,01; 0,33] terkontrol; mentah +11 poin [-4; +27] | Sedang |
| Tugas di luar proyek menambah beban | 66% menyebutnya, tetapi 46% melawan 30% pada yang beban berat (+16 poin [+0,7; +31]) dan terkontrol +0,11 [-0,04; 0,25] | **Lemah**: banyak yang merasakan, tidak membedakan siapa yang berat |
| Tugas yang terpisah dari proyek menaikkan beban | Porsi tugas bagian proyek berkaitan dengan beban r = -0,05 [-0,20; 0,10]; porsi latihan umum r = -0,05 | **Tidak didukung** |
| SIB Semester 3 lebih berat | +0,29 [0,03; 0,55] terkontrol | Sedang (n = 21) |

R² model hanya 0,14: survei menjelaskan sedikit tentang mengapa orang merasa berat. Faktor yang tidak diukur (jam kerja tim, kesulitan teknis, keadaan pribadi) kemungkinan besar penting.

**e. Sisi dosen.** Hanya 18,2% dosen menilai beban berat, dan dosen menilai jadwal lebih realistis (4,27) daripada mahasiswa (3,72). Dosen melihat satu mata kuliah; mahasiswa menanggung semuanya sekaligus.

**f. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| Tidak ada tugas baru di luar proyek selama pekan Milestone 2 | Sedang: 66% menyebut tugas menambah beban, tetapi efek terpisahnya lemah | Hampir tanpa biaya | Semua dosen pengampu | **Minggu ini** |
| Tugas baru dikonsultasikan ke PIC dulu | Lemah-sedang (lewat dugaan tugas tambahan yang lemah) | Satu langkah tambahan bagi dosen pendukung | PIC | Setelah Milestone 2 |
| Batas jumlah tugas per pekan, daftar dipegang PIC | Lemah | Perlu angka batas | PIC | Semester depan |
| Tugas praktikum dan jobsheet digabung ke hasil proyek | Lemah | Waktu persiapan dosen terbatas (36,4% dosen) | Dosen pengampu | Semester depan |

Usulan yang lebih kuat datang dari Masalah 3: **mengatur jadwal milestone supaya tidak jatuh di minggu kuis dan UTS mata kuliah lain**. Itu menyasar penyebab terkuat beban.

**Ukuran keberhasilan.** Persentase beban berat turun di bawah 33,7% (batas bawah selang saat ini); tenggat bertabrakan juga turun (Masalah 3).

**g. Pertanyaan terbuka.** Berapa jam per minggu tim mengerjakan PBL? Tidak ada di survei. **[ISI]**

## 4. Masalah 3: milestone PBL jatuh di minggu yang sama dengan kuis dan UTS mata kuliah lain

**Fakta jadwal (dari koordinator PBL).** Proposal (minggu 4) berjadwal sama dengan kuis 1. Milestone 1 (minggu 8) sama dengan UTS. Milestone 2 (minggu 12) sama dengan kuis 2. Kuis dan UTS itu berasal dari **mata kuliah non-PBL** dan merupakan ujian terpisah dari milestone. Milestone 3 (minggu 16) sama dengan UAS. Apakah itu bisa dipisah dan apakah Milestone 2 bisa digeser akan dibahas di rapat monev (bagian 10).

**Apa yang bisa dan tidak bisa dikatakan survei:**
- Butir tenggat berbunyi "Sejak awal semester... Tenggat tugas antar mata kuliah bertabrakan". Butir ini tidak membedakan mata kuliah PBL dari non-PBL, jadi angka 40,1% di bawah bisa berasal dari bentrok dengan kuis dan UTS, bentrok antar mata kuliah PBL, atau keduanya.
- Butir jadwal berbunyi "Jadwal dan tenggat milestone realistis" dan hanya menyangkut jadwal milestone.
- Bukti dari dosen (11 dari 22 jarang menyamakan deadline tugas) menyangkut dosen PBL satu sama lain, bukan koordinasi dengan dosen non-PBL.
- Keluhan dari wawancara: jadwal PBL sama dengan jadwal kuis, UTS, dan UAS. Mahasiswa dipilih acak dan jumlahnya tidak tercatat, jadi ini dipakai sebagai bukti kualitatif.

**a. Seberapa luas.**
- 40,1% sering atau selalu mengalami tenggat antar mata kuliah bertabrakan [33,2; 47,5]. Sebaran skor 1 sampai 5: 12, 26, 68, 60, 11.
- 35,5% tidak setuju jadwal dan tenggat milestone realistis [28,7; 42,9].
- 32,2% menyebut kendala tim baru diketahui dosen saat review milestone [25,8; 39,4].
- Tugas utama mata kuliah PBL menurut mahasiswa: deliverable proyek 41,6%, latihan dengan konteks proyek 32,2%, latihan umum 20,0%, kuis atau ujian 3,7%. Sebanyak 16 responden (9,0% [5,6; 14,2]) punya sedikitnya satu mata kuliah PBL dengan kuis atau ujian sebagai tugas utama.

**b. Siapa.** Bentrok sering: TI Semester 5 52,0% [33,5; 70,0], SIB Semester 3 42,9%, SIB Semester 5 37,9%, TI Semester 3 36,4%; selangnya tumpang tindih. Jadwal tidak realistis: SIB Semester 3 45,0%, SIB Semester 5 38,4%, TI Semester 3 33,3%, TI Semester 5 20,8%. Antar kelas bervariasi, dari 0% (TI-3C, 7 responden) sampai 56% (SIB-3G, 9 responden). Jumlah mata kuliah terintegrasi tidak membedakan: TI Semester 3 (4 mata kuliah) 36% melawan 41% pada semester lain (-5 poin [-21; +12]).

**c. Seberapa penting.**

| Perbandingan | Selisih [selang] |
|---|---|
| Keinginan melanjutkan: jadwal tidak realistis melawan realistis | **-0,74 [-1,12; -0,36]** |
| Kepuasan: jadwal tidak realistis melawan realistis | **-0,62 [-0,92; -0,32]** |
| Beban berat pada yang jadwalnya tidak realistis | 62% melawan 28% (+34 poin [+19; +49]) |
| Keinginan melanjutkan: tenggat bertabrakan melawan tidak | -0,44 [-0,81; -0,08] |
| Kepuasan: tenggat bertabrakan melawan tidak | -0,29 [-0,57; +0,01] (belum terbukti) |

Dalam model terkontrol, jadwal realistis adalah pendorong **terkuat keinginan melanjutkan** (b = +0,48 [0,21; 0,80]).

**d. Penyebab.**

| Dugaan | Bukti | Penilaian |
|---|---|---|
| Tenggat milestone jatuh di minggu yang sama dengan kuis dan UTS mata kuliah non-PBL | Fakta jadwal; keluhan dari wawancara; 35,5% menilai jadwal milestone tidak realistis | **Kuat** bahwa bentrok ini terjadi; survei tidak bisa mengukur beratnya |
| Dosen PBL jarang menyamakan deadline tugas satu sama lain | 11 dari 22 dosen jarang atau tidak pernah menyamakan deadline tugas; 6 kadang; 5 sering atau selalu. 13 dari 22 jarang membagikan progres tim. | **Kuat** (laporan dosen sendiri), untuk bentrok antar mata kuliah PBL |
| Dosen tidak melihat bentroknya | Dosen menilai jadwal realistis 4,27; mahasiswa 3,72 (selisih 0,55) | Sedang |
| Tugas terpisah per mata kuliah PBL menambah tenggat | Porsi tugas utama berupa deliverable r = -0,03 [-0,18; 0,11] dan berupa latihan r = +0,05 [-0,10; 0,19] terhadap tenggat bertabrakan: tidak ada kaitan. Tetapi porsi tugas yang menjadi bagian proyek: r = -0,17 [-0,32; -0,03], artinya tugas yang menyatu dengan proyek berkaitan dengan lebih sedikit bentrok. Responden dengan kuis atau ujian sebagai tugas utama: bentrok 56% melawan 39% (+18 poin [-9; +44], hanya 16 orang, belum terbukti). | Lemah-sedang |

**e. Sisi dosen.** Selain angka penyelarasan tenggat di atas, dosen melaporkan: tidak ada kesepakatan peran (50% menjawab tidak) dan tidak ada jadwal rapat rutin (16 dari 22 menyebutnya hambatan).

**f. Solusi yang diuji.** Kuis dan UTS berada di luar kendali program PBL, jadi pengaturan yang paling dekat dengan kendali program adalah tanggal milestone.

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| Geser tanggal milestone satu minggu dari minggu kuis dan UTS mata kuliah non-PBL | Kuat secara logika, menyasar bentrok yang diketahui; survei tidak bisa menguji pergeseran | Rendah sampai sedang; jadwal 16 minggu perlu dicek dan kalender mata kuliah lain harus diketahui | Koordinator PBL, Kaprodi | Semester depan; untuk Milestone 2 putuskan di rapat monev |
| Jurusan menerbitkan kalender kuis dan UTS semua mata kuliah semester itu sebelum tanggal milestone ditetapkan | Prasyarat opsi di atas | Koordinasi dengan dosen non-PBL | Kaprodi | Semester depan |
| Dosen mata kuliah non-PBL tidak menjadwalkan kuis atau tugas besar di minggu milestone | Sedang-lemah dari sisi kelayakan: di luar kendali program PBL | Permintaan lintas dosen | Kaprodi | Semester depan |
| Jendela pengumpulan beberapa hari setelah minggu kuis dan UTS untuk dokumen milestone, tanggal demo tetap | Sedang secara logika | Murah; perlu kesepakatan penilai | Koordinator PBL | Putuskan di rapat monev (berlaku untuk Milestone 2) |
| PIC mengurutkan pengumpulan tiap mata kuliah PBL di dalam jendela milestone | Sedang: separuh dosen PBL jarang menyamakan deadline tugas; PIC menjadi satu pintu | Pekerjaan PIC (73% dosen terkendala beban) | PIC | **Sebelum Milestone 2** |
| Kunci semua tanggal fase di awal semester; perubahan hanya lewat PIC | Sedang | Rendah | PIC, koordinator | Semester depan |
| Tenggat milestone dipecah menjadi tahap lebih kecil | Lemah: menambah titik penilaian | 73% dosen terkendala beban | PIC | Ditunda |

**Ukuran keberhasilan.** Tenggat bertabrakan di bawah 33,2%; jadwal tidak realistis di bawah 28,7%; wawancara acak diulang dengan jumlah dicatat.

**g. Keputusan yang diminta di rapat monev.** Lihat bagian 10.1, butir 1 sampai 3. Yang masih dibutuhkan sebagai data: kalender kuis dan UTS mata kuliah non-PBL per semester **[ISI]**.

## 5. Masalah 4: tugas mata kuliah belum menyatu dengan proyek

**a. Seberapa luas.** Mahasiswa yang menjawab tugas mata kuliah bagian dari proyek: 50,1% dari penilaian per mata kuliah. Dosen yang menjawab "ya": 36,4% (54,5% menjawab "sebagian"). Mahasiswa yang setuju tugas dan penilaian antar mata kuliah selaras: 55,8% [48,1; 63,1]. Bobot nilai PBL tidak disampaikan pada 26,0% penilaian. Tugas utama berupa latihan umum di luar proyek: 20,0%.

**b. Siapa (per mata kuliah).**

| Program, semester | Mata kuliah | PIC | n | Tugas bagian proyek [selang] | Kegiatan PBL sering |
|---|---|---|---|---|---|
| TI Sem 3 | Manajemen Proyek | ya | 44 | 72,7% [58,2; 83,7] | 59,1% |
| TI Sem 3 | Desain dan Pemrograman Web | | 44 | 40,9% [27,7; 55,6] | 80,5% |
| TI Sem 3 | Basis Data Lanjut | | 44 | 45,5% [31,7; 59,9] | 66,4% |
| TI Sem 3 | Sistem Informasi Manajemen | | 44 | 56,8% [42,2; 70,3] | 60,5% |
| TI Sem 5 | Pemrograman Mobile | | 25 | 32,0% [17,2; 51,6] | 73,6% |
| TI Sem 5 | Pembelajaran Mesin | ya | 25 | 48,0% [30,0; 66,5] | 77,6% |
| TI Sem 5 | Penjaminan Mutu Perangkat Lunak | | 25 | 44,0% [26,7; 62,9] | **25,6%** |
| SIB Sem 3 | Pemrograman Web | ya | 21 | 52,4% [32,4; 71,7] | 88,6% |
| SIB Sem 3 | Basis Data Lanjut | | 21 | **28,6%** [13,8; 50,0] | **35,2%** |
| SIB Sem 3 | Desain UI/UX | | 21 | 66,7% [45,4; 82,8] | 75,2% |
| SIB Sem 5 | Pemrograman Web Lanjut | ya | 87 | **35,6%** [26,4; 46,1] | 88,5% |
| SIB Sem 5 | Manajemen Proyek Sistem Informasi | | 87 | 62,1% [51,6; 71,5] | 60,5% |
| SIB Sem 5 | Penjaminan Mutu Perangkat Lunak | | 87 | 52,9% [42,5; 63,0] | 69,0% |

**c. PIC melawan mata kuliah pendukung (berpasangan per responden).**

| Ukuran | PIC | Pendukung | Selisih [selang] |
|---|---|---|---|
| Kegiatan PBL sering | 79,7% | 62,5% | **+17,1 poin [+11,3; +22,9]** |
| Kriteria penilaian sejalan dengan proyek | 66,1% | 57,1% | **+9,0 poin [+0,9; +16,6]** |
| Tugas bagian dari proyek | 48,6% | 51,1% | -2,5 poin [-12,1; +6,7] (tidak berbeda) |

Per semester untuk "tugas bagian proyek": TI Semester 3 **+25,0 poin [+6,8; +41,7]** (Manajemen Proyek unggul); SIB Semester 5 **-21,8 poin [-32,8; -9,8]** (Pemrograman Web Lanjut **lebih rendah** dari mata kuliah pendukungnya). Jenis tugas utama: sekitar 10% di mata kuliah PIC berupa latihan umum (18 dari 174 jawaban tercatat) melawan 24% di mata kuliah pendukung (97 dari 398).

**d. Seberapa penting.** Porsi tugas bagian proyek berkaitan dengan: beban r = -0,05 [-0,20; 0,10]; kepuasan r = 0,06 [-0,10; 0,21]; hanya dengan persepsi selaras r = 0,24 [0,09; 0,39]. "Tugas tidak selaras" menurunkan kepuasan mentah 0,54 poin, tetapi efek terkontrolnya -0,05 [-0,31; 0,24]. Dalam data ini keselarasan tugas **tidak** menjelaskan beban atau kepuasan. Satu kaitan yang muncul: porsi tugas bagian proyek berkaitan dengan lebih sedikit tenggat bertabrakan (r = -0,17 [-0,32; -0,03]; lihat Masalah 3).

**e. Penyebab.**

| Dugaan | Bukti | Penilaian |
|---|---|---|
| Mata kuliah pendukung kurang terintegrasi | Kegiatan PBL lebih jarang (62,5% melawan 79,7%); terendah di Penjaminan Mutu TI Sem 5 (25,6%) dan Basis Data Lanjut SIB Sem 3 (35,2%) | Sedang |
| Mata kuliah PIC sendiri sudah menyatu | Benar untuk kegiatan dan kriteria, **tidak** untuk tugas; Pemrograman Web Lanjut (kegiatan 88,5%, tugas 35,6%) adalah kasus yang menonjol dan melibatkan 87 responden | Sebagian |
| Mahasiswa salah menilai | Dosen sendiri lebih rendah (36,4% "ya" melawan 50,1% mahasiswa) | **Tidak didukung** |

**f. Sisi dosen.** Lainnya yang dilaporkan dosen: RPS sudah disesuaikan (77,3% ya), tugas bagian deliverable (36,4% ya), materi dan tugas dirancang bersama dosen lain (50,0% ya). Hambatan menyesuaikan materi: waktu persiapan terbatas 36,4%, topik proyek antar tim terlalu beragam 31,8%, kurang informasi kebutuhan milestone 22,7%, RPS sulit disesuaikan 18,2%.

**g. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| PIC menyusun peta keterkaitan mata kuliah dan milestone, pendukung melengkapi bagiannya | Sedang: celah ada di mata kuliah tertentu, bukan merata | Pendukung hanya mengisi bagiannya | PIC | Semester depan |
| Rubrik berbasis PBL beserta contoh, disusun PIC dan pendukung | **Sedang-kuat** (lihat Masalah 6) | Persiapan sekali | PIC | Semester depan |
| Bobot PBL minimal 51% di RPS semua mata kuliah | Tidak bisa diuji; kewajiban IKU 7 | 18,2% dosen sulit menyesuaikan RPS | Kaprodi, dosen | Semester depan |
| Bobot nilai dan ketentuan milestone dijelaskan ulang di kelas | **Sedang**: bobot tidak disampaikan pada 26,0% penilaian | Tanpa tambahan beban | Tiap dosen | **Minggu ini** |

Targetkan dulu empat mata kuliah dengan nilai terendah, bukan semuanya: Basis Data Lanjut SIB Sem 3, Pemrograman Mobile, Pemrograman Web Lanjut, Desain dan Pemrograman Web. Prioritas urgensi rendah (skor 0,022).

**Ukuran keberhasilan.** Tugas bagian proyek dari 50,1% menjadi 60% atau lebih pada empat mata kuliah itu; butir selaras dari 55,8% menjadi di atas 63,1%.

**h. Pertanyaan terbuka.** Apa isi tugas Pemrograman Web Lanjut yang dinilai "bukan bagian proyek"? Apakah latihan praktikum wajib menurut capaian pembelajaran? **[ISI]**

## 6. Masalah 5: arahan antar dosen berbeda-beda

**a. Seberapa luas.** Hanya 31,6% [25,2; 38,8] menjawab arahan dosen antar mata kuliah konsisten; 29,9% memilih "arahan dan tugas antar dosen tidak terkoordinasi" sebagai masalah. Yang tahu harus menghubungi dosen siapa: 69,5% [62,4; 75,8]. Yang menjawab dosen saling mengetahui progres proyek: 45,2%. Yang memilih "tidak jelas dosen rujukan" sebagai masalah: 5,1% [2,7; 9,4].

**b. Siapa.** SIB Semester 5 paling rendah (konsisten 21,8% [14,5; 31,6]); TI Semester 3 tertinggi (45,5% [31,7; 59,9]). Dalam satu semester variasi antar kelas besar: kelas SIB Semester 5 SIB-3A 5,3% (19 responden), SIB-3B 15,0% (20), SIB-3E 0% (5), melawan SIB-3D 53,8% (13). Perbedaan sebesar itu dalam satu semester menunjukkan **perbedaan antar tim dosen per kelas**, bukan perbedaan program. Kelas dipantau melawan tidak: -4 poin [-18; +10], tidak berbeda.

Sisi dosen: yang menyatakan dosen rujukan utama tim jelas 18,2% pada dosen SIB (n = 11) melawan 47,1% pada dosen TI (n = 17); kesepakatan peran 9,1% melawan 23,5%.

**c. Seberapa penting.** Arahan tidak konsisten menurunkan kepuasan 0,23 [-0,53; +0,08] dan keinginan melanjutkan 0,06 [-0,44; +0,34]: **belum terbukti**. Mahasiswa yang tidak tahu harus menghubungi dosen siapa memberi kepuasan 0,39 lebih rendah [-0,72; -0,08], dan mengetahui kontak berkaitan dengan arahan yang dinilai konsisten (+22 poin [+8; +35]). Setelah kontrol, keduanya mendekati nol.

**d. Penyebab dari sisi dosen (n = 22).**

| Dugaan | Bukti | Penilaian |
|---|---|---|
| Dosen kewalahan dan tidak punya struktur | Beban mengajar dan administrasi menghambat 16 dari 22 (72,7%); tidak ada jadwal rapat rutin 16 dari 22; tidak ada pembagian peran 9 dari 22 (40,9%) | **Kuat** (laporan sendiri) |
| Tidak ada kesepakatan peran | Ya 18,2%, sebagian 31,8%, tidak 50,0% | **Kuat** |
| Rapat koordinasi tidak efektif | Selalu hadir 5, sebagian 12, tidak pernah 5 | Sedang |
| Grup WhatsApp tidak dipakai untuk tanggapan | 14 membaca tetapi jarang menanggapi, 5 kadang, 2 jarang membuka, 1 aktif | Sedang |
| Dosen rujukan (PIC) belum jelas bagi dosen | Jelas 36,4%, sebagian 27,3%, tidak 36,4% | **Kuat** untuk SIB (18,2%) |
| Frekuensi koordinasi rendah | Tidak pernah 4, 1-2 kali 13, 3-5 kali 3, lebih dari 5 kali 2 | **Kuat** |

**e. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| PIC (pengampu mata kuliah inti) diumumkan ke dosen dan mahasiswa, per kelas | **Sedang-kuat**: peran sudah ada tetapi hanya 36,4% dosen yang merasa jelas (SIB 18,2%); 31,8% dosen meminta PIC | Hampir tanpa biaya | Koordinator, Kaprodi | **Minggu ini**: pastikan dulu PIC tahu perannya, lalu umumkan, mulai SIB Semester 5 |
| Tugas PIC dan dosen pendukung ditulis di juknis PBL Jurusan | **Kuat**: 45,5% dosen meminta; hanya 18,2% punya kesepakatan | Penulisan sekali | Koordinator | Setelah Milestone 2 |
| PIC mengirim catatan milestone di WhatsApp, dosen lain mengonfirmasi satu kata | **Sedang**: 14 dari 22 membaca tetapi jarang menanggapi | Sangat rendah; konfirmasi satu kata | PIC | **Minggu ini** |
| PIC mengadakan rapat singkat daring sekali per milestone | **Lemah-sedang**: diminta 45,5%, tetapi 72,7% terkendala beban dan hanya 5 dari 22 selalu hadir | Mudah tidak dihadiri | PIC | Setelah Milestone 2, uji dulu |

Tambahan: mulai dari **SIB Semester 5** (87 responden, konsisten 21,8%, kelas SIB-3A dan 3B terendah) lalu perluas.

**Ukuran keberhasilan.** Konsistensi arahan dari 31,6% menjadi di atas 38,8%; dosen yang menyatakan rujukan utama jelas dari 36,4% [19,7; 57,0] menjadi di atas 57,0%; kesepakatan peran dari 18,2% [7,3; 38,5] menjadi di atas 38,5%. Dengan 22 dosen perubahan kecil tidak bisa dibuktikan, jadi baca angka mentahnya.

**f. Pertanyaan terbuka.** Belum dipastikan apakah PIC tiap kelas sudah diberi tahu perannya (koordinator belum yakin); itu langkah pertama sebelum pengumuman. Siapa PIC di kelas yang punya lebih dari satu pengampu mata kuliah inti? **[ISI]**

## 7. Masalah 6: rubrik dan penilaian dinilai belum adil

**a. Seberapa luas.** Setuju penilaian adil 57,1% [49,6; 64,4]; setuju rubrik jelas 58,5% [51,0; 65,6]; memilih kontribusi anggota tidak seimbang sebagai masalah 32,8% [26,3; 40,0] (dosen 31,8% [16,4; 52,7]).

**b. Siapa.** Adil: TI Semester 5 72,7% [51,8; 86,8]; SIB Semester 3 60,0%; SIB Semester 5 54,1%; TI Semester 3 53,7%. Rubrik: TI Semester 5 70,8%; TI Semester 3 65,1%; SIB Semester 5 52,9%; SIB Semester 3 52,6%. **Kontribusi tidak seimbang paling tinggi di TI Semester 3: 54,5% [40,1; 68,3] melawan 20,7% [13,5; 30,4] di SIB Semester 5**, selang tidak tumpang tindih, jadi perbedaan nyata.

**c. Seberapa penting.** Mahasiswa yang menilai tidak adil memberi kepuasan 0,66 lebih rendah [-0,93; -0,37] dan keinginan melanjutkan 0,48 lebih rendah [-0,86; -0,13]. Setelah kontrol efeknya hilang (-0,12 dan +0,25, selang mencakup nol) karena persepsi adil sangat bertalian dengan kejelasan rubrik.

**d. Penyebab persepsi adil.** Model penilaian adil (R² = 0,61, n = 165):

| Faktor | Koefisien baku [selang] |
|---|---|
| **Rubrik jelas** | **+0,62 [0,47; 0,76]** |
| Bimbingan dosen memadai | +0,24 [0,08; 0,40] |
| Kontribusi tim tidak seimbang | -0,16 [-0,27; -0,06] |
| Arahan dosen konsisten | +0,11 [-0,01; 0,23] |
| Butir lain (beban, SOP, tenggat) | selang mencakup nol |

Korelasi rubrik dengan adil r = 0,73 [0,61; 0,81]. **Kejelasan rubrik adalah pengungkit terkuat.** Ketimpangan kontribusi berpengaruh sedang (nilai adil 0,52 poin lebih rendah pada yang memilihnya [-0,83; -0,21]).

**e. Sisi dosen.** Dosen menilai rubrik lebih jelas (4,05 melawan 3,67) dan nilai lebih adil (4,32 melawan 3,65) daripada mahasiswa. 40,9% dosen meminta panduan dan contoh penilaian [23,3; 61,3].

**f. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| Rubrik beserta contoh penilaian | **Kuat**: pengungkit terkuat persepsi adil; 40,9% dosen meminta contoh | Persiapan sekali; waktu persiapan dosen terbatas (36,4%) | PIC bersama pendukung | **Siapkan sebelum Milestone 3** |
| Penilaian 360 dengan bukti objektif, dikumpulkan PIC | **Sedang**: menyasar ketimpangan (TI Semester 3: 54,5%), tetapi efek independennya pada adil kecil dibanding rubrik | Menambah pekerjaan menilai | PIC | **Uji coba di TI Semester 3** |
| Progres dan milestone tim dipantau PIC lewat LMS | Lemah-sedang: 5 komentar mahasiswa meminta pemantauan progres | Perlu LMS | PIC | Semester depan |
| Halaman informasi resmi per program studi | Lemah untuk keadilan nilai; 5 komentar SIB menyebut template berasal dari TI | Perlu pengelola | Kaprodi | Semester depan |

Urutan: rubrik dan contoh dulu, lalu uji coba 360 di TI Semester 3.

**Ukuran keberhasilan.** Rubrik jelas dari 58,5% menjadi di atas 65,6%; adil dari 57,1% menjadi di atas 64,4%; kontribusi tidak seimbang di TI Semester 3 dari 54,5% menjadi di bawah 40,1%.

**g. Pertanyaan terbuka.** Apakah rubrik antar mata kuliah dalam satu kelas berbeda? Rubrik Pemrograman Web Lanjut SIB Semester 5 sudah ada (`rpp/Rubrik-Penilaian-PWL-SIB-Sem5.xlsx`); sudah dibagikan ke mahasiswa? **[ISI]**

## 8. Masalah 7: fasilitas lemah, bimbingan cepat tetapi sebagian tim belum dibimbing

Masalah ini dipisah menjadi dua karena datanya berlawanan arah.

### 8.1 Fasilitas

**a. Seberapa luas.** 52,3% setuju fasilitas memadai (skor 3,44 dari 5, terendah dari delapan butir); 47,7% tidak setuju [40,3; 55,1]; 19,8% memilihnya sebagai masalah [14,6; 26,3]. Dosen menilai 3,77. Bunyi butirnya: "Fasilitas dan sumber daya (perangkat, server, data) memadai".

**b. Siapa.** Merata: skor TI 3,42, SIB 3,46 (selisih -0,04 [-0,35; 0,26]). Yang memilihnya sebagai masalah: SIB 22,2%, TI 15,9% (selang tumpang tindih). Perbandingan eksploratif menurut kebutuhan deployment: semester dengan Penjaminan Mutu (TI dan SIB Semester 5) 3,47 melawan 3,40 pada yang tanpa (+0,07 [-0,24; 0,40]; 109 dan 63 responden); semester aplikasi web 3,45 melawan semester mobile TI Semester 5 3,42 (+0,03 [-0,45; 0,49]; 148 dan 24 responden). Keduanya tidak berbeda.

**c. Seberapa penting.** **Ini prioritas pertama.** Fasilitas tidak memadai: kepuasan -0,70 [-0,97; -0,43], korelasi dengan kepuasan r = 0,48 [0,33; 0,60], efek terkontrol -0,45 [-0,75; -0,17] pada kepuasan dan -0,59 [-0,97; -0,18] pada keinginan melanjutkan.

**d. Apa yang dimaksud.** Fasilitas yang dimaksud terutama **server untuk deployment, dan mahasiswa membeli VPS sendiri**. Menurut koordinator PBL, deployment **wajib**: aplikasi web memerlukannya, dan proses pengujian di Penjaminan Mutu Perangkat Lunak (TI Semester 5 dan SIB Semester 5) mensyaratkan aplikasi yang sudah ter-deploy. Data cocok dengan itu: skor sama rendah di semua semester dan program, 7 komentar bebas tentang fasilitas menyebut server dan jaringan, dan 6 komentar mengusulkan server kampus untuk deployment. Karena semua tim yang membuat aplikasi menanggung hal yang sama, ini biaya struktural, bukan keluhan satu program.

Yang tidak ada di data dan perlu ditutup sebelum memilih solusi:
- Biaya per tim per bulan, siapa yang membayar, dan apakah ada tim yang menunda deployment atau memangkas fitur karena biaya.
- Sejak milestone mana server pertama kali dibutuhkan. Untuk pengujian Penjaminan Mutu, kemungkinan sekitar Milestone 2, yang menurut alur 16 minggu berisi demo produk fungsional dan hasil uji. Belum dikonfirmasi **[ISI]**.
- Apakah aplikasi mobile TI Semester 5 membutuhkan server untuk layanan model.
- Kebutuhan server dan perkiraan biayanya belum tertulis di SOP dan materi Sosialisasi, jadi tim baru tahu setelah semester berjalan.

**e. Solusi yang diuji.** Karena deployment wajib, pilihannya menyangkut siapa menyediakan, kapan, dan berapa lama, bukan apakah perlu.

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| Tuliskan kebutuhan server dan perkiraan biayanya di SOP dan Sosialisasi sejak minggu 1, dan tentukan per mata kuliah kapan server pertama dibutuhkan (web: untuk demo; Penjaminan Mutu: untuk eksekusi uji), supaya tim menyewa sesingkat mungkin | Belum bisa diuji; kebutuhan sudah ada tetapi belum tertulis | Hampir tanpa biaya | Koordinator PBL, dosen pengampu | **Minggu ini** bagi tim yang belum menyewa |
| Survei lanjutan singkat tentang server dan biaya (Lampiran B) | Menutup kekosongan data: biaya, kapan dibutuhkan, siapa yang membayar | Sekali isi | Koordinator PBL | Setelah Milestone 2 |
| Lingkungan uji bersama dari jurusan, dipakai hanya selama pengujian Penjaminan Mutu | Menyasar kebutuhan wajib di Semester 5; belum bisa diuji | Perangkat, pengelola, keamanan; hanya selama pengujian | Jurusan, laboratorium | Semester depan |
| Server atau mesin virtual per tim yang disediakan jurusan | Fasilitas adalah prioritas pertama; biaya jurusan belum diketahui | Perangkat, pengelola, keamanan, kuota | Jurusan, laboratorium | Semester depan, setelah survei lanjutan |
| Kredit cloud untuk mahasiswa (program kredit pelajar dari penyedia cloud; periksa program yang sedang berlaku) | Belum bisa diuji | Kuota dan masa berlaku terbatas; verifikasi akun | Koordinator PBL, dosen pengampu | Setelah Milestone 2 |
| Patungan terkoordinasi per kelas: satu VPS bersama dengan akun terpisah per tim | Belum bisa diuji | Perlu pengelola dan aturan keamanan | PIC, ketua kelas | Semester depan |
| Layanan dengan tier gratis untuk pengembangan sebelum fase uji, VPS berbayar hanya saat dibutuhkan | Belum bisa diuji | Batas performa; bug deployment bisa baru terlihat belakangan | Dosen pengampu dengan panduan | Panduan **minggu ini** |

Urutan yang disarankan: tulis kebutuhan dan waktunya dulu (murah), survei lanjutan kedua, keputusan penyedia lingkungan terakhir. Keputusan penyedia diminta di rapat monev (bagian 10.1, butir 4).

**Ukuran keberhasilan.** Setuju fasilitas memadai dari 52,3% [44,9; 59,7] menjadi di atas 59,7%.

### 8.2 Bimbingan dan konsultasi

**a. Seberapa luas.** 23,2% tim belum pernah berkonsultasi [17,6; 29,9]; 31,1% tidak setuju bimbingan dosen memadai. Respons dosen: kurang dari 1 hari 94 dari 177 (53,1%), 1 sampai 2 hari 29,9%, belum pernah bertanya 10,2%, 3 sampai 7 hari 2,8%.

**b. Siapa.** SIB Semester 3 47,6% [28,3; 67,6]; TI Semester 3 25,0%; SIB Semester 5 18,4%; TI Semester 5 16,0%. Antar kelas dari 0% (SIB-3D, 13 responden; SIB-3G, 9) sampai 60% (SIB-3E, 5). Kelas dipantau 16% melawan 31% di kelas lain (-15 poin [-28; -2]).

**c. Seberapa penting (arah berlawanan dari dugaan).** Tim yang belum berkonsultasi: kepuasan **tidak berbeda** (+0,04 [-0,30; +0,39]); persepsi bimbingan memadai lebih rendah 0,37 [-0,68; -0,07]; keinginan melanjutkan terkontrol **lebih tinggi** (+0,67 [+0,30; +1,08]). Yang berkaitan dengan kepuasan adalah **persepsi** bimbingan memadai (mentah -0,75 [-1,05; -0,45]), bukan frekuensi konsultasi.

**d. Penyebab.** Tim yang tidak berkonsultasi mungkin mandiri atau tidak mengalami hambatan. Data tidak membedakannya dari tim yang enggan bertanya. Materi terlambat dipilih 19,8%; di tingkat penilaian per mata kuliah hanya 6,3% yang menjawab materi tidak sebelum milestone, dan hubungannya lemah (+15 poin [-1; +32]).

**e. Solusi yang diuji.**

| Opsi | Dukungan data | Biaya atau hambatan | Pemilik | Waktu |
|---|---|---|---|---|
| PIC membuka sesi konsultasi dengan jadwal tetap | **Lemah**: belum konsultasi tidak menurunkan kepuasan | Beban PIC; harus menggantikan jam tambahan | PIC | Uji terbatas di SIB Semester 3 |
| Dosen pendukung mengirim materi ke PIC dua pekan sebelum milestone | Lemah-sedang: 19,8% menyebut materi terlambat; waktu persiapan terbatas 36,4% dosen | Beban dosen pendukung | Dosen pendukung | Semester depan |

Data tidak mendukung menjadikan konsultasi wajib sebagai pendongkrak kepuasan. Jika dilakukan, targetnya perbaikan persepsi bimbingan di SIB Semester 3 (47,6% belum berkonsultasi), bukan semua tim.

**Ukuran keberhasilan.** Skor bimbingan dosen (3,77 dari 5 saat ini) naik, terutama di SIB Semester 3; persentase tim yang belum berkonsultasi di SIB Semester 3 turun dari 47,6%.

**f. Pertanyaan terbuka.** Mengapa SIB Semester 3 sering tidak berkonsultasi, dan apakah itu tim mandiri atau kesulitan akses ke dosen? **[ISI]**

## 9. Ringkasan solusi menurut bukti dan waktu

### 9.1 Matriks bukti

| Solusi | Masalah | Dukungan data | Catatan |
|---|---|---|---|
| Rubrik beserta contoh penilaian | Penilaian, keselarasan | **Kuat** | Pengungkit terkuat persepsi adil |
| Tugas PIC dan pendukung ditulis di juknis | Koordinasi | **Kuat** | 45,5% dosen meminta; 18,2% punya kesepakatan |
| Sesi pengisian 10 menit dipandu PIC | Respons | **Kuat** | 81,5% melawan 11,6% |
| Geser tanggal milestone satu minggu dari minggu kuis dan UTS non-PBL | Jadwal, beban | Kuat secara logika, tidak bisa diuji | Putuskan di rapat monev; butuh kalender mata kuliah lain |
| Jurusan menerbitkan kalender kuis dan UTS semua mata kuliah | Jadwal | Prasyarat opsi di atas | Owner Kaprodi |
| Jendela pengumpulan setelah minggu kuis dan UTS, demo tetap | Jadwal, beban | Sedang secara logika | Murah; putuskan di rapat monev |
| PIC mengurutkan pengumpulan tiap mata kuliah PBL dalam jendela milestone | Jadwal, beban | Sedang | Separuh dosen PBL jarang menyamakan deadline tugas |
| Kunci tanggal fase di awal semester | Jadwal | Sedang | Murah |
| PIC diumumkan ke dosen dan mahasiswa | Koordinasi | Sedang-kuat | Pastikan dulu PIC tahu perannya; mulai SIB Semester 5 |
| PIC mengirim catatan di WhatsApp, dosen mengonfirmasi | Koordinasi | Sedang | Murah |
| Tuliskan kebutuhan server dan biaya di SOP, dan kapan tiap mata kuliah membutuhkannya | Fasilitas | Belum bisa diuji | Kebutuhan sudah ada tetapi belum tertulis |
| Survei lanjutan fasilitas (Lampiran B) | Fasilitas | Prasyarat keputusan | Biaya tim tidak ada di data |
| Lingkungan uji bersama dari jurusan selama pengujian Penjaminan Mutu | Fasilitas | Belum bisa diuji | Menyasar kebutuhan wajib di Semester 5 |
| Server atau VM per tim dari jurusan, kredit cloud, patungan kelas | Fasilitas | Prioritas pertama, biaya belum diketahui | Pilih setelah survei lanjutan |
| Tidak ada tugas baru di pekan Milestone 2 | Beban | Sedang | Cepat dan murah |
| Bobot dan ketentuan dijelaskan ulang di kelas | Keselarasan | Sedang | Tanpa beban tambahan |
| Penilaian 360 | Penilaian | Sedang | Uji di TI Semester 3 |
| Peta keterkaitan oleh PIC | Keselarasan | Sedang | Empat mata kuliah terendah dulu |
| Satu paket pengumpulan terpadu per milestone | Keselarasan, jadwal | Sedang | Tugas yang menyatu dengan proyek berkaitan dengan lebih sedikit bentrok antar mata kuliah |
| Dosen non-PBL tidak menjadwalkan kuis di minggu milestone | Jadwal | Sedang-lemah | Di luar kendali program PBL |
| Rapat singkat daring per milestone | Koordinasi | Lemah-sedang | Kehadiran rendah, uji dulu |
| Tugas baru dikonsultasikan ke PIC, batas tugas per pekan | Beban | Lemah | Bergantung dugaan yang lemah |
| Tugas praktikum digabung ke hasil proyek | Beban | Lemah | Waktu persiapan 36,4% |
| Konsultasi dengan jadwal tetap | Bimbingan | **Lemah** | Belum konsultasi tidak menurunkan kepuasan |
| Tenggat dipecah menjadi tahap kecil | Jadwal | Lemah | Menambah titik penilaian |
| Bobot PBL 51% di RPS | Keselarasan | Tidak bisa diuji | Kewajiban IKU 7 |
| Formulir dipersingkat | Respons | Tidak bisa diuji | Tidak diukur |

### 9.2 Urutan yang disarankan

**Sebelum Milestone 2** (minggu 12, bertepatan dengan kuis 2; ini peristiwa terdekat): putuskan di rapat monev apakah Milestone 2 digeser atau diberi jendela pengumpulan; PIC mengurutkan pengumpulan tiap mata kuliah PBL dalam jendela milestone; pastikan PIC tahu perannya lalu umumkan, mulai SIB Semester 5; tidak ada tugas baru di pekan Milestone 2; catatan milestone di WhatsApp dengan konfirmasi satu kata; bobot nilai dan ketentuan milestone dijelaskan ulang di kelas; kebutuhan server dan waktunya ditulis untuk tim yang belum menyewa.

**Setelah Milestone 2:** tugas PIC dan pendukung ditulis di juknis; survei lanjutan fasilitas; rubrik beserta contoh sebelum Milestone 3; rancang satu paket pengumpulan terpadu; Jurusan menyiapkan kalender kuis dan UTS semester depan; pilih penyedia lingkungan deployment dan uji.

**Semester depan:** tanggal milestone digeser dari minggu kuis dan UTS mata kuliah non-PBL, setelah kalender lengkap; tanggal fase dikunci di awal semester; lingkungan deployment atau uji bersama; sesi pengisian survei dipandu PIC; peta keterkaitan untuk empat mata kuliah terendah; uji coba penilaian 360 di TI Semester 3; bobot PBL di RPS.

## 10. Keputusan dan data yang masih dibutuhkan

### 10.1 Keputusan yang diminta di rapat monev

1. **Tanggal milestone terhadap kuis dan UTS mata kuliah non-PBL:** geser satu minggu, beri jendela pengumpulan, atau tetap. Khusus Milestone 2 (minggu 12, bersama kuis 2): apakah masih bisa digeser atau diberi jendela.
2. **Milestone 3 dan UAS (minggu 16):** apakah bisa dipisah.
3. **Kalender kuis dan UTS:** apakah Jurusan menerbitkan kalender semua mata kuliah sebelum jadwal milestone semester depan ditetapkan.
4. **Lingkungan deployment dan uji:** siapa menyediakan (jurusan, kredit cloud, patungan kelas) dan sejak fase mana, termasuk lingkungan uji bersama untuk Penjaminan Mutu.
5. **Peran PIC:** pengumuman per kelas dan tugasnya.
6. **Penilaian:** rubrik beserta contoh sebelum Milestone 3, dan uji coba penilaian 360 di TI Semester 3.

### 10.2 Data yang masih dibutuhkan

1. **PIC:** koordinator belum yakin PIC tiap kelas sudah diberi tahu. Pastikan dulu, lalu umumkan. Siapa PIC kalau ada lebih dari satu pengampu mata kuliah inti.
2. **Server:** biaya per tim, siapa yang membayar, sejak milestone mana server dibutuhkan untuk pengujian Penjaminan Mutu, dan apakah TI Semester 5 butuh server untuk model (lewat Lampiran B).
3. **Kalender kuis dan UTS** mata kuliah non-PBL per semester, untuk menguji pergeseran tanggal milestone.
4. **Wawancara:** sampel acak, jumlah tidak tercatat. Ulangi dengan jumlah dicatat, dan tanyakan mata kuliah dan minggu yang dimaksud.
5. **Respons:** apakah kelas yang tidak dipantau menerima pengingat setara.
6. **Target angka:** disepakati di tepi selang (bagian 11). Konfirmasi saja.

## 11. Cara membaca ukuran keberhasilan

Tiap masalah diakhiri satu ukuran dari butir survei yang sama, supaya survei semester depan bisa menjawabnya. Target diletakkan di **tepi selang kepercayaan 95%** angka sekarang. Dengan 177 responden, angka seperti 40,7% hanya pasti dalam kisaran sekitar 7 poin ke dua arah, jadi perbaikan yang lebih kecil dari itu tidak bisa dibedakan dari kebetulan pengambilan sampel.

| Ukuran | Sekarang [selang 95%] | Target | Selisih terkecil yang bisa dibuktikan |
|---|---|---|---|
| Beban berat atau sangat berat | 40,7% [33,7; 48,0] | di bawah 33,7% | 14,6 poin |
| Tenggat bertabrakan (sering atau selalu) | 40,1% [33,2; 47,5] | di bawah 33,2% | 14,6 poin |
| Jadwal milestone tidak realistis | 35,5% [28,7; 42,9] | di bawah 28,7% | 14,4 poin |
| Setuju fasilitas memadai | 52,3% [44,9; 59,7] | di atas 59,7% | 15,1 poin |
| Setuju rubrik jelas | 58,5% [51,0; 65,6] | di atas 65,6% | 14,9 poin |
| Setuju penilaian adil | 57,1% [49,6; 64,4] | di atas 64,4% | 15,1 poin |
| Arahan dosen konsisten | 31,6% [25,2; 38,8] | di atas 38,8% | 13,8 poin |
| Tahu harus menghubungi dosen siapa | 69,5% [62,4; 75,8] | di atas 75,8% | 13,7 poin |
| Setuju tugas dan penilaian selaras | 55,8% [48,1; 63,1] | di atas 63,1% | 15,3 poin |
| Dosen: dosen rujukan utama jelas (n = 22) | 36,4% [19,7; 57,0] | di atas 57,0% | 40,6 poin |
| Dosen: ada kesepakatan peran (n = 22) | 18,2% [7,3; 38,5] | di atas 38,5% | 32,6 poin |
| Tingkat respons mahasiswa | 22,0% (177 dari 806) | 70% | tidak berlaku |
| Kelas dengan sedikitnya 5 responden | 12 dari 32 | 32 dari 32 | tidak berlaku |

Tiga hal yang perlu dipahami:
1. **Tepi selang adalah batas praktis, bukan bukti.** Untuk *membuktikan* bahwa angka benar-benar berubah, survei berukuran sama harus bergeser sekitar 14 sampai 15 poin (kolom terakhir, uji dua sisi 5%, daya 80%). Untuk membuktikan perubahan 10 poin pada angka sekitar 40% dibutuhkan sekitar 375 responden per survei.
2. **Hasil hanya bisa dibandingkan bila sampelnya sebanding:** respons yang mirip dan kelas yang terwakili. Karena itu Masalah 1 menjadi syarat bagi semua ukuran lain. Respons 70% dari 806 mahasiswa berarti sekitar 564 responden, cukup untuk membuktikan perubahan sekitar 8 poin.
3. **Dosen hanya 22 orang.** Perubahan kecil tidak bisa dibuktikan sama sekali; baca angka mentah dan cerita dosen.

## Lampiran A: penelusuran angka

| Bagian | Kunci di `data/analisis.json` |
|---|---|
| 1.1 komposisi dan pembobotan | `p1_respons.komposisi`, `p1_respons.pasca_stratifikasi` |
| 1.2 model pendorong | `umum.model_pendorong.puas`, `umum.model_pendorong.lanjut` |
| 1.3 prioritas | `umum.prioritas.puas`, `umum.prioritas.lanjut` |
| 1.4 ketahanan | `sensitivitas` (benih lain: dijalankan ulang dengan `ANALISIS_SEED=7`) |
| 2 respons | `p1_respons.kelas`, `p1_respons.dipantau_vs_lain` |
| 3 beban | `p2_beban` |
| 4 jadwal | `p3_jadwal` (termasuk `tenggat_vs_porsi_*`, `tidak_realistis_vs_porsi_*`, `tenggat_empat_vs_tiga_mata_kuliah`, `responden_dengan_kuis_atau_ujian_sebagai_tugas_utama`) |
| 5 keselarasan | `p4_selaras` |
| 6 koordinasi | `p5_koordinasi` |
| 7 penilaian | `p6_penilaian` |
| 8 fasilitas dan bimbingan | `p7_fasilitas_bimbingan` (termasuk `fasilitas_semester_pmpl_vs_tanpa`, `fasilitas_semester_web_vs_mobile`) |
| 11 ukuran keberhasilan | `ukuran_keberhasilan` |

Pemeriksaan: `pemeriksaan` berisi 15 pengecekan terhadap `agregat.json`, semuanya cocok. Angka yang tidak dihitung ulang (beban dosen 18,2%, penyelarasan RPS, hambatan materi, komentar bebas, jenis tugas utama gabungan, porsi bobot tidak disampaikan) diambil dari `agregat.json`, `tema.json`, dan `tema_dosen.json`. Menjalankan ulang: `uv run --with openpyxl python -I monev/analisis/analisis_masalah.py`.

## Lampiran B: survei lanjutan tentang server dan biaya (usulan)

Tujuannya menutup kekosongan data untuk keputusan fasilitas. Anonim; hasil dilaporkan dalam kelompok minimal 5.

1. Program studi dan semester.
2. Apakah tim Anda memakai server atau VPS untuk deployment semester ini? (Ya, sudah; Ya, rencana; Tidak)
3. Untuk apa server dibutuhkan? (boleh lebih dari satu): demo aplikasi web, pengujian di Penjaminan Mutu Perangkat Lunak, layanan model ML, lainnya.
4. Sejak milestone mana server pertama kali dibutuhkan? (Proposal, Milestone 1, Milestone 2, Milestone 3). Khusus pengujian Penjaminan Mutu: pada milestone mana pengujian dimulai?
5. Jenis yang dipakai: VPS berbayar, hosting, layanan dengan tier gratis, server kampus, komputer sendiri, lainnya.
6. Biaya yang ditanggung tim per bulan: 0, di bawah Rp50.000, Rp50.000 sampai Rp100.000, Rp100.000 sampai Rp200.000, di atas Rp200.000. Siapa yang membayar? (Satu anggota, patungan tim, lainnya)
7. Mata kuliah yang mensyaratkan deployment (pilih semua yang berlaku, termasuk Penjaminan Mutu), atau tidak ada kewajiban.
8. Apakah biaya atau akses server membuat tim menunda deployment, memangkas fitur, atau berhenti? (Ya, apa; Tidak)
9. Kendala utama (boleh lebih dari satu): biaya, konfigurasi, kuota atau performa, keamanan, pembayaran, jaringan kampus, lainnya.
10. Solusi yang paling membantu (pilih dua): lingkungan uji bersama dari jurusan, server kampus untuk tiap tim, kredit cloud, patungan kelas, layanan gratis untuk pengembangan, lainnya (tulis).
