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

Survei monev PBL pada Program Studi D-IV Teknik Informatika diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa Semester 3 dan 5) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen). Berikut ringkasan yang baik dan yang bermasalah, disusul langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa TI", sub: "target 70%", color: accent),
  tile(pc(imp("Kontribusi anggota tim tidak seimbang").pct), "Mahasiswa memilih kontribusi anggota tidak seimbang sebagai masalah", color: accent),
  tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan pelaksanaan PBL", color: accent),
  tile(pc(l.coord_yn.at(2).ya), "Dosen menyatakan ada kesepakatan pembagian peran", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis dan *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa menyebut dosen menanggapi dalam kurang dari sehari.],
    [Dosen TI mengisi survei *#pc(l.rate, d: 1)* dan menilai pelaksanaan *#fmt(l.ops_mean, d: 2)* (#l.ops_cat).],
  ),
  buruk: (
    [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota tidak seimbang sebagai masalah, terbesar di TI.],
    [*#pc(m.workload_heavy_pct)* menilai beban berat; *#pc(m.material.at(0).pct)* menyebut tugas menambah beban di luar proyek.],
    [Hanya *#pc(m.ben.at(3).pct_agree)* puas dan *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
    [Hanya *#pc(m.coord.at(1).ya)* menilai arahan antar dosen konsisten; kesepakatan peran dosen *#pc(l.coord_yn.at(2).ya)*.],
    [Penjaminan Mutu Perangkat Lunak (Semester 5): kegiatan dosen *#pc(pmpl.acts_mean)*, keselarasan materi *#pc(pmpl.bc_ya_mean)*.],
    [Respons TI hanya *#pc(m.response.rate, d: 1)*; Semester 5 *#pc(m.response.sems.at(1).rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Rapat evaluasi dengan dosen pengampu TI; ringkasan hasil ke mahasiswa; daftar dosen rujukan (PIC) per kelas; dosen menyampaikan ulang rubrik, bobot nilai, dan ketentuan Milestone 2; dosen menanyakan kontribusi tiap anggota saat review; tidak ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Rapat koordinasi rutin dan peran tertulis; kalender tenggat bersama dan audit tugas; catatan kontribusi anggota; rubrik dengan umpan balik tujuh hari; pembahasan Penjaminan Mutu Perangkat Lunak dengan dosen pengampu.],
  chip(w-depan, primary-mid), [Aturan pembentukan tim; satu paket informasi minggu pertama; orientasi mahasiswa baru PBL dan penyegaran dosen; tindak lanjut pengisian survei di setiap kelas.],
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
    [#mo.oth.n_classes kelas lain: *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("ti", with-classes: true, lead: [Target tingkat respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menandai 70%.])

== Kelas yang dipantau dan kelas yang hanya dibagikan tautannya

Grup WhatsApp adalah saluran komunikasi wajib dan survei diumumkan di sana, tetapi respons tetap rendah. Di TI, satu-satunya kelas yang diampu Koordinator PBL TI pada semester PBL adalah TI-2B, tempat pengisian juga diingatkan dan dipantau langsung. Di kelas lain, tautan hanya dibagikan.

#sec-keterwakilan("ti")

#apa-artinya[
  - *TI-2B mencapai #pc(mo.enf.rate, d: 1)*, kelas lain #pc(mo.oth.rate, d: 1). Selisih ini berasal dari tindak lanjut di kelas, bukan dari minat.
  - *Jawaban serupa.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) berbanding #fmt(mo.oth.stats.ops_mean, d: 2); kepuasan #fmt(mo.enf.stats.puas, d: 2) berbanding #fmt(mo.oth.stats.puas, d: 2).
  - *Dua perbedaan kecil.* Di TI-2B, kontribusi anggota lebih menonjol (#pc(mo.enf.stats.top.first().pct)); di kelas lain, waktu dan beban kerja (#pc(mo.oth.stats.top.first().pct)). Dengan #mo.enf.n responden pada satu kelas, ini bisa mencerminkan kelas itu sendiri, bukan pola program studi.
  - *TI Semester 5 paling kurang terwakili.* Hanya #m.response.sems.at(1).n responden dari #m.response.sems.at(1).roster mahasiswa.
]

#rekom-box(
  (aksi: [Kaprodi TI memutuskan apakah formulir dibuka kembali satu pekan khusus bagi kelas TI Semester 5 dengan respons rendah.], waktu: w-ini, pj: "Kaprodi TI"),
  (aksi: [Pada survei berikutnya setiap dosen pengampu TI mengingatkan dan memantau pengisian di kelas yang diampunya, seperti di TI-2B (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)). Satu sesi 10 menit pada jam kuliah (kode QR); DPA dan ketua kelas memastikan seluruh anggota mengisi, dimulai dari kelas Semester 5.], waktu: w-depan, pj: "Kaprodi TI, dosen pengampu, DPA, ketua kelas", indikator: [respons minimal 70% di setiap kelas TI pada survei berikutnya]),
)

= Rangkuman per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih sedikitnya satu masalah.],
    [Aspek B (integrasi antar-mata kuliah): *#fmt(m.aspek.at(1).mhs_mean, d: 2)*; *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
  ),
)

#sec-aspek("ti")

#apa-artinya[
  - *Masalah TI terkumpul pada aspek D*, terutama kontribusi anggota dan beban kerja, dan pada aspek B.
  - *Dosen menilai lebih tinggi pada semua aspek* (selisih #fmt(calc.min(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) sampai #fmt(calc.max(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) poin).
]

= Opini tentang Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Yang sudah pernah PBL mendukung kelanjutan: *#pc(pernah.cont_agree)*.],
  ),
  buruk: (
    [Kepuasan *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)*); melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*).],
    [Fasilitas terendah: *#fmt(m.ops.at(7).mean, d: 2)*; keselarasan tugas *#fmt(m.ops.at(4).mean, d: 2)*.],
    [Yang baru pertama kali PBL hanya *#pc(belum.cont_agree)* setuju melanjutkan.],
  ),
)

