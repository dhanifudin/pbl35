// Shared styling, helpers and section builders for the three Monev PBL reports.
// Data: data/agregat.json (anonymous aggregates) and data/tema.json (coded student comments).

#let d = json("data/agregat.json")
#let tema = json("data/tema.json")
#let tema-dosen = json("data/tema_dosen.json")

// ---------------------------------------------------------------- people (edit here)
#let tanggal = "7 November 2026"
#let bulan-tahun = "November 2026"
#let periode = "Semester Ganjil 2026/2027"
#let koordinator = (nama: "Dian Hanifudin Subhi, S.Kom., M.Kom.", jabatan: "Koordinator PBL TI")
#let kajur = (nama: "Mungki Astiningrum, S.T., M.Kom.", jabatan: "Ketua Jurusan Teknologi Informasi")
#let kaprodi-ti = (nama: "Dr. Ely Setyo Astuti, S.T., M.T.", jabatan: "Ketua Program Studi Sarjana Terapan Teknik Informatika")
#let kaprodi-sib = (nama: "Hendra Pradibta, S.E., M.Sc.", jabatan: "Ketua Program Studi Sarjana Terapan Sistem Informasi Bisnis")

// time horizons for every recommendation
#let w-ini = "Minggu ini"
#let w-setelah = "Setelah Milestone 2"
#let w-depan = "Semester depan"

// ---------------------------------------------------------------- palette
#let primary = rgb("#0f5f4c")
#let primary-mid = rgb("#3f8f78")
#let accent = rgb("#c65a2e")
#let accent-dark = rgb("#8f3f1d")
#let light = rgb("#e9f3ef")
#let light-2 = rgb("#f9ece4")
#let border-c = rgb("#c3d8cf")
#let ink = rgb("#1c2420")
#let muted = rgb("#5d6b65")
// diverging 1..5: strongly disagree .. strongly agree
#let lk-colors = (rgb("#b8442b"), rgb("#e39b6f"), rgb("#d9d9d3"), rgb("#7fb7a4"), rgb("#0f5f4c"))
#let fonts = ("Carlito", "Liberation Sans")

// ---------------------------------------------------------------- formatting
#let fmt(x, d: 1) = {
  if x == none { return "–" }
  let s = str(calc.round(float(x), digits: d))
  let parts = s.split(".")
  let frac = if parts.len() > 1 { parts.at(1) } else { "" }
  while frac.len() < d { frac = frac + "0" }
  if d == 0 { parts.at(0) } else { parts.at(0) + "," + frac }
}
#let pc(x, d: 0) = fmt(x, d: d) + "%"
#let sgn(x) = if x == none { "–" } else if x > 0.004 { "+" + fmt(x, d: 2) } else { fmt(x, d: 2) }
// show survey option labels in plain Indonesian ("deliverable" -> "hasil kerja")
#let tr(s) = s.replace("Deliverable proyek PBL", "Hasil kerja proyek PBL (deliverable)").replace("Deliverable proyek", "Hasil kerja proyek (deliverable)").replace("deliverable proyek", "hasil kerja proyek")
#let pick(items, label) = {
  let f = items.filter(i => i.label == label)
  if f.len() > 0 { f.first() } else { (label: label, count: 0, pct: 0.0) }
}

// ---------------------------------------------------------------- emphasis helpers
#let issue(body) = text(weight: 700, fill: accent-dark)[#body]
#let good(body) = text(weight: 700, fill: primary)[#body]

// ---------------------------------------------------------------- building blocks
#let chip(txt, fill, color: white) = box(inset: (x: 5pt, y: 2pt), radius: 2pt, fill: fill, baseline: 2pt)[#text(size: 8.5pt, fill: color, weight: 700)[#txt]]

#let cat-chip(c) = {
  if c == "Sangat baik" { chip(c, primary) }
  else if c == "Baik" { chip(c, primary-mid) }
  else if c == "Cukup" { chip(c, rgb("#e8c872"), color: ink) }
  else if c == "Kurang" { chip(c, accent) }
  else { chip(c, rgb("#b8442b")) }
}

#let tile(value, label, sub: none, color: primary) = block(width: 100%, inset: 11pt, radius: 4pt, fill: light, stroke: 0.5pt + border-c)[
  #set par(justify: false)
  #text(size: 20pt, weight: 700, fill: color)[#value] \
  #text(size: 9pt)[#label]
  #if sub != none [ \ #text(size: 8pt, fill: muted)[#sub]]
]
#let tiles(..items) = block(above: 12pt, below: 12pt, grid(columns: items.pos().len() * (1fr,), column-gutter: 8pt, ..items.pos()))

#let callout(title, body, color: accent) = block(width: 100%, inset: 12pt, radius: 3pt, fill: light-2, stroke: (left: 3pt + color), breakable: false, above: 14pt, below: 12pt)[
  #set par(justify: false)
  #text(weight: 700, fill: accent-dark)[#title] \
  #v(2pt)
  #body
]

// interpretation of a data block (write the body as short bullets)
#let apa-artinya(body) = block(width: 100%, inset: (x: 12pt, y: 10pt), radius: 3pt, fill: rgb("#eef1f4"), stroke: (left: 3pt + rgb("#4a6a85")), above: 14pt, below: 12pt, breakable: false)[
  #set par(justify: false)
  #text(weight: 700, fill: rgb("#2f4b63"), size: 10pt, tracking: 0.5pt)[APA ARTINYA]
  #v(3pt)
  #body
]

// the coordinator's concrete recommendation(s) for the issue just discussed
#let rekom-box(..items) = block(width: 100%, inset: 12pt, radius: 3pt, fill: rgb("#e3f1ea"), stroke: (left: 3pt + primary), above: 14pt, below: 14pt)[
  #set par(justify: false)
  #text(size: 9pt, weight: 700, fill: primary, tracking: 1pt)[REKOMENDASI KOORDINATOR PBL TI]
  #for it in items.pos() [
    #block(above: 9pt, below: 0pt)[
      #grid(columns: (12pt, 1fr), [#text(fill: primary)[▪]], [
        #it.aksi \
        #text(size: 9pt, fill: muted)[*#it.waktu* · Penanggung jawab: #it.pj#if it.at("indikator", default: none) != none [ · Indikator: #it.indikator]]
      ])
    ]
  ]
]

// good and bad stated directly, at the top of a section
#let baik-buruk(baik: (), buruk: ()) = {
  let panel(title, items, col) = block(width: 100%, inset: 12pt, radius: 3pt, stroke: 1.2pt + col, breakable: false)[
    #set par(justify: false)
    #text(weight: 700, size: 10.5pt, fill: col, tracking: 0.5pt)[#upper(title)]
    #for it in items [
      #block(above: 8pt, below: 0pt)[#grid(columns: (12pt, 1fr), [#text(fill: col)[▪]], [#it])]
    ]
  ]
  block(above: 12pt, below: 12pt, breakable: false, grid(columns: (1fr, 1fr), column-gutter: 12pt,
    panel("Yang baik", baik, primary), panel("Yang bermasalah", buruk, accent)))
}

// decision note about timing
#let keputusan() = callout("Catatan: waktu pelaksanaan dan keputusan yang dibutuhkan", [
  Milestone 2 berlangsung pekan depan. Perbaikan yang mengubah cara kerja tidak akan selesai sebelum itu. Contohnya Juknis, peta keterkaitan mata kuliah, bobot PBL di RPS, rubrik, aturan tim, dan fasilitas. Karena itu rekomendasi dibagi menjadi tiga waktu: *#w-ini* (hanya langkah komunikasi yang bisa dilakukan sebelum Milestone 2), *#w-setelah*, dan *#w-depan*.

  #v(4pt)
  Perbaikan itu baru bisa berlaku pada Milestone 2 kalau Milestone 2 ditunda. Keputusan ada pada Ketua Jurusan dan Kaprodi. Laporan ini menganggap Milestone 2 tetap sesuai jadwal. Kalau ditunda, langkah "#w-setelah" bisa dimajukan.

  #v(4pt)
  Ada dua keputusan yang perlu diambil sebelum semester depan. Pertama, menerbitkan Juknis PBL Jurusan. Kedua, menetapkan bobot PBL minimal 51% (skema PBL menurut IKU 7) di RPS semua mata kuliah PBL. Keputusan kedua butuh revisi RPS dan kesepakatan dosen.
], color: accent-dark)

#let note(body) = text(size: 9pt, fill: muted)[#body]
#let subhead(t) = block(above: 16pt, below: 7pt, sticky: true)[#text(weight: 700, size: 11pt, fill: primary)[#t]]
#let quote-block(text-, tag) = block(above: 8pt, below: 8pt, inset: (left: 10pt), stroke: (left: 1.5pt + border-c))[
  #set par(justify: false)
  #text(style: "italic")[“#text-”] #h(3pt) #text(size: 8.5pt, fill: muted)[(#tag)]
]

// horizontal bars from [{label, pct}], pct in 0..100
#let bars(items, color: primary, max: 100) = grid(
  columns: (1fr, 66pt, 30pt), column-gutter: 8pt, row-gutter: 8pt,
  align: (left + horizon, left + horizon, right + horizon),
  ..for it in items {
    (
      text(size: 9pt)[#set par(justify: false); #it.label],
      box(width: 100%, height: 9pt, fill: light, radius: 1pt)[#box(width: calc.min(it.pct, max) / max * 100%, height: 9pt, fill: color, radius: 1pt)],
      text(size: 9.5pt)[#pc(it.pct)],
    )
  },
)

// stacked 1..5 distribution bar from counts
#let lbar(dist, w: 78pt) = {
  let tot = dist.sum()
  if tot == 0 { return [] }
  box(width: w, height: 9pt, clip: true, radius: 1.5pt, grid(
    columns: dist.map(v => v * 1fr), rows: 9pt,
    ..range(5).map(i => rect(width: 100%, height: 9pt, fill: lk-colors.at(i), stroke: none)),
  ))
}

#let lk-legend() = block(above: 8pt, below: 4pt)[#note[Sebaran jawaban: #for i in range(5) [#box(width: 7pt, height: 7pt, fill: lk-colors.at(i), baseline: 0pt) #(i + 1)#if i < 4 [ #h(4pt)]] (1 sangat tidak setuju, 5 sangat setuju).]]

#let rate-bar(r) = box(width: 100%, height: 10pt)[
  #box(width: 100%, height: 10pt, fill: light, radius: 1pt)
  #place(top + left, box(width: r * 1%, height: 10pt, fill: if r >= 70 { primary } else { accent }, radius: 1pt))
  #place(top + left, dx: 70%, line(start: (0pt, -1pt), end: (0pt, 11pt), stroke: 0.9pt + ink))
]

#let topn(items, n, skip: ("Lainnya",)) = {
  let f = items.filter(i => not skip.contains(i.label))
  f.slice(0, calc.min(n, f.len()))
}

// two distributions side by side (students vs lecturers), labels matched by text
#let cmp-dist(title, a, b) = {
  let labs = a.map(i => i.label)
  for i in b { if not labs.contains(i.label) { labs.push(i.label) } }
  let g(items, l) = { let f = items.filter(i => i.label == l); if f.len() > 0 { f.first().pct } else { 0.0 } }
  table(
    columns: (1fr, 52pt, 52pt), align: (left, center, center),
    table.header[#title][Mahasiswa][Dosen],
    ..for l in labs { (l, pc(g(a, l)), pc(g(b, l))) },
  )
}

