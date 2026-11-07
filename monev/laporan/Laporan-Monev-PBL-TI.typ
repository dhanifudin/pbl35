#import "lib.typ": *

#let S = d.ti
#let A = d.all
#let m = S.mhs
#let l = S.dosen
#let mo = m.monitored
#let dr = m.drivers
#let cross(f) = dr.cross.filter(c => c.factor == f).first()
#let grp(c, lab) = c.groups.filter(x => x.label == lab).first()
#let beban = cross("Beban PBL dibanding waktu tersedia")
#let kontak = cross("Tim tahu harus menghubungi dosen siapa")
#let konsis = cross("Arahan dosen antar mata kuliah konsisten")
#let konsul = cross("Konsultasi dengan dosen di luar jam kuliah")
#let belum = m.by_experience.at(0)
#let pernah = m.by_experience.at(1)
#let imp(lab) = pick(m.improve, lab)
#let best(lab) = pick(m.best, lab)
#let th(k) = tema.themes.filter(t => t.key == k).first()
#let wa(lab) = pick(l.wa.items, lab)
#let pmpl = m.courses.at(6)
#let cepat = m.consult_resp.items.filter(i => i.label == "Kurang dari 1 hari").first().pct
#let sop = dr.corr.filter(c => c.label.starts-with("SOP")).first()

#show: report.with("Program Studi D-IV Teknik Informatika", kaprodi-ti)

= Ringkasan Eksekutif