#sec-opinion("ti")

#apa-artinya[
  - *Dosen merasa sudah menjelaskan, mahasiswa belum merasakannya.* Selisih terbesar pada jadwal dan tenggat (#sgn(S.gap.at(2).gap)), alur milestone (#sgn(S.gap.at(0).gap)), dan bimbingan (#sgn(S.gap.at(3).gap)).
  - *Mahasiswa baru tidak menilai pelaksanaan lebih buruk* (#fmt(belum.ops_mean, d: 2) berbanding #fmt(pernah.ops_mean, d: 2)), tetapi belum yakin PBL layak dilanjutkan. Mereka perlu pengalaman awal yang jelas dan terarah.
]

== Perbandingan per kelompok semester

#sec-semester("ti")

#apa-artinya[
  - *Skor serupa, beban berbeda.* Semester 5: #pc(m.sem_stats.at(1).berat) menilai beban berat, Semester 3: #pc(m.sem_stats.at(0).berat).
  - *Semester 5 lebih tidak puas* (#fmt(m.sem_stats.at(1).puas, d: 2) berbanding #fmt(m.sem_stats.at(0).puas, d: 2)), tetapi hanya #m.sem_stats.at(1).n responden; dibaca sebagai arah.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa TI memilih definisi PBL yang benar.],
    [*#pc(pick(l.k1.items, "4 Paham").pct + pick(l.k1.items, "5 Sangat paham").pct)* dosen TI menyatakan paham atau sangat paham konsep PBL.],
  ),
  buruk: (
    [*#pc(m.k3.items.at(0).pct)* mahasiswa TI belum pernah mengikuti PBL.],
    [Sekitar satu dari lima dosen TI (*#pc(100 - l.k2_correct)*) memilih langsung memberi solusi.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen TI belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("ti")

#apa-artinya[
  - *Konsep dipahami, pengalaman belum.* Mahasiswa baru membutuhkan orientasi.
  - *Dosen baru pertama kali mengampu terlalu sedikit untuk dilaporkan.* Pada #l.by_experience.at(0).n dosen berpengalaman, #pc(l.by_experience.at(0).k2_correct) memilih tindakan tepat; penyegaran perlu menyasar kebiasaan membimbing dosen berpengalaman.
]

#rekom-box(
  (aksi: [Dosen TI yang belum mengikuti sosialisasi PBL dijadwalkan mengikuti sosialisasi.], waktu: w-setelah, pj: "Kaprodi TI dan Koordinator PBL TI"),
  (aksi: [Orientasi PBL minggu pertama bagi mahasiswa yang belum pernah mengikuti PBL, dengan contoh laporan, alur milestone, dan pendamping sebaya.], waktu: w-depan, pj: "Dosen pengampu dan Koordinator PBL TI", indikator: [keinginan melanjutkan pada mahasiswa baru naik dari #pc(belum.cont_agree)]),
  (aksi: [Penyegaran PBL 60 menit bagi dosen TI, berfokus pada pertanyaan pemandu dan menahan diri dari memberi solusi langsung.], waktu: w-depan, pj: "Koordinator PBL TI", indikator: [dosen memilih tindakan tepat minimal 90%]),
)

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa TI menyebut dosen menanggapi dalam kurang dari sehari.],
    [Inisiatif konsultasi dari kedua pihak pada *#pc(pick(m.consult_init.items, "Keduanya").pct)* tim.],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [Pada *#pc(pick(m.consult_init.items, "Mahasiswa").pct)* tim, inisiatif hanya dari mahasiswa.],
  ),
)

#sec-konsultasi("ti")

#apa-artinya[
  - *Konsultasi dilakukan ketika ada kendala.* Yang belum pernah berkonsultasi justru lebih puas (#fmt(grp(konsul, "Belum pernah").puas, d: 2) berbanding #fmt(grp(konsul, "Pernah").puas, d: 2)).
  - *Tim yang belum berkonsultasi tidak otomatis baik-baik saja,* dan sebaliknya.
]

#rekom-box(
  (aksi: [Dosen menyediakan sekitar 15 menit tinjau proyek per tim pada pertemuan terdekat sebelum review Milestone 2.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Sesi tinjau proyek per tim pada setiap milestone, dicatat dalam logbook tim.], waktu: w-setelah, pj: "Dosen pengampu TI dan Koordinator PBL TI", indikator: [tim yang belum berkonsultasi di bawah 10% pada survei berikutnya]),
)

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.bc.at(8).ya)* menjawab dosen mengetahui topik proyek tim.],
  ),
  buruk: (
    [Hanya *#pc(m.pooled.bc.at(3).ya)* menjawab tugas bagian dari proyek.],
    [*#pc(pick(m.pooled.type, "Latihan umum").pct)* tugas utama berupa latihan umum, lebih tinggi daripada SIB.],
    [Bobot nilai PBL tidak disampaikan pada *#pc(pick(m.pooled.share, "Tidak disampaikan").pct)* jawaban.],
  ),
)

#sec-keselarasan("ti")

#apa-artinya[
  - *Selaras di tingkat dokumen, setengah di tingkat tugas.*
  - *Dosen TI melihat hal yang sama.* Hanya #pc(l.align.at(3).ya) menjawab tugas mata kuliahnya bagian dari deliverable proyek, dan #pc(l.align.at(6).ya) menyesuaikan materi dengan kendala tim.
]

#rekom-box(
  (aksi: [Dosen menyampaikan ulang rubrik, bobot nilai PBL, dan ketentuan Milestone 2 di kelas.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Mata kuliah yang masih memberi latihan umum mengaitkannya dengan proyek atau menjadikannya bagian deliverable; dosen memetakan setiap tugas ke milestone pada rapat koordinasi.], waktu: w-setelah, pj: "Dosen pengampu TI, difasilitasi Koordinator PBL TI", indikator: [jawaban "tugas bagian dari proyek" naik dari #pc(m.pooled.bc.at(3).ya) menjadi minimal 70%]),
  (aksi: [Bobot nilai PBL ditulis di RPS dan diumumkan di LMS.], waktu: w-depan, pj: "Dosen pengampu TI", indikator: [bobot tidak disampaikan di bawah 5%]),
)

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa TI menilai beban sesuai.],
    [Hanya *#pc(l.workload_heavy_pct)* dosen TI menilai bebannya berat.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* mahasiswa menilai beban berat atau sangat berat.],
    [*#pc(m.material.at(0).pct)* menyebut tugas mata kuliah menambah beban.],
    [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang menilai beban berat, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
  ),
)

#sec-workload("ti")

#apa-artinya[
  - *Beban berat sangat berkaitan dengan kepuasan.* Yang menilai beban berat ingin melanjutkan #fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2), berbanding #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).
  - *Beban terlihat dari penjumlahan lintas mata kuliah,* bukan dari satu mata kuliah ("seakan-akan ada tiga PBL").
]

#rekom-box(
  (aksi: [Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.], waktu: w-ini, pj: "Dosen pengampu TI"),
  (aksi: [Kalender tenggat bersama seluruh mata kuliah PBL per kelas untuk sisa semester, dan batas jumlah tugas di luar proyek per mata kuliah.], waktu: w-setelah, pj: "Koordinator PBL TI dan dosen pengampu per kelas", indikator: [mahasiswa TI yang menilai beban berat di bawah 30%]),
)

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen TI mengetahui topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [Informasi dari koordinator jelas dan tepat waktu: *#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5.],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus menghubungi dosen siapa.],
  ),
  buruk: (
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan konsisten; *#pc(m.coord.at(3).pct_oa)* mengalami tenggat bertabrakan.],
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)*; *#pc(l.coord_lk.at(1).pct_never)* jarang atau tidak pernah menyelaraskan rubrik.],
    [Hanya *#l.meeting.items.at(0).count dari #l.n* dosen selalu hadir pada rapat koordinasi.],
  ),
)

