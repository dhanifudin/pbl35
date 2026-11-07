// Shared Typst style for the Milestone 2 documents (SOP, Template, Contoh Laporan).
#let primary = rgb("#0f5f4c")
#let accent = rgb("#c65a2e")
#let light = rgb("#e9f3ef")
#let border-c = rgb("#c3d8cf")
#let ink = rgb("#1c2420")
#let muted = rgb("#5d6b65")
#let fonts = ("Carlito", "Liberation Sans")

#let conf(title: "", header-note: none, doc) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: (x: 2.2cm, top: 2.4cm, bottom: 2.2cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8.5pt, fill: muted)
        if header-note != none { text(fill: accent, weight: "bold")[#header-note] ; h(1fr) } else { h(1fr) }
        title
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + border-c)
      }
    },
    footer: context {
      set text(size: 8.5pt, fill: muted)
      h(1fr)
      counter(page).display()
    },
  )
  set text(font: fonts, size: 11pt, lang: "id", fill: ink)
  set par(justify: false, leading: 0.7em, spacing: 1em)
  show heading: set text(fill: primary, weight: "bold")
  show heading.where(level: 1): set text(size: 19pt)
  show heading.where(level: 1): set block(above: 1.6em, below: 0.9em)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 2): set block(above: 1.4em, below: 0.7em)
  show heading.where(level: 3): set text(size: 12pt)
  show heading.where(level: 3): set block(above: 1.2em, below: 0.6em)
  show heading: it => block(breakable: false, it)
  show raw: set text(font: ("DejaVu Sans Mono", "Liberation Mono"), size: 9pt)
  show raw.where(block: true): it => block(
    width: 100%, fill: rgb("#f4f6f5"), inset: 9pt, radius: 3pt, stroke: 0.5pt + border-c, it)
  show link: set text(fill: primary)
  set table(
    inset: (x: 6pt, y: 5pt),
    align: left,
    stroke: 0.5pt + border-c,
    fill: (_, y) => if y == 0 { light } else { none },
  )
  show table.cell.where(y: 0): set text(weight: "bold")
  show table: set text(size: 10pt)
  show figure.where(kind: table): set block(breakable: true)
  show figure: set block(breakable: true)
  show quote.where(block: true): it => block(
    width: 100%, fill: rgb("#fbf1ea"), inset: 10pt,
    stroke: (left: 3pt + accent), radius: (right: 3pt), it.body)
  set list(indent: 0.6em, spacing: 0.7em)
  set enum(indent: 0.6em, spacing: 0.7em)
  doc
}

// Blocks used by the hand-written example
#let note(body, color: accent) = block(
  width: 100%, fill: color.lighten(88%), inset: 10pt, radius: 3pt,
  stroke: (left: 3pt + color), body)
#let placeholder(label) = block(
  width: 100%, height: 3.2cm, fill: rgb("#f4f6f5"), stroke: (dash: "dashed", paint: muted),
  radius: 3pt, align(center + horizon, text(fill: muted, size: 9.5pt)[#label]))
