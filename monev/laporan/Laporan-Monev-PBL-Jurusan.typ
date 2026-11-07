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

Survei monev PBL diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen) di Program Studi TI dan SIB, Semester 3 dan 5. Berikut ringkasan hal yang baik dan hal yang bermasalah, lalu langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa", sub: "target 70%", color: accent),
  tile(pc(m.ben.at(0).pct_agree), "Mahasiswa setuju PBL meningkatkan keterampilan teknis"),
  tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan pelaksanaan PBL", color: accent),
  tile(pc(m.coord.at(1).ya), "Mahasiswa menilai arahan antar dosen konsisten", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis, *#pc(m.ben.at(1).pct_agree)* kerja sama, dan *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu. Ini butir pelaksanaan dengan skor tertinggi (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab pertanyaan proyek dalam kurang dari sehari.],
    [*#pc(l.rate, d: 1)* dosen mengisi survei, dan dosen menilai pelaksanaan PBL *#fmt(l.ops_mean, d: 2)* (#l.ops_cat).],
    [Beberapa komentar SIB Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada semester sebelumnya (#tema.membaik.n komentar).],
  ),
  buruk: (
    [Hanya *#pc(m.ben.at(3).pct_agree)* mahasiswa puas, dan hanya *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
    [*#pc(m.workload_heavy_pct)* menilai beban berat, dan *#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban di luar proyek.],
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar dosen konsisten. Hanya *#pc(l.coord_yn.at(2).ya)* dosen mengatakan sudah ada kesepakatan peran.],
    [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota yang tidak seimbang sebagai masalah.],
    [Fasilitas mendapat skor terendah (*#fmt(m.ops.at(7).mean, d: 2)*), dan *#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)* memilihnya sebagai masalah.],
    [Respons mahasiswa hanya *#pc(m.response.rate, d: 1)*. Di *#mo.oth.n_classes kelas* tanpa pemantauan, responsnya hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Adakan rapat evaluasi dengan dosen pengampu. Umumkan ringkasan hasil kepada mahasiswa dan dosen. Tetapkan dosen rujukan (PIC) untuk tiap kelas. Minta dosen menyampaikan ulang bobot nilai dan ketentuan Milestone 2 di kelas. Jangan ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Adakan rapat koordinasi rutin dan tetapkan peran dosen secara tertulis. Susun kalender tenggat bersama. Cocokkan setiap tugas dengan hasil kerja (deliverable) milestone. Catat kontribusi tiap anggota tim. Kembalikan rubrik dengan umpan balik dalam tujuh hari.],
  chip(w-depan, primary-mid), [Berikan satu paket informasi di minggu pertama untuk TI dan SIB. Tetapkan aturan pembentukan tim. Siapkan server deployment dan perbaiki jaringan. Adakan penyegaran PBL untuk dosen dan orientasi untuk mahasiswa. Pantau pengisian survei di setiap kelas.],
)

#pagebreak(weak: true)

= Latar Belakang dan Cara Membaca

Survei dilakukan menjelang Milestone 2 lewat dua Google Form: satu untuk mahasiswa (dwibahasa) dan satu untuk dosen. Pertanyaannya mencakup pemahaman PBL, kegiatan di tiap mata kuliah, koordinasi, penilaian pelaksanaan dan manfaat PBL (skala 1–5), pilihan hal baik dan hal bermasalah, serta saran bebas.

Hasil dibaca menurut empat aspek monev: (A) pelaksanaan PBL, (B) integrasi antar mata kuliah, (C) penilaian dan umpan balik, serta (D) kolaborasi, beban, dan dukungan. Survei tidak menanyakan status proyek tiap tim karena datanya sudah ada di Laporan Kemajuan. Analisis komentar bebas hanya mencakup komentar mahasiswa TI dan SIB.

= Cakupan Responden dan Keterwakilan

== Tingkat respons

#baik-buruk(
  baik: (
    [Dosen: *#pc(l.rate, d: 1)* (#l.n dari #l.roster), mendekati target.],
    [Di *#mo.enf.n_classes kelas yang dipantau langsung*, respons mencapai *#pc(mo.enf.rate, d: 1)*.],
  ),
  buruk: (
    [Mahasiswa: hanya *#pc(m.response.rate, d: 1)* (#m.n dari #m.response.roster), jauh di bawah target 70%.],
    [*#m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas* tidak punya responden sama sekali.],
    [#mo.oth.n_classes kelas tanpa pemantauan: hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("all", lead: [Target respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menandai 70%.])

== Kelas yang dipantau dan kelas tanpa pemantauan

Grup WhatsApp adalah saluran komunikasi wajib, dan survei diumumkan serta diingatkan di sana. Respons tetap rendah. Pengecualiannya kelas yang diampu Koordinator PBL TI: di sana pengisian juga diingatkan dan dipantau langsung. Di kelas lain, dosen pengampu hanya membagikan tautan tanpa memantau.

#sec-keterwakilan("all")

#apa-artinya[
  - *Bedanya ada pada tindak lanjut di kelas, bukan pada minat mahasiswa.* Responsnya #pc(mo.enf.rate, d: 1) di kelas yang dipantau dan #pc(mo.oth.rate, d: 1) di kelas tanpa pemantauan.
  - *Pengumuman di grup WhatsApp tidak cukup.* Pada survei dosen, #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup tanpa menanggapi, #wa("Jarang membuka").count jarang membukanya, dan hanya #wa("Aktif menanggapi dan berbagi informasi").count yang aktif.
  - *Jawaban kedua kelompok hampir sama.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) dan #fmt(mo.oth.stats.ops_mean, d: 2), kepuasan #fmt(mo.enf.stats.puas, d: 2) dan #fmt(mo.oth.stats.puas, d: 2), beban berat #pc(mo.enf.stats.berat) dan #pc(mo.oth.stats.berat). Jadi temuan umum tidak bergantung pada kelas yang dipantau.
  - *Kelemahannya ada pada keterwakilan.* #mo.oth.n_classes kelas lain, terutama TI Semester 5, hanya diwakili sedikit mahasiswa, sehingga masalah khusus kelas itu bisa terlewat.
]

#rekom-box(
  (aksi: [Putuskan apakah formulir dibuka lagi selama satu pekan khusus untuk kelas dengan respons di bawah 30%.], waktu: w-ini, pj: "Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Pada survei berikutnya, minta setiap dosen pengampu mengingatkan dan memantau pengisian di kelasnya, seperti di lima kelas yang dipantau (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)). Isi survei dalam satu sesi 10 menit pada jam kuliah (lewat kode QR). DPA dan ketua kelas memastikan semua anggota mengisi.], waktu: w-depan, pj: "Kaprodi, dosen pengampu, DPA, ketua kelas", indikator: [respons minimal 70% di setiap kelas pada survei berikutnya]),
  (aksi: [Kirim jumlah respons tiap kelas ke grup WhatsApp pada hari ke-3 dan hari terakhir survei, dan sebut kelas yang masih tertinggal.], waktu: w-depan, pj: "Koordinator PBL TI"),
)

= Rangkuman per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): skor *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); hanya *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): skor *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek B (integrasi antar mata kuliah): skor terendah di antara A sampai C (*#fmt(m.aspek.at(1).mhs_mean, d: 2)*); *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih minimal satu masalah, paling banyak di antara semua aspek.],
  ),
)

#sec-aspek("all")

#apa-artinya[
  - *Alur PBL sudah berjalan.* Aspek pelaksanaan dan penilaian bernilai baik dan jarang dipilih sebagai masalah.
  - *Masalahnya ada di antara bagian-bagian PBL.* Integrasi antar mata kuliah (B) serta beban dan kolaborasi (D) paling bermasalah.
]

= Penilaian Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Manfaat dinilai tinggi: keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kerja sama *#fmt(m.ben.at(1).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Bimbingan dosen memadai: *#pc(m.ops.at(3).pct_agree)* setuju.],
  ),
  buruk: (
    [Kepuasan hanya *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)* setuju), dan keinginan melanjutkan PBL *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*).],
    [Fasilitas paling rendah (*#fmt(m.ops.at(7).mean, d: 2)*); keselarasan tugas antar mata kuliah *#fmt(m.ops.at(4).mean, d: 2)*.],
    [Dosen menilai lebih tinggi daripada mahasiswa pada semua butir (selisih sampai *#sgn(calc.max(..A.gap.map(g => g.gap)))*).],
  ),
)

#sec-opinion("all")

#apa-artinya[
  - *PBL bermanfaat, tetapi menjalaninya belum memuaskan.* Penyebabnya ada pada beban, koordinasi, dan fasilitas (bagian 9 sampai 11), bukan pada konsep PBL.
  - *Informasi yang jelas bagi dosen belum sampai ke mahasiswa.* Alur dan target milestone bernilai #fmt(l.ops.at(0).mean, d: 2) menurut dosen dan #fmt(m.ops.at(0).mean, d: 2) menurut mahasiswa.
  - *Ini bukan hanya masalah mahasiswa baru.* Rerata pelaksanaan #fmt(m.by_experience.at(0).ops_mean, d: 2) pada yang belum pernah dan #fmt(m.by_experience.at(1).ops_mean, d: 2) pada yang pernah mengikuti PBL, hampir sama.
]

== Perbandingan per kelompok semester

#sec-semester("all")

#apa-artinya[
  - *Skor hampir sama, bebannya berbeda.* Beban berat paling banyak di SIB Semester 3 (#pc(m.sem_stats.at(2).berat)), lalu TI Semester 5 (#pc(m.sem_stats.at(1).berat)). TI Semester 3 paling rendah (#pc(m.sem_stats.at(0).berat)).
  - *Hati-hati dengan kelompok kecil.* SIB Semester 3 dan TI Semester 5 hanya diwakili sedikit mahasiswa.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa memilih definisi PBL yang benar.],
    [Semua dosen yang baru pertama kali mengampu PBL (#l.by_experience.at(0).n orang) memilih tindakan yang tepat.],
  ),
  buruk: (
    [Hanya *#pc(l.k2_correct)* dosen memilih tindakan yang sesuai prinsip PBL; *#int(calc.round((100 - l.k2_correct) * l.n / 100)) dari #l.n* memilih langsung memberi solusi.],
    [*#pc(m.k3.items.at(0).pct)* mahasiswa belum pernah mengikuti PBL.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("all")

#apa-artinya[
  - *Konsepnya dipahami, kebiasaan membimbingnya belum.* Kesenjangan ada pada cara dosen membimbing tim yang tertinggal.
  - *Penyegaran perlu menyasar dosen berpengalaman.* Hanya #pc(l.by_experience.at(1).k2_correct) dosen berpengalaman memilih tindakan yang tepat, sedangkan dosen baru #pc(l.by_experience.at(0).k2_correct).
  - *Mahasiswa baru perlu orientasi.* Sebagian besar mahasiswa TI belum pernah mengikuti PBL.
]

#rekom-box(
  (aksi: [Jadwalkan sosialisasi PBL bagi dosen yang belum pernah mengikutinya.], waktu: w-setelah, pj: "Kaprodi dan Koordinator PBL TI"),
  (aksi: [Adakan penyegaran PBL sekitar 60 menit untuk semua dosen pengampu, dengan latihan menyusun pertanyaan pemandu. Pasangkan dosen baru dengan dosen berpengalaman.], waktu: w-depan, pj: "Koordinator PBL TI", indikator: [dosen memilih tindakan yang tepat minimal 90% pada survei berikutnya]),
  (aksi: [Adakan orientasi PBL di minggu pertama untuk mahasiswa yang belum pernah mengikuti PBL, dengan contoh laporan dan alur milestone.], waktu: w-depan, pj: "Dosen pengampu"),
)

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa mengatakan dosen menjawab dalam kurang dari sehari.],
    [Konsultasi biasanya dimulai oleh kedua pihak (*#pc(pick(m.consult_init.items, "Keduanya").pct)*).],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [Kesempatan konsultasi berbeda antar mata kuliah (#th("bimbingan").n komentar).],
  ),
)

#sec-konsultasi("all")

#apa-artinya[
  - *Bimbingan tersedia dan cepat.* Mahasiswa menilai dosen cepat menjawab.
  - *Jumlah konsultasi tidak menentukan kepuasan.* Yang pernah dan belum pernah berkonsultasi sama-sama puas, #fmt(grp(konsul, "Pernah").puas, d: 2) dan #fmt(grp(konsul, "Belum pernah").puas, d: 2).
  - *Tim biasanya berkonsultasi saat sedang kesulitan.* Yang belum pernah berkonsultasi justru sedikit lebih ingin melanjutkan PBL (#fmt(grp(konsul, "Belum pernah").lanjut, d: 2) berbanding #fmt(grp(konsul, "Pernah").lanjut, d: 2)).
]

#rekom-box(
  (aksi: [Minta dosen menyediakan sekitar 15 menit untuk meninjau proyek tiap tim pada pertemuan terdekat sebelum review Milestone 2.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Adakan sesi tinjau proyek untuk tiap tim di setiap milestone dan catat hasilnya di catatan bimbingan, supaya bimbingan tidak bergantung pada inisiatif mahasiswa.], waktu: w-setelah, pj: "Dosen pengampu dan Koordinator PBL TI", indikator: [tim yang belum pernah berkonsultasi di bawah 10% pada survei berikutnya]),
)

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
  - *Dokumennya selaras, tugasnya baru setengah.* Inilah sumber keluhan beban: tugas tambahan di luar proyek.
  - *Dosen juga melihatnya.* Hanya #pc(l.align.at(3).ya) dosen menjawab tugas mata kuliahnya bagian dari hasil kerja proyek.
  - *Informasi bobot nilai belum sampai.* #int(calc.round(l.explain_start.ya * l.n / 100)) dari #l.n dosen mengatakan sudah menjelaskan kaitan mata kuliah di awal semester, tetapi #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mahasiswa menyebut bobot tidak disampaikan.
]

#rekom-box(
  (aksi: [Minta dosen menyampaikan ulang bobot nilai PBL dan ketentuan Milestone 2 di kelas masing-masing.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Cocokkan setiap tugas dengan hasil kerja milestone dalam rapat koordinasi. Kurangi atau gabungkan tugas yang tidak terkait proyek.], waktu: w-setelah, pj: "Dosen pengampu, difasilitasi Koordinator PBL TI", indikator: [jawaban "tugas bagian dari proyek" naik dari #pc(m.pooled.bc.at(3).ya) menjadi minimal 70% pada survei berikutnya]),
  (aksi: [Tulis bobot nilai PBL di RPS dan umumkan di LMS pada awal semester.], waktu: w-depan, pj: "Dosen pengampu", indikator: [jawaban "bobot tidak disampaikan" di bawah 5%]),
)

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa menilai beban sudah sesuai.],
    [Dosen menilai bebannya sendiri wajar: hanya *#pc(l.workload_heavy_pct)* menilainya berat.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* mahasiswa menilai beban berat atau sangat berat.],
    [*#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban di luar proyek.],
    [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang menilai beban berat, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
  ),
)

#sec-workload("all")

#apa-artinya[
  - *Beban terasa dari jumlah semua tugas.* Dosen hanya melihat satu mata kuliah; mahasiswa merasakan semuanya sekaligus ("seakan-akan ada tiga PBL").
  - *Paling berat di SIB Semester 3.* #pc(m.sem_stats.at(2).berat) menilai beban berat.
  - *Beban paling berpengaruh pada kepuasan.* Dari semua hal yang diperiksa, beban paling kuat berhubungan dengan kepuasan (bagian 11).
]

#rekom-box(
  (aksi: [Minta dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Susun kalender tenggat bersama untuk semua mata kuliah PBL di tiap kelas sampai akhir semester, dalam rapat koordinasi.], waktu: w-setelah, pj: "Koordinator PBL TI dan dosen pengampu tiap kelas", indikator: [pilihan "tenggat antar mata kuliah bertabrakan" (sering atau selalu) turun dari #pc(m.coord.at(3).pct_oa)]),
  (aksi: [Jadikan tugas mata kuliah bagian dari hasil kerja milestone, dan tetapkan batas jumlah tugas di luar proyek untuk tiap mata kuliah.], waktu: w-depan, pj: "Dosen pengampu", indikator: [mahasiswa yang menilai beban berat di bawah 30%]),
)

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen saling tahu topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [Informasi dari koordinator jelas dan tepat waktu (*#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5).],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus bertanya ke dosen siapa.],
  ),
  buruk: (
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar mata kuliah konsisten, dan *#pc(m.coord.at(3).pct_oa)* mengalami tenggat yang bertabrakan.],
    [Hanya *#pc(l.coord_yn.at(2).ya)* dosen punya kesepakatan peran, dan *#pc(l.coord_lk.at(1).pct_never)* jarang atau tidak pernah menyelaraskan rubrik.],
    [Hanya *#l.meeting.items.at(0).count dari #l.n* dosen selalu hadir di rapat koordinasi.],
    [Komunikasi antar dosen dinilai *#fmt(l.ops_extra.at(0).mean, d: 2)* dari 5, paling rendah di antara butir pelaksanaan.],
  ),
)

#sec-coord("all")

#apa-artinya[
  - *Dua pihak melihat masalah yang sama.* Mahasiswa melihat akibatnya (arahan tidak konsisten, tenggat bertabrakan). Dosen mengakui sebabnya (tidak ada kesepakatan peran, jarang menyelaraskan).
  - *Penyebabnya ada pada cara kerja.* Dosen menyebut beban mengajar dan administrasi (#pick(l.barriers, "Beban mengajar dan administrasi lain").count dari #l.n) serta tidak adanya jadwal rapat rutin (#pick(l.barriers, "Tidak ada jadwal rapat rutin").count).
  - *Grup WhatsApp belum bisa menggantikan rapat.* #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup, dan dosen menilai efektivitasnya #fmt(l.ops_extra.at(1).mean, d: 2) dari 5.
  - *Di SIB, mahasiswa dan dosen sepakat.* Keduanya menilai keselarasan tugas dan rubrik rendah (bagian 14).
]

#rekom-box(
  (aksi: [Adakan satu sesi koordinasi dosen untuk menyamakan arahan Milestone 2, dan buat daftar sederhana dosen rujukan (PIC) tiap kelas yang diumumkan kepada mahasiswa.], waktu: w-ini, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Adakan rapat koordinasi rutin tiap program studi (dua mingguan, 30 menit) dengan agenda tetap: progres tim, tenggat bersama, dan keselarasan rubrik. Tetapkan peran dosen di tiap kelas secara tertulis.], waktu: w-setelah, pj: "Kaprodi dan dosen pengampu", indikator: [dosen yang selalu hadir naik dari #l.meeting.items.at(0).count orang menjadi minimal 80% dosen; kesepakatan peran naik dari #pc(l.coord_yn.at(2).ya) menjadi minimal 80%]),
  (aksi: [Pakai grup WhatsApp untuk laporan progres tim secara berkala dengan format singkat, dan catat keputusan penting dalam notulen rapat.], waktu: w-setelah, pj: "Koordinator PBL TI"),
)

= Hal yang Berhubungan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang tahu harus bertanya ke dosen siapa lebih puas: *#fmt(grp(kontak, "Ya").puas, d: 2)* berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2).],
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP tidak menentukan kepuasan (korelasi hanya #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)* dan ingin melanjutkan *#fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2)*, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2) dan #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).],
    [Fasilitas paling berhubungan dengan kepuasan (*#fmt(dr.corr.at(0).r_puas, d: 2)*), tetapi skornya paling rendah.],
    [Rubrik jelas (*#fmt(dr.corr.at(1).r_puas, d: 2)*) dan penilaian adil (*#fmt(dr.corr.at(2).r_puas, d: 2)*) sangat berhubungan dengan kepuasan, tetapi hanya #pc(m.ops.at(5).pct_agree) dan #pc(m.ops.at(6).pct_agree) yang setuju.],
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
  - *SOP dan template punya dua sisi.* Banyak yang menghargai keberadaannya (#pc(m.dua_sisi.at(0).baik)), tetapi #pc(m.dua_sisi.at(0).masalah) menganggap kejelasan dan waktu penyampaiannya bermasalah.
  - *Kerja sama tim juga punya dua sisi.* Banyak yang menikmatinya (#pc(m.dua_sisi.at(5).baik)), tetapi #pc(m.dua_sisi.at(5).masalah) mengeluhkan pembagian kerja yang belum merata.
  - *Fasilitas hanya masalah.* Hanya #pc(m.dua_sisi.at(6).baik) menyebutnya baik, sedangkan #pc(m.dua_sisi.at(6).masalah) menyebutnya bermasalah.
  - *Bimbingan dan umpan balik dosen adalah keunggulan.* #pc(m.dua_sisi.at(2).baik) menyebutnya baik, hanya #pc(m.dua_sisi.at(2).masalah) menyebutnya bermasalah.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").n komentar* menyebut hal baik yang ingin dipertahankan: manfaat PBL, konsultasi dengan dosen, dan template.],
    [*#tema.membaik.n komentar* SIB Semester 5 mengatakan pelaksanaan semester ini lebih rapi daripada semester sebelumnya.],
    [Banyak komentar kritis ditutup dengan harapan agar PBL dipertahankan dan diperbaiki.],
  ),
  buruk: (
    [*#th("beban").n komentar* tentang tugas di luar proyek dan tenggat (TI #th("beban").ti, SIB #th("beban").sib).],
    [*#th("koordinasi").n komentar* tentang koordinasi antar dosen (TI #th("koordinasi").ti, SIB #th("koordinasi").sib).],
    [*#th("tim").n komentar* tentang kontribusi tim, *#th("kejelasan").n* tentang kejelasan template dan alur, dan *#th("fasilitas").n* tentang fasilitas (semuanya SIB).],
  ),
)

#sec-komentar("all", lead: [Kolom saran adalah tempat mahasiswa menjelaskan *mengapa* mereka menjawab seperti itu. Semua komentar mahasiswa TI dan SIB dibaca dan dikelompokkan. Bagian ini menunjukkan isi tiap tema, perbedaan TI dan SIB, hubungannya dengan angka survei, dan artinya.])

#rekom-box(
  (aksi: [Sampaikan ringkasan hasil kepada mahasiswa TI dan SIB: komentar mereka sudah dibaca dan ini langkah yang akan diambil.], waktu: w-ini, pj: "Koordinator PBL TI bersama Kaprodi"),
  (aksi: [Catat kontribusi tiap anggota atau adakan penilaian sejawat pada milestone berikutnya.], waktu: w-setelah, pj: "Dosen pengampu"),
  (aksi: [Tetapkan aturan pembentukan tim yang bisa diterima kedua pihak: dosen menentukan kriteria keseimbangan, mahasiswa mengusulkan susunan, dosen menyetujui, dan tim sudah terbentuk sebelum minggu ke-2.], waktu: w-depan, pj: "Koordinator PBL TI dan dosen pengampu"),
  (aksi: [Berikan satu paket informasi (SOP, template, jadwal milestone, rubrik, bobot nilai) di minggu pertama untuk TI dan SIB, lewat LMS, Kaprodi, dan dosen pengampu tiap program studi.], waktu: w-depan, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Ajukan server deployment bersama untuk proyek PBL dan perbaiki jaringan, dengan cara pengajuan proyek yang sederhana.], waktu: w-depan, pj: "Ketua Jurusan dan laboratorium"),
)

= Beda Penilaian Mahasiswa dan Dosen

#baik-buruk(
  baik: (
    [Selisih terkecil ada pada keterampilan teknis (*#sgn(A.gap.at(8).gap)*): dosen dan mahasiswa sama-sama menilai tinggi.],
    [Di SIB, rubrik (*#sgn(SIB.gap.at(5).gap)*) dan keselarasan tugas (*#sgn(SIB.gap.at(4).gap)*) dinilai sama oleh dosen dan mahasiswa, jadi masalahnya jelas.],
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
  - *Ada tiga kemungkinan penjelasan.* Dosen menilai dari rancangan yang mereka buat, sedangkan mahasiswa dari pengalaman di semua mata kuliah. Dosen tidak melihat beban yang menumpuk. Informasi alur belum sampai ke mahasiswa.
  - *Bukan salah satu pihak yang keliru.* Keduanya menjawab jujur dari tempat yang berbeda. Kemungkinan di atas perlu dibahas di rapat evaluasi.
  - *Kalau keduanya sepakat, itu tanda terkuat bahwa masalahnya nyata.* Itu yang terjadi pada rubrik dan keselarasan tugas di SIB.
]

#rekom-box(
  (aksi: [Bahas hasil ini di rapat evaluasi dengan dosen pengampu, dan undang perwakilan mahasiswa untuk menyampaikan pengalaman mereka.], waktu: w-ini, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi diurutkan menurut jumlah responden yang menyebut masalahnya dan kuatnya hubungan masalah itu dengan kepuasan.

#keputusan()

#sec-rekom-kartu((
  (judul: "Koordinasi antar dosen, peran tertulis, dan dosen rujukan", prioritas: w-ini,
   bukti: [#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct) mahasiswa memilihnya sebagai masalah; hanya #pc(m.coord.at(1).ya) menilai arahan konsisten; hanya #pc(l.coord_yn.at(2).ya) dosen punya kesepakatan peran; #th("koordinasi").n komentar bebas.],
   minggu: ([Adakan satu sesi koordinasi dosen untuk menyamakan arahan Milestone 2.], [Buat daftar dosen rujukan (PIC) tiap kelas dan umumkan ke mahasiswa.]),
   setelah: ([Adakan rapat koordinasi rutin dua mingguan dan tetapkan peran dosen di tiap kelas secara tertulis.],),
   depan: ([Tetapkan peran dan jadwal rapat di awal semester.],),
   indikator: [dosen yang selalu hadir minimal 80%; arahan konsisten minimal 60% menurut mahasiswa], pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (judul: "Beban: satukan tugas mata kuliah dengan proyek", prioritas: w-ini,
   bukti: [#pc(m.material.at(0).pct) mengatakan tugas menambah beban; #pc(m.workload_heavy_pct) menilai beban berat; kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2); #th("beban").n komentar bebas.],
   minggu: ([Minta dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.],),
   setelah: ([Susun kalender tenggat bersama sampai akhir semester.], [Cocokkan setiap tugas dengan hasil kerja milestone.]),
   depan: ([Jadikan tugas mata kuliah bagian dari hasil kerja milestone dan batasi tugas di luar proyek.],),
   indikator: [mahasiswa yang menilai beban berat di bawah 30%], pj: "Dosen pengampu dan Koordinator PBL TI"),
  (judul: "Kontribusi anggota dan pembentukan tim", prioritas: w-ini,
   bukti: [#pc(imp("Kontribusi anggota tim tidak seimbang").pct) memilihnya (TI #pc(pick(TI.mhs.improve, "Kontribusi anggota tim tidak seimbang").pct)); hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil; #th("tim").n komentar bebas, dengan pendapat terbelah tentang cara membentuk tim.],
   minggu: ([Minta dosen menanyakan kontribusi tiap anggota saat review Milestone 2.],),
   setelah: ([Catat kontribusi tiap anggota atau adakan penilaian sejawat pada milestone berikutnya.],),
   depan: ([Tetapkan aturan pembentukan tim yang disepakati bersama dan selesaikan sebelum minggu ke-2.],),
   indikator: [penilaian adil disetujui minimal 70%], pj: "Koordinator PBL TI dan dosen pengampu"),
  (judul: "Template, jadwal, rubrik, dan bobot nilai yang jelas sejak awal", prioritas: w-ini,
   bukti: [#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct) memilih kejelasan ketentuan sebagai masalah; bobot PBL tidak disampaikan pada #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mata kuliah; #th("kejelasan").n komentar bebas.],
   minggu: ([Minta dosen menyampaikan ulang ketentuan dan format laporan Milestone 2 di kelas.],),
   setelah: ([Siapkan satu dokumen laporan gabungan dan jadwal milestone di LMS untuk milestone berikutnya.],),
   depan: ([Berikan satu paket (SOP, template, jadwal, rubrik, bobot) di minggu pertama untuk TI dan SIB.],),
   indikator: [bobot tidak disampaikan di bawah 5%], pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (judul: "Penilaian yang transparan dan adil", prioritas: w-ini,
   bukti: [Hanya #pc(m.ops.at(5).pct_agree) setuju rubrik jelas dan #pc(m.ops.at(6).pct_agree) setuju penilaian adil; keduanya berhubungan dengan kepuasan (#fmt(dr.corr.at(1).r_puas, d: 2) dan #fmt(dr.corr.at(2).r_puas, d: 2)); #th("nilai").n komentar bebas.],
   minggu: ([Minta dosen menyampaikan ulang rubrik dan bobot nilai PBL di kelas.],),
   setelah: ([Berikan rubrik dengan contoh dan umpan balik tertulis dalam tujuh hari.],),
   depan: ([Di SIB, kaji rubrik yang menempatkan analisis dan manajemen proyek sejajar dengan produk.],),
   indikator: [rubrik jelas disetujui minimal 70%], pj: "Dosen pengampu dan Kaprodi SIB"),
  (judul: "Bimbingan dan materi yang tepat waktu", prioritas: w-ini,
   bukti: [#pc(m.consult_freq.items.at(0).pct) tim belum pernah berkonsultasi; #pc(pick(m.material, "Materi pendukung kurang").pct) mengatakan materi pendukung kurang; #pc(pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct) mengatakan materi terlambat.],
   minggu: ([Sediakan 15 menit untuk meninjau proyek tiap tim pada pertemuan terdekat sebelum review.],),
   setelah: ([Adakan sesi tinjau proyek tiap tim di setiap milestone dan catat di catatan bimbingan.],),
   depan: ([Susun daftar materi yang dibutuhkan tiap milestone dan adakan kelas klinik.],),
   indikator: [tim yang belum berkonsultasi di bawah 10%], pj: "Dosen pengampu"),
  (judul: "Fasilitas: server deployment dan jaringan", prioritas: w-setelah,
   bukti: [Fasilitas adalah butir dengan skor terendah (#fmt(m.ops.at(7).mean, d: 2)) dan paling berhubungan dengan kepuasan (#fmt(dr.corr.at(0).r_puas, d: 2)); #pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct) memilihnya sebagai masalah; semua komentar tentang fasilitas datang dari SIB.],
   setelah: ([Data kebutuhan server proyek tiap tim sebagai dasar pengajuan.],),
   depan: ([Sediakan server deployment bersama dengan cara pengajuan proyek yang sederhana.], [Perbaiki jaringan.]),
   indikator: [skor fasilitas minimal 3,8], pj: "Ketua Jurusan dan laboratorium"),
  (judul: "Pemahaman PBL dosen dan orientasi mahasiswa", prioritas: w-setelah,
   bukti: [Hanya #pc(l.k2_correct) dosen memilih tindakan PBL yang tepat; #pick(l.sosialisasi, "Belum pernah").count dosen belum pernah mengikuti sosialisasi; #pc(m.k3.items.at(0).pct) mahasiswa belum pernah mengikuti PBL.],
   setelah: ([Jadwalkan sosialisasi bagi dosen yang belum mengikutinya.],),
   depan: ([Adakan penyegaran PBL 60 menit untuk semua dosen.], [Adakan orientasi PBL di minggu pertama untuk mahasiswa.]),
   indikator: [dosen memilih tindakan yang tepat minimal 90%], pj: "Koordinator PBL TI"),
  (judul: "Respons survei: pantau pengisian di setiap kelas", prioritas: w-ini,
   bukti: [Respons #pc(m.response.rate, d: 1) dari target 70%; #pc(mo.enf.rate, d: 1) di kelas yang dipantau berbanding #pc(mo.oth.rate, d: 1) di kelas tanpa pemantauan.],
   minggu: ([Putuskan apakah formulir dibuka lagi untuk kelas dengan respons di bawah 30%.],),
   depan: ([Minta dosen mengingatkan dan memantau pengisian di kelasnya: satu sesi 10 menit pada jam kuliah bersama DPA dan ketua kelas.], [Kirim jumlah respons tiap kelas ke grup pada hari ke-3 dan hari terakhir.]),
   indikator: [respons minimal 70% di setiap kelas pada survei berikutnya], pj: "Kaprodi, dosen pengampu, DPA"),
))

== Rencana tindak lanjut

#sec-rekom-tabel((
  (judul: "Koordinasi antar dosen", tindakan: [Sesi koordinasi dan daftar dosen rujukan; lalu rapat rutin dan peran tertulis], waktu: [#w-ini, lanjut #w-setelah]),
  (judul: "Beban tugas di luar proyek", tindakan: [Tahan tugas baru; kalender tenggat bersama; cocokkan tugas dengan hasil kerja], waktu: [#w-ini, #w-setelah]),
  (judul: "Kontribusi dan pembentukan tim", tindakan: [Tanya kontribusi saat review; catat kontribusi; aturan pembentukan tim], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Kejelasan template, rubrik, bobot", tindakan: [Sampaikan ulang ketentuan; satu paket informasi di minggu pertama], waktu: [#w-ini, #w-depan]),
  (judul: "Transparansi penilaian", tindakan: [Sampaikan ulang rubrik; umpan balik dalam tujuh hari], waktu: [#w-ini, #w-setelah]),
  (judul: "Bimbingan dan materi", tindakan: [Tinjau proyek 15 menit; catatan bimbingan; daftar kebutuhan materi], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Fasilitas", tindakan: [Data kebutuhan server; server bersama dan perbaikan jaringan], waktu: [#w-setelah, #w-depan]),
  (judul: "Pemahaman PBL", tindakan: [Jadwalkan sosialisasi; penyegaran dosen dan orientasi mahasiswa], waktu: [#w-setelah, #w-depan]),
  (judul: "Respons survei", tindakan: [Putuskan buka lagi formulir; pantau pengisian di setiap kelas], waktu: [#w-ini, #w-depan]),
))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