#sec-coord("ti")

#apa-artinya[
  - *Mahasiswa merasakan akibatnya.* Yang menilai arahan konsisten lebih puas (#fmt(grp(konsis, "Ya").puas, d: 2) berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2)); yang tahu harus menghubungi dosen siapa juga (#fmt(grp(kontak, "Ya").puas, d: 2) berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)).
  - *Dosen TI melaporkan sebabnya.* Tidak ada jadwal rapat rutin dan beban mengajar serta administrasi menjadi hambatan utama; komunikasi antar dosen dinilai #fmt(l.ops_extra.at(0).mean, d: 2) dari 5.
]

#rekom-box(
  (aksi: [Satu sesi koordinasi dosen TI untuk menyamakan arahan Milestone 2, dan daftar sederhana dosen rujukan (PIC) per kelas yang diumumkan kepada mahasiswa.], waktu: w-ini, pj: "Koordinator PBL TI dan Kaprodi TI"),
  (aksi: [Rapat koordinasi rutin dosen TI (dua mingguan, 30 menit) dengan agenda tetap: progres tim, tenggat, dan keselarasan rubrik; pembagian peran tertulis per kelas; kesepakatan tentang apa yang boleh diminta dosen setelah proposal disetujui.], waktu: w-setelah, pj: "Kaprodi TI dan dosen pengampu", indikator: [dosen TI yang selalu hadir naik dari #l.meeting.items.at(0).count menjadi minimal 80%; kesepakatan peran naik dari #pc(l.coord_yn.at(2).ya) menjadi minimal 80%]),
)

= Faktor yang Berkaitan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP bukan penentu (korelasi #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)*, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
    [Rubrik jelas (*#fmt(dr.corr.at(0).r_puas, d: 2)*) dan penilaian adil (*#fmt(dr.corr.at(1).r_puas, d: 2)*) paling berkaitan, tetapi hanya #pc(m.ops.at(5).pct_agree) dan #pc(m.ops.at(6).pct_agree) setuju.],
    [Fasilitas berkaitan kuat (*#fmt(dr.corr.at(2).r_puas, d: 2)*), tetapi dinilai terendah.],
  ),
)

#sec-faktor("ti")

#apa-artinya[
  - *Di TI, kejelasan rubrik dan keadilan penilaian lebih menentukan daripada di SIB.*
  - *Kelompok kecil* (#grp(beban, "Berat atau sangat berat").n berbanding #grp(beban, "Ringan atau sesuai").n responden pada perbandingan beban): dibaca sebagai arah, bukan angka pasti.
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
  - *Kerja sama tim adalah dua sisi dan paling menonjol di TI.* #pc(m.dua_sisi.at(5).baik) menyebutnya baik, tetapi #pc(m.dua_sisi.at(5).masalah) memilih kontribusi anggota tidak seimbang, lebih banyak daripada yang memujinya.
  - *SOP dan template tidak dua sisi di TI* (#pc(m.dua_sisi.at(0).baik) baik berbanding #pc(m.dua_sisi.at(0).masalah) bermasalah), sehingga template TI dapat menjadi dasar paket bersama.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").ti komentar TI* menyebut hal baik: manfaat PBL, konsultasi dosen, template.],
    [Pujian dan kritik sering datang bersama: komentar kritis banyak ditutup dengan keinginan mempertahankan PBL.],
  ),
  buruk: (
    [*#th("beban").ti komentar* tentang tugas di luar proyek dan tenggat (SIB #th("beban").sib).],
    [*#th("tim").ti komentar* tentang kontribusi dan pembentukan tim (SIB #th("tim").sib).],
    [*#th("bimbingan").ti komentar* tentang bimbingan dan materi; *#th("perubahan").ti* tentang permintaan baru setelah proposal disetujui.],
  ),
)

#sec-komentar("ti", lead: [Mahasiswa TI mengisi #tema.substantive_ti komentar bermakna. Komentar dikelompokkan menjadi tema berikut, dibandingkan dengan SIB, dikaitkan dengan angka survei, dan dijelaskan artinya.])

#rekom-box(
  (aksi: [Menyampaikan ringkasan hasil dan langkah perbaikan kepada mahasiswa TI, bahwa komentar mereka dibaca dan ditindaklanjuti.], waktu: w-ini, pj: "Koordinator PBL TI"),
  (aksi: [Catatan kontribusi per anggota pada milestone berikutnya, dipantau dosen.], waktu: w-setelah, pj: "Dosen pengampu TI"),
  (aksi: [Aturan pembentukan tim yang diterima kedua pihak: dosen menetapkan kriteria keseimbangan, mahasiswa mengusulkan susunan, dosen menyetujui, selesai sebelum minggu ke-2.], waktu: w-depan, pj: "Koordinator PBL TI dan dosen pengampu TI"),
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
  - *Kegiatan dosen terkait proyek berbeda jauh antar mata kuliah,* lebih jauh daripada antar semester.
  - *Angka ini persepsi mahasiswa* dan bisa mencerminkan sifat mata kuliah, bukan penilaian terhadap dosen; pembahasannya bersama dosen pengampu.
]

#rekom-box(
  (aksi: [Gambaran per mata kuliah, terutama Penjaminan Mutu Perangkat Lunak, dibahas dengan dosen pengampu pada rapat evaluasi untuk mencari penyebab dan cara memperbaikinya. Bukan untuk menilai individu.], waktu: w-ini, pj: "Koordinator PBL TI dan Kaprodi TI"),
  (aksi: [Tindak lanjut hasil pembahasan pada milestone berikutnya.], waktu: w-setelah, pj: "Dosen pengampu mata kuliah terkait", indikator: [kegiatan dosen dan keselarasan materi minimal 50% pada survei berikutnya]),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi dirangkum dari seluruh bagian di atas dan diurutkan menurut jumlah mahasiswa yang menyebut masalahnya serta kuatnya keterkaitannya dengan kepuasan.

#keputusan()

#sec-rekom-kartu((
  (judul: "Kontribusi anggota dan pembentukan tim", prioritas: w-ini,
   bukti: [#pc(imp("Kontribusi anggota tim tidak seimbang").pct) memilihnya; hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil; #th("tim").ti komentar bebas dengan pendapat terbelah soal pembentukan tim.],
   minggu: ([Dosen menanyakan kontribusi tiap anggota saat review Milestone 2.],),
   setelah: ([Catatan kontribusi per anggota atau penilaian sejawat pada milestone berikutnya.],),
   depan: ([Aturan pembentukan tim yang disepakati, selesai sebelum minggu ke-2.],),
   indikator: [penilaian adil disetujui minimal 70%], pj: "Koordinator PBL TI dan dosen pengampu TI"),
  (judul: "Beban: satukan tugas mata kuliah dengan proyek", prioritas: w-ini,
   bukti: [#pc(imp("Waktu dan beban kerja").pct) memilih waktu dan beban; #pc(m.material.at(0).pct) menyebut tugas menambah beban; kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
   minggu: ([Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.],),
   setelah: ([Kalender tenggat bersama untuk sisa semester.], [Audit tugas terhadap deliverable milestone.]),
   depan: ([Tugas mata kuliah menjadi bagian deliverable; batas tugas di luar proyek.],),
   indikator: [beban berat di bawah 30%], pj: "Dosen pengampu dan Koordinator PBL TI"),
  (judul: "Kejelasan dan keadilan penilaian", prioritas: w-ini,
   bukti: [Rubrik jelas dan keadilan penilaian paling berkaitan dengan kepuasan (#fmt(dr.corr.at(0).r_puas, d: 2) dan #fmt(dr.corr.at(1).r_puas, d: 2)); hanya #pc(m.ops.at(5).pct_agree) setuju rubrik jelas.],
   minggu: ([Dosen menyampaikan ulang rubrik dan bobot nilai PBL di kelas.],),
   setelah: ([Rubrik dengan contoh dan umpan balik tertulis dalam tujuh hari.],),
   depan: ([Bobot nilai PBL ditulis di RPS.],),
   indikator: [rubrik jelas disetujui minimal 70%], pj: "Dosen pengampu TI"),
  (judul: "Koordinasi antar dosen dan dosen rujukan", prioritas: w-ini,
   bukti: [Arahan konsisten hanya #pc(m.coord.at(1).ya); kesepakatan peran dosen #pc(l.coord_yn.at(2).ya); #th("koordinasi").ti komentar bebas.],
   minggu: ([Satu sesi koordinasi dosen TI dan daftar dosen rujukan (PIC) per kelas.],),
   setelah: ([Rapat koordinasi rutin dan peran tertulis per kelas.], [Kesepakatan tentang permintaan setelah proposal disetujui.]),
   depan: ([Peran dan jadwal rapat ditetapkan di awal semester.],),
   indikator: [kesepakatan peran minimal 80%], pj: "Koordinator PBL TI dan Kaprodi TI"),
  (judul: "Tinjauan mata kuliah dengan kegiatan proyek rendah", prioritas: w-ini,
   bukti: [Penjaminan Mutu Perangkat Lunak Semester 5: kegiatan dosen #pc(pmpl.acts_mean), keselarasan #pc(pmpl.bc_ya_mean), hadir semua review #pc(pmpl.att_all).],
   minggu: ([Dibahas bersama dosen pengampu pada rapat evaluasi.],),
   setelah: ([Tindak lanjut hasil pembahasan pada milestone berikutnya.],),
   indikator: [kegiatan dan keselarasan minimal 50%], pj: "Koordinator PBL TI dan Kaprodi TI"),
  (judul: "Materi pendukung dan kendala teknis", prioritas: w-ini,
   bukti: [#pc(pick(m.material, "Materi pendukung kurang").pct) menyebut materi pendukung kurang; #pc(pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct) materi terlambat; #pc(imp("Kendala teknis (teknologi, kode, bug)").pct) kendala teknis; #pc(imp("Pemahaman materi").pct) pemahaman materi.],
   minggu: ([15 menit tinjau proyek per tim pada pertemuan terdekat sebelum review.],),
   setelah: ([Sesi tinjau proyek per tim tiap milestone, dicatat di logbook.],),
   depan: ([Matriks kebutuhan materi per milestone dan kelas klinik.],),
   indikator: [materi terlambat di bawah 10%], pj: "Dosen pengampu TI"),
  (judul: "Orientasi mahasiswa baru PBL dan penyegaran dosen", prioritas: w-setelah,
   bukti: [#pc(m.k3.items.at(0).pct) mahasiswa TI belum pernah mengikuti PBL, dan yang belum pernah hanya #pc(belum.cont_agree) setuju melanjutkan (berbanding #pc(pernah.cont_agree)); #pc(l.k2_correct) dosen memilih tindakan PBL yang tepat.],
   setelah: ([Dosen yang belum mengikuti sosialisasi dijadwalkan.],),
   depan: ([Orientasi PBL minggu pertama dengan contoh laporan dan pendamping sebaya.], [Penyegaran PBL 60 menit bagi dosen.]),
   indikator: [keinginan melanjutkan pada mahasiswa baru minimal 60%], pj: "Koordinator PBL TI"),
  (judul: "Tingkat respons survei: tindak lanjut di setiap kelas", prioritas: w-ini,
   bukti: [TI #pc(m.response.rate, d: 1) dari target 70%; TI-2B yang dipantau #pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1) di kelas lain.],
   minggu: ([Kaprodi TI memutuskan pembukaan kembali formulir bagi kelas Semester 5.],),
   depan: ([Dosen pengampu mengingatkan dan memantau pengisian di kelasnya, satu sesi 10 menit di jam kuliah dengan DPA dan ketua kelas.],),
   indikator: [respons minimal 70% di setiap kelas TI pada survei berikutnya], pj: "Kaprodi TI dan dosen pengampu"),
))

== Rencana tindak lanjut

#sec-rekom-tabel((
  (judul: "Kontribusi dan pembentukan tim", tindakan: [Tanya kontribusi saat review; catatan kontribusi; aturan tim], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Beban tugas di luar proyek", tindakan: [Tahan tugas baru; kalender tenggat bersama; audit tugas], waktu: [#w-ini, #w-setelah]),
  (judul: "Kejelasan dan keadilan penilaian", tindakan: [Sampaikan ulang rubrik; umpan balik tujuh hari], waktu: [#w-ini, #w-setelah]),
  (judul: "Koordinasi antar dosen", tindakan: [Sesi koordinasi dan daftar PIC; rapat rutin dan peran tertulis], waktu: [#w-ini, #w-setelah]),
  (judul: "Mata kuliah dengan kegiatan proyek rendah", tindakan: [Dibahas dengan dosen pengampu; tindak lanjut], waktu: [#w-ini, #w-setelah]),
  (judul: "Materi pendukung dan kendala teknis", tindakan: [Tinjau proyek 15 menit; logbook; matriks materi], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Mahasiswa baru PBL dan dosen", tindakan: [Jadwalkan sosialisasi; orientasi dan penyegaran], waktu: [#w-setelah, #w-depan]),
  (judul: "Tingkat respons survei", tindakan: [Putusan buka kembali formulir; tindak lanjut di setiap kelas], waktu: [#w-ini, #w-depan]),
))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
