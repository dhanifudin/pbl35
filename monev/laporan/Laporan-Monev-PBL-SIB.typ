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

#show: report.with("Program Studi Sarjana Terapan Sistem Informasi Bisnis", kaprodi-sib)

= Ringkasan Eksekutif

Survei monev PBL di Program Studi Sarjana Terapan Sistem Informasi Bisnis diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa Semester 3 dan 5) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen). Berikut ringkasan hal yang baik, hal yang bermasalah, dan langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa SIB", sub: "target 70%", color: accent),
  tile(pc(m.ben.at(4).pct_agree), "Mahasiswa setuju PBL dilanjutkan", color: accent),
  tile(pc(m.coord.at(1).ya), "Mahasiswa menilai arahan antar dosen konsisten", color: accent),
  tile(pc(l.coord_yn.at(2).ya), "Dosen mengatakan sudah ada kesepakatan peran", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis, dan *#pc(m.ben.at(2).pct_agree)* setuju PBL meningkatkan kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab dalam kurang dari sehari.],
    [Respons Semester 5 mencapai *#pc(m.response.sems.at(1).rate, d: 1)*, dan *#pc(l.rate, d: 1)* dosen SIB mengisi survei.],
    [*#tema.membaik.n komentar* Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada sebelumnya.],
  ),
  buruk: (
    [*#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct)* memilih arahan dosen yang tidak terkoordinasi sebagai masalah, dan hanya *#pc(m.coord.at(1).ya)* menilai arahan konsisten.],
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)* (#peran-n dari #l.n).],
    [Dukungan untuk melanjutkan PBL paling rendah: *#pc(m.ben.at(4).pct_agree)* (rerata #fmt(m.ben.at(4).mean, d: 2)).],
    [Rubrik (*#fmt(m.ops.at(5).mean, d: 2)*) dan keselarasan tugas (*#fmt(m.ops.at(4).mean, d: 2)*) lemah, dan dosen menilainya sama rendah.],
    [*#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct)* memilih kejelasan SOP dan rubrik sebagai masalah, dan *#tema.sib_info.n komentar* mengatakan informasi SIB datang belakangan.],
    [*#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)* memilih fasilitas sebagai masalah; beban berat di Semester 3 *#pc(s3.berat)*; respons Semester 3 hanya *#pc(m.response.sems.at(0).rate, d: 1)*.],
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
    [Semester 5: *#pc(m.response.sems.at(1).rate, d: 1)* (#m.response.sems.at(1).n dari #m.response.sems.at(1).roster).],
    [Dosen SIB: *#pc(l.rate, d: 1)* (#l.n dari #l.roster).],
    [Empat kelas yang dipantau langsung: *#pc(mo.enf.rate, d: 1)*.],
  ),
  buruk: (
    [Semester 3 hanya *#pc(m.response.sems.at(0).rate, d: 1)* (#m.response.sems.at(0).n dari #m.response.sems.at(0).roster).],
    [*#m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas* SIB tidak punya responden.],
    [#mo.oth.n_classes kelas tanpa pemantauan: hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("sib", lead: [Target respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menunjukkan 70%. Kelas Semester 5 berlabel SIB-3A dan seterusnya, sedangkan kelas Semester 3 berlabel SIB-2A dan seterusnya.])

#sec-kelas("sib")

== Kelas yang dipantau dan kelas tanpa pemantauan

Grup WhatsApp adalah saluran komunikasi wajib, dan survei diumumkan di sana. Meski begitu, respons tetap rendah. Di SIB, Koordinator PBL TI mengampu mata kuliah di empat kelas Semester 5 (SIB-3A sampai SIB-3D). Di kelas-kelas itu pengisian diingatkan dan dipantau langsung. Di kelas lain, pengisian belum dipantau secara khusus, jadi hanya bergantung pada pengumuman di grup.

#sec-keterwakilan("sib")

#apa-artinya[
  - *Empat kelas yang dipantau mencapai #pc(mo.enf.rate, d: 1).* #mo.oth.n_classes kelas lain, termasuk seluruh Semester 3, hanya #pc(mo.oth.rate, d: 1). Selisih ini berasal dari tindak lanjut di kelas, bukan dari minat.
  - *Dua beda jawaban layak dicatat.* Di kelas yang dipantau, arahan dosen yang tidak terkoordinasi lebih menonjol (#pc(pick(mo.enf.stats.top, "Arahan dan tugas antar dosen tidak terkoordinasi").pct) berbanding #pc(pick(mo.oth.stats.top, "Arahan dan tugas antar dosen tidak terkoordinasi").pct)). Di kelas lain, beban berat lebih sering dipilih (#pc(mo.oth.stats.berat) berbanding #pc(mo.enf.stats.berat)), mungkin karena kelas lain didominasi Semester 3.
  - *Jawaban umumnya serupa.* Kepuasan #fmt(mo.enf.stats.puas, d: 2) dan #fmt(mo.oth.stats.puas, d: 2).
  - *Semester 3 kurang terwakili.* Kelompok kelas lain hanya punya #mo.oth.n responden, jadi masalah khusus Semester 3 mungkin belum terlihat.
]

#rekom-box(..rekom-items("respons", "sib"))

= Ringkasan per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): skor *#fmt(m.aspek.at(0).mhs_mean, d: 2)*; hanya *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): skor *#fmt(m.aspek.at(2).mhs_mean, d: 2)*; *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek B (integrasi antar mata kuliah): *#pc(m.aspek.at(1).problem_pct)* memilih masalah, termasuk arahan dosen yang tidak terkoordinasi.],
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih paling sedikit satu masalah.],
    [Di aspek B, dosen (*#fmt(m.aspek.at(1).dosen_mean, d: 2)*) dan mahasiswa (*#fmt(m.aspek.at(1).mhs_mean, d: 2)*) sama-sama menilai rendah.],
  ),
)

#sec-aspek("sib")

#apa-artinya[
  - *Kalau mahasiswa dan dosen sama-sama menilai rendah, masalahnya hampir pasti nyata.* Hanya aspek B yang dinilai hampir sama oleh keduanya. Di aspek lain, dosen menilai jauh lebih tinggi.
  - *Aspek D banyak dipilih,* terutama beban kerja dan fasilitas.
]

= Penilaian Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kerja sama *#fmt(m.ben.at(1).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju.],
    [Dosen SIB menilai PBL layak dilanjutkan (*#fmt(l.ben.at(4).mean, d: 2)*).],
  ),
  buruk: (
    [Kepuasan *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)*); melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*), lebih rendah daripada TI.],
    [Fasilitas paling rendah: *#fmt(m.ops.at(7).mean, d: 2)*.],
    [Selisih dosen dan mahasiswa terbesar ada pada keadilan penilaian (*#sgn(S.gap.at(6).gap)*) dan keinginan melanjutkan PBL (*#sgn(S.gap.at(12).gap)*).],
  ),
)

#sec-opinion("sib")

#apa-artinya[
  - *Keraguan mahasiswa tentang keadilan perlu dijawab dengan transparansi nilai.* Dosen menilai penilaian sudah adil (#fmt(l.ops.at(6).mean, d: 2)), mahasiswa lebih ragu (#fmt(m.ops.at(6).mean, d: 2)).
  - *Rubrik dan keselarasan tugas adalah pekerjaan rumah bersama.* Selisihnya hampir nol (rubrik #fmt(m.ops.at(5).mean, d: 2) dan #fmt(l.ops.at(5).mean, d: 2); keselarasan tugas #fmt(m.ops.at(4).mean, d: 2) dan #fmt(l.ops.at(4).mean, d: 2)).
]

== Perbandingan per kelompok semester

#sec-semester("sib")

#apa-artinya[
  - *Semester 3 sedikit lebih rendah* (#fmt(s3.ops_mean, d: 2) berbanding #fmt(s5.ops_mean, d: 2)) dan *bebannya jauh lebih berat* (#pc(s3.berat) berbanding #pc(s5.berat)).
  - *Responden Semester 3 hanya #s3.n orang,* jadi perlu dikonfirmasi.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa SIB memilih definisi PBL yang benar.],
    [Hanya *#pc(m.k3.items.at(0).pct)* mahasiswa SIB belum pernah mengikuti PBL, jauh lebih sedikit daripada TI.],
  ),
  buruk: (
    [Hanya *#pc(l.k2_correct)* dosen SIB memilih tindakan yang sesuai prinsip PBL; *#int(calc.round((100 - l.k2_correct) * l.n / 100)) dari #l.n* memilih langsung memberi solusi.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen SIB belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("sib")

#apa-artinya[
  - *Konsepnya dipahami, kebiasaan membimbingnya belum.* Kesenjangan ada pada cara dosen membimbing tim yang tertinggal.
  - *Hampir semua dosen SIB yang menjawab sudah berpengalaman* (#l.by_experience.at(0).n orang), jadi pendampingan perlu menyasar kebiasaan dosen berpengalaman.
]

#rekom-box(..rekom-items("pemahaman", "sib"))

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa SIB mengatakan dosen menjawab dalam kurang dari sehari.],
    [Kedua pihak memulai konsultasi pada *#pc(pick(m.consult_init.items, "Keduanya").pct)* tim.],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [*#th("bimbingan").sib komentar* SIB menyebut dosen sulit dihubungi atau jarang hadir.],
  ),
)

#sec-konsultasi("sib")

#apa-artinya[
  - *Jumlah konsultasi tidak menentukan kepuasan.* Yang pernah berkonsultasi puas #fmt(grp(konsul, "Pernah").puas, d: 2), yang belum #fmt(grp(konsul, "Belum pernah").puas, d: 2). Tim biasanya berkonsultasi saat ada kendala.
  - *Kehadiran dosen di review berbeda antar mata kuliah* (bagian 13).
]

#rekom-box(..rekom-items("bimbingan", "sib"))

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.type.at(0).pct)* tugas utama berupa hasil kerja proyek, lebih tinggi daripada TI.],
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
  - *Dokumennya selaras, tugasnya baru setengah.*
  - *Ini sejalan dengan lemahnya rubrik dan keselarasan tugas,* yang dinilai sama rendah oleh mahasiswa dan dosen (bagian 3 dan 4).
]

#sec-keselarasan-matkul("sib")

#apa-artinya[
  - *Tidak ada satu mata kuliah yang menjadi penentu.* Hasilnya berbeda jauh antar mata kuliah di kelas yang sama. PBL menyatukan tugas banyak mata kuliah menjadi satu studi kasus besar. Karena itu, yang membedakan adalah cara tiap mata kuliah menyusun tugas dan rubriknya.
  - *Latihan umum paling sering muncul di mata kuliah yang punya CPMK sendiri.* Pada tabel di atas, mata kuliah seperti Basis Data Lanjut dan Sistem Informasi Manajemen paling sering memberi latihan umum sebagai tugas utama. Hasil kerjanya perlu dipetakan ke milestone.
]

#rekom-box(..rekom-items("keselarasan", "sib"))

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa SIB menilai beban sudah sesuai.],
    [Semester 5 lebih ringan: beban berat *#pc(s5.berat)*.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* menilai beban berat; di Semester 3, *#pc(s3.berat)*.],
    [*#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban.],
    [Dosen SIB juga merasa beban mengampu berat: *#pc(l.workload_heavy_pct)*.],
  ),
)

#sec-workload("sib")

#apa-artinya[
  - *Beban berat sangat menurunkan kepuasan.* Puas #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2); melanjutkan PBL #fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).
  - *Jangan menambah beban dosen.* Karena dosen SIB juga merasa terbebani, gabungkan tugas mahasiswa dengan hasil kerja milestone, bukan menambah tugas.
]

#rekom-box(..rekom-items("beban", "sib"))

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen SIB tahu topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus bertanya ke dosen siapa.],
  ),
  buruk: (
    [Kesepakatan peran dosen hanya *#pc(l.coord_yn.at(2).ya)*, dan dosen rujukan yang jelas hanya *#pc(l.coord_yn.at(3).ya)*.],
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan konsisten.],
    [*#pc(l.coord_lk.at(2).pct_never)* dosen jarang atau tidak pernah berbagi progres tim, dan *#l.meeting.items.at(2).count dari #l.n* tidak pernah hadir di rapat koordinasi.],
    [Komunikasi antar dosen dinilai *#fmt(l.ops_extra.at(0).mean, d: 2)* dari 5.],
  ),
)

#sec-coord("sib")

#apa-artinya[
  - *Mahasiswa yang tahu harus bertanya ke dosen siapa jauh lebih puas* (#fmt(grp(kontak, "Ya").puas, d: 2) berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)). Ini selisih kepuasan terbesar di SIB, sedikit di atas selisih akibat beban (#fmt(grp(beban, "Ringan atau sesuai").puas - grp(beban, "Berat atau sangat berat").puas, d: 2)).
  - *Koordinasi di SIB lebih lemah daripada di TI* pada pembagian peran dan kejelasan dosen rujukan.
]

#rekom-box(..rekom-items("koordinasi", "sib"))

= Hal yang Berhubungan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang tahu harus bertanya ke dosen siapa: puas *#fmt(grp(kontak, "Ya").puas, d: 2)* (berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2)).],
    [Kelengkapan SOP tidak menentukan kepuasan (hubungan #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)* (berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2)).],
    [Fasilitas paling berhubungan dengan kepuasan (*#fmt(dr.corr.at(0).r_puas, d: 2)*), tetapi skornya paling rendah.],
    [Bimbingan memadai (*#fmt(dr.corr.at(1).r_puas, d: 2)*) dan jadwal jelas (*#fmt(dr.corr.at(2).r_puas, d: 2)*) berhubungan kuat.],
  ),
)

#sec-faktor("sib")

#apa-artinya[
  - *Satu temuan perlu dibaca hati-hati.* Yang menilai arahan konsisten lebih puas (#fmt(grp(konsis, "Ya").puas, d: 2)) tetapi tidak lebih ingin melanjutkan (#fmt(grp(konsis, "Ya").lanjut, d: 2) berbanding #fmt(grp(konsis, "Sebagian atau tidak").lanjut, d: 2)), dan kelompok yang menjawab "ya" kecil (#grp(konsis, "Ya").n orang).
  - *Semua angka ini hubungan, belum tentu sebab-akibat.*
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
  - *SOP dan template punya dua sisi di SIB.* #pc(m.dua_sisi.at(0).baik) menyebutnya baik, tetapi #pc(m.dua_sisi.at(0).masalah) memilih kejelasan ketentuan sebagai masalah (di TI hanya #pc(d.ti.mhs.dua_sisi.at(0).masalah)). Yang belum jelas ketentuan khusus SIB, terutama rubrik (#pc(m.dua_sisi.at(1).baik) baik, #pc(m.dua_sisi.at(1).masalah) bermasalah).
  - *Fasilitas hanya masalah.* Hanya #pc(m.dua_sisi.at(6).baik) menyebutnya baik, sedangkan #pc(m.dua_sisi.at(6).masalah) menyebutnya bermasalah.
  - *Bimbingan dan umpan balik menjadi keunggulan.* #pc(m.dua_sisi.at(2).baik) menyebutnya baik, hanya #pc(m.dua_sisi.at(2).masalah) menyebutnya bermasalah.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").sib komentar SIB* menyebut hal baik: manfaat PBL, template, dan konsultasi dengan dosen.],
    [*#tema.membaik.n komentar* Semester 5 mengatakan semester ini lebih rapi daripada sebelumnya.],
  ),
  buruk: (
    [*#th("koordinasi").sib komentar* tentang koordinasi antar dosen, paling banyak di SIB (TI #th("koordinasi").ti).],
    [*#th("kejelasan").sib komentar* tentang kejelasan alur dan template; *#tema.sib_info.n* mengatakan informasi atau template SIB datang belakangan.],
    [*#th("beban").sib komentar* tentang beban, *#th("nilai").sib* tentang transparansi penilaian, dan *#th("fasilitas").sib* tentang fasilitas (semua komentar fasilitas datang dari SIB).],
  ),
)

#sec-komentar("sib", lead: [Mahasiswa SIB mengisi #tema.substantive_sib komentar bermakna, lebih banyak daripada TI dan sebagian besar dari Semester 5. Komentar dikelompokkan menurut tema, dibandingkan dengan TI, dikaitkan dengan angka survei, lalu dijelaskan artinya.])

#apa-artinya[
  - *Tiga hal khas SIB.* #tema.sib_info.n komentar menyebut informasi, template, atau jadwal SIB datang belakangan atau mengikuti TI. Semua komentar fasilitas (#th("fasilitas").n) datang dari SIB. Ada juga komentar tentang identitas SIB: penilaian terlalu menekankan produk dan kode, padahal kekuatan SIB adalah analisis kebutuhan dan manajemen proyek.
  - *Perbaikan mulai terasa.* #tema.membaik.n komentar Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada sebelumnya.
]

#rekom-box(..rekom-items("komentar", "sib"))

= Analisis Komentar Bebas Dosen

#baik-buruk(
  baik: (
    [*#tema-dosen.penulis.at(if "sib" == "all" { "n" } else { "sib" }) dari #d.at("sib").dosen.n dosen* menulis usulan pada pertanyaan terbuka. Sebagian besar usulan sejalan dengan jawaban pilihan ganda dosen.],
    [Dosen sendiri meminta panduan tertulis dan koordinasi sejak awal semester (#td("panduan", "sib") dosen).],
    [Ada usulan memberi penghargaan kepada dosen pendamping dan produk PBL terbaik (#td("apresiasi", "sib") dosen), serta usulan wadah bersama untuk produk dan progres (#td("wadah", "sib") dosen).],
  ),
  buruk: (
    [*#td("beban", "sib") dosen* menyinggung beban dan pemerataan dosen pengampu, sejalan dengan hambatan beban mengajar dan administrasi.],
    [*#td("keselarasan", "sib") dosen* menyoroti keselarasan mata kuliah dengan PBL, termasuk belum adanya mata kuliah acuan penilaian PBL di SIB.],
    [Hanya sebagian kecil dosen yang menulis usulan, jadi pendapat dosen lain belum tercatat.],
  ),
)

#sec-komentar-dosen("sib")

#rekom-box(..rekom-items("komentar-dosen", "sib"))

= Gambaran per Mata Kuliah

#baik-buruk(
  baik: (
    [Pemrograman Web Lanjut (Semester 5): kegiatan dosen *#pc(m.courses.at(3).acts_mean)*, hadir di semua review *#pc(m.courses.at(3).att_all)*.],
    [Pemrograman Web (Semester 3): kegiatan dosen *#pc(c3.acts_mean)*, keselarasan *#pc(c3.bc_ya_mean)*.],
  ),
  buruk: (
    [Basis Data Lanjut (Semester 3): kegiatan dosen *#pc(bdl.acts_mean)*, keselarasan *#pc(bdl.bc_ya_mean)*, penjelasan kaitan di awal semester *#pc(bdl.expl_ya)*.],
    [Di semua mata kuliah Semester 3, bobot PBL tidak disampaikan pada *#pc(c3.share_not_stated)* jawaban.],
    [Manajemen Proyek Sistem Informasi (Semester 5): hadir di semua review hanya *#pc(mpsi.att_all)*.],
  ),
)

#sec-courses("sib", lead: [Tabel berikut merangkum persepsi mahasiswa SIB per mata kuliah. Semester 5 dan Semester 3 tidak bisa dibandingkan langsung karena jumlah respondennya sangat berbeda.])

#apa-artinya[
  - *Manajemen Proyek Sistem Informasi justru inti kekhasan SIB,* tetapi kehadiran dosen di review paling rendah di Semester 5.
  - *Angka ini persepsi mahasiswa per mata kuliah,* bukan penilaian terhadap dosen. Bahas bersama dosen pengampu.
]

#rekom-box(
  (aksi: [Bahas gambaran per mata kuliah dengan dosen pengampu lewat grup WhatsApp atau satu pertemuan singkat, terutama Basis Data Lanjut Semester 3 dan kehadiran di review Manajemen Proyek Sistem Informasi.], waktu: w-ini, pj: "Kaprodi SIB dan Koordinator PBL TI"),
  (aksi: [Jadwalkan kehadiran dosen di review milestone sejak awal tiap milestone, dan jelaskan kaitan mata kuliah dengan proyek di pertemuan pertama.], waktu: w-setelah, pj: "Dosen pengampu SIB", indikator: [kehadiran di semua review minimal 80% di setiap mata kuliah]),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi diurutkan menurut berapa banyak mahasiswa yang menyebut masalahnya dan seberapa kuat hubungan masalah itu dengan kepuasan.

#keputusan()

#sec-rekom-kartu(rekom-cards("sib"))

== Rencana tindak lanjut

#sec-rekom-tabel(rekom-rows("sib"))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