// ---------------------------------------------------------------- cover, front matter, page setup
#let cover(scope-label, kepada) = page(margin: (x: 2.6cm, y: 2.6cm), header: none, footer: none, numbering: none)[
  #set text(font: fonts, fill: ink, lang: "id")
  #set par(justify: false)
  #block(width: 100%, height: 100%)[
    #text(size: 10pt, tracking: 2.4pt, weight: 600, fill: muted)[LAPORAN MONITORING DAN EVALUASI]
    #v(1.6cm)
    #text(size: 36pt, weight: 700)[Laporan Hasil \ Survei Monev PBL]
    #v(7mm)
    #line(length: 100%, stroke: 1pt + ink)
    #v(7mm)
    #text(size: 17pt, weight: 600)[#scope-label] \
    #v(3pt)
    #text(size: 12.5pt, fill: muted)[Pelaksanaan Project-Based Learning · #periode]
    #v(1fr)
    #grid(columns: (74pt, 1fr), row-gutter: 10pt,
      text(size: 9.5pt, fill: muted, weight: 600)[Kepada], text(size: 11pt)[#kepada.nama \ #text(size: 10pt, fill: muted)[#kepada.jabatan]],
      text(size: 9.5pt, fill: muted, weight: 600)[Disusun oleh], text(size: 11pt)[#koordinator.nama \ #text(size: 10pt, fill: muted)[#koordinator.jabatan]],
    )
    #v(1.8cm)
    #grid(columns: (auto, 1fr), column-gutter: 14pt,
      image("assets/logo-polinema.png", width: 2.4cm),
      align(horizon)[#text(size: 13.5pt, weight: 700)[Politeknik Negeri Malang] \ #text(size: 11pt, fill: muted)[Jurusan Teknologi Informasi]],
    )
    #v(8mm)
    #text(size: 11pt, fill: muted)[#bulan-tahun]
  ]
]

#let pengantar(scope-label, kepada) = page(header: none, footer: none, numbering: none, margin: (x: 2.6cm, top: 2.6cm, bottom: 2.2cm))[
  #set text(font: fonts, size: 11pt, fill: ink, lang: "id")
  #set par(justify: true, leading: 0.75em, spacing: 1.2em)
  #text(size: 10pt, weight: 700, fill: accent-dark, tracking: 1.5pt)[PENGANTAR]
  #v(8pt)
  #table(
    columns: (70pt, 1fr), stroke: none, inset: (x: 0pt, y: 4pt), fill: none,
    text(weight: 700)[Kepada], [#kepada.nama, #kepada.jabatan],
    text(weight: 700)[Dari], [#koordinator.nama, #koordinator.jabatan],
    text(weight: 700)[Tanggal], [#tanggal],
    text(weight: 700)[Perihal], [Hasil survei monitoring dan evaluasi (monev) pelaksanaan PBL, #scope-label, #periode],
  )
  #v(4pt)
  #line(length: 100%, stroke: 0.5pt + border-c)
  #v(6pt)
  Laporan ini memuat hasil survei monev PBL dari mahasiswa dan dosen pengampu, sebagai dasar tindak lanjut. Setiap bagian langsung menyebut *apa yang baik* dan *apa yang bermasalah*, lalu menjelaskan artinya dan memberi rekomendasi.

  Cara membaca laporan ini:
  #v(4pt)
  #grid(columns: (auto, 1fr), column-gutter: 12pt, row-gutter: 14pt,
    box(width: 5pt, height: 34pt, fill: primary), [*Yang baik dan yang bermasalah.* Dua kotak di awal setiap bagian memuat temuan utama dan angkanya.],
    box(width: 5pt, height: 34pt, fill: rgb("#4a6a85")), [*Apa artinya.* Penjelasan singkat tentang arti temuan dan kaitannya dengan temuan lain.],
    box(width: 5pt, height: 34pt, fill: accent), [*Rekomendasi Koordinator PBL TI.* Langkah untuk setiap masalah, lengkap dengan waktu (minggu ini, setelah Milestone 2, atau semester depan), penanggung jawab, dan indikator. "Dosen rujukan (PIC)" adalah dosen yang ditunjuk sebagai tempat bertanya bagi tim.],
  )
]

#let daftar-isi() = page(header: none, footer: none, numbering: none, margin: (x: 2.6cm, top: 2.6cm, bottom: 2.2cm))[
  #set text(font: fonts, size: 11pt, fill: ink, lang: "id")
  #show outline.entry.where(level: 1): it => { v(6pt); strong(it) }
  #outline(title: [Daftar Isi], depth: 2, indent: 16pt)
]

#let report(scope-label, kepada, body) = {
  cover(scope-label, kepada)
  pengantar(scope-label, kepada)
  daftar-isi()
  set page(
    paper: "a4", margin: (x: 2.3cm, top: 2.4cm, bottom: 2.2cm), numbering: "1",
    header: context [
      #set text(size: 9pt, fill: muted)
      Laporan Hasil Survei Monev PBL · #scope-label · #periode
      #v(-4pt) #line(length: 100%, stroke: 0.4pt + border-c)
    ],
    footer: context [
      #set text(size: 9pt, fill: muted)
      #align(right)[#counter(page).display()]
    ],
  )
  counter(page).update(1)
  set text(font: fonts, size: 11pt, fill: ink, lang: "id")
  set par(justify: true, leading: 0.75em, spacing: 1.2em)
  set heading(numbering: (..n) => if n.pos().len() == 1 { str(n.pos().first()) + "." } else { n.pos().map(str).join(".") })
  show heading.where(level: 1): it => block(above: 26pt, below: 14pt, breakable: false)[
    #text(size: 15pt, weight: 700, fill: primary)[#it]
    #v(-6pt) #line(length: 100%, stroke: 0.8pt + primary)
  ]
  show heading.where(level: 2): it => block(above: 20pt, below: 9pt, sticky: true)[#text(size: 12.5pt, weight: 700, fill: primary)[#it]]
  set table(
    stroke: (x, y) => (bottom: 0.4pt + border-c),
    inset: (x: 5pt, y: 5.5pt),
    fill: (x, y) => if y == 0 { light } else { none },
  )
  show table: set text(size: 9.5pt)
  show table: set par(justify: false)
  show table.cell.where(y: 0): set text(weight: 700, size: 9pt)
  set list(indent: 6pt, body-indent: 7pt, spacing: 0.9em)
  set enum(indent: 6pt, body-indent: 7pt, spacing: 0.9em)
  body
}

#let signature() = {
  v(14pt)
  block(breakable: false)[
    #align(right)[
      #block(width: 7.6cm)[
        #align(left)[
          Malang, #tanggal \
          #koordinator.jabatan,
          #v(1.5cm)
          *#koordinator.nama*
        ]
      ]
    ]
  ]
}

// ---------------------------------------------------------------- section builders (scope key: "all" | "ti" | "sib")

