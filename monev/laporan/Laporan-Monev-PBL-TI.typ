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

#show: report.with("Program Studi Sarjana Terapan Teknik Informatika", kaprodi-ti)

= Ringkasan Eksekutif

Survei monev PBL di Program Studi Sarjana Terapan Teknik Informatika diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa Semester 3 dan 5) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen). Berikut ringkasan hal yang baik, hal yang bermasalah, dan langkah tindak lanjut menurut waktunya.

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

#tindak-lanjut-utama()

#catatan-struktur()

#pagebreak(weak: true)

= Cakupan Responden dan Seberapa Mewakili

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

#sec-coverage("ti", lead: [Target respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menunjukkan 70%.])

#sec-kelas("ti")

== Kelas yang dipantau dan kelas tanpa pemantauan

Grup WhatsApp adalah saluran komunikasi wajib, dan survei diumumkan di sana. Meski begitu, respons tetap rendah. Di TI, Koordinator PBL TI hanya mengampu kelas TI-2B pada semester PBL. Di kelas itu pengisian diingatkan dan dipantau langsung. Di kelas lain, pengisian belum dipantau secara khusus, jadi hanya bergantung pada pengumuman di grup.

#sec-keterwakilan("ti")

#apa-artinya[
  - *TI-2B mencapai #pc(mo.enf.rate, d: 1)*, kelas lain #pc(mo.oth.rate, d: 1). Selisih ini berasal dari tindak lanjut di kelas, bukan dari minat.
  - *Jawabannya serupa.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) dan #fmt(mo.oth.stats.ops_mean, d: 2); kepuasan #fmt(mo.enf.stats.puas, d: 2) dan #fmt(mo.oth.stats.puas, d: 2).
  - *Ada dua beda kecil.* Di TI-2B, kontribusi anggota lebih menonjol (#pc(mo.enf.stats.top.first().pct)); di kelas lain, waktu dan beban kerja (#pc(mo.oth.stats.top.first().pct)). Dengan #mo.enf.n responden dari satu kelas, ini bisa mencerminkan kelas itu saja, bukan pola program studi.
  - *Semester 5 TI paling sedikit terwakili.* Hanya #m.response.sems.at(1).n responden dari #m.response.sems.at(1).roster mahasiswa.
]

#rekom-box(..rekom-items("respons", "ti"))

= Ringkasan per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): skor *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): skor *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih paling sedikit satu masalah.],
    [Aspek B (integrasi antar mata kuliah): skor *#fmt(m.aspek.at(1).mhs_mean, d: 2)*; *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
  ),
)

#sec-aspek("ti")

#apa-artinya[
  - *Masalah di TI paling banyak ada di aspek D*, terutama kontribusi anggota dan beban kerja, lalu di aspek B.
  - *Dosen menilai lebih tinggi di semua aspek.* Selisihnya #fmt(calc.min(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) sampai #fmt(calc.max(..m.aspek.map(a => a.dosen_mean - a.mhs_mean)), d: 2) poin.
]

= Penilaian Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Mahasiswa yang sudah pernah ikut PBL lebih mendukung kelanjutannya: *#pc(pernah.cont_agree)*.],
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
  - *Semester 5 kurang puas* (#fmt(m.sem_stats.at(1).puas, d: 2) berbanding #fmt(m.sem_stats.at(0).puas, d: 2)), tetapi hanya #m.sem_stats.at(1).n responden, jadi baru gambaran awal.
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
  - *Dosen yang baru pertama kali mengampu terlalu sedikit untuk dilaporkan sendiri.* Dari #l.by_experience.at(0).n dosen berpengalaman, #pc(l.by_experience.at(0).k2_correct) memilih tindakan yang tepat. Pendampingan perlu menyasar kebiasaan membimbing dosen berpengalaman.
]

#rekom-box(..rekom-items("pemahaman", "ti"))

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa TI mengatakan dosen menjawab dalam kurang dari sehari.],
    [Kedua pihak memulai konsultasi pada *#pc(pick(m.consult_init.items, "Keduanya").pct)* tim.],
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

#rekom-box(..rekom-items("bimbingan", "ti"))

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

#sec-keselarasan-matkul("ti")

#apa-artinya[
  - *Tidak ada satu mata kuliah yang menjadi penentu.* Hasilnya berbeda jauh antar mata kuliah di kelas yang sama. PBL menyatukan tugas banyak mata kuliah menjadi satu studi kasus besar. Karena itu, yang membedakan adalah cara tiap mata kuliah menyusun tugas dan rubriknya.
  - *Latihan umum paling sering muncul di mata kuliah yang punya CPMK sendiri.* Pada tabel di atas, mata kuliah seperti Basis Data Lanjut dan Sistem Informasi Manajemen paling sering memberi latihan umum sebagai tugas utama. Hasil kerjanya perlu dipetakan ke milestone.
]

