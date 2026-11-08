// Presentasi hasil survei monev PBL untuk acara monev (dosen dan pimpinan, sekitar 15 menit).
// Semua angka diambil dari data/agregat.json dan data/tema.json, sama dengan laporan.
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
#let imp(lab) = pick(m.improve, lab)
#let th(k) = tema.themes.filter(t => t.key == k).first()
#let cepat = m.consult_resp.items.filter(i => i.label == "Kurang dari 1 hari").first().pct
#let us(lab) = tema.usulan.filter(x => x.label == lab).first().n
#let dsup(lab) = pick(l.support, lab).count
#let gap-top = A.gap.sorted(key: g => -g.gap).slice(0, 3)

#set document(title: "Hasil Survei Monev PBL TI dan SIB", author: koordinator.nama)
#set text(font: fonts, size: 22pt, lang: "id", fill: ink)
#set par(leading: 0.6em, spacing: 0.9em)
#show strong: set text(fill: primary)

#let slide(title, body, src: none) = {
  page(
    width: 33.867cm, height: 19.05cm, margin: (x: 2cm, top: 1.5cm, bottom: 1.9cm),
    footer: context [
      #set text(size: 12pt, fill: muted)
      #if src != none [Sumber: #src] else [Monev PBL · #periode] #h(1fr) #counter(page).display()
    ],
  )[
    #block(width: 100%, below: 0.5cm)[
      #set par(leading: 0.5em)
      #text(size: 30pt, weight: 700, fill: primary)[#title]
      #v(-0.1cm)
      #line(length: 100%, stroke: 1.2pt + accent)
    ]
    #body
  ]
}

// satu angka besar dengan keterangannya
#let big(num, label, color: primary) = block(width: 100%, inset: (x: 0pt, y: 4pt))[
  #text(size: 54pt, weight: 700, fill: color)[#num]
  #v(-0.45cm)
  #text(size: 19pt, fill: ink)[#label]
]

// batang horizontal sederhana (nilai 0..max)
#let hbar(items, max: 100, w: 12cm, color: primary, unit: "%", lw: auto, sz: 18pt, gut: 0.35cm, bh: 0.6cm) = {
  grid(columns: (lw, 1fr), column-gutter: 0.5cm, row-gutter: gut, align: (right + horizon, left + horizon),
    ..for it in items {
      (
        text(size: sz)[#it.at(0)],
        {
          let v = it.at(1)
          let c = if it.len() > 2 { it.at(2) } else { color }
          box(width: v / max * w, height: bh, fill: c)
          h(0.25cm)
          text(size: sz, weight: 700)[#if unit == "%" { pc(v) } else if unit == "n" { str(int(v)) } else { fmt(v, d: 2) }]
        },
      )
    }
  )
}

// satu baris usulan, dengan dasar dari hasil survei
#let usulan(waktu, pj, body, dasar: none) = block(width: 100%, inset: (x: 0.5cm, y: 0.3cm), fill: light-2, radius: 3pt)[
  #set text(size: 19pt)
  #set par(leading: 0.5em)
  #text(fill: accent-dark, weight: 700)[Usulan (#waktu).] #body #text(fill: muted, size: 15pt)[ Penanggung jawab: #pj.]
  #if dasar != none [
    #v(-0.15cm)
    #text(size: 15pt, fill: ink)[#text(weight: 700)[Dasar: ] #dasar]
  ]
]

#let dua(kiri, kanan, gap: 1.2cm) = grid(columns: (1fr, 1fr), column-gutter: gap, kiri, kanan)
#let judul-kecil(t, color: primary) = text(size: 17pt, weight: 700, fill: color, tracking: 0.03em)[#upper(t)]

// panel baik / bermasalah, lalu satu kalimat "Artinya"
#let bb(baik, buruk, arti: none) = {
  set list(spacing: 0.35cm, marker: [•])
  grid(columns: (1fr, 1fr), column-gutter: 0.8cm,
    block(width: 100%, inset: (x: 0.5cm, y: 0.4cm), stroke: (left: 4pt + primary), fill: light)[
      #text(size: 17pt, weight: 700, fill: primary, tracking: 0.03em)[YANG BAIK]
      #v(0.1cm)
      #set text(size: 19pt)
      #for x in baik [- #x]
    ],
    block(width: 100%, inset: (x: 0.5cm, y: 0.4cm), stroke: (left: 4pt + accent), fill: light-2)[
      #text(size: 17pt, weight: 700, fill: accent-dark, tracking: 0.03em)[YANG BERMASALAH]
      #v(0.1cm)
      #set text(size: 19pt)
      #show strong: set text(fill: accent-dark)
      #for x in buruk [- #x]
    ],
  )
  if arti != none {
    v(0.35cm)
    text(size: 21pt)[#text(weight: 700, fill: ink)[Artinya: ] #arti]
  }
}

