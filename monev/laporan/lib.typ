// Shared styling, helpers and section builders for the three Monev PBL reports.
// Data: data/agregat.json (anonymous aggregates) and data/tema.json (coded student comments).

#let d = json("data/agregat.json")
#let tema = json("data/tema.json")

// ---------------------------------------------------------------- people (edit here)
#let tanggal = "7 November 2026"
#let bulan-tahun = "November 2026"
#let periode = "Semester Ganjil 2026/2027"
#let koordinator = (nama: "Dian Hanifudin Subhi, S.Kom., M.Kom.", jabatan: "Koordinator PBL TI")
#let kajur = (nama: "Mungki Astiningrum, S.T., M.Kom.", jabatan: "Ketua Jurusan Teknologi Informasi")
#let kaprodi-ti = (nama: "Dr. Ely Setyo Astuti, S.T., M.T.", jabatan: "Ketua Program Studi D-IV Teknik Informatika")
#let kaprodi-sib = (nama: "Hendra Pradibta, S.E., M.Sc.", jabatan: "Ketua Program Studi D-IV Sistem Informasi Bisnis")

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
#let keputusan() = callout("Catatan: waktu pelaksanaan", [
  Milestone 2 berlangsung pekan depan. Perbaikan yang mengubah cara kerja (rapat koordinasi rutin, penataan tugas, aturan tim, rubrik, server) tidak bisa selesai sebelum Milestone 2. Karena itu rekomendasi dibagi menjadi tiga waktu: *#w-ini* (hanya langkah komunikasi yang bisa dilakukan sebelum Milestone 2), *#w-setelah*, dan *#w-depan*.

  #v(4pt)
  Perbaikan itu baru bisa berlaku pada Milestone 2 jika Milestone 2 ditunda. Keputusan ini ada pada Ketua Jurusan dan Kaprodi. Laporan ini mengasumsikan Milestone 2 tetap sesuai jadwal. Jika ditunda, langkah pada "#w-setelah" bisa dimajukan.
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
  Laporan ini berisi hasil survei monev PBL dari mahasiswa dan dosen pengampu, sebagai dasar tindak lanjut. Setiap bagian menyebut langsung *apa yang baik* dan *apa yang bermasalah*, lalu menjelaskan artinya dan memberi rekomendasi.

  Cara membaca laporan:
  #v(4pt)
  #grid(columns: (auto, 1fr), column-gutter: 12pt, row-gutter: 14pt,
    box(width: 5pt, height: 34pt, fill: primary), [*Yang baik dan yang bermasalah.* Dua kotak di awal setiap bagian berisi temuan utama beserta angkanya.],
    box(width: 5pt, height: 34pt, fill: rgb("#4a6a85")), [*Apa artinya.* Penjelasan singkat tentang arti temuan dan hubungannya dengan temuan lain.],
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
  note[Jumlah mahasiswa diambil dari rekap nilai tengah semester tiap kelas. Jumlah dosen adalah dosen berbeda yang mengampu 13 mata kuliah PBL menurut plotting dosen Gasal 2026/2027; dosen yang mengampu di dua program studi dihitung sekali. #m.response.classes.filter(c => c.n == 0).len() dari #m.response.classes.len() kelas tidak punya responden sama sekali.]
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
    note[● kelas yang diampu Koordinator PBL TI; di sini pengisian survei diingatkan dan dipantau langsung.]
  }
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
    ..row("Tanpa pemantauan (hanya tautan)", mo.oth),
  )
  note[Puas dan Lanjut adalah rerata skala 1–5 untuk kepuasan dan keinginan melanjutkan PBL. Kelompok dengan kurang dari 5 responden tidak dilaporkan.]
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
  note[Rerata skala 1–5. Skor aspek D hanya dari butir fasilitas; beban kerja, koordinasi tim, dan kontribusi anggota diukur lewat pilihan masalah. "Pilih masalah" adalah persentase responden yang memilih minimal satu masalah di aspek itu.]
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
  note[Rerata skala 1–5, tanpa jawaban "tidak dapat menilai". Selisih = rerata dosen dikurangi rerata mahasiswa; selisih 0,50 ke atas dicetak tebal. Kategori rerata: 4,21–5,00 sangat baik; 3,41–4,20 baik; 2,61–3,40 cukup; 1,81–2,60 kurang; 1,00–1,80 sangat kurang.]
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
  note[Mahasiswa menjawab untuk tim mereka; dosen menjawab untuk rata-rata tim yang dibimbing.]
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
  note[Dihitung dari #p.n jawaban mata kuliah (#m.n mahasiswa dikali jumlah mata kuliah PBL di semesternya).]
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
  note[Persentase dihitung dari jumlah responden (#m.n mahasiswa, #l.n dosen). Tiap responden boleh memilih maksimal tiga hal, jadi totalnya lebih dari 100%.]
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
  subhead[Butir pelaksanaan yang paling berhubungan dengan kepuasan]
  table(
    columns: (1fr, 92pt, 92pt), align: (left, left, left),
    table.header[Butir][Korelasi dengan "puas"][Korelasi dengan "setuju dilanjutkan"],
    ..for c in dr.corr {
      let bar(r, col) = if r == none { [–] } else { grid(columns: (1fr, 28pt), column-gutter: 4pt, box(width: 100%, height: 8pt, fill: light, radius: 1pt)[#box(width: calc.max(r, 0) / 0.6 * 100%, height: 8pt, fill: col, radius: 1pt)], align(right, fmt(r, d: 2))) }
      (c.label, bar(c.r_puas, primary), bar(c.r_lanjut, primary-mid))
    },
  )
  note[Korelasi Pearson (0 sampai 1) antara skor butir dan skor kepuasan tiap responden. Makin tinggi, makin kuat hubungannya. Ini hubungan, belum tentu sebab-akibat.]
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
  note[Persentase dosen dihitung dari #l.n dosen; persentase mahasiswa dari #m.n mahasiswa. Kendala dan dukungan dapat dipilih maksimal tiga.]
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
  note[Kegiatan dosen: rerata persentase jawaban "sering" atau "selalu" pada 5 kegiatan. Keselarasan: rerata persentase jawaban "ya" pada 9 pernyataan tentang materi dan tugas. Angka tebal berwarna menandai nilai di bawah 50% (kegiatan, keselarasan), di bawah 60% (kehadiran), atau 40% ke atas (bobot tidak disampaikan). Angka ini adalah persepsi mahasiswa per mata kuliah, bukan penilaian terhadap dosen tertentu, dan tidak untuk disampaikan kepada dosen secara individual (Panduan Monev PBL bagian 7).]
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
  note[Kolom saran tidak wajib diisi; komentar kosong, "-", atau "tidak ada" tidak dihitung. #sc("lain") komentar membahas hal di luar tema yang ada, jadi ketiga persentase tidak berjumlah 100%.]
}

#let tri-line(k, s) = {
  let m = d.at(s).mhs
  let l = d.at(s).dosen
  let imp(lab) = pick(m.improve, lab).pct
  let bestp(lab) = pick(m.best, lab).pct
  let dr = m.drivers
  let cross(f) = dr.cross.filter(c => c.factor == f)
  if k == "koordinasi" {
    [Hanya #pc(m.coord.at(1).ya) mahasiswa menilai arahan antar mata kuliah konsisten, dan #pc(imp("Arahan dan tugas antar dosen tidak terkoordinasi")) memilih arahan yang tidak terkoordinasi sebagai masalah. Hanya #pc(l.coord_yn.at(2).ya) dosen mengatakan sudah ada kesepakatan peran.]
  } else if k == "beban" {
    let c = cross("Beban PBL dibanding waktu tersedia")
    let gb = if c.len() > 0 { c.first().groups.filter(x => x.label == "Berat atau sangat berat") } else { () }
    let gr = if c.len() > 0 { c.first().groups.filter(x => x.label == "Ringan atau sesuai") } else { () }
    [#pc(m.material.at(0).pct) mahasiswa mengatakan tugas mata kuliah menambah beban di luar proyek, dan #pc(m.workload_heavy_pct) menilai bebannya berat.#if gb.len() > 0 and gr.len() > 0 [ Yang menilai beban berat rata-rata puas #fmt(gb.first().puas, d: 2); yang menilai beban sesuai, #fmt(gr.first().puas, d: 2).]]
  } else if k == "tim" {
    [#pc(imp("Kontribusi anggota tim tidak seimbang")) memilih kontribusi anggota yang tidak seimbang sebagai masalah. Hanya #pc(m.ops.at(6).pct_agree) setuju bahwa penilaian adil bagi kontribusi tiap anggota.]
  } else if k == "kejelasan" {
    [#pc(imp("Kejelasan ketentuan (SOP dan rubrik)")) memilih kejelasan SOP dan rubrik sebagai masalah, padahal SOP dan template juga sering disebut hal baik (#pc(bestp("SOP dan template laporan membantu"))). Bobot nilai PBL tidak disampaikan pada #pc(pick(m.pooled.share, "Tidak disampaikan").pct) jawaban mata kuliah.]
  } else if k == "bimbingan" {
    [#pc(m.ops.at(3).pct_agree) setuju bimbingan dosen memadai. Namun #pc(m.consult_freq.items.at(0).pct) tim belum pernah berkonsultasi di luar jam kuliah, dan #pc(pick(m.material, "Materi pendukung kurang").pct) menyebut materi pendukung kurang.]
  } else if k == "nilai" {
    let r = dr.corr.filter(c => c.label.starts-with("Penilaian adil"))
    [Hanya #pc(m.ops.at(6).pct_agree) setuju penilaian adil dan #pc(m.ops.at(5).pct_agree) setuju rubrik jelas.#if r.len() > 0 and r.first().r_puas != none [ Keduanya termasuk yang paling berhubungan dengan kepuasan (korelasi #fmt(r.first().r_puas, d: 2) untuk keadilan).]]
  } else if k == "fasilitas" {
    [Fasilitas dan sumber daya adalah butir dengan rerata terendah (#fmt(m.ops.at(7).mean, d: 2)). #pc(imp("Fasilitas dan sumber daya (server, data, perangkat)")) responden memilihnya sebagai masalah, dan butir ini paling berhubungan dengan kepuasan.]
  } else if k == "baik" {
    [Sebagai hal yang paling baik, #pc(bestp("Pengalaman dan keterampilan baru yang saya peroleh")) memilih pengalaman dan keterampilan baru, #pc(bestp("SOP dan template laporan membantu")) SOP dan template, dan #pc(bestp("Bimbingan dosen")) bimbingan dosen.]
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
  note[Satu komentar bisa masuk lebih dari satu tema. Persentase dihitung dari komentar bermakna tiap program studi (TI #tema.substantive_ti, SIB #tema.substantive_sib), supaya keduanya bisa dibandingkan secara adil.]
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
  note[Kutipan disunting ringan (ejaan dan tanda baca) dan tidak memuat nama dosen atau mata kuliah.]

  subhead[Usulan konkret mahasiswa]
  bars(tema.usulan.filter(u => u.at(key) > 0).sorted(key: u => -u.at(key)).map(u => (label: u.label + " (" + str(u.at(key)) + ")", pct: 100 * u.at(key) / tot)), max: 20)
  note[Persentase komentar bermakna yang memuat usulan itu.]
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
      #text(size: 10pt)[#issue[Masalah.] #r.bukti]
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

// summary table for the evaluation meeting; rows: (judul, tindakan, waktu)
#let sec-rekom-tabel(rows) = {
  block(breakable: false, table(
    columns: (auto, 1.1fr, 1.5fr, 1.3fr, 1fr, 0.8fr, 0.7fr), align: (center, left, left, left, left, left, left),
    table.header[No][Masalah][Langkah][Waktu][Penanggung jawab][Tenggat][Status],
    ..for (i, r) in rows.enumerate() { (str(i + 1), r.judul, r.tindakan, r.waktu, [], [], []) },
  ))
  note[Kolom Waktu berisi waktu yang disarankan. Penanggung jawab, tenggat (tanggal), dan status diisi saat rapat evaluasi dengan dosen pengampu.]
}

#let sec-lampiran(extra: none) = {
  set text(size: 10pt)
  set par(leading: 0.65em, spacing: 0.9em)
  [
    *Sumber data.* Survei mahasiswa (#d.meta.mahasiswa_n responden) dan dosen (#d.meta.dosen_n responden) lewat Google Form. Jumlah mahasiswa: rekap nilai tengah semester 32 kelas (#d.meta.roster_n mahasiswa). Jumlah dosen: plotting dosen Gasal 2026/2027. Status tim dari Laporan Kemajuan tidak dimasukkan.

    *Cara menghitung.* Rerata skala 1–5 dihitung tanpa jawaban "tidak dapat menilai". "Setuju" berarti skor 4 dan 5. Pertanyaan pilih-banyak dilaporkan sebagai persentase responden yang memilih. Dosen yang mengampu di dua program studi dihitung di keduanya, jadi jumlah dosen TI dan SIB lebih besar daripada jumlah dosen total. Korelasi yang dipakai adalah korelasi Pearson antar skor responden. Penyusun laporan (Koordinator PBL TI) membaca semua komentar bebas mahasiswa dan mengelompokkannya secara manual; satu komentar bisa masuk beberapa tema. Komentar bebas dosen tidak dianalisis.

    *Keterbatasan.*
    - Tingkat respons mahasiswa (#pc(d.all.mhs.response.rate, d: 1)) di bawah target 70% dan terpusat pada kelas yang dipantau Koordinator PBL TI. Jawaban kedua kelompok kelas serupa, tetapi kelas lain tetap kurang terwakili.
    - Korelasi dan perbandingan kelompok hanya menunjukkan hubungan, bukan sebab-akibat, dan berasal dari persepsi pada satu waktu. Selisih antara dosen dan mahasiswa menunjukkan perbedaan sudut pandang, bukan siapa yang benar. Angka per mata kuliah tidak menilai dosen secara pribadi.
    - Komentar bebas tidak wajib, dan hanya sebagian mahasiswa yang mengisinya.

    *Privasi.* Data yang dianalisis bersifat anonim dan hanya ditampilkan secara gabungan. Laporan tidak memuat nama atau NIM. Kutipan komentar ditulis tanpa nama dan tanpa menyebut dosen atau mata kuliah. Jawaban tidak diberikan kepada dosen secara individual dan tidak memengaruhi nilai.
    #extra
  ]
}
