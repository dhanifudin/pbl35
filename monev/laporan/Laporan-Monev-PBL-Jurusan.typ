#import "lib.typ": *

#let A = d.all
#let TI = d.ti
#let SIB = d.sib
#let m = A.mhs
#let l = A.dosen
#let mo = m.monitored
#let dr = m.drivers
#let cross(f) = dr.cross.filter(c => c.factor == f).first()
#let grp(c, lab) = c.groups.filter(x => x.label == lab).first()
#let beban = cross("Beban PBL dibanding waktu tersedia")
#let kontak = cross("Tim tahu harus menghubungi dosen siapa")
#let konsis = cross("Arahan dosen antar mata kuliah konsisten")
#let tahu = cross("Dosen antar mata kuliah mengetahui progres proyek")
#let konsul = cross("Konsultasi dengan dosen di luar jam kuliah")
#let wa(lab) = pick(l.wa.items, lab)
#let imp(lab) = pick(m.improve, lab)
#let best(lab) = pick(m.best, lab)
#let th(k) = tema.themes.filter(t => t.key == k).first()
#let gap-top = A.gap.sorted(key: g => -g.gap).slice(0, 6)
#let cepat = m.consult_resp.items.filter(i => i.label == "Kurang dari 1 hari").first().pct
#let sop = dr.corr.filter(c => c.label.starts-with("SOP")).first()

#show: report.with("Tingkat Jurusan (TI dan SIB)", kajur)

= Ringkasan Eksekutif