// ================================================================ 1. judul
#page(width: 33.867cm, height: 19.05cm, margin: (x: 2.5cm, y: 2cm))[
  #image("assets/logo-polinema.png", height: 2.6cm)
  #v(1.6cm)
  #text(size: 20pt, fill: muted)[Monitoring dan Evaluasi PBL · #periode]
  #v(0.2cm)
  #text(size: 46pt, weight: 700, fill: primary)[Hasil Survei Monev PBL]
  #v(-0.3cm)
  #text(size: 30pt)[Program Studi Sarjana Terapan Teknik Informatika dan Sarjana Terapan Sistem Informasi Bisnis]
  #v(1fr)
  #line(length: 100%, stroke: 1.2pt + accent)
  #v(0.2cm)
  #text(size: 20pt)[#koordinator.nama, #koordinator.jabatan \ Jurusan Teknologi Informasi, Politeknik Negeri Malang]
]

// ================================================================ 2. responden
#slide("Responsnya rendah, dan jauh berbeda antara kelas yang dipantau dan yang tidak", src: [survei mahasiswa (n = #m.n dari #m.response.roster) dan dosen (n = #l.n dari #l.roster)])[
  #bb(
    (
      [Dosen: *#pc(l.rate, d: 1)* mengisi (#l.n dari #l.roster), hampir mencapai target.],
      [Di *#mo.enf.n_classes kelas yang dipantau*, respons mahasiswa *#pc(mo.enf.rate, d: 1)*.],
      [Jawaban kedua kelompok kelas hampir sama (skor pelaksanaan #fmt(mo.enf.stats.ops_mean, d: 2) dan #fmt(mo.oth.stats.ops_mean, d: 2)).],
    ),
    (
      [Mahasiswa: hanya *#pc(m.response.rate, d: 1)* (#m.n dari #m.response.roster); target 70%.],
      [Di *#mo.oth.n_classes kelas yang pengisiannya belum dipantau*, respons *#pc(mo.oth.rate, d: 1)*.],
      [Beberapa kelas, terutama TI Semester 5, hanya diisi sedikit mahasiswa.],
    ),
    arti: [tinggi rendahnya respons ditentukan oleh ada tidaknya pemantauan di kelas, bukan oleh isi jawaban. Temuan umum bisa dipercaya. Masalah khusus di kelas yang sedikit respondennya bisa terlewat. Rincian per kelas ada di slide berikutnya.],
  )
  #v(1fr)
  #usulan(w-depan, "Koordinator PBL, ketua kelas, dosen pengampu", dasar: [respons #pc(mo.enf.rate, d: 1) di kelas yang dipantau berbanding #pc(mo.oth.rate, d: 1) di kelas lain; sesi 10 menit adalah usulan koordinator.])[Formulir mahasiswa dipersingkat. Tiap kelas mengisinya dalam satu sesi 10 menit lewat kode QR.]
]

// ================================================================ 2b. respons per kelas
#let kelas-semua = m.response.classes
#let nol = kelas-semua.filter(c => c.n == 0).len()
#let dipantau = kelas-semua.filter(c => mo.classes.contains(c.label))
#let lainnya = kelas-semua.filter(c => not mo.classes.contains(c.label))
#let tile(c) = {
  let r = c.rate
  let bg = if c.n == 0 { luma(228) } else if r < 30 { accent.lighten(78%) } else if r < 70 { accent.lighten(35%) } else { primary }
  let fg = if r >= 70 { white } else { ink }
  box(width: 2.55cm, height: 1.75cm, fill: bg, radius: 2pt, stroke: if mo.classes.contains(c.label) { 2pt + ink } else { none }, inset: (x: 0.15cm, y: 0.12cm))[
    #set text(fill: fg)
    #set par(leading: 0.3em)
    #text(size: 12pt, weight: 700)[#c.label] \
    #text(size: 16pt, weight: 700)[#pc(c.rate)] \
    #text(size: 11pt)[#c.n dari #c.roster]
  ]
}
#slide(str(nol) + " dari " + str(kelas-semua.len()) + " kelas tidak punya responden, hanya " + str(kelas-semua.filter(c => c.rate >= 70).len()) + " kelas melewati target 70%", src: [survei mahasiswa, responden per kelas (n = #m.n dari #m.response.roster); target 70%])[
  #set par(spacing: 0.1cm, leading: 0.35em)
  #for sm in m.response.sems {
    let cs = kelas-semua.filter(c => c.prodi + " Semester " + str(c.sem) == sm.label)
    grid(columns: (4.3cm, 1fr), column-gutter: 0.3cm, align: horizon,
      [#text(size: 15pt, weight: 700)[#sm.label] \ #text(size: 13pt, fill: muted)[#sm.n dari #sm.roster · #pc(sm.rate, d: 1)]],
      grid(columns: cs.len() * (auto,), column-gutter: 0.12cm, ..cs.map(tile)),
    )
    v(0.05cm)
  }
  #v(0.15cm)
  #text(size: 13pt, fill: muted)[Abu-abu: tidak ada responden. Oranye muda: di bawah 30%. Oranye: 30–69%. Hijau: 70% atau lebih (target). Garis tebal: kelas yang dipantau langsung.]
  #v(0.35cm)
  #text(size: 20pt)[#text(weight: 700, fill: primary)[Baik: ] kelas yang dipantau langsung mengisi #pc(calc.min(..dipantau.map(c => c.rate))) sampai #pc(calc.max(..dipantau.map(c => c.rate))). SIB (#pc(d.sib.mhs.response.rate, d: 1)) lebih banyak yang mengisi daripada TI (#pc(d.ti.mhs.response.rate, d: 1)). \
  #text(weight: 700, fill: accent-dark)[Bermasalah: ] #nol dari #kelas-semua.len() kelas tidak punya responden, dan kelas lain, yang pengisiannya belum dipantau, paling tinggi #pc(calc.max(..lainnya.map(c => c.rate))). Hasil kelas yang sedikit respondennya baru gambaran awal.]
]

// ================================================================ 3. ringkasan
#slide("Ringkasan: manfaat PBL diakui, tetapi pelaksanaannya belum memuaskan", src: [survei mahasiswa (n = #m.n)])[
  #bb(
    (
      [*#pc(m.ben.at(0).pct_agree)* setuju PBL meningkatkan keterampilan teknis, *#pc(m.ben.at(2).pct_agree)* kesiapan kerja.],
      [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu.],
      [*#pc(cepat)* mengatakan dosen menjawab dalam kurang dari sehari.],
    ),
    (
      [Hanya *#pc(m.ben.at(3).pct_agree)* puas, dan hanya *#pc(m.ben.at(4).pct_agree)* setuju PBL dilanjutkan.],
      [*#pc(m.workload_heavy_pct)* menilai beban berat.],
      [Hanya *#pc(m.coord.at(1).ya)* menilai arahan antar dosen sama.],
    ),
    arti: [mahasiswa mengeluhkan cara pelaksanaan (beban, koordinasi antar dosen, fasilitas), bukan konsep PBL. Manfaat PBL mereka nilai tinggi.],
  )
]

// ================================================================ 4. manfaat vs kepuasan
#let jarak = calc.round(m.ben.at(0).pct_agree - m.ben.at(3).pct_agree)
#slide("Mahasiswa menghargai manfaatnya, tetapi belum puas menjalaninya", src: [survei mahasiswa (n = #m.n), butir manfaat dan kepuasan])[
  #hbar((
    ("Keterampilan teknis", m.ben.at(0).pct_agree),
    ("Kerja sama", m.ben.at(1).pct_agree),
    ("Kesiapan kerja", m.ben.at(2).pct_agree),
    ("Puas dengan pelaksanaan", m.ben.at(3).pct_agree, accent),
    ("Setuju dilanjutkan", m.ben.at(4).pct_agree, accent),
  ), w: 15cm)
  #v(0.2cm)
  #text(size: 16pt, fill: muted)[Persentase mahasiswa yang setuju atau sangat setuju. Hijau: baik. Oranye: bermasalah.]
  #v(1fr)
  #text(weight: 700)[Artinya: ] selisih #int(jarak) poin antara manfaat keterampilan teknis dan kepuasan menunjukkan masalahnya ada di pelaksanaan. Mahasiswa yang pernah ikut PBL sama puasnya dengan yang belum (#pc(m.by_experience.at(1).sat_agree) dan #pc(m.by_experience.at(0).sat_agree)). Jadi ini bukan masalah mahasiswa baru saja.
]

// ================================================================ 5. aspek
#slide("Pelaksanaan dan penilaian baik; keterpaduan antar mata kuliah dan beban bermasalah", src: [survei mahasiswa (n = #m.n), skor skala 1–5 dan pilihan masalah per aspek])[
  #let a = m.aspek
  #grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 0.6cm,
    ..for i in range(4) {
      let bad = i == 1 or i == 3
      (block(width: 100%, inset: 0.5cm, stroke: 1pt + (if bad { accent } else { primary }), radius: 3pt)[
        #text(size: 17pt, weight: 700, fill: if bad { accent-dark } else { primary })[#if bad [Bermasalah] else [Baik]]
        #v(-0.3cm)
        #text(size: 19pt, weight: 700)[#a.at(i).name]
        #v(0.2cm)
        #text(size: 40pt, weight: 700, fill: if bad { accent } else { primary })[#fmt(a.at(i).mhs_mean, d: 2)]
        #v(-0.4cm)
        #text(size: 16pt)[#pc(a.at(i).problem_pct) memilih masalah]
      ],)
    }
  )
  #v(1fr)
  #text(weight: 700)[Artinya: ] alur PBL sudah berjalan. Skor terendah ada pada keterpaduan antar mata kuliah. Masalah paling banyak dipilih mahasiswa di aspek kolaborasi, beban, dan dukungan.
]

