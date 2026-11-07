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

Survei monev PBL diisi oleh *#m.n mahasiswa* (#pc(m.response.rate, d: 1) dari #m.response.roster mahasiswa) dan *#l.n dosen pengampu* (#pc(l.rate, d: 1) dari #l.roster dosen) pada Program Studi TI dan SIB, Semester 3 dan 5. Berikut ringkasan yang baik dan yang bermasalah, disusul langkah tindak lanjut menurut waktunya.

#tiles(
  tile(pc(m.response.rate, d: 1), "Tingkat respons mahasiswa", sub: "target 70%", color: accent),
  tile(pc(m.ben.at(0).pct_agree), "Mahasiswa setuju PBL meningkatkan keterampilan teknis"),
  tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan pelaksanaan PBL", color: accent),
  tile(pc(m.coord.at(1).ya), "Mahasiswa menilai arahan antar dosen konsisten", color: accent),
)

#baik-buruk(
  baik: (
    [*#pc(m.ben.at(0).pct_agree)* mahasiswa setuju PBL meningkatkan keterampilan teknis, *#pc(m.ben.at(1).pct_agree)* kerja sama, dan *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
    [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu, butir pelaksanaan tertinggi (#fmt(m.ops.at(1).mean, d: 2)).],
    [*#pc(cepat)* mahasiswa menyebut dosen menanggapi pertanyaan proyek dalam kurang dari sehari.],
    [*#pc(l.rate, d: 1)* dosen mengisi survei, dan dosen menilai pelaksanaan *#fmt(l.ops_mean, d: 2)* (#l.ops_cat).],
    [Beberapa komentar SIB Semester 5 menyebut pelaksanaan semester ini lebih rapi daripada semester sebelumnya (#tema.membaik.n komentar).],
  ),
  buruk: (
    [Hanya *#pc(m.ben.at(3).pct_agree)* mahasiswa puas dan *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
    [*#pc(m.workload_heavy_pct)* menilai beban berat dan *#pc(m.material.at(0).pct)* menyebut tugas mata kuliah menambah beban di luar proyek.],
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar dosen konsisten; hanya *#pc(l.coord_yn.at(2).ya)* dosen punya kesepakatan peran.],
    [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota tidak seimbang sebagai masalah.],
    [Fasilitas adalah butir terendah (*#fmt(m.ops.at(7).mean, d: 2)*); *#pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct)* memilihnya sebagai masalah.],
    [Respons mahasiswa hanya *#pc(m.response.rate, d: 1)*; *#mo.oth.n_classes kelas* hanya *#pc(mo.oth.rate, d: 1)*.],
  ),
)

== Tindak lanjut utama menurut waktu

#grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Rapat evaluasi dengan dosen pengampu; ringkasan hasil diumumkan ke mahasiswa dan dosen; daftar dosen rujukan (PIC) per kelas; dosen menyampaikan ulang bobot nilai dan ketentuan Milestone 2 di kelas; tidak ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Rapat koordinasi rutin dan peran tertulis; kalender tenggat bersama; audit tugas terhadap deliverable; catatan kontribusi anggota; rubrik dengan umpan balik tujuh hari.],
  chip(w-depan, primary-mid), [Satu paket informasi pada minggu pertama untuk TI dan SIB; aturan pembentukan tim; server deployment dan jaringan; penyegaran PBL bagi dosen dan orientasi mahasiswa; tindak lanjut pengisian survei di setiap kelas.],
)

#pagebreak(weak: true)

= Latar Belakang dan Cara Membaca

Survei dilaksanakan menjelang Milestone 2 melalui dua Google Form (mahasiswa dwibahasa, dan dosen). Pertanyaannya mencakup pemahaman PBL, kegiatan per mata kuliah, koordinasi, pelaksanaan dan manfaat PBL (skala 1–5), pilihan hal baik dan hal bermasalah, serta saran bebas.

Hasil dibaca menurut empat aspek monev: (A) pelaksanaan PBL, (B) integrasi antar-mata kuliah, (C) penilaian dan umpan balik, dan (D) kolaborasi, beban, dan dukungan. Status proyek tiap tim tidak ditanyakan karena sudah dikumpulkan lewat Laporan Kemajuan. Analisis komentar bebas hanya mencakup komentar mahasiswa TI dan SIB.

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
    [#mo.oth.n_classes kelas yang hanya dibagikan tautannya: *#pc(mo.oth.rate, d: 1)*.],
  ),
)

#sec-coverage("all", lead: [Target tingkat respons adalah 70% untuk mahasiswa dan seluruh dosen pengampu. Garis pada grafik menandai 70%.])

== Kelas yang dipantau dan kelas yang hanya dibagikan tautannya

Grup WhatsApp adalah saluran komunikasi wajib, dan survei diumumkan serta diingatkan di sana. Tingkat respons tetap rendah. Pengecualiannya adalah kelas yang diampu Koordinator PBL TI, tempat pengisian juga diingatkan dan dipantau langsung. Di kelas lain, dosen pengampu membagikan tautan tanpa pemantauan lanjutan.

#sec-keterwakilan("all")

#apa-artinya[
  - *Penyebabnya tindak lanjut, bukan minat.* Selisih respons (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)) berasal dari ada tidaknya pemantauan di kelas.
  - *Grup WhatsApp tidak cukup.* Pada survei dosen, #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup tanpa menanggapi, #wa("Jarang membuka").count jarang membukanya, dan hanya #wa("Aktif menanggapi dan berbagi informasi").count yang aktif.
  - *Jawaban kedua kelompok hampir sama.* Rerata pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) berbanding #fmt(mo.oth.stats.ops_mean, d: 2), kepuasan #fmt(mo.enf.stats.puas, d: 2) berbanding #fmt(mo.oth.stats.puas, d: 2), beban berat #pc(mo.enf.stats.berat) berbanding #pc(mo.oth.stats.berat). Temuan umum tidak bergantung pada kelas yang dipantau.
  - *Kelemahannya keterwakilan.* #mo.oth.n_classes kelas lain, terutama TI Semester 5, hanya diwakili sedikit mahasiswa, sehingga masalah khusus kelas tersebut dapat terlewat.
]

#rekom-box(
  (aksi: [Kaprodi memutuskan apakah formulir dibuka kembali satu pekan khusus bagi kelas dengan respons di bawah 30%.], waktu: w-ini, pj: "Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Pada survei berikutnya setiap dosen pengampu mengingatkan dan memantau pengisian di kelas yang diampunya, seperti di lima kelas yang dipantau (#pc(mo.enf.rate, d: 1) berbanding #pc(mo.oth.rate, d: 1)). Pengisian dilakukan satu sesi 10 menit pada jam kuliah (kode QR); DPA dan ketua kelas memastikan seluruh anggota mengisi.], waktu: w-depan, pj: "Kaprodi, dosen pengampu, DPA, ketua kelas", indikator: [respons minimal 70% di setiap kelas pada survei berikutnya]),
  (aksi: [Koordinator PBL TI mengirim jumlah respons per kelas ke grup WhatsApp pada hari ke-3 dan hari terakhir, dengan menyebut kelas yang tertinggal.], waktu: w-depan, pj: "Koordinator PBL TI"),
)

= Rangkuman per Aspek

#baik-buruk(
  baik: (
    [Aspek A (pelaksanaan): *#fmt(m.aspek.at(0).mhs_mean, d: 2)* (#m.aspek.at(0).mhs_cat); hanya *#pc(m.aspek.at(0).problem_pct)* memilih masalah.],
    [Aspek C (penilaian): *#fmt(m.aspek.at(2).mhs_mean, d: 2)* (#m.aspek.at(2).mhs_cat); *#pc(m.aspek.at(2).problem_pct)* memilih masalah.],
  ),
  buruk: (
    [Aspek B (integrasi antar-mata kuliah): rerata terendah di antara A sampai C (*#fmt(m.aspek.at(1).mhs_mean, d: 2)*); *#pc(m.aspek.at(1).problem_pct)* memilih masalah.],
    [Aspek D (kolaborasi, beban, dukungan): *#pc(m.aspek.at(3).problem_pct)* memilih sedikitnya satu masalah, paling banyak.],
  ),
)

#sec-aspek("all")

#apa-artinya[
  - *Alur PBL sudah berjalan.* Aspek pelaksanaan dan penilaian tergolong baik dan jarang dipilih sebagai masalah.
  - *Masalah ada pada hubungan antar bagian.* Integrasi antar-mata kuliah (B) dan beban serta kolaborasi (D) paling bermasalah.
]

= Opini tentang Pelaksanaan dan Manfaat PBL

#baik-buruk(
  baik: (
    [Manfaat dinilai tinggi: keterampilan teknis *#fmt(m.ben.at(0).mean, d: 2)*, kerja sama *#fmt(m.ben.at(1).mean, d: 2)*, kesiapan kerja *#fmt(m.ben.at(2).mean, d: 2)*.],
    [SOP dan template membantu: *#pc(m.ops.at(1).pct_agree)* setuju (#fmt(m.ops.at(1).mean, d: 2)).],
    [Bimbingan dosen memadai: *#pc(m.ops.at(3).pct_agree)* setuju.],
  ),
  buruk: (
    [Kepuasan hanya *#fmt(m.ben.at(3).mean, d: 2)* (*#pc(m.ben.at(3).pct_agree)* setuju); keinginan melanjutkan *#fmt(m.ben.at(4).mean, d: 2)* (*#pc(m.ben.at(4).pct_agree)*).],
    [Fasilitas terendah: *#fmt(m.ops.at(7).mean, d: 2)*; keselarasan tugas antar-mata kuliah *#fmt(m.ops.at(4).mean, d: 2)*.],
    [Dosen menilai lebih tinggi pada semua butir (selisih sampai *#sgn(calc.max(..A.gap.map(g => g.gap)))*).],
  ),
)

#sec-opinion("all")

#apa-artinya[
  - *Bermanfaat, tetapi belum memuaskan.* Penyebabnya ada pada beban, koordinasi, dan fasilitas (bagian 9 sampai 11), bukan pada konsep PBL.
  - *Informasi dosen belum sampai ke mahasiswa.* Alur dan target milestone dinilai #fmt(l.ops.at(0).mean, d: 2) oleh dosen dan #fmt(m.ops.at(0).mean, d: 2) oleh mahasiswa.
  - *Bukan hanya masalah mahasiswa baru.* Rerata pelaksanaan #fmt(m.by_experience.at(0).ops_mean, d: 2) pada yang belum pernah dan #fmt(m.by_experience.at(1).ops_mean, d: 2) pada yang pernah mengikuti PBL, nyaris sama.
]

== Perbandingan per kelompok semester

#sec-semester("all")

#apa-artinya[
  - *Skor serupa, beban berbeda.* SIB Semester 3 paling berat (#pc(m.sem_stats.at(2).berat)), TI Semester 5 juga tinggi (#pc(m.sem_stats.at(1).berat)), TI Semester 3 paling rendah (#pc(m.sem_stats.at(0).berat)).
  - *Kelompok kecil perlu hati-hati.* SIB Semester 3 dan TI Semester 5 diwakili sedikit mahasiswa.
]

= Pemahaman Konsep dan Pengalaman PBL

#baik-buruk(
  baik: (
    [*#pc(m.k2_correct)* mahasiswa memilih definisi PBL yang benar.],
    [Dosen yang baru pertama kali mengampu PBL (#l.by_experience.at(0).n orang) semuanya memilih tindakan yang tepat.],
  ),
  buruk: (
    [Hanya *#pc(l.k2_correct)* dosen memilih tindakan sesuai prinsip PBL; *#int(calc.round((100 - l.k2_correct) * l.n / 100)) dari #l.n* memilih langsung memberi solusi.],
    [*#pc(m.k3.items.at(0).pct)* mahasiswa belum pernah mengikuti PBL.],
    [*#pick(l.sosialisasi, "Belum pernah").count* dosen belum pernah mengikuti sosialisasi PBL.],
  ),
)

#sec-pemahaman("all")

#apa-artinya[
  - *Konsep dipahami, kebiasaan membimbing belum.* Kesenjangan ada pada cara dosen membimbing tim yang tertinggal.
  - *Penyegaran perlu menyasar dosen berpengalaman.* Pada dosen berpengalaman hanya #pc(l.by_experience.at(1).k2_correct) memilih tindakan tepat, sedangkan pengampu baru #pc(l.by_experience.at(0).k2_correct).
  - *Mahasiswa baru perlu orientasi.* Sebagian besar mahasiswa TI belum pernah mengikuti PBL.
]

#rekom-box(
  (aksi: [Dosen yang belum mengikuti sosialisasi PBL dijadwalkan mengikuti sosialisasi.], waktu: w-setelah, pj: "Kaprodi dan Koordinator PBL TI"),
  (aksi: [Penyegaran PBL sekitar 60 menit bagi seluruh dosen pengampu, dengan latihan menyusun pertanyaan pemandu; dosen baru dipasangkan dengan dosen berpengalaman.], waktu: w-depan, pj: "Koordinator PBL TI", indikator: [dosen memilih tindakan tepat minimal 90% pada survei berikutnya]),
  (aksi: [Orientasi PBL pada minggu pertama bagi mahasiswa yang belum pernah mengikuti PBL, dengan contoh laporan dan alur milestone.], waktu: w-depan, pj: "Dosen pengampu"),
)

= Bimbingan dan Konsultasi

#baik-buruk(
  baik: (
    [*#pc(cepat)* mahasiswa menyebut dosen menanggapi dalam kurang dari sehari.],
    [Inisiatif konsultasi umumnya dari kedua pihak (*#pc(pick(m.consult_init.items, "Keduanya").pct)*).],
  ),
  buruk: (
    [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi di luar jam kuliah.],
    [Kesempatan konsultasi tidak merata antar mata kuliah (#th("bimbingan").n komentar).],
  ),
)

#sec-konsultasi("all")

#apa-artinya[
  - *Bimbingan tersedia dan responsif.* Mahasiswa menilai dosen cepat menanggapi.
  - *Jumlah konsultasi bukan penentu kepuasan.* Yang pernah dan belum pernah berkonsultasi sama-sama rata-rata puas #fmt(grp(konsul, "Pernah").puas, d: 2) dan #fmt(grp(konsul, "Belum pernah").puas, d: 2).
  - *Konsultasi cenderung dilakukan ketika ada masalah.* Yang belum pernah berkonsultasi justru sedikit lebih ingin melanjutkan PBL (#fmt(grp(konsul, "Belum pernah").lanjut, d: 2) berbanding #fmt(grp(konsul, "Pernah").lanjut, d: 2)).
]

#rekom-box(
  (aksi: [Dosen menyediakan sekitar 15 menit tinjau proyek per tim pada pertemuan terdekat sebelum review Milestone 2.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Sesi tinjau proyek per tim pada setiap milestone, dicatat dalam logbook tim, agar bimbingan tidak hanya bergantung pada inisiatif mahasiswa.], waktu: w-setelah, pj: "Dosen pengampu dan Koordinator PBL TI", indikator: [tim yang belum pernah berkonsultasi di bawah 10% pada survei berikutnya]),
)

= Keselarasan Mata Kuliah dengan Proyek

#baik-buruk(
  baik: (
    [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
    [*#pc(m.pooled.bc.at(8).ya)* menjawab dosen mengetahui topik proyek tim.],
    [*#pc(pick(m.pooled.type, "Deliverable proyek").pct)* tugas utama berupa deliverable proyek.],
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
  - *Selaras di tingkat dokumen, setengah di tingkat tugas.* Inilah sumber keluhan beban: tugas tambahan di luar proyek.
  - *Dosen sendiri melihat hal yang sama.* Hanya #pc(l.align.at(3).ya) dosen menjawab tugas mata kuliahnya bagian dari deliverable proyek.
  - *Informasi bobot belum diterima.* #int(calc.round(l.explain_start.ya * l.n / 100)) dari #l.n dosen menyatakan menjelaskan keterkaitan di awal semester, tetapi #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mahasiswa menyebut bobot tidak disampaikan.
]

#rekom-box(
  (aksi: [Dosen menyampaikan ulang bobot nilai PBL dan ketentuan Milestone 2 di kelas masing-masing.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Audit tugas per mata kuliah pada rapat koordinasi: setiap tugas dipetakan ke deliverable milestone; tugas yang tidak terkait proyek dikurangi atau digabung.], waktu: w-setelah, pj: "Dosen pengampu, difasilitasi Koordinator PBL TI", indikator: [jawaban "tugas bagian dari proyek" naik dari #pc(m.pooled.bc.at(3).ya) menjadi minimal 70% pada survei berikutnya]),
  (aksi: [Bobot nilai PBL ditulis di RPS dan diumumkan di LMS pada awal semester.], waktu: w-depan, pj: "Dosen pengampu", indikator: [jawaban bobot tidak disampaikan di bawah 5%]),
)

= Beban Kerja dan Tugas di Luar Proyek

#baik-buruk(
  baik: (
    [*#pc(m.workload.items.at(1).pct)* mahasiswa menilai beban sesuai.],
    [Dosen menilai bebannya sendiri wajar: hanya *#pc(l.workload_heavy_pct)* menilai berat.],
  ),
  buruk: (
    [*#pc(m.workload_heavy_pct)* mahasiswa menilai beban berat atau sangat berat.],
    [*#pc(m.material.at(0).pct)* menyebut tugas mata kuliah menambah beban di luar proyek.],
    [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang menilai beban berat, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2).],
  ),
)

#sec-workload("all")

#apa-artinya[
  - *Beban dirasakan dari penjumlahan tugas.* Dosen melihat satu mata kuliah; mahasiswa merasakan semua sekaligus ("seakan-akan ada tiga PBL").
  - *Paling berat di SIB Semester 3.* #pc(m.sem_stats.at(2).berat) menilai beban berat.
  - *Dampak terbesar pada kepuasan.* Beban adalah faktor yang paling kuat berkaitan dengan kepuasan (bagian 11).
]

#rekom-box(
  (aksi: [Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.], waktu: w-ini, pj: "Dosen pengampu"),
  (aksi: [Kalender tenggat bersama seluruh mata kuliah PBL per kelas untuk sisa semester, disusun pada rapat koordinasi.], waktu: w-setelah, pj: "Koordinator PBL TI dan dosen pengampu per kelas", indikator: [pilihan "tenggat antar mata kuliah bertabrakan" (sering atau selalu) turun dari #pc(m.coord.at(3).pct_oa)]),
  (aksi: [Tugas mata kuliah menjadi bagian deliverable milestone; batas jumlah tugas di luar proyek per mata kuliah ditetapkan.], waktu: w-depan, pj: "Dosen pengampu", indikator: [mahasiswa yang menilai beban berat di bawah 30%]),
)

= Koordinasi antar Dosen

#baik-buruk(
  baik: (
    [Dosen saling mengetahui topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
    [Informasi dari koordinator diterima jelas dan tepat waktu (*#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5).],
    [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus menghubungi dosen siapa.],
  ),
  buruk: (
    [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan antar mata kuliah konsisten; *#pc(m.coord.at(3).pct_oa)* mengalami tenggat bertabrakan.],
    [Hanya *#pc(l.coord_yn.at(2).ya)* dosen punya kesepakatan peran; *#pc(l.coord_lk.at(1).pct_never)* jarang atau tidak pernah menyelaraskan rubrik.],
    [Hanya *#l.meeting.items.at(0).count dari #l.n* dosen selalu hadir pada rapat koordinasi.],
    [Komunikasi antar dosen dinilai *#fmt(l.ops_extra.at(0).mean, d: 2)* dari 5, terendah di antara butir pelaksanaan.],
  ),
)

#sec-coord("all")

#apa-artinya[
  - *Dua sisi melihat masalah yang sama.* Mahasiswa melihat akibatnya (arahan tidak konsisten, tenggat bertabrakan); dosen mengakui sebabnya (tidak ada kesepakatan peran, jarang menyelaraskan).
  - *Penyebabnya struktural.* Dosen menyebut beban mengajar dan administrasi (#pick(l.barriers, "Beban mengajar dan administrasi lain").count dari #l.n) dan tidak adanya jadwal rapat rutin (#pick(l.barriers, "Tidak ada jadwal rapat rutin").count).
  - *Grup WhatsApp belum menggantikan rapat.* #wa("Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup; efektivitasnya dinilai #fmt(l.ops_extra.at(1).mean, d: 2) dari 5.
  - *Di SIB, kedua pihak sepakat.* Mahasiswa dan dosen sama-sama menilai keselarasan tugas dan rubrik rendah (bagian 14).
]

#rekom-box(
  (aksi: [Satu sesi koordinasi dosen untuk menyamakan arahan Milestone 2, dan daftar sederhana dosen rujukan (PIC) per kelas yang diumumkan kepada mahasiswa.], waktu: w-ini, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Rapat koordinasi rutin (dua mingguan, 30 menit) per program studi dengan agenda tetap: progres tim, tenggat bersama, dan keselarasan rubrik; pembagian peran tertulis per kelas.], waktu: w-setelah, pj: "Kaprodi dan dosen pengampu", indikator: [dosen yang selalu hadir naik dari #l.meeting.items.at(0).count menjadi minimal 80%; kesepakatan peran naik dari #pc(l.coord_yn.at(2).ya) menjadi minimal 80%]),
  (aksi: [Grup WhatsApp dipakai untuk pembaruan progres tim yang terjadwal dengan format singkat; keputusan penting dicatat dalam notulen rapat.], waktu: w-setelah, pj: "Koordinator PBL TI"),
)

= Faktor yang Berkaitan dengan Kepuasan

#baik-buruk(
  baik: (
    [Yang tahu harus menghubungi dosen siapa lebih puas: *#fmt(grp(kontak, "Ya").puas, d: 2)* berbanding #fmt(grp(kontak, "Sebagian atau tidak").puas, d: 2).],
    [Yang menilai arahan konsisten lebih puas: *#fmt(grp(konsis, "Ya").puas, d: 2)* berbanding #fmt(grp(konsis, "Sebagian atau tidak").puas, d: 2).],
    [Kelengkapan SOP bukan penentu (korelasi hanya #fmt(sop.r_puas, d: 2)).],
  ),
  buruk: (
    [Beban berat: puas *#fmt(grp(beban, "Berat atau sangat berat").puas, d: 2)* dan ingin melanjutkan *#fmt(grp(beban, "Berat atau sangat berat").lanjut, d: 2)*, berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2) dan #fmt(grp(beban, "Ringan atau sesuai").lanjut, d: 2).],
    [Fasilitas paling berkaitan dengan kepuasan (*#fmt(dr.corr.at(0).r_puas, d: 2)*), tetapi dinilai terendah.],
    [Rubrik jelas (*#fmt(dr.corr.at(1).r_puas, d: 2)*) dan penilaian adil (*#fmt(dr.corr.at(2).r_puas, d: 2)*) berkaitan kuat, tetapi hanya #pc(m.ops.at(5).pct_agree) dan #pc(m.ops.at(6).pct_agree) yang setuju.],
  ),
)

#sec-faktor("all")

#apa-artinya[
  - *Urutan prioritas dari data:* beban, kejelasan dan keadilan penilaian, fasilitas, dan kejelasan dosen rujukan.
  - *Keterkaitan, bukan sebab-akibat.* Pola ini cukup konsisten untuk dijadikan dasar urutan rekomendasi.
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
  - *SOP dan template: dua sisi.* Dihargai keberadaannya (#pc(m.dua_sisi.at(0).baik)), tetapi kejelasan dan waktu penyampaiannya bermasalah bagi #pc(m.dua_sisi.at(0).masalah).
  - *Kerja sama tim: dua sisi.* Dinikmati (#pc(m.dua_sisi.at(5).baik)), tetapi pembagian kerja belum merata (#pc(m.dua_sisi.at(5).masalah)).
  - *Fasilitas: hanya masalah.* Disebut baik #pc(m.dua_sisi.at(6).baik), bermasalah #pc(m.dua_sisi.at(6).masalah).
  - *Bimbingan dan umpan balik: keunggulan.* #pc(m.dua_sisi.at(2).baik) menyebutnya baik, hanya #pc(m.dua_sisi.at(2).masalah) bermasalah.
]

#pagebreak(weak: true)

= Analisis Komentar Bebas Mahasiswa

#baik-buruk(
  baik: (
    [*#th("baik").n komentar* menyebut hal baik yang ingin dipertahankan: manfaat PBL, konsultasi dosen, template.],
    [*#tema.membaik.n komentar* SIB Semester 5 menyebut pelaksanaan semester ini lebih rapi daripada sebelumnya.],
    [Banyak komentar kritis ditutup dengan keinginan agar PBL dipertahankan dan diperbaiki.],
  ),
  buruk: (
    [*#th("beban").n komentar* tentang tugas di luar proyek dan tenggat (TI #th("beban").ti, SIB #th("beban").sib).],
    [*#th("koordinasi").n komentar* tentang koordinasi antar dosen (TI #th("koordinasi").ti, SIB #th("koordinasi").sib).],
    [*#th("tim").n komentar* tentang kontribusi tim; *#th("kejelasan").n* tentang kejelasan template dan alur; *#th("fasilitas").n* tentang fasilitas (seluruhnya SIB).],
  ),
)

#sec-komentar("all", lead: [Kolom saran terbuka adalah tempat mahasiswa menjelaskan *mengapa* mereka menjawab seperti pada skala. Seluruh komentar mahasiswa TI dan SIB dibaca dan dikelompokkan. Bagian ini menunjukkan isi tiap tema, perbedaan antara TI dan SIB, kaitannya dengan angka survei, dan artinya.])

#rekom-box(
  (aksi: [Menyampaikan ringkasan hasil kepada mahasiswa TI dan SIB, bahwa komentar mereka dibaca dan langkah apa yang diambil.], waktu: w-ini, pj: "Koordinator PBL TI bersama Kaprodi"),
  (aksi: [Catatan kontribusi per anggota atau penilaian sejawat pada milestone berikutnya.], waktu: w-setelah, pj: "Dosen pengampu"),
  (aksi: [Aturan pembentukan tim yang diterima kedua pihak: dosen menetapkan kriteria keseimbangan, mahasiswa mengusulkan susunan, dosen menyetujui, dan tim terbentuk sebelum minggu ke-2.], waktu: w-depan, pj: "Koordinator PBL TI dan dosen pengampu"),
  (aksi: [Satu paket informasi pada minggu pertama (SOP, template, jadwal milestone, rubrik, bobot nilai) untuk TI dan SIB, disampaikan lewat LMS, Kaprodi, dan dosen pengampu masing-masing program studi.], waktu: w-depan, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (aksi: [Mengajukan server deployment bersama untuk proyek PBL dan memperbaiki jaringan, dengan mekanisme pengajuan proyek yang sederhana.], waktu: w-depan, pj: "Ketua Jurusan dan laboratorium"),
)

= Selisih Sudut Pandang Mahasiswa dan Dosen

#baik-buruk(
  baik: (
    [Selisih terkecil pada keterampilan teknis (*#sgn(A.gap.at(8).gap)*): dosen dan mahasiswa sama-sama menilai tinggi.],
    [Di SIB, rubrik (*#sgn(SIB.gap.at(5).gap)*) dan keselarasan tugas (*#sgn(SIB.gap.at(4).gap)*) dinilai sama oleh dosen dan mahasiswa, sehingga masalahnya jelas.],
  ),
  buruk: (
    [Dosen menilai lebih tinggi pada seluruh *#A.gap.len() butir* yang sebanding.],
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
  - *Dua kemungkinan penjelasan.* Dosen menilai dari rancangan yang dibuat, mahasiswa dari pengalaman lintas mata kuliah; dosen tidak melihat penjumlahan beban; informasi alur belum sampai ke mahasiswa.
  - *Bukan salah satu pihak.* Kedua kelompok menjawab jujur dari tempat yang berbeda; hal ini perlu diuji dalam rapat evaluasi.
  - *Kesepakatan adalah sinyal terkuat.* Bila kedua pihak sama-sama menilai rendah, masalahnya nyata.
]

#rekom-box(
  (aksi: [Rapat evaluasi dengan dosen pengampu, dengan perwakilan mahasiswa diundang menyampaikan pengalaman mereka.], waktu: w-ini, pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
)

#pagebreak(weak: true)

= Rekomendasi Tindak Lanjut

Rekomendasi dirangkum dari seluruh bagian di atas dan diurutkan menurut jumlah responden yang menyebut masalahnya serta kuatnya keterkaitannya dengan kepuasan.

#keputusan()

#sec-rekom-kartu((
  (judul: "Koordinasi antar dosen, peran tertulis, dan dosen rujukan", prioritas: w-ini,
   bukti: [#pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi").pct) mahasiswa memilihnya; arahan konsisten hanya #pc(m.coord.at(1).ya); kesepakatan peran hanya #pc(l.coord_yn.at(2).ya); #th("koordinasi").n komentar bebas.],
   minggu: ([Satu sesi koordinasi dosen untuk menyamakan arahan Milestone 2.], [Daftar dosen rujukan (PIC) per kelas, diumumkan ke mahasiswa.]),
   setelah: ([Rapat koordinasi rutin dua mingguan dan peran tertulis per kelas.],),
   depan: ([Peran dan jadwal rapat ditetapkan di awal semester.],),
   indikator: [dosen yang selalu hadir minimal 80%; arahan konsisten minimal 60% mahasiswa], pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (judul: "Beban: satukan tugas mata kuliah dengan proyek", prioritas: w-ini,
   bukti: [#pc(m.material.at(0).pct) menyebut tugas menambah beban; #pc(m.workload_heavy_pct) menilai beban berat; kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) berbanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2); #th("beban").n komentar bebas.],
   minggu: ([Dosen tidak menambah tugas baru di luar proyek selama pekan Milestone 2.],),
   setelah: ([Kalender tenggat bersama untuk sisa semester.], [Audit tugas terhadap deliverable milestone.]),
   depan: ([Tugas mata kuliah menjadi bagian deliverable; batas tugas di luar proyek.],),
   indikator: [mahasiswa yang menilai beban berat di bawah 30%], pj: "Dosen pengampu dan Koordinator PBL TI"),
  (judul: "Kontribusi anggota dan pembentukan tim", prioritas: w-ini,
   bukti: [#pc(imp("Kontribusi anggota tim tidak seimbang").pct) memilihnya (TI #pc(pick(TI.mhs.improve, "Kontribusi anggota tim tidak seimbang").pct)); hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil; #th("tim").n komentar bebas dengan pendapat terbelah soal pembentukan tim.],
   minggu: ([Dosen menanyakan kontribusi tiap anggota saat review Milestone 2.],),
   setelah: ([Catatan kontribusi per anggota atau penilaian sejawat pada milestone berikutnya.],),
   depan: ([Aturan pembentukan tim yang disepakati, selesai sebelum minggu ke-2.],),
   indikator: [penilaian adil disetujui minimal 70%], pj: "Koordinator PBL TI dan dosen pengampu"),
  (judul: "Kejelasan template, jadwal, rubrik, dan bobot nilai", prioritas: w-ini,
   bukti: [#pc(imp("Kejelasan ketentuan (SOP dan rubrik)").pct) memilih kejelasan ketentuan; bobot PBL tidak disampaikan pada #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mata kuliah; #th("kejelasan").n komentar bebas.],
   minggu: ([Dosen menyampaikan ulang ketentuan dan format laporan Milestone 2 di kelas.],),
   setelah: ([Satu dokumen laporan gabungan dan jadwal milestone di LMS untuk milestone berikutnya.],),
   depan: ([Satu paket (SOP, template, jadwal, rubrik, bobot) pada minggu pertama untuk TI dan SIB.],),
   indikator: [bobot tidak disampaikan di bawah 5%], pj: "Koordinator PBL TI, Kaprodi TI dan Kaprodi SIB"),
  (judul: "Transparansi dan keadilan penilaian", prioritas: w-ini,
   bukti: [Hanya #pc(m.ops.at(5).pct_agree) setuju rubrik jelas dan #pc(m.ops.at(6).pct_agree) setuju penilaian adil; keduanya berkaitan dengan kepuasan (#fmt(dr.corr.at(1).r_puas, d: 2) dan #fmt(dr.corr.at(2).r_puas, d: 2)); #th("nilai").n komentar bebas.],
   minggu: ([Dosen menyampaikan ulang rubrik dan bobot nilai PBL di kelas.],),
   setelah: ([Rubrik dengan contoh dan umpan balik tertulis dalam tujuh hari.],),
   depan: ([Di SIB, kaji rubrik yang menempatkan analisis dan manajemen proyek sejajar dengan produk.],),
   indikator: [rubrik jelas disetujui minimal 70%], pj: "Dosen pengampu dan Kaprodi SIB"),
  (judul: "Bimbingan dan materi tepat waktu", prioritas: w-ini,
   bukti: [#pc(m.consult_freq.items.at(0).pct) tim belum pernah berkonsultasi; #pc(pick(m.material, "Materi pendukung kurang").pct) menyebut materi pendukung kurang; #pc(pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct) menyebut materi terlambat.],
   minggu: ([15 menit tinjau proyek per tim pada pertemuan terdekat sebelum review.],),
   setelah: ([Sesi tinjau proyek per tim pada tiap milestone, dicatat di logbook.],),
   depan: ([Matriks kebutuhan materi per milestone dan kelas klinik.],),
   indikator: [tim yang belum berkonsultasi di bawah 10%], pj: "Dosen pengampu"),
  (judul: "Fasilitas: server deployment dan jaringan", prioritas: w-setelah,
   bukti: [Fasilitas adalah butir terendah (#fmt(m.ops.at(7).mean, d: 2)) dan paling berkaitan dengan kepuasan (#fmt(dr.corr.at(0).r_puas, d: 2)); #pc(imp("Fasilitas dan sumber daya (server, data, perangkat)").pct) menyebutnya masalah; seluruh komentar fasilitas dari SIB.],
   setelah: ([Mendata kebutuhan server proyek per tim sebagai dasar pengajuan.],),
   depan: ([Server deployment bersama dengan mekanisme pengajuan proyek.], [Perbaikan jaringan.]),
   indikator: [skor fasilitas minimal 3,8], pj: "Ketua Jurusan dan laboratorium"),
  (judul: "Pemahaman PBL dosen dan orientasi mahasiswa", prioritas: w-setelah,
   bukti: [Hanya #pc(l.k2_correct) dosen memilih tindakan PBL yang tepat; #pick(l.sosialisasi, "Belum pernah").count dosen belum mengikuti sosialisasi; #pc(m.k3.items.at(0).pct) mahasiswa belum pernah mengikuti PBL.],
   setelah: ([Dosen yang belum mengikuti sosialisasi dijadwalkan.],),
   depan: ([Penyegaran PBL 60 menit bagi seluruh dosen.], [Orientasi PBL minggu pertama bagi mahasiswa.]),
   indikator: [dosen memilih tindakan tepat minimal 90%], pj: "Koordinator PBL TI"),
  (judul: "Tingkat respons survei: tindak lanjut di setiap kelas", prioritas: w-ini,
   bukti: [Respons #pc(m.response.rate, d: 1) dari target 70%; #pc(mo.enf.rate, d: 1) di kelas yang dipantau berbanding #pc(mo.oth.rate, d: 1) di kelas lain.],
   minggu: ([Kaprodi memutuskan pembukaan kembali formulir bagi kelas dengan respons di bawah 30%.],),
   depan: ([Dosen pengampu mengingatkan dan memantau pengisian di kelasnya, satu sesi 10 menit di jam kuliah dengan DPA dan ketua kelas.], [Jumlah respons per kelas dikirim ke grup pada hari ke-3 dan hari terakhir.]),
   indikator: [respons minimal 70% di setiap kelas pada survei berikutnya], pj: "Kaprodi, dosen pengampu, DPA"),
))

== Rencana tindak lanjut

#sec-rekom-tabel((
  (judul: "Koordinasi antar dosen", tindakan: [Sesi koordinasi dan daftar PIC; lalu rapat rutin dan peran tertulis], waktu: [#w-ini, lanjut #w-setelah]),
  (judul: "Beban tugas di luar proyek", tindakan: [Tahan tugas baru; kalender tenggat bersama; audit tugas], waktu: [#w-ini, #w-setelah]),
  (judul: "Kontribusi dan pembentukan tim", tindakan: [Tanya kontribusi saat review; catatan kontribusi; aturan tim], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Kejelasan template, rubrik, bobot", tindakan: [Sampaikan ulang ketentuan; satu paket informasi minggu pertama], waktu: [#w-ini, #w-depan]),
  (judul: "Transparansi penilaian", tindakan: [Sampaikan ulang rubrik; umpan balik tujuh hari], waktu: [#w-ini, #w-setelah]),
  (judul: "Bimbingan dan materi", tindakan: [Tinjau proyek 15 menit; logbook; matriks materi], waktu: [#w-ini, #w-setelah, #w-depan]),
  (judul: "Fasilitas", tindakan: [Data kebutuhan server; server bersama dan jaringan], waktu: [#w-setelah, #w-depan]),
  (judul: "Pemahaman PBL", tindakan: [Jadwalkan sosialisasi; penyegaran dosen dan orientasi mahasiswa], waktu: [#w-setelah, #w-depan]),
  (judul: "Tingkat respons survei", tindakan: [Putusan buka kembali formulir; tindak lanjut di setiap kelas], waktu: [#w-ini, #w-depan]),
))

#signature()

#pagebreak(weak: true)

= Lampiran: Metode, Privasi, dan Keterbatasan

#sec-lampiran()