Survei monev PBL diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen) di Program Studi TI dan SIB, Semester 3 dan 5. Berikut ringkasan hal yang baik dan yang bermasalah, lalu langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa", sub: "target 70%", color: accent),
  tile(pc(m.ben.at(0).pct_agree), "Mahasiswa setuju PBL meningkatkan keterampilan teknis"),
  tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan pelaksanaan PBL", color: accent),
  tile(pc(m.coord.at(1).ya), "Mahasiswa menilai arahan antar dosen konsisten", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis, *#pc(m.ben.at(1).pct_agree)* kerja sama, dan *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu. Skor butir ini tertinggi di antara butir pelaksanaan (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab pertanyaan proyek dalam kurang dari sehari.],
    [*#pc(l.rate, d: 1)* dosen mengisi survei, dan dosen menilai pelaksanaan PBL *#fmt(l.ops_mean, d: 2)* (#l.ops_cat).],
    [Beberapa komentar SIB Semester 5 mengatakan semester ini lebih rapi daripada semester sebelumnya (#tema.membaik.n komentar).],
  ),
  buruk: (
    [Hanya *#pc(m.ben.at(3).pct_agree)* mahasiswa puas, dan hanya *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
    [*#pc(m.workload_heavy_pct)* menilai beban berat. *#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban di luar proyek.],
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar dosen konsisten. Hanya *#pc(l.coord_yn.at(2).ya)* dosen mengatakan sudah ada kesepakatan peran.],
    [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota yang tidak seimbang sebagai masalah.],
    [Skor fasilitas paling rendah (*#fmt(m.ops.at(7).mean, d: 2)*), dan *#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)* memilihnya sebagai masalah.],
    [Respons mahasiswa hanya *#pc(m.response.rate, d: 1)*. Di *#mo.oth.n_classes kelas* yang pengisiannya belum dipantau, responsnya hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#tindak-lanjut-utama()

#catatan-struktur()

#pagebreak(weak: true)

= Latar Belakang dan Cara Membaca

Survei diadakan menjelang Milestone 2 lewat dua Google Form: satu untuk mahasiswa (dwibahasa) dan satu untuk dosen. Pertanyaannya meliputi pemahaman PBL, kegiatan di tiap mata kuliah, koordinasi, dan penilaian pelaksanaan serta manfaat PBL (skala 1–5). Responden juga memilih hal yang baik dan yang bermasalah, lalu menulis saran bebas.

Hasil dibaca menurut empat aspek monev: (A) pelaksanaan PBL, (B) keterpaduan antar mata kuliah, (C) penilaian dan umpan balik, serta (D) kerja sama, beban, dan dukungan. Survei tidak menanyakan status proyek tiap tim, karena datanya sudah ada di Laporan Kemajuan. Analisis komentar bebas hanya mencakup komentar mahasiswa TI dan SIB.

= Cakupan Responden dan Seberapa Mewakili

== Tingkat respons

#baik-buruk(
  baik: (
    [Dosen: *#pc(l.rate, d: 1)* (#l.n dari #l.roster), hampir mencapai target.],
    [Di *#mo.enf.n_classes kelas yang dipantau langsung*, respons mencapai *#pc(mo.enf.rate, d: 1)*.],
  ),
  buruk: (
    [Mahasiswa: hanya *#pc(m.response.rate, d: 1)* (#m.n dari #m.response.roster), jauh di bawah target 70%.],
    [*#m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas* tidak punya responden.],
    [#mo.oth.n_classes kelas yang pengisiannya belum dipantau: hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("all", lead: [Target respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menunjukkan 70%.])

#sec-kelas("all")

== Kelas yang dipantau dan yang belum dipantau

Grup WhatsApp adalah saluran komunikasi wajib. Survei diumumkan dan diingatkan di sana, tetapi respons tetap rendah. Kelas yang diampu Koordinator PBL TI berbeda: pengisian di sana juga diingatkan dan dipantau langsung. Di kelas lain, pengisian belum dipantau khusus dan hanya bergantung pada pengumuman di grup.

#sec-keterwakilan("all")

#apa-artinya[
  - *Bedanya ada pada tindak lanjut di kelas, bukan pada minat mahasiswa.* Responsnya #pc(mo.enf.rate, d: 1) di kelas yang dipantau dan #pc(mo.oth.rate, d: 1) di kelas yang pengisiannya belum dipantau.
  - *Pengumuman di grup WhatsApp tidak cukup.* Pada survei dosen, #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup tanpa menanggapi, #wa("Jarang membuka").count jarang membukanya, dan hanya #wa("Aktif menanggapi dan berbagi informasi").count yang aktif.
  - *Jawaban kedua kelompok hampir sama.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) dan #fmt(mo.oth.stats.ops_mean, d: 2), kepuasan #fmt(mo.enf.stats.puas, d: 2) dan #fmt(mo.oth.stats.puas, d: 2), beban berat #pc(mo.enf.stats.berat) dan #pc(mo.oth.stats.berat). Jadi temuan umum tidak bergantung pada ada tidaknya pemantauan.
  - *Kelemahannya: belum cukup mewakili.* #mo.oth.n_classes kelas lain, terutama TI Semester 5, hanya diwakili sedikit mahasiswa. Masalah khusus kelas itu bisa terlewat.
]

#rekom-box(..rekom-items("respons", "all"))

= Ringkasan per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): skor *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); hanya *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): skor *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek B (keterpaduan antar mata kuliah): skor terendah di antara A sampai C (*#fmt(m.aspek.at(1).mhs_mean, d: 2)*); *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
    [Aspek D (kerja sama, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih setidaknya satu masalah, paling banyak di antara semua aspek.],
  ),
)

#sec-aspek("all")

#apa-artinya[
  - *Alur PBL sudah berjalan.* Aspek pelaksanaan dan penilaian bernilai baik, dan jarang dipilih sebagai masalah.
  - *Masalahnya ada di antara bagian-bagian PBL.* Keterpaduan antar mata kuliah (B) serta beban dan kerja sama (D) paling bermasalah.
]

= Penilaian Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Manfaat dinilai tinggi: keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kerja sama *#fmt(m.ben.at(1).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Bimbingan dosen sudah cukup: *#pc(m.ops.at(3).pct_agree)* setuju.],
  ),
  buruk: (
    [Kepuasan hanya *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)* setuju), dan keinginan melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*).],
    [Fasilitas paling rendah (*#fmt(m.ops.at(7).mean, d: 2)*); keselarasan tugas antar mata kuliah *#fmt(m.ops.at(4).mean, d: 2)*.],
    [Dosen menilai lebih tinggi daripada mahasiswa pada semua butir (selisih hingga *#sgn(calc.max(..A.gap.map(g => g.gap)))*).],
  ),
)

#sec-opinion("all")

#apa-artinya[
  - *PBL bermanfaat, tetapi menjalaninya belum memuaskan.* Penyebabnya beban, koordinasi, dan fasilitas (bagian 9 sampai 11), bukan konsep PBL.
  - *Yang jelas bagi dosen belum jelas bagi mahasiswa.* Alur dan target milestone dinilai #fmt(l.ops.at(0).mean, d: 2) oleh dosen dan #fmt(m.ops.at(0).mean, d: 2) oleh mahasiswa.
  - *Ini bukan hanya masalah mahasiswa baru.* Rerata pelaksanaan hampir sama: #fmt(m.by_experience.at(0).ops_mean, d: 2) pada yang belum pernah dan #fmt(m.by_experience.at(1).ops_mean, d: 2) pada yang pernah mengikuti PBL.
]

== Perbandingan per kelompok semester

#sec-semester("all")

#apa-artinya[
  - *Skor hampir sama, bebannya berbeda.* Beban berat paling banyak dirasakan di SIB Semester 3 (#pc(m.sem_stats.at(2).berat)), lalu TI Semester 5 (#pc(m.sem_stats.at(1).berat)). TI Semester 3 paling rendah (#pc(m.sem_stats.at(0).berat)).
  - *Hati-hati dengan kelompok kecil.* Hanya sedikit mahasiswa SIB Semester 3 dan TI Semester 5 yang menjawab.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa memilih definisi PBL yang benar.],
    [Semua dosen yang baru pertama kali mengampu PBL (#l.by_experience.at(0).n orang) memilih tindakan yang tepat.],
  ),
  buruk: (
    [Hanya *#pc(l.k2_correct)* dosen memilih tindakan yang sesuai prinsip PBL. *#int(calc.round((100 - l.k2_correct) * l.n / 100)) dari #l.n* memilih langsung memberi solusi.],
    [*#pc(m.k3.items.at(0).pct)* mahasiswa belum pernah mengikuti PBL.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("all")

#apa-artinya[
  - *Konsepnya dipahami, cara membimbingnya belum.* Kekurangannya ada pada cara dosen membimbing tim yang tertinggal.
  - *Pendampingan perlu menyasar dosen berpengalaman juga.* Hanya #pc(l.by_experience.at(1).k2_correct) dosen berpengalaman memilih tindakan yang tepat, sedangkan dosen baru #pc(l.by_experience.at(0).k2_correct).
  - *Mahasiswa baru perlu orientasi.* Sebagian besar mahasiswa TI belum pernah mengikuti PBL.
]

#rekom-box(..rekom-items("pemahaman", "all"))

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab dalam kurang dari sehari.],
    [Konsultasi biasanya dimulai oleh kedua pihak (*#pc(pick(m.consult_init.items, "Keduanya").pct)*).],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [Kesempatan konsultasi berbeda-beda antar mata kuliah (#th("bimbingan").n komentar).],
  ),
)

#sec-konsultasi("all")

#apa-artinya[
  - *Bimbingan tersedia dan cepat.* Mahasiswa menilai dosen cepat menjawab.
  - *Pernah tidaknya berkonsultasi tidak menentukan kepuasan.* Kedua kelompok sama-sama puas, #fmt(grp(konsul, "Pernah").puas, d: 2) dan #fmt(grp(konsul, "Belum pernah").puas, d: 2).
  - *Tim biasanya berkonsultasi saat kesulitan.* Yang belum pernah berkonsultasi justru sedikit lebih ingin melanjutkan PBL (#fmt(grp(konsul, "Belum pernah").lanjut, d: 2) berbanding #fmt(grp(konsul, "Pernah").lanjut, d: 2)).
]

#rekom-box(..rekom-items("bimbingan", "all"))

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.bc.at(8).ya)* menjawab dosen tahu topik proyek tim.],
    [*#pc(pick(m.pooled.type, "Deliverable proyek").pct)* tugas utama berupa hasil kerja (deliverable) proyek.],
  ),
  buruk: (
    [Hanya *#pc(m.pooled.bc.at(3).ya)* menjawab tugas mata kuliah bagian dari proyek.],
    [*#pc(pick(m.pooled.type, "Latihan umum").pct)* tugas utama berupa latihan umum yang tidak terkait proyek.],
    [Bobot nilai PBL tidak disampaikan pada *#pc(pick(m.pooled.share, "Tidak disampaikan").pct)* jawaban.],
    [Hanya *#pc(m.pooled.bc.at(6).ya)* menjawab dosen menyesuaikan materi saat tim mengalami kendala.],
  ),
)

#sec-keselarasan("all")

#apa-artinya[
  - *Dokumennya sudah selaras, tugasnya baru setengah.* Inilah sumber keluhan beban: tugas tambahan di luar proyek.
  - *Dosen juga melihatnya.* Hanya #pc(l.align.at(3).ya) dosen menjawab bahwa tugas mata kuliahnya bagian dari hasil kerja proyek.
  - *Informasi bobot nilai belum sampai.* #int(calc.round(l.explain_start.ya * l.n / 100)) dari #l.n dosen mengatakan sudah menjelaskan kaitan mata kuliah di awal semester. Namun #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mahasiswa menyebut bobot tidak disampaikan.
]

#sec-keselarasan-matkul("all")

#apa-artinya[
  - *Tidak ada satu mata kuliah yang menentukan.* Selisih antar mata kuliah di kelas yang sama besar. PBL menyatukan tugas banyak mata kuliah menjadi satu studi kasus besar. Karena itu, yang membedakan adalah cara tiap mata kuliah merancang tugas dan rubriknya.
  - *Latihan umum paling sering muncul di mata kuliah dengan CPMK sendiri.* Pada tabel di atas, Basis Data Lanjut dan Sistem Informasi Manajemen paling banyak memberi latihan umum sebagai tugas utama. Hasil kerja mata kuliah itu perlu dipetakan ke milestone.
]

#rekom-box(..rekom-items("keselarasan", "all"))

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa menilai beban sudah sesuai.],
    [Dosen menilai beban mereka sendiri wajar: hanya *#pc(l.workload_heavy_pct)* menilainya berat.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* mahasiswa menilai beban berat atau sangat berat.],
    [*#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban di luar proyek.],
    [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang menilai beban berat, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
  ),
)

#sec-workload("all")

#apa-artinya[
  - *Beban terasa dari jumlah semua tugas.* Dosen hanya melihat satu mata kuliah, sedangkan mahasiswa menanggung semuanya sekaligus ("seakan-akan ada tiga PBL").
  - *Paling berat di SIB Semester 3.* #pc(m.sem_stats.at(2).berat) menilai beban berat.
  - *Beban paling memengaruhi kepuasan.* Di antara semua hal yang diperiksa, beban paling kuat hubungannya dengan kepuasan (bagian 11).
]

#rekom-box(..rekom-items("beban", "all"))

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen saling mengetahui topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [Informasi dari koordinator jelas dan tepat waktu (*#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5).],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus bertanya ke dosen siapa.],
  ),
  buruk: (
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar mata kuliah konsisten, dan *#pc(m.coord.at(3).pct_oa)* mengalami tenggat yang bertabrakan.],
    [Hanya *#pc(l.coord_yn.at(2).ya)* dosen punya kesepakatan peran. *#pc(l.coord_lk.at(1).pct_never)* jarang atau tidak pernah menyelaraskan rubrik.],
    [Hanya *#l.meeting.items.at(0).count dari #l.n* dosen selalu hadir di rapat koordinasi.],
    [Komunikasi antar dosen dinilai *#fmt(l.ops_extra.at(0).mean, d: 2)* dari 5, yang paling rendah di antara butir pelaksanaan.],
  ),
)

#sec-coord("all")

#apa-artinya[
  - *Dua pihak melihat masalah yang sama.* Mahasiswa merasakan akibatnya (arahan tidak konsisten, tenggat bertabrakan). Dosen mengakui sebabnya (tidak ada kesepakatan peran, jarang menyelaraskan).
  - *Penyebabnya ada pada cara kerja.* Dosen menyebut beban mengajar dan administrasi (#pick(l.barriers, "Beban mengajar dan administrasi lain").count dari #l.n) serta tidak ada jadwal rapat rutin (#pick(l.barriers, "Tidak ada jadwal rapat rutin").count).
  - *Grup WhatsApp perlu aturan pemakaian yang jelas.* #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup, dan dosen menilai efektivitasnya #fmt(l.ops_extra.at(1).mean, d: 2) dari 5.
  - *Di SIB, mahasiswa dan dosen sepakat.* Keduanya menilai keselarasan tugas dan rubrik rendah (bagian 15).
]

#rekom-box(..rekom-items("koordinasi", "all"))

= Hal yang Berhubungan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang tahu harus bertanya ke dosen siapa lebih puas: *#fmt(grp(kontak, "Ya").puas, d: 2)* berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2).],
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP tidak menentukan kepuasan (hubungannya hanya #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)* dan ingin melanjutkan *#fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2)*, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2) dan #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).],
    [Fasilitas paling erat hubungannya dengan kepuasan (*#fmt(dr.corr.at(0).r_puas, d: 2)*), tetapi skornya paling rendah.],
    [Rubrik jelas (*#fmt(dr.corr.at(1).r_puas, d: 2)*) dan penilaian adil (*#fmt(dr.corr.at(2).r_puas, d: 2)*) sangat erat hubungannya dengan kepuasan, tetapi hanya #pc(m.ops.at(5).pct_agree) dan #pc(m.ops.at(6).pct_agree) yang setuju.],
  ),
)

#sec-faktor("all")

#apa-artinya[
  - *Urutan prioritas menurut data:* beban, kejelasan dan keadilan penilaian, fasilitas, lalu kejelasan dosen rujukan.
  - *Ini hubungan, belum tentu sebab-akibat.* Polanya cukup konsisten untuk dijadikan dasar urutan rekomendasi.
]

= Hal Baik dan yang Perlu Diperbaiki

#baik-buruk(
  baik: (
    [Pengalaman dan keterampilan baru: *#pc(best("Pengalaman dan keterampilan baru yang saya peroleh").pct)*.],
    [SOP dan template membantu: *#pc(best("SOP dan template laporan membantu").pct)*; kerja sama tim: *#pc(best("Kerja sama tim").pct)*.],
    [Bimbingan dosen: *#pc(best("Bimbingan dosen").pct)*; alur milestone jelas: *#pc(best("Alur dan target milestone jelas").pct)*.],
  ),
  buruk: (
    [Waktu dan beban kerja: *#pc(imp("Waktu dan beban kerja").pct)*.],
    [Kontribusi anggota tidak seimbang: *#pc(imp("Kontribusi anggota tim tidak seimbang").pct)*.],
    [Arahan dosen tidak terkoordinasi: *#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct)*; koordinasi tim: *#pc(imp("Koordinasi tim").pct)*.],
  ),
)

#sec-goodbad("all")

== Hal yang baik sekaligus bermasalah

#sec-duasisi("all")

#apa-artinya[
  - *SOP dan template punya dua sisi.* Banyak yang menghargainya (#pc(m.dua_sisi.at(0).baik)), tetapi #pc(m.dua_sisi.at(0).masalah) menganggap kejelasan dan waktu penyampaiannya bermasalah.
  - *Kerja sama tim juga punya dua sisi.* Banyak yang menikmatinya (#pc(m.dua_sisi.at(5).baik)), tetapi #pc(m.dua_sisi.at(5).masalah) mengeluhkan pembagian kerja yang belum merata.
  - *Fasilitas lebih banyak dipandang masalah.* Hanya #pc(m.dua_sisi.at(6).baik) menyebutnya baik, sedangkan #pc(m.dua_sisi.at(6).masalah) menyebutnya bermasalah.
  - *Bimbingan dan umpan balik dosen adalah kekuatan.* #pc(m.dua_sisi.at(2).baik) menyebutnya baik, hanya #pc(m.dua_sisi.at(2).masalah) menyebutnya bermasalah.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").n komentar* menyebut hal baik yang ingin dipertahankan: manfaat PBL, konsultasi dengan dosen, dan template.],
    [*#tema.membaik.n komentar* SIB Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada semester sebelumnya.],
    [Banyak komentar kritis ditutup dengan harapan PBL dipertahankan dan diperbaiki.],
  ),
  buruk: (
    [*#th("beban").n komentar* tentang tugas di luar proyek dan tenggat (TI #th("beban").ti, SIB #th("beban").sib).],
    [*#th("koordinasi").n komentar* tentang koordinasi antar dosen (TI #th("koordinasi").ti, SIB #th("koordinasi").sib).],
    [*#th("tim").n komentar* tentang kontribusi tim, *#th("kejelasan").n* tentang kejelasan template dan alur, dan *#th("fasilitas").n* tentang fasilitas (semuanya SIB).],
  ),
)

#sec-komentar("all", lead: [Di kolom saran, mahasiswa menjelaskan *mengapa* mereka menjawab seperti itu. Semua komentar mahasiswa TI dan SIB dibaca dan dikelompokkan. Bagian ini menunjukkan isi tiap tema, perbedaan TI dan SIB, kaitannya dengan angka survei, dan artinya.])

#rekom-box(..rekom-items("komentar", "all"))

= Analisis Komentar Bebas Dosen

#baik-buruk(
  baik: (
    [*#tema-dosen.penulis.at(if "all" == "all" { "n" } else { "all" }) dari #d.at("all").dosen.n dosen* menulis usulan pada pertanyaan terbuka. Sebagian besar usulan sejalan dengan jawaban pilihan ganda dosen.],
    [Dosen sendiri meminta panduan tertulis dan koordinasi sejak awal semester (#td("panduan", "all") dosen).],
    [Ada usulan memberi penghargaan kepada dosen pendamping dan produk PBL terbaik (#td("apresiasi", "all") dosen), serta usulan tempat bersama untuk produk dan progres (#td("wadah", "all") dosen).],
  ),
  buruk: (
    [*#td("beban", "all") dosen* menyinggung beban dan pemerataan dosen pengampu, sejalan dengan hambatan beban mengajar dan administrasi.],
    [*#td("keselarasan", "all") dosen* menyoroti keselarasan mata kuliah dengan PBL, termasuk belum adanya mata kuliah acuan penilaian PBL di SIB.],
    [Hanya sebagian kecil dosen menulis usulan, sehingga pendapat dosen lain belum tercatat.],
  ),
)

#sec-komentar-dosen("all")

#rekom-box(..rekom-items("komentar-dosen", "all"))

= Beda Penilaian Mahasiswa dan Dosen

#baik-buruk(
  baik: (
    [Selisih terkecil ada pada keterampilan teknis (*#sgn(A.gap.at(8).gap)*): dosen dan mahasiswa sama-sama menilai tinggi.],
    [Di SIB, rubrik (*#sgn(SIB.gap.at(5).gap)*) dan keselarasan tugas (*#sgn(SIB.gap.at(4).gap)*) dinilai sama oleh dosen dan mahasiswa, sehingga masalahnya jelas.],
  ),
  buruk: (
    [Dosen menilai lebih tinggi pada semua *#A.gap.len() butir* yang bisa dibandingkan.],
    [Selisih terbesar: keadilan penilaian (*#sgn(A.gap.at(6).gap)*) dan keinginan melanjutkan PBL (*#sgn(A.gap.at(12).gap)*).],
  ),
)

Enam selisih terbesar:

#table(
  columns: (1fr, auto, auto, auto), align: (left, center, center, center),
  table.header[Butir][Rerata mahasiswa][Rerata dosen][Selisih],
  ..for g in gap-top { (g.label, fmt(g.mhs_mean, d: 2), fmt(g.dosen_mean, d: 2), sgn(g.gap)) },
)

#apa-artinya[
  - *Ada tiga kemungkinan penyebab.* Pertama, dosen menilai dari rancangan buatan sendiri, sedangkan mahasiswa dari pengalaman di semua mata kuliah. Kedua, dosen tidak melihat beban yang menumpuk. Ketiga, informasi alur belum sampai ke mahasiswa.
  - *Tidak ada pihak yang keliru.* Keduanya menjawab jujur dari posisi yang berbeda. Ketiga kemungkinan di atas perlu dibahas bersama dosen pengampu.
  - *Kalau keduanya sepakat, itu tanda paling kuat bahwa masalahnya nyata.* Itu yang terjadi pada rubrik dan keselarasan tugas di SIB.
]

#rekom-box(..rekom-items("gap", "all"))

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi diurutkan menurut jumlah responden yang menyebut masalahnya dan seberapa kuat hubungan masalah itu dengan kepuasan.

#keputusan()

#sec-rekom-kartu(rekom-cards("all"))

== Rencana tindak lanjut

#sec-rekom-tabel(rekom-rows("all"))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
