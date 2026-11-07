// Pustaka tata letak untuk empat contoh laporan Milestone 2.
// Arah: tata letak majalah yang tenang (huruf serif, kolom catatan di margin kanan, tabel bergaris tipis).
#let ink = rgb("#1b1b1b")
#let muted = rgb("#6b6b66")
#let rule-c = rgb("#bdbdb6")
#let accent = rgb("#b4532a")
#let accent-dark = rgb("#8a3d1c")
#let paper-grey = rgb("#f2f2ef")
#let serif = ("Georgia", "Libertinus Serif")
#let ui = ("Segoe UI", "Carlito")
#let mono = ("DejaVu Sans Mono", "Liberation Mono")
#let tw = 14.4cm   // lebar kolom teks
#let note-w = 3.2cm

// ---- label catatan (keterangan untuk pembaca contoh, tidak ditulis di laporan)
#let st-proposal = "dipindahkan dari proposal"
#let st-lanjutan = "dilanjutkan dari Laporan Kemajuan"
#let st-m2 = "ditulis pada Milestone 2"
#let st-akhir = "ditulis pada laporan akhir"
#let st-hapus = "dihapus pada laporan akhir"

#let margin-note(txt) = block(width: note-w, stroke: (top: 0.5pt + accent), inset: (top: 3pt), above: 0pt, below: 0pt)[
  #set par(justify: false, leading: 0.5em)
  #text(font: ui, size: 7.4pt, fill: muted)[Catatan contoh: #txt]
]
#let pill(label) = text(font: ui, size: 7.6pt, fill: muted)[Catatan contoh: #label]

// ---- nomor dan judul gambar, tabel, dan kode (dirujuk di teks dengan @label)
#let bab = state("bab", "1")
#let bab-title = state("bab-title", "")
#let reset-counters() = {
  for k in ("tabel", "gambar", "kode") { counter(figure.where(kind: k)).update(0) }
}
#let _fig(kind, supp, lbl, judul, body) = context {
  let b = bab.get()
  [#figure(body, kind: kind, supplement: supp, numbering: n => b + "." + str(n), caption: judul) #label(lbl)]
}
#let tabel(lbl, judul, body) = _fig("tabel", [Tabel], lbl, judul, align(left, body))
#let gambar(lbl, judul, body) = _fig("gambar", [Gambar], lbl, judul, body)
#let kode(lbl, judul, body) = _fig("kode", [Potongan kode], lbl, judul, align(left, body))
#let wide(body) = block(width: tw + 3.0cm, body)