Survei monev PBL di Program Studi D-IV Teknik Informatika diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa Semester 3 dan 5) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen). Berikut ringkasan hal yang baik dan hal yang bermasalah, lalu langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa TI", sub: "target 70%", color: accent),
  tile(pc(imp("Kontribusi anggota tim tidak seimbang").pct), "Mahasiswa memilih kontribusi anggota tidak seimbang sebagai masalah", color: accent),
  tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan pelaksanaan PBL", color: accent),
  tile(pc(l.coord_yn.at(2).ya), "Dosen mengatakan sudah ada kesepakatan peran", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis, dan *#pc(m.ben.at(2).pct_agree)* setuju PBL meningkatkan kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab dalam kurang dari sehari.],
    [*#pc(l.rate, d: 1)* dosen TI mengisi survei, dan mereka menilai pelaksanaan PBL *#fmt(l.ops_mean, d: 2)* (#l.ops_cat).],
  ),
  buruk: (
    [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota yang tidak seimbang sebagai masalah, yang terbesar di TI.],
    [*#pc(m.workload_heavy_pct)* menilai beban berat, dan *#pc(m.material.at(0).pct)* mengatakan tugas menambah beban di luar proyek.],
    [Hanya *#pc(m.ben.at(3).pct_agree)* puas dan *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
    [Hanya *#pc(m.coord.at(1).ya)* menilai arahan antar dosen konsisten, dan kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)*.],
    [Penjaminan Mutu Perangkat Lunak (Semester 5): kegiatan dosen *#pc(pmpl.acts_mean)*, keselarasan materi *#pc(pmpl.bc_ya_mean)*.],
    [Respons TI hanya *#pc(m.response.rate, d: 1)*; Semester 5 hanya *#pc(m.response.sems.at(1).rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Adakan rapat evaluasi dengan dosen pengampu TI. Umumkan ringkasan hasil kepada mahasiswa. Tetapkan dosen rujukan (PIC) untuk tiap kelas. Minta dosen menyampaikan ulang rubrik, bobot nilai, dan ketentuan Milestone 2. Minta dosen menanyakan kontribusi tiap anggota saat review. Jangan ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Adakan rapat koordinasi rutin dan tetapkan peran dosen secara tertulis. Susun kalender tenggat bersama dan cocokkan tugas dengan hasil kerja (deliverable) milestone. Catat kontribusi tiap anggota. Kembalikan rubrik dengan umpan balik dalam tujuh hari. Bahas Penjaminan Mutu Perangkat Lunak dengan dosen pengampunya.],
  chip(w-depan, primary-mid), [Tetapkan aturan pembentukan tim. Berikan satu paket informasi di minggu pertama. Adakan orientasi untuk mahasiswa baru PBL dan penyegaran untuk dosen. Pantau pengisian survei di setiap kelas.],
)

#pagebreak(weak: true)

= Cakupan Responden dan Keterwakilan

== Tingkat respons dan sebaran kelas

#baik-buruk(
  baik: (
    [Dosen TI: *#pc(l.rate, d: 1)* (#l.n dari #l.roster).],
    [Kelas TI-2B yang dipantau langsung: *#pc(mo.enf.rate, d: 1)* (#mo.enf.n dari #mo.enf.roster).],
  ),
  buruk: (
    [Mahasiswa TI hanya *#pc(m.response.rate, d: 1)*: Semester 3 *#pc(m.response.sems.at(0).rate, d: 1)*, Semester 5 *#pc(m.response.sems.at(1).rate, d: 1)*.],
    [*#m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas* TI tidak punya responden.],
    [#mo.oth.n_classes kelas tanpa pemantauan: hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("ti", with-classes: true, lead: [Target respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menandai 70%.])

== Kelas yang dipantau dan kelas tanpa pemantauan

Grup WhatsApp adalah saluran komunikasi wajib dan survei diumumkan di sana, tetapi respons tetap rendah. Di TI, satu-satunya kelas yang diampu Koordinator PBL TI pada semester PBL adalah TI-2B. Di kelas itu pengisian juga diingatkan dan dipantau langsung. Di kelas lain, tautan hanya dibagikan.

#sec-keterwakilan("ti")

#apa-artinya[
  - *TI-2B mencapai #pc(mo.enf.rate, d: 1)*, kelas lain #pc(mo.oth.rate, d: 1). Selisih ini berasal dari tindak lanjut di kelas, bukan dari minat.
  - *Jawabannya serupa.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) dan #fmt(mo.oth.stats.ops_mean, d: 2); kepuasan #fmt(mo.enf.stats.puas, d: 2) dan #fmt(mo.oth.stats.puas, d: 2).
  - *Ada dua beda kecil.* Di TI-2B, kontribusi anggota lebih menonjol (#pc(mo.enf.stats.top.first().pct)); di kelas lain, waktu dan beban kerja (#pc(mo.oth.stats.top.first().pct)). Dengan #mo.enf.n responden dari satu kelas, ini bisa mencerminkan kelas itu saja, bukan pola program studi.
  - *TI Semester 5 paling kurang terwakili.* Hanya #m.response.sems.at(1).n responden dari #m.response.sems.at(1).roster mahasiswa.
]

#rekom-box(
  (aksi: [Putuskan apakah formulir dibuka lagi selama satu pekan khusus untuk kelas TI Semester 5 yang responsnya rendah.], waktu: w-ini, pj: "Kaprodi TI"),
  (aksi: [Pada survei berikutnya, minta setiap dosen pengampu TI mengingatkan dan memantau pengisian di kelasnya, seperti di TI-2B (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)). Isi survei dalam satu sesi 10 menit pada jam kuliah (lewat kode QR). DPA dan ketua kelas memastikan semua anggota mengisi, mulai dari kelas Semester 5.], waktu: w-depan, pj: "Kaprodi TI, dosen pengampu, DPA, ketua kelas", indikator: [respons minimal 70% di setiap kelas TI pada survei berikutnya]),
)

= Rangkuman per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): skor *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): skor *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih minimal satu masalah.],
    [Aspek B (integrasi antar mata kuliah): skor *#fmt(m.aspek.at(1).mhs_mean, d: 2)*; *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
  ),
)

#sec-aspek("ti")

#apa-artinya[
  - *Masalah di TI menumpuk pada aspek D*, terutama kontribusi anggota dan beban kerja, lalu pada aspek B.
  - *Dosen menilai lebih tinggi di semua aspek.* Selisihnya #fmt(calc.min(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) sampai #fmt(calc.max(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) poin.
]

= Penilaian Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Mahasiswa yang sudah pernah PBL lebih mendukung kelanjutannya: *#pc(pernah.cont_agree)*.],
  ),
  buruk: (
    [Kepuasan *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)*); melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*).],
    [Fasilitas paling rendah: *#fmt(m.ops.at(7).mean, d: 2)*; keselarasan tugas *#fmt(m.ops.at(4).mean, d: 2)*.],
    [Yang baru pertama kali mengikuti PBL hanya *#pc(belum.cont_agree)* setuju melanjutkan.],
  ),
)

#sec-opinion("ti")

#apa-artinya[
  - *Dosen merasa sudah menjelaskan, mahasiswa belum merasakannya.* Selisih terbesar ada pada jadwal dan tenggat (#sgn(S.gap.at(2).gap)), alur milestone (#sgn(S.gap.at(0).gap)), dan bimbingan (#sgn(S.gap.at(3).gap)).
  - *Mahasiswa baru tidak menilai pelaksanaan lebih buruk* (#fmt(belum.ops_mean, d: 2) berbanding #fmt(pernah.ops_mean, d: 2)), tetapi belum yakin PBL layak dilanjutkan. Mereka butuh pengalaman awal yang jelas dan terarah.
]

== Perbandingan per kelompok semester

#sec-semester("ti")

#apa-artinya[
  - *Skor hampir sama, bebannya berbeda.* Di Semester 5, #pc(m.sem_stats.at(1).berat) menilai beban berat; di Semester 3, #pc(m.sem_stats.at(0).berat).
  - *Semester 5 kurang puas* (#fmt(m.sem_stats.at(1).puas, d: 2) berbanding #fmt(m.sem_stats.at(0).puas, d: 2)), tetapi hanya #m.sem_stats.at(1).n responden, jadi baca sebagai arah.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa TI memilih definisi PBL yang benar.],
    [*#pc(pick(l.k1.items, "4 Paham").pct + pick(l.k1.items, "5 Sangat paham").pct)* dosen TI mengaku paham atau sangat paham konsep PBL.],
  ),
  buruk: (
    [*#pc(m.k3.items.at(0).pct)* mahasiswa TI belum pernah mengikuti PBL.],
    [Sekitar satu dari lima dosen TI (*#pc(100 - l.k2_correct)*) memilih langsung memberi solusi.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen TI belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("ti")

#apa-artinya[
  - *Konsepnya dipahami, pengalamannya belum.* Mahasiswa baru butuh orientasi.
  - *Dosen yang baru pertama kali mengampu terlalu sedikit untuk dilaporkan terpisah.* Dari #l.by_experience.at(0).n dosen berpengalaman, #pc(l.by_experience.at(0).k2_correct) memilih tindakan yang tepat. Penyegaran perlu menyasar kebiasaan membimbing dosen berpengalaman.
]

#rekom-box(
  (aksi: [Jadwalkan sosialisasi PBL bagi dosen TI yang belum pernah mengikutinya.], waktu: w-setelah, pj: "Kaprodi TI dan Koordinator PBL TI"),
  (aksi: [Adakan orientasi PBL di minggu pertama untuk mahasiswa yang belum pernah mengikuti PBL, dengan contoh laporan, alur milestone, dan pendamping sebaya.], waktu: w-depan, pj: "Dosen pengampu dan Koordinator PBL TI", indikator: [keinginan melanjutkan pada mahasiswa baru naik dari #pc(belum.cont_agree)]),
  (aksi: [Adakan penyegaran PBL 60 menit untuk dosen TI, dengan fokus pada pertanyaan pemandu dan menahan diri dari memberi solusi langsung.], waktu: w-depan, pj: "Koordinator PBL TI", indikator: [dosen memilih tindakan yang tepat minimal 90%]),
)

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa TI mengatakan dosen menjawab dalam kurang dari sehari.],
    [Konsultasi dimulai oleh kedua pihak pada *#pc(pick(m.consult_init.items, "Keduanya").pct)* tim.],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [Pada *#pc(pick(m.consult_init.items, "Mahasiswa").pct)* tim, hanya mahasiswa yang memulai konsultasi.],
  ),
)

#sec-konsultasi("ti")

#apa-artinya[
  - *Tim berkonsultasi saat ada kendala.* Yang belum pernah berkonsultasi justru lebih puas (#fmt(grp(konsul, "Belum pernah").puas, d: 2) berbanding #fmt(grp(konsul, "Pernah").puas, d: 2)).
  - *Tim yang belum berkonsultasi belum tentu baik-baik saja,* dan sebaliknya.
]

#rekom-box(
  (aksi: [Minta dosen menyediakan sekitar 15 menit untuk meninjau proyek tiap tim pada pertemuan terdekat sebelum review Milestone 2.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Adakan sesi tinjau proyek untuk tiap tim di setiap milestone dan catat di catatan bimbingan.], waktu: w-setelah, pj: "Dosen pengampu TI dan Koordinator PBL TI", indikator: [tim yang belum pernah berkonsultasi di bawah 10% pada survei berikutnya]),
)

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.bc.at(8).ya)* menjawab dosen tahu topik proyek tim.],
  ),
  buruk: (
    [Hanya *#pc(m.pooled.bc.at(3).ya)* menjawab tugas bagian dari proyek.],
    [*#pc(pick(m.pooled.type, "Latihan umum").pct)* tugas utama berupa latihan umum, lebih tinggi daripada SIB.],
    [Bobot nilai PBL tidak disampaikan pada *#pc(pick(m.pooled.share, "Tidak disampaikan").pct)* jawaban.],
  ),
)

#sec-keselarasan("ti")

#apa-artinya[
  - *Dokumennya selaras, tugasnya baru setengah.*
  - *Dosen TI juga melihatnya.* Hanya #pc(l.align.at(3).ya) menjawab tugas mata kuliahnya bagian dari hasil kerja proyek, dan hanya #pc(l.align.at(6).ya) menyesuaikan materi dengan kendala tim.
]

#rekom-box(
  (aksi: [Minta dosen menyampaikan ulang rubrik, bobot nilai PBL, dan ketentuan Milestone 2 di kelas.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Minta mata kuliah yang masih memberi latihan umum untuk mengaitkannya dengan proyek atau menjadikannya bagian dari hasil kerja milestone. Cocokkan setiap tugas dengan milestone dalam rapat koordinasi.], waktu: w-setelah, pj: "Dosen pengampu TI, difasilitasi Koordinator PBL TI", indikator: [jawaban "tugas bagian dari proyek" naik dari #pc(m.pooled.bc.at(3).ya) menjadi minimal 70%]),
  (aksi: [Tulis bobot nilai PBL di RPS dan umumkan di LMS.], waktu: w-depan, pj: "Dosen pengampu TI", indikator: [jawaban "bobot tidak disampaikan" di bawah 5%]),
)

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa TI menilai beban sudah sesuai.],
    [Hanya *#pc(l.workload_heavy_pct)* dosen TI menilai bebannya berat.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* mahasiswa menilai beban berat atau sangat berat.],
    [*#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban.],
    [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang menilai beban berat, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
  ),
)

#sec-workload("ti")

#apa-artinya[
  - *Beban berat sangat berhubungan dengan kepuasan.* Yang menilai beban berat ingin melanjutkan PBL #fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2), berbanding #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).
  - *Beban terasa dari jumlah semua mata kuliah,* bukan dari satu mata kuliah ("seakan-akan ada tiga PBL").
]

#rekom-box(
  (aksi: [Minta dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Susun kalender tenggat bersama untuk semua mata kuliah PBL di tiap kelas sampai akhir semester, dan tetapkan batas jumlah tugas di luar proyek untuk tiap mata kuliah.], waktu: w-setelah, pj: "Koordinator PBL TI dan dosen pengampu tiap kelas", indikator: [mahasiswa TI yang menilai beban berat di bawah 30%]),
)

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen TI tahu topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [Informasi dari koordinator jelas dan tepat waktu: *#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5.],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus bertanya ke dosen siapa.],
  ),
  buruk: (
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan konsisten, dan *#pc(m.coord.at(3).pct_oa)* mengalami tenggat bertabrakan.],
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)*, dan *#pc(l.coord_lk.at(1).pct_never)* jarang atau tidak pernah menyelaraskan rubrik.],
    [Hanya *#l.meeting.items.at(0).count dari #l.n* dosen selalu hadir di rapat koordinasi.],
  ),
)