#let sec-coverage(s, lead: none, with-classes: false) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  lead
  table(
    columns: (1.1fr, auto, auto, auto, 1.3fr), align: (left, right, right, right, left),
    table.header[Kelompok][Responden][Populasi][Tingkat respons][Dibanding target 70% (garis)],
    ..for r in m.response.sems { (r.label, str(r.n), str(r.roster), pc(r.rate, d: 1), rate-bar(r.rate)) },
    [*Mahasiswa (total)*], [*#m.n*], [*#m.response.roster*], [*#pc(m.response.rate, d: 1)*], rate-bar(m.response.rate),
    [*Dosen pengampu PBL*], [*#l.n*], [*#l.roster*], [*#pc(l.rate, d: 1)*], rate-bar(l.rate),
  )
  note[Jumlah mahasiswa diambil dari rekap nilai tengah semester tiap kelas. Jumlah dosen adalah dosen yang berbeda, yang mengampu 13 mata kuliah PBL menurut plotting dosen Gasal 2026/2027. Dosen yang mengampu di dua program studi dihitung sekali. #m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas tidak punya responden sama sekali.]
  if with-classes {
    let cl = m.response.classes
    let mon = m.monitored.classes
    let mk(sem) = table(
      columns: (1fr, auto, auto, auto), align: (left, right, right, right),
      table.header[Kelas][Resp.][Mhs][%],
      ..for c in cl.filter(c => c.sem == sem) { (if mon.contains(c.label) { c.label + " ●" } else { c.label }, str(c.n), str(c.roster), pc(c.rate)) },
    )
    v(8pt)
    let sems = cl.map(c => c.sem).dedup()
    grid(columns: sems.len() * (1fr,), column-gutter: 16pt, ..sems.map(sm => [#text(weight: 700, size: 9.5pt)[Semester #sm]#v(3pt)#mk(sm)]))
    note[● kelas yang diampu Koordinator PBL TI. Di kelas ini pengisian survei diingatkan dan dipantau langsung.]
  }
}

// peta kelas: satu petak per kelas dengan tingkat responsnya (scope: "all" | "ti" | "sib")
#let sec-kelas(s) = {
  let m = d.at(s).mhs
  let cl = m.response.classes
  let mon = m.monitored.classes
  let nmax = calc.max(..m.response.sems.map(x => x.classes))
  let tile(c) = {
    let bg = if c.n == 0 { luma(228) } else if c.rate < 30 { accent.lighten(78%) } else if c.rate < 70 { accent.lighten(35%) } else { primary }
    let fg = if c.rate >= 70 { white } else { ink }
    block(width: 100%, height: 1.2cm, fill: bg, radius: 2pt, stroke: if mon.contains(c.label) { 1.6pt + ink } else { none }, inset: (x: 0.1cm, y: 0.07cm))[
      #set text(fill: fg)
      #set par(leading: 0.2em, justify: false)
      #text(size: 6.6pt, weight: 700)[#c.label] \
      #text(size: 9pt, weight: 700)[#pc(c.rate)] \
      #text(size: 6.4pt)[#c.n dari #c.roster]
    ]
  }
  block(breakable: false)[
  #v(6pt)
  #for sm in m.response.sems {
    let cs = cl.filter(c => c.prodi + " Semester " + str(c.sem) == sm.label)
    grid(columns: (2.7cm, 1fr), column-gutter: 4pt, align: horizon,
      [#text(weight: 700, size: 9pt)[#sm.label] \ #text(size: 7.5pt, fill: muted)[#sm.n dari #sm.roster · #pc(sm.rate, d: 1)]],
      grid(columns: nmax * (1fr,), column-gutter: 2.5pt, ..cs.map(tile)),
    )
    v(3pt)
  }
  #note[Abu-abu: tidak ada responden. Oranye muda: di bawah 30%. Oranye: 30–69%. Hijau: 70% atau lebih (target). Garis tebal: kelas yang diampu Koordinator PBL TI, yang pengisiannya diingatkan dan dipantau langsung. Teks tiap petak: kelas, tingkat respons, dan jumlah responden dari jumlah mahasiswa.]
  #v(2pt)
  #let zero = cl.filter(c => c.n == 0)
  #let lolos = cl.filter(c => c.rate >= 70)
  #note[#zero.len() dari #cl.len() kelas tidak punya responden (#zero.map(c => c.label).join(", ")). #lolos.len() kelas mencapai target 70% (#lolos.map(c => c.label).join(", ")).]
  ]
}

#let sec-keterwakilan(s) = {
  let m = d.at(s).mhs
  let mo = m.monitored
  let row(lab, g) = (
    lab, str(g.n_classes), str(g.roster), str(g.n), pc(g.rate, d: 1),
    if "stats" in g { fmt(g.stats.ops_mean, d: 2) } else { "–" },
    if "stats" in g { fmt(g.stats.puas, d: 2) } else { "–" },
    if "stats" in g { fmt(g.stats.lanjut, d: 2) } else { "–" },
    if "stats" in g { pc(g.stats.berat) } else { "–" },
    if "stats" in g { g.stats.top.map(t => t.label + " (" + pc(t.pct) + ")").first() } else { "–" },
  )
  table(
    columns: (1.5fr, auto, auto, auto, auto, auto, auto, auto, auto, 1.5fr), align: (left, right, right, right, right, right, right, right, right, left),
    table.header[Kelompok kelas][Kelas][Mhs][Resp.][Tingkat respons][Rerata pelaksanaan][Puas][Lanjut][Beban berat][Masalah terbanyak],
    ..row("Dipantau Koordinator PBL TI", mo.enf),
    ..row("Pengisian belum dipantau", mo.oth),
  )
  note[Puas dan Lanjut adalah rerata skala 1–5 untuk kepuasan dan keinginan melanjutkan PBL. Kelompok dengan responden kurang dari 5 tidak dilaporkan.]
}

#let cmp-table(mh, dos, title) = table(
  columns: (1fr, 34pt, 82pt, 36pt, 36pt, 40pt), align: (left, center, left, center, center, center),
  table.header[#title][Rerata mhs][Sebaran mhs][Setuju mhs][Rerata dosen][Selisih],
  ..for i in range(mh.len()) {
    let a = mh.at(i)
    let b = dos.at(i)
    let g = if a.mean != none and b.mean != none { b.mean - a.mean } else { none }
    (
      a.label, fmt(a.mean, d: 2), lbar(a.dist), pc(a.pct_agree), fmt(b.mean, d: 2),
      if g != none and g >= 0.5 { text(weight: 700, fill: accent-dark)[#sgn(g)] } else { sgn(g) },
    )
  },
)

#let sec-aspek(s) = {
  let m = d.at(s).mhs
  table(
    columns: (auto, 1.6fr, auto, auto, auto, 1.7fr), align: (center, left, center, center, center, left),
    table.header[Aspek][Isi][Mahasiswa][Dosen][Pilih masalah di aspek ini][Masalah yang paling sering],
    ..for a in m.aspek {
      (
        a.code, [*#a.name* \ #text(size: 8.5pt, fill: muted)[#a.items.join(", ")]],
        [#fmt(a.mhs_mean, d: 2) \ #cat-chip(a.mhs_cat)], [#fmt(a.dosen_mean, d: 2) \ #cat-chip(a.dosen_cat)], pc(a.problem_pct),
        [#a.problems.first().label (#pc(a.problems.first().pct))],
      )
    },
  )
  note[Rerata skala 1–5. Skor aspek D hanya dari butir fasilitas. Beban kerja, koordinasi tim, dan kontribusi anggota diukur lewat pilihan masalah. "Pilih masalah" adalah persentase responden yang memilih minimal satu masalah di aspek itu.]
}

#let sec-opinion(s, lead: none, with-exp: true) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  lead
  tiles(
    tile(fmt(m.ops_mean, d: 2), "Rerata pelaksanaan PBL (mahasiswa)", sub: m.ops_cat),
    tile(fmt(l.ops_mean, d: 2), "Rerata pelaksanaan PBL (dosen)", sub: l.ops_cat),
    tile(pc(m.ben.at(3).pct_agree), "Mahasiswa puas dengan PBL", sub: "skor 4 dan 5", color: accent),
    tile(pc(m.ben.at(4).pct_agree), "Mahasiswa setuju PBL dilanjutkan", sub: "skor 4 dan 5", color: accent),
  )
  cmp-table(m.ops, l.ops, "Pelaksanaan PBL")
  v(10pt)
  cmp-table(m.ben, l.ben, "Manfaat dan kepuasan")
  v(2pt)
  lk-legend()
  note[Rerata skala 1–5, tanpa jawaban "tidak dapat menilai". Selisih adalah rerata dosen dikurangi rerata mahasiswa. Selisih 0,50 ke atas dicetak tebal. Kategori rerata: 4,21–5,00 sangat baik; 3,41–4,20 baik; 2,61–3,40 cukup; 1,81–2,60 kurang; 1,00–1,80 sangat kurang.]
  if with-exp and m.by_experience.len() > 0 {
    subhead[Menurut pengalaman PBL sebelumnya (mahasiswa)]
    block(breakable: false, table(
      columns: (1.4fr, auto, auto, auto, auto, auto), align: (left, right, right, right, right, right),
      table.header[Kelompok][Responden][Rerata pelaksanaan][Puas (setuju)][Setuju dilanjutkan][Beban berat],
      ..for g in m.by_experience {
        (if g.group == "Belum pernah" { "Belum pernah mengikuti PBL" } else { "Pernah mengikuti PBL" }, str(g.n), fmt(g.ops_mean, d: 2), pc(g.sat_agree), pc(g.cont_agree), pc(g.berat_pct))
      },
    ))
  }
}

#let sec-pemahaman(s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let strip(items) = items.map(i => (label: i.label.replace(regex("^[0-9] "), ""), pct: i.pct))
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [
      #subhead[Mahasiswa: pemahaman PBL menurut diri sendiri]
      #bars(strip(m.k1.items))
      #note[Rerata #fmt(m.k1_mean, d: 2) dari 5. Pada soal uji, #pc(m.k2_correct) memilih definisi PBL yang benar.]
      #subhead[Mahasiswa: pengalaman PBL sebelum semester ini]
      #bars(m.k3.items.map(i => (label: i.label, pct: i.pct)))
    ],
    [
      #subhead[Dosen: pemahaman PBL menurut diri sendiri]
      #bars(strip(l.k1.items))
      #note[Pada soal uji, #pc(l.k2_correct) memilih tindakan yang sesuai prinsip PBL.]
      #subhead[Dosen: sosialisasi PBL yang pernah diikuti]
      #bars(l.sosialisasi.map(i => (label: i.label, pct: i.pct)))
    ],
  )
  if l.by_experience.len() > 0 {
    subhead[Dosen menurut pengalaman mengampu PBL]
    block(breakable: false, table(
      columns: (1.6fr, auto, auto, auto, auto, auto), align: (left, right, right, right, right, right),
      table.header[Kelompok][Dosen][Pemahaman (rerata)][Memilih tindakan PBL yang tepat][Rerata pelaksanaan][Puas (rerata)],
      ..for g in l.by_experience { (g.group, str(g.n), fmt(g.k1, d: 2), pc(g.k2_correct), fmt(g.ops_mean, d: 2), fmt(g.puas, d: 2)) },
    ))
  }
}

#let sec-konsultasi(s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  grid(
    columns: (1fr, 1fr, 1fr), column-gutter: 10pt,
    cmp-dist("Konsultasi di luar jam kuliah", m.consult_freq.items, l.consult_freq.items),
    cmp-dist("Waktu menanggapi", m.consult_resp.items, l.consult_resp.items),
    cmp-dist("Inisiatif konsultasi", m.consult_init.items, l.consult_init.items),
  )
  note[Mahasiswa menjawab untuk tim mereka. Dosen menjawab untuk rata-rata tim yang dibimbing.]
}

#let sec-keselarasan(s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let p = m.pooled
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Mahasiswa: jawaban "ya" pada pernyataan materi dan tugas]
     #bars(p.bc.map(b => (label: b.label, pct: b.ya)))],
    [#subhead[Dosen: jawaban "ya" pada penyesuaian mata kuliah]
     #bars(l.align.map(a => (label: tr(a.label), pct: a.ya)))],
  )
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Bentuk tugas utama (jawaban mahasiswa per mata kuliah)]
     #bars(p.type.map(t => (label: tr(t.label), pct: t.pct)), color: primary-mid)
     #subhead[Bentuk tugas utama (dosen memilih semua yang berlaku)]
     #bars(l.types.map(t => (label: tr(t.label), pct: t.pct)), color: primary-mid)],
    [#subhead[Bobot nilai dari proyek PBL (jawaban mahasiswa)]
     #bars(p.share.map(t => (label: t.label, pct: t.pct)), color: accent)
     #subhead[Bobot nilai dari proyek PBL (pernyataan dosen)]
     #bars(l.share.items.map(t => (label: t.label, pct: t.pct)), color: accent)],
  )
  note[Dihitung dari #p.n jawaban mata kuliah, yaitu #m.n mahasiswa dikali jumlah mata kuliah PBL di semesternya.]
}

