#import "lib.typ": *

#let S = d.sib
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
#let imp(lab) = pick(m.improve, lab)
#let best(lab) = pick(m.best, lab)
#let th(k) = tema.themes.filter(t => t.key == k).first()
#let wa(lab) = pick(l.wa.items, lab)
#let c3 = m.courses.at(0)   // Pemrograman Web (Semester 3)
#let bdl = m.courses.at(1)  // Basis Data Lanjut (Semester 3)
#let mpsi = m.courses.at(4) // Manajemen Proyek Sistem Informasi (Semester 5)
#let s3 = m.sem_stats.at(0)
#let s5 = m.sem_stats.at(1)
#let cepat = m.consult_resp.items.filter(i => i.label == "Kurang dari 1 hari").first().pct
#let sop = dr.corr.filter(c => c.label.starts-with("SOP")).first()
#let peran-n = int(calc.round(l.coord_yn.at(2).ya * l.n / 100))

#show: report.with("Program Studi D-IV Sistem Informasi Bisnis", kaprodi-sib)

= Ringkasan Eksekutif

Survei monev PBL pada Program Studi D-IV Sistem Informasi Bisnis diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa Semester 3 dan 5) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen). Berikut ringkasan yang baik dan yang bermasalah, disusul langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa SIB", sub: "target 70%", color: accent),
  tile(pc(m.ben.at(4).pct_agree), "Mahasiswa setuju PBL dilanjutkan", color: accent),
  tile(pc(m.coord.at(1).ya), "Mahasiswa menilai arahan antar dosen konsisten", color: accent),
  tile(pc(l.coord_yn.at(2).ya), "Dosen menyatakan ada kesepakatan pembagian peran", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis dan *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa menyebut dosen menanggapi dalam kurang dari sehari.],
    [Respons Semester 5 mencapai *#pc(m.response.sems.at(1).rate, d: 1)*; dosen SIB mengisi *#pc(l.rate, d: 1)*.],
    [*#tema.membaik.n komentar* Semester 5 menyebut pelaksanaan semester ini lebih rapi daripada sebelumnya.],
  ),
  buruk: (
    [*#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct)* memilih arahan dosen yang tidak terkoordinasi; hanya *#pc(m.coord.at(1).ya)* menilai arahan konsisten.],
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)* (#peran-n dari #l.n).],
    [Dukungan melanjutkan PBL paling rendah: *#pc(m.ben.at(4).pct_agree)* (rerata #fmt(m.ben.at(4).mean, d: 2)).],
    [Rubrik (*#fmt(m.ops.at(5).mean, d: 2)*) dan keselarasan tugas (*#fmt(m.ops.at(4).mean, d: 2)*) lemah, dinilai sama oleh dosen.],
    [*#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct)* memilih kejelasan SOP dan rubrik sebagai masalah; *#tema.sib_info.n komentar* menyebut informasi SIB datang belakangan.],
    [Fasilitas: *#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)* memilihnya sebagai masalah; Semester 3 beban berat *#pc(s3.berat)*; respons Semester 3 hanya *#pc(m.response.sems.at(0).rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Rapat evaluasi dengan dosen pengampu SIB; ringkasan hasil ke mahasiswa; daftar dosen rujukan (PIC) per kelas; dosen menyampaikan ulang rubrik, bobot nilai, dan format laporan Milestone 2; pembahasan gambaran per mata kuliah; tidak ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Rapat koordinasi rutin dan peran tertulis; ruang SIB di LMS dengan dokumen laporan gabungan; kalender tenggat bersama; telaah rubrik tiap mata kuliah terhadap rubrik PBL; jadwal review milestone.],
  chip(w-depan, primary-mid), [Paket informasi SIB pada minggu pertama; rubrik PBL yang sejajar antara produk dan manajemen proyek; bobot nilai di RPS; server deployment dan jaringan; tindak lanjut pengisian survei di setiap kelas.],
)

#pagebreak(weak: true)

= Cakupan Responden dan Keterwakilan

== Tingkat respons dan sebaran kelas

#baik-buruk(
  baik: (
    [Semester 5: *#pc(m.response.sems.at(1).rate, d: 1)* (#m.response.sems.at(1).n dari #m.response.sems.at(1).roster).],
    [Dosen SIB: *#pc(l.rate, d: 1)* (#l.n dari #l.roster).],
    [Empat kelas yang dipantau langsung: *#pc(mo.enf.rate, d: 1)*.],
  ),
  buruk: (
    [Semester 3 hanya *#pc(m.response.sems.at(0).rate, d: 1)* (#m.response.sems.at(0).n dari #m.response.sems.at(0).roster).],
    [*#m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas* SIB tidak punya responden.],
    [#mo.oth.n_classes kelas lain: *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("sib", with-classes: true, lead: [Target tingkat respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menandai 70%. Kelas Semester 5 berlabel SIB-3A dan seterusnya, kelas Semester 3 berlabel SIB-2A dan seterusnya.])

== Kelas yang dipantau dan kelas yang hanya dibagikan tautannya

Grup WhatsApp adalah saluran komunikasi wajib dan survei diumumkan di sana, tetapi respons tetap rendah. Di SIB, Koordinator PBL TI mengampu mata kuliah pada empat kelas Semester 5 (SIB-3A sampai SIB-3D) dan di sana mengingatkan serta memantau pengisian langsung. Di kelas lain, tautan hanya dibagikan.

#sec-keterwakilan("sib")

#apa-artinya[
  - *Empat kelas yang dipantau mencapai #pc(mo.enf.rate, d: 1)*; #mo.oth.n_classes kelas lain, termasuk seluruh Semester 3, hanya #pc(mo.oth.rate, d: 1). Selisih ini berasal dari tindak lanjut di kelas, bukan dari minat.
  - *Dua perbedaan jawaban layak dicatat.* Di kelas yang dipantau, arahan dosen tidak terkoordinasi lebih menonjol (#pc(pick(mo.enf.stats.top, "Arahan dan tugas antar dosen tidak terkoordinasi").pct) berbanding #pc(pick(mo.oth.stats.top, "Arahan dan tugas antar dosen tidak terkoordinasi").pct)); di kelas lain beban berat lebih sering (#pc(mo.oth.stats.berat) berbanding #pc(mo.enf.stats.berat)), kemungkinan karena kelas lain didominasi Semester 3.
  - *Jawaban umum serupa.* Kepuasan #fmt(mo.enf.stats.puas, d: 2) berbanding #fmt(mo.oth.stats.puas, d: 2).
  - *Semester 3 kurang terwakili* (#mo.oth.n responden pada kelompok kelas lain), sehingga masalah khususnya mungkin belum terlihat sepenuhnya.
]

#rekom-box(
  (aksi: [Kaprodi SIB memutuskan apakah formulir dibuka kembali satu pekan khusus bagi kelas Semester 3.], waktu: w-ini, pj: "Kaprodi SIB"),
  (aksi: [Pada survei berikutnya setiap dosen pengampu SIB mengingatkan dan memantau pengisian di kelas yang diampunya, seperti di empat kelas yang dipantau (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)). Satu sesi 10 menit pada jam kuliah (kode QR); DPA dan ketua kelas memastikan seluruh anggota mengisi, dimulai dari kelas Semester 3.], waktu: w-depan, pj: "Kaprodi SIB, dosen pengampu SIB, DPA, ketua kelas", indikator: [respons minimal 70% di setiap kelas SIB pada survei berikutnya]),
)

= Rangkuman per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): *#fmt(m.aspek.at(0).mhs_mean, d: 2)*; hanya *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): *#fmt(m.aspek.at(2).mhs_mean, d: 2)*; *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek B (integrasi antar-mata kuliah): *#pc(m.aspek.at(1).problem_pct)* memilih masalah, termasuk arahan dosen tidak terkoordinasi.],
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih sedikitnya satu masalah.],
    [Di aspek B, dosen (*#fmt(m.aspek.at(1).dosen_mean, d: 2)*) dan mahasiswa (*#fmt(m.aspek.at(1).mhs_mean, d: 2)*) sama-sama menilai rendah.],
  ),
)

#sec-aspek("sib")

#apa-artinya[
  - *Ketika kedua sisi sepakat, itu sinyal paling kuat.* Aspek B adalah satu-satunya tempat mahasiswa dan dosen menilai hampir sama; pada aspek lain dosen menilai jauh lebih tinggi.
  - *Aspek D banyak dipilih,* terutama beban kerja dan fasilitas.
]

= Opini tentang Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kerja sama *#fmt(m.ben.at(1).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju.],
    [Dosen SIB menilai PBL layak dilanjutkan (*#fmt(l.ben.at(4).mean, d: 2)*).],
  ),
  buruk: (
    [Kepuasan *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)*); melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*), lebih rendah daripada TI.],
    [Fasilitas terendah: *#fmt(m.ops.at(7).mean, d: 2)*.],
    [Selisih dosen dan mahasiswa terbesar pada keadilan penilaian (*#sgn(S.gap.at(6).gap)*) dan melanjutkan PBL (*#sgn(S.gap.at(12).gap)*).],
  ),
)

#sec-opinion("sib")

#apa-artinya[
  - *Keraguan mahasiswa tentang keadilan perlu dijawab dengan transparansi nilai.* Dosen menilai penilaian adil (#fmt(l.ops.at(6).mean, d: 2)); mahasiswa lebih ragu (#fmt(m.ops.at(6).mean, d: 2)).
  - *Rubrik dan keselarasan tugas adalah pekerjaan rumah bersama.* Selisihnya nyaris nol (rubrik #fmt(m.ops.at(5).mean, d: 2) dan #fmt(l.ops.at(5).mean, d: 2); keselarasan tugas #fmt(m.ops.at(4).mean, d: 2) dan #fmt(l.ops.at(4).mean, d: 2)).
]

== Perbandingan per kelompok semester

#sec-semester("sib")

#apa-artinya[
  - *Semester 3 sedikit lebih rendah* (#fmt(s3.ops_mean, d: 2) berbanding #fmt(s5.ops_mean, d: 2)) dan *bebannya jauh lebih berat* (#pc(s3.berat) berbanding #pc(s5.berat)).
  - *Responden Semester 3 hanya #s3.n orang,* sehingga perlu dikonfirmasi.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa SIB memilih definisi PBL yang benar.],
    [Hanya *#pc(m.k3.items.at(0).pct)* mahasiswa SIB belum pernah mengikuti PBL, jauh lebih sedikit daripada TI.],
  ),
  buruk: (
    [Hanya *#pc(l.k2_correct)* dosen SIB memilih tindakan sesuai prinsip PBL; *#int(calc.round((100 - l.k2_correct) * l.n / 100)) dari #l.n* memilih langsung memberi solusi.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen SIB belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("sib")

#apa-artinya[
  - *Konsep dipahami, kebiasaan membimbing belum.* Kesenjangan ada pada cara dosen membimbing tim yang tertinggal.
  - *Hampir seluruh dosen SIB yang menjawab sudah berpengalaman* (#l.by_experience.at(0).n orang), sehingga penyegaran perlu menyasar kebiasaan dosen berpengalaman.
]

#rekom-box(
  (aksi: [Dosen SIB yang belum mengikuti sosialisasi PBL dijadwalkan mengikuti sosialisasi.], waktu: w-setelah, pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (aksi: [Penyegaran PBL 60 menit bagi dosen pengampu SIB, berfokus pada pertanyaan pemandu dan menahan diri dari memberi solusi langsung.], waktu: w-depan, pj: "Kaprodi SIB dan Koordinator PBL TI", indikator: [dosen SIB memilih tindakan tepat minimal 90%]),
)

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa SIB menyebut dosen menanggapi dalam kurang dari sehari.],
    [Inisiatif konsultasi dari kedua pihak pada *#pc(pick(m.consult_init.items, "Keduanya").pct)* tim.],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [*#th("bimbingan").sib komentar* SIB menyebut dosen sulit dihubungi atau jarang hadir.],
  ),
)

#sec-konsultasi("sib")

#apa-artinya[
  - *Jumlah konsultasi bukan penentu kepuasan.* Yang pernah berkonsultasi puas #fmt(grp(konsul, "Pernah").puas, d: 2), yang belum #fmt(grp(konsul, "Belum pernah").puas, d: 2); konsultasi cenderung dilakukan ketika ada kendala.
  - *Kehadiran dosen pada review berbeda antar mata kuliah* (bagian 13).
]

#rekom-box(
  (aksi: [Dosen menyediakan sekitar 15 menit tinjau proyek per tim pada pertemuan terdekat sebelum review Milestone 2.], waktu: w-ini, pj: "Dosen pengampu SIB"),
  (aksi: [Sesi tinjau proyek per tim pada setiap milestone, dicatat dalam logbook tim.], waktu: w-setelah, pj: "Dosen pengampu SIB dan Kaprodi SIB", indikator: [tim yang belum berkonsultasi di bawah 10% pada survei berikutnya]),
)

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.type.at(0).pct)* tugas utama berupa deliverable proyek, lebih tinggi daripada TI.],
    [Latihan umum hanya *#pc(pick(m.pooled.type, "Latihan umum").pct)*.],
  ),
  buruk: (
    [Hanya *#pc(m.pooled.bc.at(3).ya)* menjawab tugas bagian dari proyek.],
    [Bobot nilai PBL tidak disampaikan pada *#pc(pick(m.pooled.share, "Tidak disampaikan").pct)* jawaban, lebih tinggi daripada TI.],
    [Hanya *#pc(m.pooled.bc.at(6).ya)* menjawab dosen menyesuaikan materi saat tim mengalami kendala.],
  ),
)

#sec-keselarasan("sib")

#apa-artinya[
  - *Dokumen selaras, tugas setengah.* Pada tingkat tugas keselarasan masih rendah.
  - *Sejalan dengan lemahnya rubrik dan keselarasan tugas* yang dinilai sama oleh mahasiswa dan dosen (bagian 3 dan 4).
]

#rekom-box(
  (aksi: [Dosen menyampaikan ulang rubrik, bobot nilai PBL, dan format laporan Milestone 2 di kelas masing-masing.], waktu: w-ini, pj: "Dosen pengampu SIB"),
  (aksi: [Menelaah rubrik tiap mata kuliah terhadap rubrik PBL agar sejalan, dimulai dari mata kuliah dengan keselarasan terendah.], waktu: w-setelah, pj: "Kaprodi SIB dan dosen pengampu SIB", indikator: [rubrik jelas disetujui minimal 70% mahasiswa dan dosen]),
  (aksi: [Rubrik PBL SIB yang menempatkan analisis kebutuhan, perancangan, dan manajemen proyek sejajar dengan produk; bobot nilai PBL ditulis di RPS dan diumumkan di LMS.], waktu: w-depan, pj: "Kaprodi SIB, dosen pengampu SIB, dan Koordinator PBL TI", indikator: [bobot tidak disampaikan di bawah 5%]),
)

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa SIB menilai beban sesuai.],
    [Semester 5 lebih ringan: beban berat *#pc(s5.berat)*.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* menilai beban berat; Semester 3: *#pc(s3.berat)*.],
    [*#pc(m.material.at(0).pct)* menyebut tugas mata kuliah menambah beban.],
    [Dosen SIB juga merasa beban mengampu berat: *#pc(l.workload_heavy_pct)*.],
  ),
)

#sec-workload("sib")

#apa-artinya[
  - *Beban berat sangat menurunkan kepuasan.* Puas #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2); melanjutkan PBL #fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).
  - *Jangan menambah beban dosen.* Karena dosen SIB juga merasa terbebani, tugas mahasiswa digabung dengan deliverable, bukan ditambah.
]

#rekom-box(
  (aksi: [Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2, dengan perhatian khusus pada Semester 3.], waktu: w-ini, pj: "Dosen pengampu SIB"),
  (aksi: [Kalender tenggat bersama seluruh mata kuliah PBL per kelas untuk sisa semester.], waktu: w-setelah, pj: "Kaprodi SIB dan dosen pengampu SIB", indikator: [mahasiswa SIB yang menilai beban berat di bawah 30%]),
  (aksi: [Tugas mata kuliah digabung ke dalam deliverable milestone.], waktu: w-depan, pj: "Dosen pengampu SIB"),
)

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen SIB mengetahui topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus menghubungi dosen siapa.],
  ),
  buruk: (
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)*; dosen rujukan jelas hanya *#pc(l.coord_yn.at(3).ya)*.],
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan konsisten.],
    [*#pc(l.coord_lk.at(2).pct_never)* dosen jarang atau tidak pernah berbagi progres tim; *#l.meeting.items.at(2).count dari #l.n* tidak pernah hadir pada rapat koordinasi.],
    [Komunikasi antar dosen dinilai *#fmt(l.ops_extra.at(0).mean, d: 2)* dari 5.],
  ),
)

#sec-coord("sib")

#apa-artinya[
  - *Mahasiswa yang tahu harus menghubungi dosen siapa jauh lebih puas* (#fmt(grp(kontak, "Ya").puas, d: 2) berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)), selisih terbesar pada kepuasan di SIB, sedikit melebihi selisih akibat beban (#fmt(grp(beban, "Ringan atau sesuai").puas - grp(beban, "Berat atau sangat berat").puas, d: 2)).
  - *Lebih lemah daripada TI* pada pembagian peran dan kejelasan dosen rujukan.
]

#rekom-box(
  (aksi: [Satu sesi koordinasi dosen SIB untuk menyamakan arahan Milestone 2, dan daftar sederhana dosen rujukan (PIC) per kelas yang diumumkan kepada mahasiswa.], waktu: w-ini, pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (aksi: [Rapat koordinasi rutin dosen SIB (dua mingguan, 30 menit) yang memutuskan satu arahan bersama tiap milestone dan menyelaraskan rubrik serta tenggat; pembagian peran tertulis per kelas.], waktu: w-setelah, pj: "Kaprodi SIB dan dosen pengampu SIB", indikator: [kesepakatan peran naik dari #pc(l.coord_yn.at(2).ya) menjadi minimal 80%; mahasiswa yang tahu harus menghubungi siapa naik dari #pc(m.coord.at(2).ya)]),
)

= Faktor yang Berkaitan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang tahu harus menghubungi dosen siapa: puas *#fmt(grp(kontak, "Ya").puas, d: 2)* (berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)).],
    [Kelengkapan SOP bukan penentu (korelasi #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)* (berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2)).],
    [Fasilitas paling berkaitan dengan kepuasan (*#fmt(dr.corr.at(0).r_puas, d: 2)*), tetapi dinilai terendah.],
    [Bimbingan memadai (*#fmt(dr.corr.at(1).r_puas, d: 2)*) dan jadwal jelas (*#fmt(dr.corr.at(2).r_puas, d: 2)*) berkaitan kuat.],
  ),
)

#sec-faktor("sib")

#apa-artinya[
  - *Satu temuan perlu hati-hati.* Yang menilai arahan konsisten lebih puas (#fmt(grp(konsis, "Ya").puas, d: 2)) tetapi tidak lebih ingin melanjutkan (#fmt(grp(konsis, "Ya").lanjut, d: 2) berbanding #fmt(grp(konsis, "Sebagian atau tidak").lanjut, d: 2)), dan kelompok "ya" kecil (#grp(konsis, "Ya").n orang).
  - *Seluruh angka ini keterkaitan, bukan sebab-akibat.*
]

= Hal Baik dan yang Perlu Diperbaiki

#baik-buruk(
  baik: (
    [Pengalaman dan keterampilan baru: *#pc(best("Pengalaman dan keterampilan baru yang saya peroleh").pct)*.],
    [Kerja sama tim: *#pc(best("Kerja sama tim").pct)*; SOP dan template: *#pc(best("SOP dan template laporan membantu").pct)*.],
    [Bimbingan dosen: *#pc(best("Bimbingan dosen").pct)*.],
  ),
  buruk: (
    [Waktu dan beban kerja: *#pc(imp("Waktu dan beban kerja").pct)*.],
    [Arahan dosen tidak terkoordinasi: *#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct)*.],
    [Kejelasan SOP dan rubrik: *#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct)*; fasilitas: *#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)*.],
  ),
)

#sec-goodbad("sib")

== Hal yang baik sekaligus bermasalah

#sec-duasisi("sib")

#apa-artinya[
  - *SOP dan template: dua sisi di SIB.* #pc(m.dua_sisi.at(0).baik) menyebutnya baik, tetapi #pc(m.dua_sisi.at(0).masalah) memilih kejelasan ketentuan sebagai masalah (di TI hanya #pc(d.ti.mhs.dua_sisi.at(0).masalah)). Yang belum jelas adalah ketentuan khusus SIB, terutama rubrik (#pc(m.dua_sisi.at(1).baik) baik berbanding #pc(m.dua_sisi.at(1).masalah) bermasalah).
  - *Fasilitas hanya masalah.* Disebut baik #pc(m.dua_sisi.at(6).baik), bermasalah #pc(m.dua_sisi.at(6).masalah).
  - *Bimbingan dan umpan balik adalah keunggulan.* #pc(m.dua_sisi.at(2).baik) baik, hanya #pc(m.dua_sisi.at(2).masalah) bermasalah.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").sib komentar SIB* menyebut hal baik: manfaat PBL, template, konsultasi dosen.],
    [*#tema.membaik.n komentar* Semester 5 menyebut semester ini lebih rapi daripada sebelumnya.],
  ),
  buruk: (
    [*#th("koordinasi").sib komentar* tentang koordinasi antar dosen, terbanyak di SIB (TI #th("koordinasi").ti).],
    [*#th("kejelasan").sib komentar* tentang kejelasan alur dan template; *#tema.sib_info.n* menyebut informasi atau template SIB datang belakangan.],
    [*#th("beban").sib komentar* beban; *#th("nilai").sib* transparansi penilaian; *#th("fasilitas").sib* fasilitas (seluruh komentar fasilitas dari SIB).],
  ),
)

#sec-komentar("sib", lead: [Mahasiswa SIB mengisi #tema.substantive_sib komentar bermakna, lebih banyak daripada TI dan sebagian besar dari Semester 5. Komentar dikelompokkan menjadi tema berikut, dibandingkan dengan TI, dikaitkan dengan angka survei, dan dijelaskan artinya.])

#apa-artinya[
  - *Tiga hal khas SIB.* #tema.sib_info.n komentar menyebut informasi, template, atau jadwal SIB datang belakangan atau mengikuti TI; seluruh komentar fasilitas (#th("fasilitas").n) berasal dari SIB; dan ada komentar tentang identitas SIB: penilaian terlalu condong pada produk dan kode, sedangkan kekuatan SIB adalah analisis kebutuhan dan manajemen proyek.
  - *Perbaikan terasa.* #tema.membaik.n komentar Semester 5 menyebut pelaksanaan semester ini lebih rapi daripada sebelumnya.
]

#rekom-box(
  (aksi: [Menyampaikan ringkasan hasil dan langkah perbaikan kepada mahasiswa SIB, bahwa komentar mereka dibaca dan ditindaklanjuti.], waktu: w-ini, pj: "Koordinator PBL TI bersama Kaprodi SIB"),
  (aksi: [Ruang SIB di LMS berisi dokumen laporan gabungan dan jadwal milestone, agar mahasiswa SIB tidak bergantung pada paket TI.], waktu: w-setelah, pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (aksi: [Paket informasi SIB (SOP, template, jadwal milestone, rubrik, bobot) pada minggu pertama, disusun bersama dan disampaikan melalui Kaprodi SIB dan dosen pengampu SIB.], waktu: w-depan, pj: "Kaprodi SIB, dosen pengampu SIB, dan Koordinator PBL TI"),
  (aksi: [Mengajukan server deployment bersama untuk proyek PBL dan memperbaiki jaringan, dengan mekanisme pengajuan proyek yang sederhana.], waktu: w-depan, pj: "Kaprodi SIB dan Ketua Jurusan", indikator: [skor fasilitas minimal 3,8]),
  (aksi: [Catatan kontribusi per anggota dan panduan melibatkan mitra atau calon pengguna.], waktu: w-depan, pj: "Dosen pengampu SIB"),
)

= Gambaran per Mata Kuliah

#baik-buruk(
  baik: (
    [Pemrograman Web Lanjut (Semester 5): kegiatan dosen *#pc(m.courses.at(3).acts_mean)*, hadir di semua review *#pc(m.courses.at(3).att_all)*.],
    [Pemrograman Web (Semester 3): kegiatan dosen *#pc(c3.acts_mean)*, keselarasan *#pc(c3.bc_ya_mean)*.],
  ),
  buruk: (
    [Basis Data Lanjut (Semester 3): kegiatan dosen *#pc(bdl.acts_mean)*, keselarasan *#pc(bdl.bc_ya_mean)*, penjelasan keterkaitan di awal semester *#pc(bdl.expl_ya)*.],
    [Seluruh mata kuliah Semester 3: bobot PBL tidak disampaikan pada *#pc(c3.share_not_stated)* jawaban.],
    [Manajemen Proyek Sistem Informasi (Semester 5): hadir di semua review hanya *#pc(mpsi.att_all)*.],
  ),
)

#sec-courses("sib", lead: [Tabel berikut merangkum persepsi mahasiswa SIB per mata kuliah. Semester 5 dan Semester 3 tidak dapat dibandingkan langsung karena jumlah respondennya berbeda jauh.])

#apa-artinya[
  - *Manajemen Proyek Sistem Informasi justru inti kekhasan SIB,* tetapi kehadiran dosen pada review paling rendah di Semester 5.
  - *Angka ini persepsi mahasiswa per mata kuliah,* bukan penilaian individu dosen; sebaiknya dibahas bersama dosen pengampu.
]

#rekom-box(
  (aksi: [Gambaran per mata kuliah dibahas dengan dosen pengampu pada rapat evaluasi, terutama Basis Data Lanjut Semester 3 dan kehadiran pada review di Manajemen Proyek Sistem Informasi.], waktu: w-ini, pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (aksi: [Kehadiran dosen pada review milestone dijadwalkan di awal setiap milestone, dan keterkaitan mata kuliah dengan proyek dijelaskan pada pertemuan pertama.], waktu: w-setelah, pj: "Dosen pengampu SIB", indikator: [kehadiran pada seluruh review minimal 80% di setiap mata kuliah]),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi dirangkum dari seluruh bagian di atas dan diurutkan menurut jumlah mahasiswa yang menyebut masalahnya serta kuatnya keterkaitannya dengan kepuasan.

#keputusan()

#sec-rekom-kartu((
  (judul: "Koordinasi antar dosen, peran tertulis, dan dosen rujukan", prioritas: w-ini,
   bukti: [#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct) memilih arahan tidak terkoordinasi; arahan konsisten hanya #pc(m.coord.at(1).ya); kesepakatan peran #pc(l.coord_yn.at(2).ya); #th("koordinasi").sib komentar bebas.],
   minggu: ([Satu sesi koordinasi dosen SIB dan daftar dosen rujukan (PIC) per kelas.],),
   setelah: ([Rapat koordinasi rutin dengan satu arahan bersama tiap milestone.], [Peran tertulis per kelas.]),
   depan: ([Peran dan jadwal rapat ditetapkan di awal semester.],),
   indikator: [kesepakatan peran minimal 80%; arahan konsisten minimal 60%], pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (judul: "Informasi dan template khusus SIB", prioritas: w-ini,
   bukti: [#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct) memilih kejelasan ketentuan sebagai masalah; #tema.sib_info.n komentar menyebut informasi SIB datang belakangan atau mengikuti TI.],
   minggu: ([Dosen menyampaikan ulang format laporan dan ketentuan Milestone 2 di kelas.],),
   setelah: ([Ruang SIB di LMS dengan dokumen laporan gabungan dan jadwal milestone.],),
   depan: ([Paket SIB (SOP, template, jadwal, rubrik, bobot) pada minggu pertama.],),
   indikator: [kejelasan ketentuan dipilih di bawah 10% mahasiswa], pj: "Kaprodi SIB, dosen pengampu SIB, dan Koordinator PBL TI"),
  (judul: "Rubrik PBL SIB dan keselarasan tugas", prioritas: w-ini,
   bukti: [Rubrik (#fmt(m.ops.at(5).mean, d: 2) mahasiswa, #fmt(l.ops.at(5).mean, d: 2) dosen) dan keselarasan tugas (#fmt(m.ops.at(4).mean, d: 2) dan #fmt(l.ops.at(4).mean, d: 2)) dinilai lemah oleh kedua kelompok.],
   minggu: ([Dosen menyampaikan ulang rubrik di kelas.],),
   setelah: ([Telaah rubrik tiap mata kuliah terhadap rubrik PBL.],),
   depan: ([Rubrik PBL yang menempatkan analisis dan manajemen proyek sejajar dengan produk.],),
   indikator: [rubrik jelas disetujui minimal 70%], pj: "Kaprodi SIB dan dosen pengampu SIB"),
  (judul: "Bobot nilai PBL disampaikan sejak awal", prioritas: w-ini,
   bukti: [Pada Semester 3, #pc(c3.share_not_stated) menjawab bobot PBL tidak disampaikan; penjelasan keterkaitan di awal semester pada Basis Data Lanjut hanya #pc(bdl.expl_ya).],
   minggu: ([Dosen menyampaikan ulang bobot nilai PBL di kelas.],),
   depan: ([Bobot dan keterkaitan disampaikan pada pertemuan pertama, ditulis di RPS, diumumkan di LMS.],),
   indikator: [bobot tidak disampaikan di bawah 5%], pj: "Dosen pengampu SIB"),
  (judul: "Beban: satukan tugas dengan proyek, terutama Semester 3", prioritas: w-ini,
   bukti: [#pc(imp("Waktu dan beban kerja").pct) memilih waktu dan beban; #pc(m.material.at(0).pct) menyebut tugas menambah beban; Semester 3 #pc(s3.berat) menilai beban berat.],
   minggu: ([Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.],),
   setelah: ([Kalender tenggat bersama untuk sisa semester.],),
   depan: ([Tugas digabung ke deliverable milestone.],),
   indikator: [beban berat di bawah 30%], pj: "Kaprodi SIB dan dosen pengampu SIB"),
  (judul: "Kehadiran dosen pada review dan penjelasan keterkaitan", prioritas: w-ini,
   bukti: [Basis Data Lanjut Semester 3: kegiatan dosen #pc(bdl.acts_mean), penjelasan keterkaitan #pc(bdl.expl_ya); Manajemen Proyek Sistem Informasi: hadir pada semua review #pc(mpsi.att_all).],
   minggu: ([Dibahas dengan dosen pengampu pada rapat evaluasi.],),
   setelah: ([Kehadiran pada review dijadwalkan di awal setiap milestone.],),
   indikator: [kehadiran semua review minimal 80% di setiap mata kuliah], pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (judul: "Fasilitas: server deployment dan jaringan", prioritas: w-setelah,
   bukti: [Fasilitas adalah butir terendah (#fmt(m.ops.at(7).mean, d: 2)) dan paling berkaitan dengan kepuasan (#fmt(dr.corr.at(0).r_puas, d: 2)); #pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct) menyebutnya masalah; seluruh komentar fasilitas dari SIB.],
   setelah: ([Mendata kebutuhan server proyek per tim sebagai dasar pengajuan.],),
   depan: ([Server deployment bersama dengan mekanisme pengajuan proyek.], [Perbaikan jaringan.]),
   indikator: [skor fasilitas minimal 3,8], pj: "Kaprodi SIB dan Ketua Jurusan"),
  (judul: "Kontribusi anggota, mitra, dan penyegaran dosen", prioritas: w-setelah,
   bukti: [#pc(imp("Kontribusi anggota tim tidak seimbang").pct) memilih kontribusi tidak seimbang; #pc(imp("Mitra atau calon pengguna").pct) memilih mitra atau calon pengguna; hanya #pc(l.k2_correct) dosen memilih tindakan PBL yang tepat.],
   setelah: ([Catatan kontribusi per anggota pada milestone berikutnya.], [Dosen yang belum mengikuti sosialisasi dijadwalkan.]),
   depan: ([Panduan melibatkan mitra.], [Penyegaran PBL 60 menit bagi dosen.]),
   indikator: [penilaian adil disetujui minimal 70%; dosen memilih tindakan tepat minimal 90%], pj: "Dosen pengampu SIB dan Koordinator PBL TI"),
  (judul: "Tingkat respons survei: tindak lanjut di setiap kelas", prioritas: w-ini,
   bukti: [SIB #pc(m.response.rate, d: 1) dari target 70%; empat kelas yang dipantau #pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1) di kelas lain; Semester 3 hanya #pc(m.response.sems.at(0).rate, d: 1).],
   minggu: ([Kaprodi SIB memutuskan pembukaan kembali formulir bagi Semester 3.],),
   depan: ([Dosen pengampu mengingatkan dan memantau pengisian di kelasnya, satu sesi 10 menit di jam kuliah dengan DPA dan ketua kelas.],),
   indikator: [respons minimal 70% di setiap kelas SIB pada survei berikutnya], pj: "Kaprodi SIB dan dosen pengampu SIB"),
))

== Rencana tindak lanjut

#sec-rekom-tabel((
  (judul: "Koordinasi antar dosen", tindakan: [Sesi koordinasi dan daftar PIC; rapat rutin dan peran tertulis], waktu: [#w-ini, #w-setelah]),
  (judul: "Informasi dan template SIB", tindakan: [Sampaikan ulang ketentuan; ruang SIB di LMS; paket minggu pertama], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Rubrik PBL SIB", tindakan: [Sampaikan ulang rubrik; telaah rubrik; rancang rubrik sejajar], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Bobot nilai PBL", tindakan: [Sampaikan ulang; tulis di RPS], waktu: [#w-ini, #w-depan]),
  (judul: "Beban, terutama Semester 3", tindakan: [Tahan tugas baru; kalender tenggat; gabung tugas], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Kehadiran review dan keterkaitan", tindakan: [Dibahas dengan dosen; jadwalkan review], waktu: [#w-ini, #w-setelah]),
  (judul: "Fasilitas", tindakan: [Data kebutuhan server; server bersama dan jaringan], waktu: [#w-setelah, #w-depan]),
  (judul: "Kontribusi, mitra, dosen", tindakan: [Catatan kontribusi; panduan mitra; penyegaran], waktu: [#w-setelah, #w-depan]),
  (judul: "Tingkat respons survei", tindakan: [Putusan buka kembali formulir; tindak lanjut di setiap kelas], waktu: [#w-ini, #w-depan]),
))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