// ---- tabel bergaris tipis
#let tbl(cols, head, rows, sz: 8.4pt) = {
  let last = rows.len()
  table(
    columns: cols, inset: (x: 5pt, y: 4pt), align: left + top,
    stroke: (x, y) => (
      top: if y == 0 { 0.9pt + ink } else if y == 1 { 0.5pt + ink } else { 0.25pt + rule-c },
      bottom: if y == last { 0.9pt + ink } else { none }),
    table.header(..head.map(h => table.cell(text(font: ui, weight: 700, size: sz)[#h]))),
    ..rows.flatten().map(c => text(font: ui, size: sz)[#c]),
  )
}

// ---- pembuka bab, bagian, dan subbagian
#let chapter(eb, title, icon-kind: none) = {
  let num = eb.split(" ").last()
  bab.update(num)
  bab-title.update(title)
  reset-counters()
  pagebreak(weak: true)
  place(hide(heading(level: 1)[#eb. #title]))
  v(0.6cm)
  grid(columns: (auto, 1fr), column-gutter: 0.5cm, align: bottom,
    text(font: serif, size: 58pt, fill: accent.lighten(25%))[#if num.len() == 1 { "0" + num } else { num }],
    { set par(justify: false); text(font: serif, size: 23pt, weight: 700)[#title] })
  v(0.3cm)
  line(length: 100%, stroke: 0.8pt + ink)
  v(0.5cm)
}
#let part(eb, title, icon-kind: none) = {
  bab.update("S")
  bab-title.update(title)
  reset-counters()
  place(hide(heading(level: 1)[#title]))
  text(font: ui, size: 8.6pt, fill: muted)[#eb]
  v(0.1cm)
  text(font: serif, size: 21pt, weight: 700)[#title]
  v(0.2cm)
  line(length: 100%, stroke: 0.8pt + ink)
  v(0.4cm)
}
#let sec(num, title, stage: none) = block(sticky: true, breakable: false, above: 1.5em, below: 0.85em, width: 100%)[
  #line(length: 100%, stroke: 0.4pt + rule-c)
  #v(0.15em)
  #heading(level: 2, outlined: false)[#if num != "" [#text(fill: accent)[#num]#h(0.55em)]#title]
  #if stage != none { place(top + left, dx: tw + 0.45cm, dy: 0.35em, margin-note(stage)) }
]
#let lamp(huruf, judul, stage: none) = {
  bab.update(huruf)
  bab-title.update("Lampiran " + huruf)
  reset-counters()
  sec("", "Lampiran " + huruf + ". " + judul, stage: stage)
}
// ringkasan satu-dua kalimat di bawah judul bab (bukan kartu)
#let lead(body) = block(width: 100%, below: 1.1em)[
  #set par(justify: false, leading: 0.7em)
  #text(font: serif, size: 11.6pt, fill: ink)[#body]
]
#let pending(body) = block(width: 100%, stroke: (dash: "dashed", paint: rule-c, thickness: 0.6pt), inset: 8pt)[
  #set par(justify: false)
  #text(font: ui, size: 8.4pt, fill: muted)[#body]
]
// lembar fakta: satu baris kunci dan nilai
#let fakta(items) = {
  let n = items.len()
  block(width: 100%, stroke: (top: 0.9pt + ink, bottom: 0.5pt + ink), inset: (y: 6pt))[
    #grid(columns: (1fr,) * n, column-gutter: 8pt,
      ..items.map(it => [
        #text(font: ui, size: 7.4pt, fill: muted)[#it.at(0)] \
        #text(font: serif, size: 10.5pt, weight: 700)[#it.at(1)]
      ]))
  ]
}
// kutipan tarik (paling banyak satu per contoh)
#let kutipan(body, dari) = block(width: 100%, inset: (left: 14pt, y: 4pt), stroke: (left: 2pt + accent), above: 1em, below: 1em)[
  #set par(justify: false, leading: 0.7em)
  #text(font: serif, size: 13pt, style: "italic")[#body] \
  #text(font: ui, size: 8pt, fill: muted)[#dari]
]

// ---- tangkapan layar (kotak kosong dengan tanda silang), keluaran terminal
#let _cross(w, h) = {
  place(top + left, line(start: (0pt, 0pt), end: (w, h), stroke: 0.5pt + rule-c))
  place(top + left, line(start: (0pt, h), end: (w, 0pt), stroke: 0.5pt + rule-c))
}
#let shot(lbl, judul, ht: 3.2cm) = gambar(lbl, judul, block(width: 100%, height: ht, stroke: 0.7pt + rule-c, fill: paper-grey, clip: true)[
  #layout(sz => _cross(sz.width, sz.height))
  #align(center + horizon, text(font: ui, size: 8pt, fill: muted)[tangkapan layar])
])
#let console(lbl, judul, body) = gambar(lbl, judul, align(left, block(breakable: false, width: 100%, fill: paper-grey, stroke: 0.5pt + rule-c, inset: 8pt)[
  #set par(justify: false, leading: 0.5em)
  #set text(font: mono, size: 7.4pt, fill: ink)
  #body.split("\n").join(linebreak())
]))

// ---- alur proses dan wireframe
#let flow(steps) = {
  let cells = ()
  for (i, st) in steps.enumerate() {
    if i > 0 { cells.push(align(center + horizon, text(font: ui, fill: ink)[→])) }
    cells.push(block(width: 100%, stroke: 0.6pt + ink, inset: 6pt, height: 1.4cm,
      align(center + horizon, { set par(justify: false); text(font: ui, size: 7.6pt)[#st] })))
  }
  grid(columns: range(cells.len()).map(i => if calc.odd(i) { auto } else { 1fr }), column-gutter: 3pt, ..cells)
}
// wireframe tingkat rendah. blocks: ((jenis, label, tinggi-cm), ...), jenis: bar, card, list, btn, input, chart, img
#let wire(title, blocks, w: 5cm, h: 8cm, kind: "phone") = block(width: w, height: h, stroke: 0.9pt + ink,
  radius: if kind == "phone" { 7pt } else { 0pt }, clip: true, fill: white)[
  #set block(spacing: 0pt)
  #block(width: 100%, height: 0.5cm, fill: rgb("#e4e4e0"), inset: (x: 5pt))[#align(horizon, text(font: ui, size: 6.4pt, weight: 700)[#title])]
  #pad(x: 5pt, y: 5pt)[
    #for b in blocks {
      let (ty, lb, ht) = b
      let fc = if ty == "btn" { rgb("#4a4a47") } else if ty == "input" { white } else if ty == "bar" { rgb("#e4e4e0") } else { rgb("#f0f0ed") }
      block(width: 100%, height: ht * 1cm, fill: fc, stroke: 0.5pt + rule-c, above: 0pt, below: 4pt, clip: true)[
        #if ty == "img" or ty == "chart" { _cross(w - 10pt, ht * 1cm) }
        #align(center + horizon, text(font: ui, size: 6.2pt, fill: if ty == "btn" { white } else { muted })[#lb])
      ]
    }
  ]
]

// ---- diagram Gantt gaya MS Project
#let gantt(tasks, weeks: 16, now: 12, total: 14.4cm, label-w: 5.6cm, rowh: 0.55cm) = {
  let wk = (total - label-w) / weeks
  let H = 0.55cm + rowh * tasks.len() + 0.9cm
  block(width: total, height: H, breakable: false)[
    #for w in range(weeks) {
      place(top + left, dx: label-w + wk * w, dy: 0cm, box(width: wk, height: 0.5cm, align(center + horizon, text(font: ui, size: 6.2pt, fill: muted)[#(w + 1)])))
    }
    #place(top + left, dx: 0cm, dy: 0.1cm, text(font: ui, size: 6.6pt, fill: muted)[Tugas \/ Minggu])
    #place(top + left, dx: 0cm, dy: 0.5cm, line(length: total, stroke: 0.7pt + ink))
    #for w in range(weeks + 1) {
      place(top + left, dx: label-w + wk * w, dy: 0.5cm, line(angle: 90deg, length: rowh * tasks.len(), stroke: 0.25pt + rule-c))
    }
    #for (i, t) in tasks.enumerate() {
      let y = 0.55cm + rowh * i
      place(top + left, dx: 0cm, dy: y, box(width: label-w - 0.2cm, height: rowh, align(horizon, text(font: ui, size: 6.6pt)[#t.at(0) #t.at(1)])))
      let (ps, pe) = t.at(2)
      place(top + left, dx: label-w + wk * (ps - 1), dy: y + 0.1cm, rect(width: wk * (pe - ps + 1), height: 0.16cm, fill: rgb("#cfcfca"), stroke: none))
      if t.at(3) != none {
        let (as_, ae) = t.at(3)
        place(top + left, dx: label-w + wk * (as_ - 1), dy: y + 0.29cm, rect(width: wk * (ae - as_ + 1), height: 0.16cm, fill: ink, stroke: none))
      }
    }
    #place(top + left, dx: 0cm, dy: 0.55cm + rowh * tasks.len(), line(length: total, stroke: 0.7pt + ink))
    #for cp in (4, 8, 12, 16) {
      place(top + left, dx: label-w + wk * cp, dy: 0.55cm + rowh * tasks.len() + 0.22cm, polygon(fill: ink, (0cm, -0.1cm), (0.1cm, 0cm), (0cm, 0.1cm), (-0.1cm, 0cm)))
    }
    #place(top + left, dx: label-w + wk * now, dy: 0.5cm, line(angle: 90deg, length: rowh * tasks.len() + 0.1cm, stroke: (paint: ink, thickness: 0.9pt, dash: "dashed")))
    #place(top + left, dx: 0cm, dy: 0.55cm + rowh * tasks.len() + 0.4cm, text(font: ui, size: 6.4pt, fill: muted)[Batang abu-abu: rencana. Batang hitam: realisasi. Belah ketupat: titik uji (Minggu 4, 8, 12, 16). Garis putus-putus: Minggu #now.])
  ]
}

// ---- Physical Data Model gaya alat diagram (notasi kaki gagak)
#let pdm(tables, links, cols: 5, total: 25.7cm, gap-x: 0.9cm, gap-y: 0.7cm, rowh: 0.37cm, hdrh: 0.5cm) = {
  let tw2 = (total - gap-x * (cols - 1)) / cols
  let nrows = calc.max(..tables.map(t => t.row)) + 1
  let th(t) = hdrh + rowh * t.cols.len()
  let rh = range(nrows).map(r => calc.max(0cm, ..tables.filter(t => t.row == r).map(t => th(t))))
  let ys = ()
  let acc = 0cm
  for r in range(nrows) { ys.push(acc); acc += rh.at(r) + gap-y }
  let H = acc - gap-y
  let geo = (:)
  for t in tables { geo.insert(t.name, (x: t.col * (tw2 + gap-x), y: ys.at(t.row), h: th(t), t: t, col: t.col, row: t.row)) }
  let rowidx(g, cn) = { let i = g.t.cols.position(c => c.at(0) == cn); if i == none { 0 } else { i } }
  let anchor(g, side, cn) = {
    if side == "r" { (g.x + tw2, g.y + hdrh + rowh * (rowidx(g, cn) + 0.5)) }
    else if side == "l" { (g.x, g.y + hdrh + rowh * (rowidx(g, cn) + 0.5)) }
    else if side == "t" { (g.x + tw2 / 2, g.y) }
    else { (g.x + tw2 / 2, g.y + g.h) }
  }
  let seg(a, b) = place(top + left, curve(stroke: 0.6pt + ink, curve.move(a), curve.line(b)))
  let dirv(side) = if side == "r" { (1, 0) } else if side == "l" { (-1, 0) } else if side == "t" { (0, -1) } else { (0, 1) }
  let symbol(kind, p, side) = {
    let d = dirv(side)
    let pp = (d.at(1), d.at(0))
    if kind == "N" {
      let q = (p.at(0) + d.at(0) * 0.3cm, p.at(1) + d.at(1) * 0.3cm)
      seg(q, (p.at(0) + pp.at(0) * 0.13cm, p.at(1) + pp.at(1) * 0.13cm))
      seg(q, p)
      seg(q, (p.at(0) - pp.at(0) * 0.13cm, p.at(1) - pp.at(1) * 0.13cm))
    } else {
      let c = (p.at(0) + d.at(0) * 0.22cm, p.at(1) + d.at(1) * 0.22cm)
      seg((c.at(0) + pp.at(0) * 0.1cm, c.at(1) + pp.at(1) * 0.1cm), (c.at(0) - pp.at(0) * 0.1cm, c.at(1) - pp.at(1) * 0.1cm))
    }
  }
  block(width: total, height: H, breakable: false)[
    #for (i, lk) in links.enumerate() {
      let gp = geo.at(lk.parent)
      let gc = geo.at(lk.child)
      let sides = if gp.col == gc.col { if gp.row < gc.row { ("b", "t") } else { ("t", "b") } } else if gp.col < gc.col { ("r", "l") } else { ("l", "r") }
      let a = anchor(gp, sides.at(0), lk.at("pk", default: "id"))
      let b = anchor(gc, sides.at(1), lk.fk)
      let off = 0.13cm * calc.rem(i, 4)
      let pts = if sides.at(0) in ("r", "l") {
        let mx = if sides.at(0) == "r" { b.at(0) - gap-x / 2 + off } else { b.at(0) + gap-x / 2 - off }
        (a, (mx, a.at(1)), (mx, b.at(1)), b)
      } else {
        let my = (a.at(1) + b.at(1)) / 2
        (a, (a.at(0), my), (b.at(0), my), b)
      }
      place(top + left, curve(stroke: 0.6pt + ink, curve.move(pts.at(0)), ..pts.slice(1).map(p => curve.line(p))))
      symbol(lk.at("a", default: "1"), a, sides.at(0))
      symbol(lk.at("b", default: "N"), b, sides.at(1))
    }
    #for g in geo.values() {
      let t = g.t
      place(top + left, dx: g.x, dy: g.y, block(width: tw2, height: g.h, stroke: 0.7pt + ink, clip: true, fill: white)[
        #set block(spacing: 0pt)
        #block(width: 100%, height: hdrh, fill: rgb("#dcdcd7"), inset: (x: 4pt), stroke: (bottom: 0.7pt + ink))[#align(horizon, text(font: ui, size: 7.4pt, weight: 700)[#t.name])]
        #for (i, c) in t.cols.enumerate() {
          let kk = c.at(2, default: "")
          block(width: 100%, height: rowh, inset: (x: 3pt))[
            #grid(columns: (0.62cm, 1fr, auto), align: horizon + left, column-gutter: 2pt,
              text(font: ui, size: 5.8pt, weight: 700)[#kk],
              text(font: mono, size: 6.4pt, weight: if kk.contains("PK") { 700 } else { 400 })[#c.at(0)],
              text(font: mono, size: 5.6pt, fill: muted)[#c.at(1)])
          ]
        }
      ])
    }
  ]
}
#let pdm-page(lbl, judul, tables, links, cols: 5) = page(flipped: true, margin: (x: 2cm, top: 2.4cm, bottom: 2.2cm))[
  #gambar(lbl, judul, pdm(tables, links, cols: cols))
]

// ---- matriks konfusi dalam skala abu-abu
#let confmat(labels, m) = {
  let n = labels.len()
  let mx = calc.max(..m.flatten())
  let cell(v, diag) = {
    let t = if diag { 0.2 + 0.7 * v / mx } else { 0.04 + 0.4 * v / mx }
    let shade = luma(int(255 - 215 * t))
    table.cell(fill: shade, align: center + horizon, text(font: ui, size: 8.6pt, weight: if diag { 700 } else { 400 }, fill: if t > 0.55 { white } else { ink })[#v])
  }
  table(
    columns: (auto,) + (1.3cm,) * n, rows: (auto,) + (0.9cm,) * n,
    stroke: 0.4pt + rule-c, inset: 4pt,
    table.cell(fill: white, text(font: ui, size: 7pt, fill: muted)[Aktual \ Prediksi]),
    ..labels.map(l => table.cell(align: center, text(font: ui, size: 7.6pt, weight: 700)[#l])),
    ..range(n).map(i => (
      table.cell(text(font: ui, size: 7.6pt, weight: 700)[#labels.at(i)]),
      ..range(n).map(j => cell(m.at(i).at(j), i == j)),
    )).flatten(),
  )
}

// ---- pembungkus dokumen
#let contoh(product: "", team: "", title: "", doc) = {
  set document(title: title)
  set text(font: serif, size: 10pt, fill: ink, lang: "id", hyphenate: true)
  set page(paper: "a4", margin: (left: 2.2cm, right: 4.4cm, top: 2.7cm, bottom: 2.4cm), numbering: none, fill: white,
    header: context {
      set text(font: ui, size: 7.6pt, fill: muted)
      let pg = here().page()
      let on = query(heading.where(level: 1)).filter(h => h.location().page() == pg)
      let lm = query(heading.where(level: 2)).filter(h => h.location().page() == pg and repr(h.body).contains("Lampiran"))
      let title = if on.len() > 0 { on.first().body } else if lm.len() > 0 { lm.first().body } else { bab-title.get() }
      grid(columns: (1fr, 1fr), smallcaps[#product · Laporan Milestone 2 PBL], align(right)[#title])
      v(-0.55em)
      line(length: 100%, stroke: 0.4pt + rule-c)
    },
    footer: context align(right, text(font: ui, size: 8pt, fill: muted)[#counter(page).display()]))
  set par(justify: true, leading: 0.66em, spacing: 0.95em)
  show raw: set text(font: mono, size: 7.8pt)
  show raw.where(block: true): it => block(width: 100%, fill: paper-grey, inset: 7pt, it)
  show heading.where(level: 2): it => text(font: serif, size: 12.2pt, weight: 700, fill: ink)[#it.body]
  show figure: set block(breakable: true, above: 1.1em, below: 1.3em)
  show figure.where(kind: "gambar"): set block(breakable: false)
  show figure.where(kind: "tabel"): set figure.caption(position: top)
  show figure.where(kind: "kode"): set figure.caption(position: top)
  show figure.where(kind: "kode"): set align(left)
  show table: set par(justify: false)
  show figure.caption: it => block(width: 100%, above: 0.2em, below: 0.45em, sticky: true)[
    #set text(font: ui, size: 8.2pt)
    #set par(justify: false)
    #text(weight: 700, fill: accent)[#it.supplement #context it.counter.display(it.numbering)]#h(5pt)#it.body
  ]
  set list(indent: 0.4em, spacing: 0.6em)
  doc
}

// ---- sampul: empat gaya majalah berita yang berbeda. Tim bebas memilih gayanya sendiri.
#let _at(x, y, body) = place(top + left, dx: x * 1cm, dy: y * 1cm, body)
#let _logo(x, y, w: 1.8cm) = _at(x, y, image("../monev/laporan/assets/logo-polinema.png", width: w))
#let _cover-page(body) = page(margin: 0pt, fill: white, numbering: none, header: none, footer: none, body)
#let _disp(sz, body, fill: ink, tracking: 0pt) = text(font: ("Impact", "Georgia"), size: sz, fill: fill, tracking: tracking, body)
#let _cap(sz, body, fill: ink) = text(font: ui, size: sz * 1pt, weight: 700, fill: fill, tracking: 0.6pt, upper(body))
#let _credits(x, y, w, team, class-line, prodi, members, year-line) = _at(x, y, block(width: w * 1cm)[
  #set par(justify: false, leading: 0.62em)
  #_cap(7.2, [Disusun oleh], fill: muted) \
  #text(font: serif, size: 10.6pt, weight: 700)[#team] \
  #text(font: serif, size: 9.4pt)[#members] \
  #v(0.12cm)
  #text(font: ui, size: 7.8pt, fill: muted)[#class-line · #prodi \ Politeknik Negeri Malang · #year-line]
])
#let _editor(x, y, w) = _at(x, y, block(width: w * 1cm, stroke: (top: 0.5pt + rule-c), inset: (top: 4pt))[
  #set par(justify: false, leading: 0.55em)
  #text(font: ui, size: 7.2pt, fill: muted)[*Catatan.* Sampul ini hanya salah satu cara. Tim bebas memilih gaya sampul dan tata letak laporan, selama susunan bagiannya diikuti. Nama, NIM, alamat, angka, dan tangkapan layar di contoh ini fiktif.]
])
#let _hl(headline, word, hi) = {
  let parts = headline.split(word)
  if parts.len() == 1 { headline } else { [#parts.at(0)#text(fill: hi)[#word]#parts.at(1)] }
}
#let _lines(items, w, sz: 10.4pt, hi: ink) = for (k, t) in items {
  block(width: w * 1cm, below: 0.5cm, stroke: (top: 1.2pt + hi), inset: (top: 5pt))[
    #set par(justify: false, leading: 0.55em)
    #_cap(7, k, fill: hi) \
    #text(font: serif, size: sz, weight: 700)[#t]
  ]
}

// SIKAP-PBL: tata letak ala Time. Bingkai berwarna, kotak kepala majalah, angka besar terpotong sebagai gambar
#let cover-sikap(product: "", subtitle: "", prodi: "", team: "", class-line: "", members: "", year-line: "", headline: "", accent-word: "", coverlines: ()) = _cover-page[
  #let ac = rgb("#1f7a57")
  #_at(0.55, 0.55, rect(width: 19.9cm, height: 28.6cm, stroke: 3.2pt + ac, fill: none))
  #_at(0.55, 0.55, rect(width: 19.9cm, height: 3.9cm, fill: ac))
  #_at(1.6, 0.9, _disp(78pt, product, fill: white, tracking: 1pt))
  #_at(14.2, 1.15, text(font: ui, size: 7.6pt, fill: white, weight: 700, tracking: 0.6pt)[LAPORAN PROYEK PBL])
  #_at(14.2, 1.65, text(font: ui, size: 7.6pt, fill: white)[Tahap Milestone 2])
  #_at(1.0, 4.9, text(font: "Impact", size: 470pt, fill: ac.lighten(84%))[12])
  #_at(1.6, 8.0, block(width: 11.8cm)[#set par(justify: false, leading: 0.08em); #_disp(58pt, _hl(upper(headline), upper(accent-word), ac))])
  #_at(1.6, 17.0, block(width: 10.5cm)[#set par(justify: false, leading: 0.7em); #text(font: serif, size: 12.6pt, fill: ink)[#subtitle]])
  #_at(14.5, 8.6, block(width: 4.9cm)[#_lines(coverlines, 4.9, sz: 10.2pt, hi: ac)])
  #_credits(1.6, 24.4, 15.5, team, class-line, prodi, members, year-line)
  #_editor(1.6, 27.4, 17.8)
]

// CELAH: tata letak ala Tempo. Papan kepala hitam, bidang warna penuh berisi judul sampul
#let cover-celah(product: "", subtitle: "", prodi: "", team: "", class-line: "", members: "", year-line: "", headline: "", accent-word: "", coverlines: ()) = _cover-page[
  #let ac = rgb("#f0a81a")
  #_at(0, 0, rect(width: 21cm, height: 4.2cm, fill: ink))
  #_at(1.5, 0.7, _disp(100pt, product, fill: ac, tracking: 2pt))
  #_at(0, 4.2, rect(width: 21cm, height: 15cm, fill: ac))
  #_at(1.5, 5.4, block(width: 17.6cm)[#set par(justify: false, leading: 0.06em); #_disp(72pt, upper(headline))])
  #_at(1.5, 16.2, block(width: 12.5cm)[#set par(justify: false, leading: 0.7em); #text(font: serif, size: 14pt, weight: 700)[#subtitle]])
  #_at(17.3, 15.6, circle(radius: 0.85cm, fill: ink))
  #_at(17.0, 17.0, polygon(fill: ink, (0cm, 0cm), (1.7cm, 0cm), (0.85cm, 1.9cm)))
  #_at(17.9, 16.1, circle(radius: 0.38cm, fill: ac))
  #_at(1.5, 20.2, grid(columns: (5.3cm, 5.3cm, 5.3cm), column-gutter: 0.7cm, ..coverlines.map(c => _lines((c,), 5.3, sz: 11pt, hi: ink))))
  #_credits(1.5, 24.2, 16, team, class-line, prodi, members, year-line)
  #_editor(1.5, 27.6, 18)
]

// CUCIKU: tata letak majalah gaya hidup. Kepala majalah vertikal di tepi kiri
#let cover-cucik(product: "", subtitle: "", prodi: "", team: "", class-line: "", members: "", year-line: "", headline: "", accent-word: "", coverlines: ()) = _cover-page[
  #let ac = rgb("#1d6fb0")
  #_at(1.0, 26.6, rotate(-90deg, origin: top + left, _disp(190pt, product, fill: ac, tracking: 2pt)))
  #_at(6.8, 1.7, grid(columns: (4.1cm, 4.1cm, 4.1cm), column-gutter: 0.6cm, ..coverlines.map(c => _lines((c,), 4.1, sz: 9.4pt, hi: ac))))
  #_at(6.8, 7.6, line(length: 12.4cm, stroke: 0.6pt + ink))
  #_at(6.8, 8.0, text(font: serif, size: 12.6pt, fill: muted)[#subtitle])
  #_at(6.8, 14.9, rect(width: 3.2cm, height: 0.3cm, fill: ac))
  #_at(6.8, 15.7, block(width: 12.4cm)[#set par(justify: false, leading: 0.3em); #text(font: serif, size: 50pt, weight: 700)[#_hl(headline, accent-word, ac)]])
  #_credits(6.8, 23.4, 12.4, team, class-line, prodi, members, year-line)
  #_editor(6.8, 27.2, 12.4)
]

// KOSKU: tata letak mingguan klasik. Kepala majalah serif di tengah, judul sampul berbingkai
#let cover-kosku(product: "", subtitle: "", prodi: "", team: "", class-line: "", members: "", year-line: "", headline: "", accent-word: "", coverlines: ()) = _cover-page[
  #let ac = rgb("#a8402a")
  #_at(1.8, 1.5, line(length: 17.4cm, stroke: 2.4pt + ink))
  #_at(1.8, 1.66, line(length: 17.4cm, stroke: 0.6pt + ink))
  #_at(1.8, 2.3, align(center, block(width: 17.4cm, text(font: ("Georgia"), size: 96pt, weight: 700, tracking: 8pt)[#product])))
  #_at(1.8, 5.5, line(length: 17.4cm, stroke: 0.6pt + ink))
  #_at(1.8, 5.66, line(length: 17.4cm, stroke: 2.4pt + ink))
  #_at(1.8, 7.6, rect(width: 17.4cm, height: 8.4cm, stroke: 4pt + ac, fill: white))
  #_at(1.8, 8.9, align(center, block(width: 17.4cm)[
    #v(0.3cm)
    #block(width: 14.8cm)[#set par(justify: false, leading: 0.34em); #text(font: serif, size: 44pt, weight: 700)[#_hl(headline, accent-word, ac)]]
    #v(0.3cm)
    #text(font: serif, size: 12.6pt, style: "italic")[#subtitle]
  ]))
  #_at(1.8, 17.6, grid(columns: (5.5cm, 5.5cm, 5.5cm), column-gutter: 0.45cm, ..coverlines.map(c => _lines((c,), 5.5, sz: 11pt, hi: ac))))
  #_credits(1.8, 23.6, 17.4, team, class-line, prodi, members, year-line)
  #_editor(1.8, 27.6, 17.4)
]

// ---- catatan untuk pembaca contoh (halaman pertama setelah sampul)
#let usage-note() = {
  part("Catatan untuk pembaca contoh", "Cara Memakai Contoh Ini")
  [Ikuti susunannya, tulis isinya dari proyek tim sendiri. Contoh ini memperlihatkan urutan bagian, bentuk tabel, dan kedalaman isi yang diharapkan. Laporan yang hanya menyalin contoh tidak diterima. Tata letak, warna, huruf, dan gaya sampul bebas. Yang diperiksa hanyalah susunan bagian dan kelengkapan isinya.]
  parbreak()
  [Satu laporan tumbuh dalam tiga tahap, sehingga tidak ada bagian yang perlu ditulis ulang dari awal. Di margin kanan beberapa bagian terdapat catatan kecil bertanda "Catatan contoh". Catatan itu hanya untuk pembaca contoh dan *tidak ditulis di laporan*. Artinya:]
  v(0.2em)
  tbl((3.4cm, 1fr), ([Catatan di margin], [Artinya]), (
    ([#st-proposal], [Isinya berasal dari proposal. Gunakan isi proposal, lalu perbarui.]),
    ([#st-lanjutan], [Isinya berasal dari Laporan Kemajuan. Perbarui sampai Minggu 12.]),
    ([#st-m2], [Mulai ditulis pada Milestone 2 dan dilengkapi pada laporan akhir.]),
    ([#st-akhir], [Pada Milestone 2 cukup judulnya. Isinya ditulis pada laporan akhir.]),
    ([#st-hapus], [Hanya untuk Milestone 2. Bagian ini dihapus dari laporan akhir.]),
  ), sz: 8.4pt)
  v(1.2em)
}

// ---- daftar isi, tabel, dan gambar
#let toc-page() = {
  part("Daftar", "Isi Laporan")
  // satu gaya untuk semua daftar: huruf UI kecil, titik halus, nomor halaman di kanan
  show outline.entry: it => block(above: 0.38em, below: 0.38em, width: 100%)[
    #set par(justify: false)
    #text(font: ui, size: 9pt)[#link(it.element.location())[#it.indented(it.prefix(), it.body() + box(width: 1fr, repeat(text(fill: rule-c)[ . ])) + it.page())]]
  ]
  let judul(t) = {
    v(0.8em)
    block(sticky: true, below: 0.5em, width: 100%)[
      #text(font: ui, size: 8.6pt, fill: accent, weight: 700, tracking: 0.04em)[#t]
      #v(-0.35em)
      #line(length: 100%, stroke: 0.4pt + rule-c)
    ]
  }
  judul("Bagian laporan")
  outline(title: none, depth: 1, indent: 0pt)
  v(0.2em)
  text(font: ui, size: 8pt, fill: muted)[Pada laporan akhir, Lembar Status dihapus dan daftar isi disesuaikan.]
  judul("Daftar gambar")
  outline(title: none, target: figure.where(kind: "gambar"), indent: 0pt)
  judul("Daftar tabel")
  outline(title: none, target: figure.where(kind: "tabel"), indent: 0pt)
  judul("Daftar potongan kode")
  outline(title: none, target: figure.where(kind: "kode"), indent: 0pt)
}