#let sec-goodbad(s, lead: none) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  lead
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Mahasiswa: hal yang paling baik] #bars(topn(m.best, 6))],
    [#subhead[Mahasiswa: hal yang perlu diperbaiki] #bars(topn(m.improve, 8), color: accent)],
  )
  v(8pt)
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Dosen: hal yang paling baik] #bars(topn(l.best, 5))],
    [#subhead[Dosen: hal yang perlu diperbaiki] #bars(topn(l.improve, 6), color: accent)],
  )
  note[Persentase dihitung dari jumlah responden (#m.n mahasiswa, #l.n dosen). Tiap responden boleh memilih paling banyak tiga hal, jadi totalnya lebih dari 100%.]
}

#let sec-duasisi(s) = {
  let m = d.at(s).mhs
  table(
    columns: (1.3fr, 1fr, 1fr, 1.2fr), align: (left, left, left, center),
    table.header[Aspek][Disebut paling baik][Disebut perlu diperbaiki][Catatan],
    ..for x in m.dua_sisi {
      (
        x.aspek,
        grid(columns: (1fr, 28pt), box(width: 100%, height: 8pt, fill: light, radius: 1pt)[#box(width: calc.min(x.baik, 60) / 60 * 100%, height: 8pt, fill: primary, radius: 1pt)], align(right, pc(x.baik))),
        grid(columns: (1fr, 28pt), box(width: 100%, height: 8pt, fill: light, radius: 1pt)[#box(width: calc.min(x.masalah, 60) / 60 * 100%, height: 8pt, fill: accent, radius: 1pt)], align(right, pc(x.masalah))),
        if x.dua_sisi { chip("dua sisi", accent) } else if x.masalah > x.baik { chip("lebih banyak masalah", accent-dark) } else { chip("lebih banyak baik", primary-mid) },
      )
    },
  )
  note[Persentase dari seluruh mahasiswa responden. "Dua sisi" berarti lebih dari 15% responden menyebutnya baik sekaligus bermasalah.]
}

#let sec-faktor(s) = {
  let m = d.at(s).mhs
  let dr = m.drivers
  subhead[Butir pelaksanaan yang paling berkaitan dengan kepuasan]
  table(
    columns: (1fr, 92pt, 92pt), align: (left, left, left),
    table.header[Butir][Hubungan dengan "puas"][Hubungan dengan "setuju dilanjutkan"],
    ..for c in dr.corr {
      let bar(r, col) = if r == none { [–] } else { grid(columns: (1fr, 28pt), column-gutter: 4pt, box(width: 100%, height: 8pt, fill: light, radius: 1pt)[#box(width: calc.max(r, 0) / 0.6 * 100%, height: 8pt, fill: col, radius: 1pt)], align(right, fmt(r, d: 2))) }
      (c.label, bar(c.r_puas, primary), bar(c.r_lanjut, primary-mid))
    },
  )
  note[Angka ini adalah korelasi Pearson (0 sampai 1) antara skor butir dan skor kepuasan tiap responden. Makin tinggi, makin kuat hubungannya. Ini baru hubungan, belum tentu sebab-akibat.]
  subhead[Rerata kepuasan menurut pengalaman responden]
  table(
    columns: (1.5fr, 1.4fr, auto, auto, auto), align: (left, left, right, right, right),
    table.header[Faktor][Kelompok][Responden][Puas (rerata)][Setuju dilanjutkan (rerata)],
    ..for c in dr.cross {
      for (i, g) in c.groups.enumerate() { (if i == 0 { c.factor } else { [] }, g.label, str(g.n), fmt(g.puas, d: 2), fmt(g.lanjut, d: 2)) }
    },
  )
}

#let sec-semester(s) = {
  let m = d.at(s).mhs
  table(
    columns: (1.2fr, auto, auto, auto, auto, auto, 1.6fr), align: (left, right, right, right, right, right, left),
    table.header[Kelompok][Resp.][Rerata pelaksanaan][Puas][Lanjut][Beban berat][Masalah terbanyak],
    ..for x in m.sem_stats { (x.label, str(x.n), fmt(x.ops_mean, d: 2), fmt(x.puas, d: 2), fmt(x.lanjut, d: 2), pc(x.berat), x.top.first().label + " (" + pc(x.top.first().pct) + ")") },
  )
}

#let sec-workload(s, lead: none) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let wl(dist) = dist.items.map(i => (label: i.label.slice(2), pct: i.pct))
  lead
  tiles(
    tile(pc(m.workload_heavy_pct), "Mahasiswa menilai beban PBL berat atau sangat berat", color: accent),
    tile(pc(l.workload_heavy_pct), "Dosen menilai beban mengampu PBL berat atau sangat berat", color: accent),
    tile(pc(m.material.at(0).pct), "Mahasiswa: tugas mata kuliah menambah beban di luar proyek", sub: "keluhan materi dan tugas yang paling sering", color: accent),
  )
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Beban PBL dibanding waktu tersedia (mahasiswa)] #bars(wl(m.workload), color: accent) #subhead[Beban mengampu PBL (dosen)] #bars(wl(l.workload), color: accent)],
    [#subhead[Keluhan materi dan tugas (mahasiswa)] #bars(topn(m.material, 6, skip: ("Lainnya", "Tidak ada kendala")), color: accent)],
  )
}

#let sec-coord(s, lead: none) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let stu = m.coord.map(c => (
    label: c.label + if c.kind == "yn" { " (ya)" } else { " (sering/selalu)" },
    pct: if c.kind == "yn" { c.ya } else { c.pct_oa },
    neg: c.kind == "lk",
  ))
  lead
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [
      #subhead[Pandangan mahasiswa]
      #bars(stu.filter(x => not x.neg))
      #v(6pt)
      #bars(stu.filter(x => x.neg), color: accent)
    ],
    [
      #subhead[Praktik dosen pengampu]
      #bars(l.coord_yn.map(c => (label: c.label + " (ya)", pct: c.ya)).slice(1, 4))
      #v(6pt)
      #bars(l.coord_lk.map(c => (label: c.label + " (jarang/tidak pernah)", pct: c.pct_never)), color: accent)
    ],
  )
  grid(
    columns: (1fr, 1fr), column-gutter: 18pt,
    [#subhead[Kehadiran pada rapat koordinasi dosen] #bars(l.meeting.items.map(i => (label: i.label, pct: i.pct)))
     #subhead[Kendala koordinasi (dosen)] #bars(topn(l.barriers, 4, skip: ("Lainnya", "Tidak ada kendala")), color: accent)],
    [#subhead[Dukungan yang paling diperlukan (dosen)] #bars(topn(l.support, 6, skip: ("Lainnya",)))
     #subhead[Keterlibatan di grup WhatsApp dosen PBL] #bars(l.wa.items.map(i => (label: i.label, pct: i.pct)))],
  )
  note[Persentase dosen dihitung dari #l.n dosen, persentase mahasiswa dari #m.n mahasiswa. Kendala dan dukungan boleh dipilih paling banyak tiga.]
}

#let sec-courses(s, lead: none) = {
  let cs = d.at(s).mhs.courses
  lead
  table(
    columns: (auto, 2.4fr, auto, auto, auto, auto, auto, 1.4fr), align: (center, left, right, right, right, right, right, left),
    table.header[Smt][Mata kuliah][n][Kegiatan dosen][Keselarasan][Hadir review][Bobot tak disampaikan][Tugas utama],
    ..for c in cs {
      let flag(v, bad) = if bad { text(weight: 700, fill: accent-dark)[#pc(v)] } else { pc(v) }
      (
        str(c.sem), c.course, str(c.n), flag(c.acts_mean, c.acts_mean < 50), flag(c.bc_ya_mean, c.bc_ya_mean < 50),
        flag(c.att_all, c.att_all < 60), flag(c.share_not_stated, c.share_not_stated >= 40), c.type.at(0).label.replace("Deliverable proyek", "Hasil kerja proyek"),
      )
    },
  )
  note[Kegiatan dosen: rerata persentase jawaban "sering" atau "selalu" pada 5 kegiatan. Keselarasan: rerata persentase jawaban "ya" pada 9 pernyataan tentang materi dan tugas. Angka tebal berwarna menandai nilai di bawah 50% (kegiatan, keselarasan), di bawah 60% (kehadiran), atau 40% ke atas (bobot tidak disampaikan). Angka ini adalah persepsi mahasiswa per mata kuliah. Angka ini bukan penilaian terhadap dosen tertentu dan tidak disampaikan kepada dosen secara individual (Panduan Monev PBL bagian 7).]
}

// ---------------------------------------------------------------- free-text chapter (student comments, TI and SIB)
#let sec-komentar-ringkas(s) = {
  let tot = if s == "all" { tema.substantive } else if s == "ti" { tema.substantive_ti } else { tema.substantive_sib }
  let sc(lab) = { let x = tema.sentimen.filter(i => i.label == lab).first(); if s == "all" { x.n } else { x.at(s) } }
  tiles(
    tile(str(tot), "Komentar bermakna", sub: "kolom saran tidak wajib diisi"),
    tile(pc(100 * sc("kritik") / tot), "Berisi kritik atau saran saja", color: accent),
    tile(pc(100 * sc("campuran") / tot), "Memuat pujian dan kritik", color: primary-mid),
    tile(pc(100 * sc("pujian") / tot), "Berisi pujian saja", color: primary),
  )
  note[Kolom saran tidak wajib diisi. Komentar kosong, "-", atau "tidak ada" tidak dihitung. #sc("lain") komentar membahas hal di luar tema yang ada, jadi ketiga persentase tidak berjumlah 100%.]
}

#let tri-line(k, s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let imp(lab) = pick(m.improve, lab).pct
  let bestp(lab) = pick(m.best, lab).pct
  let dr = m.drivers
  let cross(f) = dr.cross.filter(c => c.factor == f)
  if k == "koordinasi" {
    [Hanya #pc(m.coord.at(1).ya) mahasiswa menilai arahan antar mata kuliah konsisten. Sebanyak #pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi")) memilih arahan yang tidak terkoordinasi sebagai masalah. Hanya #pc(l.coord_yn.at(2).ya) dosen mengatakan sudah ada kesepakatan peran.]
  } else if k == "beban" {
    let c = cross("Beban PBL dibanding waktu tersedia")
    let gb = if c.len() > 0 { c.first().groups.filter(x => x.label == "Berat atau sangat berat") } else { () }
    let gr = if c.len() > 0 { c.first().groups.filter(x => x.label == "Ringan atau sesuai") } else { () }
    [#pc(m.material.at(0).pct) mahasiswa mengatakan tugas mata kuliah menambah beban di luar proyek, dan #pc(m.workload_heavy_pct) menilai bebannya berat.#if gb.len() > 0 and gr.len() > 0 [ Yang menilai beban berat rata-rata puas #fmt(gb.first().puas, d: 2). Yang menilai beban sesuai rata-rata puas #fmt(gr.first().puas, d: 2).]]
  } else if k == "tim" {
    [#pc(imp("Kontribusi anggota tim tidak seimbang")) memilih kontribusi anggota yang tidak seimbang sebagai masalah. Hanya #pc(m.ops.at(6).pct_agree) setuju bahwa penilaian adil bagi kontribusi tiap anggota.]
  } else if k == "kejelasan" {
    [#pc(imp("Kejelasan ketentuan (SOP dan rubrik)")) memilih kejelasan SOP dan rubrik sebagai masalah. Di sisi lain, SOP dan template juga sering disebut hal baik (#pc(bestp("SOP dan template laporan membantu"))). Bobot nilai PBL tidak disampaikan pada #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mata kuliah.]
  } else if k == "bimbingan" {
    [#pc(m.ops.at(3).pct_agree) setuju bimbingan dosen memadai. Namun #pc(m.consult_freq.items.at(0).pct) tim belum pernah berkonsultasi di luar jam kuliah, dan #pc(pick(m.material, "Materi pendukung kurang").pct) menyebut materi pendukung kurang.]
  } else if k == "nilai" {
    let r = dr.corr.filter(c => c.label.starts-with("Penilaian adil"))
    [Hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil dan #pc(m.ops.at(5).pct_agree) setuju rubrik jelas.#if r.len() > 0 and r.first().r_puas != none [ Keduanya termasuk yang paling berhubungan dengan kepuasan (r = #fmt(r.first().r_puas, d: 2) untuk keadilan).]]
  } else if k == "fasilitas" {
    [Fasilitas dan sumber daya adalah butir dengan rerata terendah (#fmt(m.ops.at(7).mean, d: 2)). Sebanyak #pc(imp("Fasilitas dan sumber daya (server, data, perangkat)")) responden memilihnya sebagai masalah. Butir ini juga paling berhubungan dengan kepuasan.]
  } else if k == "baik" {
    [Hal yang dinilai paling baik: pengalaman dan keterampilan baru (#pc(bestp("Pengalaman dan keterampilan baru yang saya peroleh"))), SOP dan template (#pc(bestp("SOP dan template laporan membantu"))), dan bimbingan dosen (#pc(bestp("Bimbingan dosen"))).]
  } else { none }
}

#let sec-komentar(s, lead: none) = {
  let key = if s == "all" { "n" } else { s }
  let tot = if s == "all" { tema.substantive } else if s == "ti" { tema.substantive_ti } else { tema.substantive_sib }
  lead
  sec-komentar-ringkas(s)
  let ths = tema.themes.filter(t => t.at(key) > 0)
  let probs = ths.filter(t => t.kind == "masalah").sorted(key: t => -t.at(key))
  let goods = ths.filter(t => t.kind == "baik")
  subhead[Peta tema: TI dibanding SIB]
  table(
    columns: (2fr, auto, auto, auto, auto, auto), align: (left, right, right, right, right, right),
    table.header[Tema][Total][TI][% komentar TI][SIB][% komentar SIB],
    ..for t in probs + goods {
      (t.label, str(t.n), str(t.ti), pc(100 * t.ti / tema.substantive_ti), str(t.sib), pc(100 * t.sib / tema.substantive_sib))
    },
  )
  note[Satu komentar bisa masuk lebih dari satu tema. Persentase dihitung dari komentar bermakna tiap program studi (TI #tema.substantive_ti, SIB #tema.substantive_sib), supaya TI dan SIB bisa dibandingkan dengan adil.]
  for t in probs + goods {
    block(above: 22pt, below: 6pt, sticky: true)[
      #chip(if t.kind == "baik" { "BAIK" } else { "MASALAH" }, if t.kind == "baik" { primary } else { accent })
      #h(4pt) #text(weight: 700, size: 12pt, fill: if t.kind == "baik" { primary } else { accent-dark })[#t.label]
      #h(4pt) #text(size: 9.5pt, fill: muted)[#t.at(key) komentar]
    ]
    t.ringkasan
    let subs = t.subs.filter(sb => sb.at(key) > 0)
    if subs.len() > 1 { bars(subs.map(sb => (label: sb.label + " (" + str(sb.at(key)) + ")", pct: 100 * sb.at(key) / tot)), color: if t.kind == "baik" { primary-mid } else { accent }, max: 40) }
    let qs = if s == "all" {
      let tq = t.quotes.filter(q => q.tag.contains(" TI "))
      let sq = t.quotes.filter(q => q.tag.contains(" SIB "))
      tq.slice(0, calc.min(1, tq.len())) + sq.slice(0, calc.min(1, sq.len()))
    } else {
      let f = t.quotes.filter(q => q.tag.contains(" " + upper(s) + " "))
      f.slice(0, calc.min(2, f.len()))
    }
    for q in qs { quote-block(q.text, q.tag) }
    block(above: 8pt)[#text(weight: 700)[TI dibanding SIB.] TI #t.ti komentar (#pc(100 * t.ti / tema.substantive_ti) dari komentar TI); SIB #t.sib komentar (#pc(100 * t.sib / tema.substantive_sib) dari komentar SIB).]
    let tl = tri-line(t.key, s)
    if tl != none { block(above: 6pt)[#text(weight: 700)[Menurut angka survei.] #tl] }
    apa-artinya(t.makna)
  }
  note[Kutipan hanya disunting ringan (ejaan dan tanda baca) dan tidak memuat nama dosen atau mata kuliah.]

  subhead[Usulan konkret mahasiswa]
  bars(tema.usulan.filter(u => u.at(key) > 0).sorted(key: u => -u.at(key)).map(u => (label: u.label + " (" + str(u.at(key)) + ")", pct: 100 * u.at(key) / tot)), max: 20)
  note[Persentase komentar bermakna yang memuat usulan itu.]
}

// ---------------------------------------------------------------- komentar bebas dosen (paraphrase, tanpa kutipan)
#let td(k, s) = tema-dosen.themes.filter(x => x.key == k).first().at(if s == "all" { "n" } else { s })

#let dosen-line(k, s) = {
  let l = d.at(s).dosen
  let m = d.at(s).mhs
  let b(lab) = pick(l.barriers, lab).count
  let sp(lab) = pick(l.support, lab).count
  if k == "apresiasi" or k == "beban" {
    [#b("Beban mengajar dan administrasi lain") dari #l.n dosen menyebut beban mengajar dan administrasi sebagai hambatan koordinasi. Sebanyak #sp("Penyesuaian beban kerja") memilih penyesuaian beban kerja sebagai dukungan yang diperlukan.]
  } else if k == "panduan" {
    [Dari #l.n dosen, #sp("Rapat koordinasi dosen rutin") memilih rapat koordinasi rutin, #sp("Pembagian peran dosen yang tertulis") memilih pembagian peran yang tertulis, dan #sp("Panduan dan contoh penilaian") memilih panduan dan contoh penilaian. Hanya #pc(l.coord_yn.at(2).ya) dosen mengatakan sudah ada kesepakatan peran.]
  } else if k == "wadah" {
    let u = tema.usulan.filter(x => x.label.starts-with("Sediakan sistem pemantau")).first()
    let key = if s == "all" { "n" } else { s }
    [#u.at(key) komentar mahasiswa juga meminta sistem untuk memantau progres dan kontribusi, termasuk milestone di LMS.]
  } else if k == "keselarasan" {
    [Hanya #pc(l.align.at(3).ya) dosen menjawab bahwa tugas mata kuliahnya bagian dari hasil kerja proyek. Hanya #pc(m.pooled.bc.at(3).ya) mahasiswa menjawab bahwa tugas mata kuliah bagian dari proyek.]
  } else if k == "baik" {
    [Dosen menilai pelaksanaan PBL #fmt(l.ops_mean, d: 2) dari 5 (#l.ops_cat).]
  } else { none }
}

#let sec-komentar-dosen(s) = {
  let key = if s == "all" { "n" } else { s }
  let l = d.at(s).dosen
  let w = tema-dosen.penulis.at(key)
  let ths = tema-dosen.themes.filter(t => t.at(key) > 0)
  [#w dari #l.n dosen menulis sesuatu pada pertanyaan terbuka (saran bebas dan jawaban "lainnya" yang diketik), seluruhnya #tema-dosen.input isian. Semua isian dibaca dan dikelompokkan. Jumlahnya kecil, jadi tema di bawah ini hanya usulan dan bukan gambaran pendapat seluruh dosen. Isinya ditulis ulang dengan kata lain, tanpa kutipan, supaya penulisnya tidak bisa dikenali.#if s != "all" [ Dosen yang mengampu di dua program studi dihitung di keduanya.]]
  table(
    columns: if s == "all" { (2.4fr, auto, auto, auto) } else { (2.4fr, auto) }, align: (left, right, right, right),
    table.header(..if s == "all" { ([Tema], [Dosen], [TI], [SIB]) } else { ([Tema], [Dosen]) }),
    ..for t in ths { if s == "all" { (t.label, str(t.n), str(t.ti), str(t.sib)) } else { (t.label, str(t.at(key))) } },
  )
  note[Satu dosen bisa menulis lebih dari satu usulan, jadi jumlah per tema tidak boleh dijumlahkan.]
  for t in ths {
    block(above: 18pt, below: 6pt, sticky: true)[
      #chip(if t.kind == "baik" { "BAIK" } else { "SARAN" }, if t.kind == "baik" { primary } else { accent })
      #h(4pt) #text(weight: 700, size: 12pt, fill: if t.kind == "baik" { primary } else { accent-dark })[#t.label]
      #h(4pt) #text(size: 9.5pt, fill: muted)[#t.at(key) dosen]
    ]
    t.ringkasan
    let dl = dosen-line(t.key, s)
    if dl != none { block(above: 6pt)[#text(weight: 700)[Menurut angka survei.] #dl] }
    apa-artinya(t.makna)
  }
}

// ---------------------------------------------------------------- recommendations (3 time horizons)
#let prio-chip(p) = if p == w-ini { chip(p, accent) } else if p == w-setelah { chip(p, primary) } else { chip(p, primary-mid) }

// rows: (judul, bukti, prioritas (earliest horizon), minggu: (..), setelah: (..), depan: (..), indikator, pj)
#let sec-rekom-kartu(rows) = {
  for (i, r) in rows.enumerate() {
    block(width: 100%, breakable: false, inset: 12pt, radius: 3pt, stroke: 0.7pt + border-c, above: 12pt, below: 0pt)[
      #set par(justify: false)
      #grid(columns: (24pt, 1fr, auto), column-gutter: 8pt,
        circle(radius: 9pt, fill: primary)[#align(center + horizon)[#text(fill: white, weight: 700, size: 10pt)[#(i + 1)]]],
        text(weight: 700, size: 11pt)[#r.judul], prio-chip(r.prioritas))
      #v(3pt)
      #text(size: 10pt)[#issue[#r.at("label", default: "Masalah.")] #r.bukti]
      #for (lab, k) in ((w-ini, "minggu"), (w-setelah, "setelah"), (w-depan, "depan")) {
        let items = r.at(k, default: ())
        if items.len() > 0 {
          block(above: 7pt, below: 0pt)[
            #grid(columns: (92pt, 1fr), column-gutter: 6pt,
              text(weight: 700, size: 9.5pt)[#lab],
              [#for it in items [#text(size: 10pt)[▪ #it] \ ]])
          ]
        }
      }
      #v(8pt)
      #text(size: 9pt, fill: muted)[*Indikator:* #r.indikator · *Usulan penanggung jawab:* #r.pj]
    ]
  }
}

// rencana tindak lanjut menurut tingkat pelaksana; groups: ((tingkat, (baris...)), ...)
// baris: (judul, tindakan, waktu, pj, tenggat, status)
#let sec-rekom-tabel(groups) = {
  [Tabel berikut meringkas rekomendasi menurut tingkat pelaksananya: jurusan, program studi, dan kelas. Penanggung jawab dan tenggat adalah usulan koordinator. Statusnya diperbarui pada laporan tiap milestone.]
  v(4pt)
  let no = 0
  table(
    columns: (auto, 1.1fr, 1.6fr, 1.1fr, 1.2fr, 1.2fr, 0.7fr), align: (center, left, left, left, left, left, left),
    table.header[No][Masalah][Langkah][Waktu][Penanggung jawab][Tenggat][Status],
    ..for g in groups {
      (table.cell(colspan: 7, fill: light)[#text(weight: 700, fill: primary)[#g.at(0)]],)
      for r in g.at(1) {
        no += 1
        (str(no), r.judul, r.tindakan, r.waktu, r.pj, r.tenggat, r.at("status", default: "Belum"))
      }
    },
  )
  note[Penanggung jawab dan tenggat adalah usulan koordinator dan menunggu persetujuan tertulis Ketua Jurusan dan Kaprodi (balasan memo atau WhatsApp). Status ada empat: Belum, Berjalan, Selesai, dan Ditunda. Koordinator PBL memperbaruinya di laporan tiap milestone kepada Ketua Jurusan dan Kaprodi. Tenggat memakai minggu kalender akademik (Milestone 2 pada Minggu 12, Demo Day pada Minggu 16). Tanggalnya ditambahkan setelah kalender akademik semester berikutnya terbit.]
}

// ---------------------------------------------------------------- rekomendasi terpadu (satu sumber untuk ketiga laporan)
// Semua angka dihitung dari data survei untuk lingkup s ("all" | "ti" | "sib").
#let kp-owner(s) = if s == "ti" { "Ketua Jurusan dan Kaprodi TI" } else if s == "sib" { "Ketua Jurusan dan Kaprodi SIB" } else { "Ketua Jurusan, Kaprodi TI, dan Kaprodi SIB" }

#let ev(s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let mo = m.monitored
  let key = if s == "all" { "n" } else { s }
  let thn(k) = tema.themes.filter(t => t.key == k).first().at(key)
  let b(lab) = pick(l.barriers, lab).count
  let sp(lab) = pick(l.support, lab).count
  let imp(lab) = pick(m.improve, lab).pct
  let acts = m.courses.map(c => c.acts_mean)
  (
    m: m, l: l, mo: mo,
    konsisten: m.coord.at(1).ya, peran: l.coord_yn.at(2).ya,
    sup_rapat: sp("Rapat koordinasi dosen rutin"), sup_peran: sp("Pembagian peran dosen yang tertulis"), sup_panduan: sp("Panduan dan contoh penilaian"),
    b_beban: b("Beban mengajar dan administrasi lain"), b_jadwal: b("Tidak ada jadwal rapat rutin"),
    rapat_selalu: l.meeting.items.at(0).count,
    wa_baca: pick(l.wa.items, "Membaca tetapi jarang menanggapi").count, wa_aktif: pick(l.wa.items, "Aktif menanggapi dan berbagi informasi").count,
    tugas: m.pooled.bc.at(3).ya, tugas_d: l.align.at(3).ya, umum: pick(m.pooled.type, "Latihan umum").pct,
    bobot_tidak: pick(m.pooled.share, "Tidak disampaikan").pct, bobot50: pick(m.pooled.share, "> 50%").pct,
    materi_sebelum: m.pooled.bc.at(1).ya, materi_terlambat: pick(m.material, "Materi terlambat dibanding kebutuhan milestone").pct, materi_kurang: pick(m.material, "Materi pendukung kurang").pct,
    berat: m.workload_heavy_pct, tambah: m.material.at(0).pct, tenggat: m.coord.at(3).pct_oa,
    adil: m.ops.at(6).pct_agree, rubrik: m.ops.at(5).pct_agree, kontribusi: imp("Kontribusi anggota tim tidak seimbang"), kejelasan: imp("Kejelasan ketentuan (SOP dan rubrik)"),
    fasil: m.ops.at(7).mean, fasil_masalah: imp("Fasilitas dan sumber daya (server, data, perangkat)"),
    never: m.consult_freq.items.at(0).pct,
    acts_min: calc.min(..acts), acts_max: calc.max(..acts),
    resp: m.response.rate, enf: mo.enf.rate, oth: mo.oth.rate,
    baru: m.k3.items.at(0).pct, k2: l.k2_correct,
    th_koord: thn("koordinasi"), th_beban: thn("beban"), th_tim: thn("tim"), th_kej: thn("kejelasan"), th_fasil: thn("fasilitas"),
    sib_info: if s == "ti" { 0 } else if s == "sib" { tema.sib_info.sib } else { tema.sib_info.n },
  )
}

// catatan struktur PBL: keterangan koordinator, bukan hasil survei
#let catatan-struktur() = callout("Keterangan koordinator: struktur pelaksanaan PBL", [
  Bagian ini berasal dari penyusun laporan, bukan dari survei. PBL punya dua koordinator, TI dan SIB. Semester ini koordinasi PBL berjalan terutama lewat Koordinator PBL TI, yang juga mengampu empat kelas SIB Semester 5, sehingga PBL SIB tetap berjalan. Pembagian peran antar koordinator belum tertulis. PBL juga belum punya petunjuk teknis (juknis) atau petunjuk pelaksanaan (juklak) di tingkat jurusan. Yang ada hanya di tingkat institusi, sehingga aturannya tersebar di SOP tiap milestone dan RPS tiap dosen. Akibatnya, cara PBL dijalankan sampai sekarang bertumpu pada pengalaman semester-semester sebelumnya, baik yang berhasil maupun yang gagal, dan pada asumsi tentang apa yang akan berhasil, bukan pada aturan tertulis di tingkat jurusan. Karena itu, hasil survei ini juga menjadi cara pertama untuk menguji asumsi tersebut dengan data.
], color: primary-mid)

#let rekom-cards(s) = {
  let e = ev(s)
  let l = e.l
  let kp = kp-owner(s)
  (
    (judul: "Juknis PBL tingkat jurusan: peran koordinator, dosen rujukan, dan aturan bersama", prioritas: w-ini,
     bukti: [Keterangan koordinator: PBL belum punya juknis atau juklak di tingkat jurusan, dan pembagian peran antara dua koordinator (TI dan SIB) belum tertulis. Dampaknya terlihat di survei. Hanya #pc(e.peran) dosen mengatakan sudah ada kesepakatan peran. Dari #l.n dosen, #e.sup_peran meminta pembagian peran yang tertulis dan #e.sup_panduan meminta panduan dan contoh penilaian. Hanya #pc(e.konsisten) mahasiswa menilai arahan antar dosen konsisten. Satu dosen menulis bahwa mutu PBL sulit diukur kalau tiap pengampu mengajar menurut tafsirnya sendiri.],
     minggu: ([Umumkan dosen rujukan (PIC) tiap kelas kepada mahasiswa dan dosen.],),
     setelah: ([Koordinator PBL menyusun draf Juknis PBL Jurusan. Dosen menanggapi secara tertulis lewat grup WhatsApp, tanpa rapat tambahan.],),
     depan: ([Terbitkan Juknis PBL Jurusan sebelum minggu pertama semester depan. Isinya: peran kedua koordinator, dosen rujukan, dan dosen; skema PBL dengan bobot minimal 51%; rubrik berbasis PBL; peta keterkaitan mata kuliah dan milestone; batas beban dan tenggat; aturan WhatsApp; pembentukan tim, Penilaian 360, dan bukti kontribusi; halaman informasi per program studi; cara meminta fasilitas; dan cara pelaksanaan survei.], [Koordinator PBL melapor singkat kepada Ketua Jurusan dan Kaprodi pada tiap milestone, dengan indikator tetap: catatan milestone yang terkirim per kelas, halaman informasi yang terbit di minggu pertama, respons survei per kelas, dan dosen yang mengonfirmasi catatan. Dengan begitu kerja koordinator ikut dipantau.]),
     indikator: [Juknis terbit sebelum minggu pertama semester depan; kesepakatan peran dosen dari #pc(e.peran) menjadi minimal 80%; setiap aturan di Juknis merujuk ke satu temuan survei], pj: kp),
    (judul: "Koordinasi antar dosen lewat WhatsApp terstruktur, tanpa tambahan rapat", prioritas: w-setelah,
     bukti: [Hanya #pc(e.konsisten) mahasiswa menilai arahan antar dosen konsisten, dan #e.th_koord komentar mahasiswa membahasnya. Sebanyak #e.sup_rapat dari #l.n dosen meminta rapat rutin. Namun hambatan yang paling sering mereka sebut adalah beban mengajar dan administrasi (#e.b_beban) serta tidak adanya jadwal rapat (#e.b_jadwal). Hanya #e.rapat_selalu dosen yang selalu hadir di rapat yang ada. Grup WhatsApp tetap menjadi saluran utama, tetapi #e.wa_baca dari #l.n dosen hanya membacanya dan #e.wa_aktif yang aktif. Karena itu rapat rutin tidak direkomendasikan. Yang dibenahi adalah cara memakai WhatsApp.],
     setelah: ([Dosen rujukan mengirim satu catatan standar per milestone: status, risiko, dan keputusan yang dibutuhkan. Dosen mengonfirmasi dengan reaksi atau satu kata sampai batas waktu yang disebut. Yang diam dianggap setuju. Keputusan ditulis di peta keterkaitan, tidak dibiarkan di obrolan.],),
     depan: ([Cantumkan aturan ini di Juknis dan tulis peran dosen tiap kelas di peta.], [Kalau konfirmasi tetap rendah pada survei berikutnya, tambahkan satu pertemuan singkat per milestone.]),
     indikator: [dosen yang mengonfirmasi catatan milestone minimal 70%; arahan konsisten dari #pc(e.konsisten) menjadi minimal 60%], pj: "Dosen rujukan dan Koordinator PBL"),
    (judul: "Satu kasus besar: peta keterkaitan, rubrik berbasis PBL, dan bobot PBL minimal 51%", prioritas: w-ini,
     bukti: [Hanya #pc(e.tugas) mahasiswa (dosen: #pc(e.tugas_d)) menjawab bahwa tugas mata kuliah bagian dari proyek, dan #pc(e.umum) tugas utama berupa latihan umum. Bobot PBL tidak disampaikan pada #pc(e.bobot_tidak) jawaban, dan hanya #pc(e.bobot50) menyebut lebih dari 50%. Skor kegiatan PBL tiap mata kuliah berkisar #pc(e.acts_min) sampai #pc(e.acts_max). PBL mengumpulkan tugas banyak mata kuliah menjadi satu studi kasus besar. Tidak ada mata kuliah jangkar yang menentukan berhasil tidaknya PBL. Yang menentukan adalah cara tiap mata kuliah merancang tugas dan rubriknya. Risikonya, kalau satu kasus gagal, semua mata kuliah ikut terdampak. Karena itu hasil kerja tiap mata kuliah dinilai dengan kriterianya sendiri.],
     minggu: ([Sampaikan ulang bobot nilai PBL dan ketentuan Milestone 2 di kelas. Jangan ada tugas baru di luar proyek selama pekan Milestone 2.],),
     setelah: ([Dosen rujukan bersama dosen satu kelas menyusun peta keterkaitan untuk sisa semester. Tiap milestone memuat hasil kerja tiap mata kuliah, tenggat, bobot, dan tanggal materi pendukung. Dasarnya SOP Milestone 2 Bagian 6.], [Mulai dari mata kuliah dengan skor terendah di tabel keselarasan, terutama yang tugas utamanya masih latihan umum: Basis Data Lanjut (PDM, kamus data, kueri dan EXPLAIN ANALYZE), Penjaminan Mutu (rencana uji, kasus uji, catatan bug), dan Sistem Informasi Manajemen (kebutuhan informasi, rancangan laporan dan dasbor).]),
     depan: ([Semua 13 mata kuliah PBL memakai skema PBL (IKU 7). Bobot PBL minimal 51% tertulis di RPS, bersama pemetaan CPMK ke hasil kerja, rubrik, dan jadwal materi, lalu diumumkan di LMS pada minggu pertama. Angka 51% adalah batas bawah IKU 7, bukan target ideal.], [Rubrik ditulis berbasis PBL. Tiap kriteria menyebut CPMK yang diukurnya, dan tiap mata kuliah menyisakan komponen individual di dalam proyek, selain Penilaian 360. Tugas di luar proyek hanya untuk CPMK yang tidak bisa dicapai lewat proyek.], [Tiap mata kuliah menyediakan template hasil kerja yang berlaku untuk topik proyek apa pun, seperti template Milestone 2 untuk basis data dan pengujian.]),
     indikator: [tugas bagian dari proyek dari #pc(e.tugas) menjadi minimal 70%; latihan umum dari #pc(e.umum) menjadi di bawah 10%; bobot tidak disampaikan dari #pc(e.bobot_tidak) menjadi di bawah 5%; bobot PBL minimal 51% tertulis di RPS 13 mata kuliah], pj: "Dosen rujukan dan dosen pengampu tiap kelas; " + kp),
    (judul: "Beban: tenggat bertahap dan batas tugas di luar proyek", prioritas: w-ini,
     bukti: [#pc(e.tambah) mahasiswa mengatakan tugas mata kuliah menambah beban di luar proyek, #pc(e.berat) menilai beban berat, dan #pc(e.tenggat) mengalami tenggat antar mata kuliah yang bertabrakan. Selain itu, #e.th_beban komentar bebas membahas tugas terpisah dan tenggat.],
     minggu: ([Tidak ada tugas baru di luar proyek selama pekan Milestone 2.],),
     setelah: ([Peta memuat kalender tenggat bersama. Paling banyak dua hasil kerja mata kuliah jatuh pada pekan yang sama.],),
     depan: ([Batasi tugas di luar proyek pada sisa bobot (di bawah 49%) dan hanya untuk CPMK yang tidak bisa diwujudkan lewat proyek.],),
     indikator: [beban berat dari #pc(e.berat) menjadi di bawah 30%; tenggat bertabrakan dari #pc(e.tenggat) menjadi di bawah 25%], pj: "Dosen pengampu, dosen rujukan, dan Koordinator PBL"),
    (judul: "Kontribusi anggota dan pembentukan tim", prioritas: w-ini,
     bukti: [#pc(e.kontribusi) memilih kontribusi anggota yang tidak seimbang sebagai masalah. Hanya #pc(e.adil) setuju bahwa penilaian adil bagi kontribusi tiap anggota. Selain itu, #e.th_tim komentar bebas membahas kontribusi dan cara membentuk tim (pendapat terbelah antara memilih sendiri dan diatur dosen). Dosen belum punya data keterampilan individu mahasiswa, sehingga membagi tim menurut keterampilan tidak realistis.],
     minggu: ([Minta dosen menanyakan kontribusi tiap anggota saat review Milestone 2.],),
     setelah: ([Terapkan Penilaian 360 (SOP Bagian 9.3) bersama bukti objektif (logbook dan repositori). Selisih lebih dari 15 poin terhadap perkiraan tim memicu percakapan, dan dosen memutuskan penyesuaian nilai individual kalau perlu.],),
     depan: ([Mahasiswa memilih tim sendiri, tetapi proposal harus menunjukkan siapa memegang tiap peran (misalnya back-end, front-end, basis data, pengujian, dokumentasi). Dosen rujukan memeriksa apakah semua peran terisi dan ukuran tim pas. Dosen rujukan juga menyeimbangkan tim secara kasar, memakai nilai kelas yang sudah ada dan portofolio singkat. Nilai hanya dilihat dosen rujukan, dipakai untuk menyeimbangkan tim, dan tidak diumumkan.], [Tim boleh mengganti anggota satu kali pada Milestone 1 dengan persetujuan, dan tim sudah tetap sebelum minggu ke-2.]),
     indikator: [kontribusi tidak seimbang dari #pc(e.kontribusi) menjadi di bawah 20%; penilaian adil dari #pc(e.adil) menjadi minimal 70%], pj: "Dosen rujukan dan dosen pengampu"),
    (judul: "Halaman informasi resmi per program studi dan semester", prioritas: w-depan,
     bukti: [Bobot nilai PBL tidak disampaikan pada #pc(e.bobot_tidak) jawaban. Sebanyak #pc(e.kejelasan) memilih kejelasan ketentuan (SOP dan rubrik) sebagai masalah, dan #e.th_kej komentar bebas meminta template, jadwal, dan alur sejak awal semester.#if e.sib_info > 0 [ Ada #e.sib_info komentar SIB yang menyebut bahwa template dan jadwal yang mereka pakai berasal dari TI dan disampaikan oleh dosen mata kuliah. Belum ada halaman informasi resmi per program studi.]],
     depan: ([Buat satu halaman LMS per program studi dan semester, dengan satu pemilik (perwakilan Kaprodi). Isinya SOP, template, jadwal milestone, rubrik, dan bobot tiap mata kuliah, dan terbit pada minggu pertama. Bagian yang sama disalin dari sumber bersama, dan tiap program studi menambahkan bagian khasnya.], [Tambahkan halaman orientasi singkat bagi mahasiswa yang belum pernah mengikuti PBL (#pc(e.baru) dari responden).]),
     indikator: [bobot tidak disampaikan di bawah 5%; kejelasan ketentuan dipilih sebagai masalah di bawah 10%], pj: kp),
    (judul: "Materi tepat waktu dan sesi konsultasi terbuka sebelum milestone", prioritas: w-setelah,
     bukti: [Hanya #pc(e.materi_sebelum) mahasiswa menjawab bahwa materi diberikan sebelum milestone membutuhkannya. Sebanyak #pc(e.materi_terlambat) menyebut materi terlambat, dan #pc(e.materi_kurang) menyebut materi pendukung kurang. Sebanyak #pc(e.never) tim belum pernah berkonsultasi di luar jam kuliah. Namun kepuasan tidak berbeda antara tim yang pernah dan yang belum pernah berkonsultasi. Jadi yang perlu dibenahi adalah ketepatan waktu materi, bukan jumlah konsultasi.],
     setelah: ([Peta mencantumkan materi yang dibutuhkan tiap milestone dan tanggal penyampaiannya, paling lambat dua pekan sebelum milestone (usulan koordinator).], [Dosen menyediakan satu sesi konsultasi terbuka sebelum tiap milestone untuk tim yang meminta atau ditandai dari logbook.]),
     indikator: [materi terlambat dari #pc(e.materi_terlambat) menjadi di bawah 10%; materi pendukung kurang dari #pc(e.materi_kurang) menjadi di bawah 15%; tim yang belum pernah berkonsultasi dari #pc(e.never) menjadi di bawah 10%], pj: "Dosen pengampu dan dosen rujukan"),
    (judul: "Fasilitas: kredit cloud dan panduan dulu, server bersama kemudian", prioritas: w-setelah,
     bukti: [Fasilitas adalah butir dengan skor terendah (#fmt(e.fasil, d: 2)), dan #pc(e.fasil_masalah) memilihnya sebagai masalah.#if s != "ti" [ Semua #e.th_fasil komentar bebas tentang fasilitas datang dari SIB, tentang server untuk deployment dan jaringan.]#if s == "ti" [ Tidak ada komentar bebas TI tentang fasilitas.]],
     setelah: ([Susun panduan deployment singkat dengan layanan gratis dan kredit cloud untuk mahasiswa. Kumpulkan juga data kebutuhan server tiap tim semester ini.], [Teruskan keluhan jaringan ke laboratorium.]),
     depan: ([Putuskan perlu tidaknya server deployment bersama di kampus, berdasarkan data kebutuhan tim dan biaya pemeliharaannya.],),
     indikator: [skor fasilitas minimal 3,8], pj: "Koordinator PBL, laboratorium, dan " + kp),
    (judul: "Pemahaman PBL: kartu pertanyaan pemandu dan pendampingan dosen baru", prioritas: w-setelah,
     bukti: [Hanya #pc(e.k2) dosen memilih tindakan yang sesuai prinsip PBL pada pertanyaan skenario. Ini baru gambaran awal karena hanya satu butir. Selain itu, #pc(e.baru) mahasiswa belum pernah mengikuti PBL.#if s == "all" [ Dosen yang baru pertama kali mengampu (#l.by_experience.at(0).n orang) memilih tindakan yang tepat #pc(l.by_experience.at(0).k2_correct). Pada dosen berpengalaman (#l.by_experience.at(1).n orang), angkanya #pc(l.by_experience.at(1).k2_correct).]],
     setelah: ([Susun satu kartu pertanyaan pemandu untuk masalah milestone yang sering muncul. Kartu yang sama menjadi isi catatan milestone di WhatsApp.], [Pasangkan dosen yang baru mengampu PBL dengan dosen berpengalaman, tanpa pertemuan tambahan.]),
     depan: ([Tambahkan kartu dan pendampingan ke Juknis.],),
     indikator: [dosen memilih tindakan yang tepat minimal 90% pada survei berikutnya], pj: "Koordinator PBL dan dosen rujukan"),
    (judul: "Survei berikutnya: formulir singkat dan sesi 10 menit di kelas", prioritas: w-ini,
     bukti: [Respons mahasiswa hanya #pc(e.resp, d: 1), jauh di bawah target 70%. Di kelas yang dipantau responsnya #pc(e.enf, d: 1), sedangkan di kelas yang pengisiannya belum dipantau #pc(e.oth, d: 1).],
     minggu: ([Putuskan apakah formulir dibuka lagi untuk kelas dengan respons di bawah 30%.],),
     depan: ([Persingkat formulir mahasiswa menjadi butir yang dipakai laporan. Isi formulir dalam satu sesi 10 menit per kelas lewat kode QR, bersama ketua kelas. Dosen cukup menyediakan waktu.], [Kirim jumlah respons tiap kelas ke grup pada hari ke-3 dan hari terakhir.]),
     indikator: [respons minimal 70% di setiap kelas], pj: "Dosen pengampu, ketua kelas, dan Koordinator PBL"),
    (judul: "Apresiasi dan keberlanjutan PBL", prioritas: w-depan, label: "Saran dosen.",
     bukti: [Satu dosen menyarankan empat hal. Kinerja dosen dihargai dari komitmen pendampingan dan hasil PBL, tidak hanya dari survei kepuasan mahasiswa. Aturan penghargaan produk PBL terbaik diumumkan sejak awal semester. Pengampu ditata ulang berkala lewat RTM. Ada repositori produk lintas semester. Satu dosen lain meminta dosen yang punya tugas tambahan mengampu lebih sedikit mata kuliah, dan satu dosen meminta situs PBL bersama. Usulan ini berkaitan dengan hambatan beban mengajar dan administrasi (#e.b_beban dari #l.n dosen). Usulan ini berasal dari sedikit dosen, jadi diserahkan kepada Ketua Jurusan untuk diputuskan.],
     setelah: ([Minta masukan dosen lain tentang kriteria apresiasi dan penghargaan lewat grup WhatsApp.],),
     depan: ([Kriteria penghargaan produk PBL terbaik mencakup proses dan kolaborasi, tidak hanya produk, dan diumumkan di minggu pertama semester.], [Apresiasi kinerja dosen juga melihat bukti pendampingan (logbook dan review milestone), tidak hanya hasil.], [Tata ulang pengampu lewat RTM hanya kalau beban timpang, dengan memperhatikan kesinambungan mata kuliah.], [Siapkan repositori produk PBL dengan catatan kepemilikan dan privasi, serta situs progres bersama.]),
     indikator: [aturan penghargaan diumumkan di minggu pertama semester depan; repositori tersedia], pj: kp + " dan Koordinator PBL"),
  )
}

// butir rekomendasi di akhir tiap bagian; isi selaras dengan kartu rekomendasi (rekom-cards)
#let rekom-items(k, s) = {
  let e = ev(s)
  let kp = kp-owner(s)
  if k == "respons" { (
    (aksi: [Putuskan apakah formulir dibuka lagi selama satu pekan untuk kelas dengan respons di bawah 30%.], waktu: w-ini, pj: kp),
    (aksi: [Pada survei berikutnya, persingkat formulir mahasiswa menjadi butir yang dipakai laporan. Isi formulir dalam satu sesi 10 menit per kelas lewat kode QR, bersama ketua kelas. Dosen cukup menyediakan waktu. Di kelas yang dipantau, respons mencapai #pc(e.enf, d: 1), sedangkan di kelas yang pengisiannya belum dipantau #pc(e.oth, d: 1).], waktu: w-depan, pj: "Dosen pengampu, ketua kelas, dan Koordinator PBL", indikator: [respons minimal 70% di setiap kelas pada survei berikutnya]),
    (aksi: [Kirim jumlah respons tiap kelas ke grup WhatsApp pada hari ke-3 dan hari terakhir survei.], waktu: w-depan, pj: "Koordinator PBL"),
  ) } else if k == "pemahaman" { (
    (aksi: [Susun satu kartu pertanyaan pemandu untuk masalah milestone yang sering muncul. Pasangkan dosen yang baru mengampu PBL dengan dosen berpengalaman. Tidak ada pertemuan tambahan.], waktu: w-setelah, pj: "Koordinator PBL dan dosen rujukan", indikator: [dosen memilih tindakan yang tepat minimal 90% pada survei berikutnya]),
    (aksi: [Tambahkan halaman orientasi singkat bagi mahasiswa yang belum pernah mengikuti PBL pada halaman informasi program studi.], waktu: w-depan, pj: kp),
  ) } else if k == "bimbingan" { (
    (aksi: [Cantumkan di peta materi yang dibutuhkan tiap milestone dan tanggal penyampaiannya, paling lambat dua pekan sebelum milestone (usulan koordinator).], waktu: w-setelah, pj: "Dosen pengampu dan dosen rujukan", indikator: [materi terlambat dari #pc(e.materi_terlambat) menjadi di bawah 10%]),
    (aksi: [Sediakan satu sesi konsultasi terbuka sebelum tiap milestone untuk tim yang meminta atau ditandai dari logbook. Sesi ini menggantikan tinjauan untuk setiap tim.], waktu: w-setelah, pj: "Dosen pengampu", indikator: [tim yang belum pernah berkonsultasi dari #pc(e.never) menjadi di bawah 10%]),
  ) } else if k == "keselarasan" { (
    (aksi: [Sampaikan ulang bobot nilai PBL dan ketentuan Milestone 2 di kelas masing-masing.], waktu: w-ini, pj: "Dosen pengampu"),
    (aksi: [Susun peta keterkaitan mata kuliah dan milestone tiap kelas, dimulai dari mata kuliah dengan keselarasan terendah (tabel di atas). Dasarnya SOP Milestone 2 Bagian 6.], waktu: w-setelah, pj: "Dosen rujukan dan dosen pengampu tiap kelas", indikator: [tugas bagian dari proyek dari #pc(e.tugas) menjadi minimal 70%; latihan umum dari #pc(e.umum) menjadi di bawah 10%]),
    (aksi: [Tetapkan skema PBL (IKU 7) dengan bobot PBL minimal 51% di RPS semua mata kuliah PBL. Susun juga rubrik berbasis PBL yang memetakan tiap kriteria ke CPMK dan memuat komponen individual. Umumkan di LMS pada minggu pertama.], waktu: w-depan, pj: kp, indikator: [bobot minimal 51% tertulis di RPS 13 mata kuliah; bobot tidak disampaikan di bawah 5%]),
  ) } else if k == "beban" { (
    (aksi: [Tidak ada tugas baru di luar proyek selama pekan Milestone 2.], waktu: w-ini, pj: "Dosen pengampu"),
    (aksi: [Susun kalender tenggat bersama di peta, dengan paling banyak dua hasil kerja mata kuliah pada pekan yang sama.], waktu: w-setelah, pj: "Dosen rujukan dan dosen pengampu tiap kelas", indikator: [tenggat bertabrakan dari #pc(e.tenggat) menjadi di bawah 25%]),
    (aksi: [Batasi tugas di luar proyek pada sisa bobot (di bawah 49%) dan hanya untuk CPMK yang tidak bisa diwujudkan lewat proyek.], waktu: w-depan, pj: "Dosen pengampu", indikator: [beban berat dari #pc(e.berat) menjadi di bawah 30%]),
  ) } else if k == "koordinasi" { (
    (aksi: [Umumkan dosen rujukan (PIC) tiap kelas kepada mahasiswa dan dosen.], waktu: w-ini, pj: kp),
    (aksi: [Mulai aturan WhatsApp: dosen rujukan mengirim satu catatan standar per milestone, dosen mengonfirmasi dengan reaksi atau satu kata sampai batas waktu yang disebut, dan keputusan ditulis di peta. Rapat rutin tidak direkomendasikan karena beban mengajar dan administrasi (#e.b_beban dari #e.l.n dosen).], waktu: w-setelah, pj: "Dosen rujukan dan Koordinator PBL", indikator: [dosen yang mengonfirmasi catatan milestone minimal 70%; kesepakatan peran dari #pc(e.peran) menjadi minimal 80%]),
    (aksi: [Tulis peran kedua koordinator, dosen rujukan, dan dosen dalam Juknis PBL Jurusan. Minta koordinator melapor singkat kepada Ketua Jurusan dan Kaprodi pada tiap milestone.], waktu: w-depan, pj: kp),
  ) } else if k == "komentar" { (
    (aksi: [Sampaikan ringkasan hasil kepada mahasiswa: komentar mereka sudah dibaca, dan ini langkah yang akan diambil.], waktu: w-ini, pj: "Koordinator PBL bersama Kaprodi"),
    (aksi: [Terapkan Penilaian 360 bersama bukti objektif (logbook dan repositori) untuk menilai kontribusi anggota. Selisih lebih dari 15 poin memicu percakapan, dan dosen memutuskan penyesuaian nilai individual.], waktu: w-setelah, pj: "Dosen pengampu dan dosen rujukan"),
    (aksi: [Mahasiswa memilih tim sendiri, dengan peran yang jelas di proposal. Dosen rujukan memeriksa apakah semua peran terisi dan menyeimbangkan tim secara kasar, memakai nilai kelas dan portofolio. Tim boleh mengganti anggota sekali pada Milestone 1.], waktu: w-depan, pj: "Dosen rujukan dan dosen pengampu"),
    (aksi: [Buat satu halaman informasi resmi per program studi dan semester (SOP, template, jadwal milestone, rubrik, bobot) pada minggu pertama.], waktu: w-depan, pj: kp),
    (aksi: [Susun panduan deployment dengan layanan gratis dan kredit cloud, dan kumpulkan data kebutuhan server tiap tim. Putuskan soal server bersama kemudian.], waktu: w-depan, pj: "Koordinator PBL, laboratorium, dan Ketua Jurusan"),
  ) } else if k == "komentar-dosen" { (
    (aksi: [Minta masukan dosen lain tentang kriteria apresiasi dan penghargaan lewat grup WhatsApp.], waktu: w-setelah, pj: "Koordinator PBL"),
    (aksi: [Rumuskan kriteria penghargaan produk PBL terbaik yang mencakup proses dan kolaborasi. Apresiasi kinerja dosen juga melihat bukti pendampingan. Penataan pengampu lewat RTM hanya kalau beban timpang. Siapkan repositori produk dengan catatan kepemilikan dan privasi. Usulan ini diserahkan kepada Ketua Jurusan karena berasal dari sedikit dosen.], waktu: w-depan, pj: kp + " dan Koordinator PBL", indikator: [aturan penghargaan diumumkan di minggu pertama semester depan]),
  ) } else if k == "gap" { (
    (aksi: [Bahas selisih ini dengan dosen pengampu lewat grup WhatsApp atau satu pertemuan singkat. Undang perwakilan mahasiswa untuk menyampaikan pengalaman mereka.], waktu: w-ini, pj: "Koordinator PBL dan " + kp),
  ) } else { () }
}

#let rekom-rows(s) = {
  let kp = kp-owner(s)
  (
    ("Tingkat jurusan (diputuskan Ketua Jurusan)", (
      (judul: "Langkah sebelum Milestone 2", tindakan: [Umumkan ringkasan hasil dan dosen rujukan; ulangi bobot nilai dan ketentuan Milestone 2; tidak ada tugas baru di luar proyek], waktu: [#w-ini], pj: "Koordinator PBL, Kaprodi, dan dosen pengampu", tenggat: "Sebelum Milestone 2 (Minggu 12)"),
      (judul: "Juknis PBL jurusan", tindakan: [Draf Juknis dengan tanggapan tertulis dosen; terbitkan; koordinator melapor tiap milestone], waktu: [#w-setelah, #w-depan], pj: kp + "; draf oleh Koordinator PBL", tenggat: "Draf: Minggu 16; terbit: sebelum Minggu 1 semester berikutnya"),
      (judul: "Bobot PBL minimal 51% dan rubrik berbasis PBL di RPS", tindakan: [Skema PBL (IKU 7) di RPS 13 mata kuliah; pemetaan CPMK; komponen individual], waktu: [#w-depan], pj: kp + "; RPS oleh dosen pengampu", tenggat: "RPS direvisi sebelum Minggu 1 semester berikutnya"),
      (judul: "Fasilitas", tindakan: [Panduan deployment dan kredit cloud; data kebutuhan server; putuskan server bersama kemudian], waktu: [#w-setelah, #w-depan], pj: "Koordinator PBL dan laboratorium; keputusan server oleh Ketua Jurusan", tenggat: "Panduan: Minggu 14; keputusan server setelah data kebutuhan terkumpul"),
      (judul: "Apresiasi dan keberlanjutan", tindakan: [Penghargaan produk; apresiasi dosen; RTM; repositori], waktu: [#w-setelah, #w-depan], pj: "Ketua Jurusan", tenggat: "Masukan dosen: Minggu 14; aturan: Minggu 1 semester berikutnya"),
    )),
    ("Tingkat program studi (Kaprodi)", (
      (judul: "Halaman informasi", tindakan: [Satu halaman LMS per program studi dan semester; orientasi mahasiswa baru], waktu: [#w-depan], pj: "Kaprodi (perwakilan Kaprodi sebagai pemilik halaman)", tenggat: "Minggu 1 semester berikutnya"),
      (judul: "Kontribusi dan tim", tindakan: [Penilaian 360 dengan bukti; peran dalam proposal; ganti anggota sekali], waktu: [#w-ini, #w-setelah, #w-depan], pj: "Kaprodi; dosen rujukan memeriksa", tenggat: "Penilaian 360 sesuai SOP Milestone 2; aturan tim sebelum Minggu 2 semester berikutnya"),
      (judul: "Survei berikutnya", tindakan: [Putuskan apakah formulir dibuka lagi; formulir singkat; sesi 10 menit di kelas], waktu: [#w-ini, #w-depan], pj: "Koordinator PBL dan Kaprodi", tenggat: "Keputusan membuka formulir lagi: Minggu 13; survei berikutnya: pertengahan semester berikutnya"),
      (judul: "Pemahaman PBL", tindakan: [Kartu pertanyaan pemandu; pendampingan dosen baru], waktu: [#w-setelah, #w-depan], pj: "Koordinator PBL", tenggat: "Kartu: Minggu 16; pendampingan: Minggu 1 semester berikutnya"),
    )),
    ("Tingkat kelas (dosen rujukan dan dosen pengampu)", (
      (judul: "Koordinasi antar dosen", tindakan: [Catatan milestone di WhatsApp, konfirmasi, keputusan di peta; tanpa rapat tambahan], waktu: [#w-setelah, #w-depan], pj: "Dosen rujukan", tenggat: "Mulai pada milestone berikutnya (Minggu 16)"),
      (judul: "Peta keterkaitan, beban, dan tenggat", tindakan: [Peta mata kuliah dan milestone; mulai dari mata kuliah terendah; tenggat bertahap; batas tugas di luar proyek], waktu: [#w-setelah, #w-depan], pj: "Dosen rujukan dan dosen pengampu", tenggat: "Sisa semester: Minggu 14; semester berikutnya: Minggu 2"),
      (judul: "Materi dan konsultasi", tindakan: [Materi dua pekan sebelum milestone; sesi konsultasi terbuka], waktu: [#w-setelah], pj: "Dosen pengampu", tenggat: "Sebelum Demo Day (Minggu 16)"),
    )),
  )
}

// tiga baris "Tindak lanjut utama menurut waktu" untuk ringkasan eksekutif
#let tindak-lanjut-utama() = grid(columns: (92pt, 1fr), row-gutter: 14pt, column-gutter: 8pt,
  chip(w-ini, accent), [Umumkan ringkasan hasil kepada mahasiswa dan dosen, lalu bahas hasilnya dengan dosen pengampu lewat grup WhatsApp atau satu pertemuan singkat. Umumkan dosen rujukan (PIC) tiap kelas. Sampaikan ulang bobot nilai PBL dan ketentuan Milestone 2. Jangan ada tugas baru di luar proyek selama pekan Milestone 2.],
  chip(w-setelah, primary), [Koordinator PBL menyusun draf Juknis PBL Jurusan. Dosen rujukan tiap kelas menyusun peta keterkaitan mata kuliah dan milestone, dimulai dari mata kuliah dengan keselarasan terendah. Mulai aturan WhatsApp: catatan standar per milestone, konfirmasi dosen, dan keputusan di peta.],
  chip(w-depan, primary-mid), [Terbitkan Juknis PBL Jurusan sebelum semester dimulai. Isinya: peran koordinator dan dosen rujukan (kerja koordinator dipantau tiap milestone), skema PBL dengan bobot minimal 51% (IKU 7) di RPS semua mata kuliah, rubrik berbasis PBL, tenggat bertahap, aturan tim, halaman informasi per program studi, panduan fasilitas, survei singkat dengan sesi 10 menit di kelas, serta apresiasi dosen dan penghargaan produk PBL.],
)

// tabel keselarasan per mata kuliah, diurutkan dari kegiatan PBL terendah; empat terendah ditandai
#let sec-keselarasan-matkul(s) = {
  let cs = d.at(s).mhs.courses.sorted(key: c => c.acts_mean)
  let lab(c) = if s == "all" { c.prodi + " Sem " + str(c.sem) + " · " + c.course } else { "Sem " + str(c.sem) + " · " + c.course }
  table(
    columns: (2.4fr, auto, auto, auto, auto), align: (left, right, right, right, right),
    table.header[Mata kuliah][Kegiatan PBL][Keselarasan][Hasil kerja proyek][Latihan umum],
    ..for (i, c) in cs.enumerate() {
      let low = i < 4
      let f(x) = if low { text(weight: 700, fill: accent-dark)[#x] } else { x }
      (f(lab(c)), f(pc(c.acts_mean)), f(pc(c.bc_ya_mean)), f(pc(pick(c.type, "Deliverable proyek").pct)), f(pc(pick(c.type, "Latihan umum").pct)))
    },
  )
  note[Diurutkan dari skor kegiatan PBL terendah. Empat mata kuliah terendah dicetak tebal. Kegiatan PBL dan keselarasan adalah rerata jawaban "ya" mahasiswa pada butir kegiatan dan butir keselarasan mata kuliah itu. Hasil kerja proyek dan latihan umum adalah persentase mahasiswa yang menyebutnya sebagai bentuk tugas utama.]
}

#let sec-lampiran(extra: none) = {
  set text(size: 10pt)
  set par(leading: 0.65em, spacing: 0.9em)
  [
    *Sumber data.* Survei mahasiswa (#d.meta.mahasiswa_n responden) dan dosen (#d.meta.dosen_n responden) lewat Google Form. Jumlah mahasiswa berasal dari rekap nilai tengah semester 32 kelas (#d.meta.roster_n mahasiswa). Jumlah dosen berasal dari plotting dosen Gasal 2026/2027. Status tim dari Laporan Kemajuan tidak dimasukkan.

    *Cara menghitung.* Rerata skala 1–5 dihitung tanpa jawaban "tidak dapat menilai". "Setuju" berarti skor 4 dan 5. Pertanyaan pilih-banyak dilaporkan sebagai persentase responden yang memilih. Dosen yang mengampu di dua program studi dihitung di keduanya, jadi jumlah dosen TI dan SIB bersama-sama lebih besar daripada jumlah dosen total. Hubungan antar skor dihitung dengan korelasi Pearson antar skor responden. Penyusun laporan (Koordinator PBL TI) membaca semua komentar bebas mahasiswa dan mengelompokkannya dengan tangan. Satu komentar bisa masuk beberapa tema. Semua isian terbuka dosen (#tema-dosen.input isian dari #tema-dosen.penulis.n dari #d.meta.dosen_n dosen, termasuk jawaban "lainnya" yang diketik) juga dibaca dan dikelompokkan dengan tangan. Isian dosen dilaporkan ditulis ulang dengan kata lain, tanpa kutipan, dan dibaca sebagai usulan, bukan sebagai seberapa banyak dosen yang berpendapat sama.

    *Keterbatasan.*
    - Tingkat respons mahasiswa (#pc(d.all.mhs.response.rate, d: 1)) di bawah target 70% dan terpusat pada kelas yang dipantau Koordinator PBL TI. Jawaban kedua kelompok kelas serupa, tetapi kelas lain tetap kurang terwakili.
    - Korelasi dan perbandingan kelompok hanya menunjukkan hubungan, bukan sebab-akibat, dan berasal dari persepsi pada satu waktu. Selisih antara dosen dan mahasiswa menunjukkan perbedaan sudut pandang, bukan siapa yang benar. Angka per mata kuliah bukan penilaian terhadap dosen secara pribadi.
    - Komentar bebas tidak wajib, dan hanya sebagian mahasiswa yang mengisinya.
    - Keterangan tentang struktur PBL (dua koordinator, dan belum adanya juknis atau juklak di tingkat jurusan) berasal dari penyusun laporan, bukan dari survei. Angka target di rekomendasi dan cara kerja yang diusulkan (peta keterkaitan, aturan WhatsApp, sesi survei 10 menit) adalah usulan koordinator. Bobot minimal 51% adalah batas bawah skema PBL pada IKU 7.

    *Privasi.* Data yang dianalisis anonim dan hanya ditampilkan secara gabungan. Laporan tidak memuat nama atau NIM. Kutipan komentar mahasiswa ditulis tanpa nama dan tanpa menyebut dosen atau mata kuliah. Komentar dosen tidak dikutip karena kelompoknya kecil. Jawaban tidak diberikan kepada dosen secara individual dan tidak memengaruhi nilai.
    #extra
  ]
}