#sec-coord("ti")

#apa-artinya[
  - *Mahasiswa merasakan akibatnya.* Yang menilai arahan konsisten lebih puas (#fmt(grp(konsis, "Ya").puas, d: 2) berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2)), begitu juga yang tahu harus bertanya ke dosen siapa (#fmt(grp(kontak, "Ya").puas, d: 2) berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)).
  - *Dosen TI menyebut sebabnya.* Tidak ada jadwal rapat rutin, dan beban mengajar serta administrasi menjadi hambatan utama. Komunikasi antar dosen dinilai #fmt(l.ops_extra.at(0).mean, d: 2) dari 5.
]

#rekom-box(
  (aksi: [Adakan satu sesi koordinasi dosen TI untuk menyamakan arahan Milestone 2, dan buat daftar sederhana dosen rujukan (PIC) tiap kelas yang diumumkan kepada mahasiswa.], waktu: w-ini, pj: "Koordinator PBL TI dan Kaprodi TI"),
  (aksi: [Adakan rapat koordinasi rutin dosen TI (dua mingguan, 30 menit) dengan agenda tetap: progres tim, tenggat, dan keselarasan rubrik. Tetapkan peran dosen di tiap kelas secara tertulis, dan sepakati apa yang boleh diminta dosen setelah proposal disetujui.], waktu: w-setelah, pj: "Kaprodi TI dan dosen pengampu", indikator: [dosen TI yang selalu hadir naik dari #l.meeting.items.at(0).count orang menjadi minimal 80% dosen; kesepakatan peran naik dari #pc(l.coord_yn.at(2).ya) menjadi minimal 80%]),
)

= Hal yang Berhubungan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP tidak menentukan kepuasan (korelasi #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)*, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
    [Rubrik jelas (*#fmt(dr.corr.at(0).r_puas, d: 2)*) dan penilaian adil (*#fmt(dr.corr.at(1).r_puas, d: 2)*) paling berhubungan dengan kepuasan, tetapi hanya #pc(m.ops.at(5).pct_agree) dan #pc(m.ops.at(6).pct_agree) yang setuju.],
    [Fasilitas berhubungan kuat (*#fmt(dr.corr.at(2).r_puas, d: 2)*), tetapi skornya paling rendah.],
  ),
)

#sec-faktor("ti")

#apa-artinya[
  - *Di TI, kejelasan rubrik dan keadilan penilaian lebih menentukan daripada di SIB.*
  - *Kelompoknya kecil* (#grp(beban, "Berat atau sangat berat").n berbanding #grp(beban, "Ringan atau sesuai").n responden pada perbandingan beban), jadi baca sebagai arah, bukan angka pasti.
]

= Hal Baik dan yang Perlu Diperbaiki

#baik-buruk(
  baik: (
    [Pengalaman dan keterampilan baru: *#pc(best("Pengalaman dan keterampilan baru yang saya peroleh").pct)*.],
    [SOP dan template: *#pc(best("SOP dan template laporan membantu").pct)*; alur milestone jelas: *#pc(best("Alur dan target milestone jelas").pct)*.],
    [Kerja sama tim: *#pc(best("Kerja sama tim").pct)*; bimbingan dosen: *#pc(best("Bimbingan dosen").pct)*.],
  ),
  buruk: (
    [Kontribusi anggota tidak seimbang: *#pc(imp("Kontribusi anggota tim tidak seimbang").pct)*.],
    [Waktu dan beban kerja: *#pc(imp("Waktu dan beban kerja").pct)*; koordinasi tim: *#pc(imp("Koordinasi tim").pct)*.],
    [Kendala teknis: *#pc(imp("Kendala teknis (teknologi, kode, bug)").pct)*; pemahaman materi: *#pc(imp("Pemahaman materi").pct)*.],
  ),
)

#sec-goodbad("ti")

== Hal yang baik sekaligus bermasalah

#sec-duasisi("ti")

#apa-artinya[
  - *Kerja sama tim punya dua sisi dan paling menonjol di TI.* #pc(m.dua_sisi.at(5).baik) menyebutnya baik, tetapi #pc(m.dua_sisi.at(5).masalah) memilih kontribusi anggota yang tidak seimbang sebagai masalah, lebih banyak daripada yang memujinya.
  - *SOP dan template tidak punya dua sisi di TI* (#pc(m.dua_sisi.at(0).baik) baik, #pc(m.dua_sisi.at(0).masalah) bermasalah), jadi template TI bisa menjadi dasar paket bersama.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").ti komentar TI* menyebut hal baik: manfaat PBL, konsultasi dengan dosen, dan template.],
    [Pujian dan kritik sering datang bersama: banyak komentar kritis ditutup dengan harapan PBL tetap dipertahankan.],
  ),
  buruk: (
    [*#th("beban").ti komentar* tentang tugas di luar proyek dan tenggat (SIB #th("beban").sib).],
    [*#th("tim").ti komentar* tentang kontribusi dan pembentukan tim (SIB #th("tim").sib).],
    [*#th("bimbingan").ti komentar* tentang bimbingan dan materi, dan *#th("perubahan").ti* tentang permintaan baru setelah proposal disetujui.],
  ),
)

#sec-komentar("ti", lead: [Mahasiswa TI mengisi #tema.substantive_ti komentar bermakna. Komentar dikelompokkan menjadi tema berikut, dibandingkan dengan SIB, dihubungkan dengan angka survei, dan dijelaskan artinya.])

#rekom-box(
  (aksi: [Sampaikan ringkasan hasil dan langkah perbaikan kepada mahasiswa TI: komentar mereka sudah dibaca dan ditindaklanjuti.], waktu: w-ini, pj: "Koordinator PBL TI"),
  (aksi: [Catat kontribusi tiap anggota pada milestone berikutnya, dan minta dosen memantaunya.], waktu: w-setelah, pj: "Dosen pengampu TI"),
  (aksi: [Tetapkan aturan pembentukan tim yang bisa diterima kedua pihak: dosen menentukan kriteria keseimbangan, mahasiswa mengusulkan susunan, dosen menyetujui, selesai sebelum minggu ke-2.], waktu: w-depan, pj: "Koordinator PBL TI dan dosen pengampu TI"),
)

= Gambaran per Mata Kuliah

#baik-buruk(
  baik: (
    [Desain dan Pemrograman Web (Semester 3): kegiatan dosen *#pc(m.courses.at(1).acts_mean)*, hadir di semua review *#pc(m.courses.at(1).att_all)*.],
    [Pembelajaran Mesin (Semester 5): kegiatan dosen *#pc(m.courses.at(5).acts_mean)*, keselarasan *#pc(m.courses.at(5).bc_ya_mean)*.],
  ),
  buruk: (
    [Penjaminan Mutu Perangkat Lunak (Semester 5): kegiatan dosen *#pc(pmpl.acts_mean)*, keselarasan *#pc(pmpl.bc_ya_mean)*, hadir di review *#pc(pmpl.att_all)*.],
    [Basis Data Lanjut dan Sistem Informasi Manajemen (Semester 3) paling sering memberi latihan umum (*#pc(m.courses.at(2).type.at(0).pct)* dan *#pc(m.courses.at(3).type.at(0).pct)*).],
  ),
)

#sec-courses("ti", lead: [Tabel berikut merangkum persepsi mahasiswa TI per mata kuliah.])

#apa-artinya[
  - *Kegiatan dosen untuk proyek sangat bervariasi antar mata kuliah,* lebih daripada antar semester.
  - *Angka ini persepsi mahasiswa* dan bisa mencerminkan sifat mata kuliahnya, bukan penilaian terhadap dosen. Bahas bersama dosen pengampu.
]

#rekom-box(
  (aksi: [Bahas gambaran per mata kuliah dengan dosen pengampu di rapat evaluasi, terutama Penjaminan Mutu Perangkat Lunak, untuk mencari penyebab dan cara memperbaikinya. Tujuannya bukan menilai individu.], waktu: w-ini, pj: "Koordinator PBL TI dan Kaprodi TI"),
  (aksi: [Tindak lanjuti hasil pembahasan itu pada milestone berikutnya.], waktu: w-setelah, pj: "Dosen pengampu mata kuliah terkait", indikator: [kegiatan dosen dan keselarasan materi minimal 50% pada survei berikutnya]),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi diurutkan menurut jumlah mahasiswa yang menyebut masalahnya dan kuatnya hubungan masalah itu dengan kepuasan.

#keputusan()

#sec-rekom-kartu((
  (judul: "Kontribusi anggota dan pembentukan tim", prioritas: w-ini,
   bukti: [#pc(imp("Kontribusi anggota tim tidak seimbang").pct) memilihnya; hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil; #th("tim").ti komentar bebas, dengan pendapat terbelah tentang cara membentuk tim.],
   minggu: ([Minta dosen menanyakan kontribusi tiap anggota saat review Milestone 2.],),
   setelah: ([Catat kontribusi tiap anggota atau adakan penilaian sejawat pada milestone berikutnya.],),
   depan: ([Tetapkan aturan pembentukan tim yang disepakati bersama dan selesaikan sebelum minggu ke-2.],),
   indikator: [penilaian adil disetujui minimal 70%], pj: "Koordinator PBL TI dan dosen pengampu TI"),
  (judul: "Beban: satukan tugas mata kuliah dengan proyek", prioritas: w-ini,
   bukti: [#pc(imp("Waktu dan beban kerja").pct) memilih waktu dan beban; #pc(m.material.at(0).pct) mengatakan tugas menambah beban; kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
   minggu: ([Minta dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.],),
   setelah: ([Susun kalender tenggat bersama sampai akhir semester.], [Cocokkan setiap tugas dengan hasil kerja milestone.]),
   depan: ([Jadikan tugas mata kuliah bagian dari hasil kerja milestone dan batasi tugas di luar proyek.],),
   indikator: [mahasiswa yang menilai beban berat di bawah 30%], pj: "Dosen pengampu dan Koordinator PBL TI"),
  (judul: "Penilaian yang jelas dan adil", prioritas: w-ini,
   bukti: [Rubrik jelas dan penilaian adil paling berhubungan dengan kepuasan (#fmt(dr.corr.at(0).r_puas, d: 2) dan #fmt(dr.corr.at(1).r_puas, d: 2)); hanya #pc(m.ops.at(5).pct_agree) setuju rubrik jelas.],
   minggu: ([Minta dosen menyampaikan ulang rubrik dan bobot nilai PBL di kelas.],),
   setelah: ([Berikan rubrik dengan contoh dan umpan balik tertulis dalam tujuh hari.],),
   depan: ([Tulis bobot nilai PBL di RPS.],),
   indikator: [rubrik jelas disetujui minimal 70%], pj: "Dosen pengampu TI"),
  (judul: "Koordinasi antar dosen dan dosen rujukan", prioritas: w-ini,
   bukti: [Arahan konsisten hanya #pc(m.coord.at(1).ya); kesepakatan peran dosen #pc(l.coord_yn.at(2).ya); #th("koordinasi").ti komentar bebas.],
   minggu: ([Adakan satu sesi koordinasi dosen TI dan buat daftar dosen rujukan (PIC) tiap kelas.],),
   setelah: ([Adakan rapat koordinasi rutin dan tetapkan peran dosen di tiap kelas secara tertulis.], [Sepakati apa yang boleh diminta dosen setelah proposal disetujui.]),
   depan: ([Tetapkan peran dan jadwal rapat di awal semester.],),
   indikator: [kesepakatan peran minimal 80%], pj: "Koordinator PBL TI dan Kaprodi TI"),
  (judul: "Tinjauan mata kuliah dengan kegiatan proyek rendah", prioritas: w-ini,
   bukti: [Penjaminan Mutu Perangkat Lunak Semester 5: kegiatan dosen #pc(pmpl.acts_mean), keselarasan #pc(pmpl.bc_ya_mean), hadir di semua review #pc(pmpl.att_all).],
   minggu: ([Bahas bersama dosen pengampu di rapat evaluasi.],),
   setelah: ([Tindak lanjuti hasil pembahasan pada milestone berikutnya.],),
   indikator: [kegiatan dan keselarasan minimal 50%], pj: "Koordinator PBL TI dan Kaprodi TI"),
  (judul: "Materi pendukung dan kendala teknis", prioritas: w-ini,
   bukti: [#pc(pick(m.material, "Materi pendukung kurang").pct) mengatakan materi pendukung kurang; #pc(pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct) mengatakan materi terlambat; #pc(imp("Kendala teknis (teknologi, kode, bug)").pct) memilih kendala teknis; #pc(imp("Pemahaman materi").pct) memilih pemahaman materi.],
   minggu: ([Sediakan 15 menit untuk meninjau proyek tiap tim pada pertemuan terdekat sebelum review.],),
   setelah: ([Adakan sesi tinjau proyek tiap tim di setiap milestone dan catat di catatan bimbingan.],),
   depan: ([Susun daftar materi yang dibutuhkan tiap milestone dan adakan kelas klinik.],),
   indikator: [materi terlambat di bawah 10%], pj: "Dosen pengampu TI"),
  (judul: "Orientasi mahasiswa baru PBL dan penyegaran dosen", prioritas: w-setelah,
   bukti: [#pc(m.k3.items.at(0).pct) mahasiswa TI belum pernah mengikuti PBL, dan yang belum pernah hanya #pc(belum.cont_agree) setuju melanjutkan (berbanding #pc(pernah.cont_agree)); #pc(l.k2_correct) dosen memilih tindakan PBL yang tepat.],
   setelah: ([Jadwalkan sosialisasi bagi dosen yang belum mengikutinya.],),
   depan: ([Adakan orientasi PBL di minggu pertama dengan contoh laporan dan pendamping sebaya.], [Adakan penyegaran PBL 60 menit untuk dosen.]),
   indikator: [keinginan melanjutkan pada mahasiswa baru minimal 60%], pj: "Koordinator PBL TI"),
  (judul: "Respons survei: pantau pengisian di setiap kelas", prioritas: w-ini,
   bukti: [Respons TI #pc(m.response.rate, d: 1) dari target 70%; TI-2B yang dipantau #pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1) di kelas lain.],
   minggu: ([Putuskan apakah formulir dibuka lagi untuk kelas Semester 5.],),
   depan: ([Minta dosen mengingatkan dan memantau pengisian di kelasnya: satu sesi 10 menit pada jam kuliah bersama DPA dan ketua kelas.],),
   indikator: [respons minimal 70% di setiap kelas TI pada survei berikutnya], pj: "Kaprodi TI dan dosen pengampu"),
))

== Rencana tindak lanjut

#sec-rekom-tabel((
  (judul: "Kontribusi dan pembentukan tim", tindakan: [Tanya kontribusi saat review; catat kontribusi; aturan pembentukan tim], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Beban tugas di luar proyek", tindakan: [Tahan tugas baru; kalender tenggat bersama; cocokkan tugas dengan hasil kerja], waktu: [#w-ini, #w-setelah]),
  (judul: "Penilaian yang jelas dan adil", tindakan: [Sampaikan ulang rubrik; umpan balik dalam tujuh hari], waktu: [#w-ini, #w-setelah]),
  (judul: "Koordinasi antar dosen", tindakan: [Sesi koordinasi dan daftar dosen rujukan; rapat rutin dan peran tertulis], waktu: [#w-ini, #w-setelah]),
  (judul: "Mata kuliah dengan kegiatan proyek rendah", tindakan: [Bahas dengan dosen pengampu; tindak lanjut], waktu: [#w-ini, #w-setelah]),
  (judul: "Materi pendukung dan kendala teknis", tindakan: [Tinjau proyek 15 menit; catatan bimbingan; daftar kebutuhan materi], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Mahasiswa baru PBL dan dosen", tindakan: [Jadwalkan sosialisasi; orientasi dan penyegaran], waktu: [#w-setelah, #w-depan]),
  (judul: "Respons survei", tindakan: [Putuskan buka lagi formulir; pantau pengisian di setiap kelas], waktu: [#w-ini, #w-depan]),
))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