// ================================================================ 6. beban
#slide("Beban: tugas di luar proyek membuat PBL terasa berat", src: [survei mahasiswa (n = #m.n) dan dosen (n = #l.n); komentar bebas tema beban (#th("beban").n)])[
  #bb(
    (
      [*#pc(m.workload.items.at(1).pct)* mahasiswa menilai beban sudah sesuai.],
      [Dosen menilai beban wajar: hanya *#pc(l.workload_heavy_pct)* menilainya berat.],
      [TI Semester 3 paling ringan: *#pc(m.sem_stats.at(0).berat)* menilai berat.],
    ),
    (
      [*#pc(m.workload_heavy_pct)* menilai beban berat; *#pc(m.material.at(0).pct)* mengatakan tugas mata kuliah menambah beban di luar proyek.],
      [SIB Semester 3: *#pc(m.sem_stats.at(2).berat)* menilai berat; TI Semester 5: *#pc(m.sem_stats.at(1).berat)*.],
      [Kepuasan #fmt(grp(beban, "Berat atau sangat berat").puas, d: 2) pada yang merasa berat, dibanding #fmt(grp(beban, "Ringan atau sesuai").puas, d: 2) pada yang tidak.],
    ),
    arti: [dosen hanya melihat satu mata kuliah, mahasiswa merasakan semuanya sekaligus: #th("beban").subs.first().n komentar menyebut tugas praktikum, jobsheet, atau tugas besar terpisah dari PBL.],
  )
  #v(1fr)
  #usulan(w-ini + ", lalu " + w-setelah, "Dosen pengampu, dosen rujukan", dasar: [#us("Kurangi atau gabungkan tugas di luar PBL") komentar mahasiswa meminta tugas dikurangi atau digabung; #pc(m.coord.at(3).pct_oa) mengalami tenggat bertabrakan. Batas dua hasil kerja per pekan: usulan koordinator.])[Tidak ada tugas baru di luar proyek selama pekan Milestone 2; lalu tenggat bertahap dan batas tugas di luar proyek.]
]

// ================================================================ 7. keselarasan
#slide("Keselarasan: dokumennya sudah sejalan dengan proyek, tugasnya baru setengah", src: [survei mahasiswa (n = #m.n) dan dosen (n = #l.n), butir keselarasan mata kuliah])[
  #bb(
    (
      [*#pc(m.pooled.bc.at(0).ya)* menjawab kontrak kuliah memuat kaitan dengan proyek.],
      [*#pc(m.pooled.bc.at(8).ya)* menjawab dosen tahu topik proyek tim.],
      [*#pc(pick(m.pooled.type, "Deliverable proyek").pct)* tugas utama berupa hasil kerja proyek.],
    ),
    (
      [Hanya *#pc(m.pooled.bc.at(3).ya)* menjawab tugas mata kuliah bagian dari proyek (dosen: *#pc(l.align.at(3).ya)*).],
      [*#pc(pick(m.pooled.type, "Latihan umum").pct)* tugas utama berupa latihan umum di luar proyek.],
      [Bobot nilai PBL tidak disampaikan pada *#pc(pick(m.pooled.share, "Tidak disampaikan").pct)* jawaban.],
    ),
    arti: [tugas yang tidak sejalan dengan proyek memicu keluhan beban, dan dosen mengakuinya.],
  )
  #v(1fr)
  #usulan(w-ini + ", lalu " + w-depan, "Dosen rujukan, dosen pengampu, Kaprodi", dasar: [hanya #pc(m.pooled.bc.at(3).ya) mahasiswa menjawab tugas mata kuliah bagian dari proyek; #pc(pick(m.pooled.share, "Tidak disampaikan").pct) menyebut bobot tidak disampaikan. Bobot minimal 51% adalah batas IKU 7; peta: usulan koordinator.])[Peta keterkaitan mata kuliah dan milestone, rubrik berbasis PBL, dan bobot PBL minimal 51% di RPS semua mata kuliah.]
]

// ================================================================ 7b. keselarasan per mata kuliah
#slide("Keselarasan per mata kuliah: empat mata kuliah dengan kegiatan PBL paling sedikit", src: [survei mahasiswa, butir kegiatan PBL tiap mata kuliah; mata kuliah dan semester sesuai plotting dosen Gasal 2026/2027])[
  #let cs = m.courses.sorted(key: c => c.acts_mean)
  #hbar(cs.enumerate().map(((i, c)) => (c.prodi + " Sem " + str(c.sem) + " · " + c.course, c.acts_mean, if i < 4 { accent } else { primary })), max: 100, w: 8cm, lw: 11cm, sz: 14pt, gut: 0.2cm, bh: 0.38cm)
  #v(1fr)
  #text(size: 15pt, fill: muted)[Persentase jawaban "ya" mahasiswa pada butir kegiatan PBL tiap mata kuliah. Oranye: empat terendah. PBL menyatukan tugas banyak mata kuliah dalam satu studi kasus besar. Jadi selisih antar mata kuliah di kelas yang sama berasal dari cara tugas dan rubrik dirancang, bukan dari ada tidaknya mata kuliah utama.]
]

// ================================================================ 8. koordinasi
#slide("Koordinasi antar dosen: mahasiswa merasakan akibatnya, dosen mengakui penyebabnya", src: [survei mahasiswa (n = #m.n) dan dosen (n = #l.n); komentar bebas tema koordinasi (#th("koordinasi").n)])[
  #bb(
    (
      [Dosen saling tahu topik proyek tim: *#pc(l.coord_yn.at(0).ya)*.],
      [Informasi dari koordinator jelas dan tepat waktu (*#fmt(l.ops_extra.at(2).mean, d: 2)* dari 5).],
      [*#pc(m.coord.at(2).ya)* mahasiswa tahu harus bertanya ke dosen siapa.],
    ),
    (
      [Hanya *#pc(m.coord.at(1).ya)* mahasiswa menilai arahan dosen sama; *#th("koordinasi").n komentar* membahasnya.],
      [Hanya *#pc(l.coord_yn.at(2).ya)* dosen punya kesepakatan peran; hanya *#l.meeting.items.at(0).count dari #l.n* selalu hadir di rapat.],
      [Hambatan dosen: beban mengajar dan administrasi (*#pick(l.barriers, "Beban mengajar dan administrasi lain").count*) dan tidak adanya jadwal rapat (*#pick(l.barriers, "Tidak ada jadwal rapat rutin").count*).],
    ),
    arti: [dua pihak melihat masalah yang sama. Penyebabnya ada pada cara kerja: tidak ada jadwal rapat dan pembagian peran.],
  )
  #v(1fr)
  #usulan(w-ini + ", lalu " + w-setelah, "Dosen rujukan, Koordinator PBL", dasar: [#dsup("Rapat koordinasi dosen rutin") dosen meminta rapat, tetapi hambatannya beban mengajar dan administrasi (#pick(l.barriers, "Beban mengajar dan administrasi lain").count). konfirmasi: usulan koordinator.])[Dosen rujukan tiap kelas dan catatan milestone di WhatsApp dengan konfirmasi singkat, tanpa rapat tambahan.]
]

// ================================================================ 9. penilaian dan kontribusi
#slide("Penilaian dan kontribusi: panduannya membantu, tetapi rubrik dan keadilan nilai belum meyakinkan", src: [survei mahasiswa (n = #m.n) dan dosen (n = #l.n); komentar bebas tema tim dan nilai])[
  #bb(
    (
      [*#pc(m.ops.at(1).pct_agree)* menilai SOP dan template membantu, skor tertinggi di butir pelaksanaan.],
      [Bimbingan dosen dinilai memadai oleh *#pc(m.ops.at(3).pct_agree)*.],
    ),
    (
      [Hanya *#pc(m.ops.at(5).pct_agree)* setuju rubrik jelas dan *#pc(m.ops.at(6).pct_agree)* setuju penilaian adil.],
      [*#pc(imp("Kontribusi anggota tim tidak seimbang").pct)* memilih kontribusi anggota yang tidak seimbang sebagai masalah.],
    ),
    arti: [rubrik yang jelas dan penilaian yang adil sangat berhubungan dengan kepuasan (r = #fmt(dr.corr.at(1).r_puas, d: 2) dan #fmt(dr.corr.at(2).r_puas, d: 2)). Kontribusi tim tidak bisa dibuktikan dari laporan.],
  )
  #v(1fr)
  #usulan(w-ini + ", lalu " + w-depan, "Dosen rujukan, dosen pengampu", dasar: [#us("Sediakan sistem pemantau progres dan kontribusi (termasuk milestone di LMS)") komentar meminta pemantauan kontribusi, dan #us("Buat nilai transparan dan umpan balik jelas") meminta nilai transparan; #dsup("Panduan dan contoh penilaian") dosen meminta panduan dan contoh penilaian. Draf SOP mengusulkan Penilaian 360 (masih dibahas).])[Penilaian 360 dengan bukti yang objektif, rubrik berbasis PBL beserta contoh, dan halaman informasi resmi per program studi.]
]

// ================================================================ 10. fasilitas dan bimbingan
#slide("Bimbingan cepat dan tersedia; fasilitas yang paling lemah", src: [survei mahasiswa (n = #m.n); komentar bebas tema fasilitas (#th("fasilitas").n) dan bimbingan (#th("bimbingan").n)])[
  #bb(
    (
      [*#pc(cepat)* mahasiswa mengatakan dosen menjawab dalam kurang dari sehari.],
      [Konsultasi biasanya dimulai oleh mahasiswa maupun dosen (*#pc(pick(m.consult_init.items, "Keduanya").pct)*).],
    ),
    (
      [Fasilitas bernilai terendah (*#fmt(m.ops.at(7).mean, d: 2)*), tetapi hubungannya dengan kepuasan paling kuat (r = #fmt(dr.corr.at(0).r_puas, d: 2)).],
      [*#pc(m.consult_freq.items.at(0).pct)* tim belum pernah berkonsultasi, dan #th("bimbingan").subs.first().n komentar menyebut sulit mendapat waktu.],
      [Semua komentar fasilitas (#th("fasilitas").n) dari SIB: server dan jaringan.],
    ),
    arti: [dosen cepat menanggapi, tetapi sebagian tim belum dibimbing. Fasilitas perlu keputusan di luar kelas.],
  )
  #v(1fr)
  #usulan(w-setelah + ", lalu " + w-depan, "Dosen pengampu; Koordinator PBL; laboratorium", dasar: [#us("Sediakan server kampus untuk deployment dan perbaiki jaringan") komentar meminta server dan jaringan; #pc(pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct) menyebut materi terlambat. Materi dua pekan sebelum milestone dan kredit cloud dulu: usulan koordinator.])[Materi dua pekan sebelum milestone dan sesi konsultasi terbuka; panduan deployment dengan kredit cloud dulu, server bersama kemudian.]
]

// ================================================================ 11. komentar
#slide("Komentar bebas: yang paling sering dikeluhkan adalah beban dan koordinasi", src: [komentar bebas mahasiswa TI dan SIB (#tema.substantive komentar bermakna)])[
  #let urut = tema.themes.filter(t => t.key != "perubahan").sorted(key: t => -t.n)
  #hbar(urut.map(t => (t.label, t.n, if t.key == "baik" { primary } else { accent })), max: 20, w: 8cm, unit: "n")
  #v(1fr)
  #text(size: 17pt, fill: muted)[Jumlah komentar per tema (TI dan SIB). Hijau: hal baik yang ingin dipertahankan (#th("baik").n komentar). Oranye: hal bermasalah. Komentar dikelompokkan tanpa identitas.]
  #v(0.2cm)
  #text(weight: 700)[Artinya: ] mahasiswa tidak menolak PBL. Mereka menyebut apa yang perlu diperbaiki. Selain itu, #tema.sib_info.n komentar SIB menyebut template dan jadwal yang dipakai berasal dari TI, bukan dari paket informasi SIB.
]

// ================================================================ 12. beda mahasiswa dan dosen
#slide("Dosen menilai lebih tinggi di semua butir; dua pihak melihat dari sudut yang berbeda", src: [butir yang sama pada survei mahasiswa (n = #m.n) dan dosen (n = #l.n)])[
  #table(
    columns: (1fr, auto, auto, auto), align: (left, center, center, center), stroke: none,
    inset: (x: 0.4cm, y: 0.3cm),
    table.hline(stroke: 1pt + primary),
    table.header(text(size: 17pt, fill: muted)[Butir dengan selisih terbesar], text(size: 17pt, fill: muted)[Mahasiswa], text(size: 17pt, fill: muted)[Dosen], text(size: 17pt, fill: muted)[Selisih]),
    table.hline(stroke: 0.5pt + border-c),
    ..for g in gap-top { (text(size: 19pt)[#g.label], text(size: 19pt)[#fmt(g.mhs_mean, d: 2)], text(size: 19pt)[#fmt(g.dosen_mean, d: 2)], text(size: 19pt, weight: 700, fill: accent-dark)[#sgn(g.gap)]) },
    table.hline(stroke: 1pt + primary),
  )
  #v(0.3cm)
  #text(weight: 700, fill: primary)[Baik: ] kedua pihak paling sepakat soal manfaat keterampilan teknis (selisih terkecil, #sgn(A.gap.at(8).gap)).
  #v(0.1cm)
  #text(weight: 700, fill: accent-dark)[Bermasalah: ] di SIB, dosen dan mahasiswa sama-sama menilai rubrik rendah (#fmt(SIB.gap.at(5).mhs_mean, d: 2) dan #fmt(SIB.gap.at(5).dosen_mean, d: 2)). Keselarasan tugas juga mereka nilai rendah (#fmt(SIB.gap.at(4).mhs_mean, d: 2) dan #fmt(SIB.gap.at(4).dosen_mean, d: 2)). Kalau dua pihak sepakat, itu tanda terkuat bahwa masalahnya nyata.
  #v(1fr)
  #usulan(w-ini, "Koordinator PBL, Kaprodi", dasar: [dosen menilai lebih tinggi pada #A.gap.len() dari #A.gap.len() butir yang bisa dibandingkan. Mengundang perwakilan mahasiswa adalah usulan koordinator.])[Selisih ini dibahas bersama dosen pengampu lewat WhatsApp atau satu pertemuan singkat.]
]

// ================================================================ 13-16. daftar lengkap masalah
#let masalah-kecil(lab) = lab in ("Tidak ada masalah berarti", "Tidak ada kendala")
#slide("Semua masalah yang dipilih mahasiswa, tanpa disaring", src: [survei mahasiswa (n = #m.n), pertanyaan pilihan masalah dan kendala materi; semua pilihan ditampilkan])[
  #dua(
    [
      #judul-kecil("Masalah yang dipilih (boleh lebih dari satu)", color: accent-dark)
      #v(0.2cm)
      #hbar(m.improve.map(x => (x.label, x.pct, if masalah-kecil(x.label) { muted } else { accent })), max: 45, w: 3cm, lw: 9cm, sz: 14pt, gut: 0.22cm, bh: 0.4cm)
    ],
    [
      #judul-kecil("Kendala materi dan koordinasi", color: accent-dark)
      #v(0.2cm)
      #hbar(
        m.material.map(x => (x.label, x.pct, if masalah-kecil(x.label) { muted } else { accent }))
          + ((m.coord.at(3).label + " (sering atau selalu)", m.coord.at(3).pct_oa, accent), (m.coord.at(4).label + " (sering atau selalu)", m.coord.at(4).pct_oa, accent)),
        max: 70, w: 3cm, lw: 9cm, sz: 14pt, gut: 0.22cm, bh: 0.4cm)
      #v(0.3cm)
      #text(size: 15pt, fill: muted)[Abu-abu: jawaban "tidak ada masalah atau kendala". Persentase dihitung dari #m.n mahasiswa.]
    ],
  )
]

#slide("Semua masalah dari sisi dosen, tanpa disaring", src: [survei dosen (n = #l.n), pertanyaan hal yang perlu diperbaiki, hambatan koordinasi, dan hambatan materi; semua pilihan ditampilkan])[
  #dua(
    [
      #judul-kecil("Hal yang perlu diperbaiki (jumlah dosen)", color: accent-dark)
      #v(0.2cm)
      #hbar(l.improve.map(x => (x.label, x.count)), max: 12, w: 2.6cm, unit: "n", color: accent, lw: 9.2cm, sz: 14pt, gut: 0.22cm, bh: 0.4cm)
    ],
    [
      #judul-kecil("Hambatan koordinasi antar dosen", color: accent-dark)
      #v(0.2cm)
      #hbar(l.barriers.map(x => (x.label, x.count, if masalah-kecil(x.label) { muted } else { accent })), max: 20, w: 2.6cm, unit: "n", lw: 9.2cm, sz: 14pt, gut: 0.22cm, bh: 0.4cm)
      #v(0.3cm)
      #judul-kecil("Hambatan dalam menyesuaikan materi", color: accent-dark)
      #v(0.2cm)
      #hbar(l.material_barriers.map(x => (x.label, x.count, if masalah-kecil(x.label) { muted} else { accent })), max: 20, w: 2.6cm, unit: "n", lw: 9.2cm, sz: 14pt, gut: 0.22cm, bh: 0.4cm)
    ],
  )
]

#slide("Semua butir penilaian: mahasiswa dan dosen", src: [butir yang sama pada survei mahasiswa (n = #m.n) dan dosen (n = #l.n); persentase setuju atau sangat setuju])[
  #table(
    columns: (1fr, auto, auto, auto), align: (left, center, center, center), stroke: none,
    inset: (x: 0.35cm, y: 0.17cm),
    table.hline(stroke: 1pt + primary),
    table.header(text(size: 15pt, fill: muted)[Butir], text(size: 15pt, fill: muted)[Mahasiswa setuju], text(size: 15pt, fill: muted)[Dosen setuju], text(size: 15pt, fill: muted)[Selisih skor]),
    table.hline(stroke: 0.5pt + border-c),
    ..for g in A.gap.sorted(key: g => g.mhs_agree) { (text(size: 16pt)[#g.label], text(size: 16pt, weight: 700, fill: if g.mhs_agree < 50 { accent-dark } else { ink })[#pc(g.mhs_agree)], text(size: 16pt)[#pc(g.dosen_agree)], text(size: 16pt)[#sgn(g.gap)]) },
    table.hline(stroke: 1pt + primary),
  )
  #v(0.2cm)
  #text(size: 15pt, fill: muted)[Diurutkan dari persetujuan mahasiswa yang paling rendah. Oranye: kurang dari separuh mahasiswa setuju.]
]

#slide("Semua tema komentar bebas mahasiswa, termasuk yang kecil", src: [komentar bebas mahasiswa TI dan SIB (#tema.substantive komentar bermakna), dikelompokkan per tema dan subtema])[
  #set text(size: 14.5pt)
  #set par(leading: 0.4em, spacing: 0.35em)
  #columns(2, gutter: 1cm)[
    #for t in tema.themes.sorted(key: t => -t.n) [
      #block(breakable: false, below: 0.3cm)[
        #text(weight: 700, fill: if t.key == "baik" { primary } else { accent-dark })[#t.label] #text(fill: muted)[(#t.n; TI #t.ti, SIB #t.sib)]
        #for sub in t.subs [\ #h(0.4cm)– #sub.label (#sub.n)]
      ]
    ]
  ]
]

#slide("Semua komentar bebas dosen, termasuk usulan satu orang", src: [isian terbuka survei dosen (#tema-dosen.input isian dari #tema-dosen.penulis.n dari #l.n dosen), ditulis ulang dengan kata lain, tanpa kutipan])[
  #text(size: 15pt, fill: muted)[Jumlahnya kecil, jadi ini usulan, bukan pendapat seluruh dosen. Dosen yang mengampu di dua program studi dihitung di keduanya.]
  #v(0.2cm)
  #set text(size: 15.5pt)
  #set par(leading: 0.4em, spacing: 0.3em)
  #columns(2, gutter: 1cm)[
    #for t in tema-dosen.themes [
      #block(breakable: false, below: 0.35cm)[
        #text(weight: 700, fill: if t.kind == "baik" { primary } else { accent-dark })[#t.label] #text(fill: muted)[(#t.n dosen; TI #t.ti, SIB #t.sib)]
        #for sb in t.subs [\ #h(0.4cm)– #sb.label]
      ]
    ]
  ]
]

// ================================================================ 13. usulan responden
#slide("Yang diminta responden sendiri", src: [komentar bebas mahasiswa (usulan, n per usulan) dan survei dosen (n = #l.n, dukungan dan hambatan)])[
  #dua(
    [
      #judul-kecil("Usulan mahasiswa (jumlah komentar)")
      #v(0.3cm)
      #hbar(tema.usulan.slice(0, 6).map(x => (x.label, x.n)), max: 10, w: 2.2cm, unit: "n", lw: 9.2cm)
    ],
    [
      #judul-kecil("Dukungan yang diminta dosen (dari " + str(l.n) + ")")
      #v(0.3cm)
      #hbar(l.support.slice(0, 5).map(x => (x.label, x.count)), max: 12, w: 2.2cm, unit: "n", color: primary-mid, lw: 9.2cm)
      #v(0.4cm)
      #judul-kecil("Hambatan yang disebut dosen", color: accent-dark)
      #v(0.3cm)
      #hbar(l.barriers.slice(0, 3).map(x => (if x.label.starts-with("Tidak ada pembagian peran") { "Tidak ada pembagian peran jelas antar dosen" } else { x.label }, x.count)), max: 20, w: 2.2cm, unit: "n", color: accent, lw: 9.2cm)
    ],
  )
]

// ================================================================ 14. tindak lanjut
#slide("Tindak lanjut menurut waktu, beserta sumber tiap langkah", src: [usulan mahasiswa (M), permintaan dosen (D), dan usulan koordinator (K); angkanya ada di slide 7–20])[
  #grid(columns: (1fr, 1fr, 1fr), column-gutter: 0.7cm,
    ..(
      (w-ini, accent, (
        ([K], [Umumkan ringkasan hasil, lalu bahas dengan dosen pengampu lewat WhatsApp atau satu pertemuan singkat.]),
        ([D], [Umumkan dosen rujukan (PIC) tiap kelas.]),
        ([M], [Ulangi bobot nilai dan ketentuan Milestone 2.]),
        ([M], [Tidak ada tugas baru di luar proyek.]),
      )),
      (w-setelah, primary, (
        ([K], [Susun draf juknis PBL Jurusan; koordinator melapor tiap milestone.]),
        ([D, K], [Catatan milestone di WhatsApp dengan konfirmasi, tanpa rapat tambahan.]),
        ([M, K], [Peta keterkaitan mata kuliah dan milestone, tenggat bertahap.]),
        ([D, M], [Penilaian 360 dengan bukti; rubrik beserta contoh.]),
      )),
      (w-depan, primary-mid, (
        ([K], [Juknis terbit; bobot PBL minimal 51% di RPS 13 mata kuliah (IKU 7).]),
        ([M], [Halaman informasi per program studi; aturan tim dengan peran jelas.]),
        ([M, K], [Materi dua pekan sebelum milestone; fasilitas: kredit cloud dulu.]),
        ([D], [Apresiasi untuk dosen dan penghargaan untuk produk PBL.]),
      )),
    ).map(c => block(width: 100%, stroke: (top: 4pt + c.at(1)), inset: (top: 0.4cm))[
      #text(size: 22pt, weight: 700, fill: c.at(1))[#c.at(0)]
      #set text(size: 19pt)
      #for it in c.at(2) [#block(below: 0.45cm)[#text(size: 15pt, weight: 700, fill: muted)[\[#it.at(0)\]] #it.at(1)]]
    ])
  )
  #v(1fr)
  #text(size: 16pt, fill: muted)[Pekan Milestone 2 sudah dekat, jadi perubahan besar belum bisa berlaku sebelum itu. Keputusan menunda Milestone 2 ada pada Ketua Jurusan dan Kaprodi.]
]

// ================================================================ 15. permintaan
#slide("Yang kami mohon dari Bapak/Ibu dosen", src: [survei mahasiswa dan dosen, sesuai slide 7, 10, dan 20])[
  #set text(size: 24pt)
  #set enum(spacing: 0.9cm)
  + Bersedia menjadi dosen rujukan (PIC) untuk kelas yang diampu. Nama Bapak/Ibu akan kami umumkan ke mahasiswa. \
    #text(size: 17pt, fill: muted)[Dasar: #dsup("PIC dosen per kelas") dari #l.n dosen meminta PIC, dan hanya #pc(l.coord_yn.at(3).ya) dosen menyatakan dosen rujukan utama tim sudah jelas.]
  + Tidak menambah tugas baru di luar proyek selama pekan Milestone 2, dan menjelaskan ulang bobot nilai serta rubrik di kelas. \
    #text(size: 17pt, fill: muted)[Dasar: #pc(m.material.at(0).pct) mahasiswa menyebut tugas menambah beban; bobot tidak disampaikan pada #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban.]
  + Mengonfirmasi catatan milestone dari dosen rujukan di WhatsApp dengan reaksi atau satu kata, lalu melengkapi bagian mata kuliah Bapak/Ibu pada peta keterkaitan. Tidak ada rapat tambahan. \
    #text(size: 17pt, fill: muted)[Dasar: #pick(l.wa.items, "Membaca tetapi jarang menanggapi").count dari #l.n dosen hanya membaca grup, dan hambatan utamanya adalah beban mengajar dan administrasi (#pick(l.barriers, "Beban mengajar dan administrasi lain").count).]
  #v(1fr)
  #line(length: 100%, stroke: 1.2pt + accent)
  #text(size: 26pt, weight: 700, fill: primary)[Diskusi: menurut Bapak/Ibu, apa yang paling perlu didahulukan?]
]