#rekom-box(..rekom-items("keselarasan", "ti"))

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
  - *Beban berat berhubungan kuat dengan kepuasan.* Yang menilai beban berat ingin melanjutkan PBL #fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2), berbanding #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).
  - *Beban terasa dari jumlah semua mata kuliah,* bukan dari satu mata kuliah ("seakan-akan ada tiga PBL").
]

#rekom-box(..rekom-items("beban", "ti"))

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
  - *Dosen TI menyebut sebabnya.* Tidak ada jadwal rapat rutin, dan hambatan utamanya beban mengajar serta administrasi. Komunikasi antar dosen dinilai #fmt(l.ops_extra.at(0).mean, d: 2) dari 5.
]

#rekom-box(..rekom-items("koordinasi", "ti"))

= Hal yang Berhubungan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP tidak menentukan kepuasan (hubungan #fmt(sop.r_puas, d: 2)).],
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
  - *Kelompoknya kecil* (#grp(beban, "Berat atau sangat berat").n berbanding #grp(beban, "Ringan atau sesuai").n responden pada perbandingan beban), jadi baru gambaran awal, bukan angka pasti.
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

#sec-komentar("ti", lead: [Mahasiswa TI mengisi #tema.substantive_ti komentar bermakna. Komentar dikelompokkan menurut tema, dibandingkan dengan SIB, dikaitkan dengan angka survei, lalu dijelaskan artinya.])

#rekom-box(..rekom-items("komentar", "ti"))

= Analisis Komentar Bebas Dosen

#baik-buruk(
  baik: (
    [*#tema-dosen.penulis.at(if "ti" == "all" { "n" } else { "ti" }) dari #d.at("ti").dosen.n dosen* menulis usulan pada pertanyaan terbuka. Sebagian besar usulan sejalan dengan jawaban pilihan ganda dosen.],
    [Dosen sendiri meminta panduan tertulis dan koordinasi sejak awal semester (#td("panduan", "ti") dosen).],
    [Ada usulan memberi penghargaan kepada dosen pendamping dan produk PBL terbaik (#td("apresiasi", "ti") dosen), serta usulan wadah bersama untuk produk dan progres (#td("wadah", "ti") dosen).],
  ),
  buruk: (
    [*#td("beban", "ti") dosen* menyinggung beban dan pemerataan dosen pengampu, sejalan dengan hambatan beban mengajar dan administrasi.],
    [*#td("keselarasan", "ti") dosen* menyoroti keselarasan mata kuliah dengan PBL, termasuk belum adanya mata kuliah acuan penilaian PBL di SIB.],
    [Hanya sebagian kecil dosen yang menulis usulan, jadi pendapat dosen lain belum tercatat.],
  ),
)

#sec-komentar-dosen("ti")

#rekom-box(..rekom-items("komentar-dosen", "ti"))

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
  - *Kegiatan dosen untuk proyek sangat berbeda antar mata kuliah,* lebih besar daripada antar semester.
  - *Angka ini persepsi mahasiswa.* Angkanya bisa mencerminkan sifat mata kuliah, bukan penilaian terhadap dosen. Bahas bersama dosen pengampu.
]

#rekom-box(
  (aksi: [Bahas gambaran per mata kuliah dengan dosen pengampu lewat grup WhatsApp atau satu pertemuan singkat, terutama Penjaminan Mutu Perangkat Lunak, untuk mencari penyebab dan cara memperbaikinya. Tujuannya bukan menilai individu.], waktu: w-ini, pj: "Koordinator PBL TI dan Kaprodi TI"),
  (aksi: [Tindak lanjuti hasil pembahasan itu pada milestone berikutnya.], waktu: w-setelah, pj: "Dosen pengampu mata kuliah terkait", indikator: [kegiatan dosen dan keselarasan materi minimal 50% pada survei berikutnya]),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi diurutkan menurut berapa banyak mahasiswa yang menyebut masalahnya dan seberapa kuat hubungan masalah itu dengan kepuasan.

#keputusan()

#sec-rekom-kartu(rekom-cards("ti"))

== Rencana tindak lanjut

#sec-rekom-tabel(rekom-rows("ti"))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
