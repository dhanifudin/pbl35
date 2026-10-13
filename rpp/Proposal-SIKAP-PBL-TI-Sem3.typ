// SIKAP-PBL proposal: original pitch-deck-style layout (not derived from the
// RPP/Format-Proposal document skeleton). Substance (entities, roles, scope)
// still satisfies RPP-PBL-TI-Sem3.md's product requirements.

#let primary = rgb("#0f5f4c")
#let primary-dark = rgb("#093f33")
#let accent = rgb("#c65a2e")
#let accent-dark = rgb("#8f3f1d")
#let light = rgb("#e9f3ef")
#let light-2 = rgb("#f9ece4")
#let border-c = rgb("#c3d8cf")
#let text-c = rgb("#1c2420")
#let ok-green = rgb("#1f8a5c")
#let ok-bg = rgb("#e7f5ee")

#set text(font: "Segoe UI", size: 10.8pt, fill: text-c, lang: "id")
#set page(paper: "a4", margin: (x: 2cm, y: 2cm), numbering: none)
#set par(justify: true, leading: 0.68em)

#let eyebrow(label) = text(size: 10.5pt, weight: 700, fill: accent-dark, tracking: 2pt)[#upper(label)]

// Small hand-drawn line-icons (circles/rects/lines only, same technique as
// the ERD diagram) used as section-opener accents instead of a flat color
// bar. Each is built inside a 12x12pt box, top-left anchored.
#let icon(kind) = box(width: 13pt, height: 10pt)[
  #if kind == "person" [
    #place(dx: 3.5pt, dy: 0pt, circle(radius: 2.4pt, fill: accent))
    #place(dx: 1pt, dy: 5.5pt, rect(width: 11pt, height: 6pt, radius: (top-left: 5pt, top-right: 5pt), fill: accent))
  ] else if kind == "chart" [
    #place(dx: 0pt, dy: 6pt, rect(width: 2.6pt, height: 6pt, fill: accent))
    #place(dx: 4.7pt, dy: 2pt, rect(width: 2.6pt, height: 10pt, fill: accent))
    #place(dx: 9.4pt, dy: 4pt, rect(width: 2.6pt, height: 8pt, fill: accent))
  ] else if kind == "alert" [
    #place(dx: 1pt, dy: 0pt, rect(width: 11pt, height: 11pt, radius: 2.5pt, stroke: 1.4pt + accent))
    #place(dx: 5.7pt, dy: 2.8pt, rect(width: 1.6pt, height: 4pt, fill: accent))
    #place(dx: 5.7pt, dy: 7.8pt, circle(radius: 0.9pt, fill: accent))
  ] else if kind == "spark" [
    #place(dx: 3.3pt, dy: 1.8pt, circle(radius: 3.2pt, fill: accent))
    #place(dx: 0pt, dy: 0pt, line(start: (0pt, 0pt), end: (2.4pt, 2pt), stroke: 1.3pt + accent))
    #place(dx: 13pt, dy: 0pt, line(start: (0pt, 0pt), end: (-2.4pt, 2pt), stroke: 1.3pt + accent))
    #place(dx: 0pt, dy: 10pt, line(start: (0pt, 0pt), end: (2.4pt, -2pt), stroke: 1.3pt + accent))
    #place(dx: 13pt, dy: 10pt, line(start: (0pt, 0pt), end: (-2.4pt, -2pt), stroke: 1.3pt + accent))
  ] else if kind == "scope" [
    #place(dx: 0.5pt, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 11pt), stroke: 1.6pt + accent))
    #place(dx: 0.5pt, dy: 0pt, line(start: (0pt, 0pt), end: (2.8pt, 0pt), stroke: 1.6pt + accent))
    #place(dx: 0.5pt, dy: 11pt, line(start: (0pt, 0pt), end: (2.8pt, 0pt), stroke: 1.6pt + accent))
    #place(dx: 10.5pt, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 11pt), stroke: 1.6pt + accent))
    #place(dx: 10.5pt, dy: 0pt, line(start: (0pt, 0pt), end: (-2.8pt, 0pt), stroke: 1.6pt + accent))
    #place(dx: 10.5pt, dy: 11pt, line(start: (0pt, 0pt), end: (-2.8pt, 0pt), stroke: 1.6pt + accent))
  ] else if kind == "layers" [
    #place(dx: 0pt, dy: 0.5pt, rect(width: 13pt, height: 2.6pt, radius: 1pt, fill: accent))
    #place(dx: 1pt, dy: 4.7pt, rect(width: 11pt, height: 2.6pt, radius: 1pt, fill: accent))
    #place(dx: 2pt, dy: 8.9pt, rect(width: 9pt, height: 2.6pt, radius: 1pt, fill: accent))
  ] else if kind == "team" [
    #place(dx: 0pt, dy: 2pt, circle(radius: 3.6pt, fill: accent))
    #place(dx: 5.5pt, dy: 2pt, circle(radius: 3.6pt, fill: accent-dark))
  ] else if kind == "flag" [
    #place(dx: 1pt, dy: 0pt, line(start: (0pt, 0pt), end: (0pt, 12pt), stroke: 1.6pt + accent))
    #place(dx: 1.4pt, dy: 0pt, rect(width: 8pt, height: 5.5pt, fill: accent))
  ] else if kind == "link" [
    #place(dx: 0pt, dy: 3pt, circle(radius: 3.4pt, stroke: 1.6pt + accent))
    #place(dx: 5.2pt, dy: 3pt, circle(radius: 3.4pt, stroke: 1.6pt + accent))
  ] else if kind == "doc" [
    #place(dx: 1.5pt, dy: 0pt, rect(width: 9pt, height: 11.5pt, radius: 1.2pt, stroke: 1.4pt + accent))
    #place(dx: 3.5pt, dy: 3.8pt, line(length: 5pt, stroke: 1pt + accent))
    #place(dx: 3.5pt, dy: 6.4pt, line(length: 5pt, stroke: 1pt + accent))
  ]
]

#let section-title(eyebrow-text, title, icon-kind: "spark") = block(above: 0em, below: 1em)[
  #box(width: 22pt, height: 22pt, radius: 999pt, fill: light, baseline: 5.5pt)[
    #align(center + horizon, icon(icon-kind))
  ]
  #h(5pt) #eyebrow(eyebrow-text)
  #v(-0.3em)
  #text(size: 22pt, weight: 800, fill: primary)[#title]
]

// Full-bleed page decoration. Header/footer bands use the dedicated
// header:/footer: page fields (re-evaluated fresh on every page, so
// counter(page) stays accurate) and bleed past the 2cm content margin via
// negative placement + a "100% + 4cm" width.
#let page-header = place(dx: -2cm, dy: 0pt, rect(width: 100% + 4cm, height: 0.85cm, fill: primary)[
  #pad(x: 2cm)[
    #align(horizon)[
      #text(fill: white, size: 8.5pt, weight: 800, tracking: 1pt)[SIKAP-PBL]
      #h(1fr)
      #text(fill: rgb("#cfe8de"), size: 7.5pt)[Koyok Ngene Lho]
    ]
  ]
])

#let page-footer = context [
  #place(dx: -2cm, dy: 0pt, rect(width: 100% + 4cm, height: 1cm, fill: primary)[
    #pad(x: 2cm)[
      #align(horizon)[
        #grid(columns: (1.4fr, 1.2fr, auto),
          text(fill: rgb("#cfe8de"), size: 7.5pt, weight: 600)[SIKAP-PBL · Koyok Ngene Lho],
          align(center)[#text(fill: rgb("#cfe8de"), size: 7.5pt)[Politeknik Negeri Malang]],
          align(right)[#text(fill: white, size: 7.5pt, weight: 700)[#counter(page).display()]],
        )
      ]
    ]
  ])
]

#let card(fill-c, body) = block(
  width: 100%, fill: fill-c, radius: 8pt, inset: 12pt, above: 0pt, below: 0pt, breakable: false,
)[#set par(justify: false); #body]

#let dot() = box(width: 9pt, height: 9pt, radius: 999pt, fill: accent)

#let feature-card(role, title, body) = block(
  width: 100%, radius: 8pt, stroke: 1pt + border-c, inset: 12pt, above: 0.5em, below: 0.5em,
  breakable: false,
)[
  #set par(justify: false)
  #box(width: 22pt, height: 22pt, radius: 5pt, fill: light)[
    #align(center + horizon, dot())
  ]
  #v(0.35em)
  #text(size: 7.6pt, weight: 700, fill: accent-dark, tracking: 1pt)[#upper(role)]
  #v(0.1em)
  #text(size: 10.5pt, weight: 700, fill: primary-dark)[#title]
  #v(0.15em)
  #text(size: 9.3pt)[#body]
]

// Solid-fill tiles. Alternates primary/accent backgrounds for color variety,
// but text is always white/light on both: accent (orange) and primary
// (green) never sit together as text-on-fill, which is what caused the
// low-contrast clash the earlier version had.
#let stat-tile(value, label, fill-c: primary) = block(
  width: 100%, fill: fill-c, radius: 8pt, inset: (x: 10pt, y: 12pt), breakable: false,
)[
  #set align(center)
  #text(size: 22pt, weight: 800, fill: white)[#value] \
  #text(size: 8.6pt, fill: white.transparentize(15%), weight: 600)[#upper(label)]
]

// Magazine-style two-column running text. Each argument is one paragraph;
// paragraphs are split left/right (first half left, rest right) so reading
// order stays top-to-bottom-left-then-right, and the split is explicit
// rather than relying on auto-reflow (which leaves a column empty when the
// text is short enough to fit in the first column alone).
#let mag(..paragraphs) = {
  let ps = paragraphs.pos()
  let half = calc.ceil(ps.len() / 2)
  let left = ps.slice(0, half)
  let right = ps.slice(half)
  set text(size: 9.6pt)
  set par(justify: false, leading: 0.62em)
  grid(columns: (1fr, 1fr), column-gutter: 16pt,
    left.join(v(0.6em)),
    if right.len() > 0 { right.join(v(0.6em)) } else { [] },
  )
}

#let avatar(initials, c) = box(width: 34pt, height: 34pt, radius: 999pt, fill: c)[
  #align(center + horizon, text(size: 11pt, weight: 800, fill: white)[#initials])
]

// ---------------------------------------------------------------------
// SAMPUL
// ---------------------------------------------------------------------
#page(fill: primary-dark, margin: 0pt, numbering: none)[
  #place(top + left, dx: -3cm, dy: -4cm, circle(radius: 8.5cm, fill: primary))
  #place(bottom + right, dx: 3cm, dy: 3.5cm, circle(radius: 6cm, fill: rgb("#0b4a3b")))
  #place(top + right, dx: -1.4cm, dy: 7.6cm, rect(width: 3.8cm, height: 3.8cm, fill: accent, radius: 999pt))

  #v(2.6cm)
  #box(inset: (left: 2.2cm, right: 2.2cm))[
    #text(size: 13pt, fill: rgb("#cfe8de"), weight: 700, tracking: 3pt)[
      PROPOSAL PRODUK PBL
    ]
    #v(0.25cm)
    #text(size: 13pt, fill: rgb("#cfe8de"))[
      Program Studi Teknik Informatika, Semester 3, Politeknik Negeri Malang
    ]

    #v(1.6cm)
    #text(size: 62pt, weight: 800, fill: white)[SIKAP-PBL]
    #v(0.2cm)
    #text(size: 19pt, weight: 500, fill: accent)[
      Sistem Informasi Kontribusi, Aktivitas, dan Partisipasi PBL
    ]

    #v(1.1cm)
    #block(width: 88%, fill: rgb("#07332a"), inset: 16pt, radius: 8pt)[
      #text(size: 13pt, style: "italic", fill: rgb("#e9f3ef"))[
        "Karena rubrik penilaian butuh bukti kontribusi, bukan asumsi dan laporan lisan menit terakhir."
      ]
    ]

    #v(2.2cm)
    #text(size: 12pt, fill: rgb("#cfe8de"), weight: 700)[KOYOK NGENE LHO]
    #v(0.2cm)
    #text(size: 11pt, fill: rgb("#a9d3c2"))[
      Raka Aditya Pratama, Salsabila Rahma Putri, Farrel Ibrahim Nugroho, Nadia Kirana Sari
    ]

    #v(1.6cm)
    #box(fill: accent, radius: 999pt, inset: (x: 12pt, y: 6pt))[
      #text(size: 9pt, fill: white, weight: 700, tracking: 1.5pt)[DOKUMEN CONTOH, UNTUK KEPERLUAN PEMBELAJARAN]
    ]
    #v(0.35cm)
    #box(fill: primary, radius: 999pt, inset: (x: 12pt, y: 6pt))[
      #text(size: 9pt, fill: white, weight: 700, tracking: 1.5pt)[TATA LETAK BEBAS, ISI IKUTI STRUKTUR PROPOSAL]
    ]
  ]
]

#set page(
  numbering: none, fill: white, margin: (x: 2cm, y: 2cm),
  header: page-header, footer: page-footer,
)
#counter(page).update(1)

// ---------------------------------------------------------------------
// IDENTITAS (formal: identity data, course/lecturer info)
// ---------------------------------------------------------------------
#section-title("Identitas", "Tim dan Mata Kuliah Terintegrasi", icon-kind: "person")

#v(1fr)

#eyebrow("Identitas Tim")
#v(0.7em)
#table(
  columns: (2fr, 1.3fr, 2fr),
  stroke: 0.7pt + border-c,
  inset: 11pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 11pt)[Nama]),
  table.cell(text(fill: white, weight: 700, size: 11pt)[NIM]),
  table.cell(text(fill: white, weight: 700, size: 11pt)[Peran]),
  text(size: 11pt)[Raka Aditya Pratama], text(size: 11pt)[2341720011], text(size: 11pt)[Ketua Tim & Pengembang Utama],
  text(size: 11pt)[Salsabila Rahma Putri], text(size: 11pt)[2341720012], text(size: 11pt)[Analis/Desainer],
  text(size: 11pt)[Farrel Ibrahim Nugroho], text(size: 11pt)[2341720013], text(size: 11pt)[Sekretaris/Dokumentator],
  text(size: 11pt)[Nadia Kirana Sari], text(size: 11pt)[2341720014], text(size: 11pt)[QA/Penguji],
)

#v(1.6em)
#eyebrow("Mata Kuliah Terintegrasi dan Dosen Pengampu")
#v(0.7em)
#table(
  columns: (2fr, 2fr, 1fr),
  stroke: 0.7pt + border-c,
  inset: 11pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 11pt)[Mata Kuliah]),
  table.cell(text(fill: white, weight: 700, size: 11pt)[Dosen Pengampu]),
  table.cell(text(fill: white, weight: 700, size: 11pt)[Kelas]),
  text(size: 11pt)[Manajemen Proyek], text(size: 11pt)[Dian Hanifudin Subhi, M.Kom.], text(size: 11pt)[TI-3C],
  text(size: 11pt)[Desain dan Pemrograman Web], text(size: 11pt)[Dian Hanifudin Subhi, M.Kom.], text(size: 11pt)[TI-3C],
  text(size: 11pt)[Basis Data Lanjut], text(size: 11pt)[Dian Hanifudin Subhi, M.Kom.], text(size: 11pt)[TI-3C],
  text(size: 11pt)[Sistem Informasi Manajemen], text(size: 11pt)[Dian Hanifudin Subhi, M.Kom.], text(size: 11pt)[TI-3C],
)
#v(0.5em)
#text(size: 9.5pt, style: "italic", fill: accent-dark)[Seluruh mata kuliah terintegrasi berjalan pada
Semester 3, Tahun Akademik 2026/2027.]

#v(1fr)
#pagebreak()

// ---------------------------------------------------------------------
// RINGKASAN
// ---------------------------------------------------------------------
#section-title("Ringkasan", "Bukti, Bukan Asumsi", icon-kind: "chart")

#block(width: 100%, fill: primary-dark, radius: 10pt, inset: 14pt)[
  #set par(justify: true)
  #text(size: 12pt, style: "italic", fill: white)[
    Pembagian kerja pada proyek kelompok PBL kerap dilaporkan merata di atas kertas. Riwayat aktivitas
    nyata, seperti commit, kehadiran rapat, dan jejak percakapan tim, tidak selalu mendukung klaim itu.
  ]
]

#v(0.7em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt, row-gutter: 10pt,
  card(light-2)[
    #text(size: 9.5pt, weight: 700, fill: accent-dark)[MASALAH 1]
    #v(0.3em)
    #text(size: 8.6pt)[Dosen pengampu menilai partisipasi individu tanpa data yang memadai; satu dosen
    mengampu 6 tim atau lebih pada satu checkpoint, sehingga penilaian kontribusi sering bersandar pada
    laporan lisan ketua tim. Nilai kontribusi individu akhirnya disamaratakan, meskipun beban kerja
    tidak pernah benar-benar merata.]
  ],
  card(light)[
    #text(size: 9.5pt, weight: 700, fill: primary-dark)[SOLUSI 1]
    #v(0.3em)
    #text(size: 8.6pt)[SIKAP-PBL mengganti laporan lisan itu dengan bukti: catatan aktivitas mingguan,
    checklist tugas, dan log kontribusi yang tersimpan otomatis. Hasilnya satu dashboard partisipasi
    yang bisa dibuka kapan saja, selaras dengan rubrik penilaian checkpoint yang berlaku.]
  ],
  card(light-2)[
    #text(size: 9.5pt, weight: 700, fill: accent-dark)[MASALAH 2]
    #v(0.3em)
    #text(size: 8.6pt)[Masalah serupa terjadi di level manajemen: koordinator PBL mengawasi banyak dosen
    pengampu sekaligus, namun tidak punya cara sistematis mengetahui dosen mana yang aktif
    menindaklanjuti laporan tim dan mana yang hanya membaca tanpa merespons.]
  ],
  card(light)[
    #text(size: 9.5pt, weight: 700, fill: primary-dark)[SOLUSI 2]
    #v(0.3em)
    #text(size: 8.6pt)[Pendekatan yang sama diterapkan pada level manajemen lewat Rekap Keterlibatan
    Dosen, yang merangkum status baca dan tindak lanjut tiap dosen lintas tim dan checkpoint, sehingga
    koordinator dapat menindaklanjuti dosen yang jarang merespons.]
  ],
)

#v(0.6em)
#block(width: 100%, fill: light-2, radius: 8pt, inset: 10pt)[
  #set par(justify: false)
  #text(size: 9pt)[*Tujuan Proyek:* menghasilkan aplikasi web SIKAP-PBL yang berjalan penuh pada akhir
  Minggu 16, dengan dashboard partisipasi yang tidak lagi bergantung pada laporan lisan ketua tim.]
]

#v(0.6em)
#grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 10pt,
  stat-tile("4", "Entitas Data", fill-c: primary),
  stat-tile("4", "Peran Pengguna", fill-c: accent),
  stat-tile("16", "Minggu", fill-c: primary),
  stat-tile("1", "Dashboard Partisipasi", fill-c: accent),
)

#pagebreak()

// ---------------------------------------------------------------------
// MASALAH
// ---------------------------------------------------------------------
#section-title("Masalah", "Grup Diskusi yang Sunyi", icon-kind: "alert")

#eyebrow("Latar Belakang")
#v(0.4em)
#mag(
  [Proses bisnis PBL di Jurusan Teknologi Informasi mengikuti pola yang baku. Materi Sosialisasi PBL TI
  & SIB menetapkan lima fase PjBL sepanjang 16 minggu, dengan empat checkpoint sebagai titik evaluasi
  bersama dosen pengampu mata kuliah terintegrasi. Setiap tim beranggotakan 4-5 mahasiswa dan dinilai
  baik secara kelompok maupun individu pada tiap checkpoint tersebut.],
  [Pada praktiknya, komunikasi tim mengikuti pola yang dapat diprediksi. Grup diskusi tim dibentuk pada
  Minggu 1 dan aktif hingga Minggu 3, lalu frekuensi pesan menurun tajam memasuki Minggu 5, dan baru
  ramai kembali pada H-1 checkpoint. Pola yang sama dilaporkan oleh beberapa ketua tim lain yang sempat
  diajak berbincang secara informal pada periode yang sama.],
  [Penurunan aktivitas ini tidak disengaja oleh siapa pun, tetapi tetap berdampak kolektif. Setiap
  anggota punya alasan yang sah secara individu, seperti tugas mata kuliah lain atau kelelahan, namun
  akumulasinya menghasilkan pengalaman kerja kelompok yang timpang. Tidak ada anggota tim yang
  mencatat pola ini secara sistematis selain mengandalkan ingatan menjelang penilaian.],
)

#v(0.6em)
#text(size: 9pt)[Berikut temuan tim dari tiga sudut pandang berbeda yang dikumpulkan menjelang
penyusunan proposal ini:]

#v(0.4em)
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 10pt,
  card(light-2)[
    #text(size: 9pt, weight: 700, fill: accent-dark)[KETUA TIM LAIN]
    #v(0.3em)
    #text(size: 7.8pt, weight: 600)[Pertanyaan: Bagaimana proses pembagian dan pelaporan tugas
    selama ini berjalan di timmu?]
    #v(0.25em)
    #text(size: 9.3pt, style: "italic")[
      "Tugas dibagi rata di Minggu 1, tapi satu-dua orang akhirnya mengerjakan mayoritas bagian
      teknis karena yang lain 'sibuk' tanpa keterangan."
    ]
  ],
  card(light-2)[
    #text(size: 9pt, weight: 700, fill: accent-dark)[DOSEN PENGAMPU]
    #v(0.3em)
    #text(size: 7.8pt, weight: 600)[Pertanyaan: Apa kendala utama menilai kontribusi individu pada
    setiap checkpoint?]
    #v(0.25em)
    #text(size: 9.3pt, style: "italic")[
      "Tidak ada bukti aktivitas yang bisa diperiksa cepat untuk 6+ tim sekaligus, penilaian
      kontribusi akhirnya menyamakan nilai seluruh anggota."
    ]
  ],
  card(light-2)[
    #text(size: 9pt, weight: 700, fill: accent-dark)[ANGGOTA TIM]
    #v(0.3em)
    #text(size: 7.8pt, weight: 600)[Pertanyaan: Apa alasan keterlambatan merespons pembagian tugas
    di grup diskusi?]
    #v(0.25em)
    #text(size: 9.3pt, style: "italic")[
      "Membaca pesan, berniat membalas, lalu lupa, karena notifikasi grup tenggelam di antara
      puluhan grup lain."
    ]
  ],
)

#v(0.8em)
Ketiga sudut pandang wawancara di atas menunjuk pada satu akar masalah. Ketua tim tidak punya data
untuk menegakkan pembagian kerja, dosen pengampu tidak punya alat untuk memverifikasi klaim kontribusi
dengan cepat, dan anggota tim sendiri tidak selalu sadar bahwa keterlambatannya berdampak pada
penilaian rekan lain. Ketiadaan satu sumber data bersama membuat ketiga pihak ini saling menebak, dan
tebakan itulah yang akhirnya dicatat sebagai nilai kontribusi individu pada akhir semester.

#v(0.6em)
Pola ini juga tidak sepenuhnya terlihat oleh manajemen jurusan. Koordinator PBL mengawasi puluhan dosen
pengampu sekaligus, namun tidak memiliki cara sistematis untuk mengetahui dosen mana yang secara
konsisten menindaklanjuti laporan tim dan mana yang hanya membaca tanpa merespons.

#v(0.6em)
#eyebrow("Rumusan Masalah")
#v(0.4em)
*Pertanyaan yang kami jawab:* bagaimana menyediakan data partisipasi individu yang objektif dan dapat
diverifikasi, tanpa bergantung sepenuhnya pada laporan lisan ketua tim atau self-assessment yang
cenderung menyamaratakan kontribusi?

#v(1.4em)

// ---------------------------------------------------------------------
// SOLUSI
// ---------------------------------------------------------------------
#section-title("Solusi", "Apa yang SIKAP-PBL Lakukan", icon-kind: "spark")

SIKAP-PBL dirancang untuk memperkuat pelaporan mandiri, bukan mengawasi tim secara berlebihan. Setiap
anggota tim tahu persis data yang tercatat atas namanya dan dapat memeriksa riwayatnya sendiri kapan
saja. Sistem ini tidak pernah mengambil data secara diam-diam dari kanal komunikasi pribadi seperti
WhatsApp atau Discord.

#v(0.6em)
#eyebrow("Mengapa Bukan Tools yang Sudah Ada?")
#v(0.35em)
Tim mempertimbangkan tools manajemen tugas umum sebelum memutuskan membangun SIKAP-PBL sendiri.
Ketiganya gagal pada titik yang sama: tidak ada satu pun yang terhubung langsung ke rubrik penilaian
checkpoint PBL, sehingga data yang terkumpul tetap harus diterjemahkan manual oleh dosen menjadi nilai
kontribusi individu.

#v(0.35em)
#table(
  columns: (2.2fr, 1.7fr, 1.9fr, 1.9fr),
  stroke: 0.6pt + border-c,
  inset: 6.5pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Aspek]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Trello / Notion]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Google Form + Sheets]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[SIKAP-PBL]),
  text(size: 7.4pt)[Terhubung ke rubrik penilaian checkpoint PBL],
    text(size: 7.4pt)[Tidak, murni papan tugas],
    text(size: 7.4pt)[Tidak, sekadar formulir umum],
    text(size: 7.4pt)[Ya, kategori penilaian selaras rubrik],
  text(size: 7.4pt)[Kontribusi individu tercatat terstruktur per minggu],
    text(size: 7.4pt)[Manual, tergantung disiplin anggota memindahkan kartu],
    text(size: 7.4pt)[Manual, direkap ulang tiap minggu],
    text(size: 7.4pt)[Otomatis tersimpan tiap minggu berjalan],
  text(size: 7.4pt)[Dashboard partisipasi lintas tim untuk dosen],
    text(size: 7.4pt)[Tidak tersedia],
    text(size: 7.4pt)[Perlu diolah manual dari spreadsheet mentah],
    text(size: 7.4pt)[Tersedia otomatis per checkpoint],
  text(size: 7.4pt)[Pengingat ke seluruh anggota, bukan hanya ketua tim],
    text(size: 7.4pt)[Terbatas pada due date kartu],
    text(size: 7.4pt)[Tidak ada],
    text(size: 7.4pt)[Terjadwal otomatis H-3 checkpoint],
  text(size: 7.4pt)[Effort tambahan di luar alur kerja tim yang sudah berjalan],
    text(size: 7.4pt)[Tinggi, tim harus pindah platform sepenuhnya],
    text(size: 7.4pt)[Sedang, dosen mengolah spreadsheet sendiri],
    text(size: 7.4pt)[Rendah, mengikuti checkpoint yang sudah ada],
)
#v(0.2em)
#text(size: 7.4pt, style: "italic", fill: accent-dark)[SIKAP-PBL bukan pengganti alat kolaborasi umum;
posisinya spesifik pada satu celah yang tidak diisi tools generik: menerjemahkan aktivitas mingguan
menjadi bukti kontribusi individu yang selaras dengan rubrik PBL.]

#v(0.6em)
#eyebrow("Pemetaan Masalah ke Solusi")
#v(0.4em)
#table(
  columns: (2fr, 2.3fr, 2fr),
  stroke: 0.6pt + border-c,
  inset: 7pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 8.4pt)[Masalah]),
  table.cell(text(fill: white, weight: 700, size: 8.4pt)[Mekanisme SIKAP-PBL]),
  table.cell(text(fill: white, weight: 700, size: 8.4pt)[Hasil yang Diharapkan]),
  text(size: 8.4pt)[Ketua tim tidak punya data untuk menegakkan pembagian kerja],
    text(size: 8.4pt)[Formulir Catat Aktivitas Mingguan mengumpulkan bukti tiap anggota setiap minggu],
    text(size: 8.4pt)[Ketua tim melihat siapa yang aktif tanpa menagih laporan lisan],
  text(size: 8.4pt)[Dosen tidak bisa memverifikasi klaim kontribusi untuk banyak tim sekaligus],
    text(size: 8.4pt)[Dashboard Partisipasi merangkum seluruh tim dalam satu tampilan per checkpoint],
    text(size: 8.4pt)[Dosen menilai dari riwayat aktivitas, bukan kesan sesaat],
  text(size: 8.4pt)[Anggota tidak sadar keterlambatan responsnya berdampak pada penilaian],
    text(size: 8.4pt)[Pengingat Otomatis dikirim H-3 sebelum checkpoint ke seluruh anggota],
    text(size: 8.4pt)[Keterlambatan menurun karena tiap anggota mendapat sinyal langsung],
  text(size: 8.4pt)[Manajemen jurusan tidak punya visibilitas ke pola keterlibatan dosen pengampu lintas tim],
    text(size: 8.4pt)[Rekap Keterlibatan Dosen mengagregasi status baca dan tindak lanjut tiap checkpoint per dosen],
    text(size: 8.4pt)[Koordinator dapat menindaklanjuti dosen yang jarang merespons, bukan menunggu keluhan mahasiswa],
)

#v(0.8em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt, row-gutter: 10pt,
  feature-card("Anggota Tim", "Catat Aktivitas Mingguan", "Setiap anggota mencatat tugas, waktu, dan bukti pendukung (tautan commit, tangkapan layar, berkas kerja)."),
  feature-card("Ketua Tim & Dosen", "Dashboard Partisipasi", "Rekap kontribusi tiap anggota per mata kuliah terintegrasi, diperbarui otomatis mendekati checkpoint."),
  feature-card("Ketua Tim", "Pengingat Otomatis", "Notifikasi ke anggota yang belum mencatat aktivitas, dikirim H-3 sebelum checkpoint, bukan hanya ke ketua tim."),
  feature-card("Dosen Pengampu", "Ekspor untuk Penilaian", "Dosen mengekspor rekap kontribusi individu sebagai referensi objektif saat menilai rubrik."),
  feature-card("Koordinator PBL", "Rekap Keterlibatan Dosen", "Merangkum status baca dan tindak lanjut tiap dosen pengampu atas laporan tim, lintas seluruh tim dan checkpoint yang diampu."),
)

#v(0.8em)
#block(width: 100%, fill: light, radius: 10pt, inset: 14pt)[
  #set par(justify: false)
  #text(size: 9.3pt)[*Alur penggunaan:* setiap Jumat sore, sistem mengirim pengingat ke seluruh anggota
  tim untuk mencatat aktivitas minggu berjalan: tugas yang dikerjakan, waktu yang dihabiskan, dan bukti
  pendukung seperti tautan commit atau tangkapan layar. Ketua tim memantau siapa yang belum mengisi
  catatan lewat dashboard ringkas timnya sendiri. Menjelang checkpoint, seluruh catatan itu tersusun
  otomatis menjadi satu dashboard partisipasi yang bisa langsung dibuka dosen pengampu.]
]

#v(0.6em)
Empat peran pengguna berinteraksi dengan sistem ini dengan kebutuhan berbeda. *Anggota Tim* mencatat
aktivitasnya sendiri dan melihat posisinya dibandingkan rata-rata tim, tanpa membuka identitas rekan
lain secara terbuka. *Ketua Tim* mendapat ringkasan status seluruh anggota, sehingga dapat
menindaklanjuti anggota yang tertinggal tanpa menegur secara personal di grup diskusi bersama. *Dosen
Pengampu* mendapat akses ke dashboard seluruh tim asuhannya sekaligus, sehingga bisa membandingkan
pola partisipasi antar tim dan antar checkpoint dari satu tempat yang sama. *Koordinator PBL* mendapat
rekap keterlibatan dosen pengampu lintas tim, sehingga dapat menindaklanjuti dosen yang jarang
merespons laporan sebelum menjadi keluhan mahasiswa.

// ---------------------------------------------------------------------
// CAKUPAN
// ---------------------------------------------------------------------
#v(1.2em)
#section-title("Cakupan", "Batasan yang Kami Sadari Penuh", icon-kind: "scope")

Menentukan batas cakupan proyek adalah keputusan yang paling sering diperdebatkan tim. Godaan menambah
fitur selalu muncul begitu satu fitur selesai dirancang. Tim akhirnya menyepakati satu patokan: fitur
masuk cakupan hanya jika bisa diselesaikan dengan kualitas layak oleh empat orang dalam sisa semester,
dan benar-benar menjawab rumusan masalah, bukan sekadar menarik untuk ditambahkan.

#v(0.6em)
#grid(columns: (1fr, 1fr), column-gutter: 10pt,
  card(ok-bg)[
    #text(size: 10pt, weight: 700, fill: ok-green)[YANG KAMI BANGUN]
    #v(0.4em)
    #text(size: 9.3pt)[
      - Checklist tugas mingguan per anggota \
      - Log kontribusi dengan bukti unggahan \
      - Dashboard partisipasi per checkpoint \
      - Kategori penilaian selaras rubrik PBL \
      - Rekap keterlibatan dosen pengampu lintas tim
    ]
  ],
  card(rgb("#fdeaea"))[
    #text(size: 10pt, weight: 700, fill: rgb("#b00020"))[YANG SENGAJA TIDAK KAMI BANGUN]
    #v(0.4em)
    #text(size: 9.3pt)[
      - Pelacakan otomatis dari WhatsApp/Discord \
      - Deteksi kebohongan atas laporan kontribusi \
      - Integrasi otomatis ke sistem akademik kampus
    ]
  ],
)

#v(0.6em)
#mag(
  [*Asumsi:* seluruh anggota tim bersedia mencatat aktivitasnya secara jujur. Bila asumsi ini keliru,
  misalnya ada anggota mengunggah bukti yang tidak mencerminkan pekerjaan sebenarnya, sistem tidak
  memiliki mekanisme verifikasi independen untuk mendeteksinya. Keputusan atas kasus semacam itu tetap
  berada di tangan dosen pengampu, bukan sistem.],
  [*Batasan:* proyek dikerjakan 16 minggu oleh 4 anggota tim yang juga menjalani mata kuliah lain di
  semester yang sama. Sistem tidak dapat memaksa siapa pun membalas pesan tepat waktu. Tidak ada
  perangkat lunak yang mampu menyelesaikan seluruh persoalan komunikasi antarmanusia.],
)

#v(0.6em)
#eyebrow("Pemangku Kepentingan")
#v(0.35em)
#table(
  columns: (1.4fr, 2fr, 1.8fr),
  stroke: 0.6pt + border-c,
  inset: 6.5pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Pemangku Kepentingan]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Kepentingan Utama]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Bentuk Keterlibatan]),
  text(size: 7.8pt)[Mahasiswa (Anggota Tim)], text(size: 7.8pt)[Penilaian kontribusi yang adil dan berbasis bukti], text(size: 7.8pt)[Mencatat aktivitas mingguan sendiri],
  text(size: 7.8pt)[Dosen Pengampu], text(size: 7.8pt)[Data partisipasi yang bisa diperiksa cepat untuk banyak tim sekaligus], text(size: 7.8pt)[Menilai lewat dashboard saat checkpoint],
  text(size: 7.8pt)[Koordinator PBL], text(size: 7.8pt)[Rekap lintas tim untuk evaluasi program secara keseluruhan], text(size: 7.8pt)[Memvalidasi kebutuhan dashboard lintas tim],
  text(size: 7.8pt)[Ketua Tim], text(size: 7.8pt)[Alat bantu yang meringankan peran informal sebagai penengah], text(size: 7.8pt)[Memantau dashboard tim, menindaklanjuti anggota tertinggal],
)

#v(1.4em)

// ---------------------------------------------------------------------
// RANCANGAN SISTEM
// ---------------------------------------------------------------------
#section-title("Rancangan", "Struktur Data dan Tampilan", icon-kind: "layers")

#eyebrow("Struktur Data")
#v(0.3em)
Rancangan basis data awal terdiri atas empat entitas yang saling berelasi. Satu `Tim` beranggotakan
banyak `Anggota`, dan setiap `Anggota` memiliki banyak catatan `Kontribusi` sepanjang semester. Setiap
catatan `Kontribusi` merujuk ke satu `Checkpoint` tertentu, sehingga data dapat direkap per fase
penilaian. Detail seperti tipe data dan indeks kueri akan disempurnakan pada tahap implementasi.

#align(center)[
  #box(width: 100%, height: 4.3cm, stroke: none)[
    #let ent(x, y, w, h, label) = place(dx: x, dy: y, block(
      width: w, height: h, fill: light, stroke: 1.2pt + primary, radius: 4pt,
      align(center + horizon, text(size: 9pt, weight: 700)[#label]),
    ))
    #ent(0.2cm, 1.6cm, 2.6cm, 1.1cm)[Tim]
    #ent(4.0cm, 1.6cm, 3.0cm, 1.1cm)[Anggota]
    #ent(9.3cm, 0.1cm, 3.0cm, 1.1cm)[Checkpoint]
    #ent(9.3cm, 3.0cm, 3.0cm, 1.1cm)[Kontribusi]
    #place(dx: 2.85cm, dy: 2.05cm, line(length: 1.15cm, stroke: 1.2pt + primary))
    #place(dx: 2.95cm, dy: 1.75cm, text(size: 8pt, fill: accent-dark)[1:N])
    #place(dx: 7.0cm, dy: 2.1cm, curve(stroke: 1.2pt + primary,
      curve.move((0cm, 0cm)), curve.line((1.1cm, -1.2cm)), curve.line((2.3cm, -1.4cm))))
    #place(dx: 7.4cm, dy: 1.15cm, text(size: 8pt, fill: accent-dark)[N:1])
    #place(dx: 7.0cm, dy: 2.3cm, curve(stroke: 1.2pt + primary,
      curve.move((0cm, 0cm)), curve.line((1.1cm, 0.9cm)), curve.line((2.3cm, 1.05cm))))
    #place(dx: 7.4cm, dy: 3.1cm, text(size: 8pt, fill: accent-dark)[N:1])
  ]
]

#v(0.7em)
#eyebrow("Skema Atribut")
#v(0.3em)
Setiap entitas di atas dirinci menjadi kolom-kolom berikut pada rancangan basis data awal.

#v(0.35em)
#{
  let schema(name, rows) = {
    let head = table.cell(colspan: 3, fill: accent)[#text(fill: white, weight: 700, size: 8pt)[#name]]
    let cols = (
      table.cell(fill: primary, text(fill: white, weight: 700, size: 7.2pt)[Field]),
      table.cell(fill: primary, text(fill: white, weight: 700, size: 7.2pt)[Tipe]),
      table.cell(fill: primary, text(fill: white, weight: 700, size: 7.2pt)[Keterangan]),
    )
    let body = rows.enumerate().map(((i, r)) => {
      let bg = if calc.even(i) { white } else { light }
      (
        table.cell(fill: bg, text(size: 6.8pt)[#r.at(0)]),
        table.cell(fill: bg, text(size: 6.8pt)[#r.at(1)]),
        table.cell(fill: bg, text(size: 6.8pt)[#r.at(2)]),
      )
    }).flatten()
    table(
      columns: (1.3fr, 0.8fr, 1.7fr),
      stroke: 0.5pt + border-c,
      inset: 4.5pt,
      head, ..cols, ..body,
    )
  }

  grid(columns: (1fr, 1fr), column-gutter: 10pt, row-gutter: 10pt,
    schema("Tim", (
      ("id", "int", "Primary key"),
      ("nama_tim", "varchar", "Nama tim PBL"),
    )),
    schema("Anggota", (
      ("id", "int", "Primary key"),
      ("tim_id", "int", "FK -> Tim.id"),
      ("nim", "varchar", "NIM mahasiswa"),
      ("nama", "varchar", "Nama anggota"),
      ("peran", "varchar", "Peran dalam tim"),
    )),
    schema("Checkpoint", (
      ("id", "int", "Primary key"),
      ("nama", "varchar", "Proposal/Milestone 1/2/Final"),
      ("minggu", "int", "Minggu ke-berapa"),
      ("tanggal", "date", "Tanggal checkpoint"),
      ("status_tindak_lanjut_dosen", "varchar", "Dibaca/ditindaklanjuti oleh dosen"),
      ("waktu_direspons", "datetime", "Kosong bila belum direspons dosen"),
    )),
    schema("Kontribusi", (
      ("id", "int", "Primary key"),
      ("anggota_id", "int", "FK -> Anggota.id"),
      ("checkpoint_id", "int", "FK -> Checkpoint.id"),
      ("minggu", "int", "Minggu pencatatan"),
      ("deskripsi_tugas", "text", "Uraian tugas dikerjakan"),
      ("waktu_jam", "int", "Jam yang dihabiskan"),
      ("bukti_url", "varchar", "Tautan/berkas bukti"),
      ("status_verifikasi", "varchar", "Terverifikasi/belum"),
    )),
  )
}

#v(0.6em)
#eyebrow("Arsitektur Sistem")
#v(0.3em)
Sistem berjalan sebagai aplikasi web tiga lapis: peramban di sisi pengguna, logika aplikasi di sisi
server, dan basis data yang menyimpan seluruh catatan aktivitas dan kontribusi.

#v(0.3em)
#align(center)[
  #box(width: 100%, height: 3cm, stroke: none)[
    #let tier(x, y, w, h, title, sub) = place(dx: x, dy: y, block(
      width: w, height: h, fill: light, stroke: 1.2pt + primary, radius: 6pt, inset: 7pt,
    )[
      #align(center + horizon)[
        #text(size: 8.6pt, weight: 700)[#title] \
        #text(size: 7pt, fill: accent-dark)[#sub]
      ]
    ])
    #tier(0cm, 0.5cm, 4.6cm, 2cm, "Klien (Peramban)", "Anggota, Ketua Tim, Dosen")
    #tier(6.05cm, 0.5cm, 4.9cm, 2cm, "Aplikasi Web (Backend)", "Logika bisnis dan peran akses")
    #tier(12.4cm, 0.5cm, 4.6cm, 2cm, "Basis Data (MySQL)", "Tim, Anggota, Kontribusi, Checkpoint")
    #place(dx: 4.7cm, dy: 1.4cm, line(length: 1.3cm, stroke: 1.4pt + accent))
    #place(dx: 4.75cm, dy: 1.0cm, text(size: 6.8pt, fill: accent-dark)[HTTP])
    #place(dx: 11.05cm, dy: 1.4cm, line(length: 1.3cm, stroke: 1.4pt + accent))
    #place(dx: 11.1cm, dy: 1.0cm, text(size: 6.8pt, fill: accent-dark)[SQL])
  ]
]

#v(0.6em)
#eyebrow("Rencana Implementasi")
#v(0.3em)
SIKAP-PBL dibangun sebagai aplikasi web dengan basis data relasional (MySQL), mengikuti materi Desain
dan Pemrograman Web dan Basis Data Lanjut yang sedang ditempuh tim. Selama semester berjalan, aplikasi
dijalankan pada server latihan jurusan atau layanan hosting gratis, cukup untuk kebutuhan demo dan
pengujian oleh dosen pengampu, bukan untuk beban pengguna produksi.

#v(0.5em)
#table(
  columns: (1.6fr, 3fr, 1.3fr),
  stroke: 0.6pt + border-c,
  inset: 6pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Fase]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Modul yang Dikirim]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Checkpoint]),
  text(size: 8pt)[Perencanaan], text(size: 8pt)[Skema basis data dan wireframe formulir catat aktivitas], text(size: 8pt)[Proposal],
  text(size: 8pt)[Pengembangan (awal)], text(size: 8pt)[Formulir Catat Aktivitas Mingguan berjalan penuh], text(size: 8pt)[Milestone 1],
  text(size: 8pt)[Pengembangan (lanjut)], text(size: 8pt)[Dashboard Partisipasi live dengan data uji realistis], text(size: 8pt)[Milestone 2],
  text(size: 8pt)[Pengujian & Pengemasan], text(size: 8pt)[Pengingat Otomatis dan Ekspor untuk Penilaian selesai diuji], text(size: 8pt)[Final],
)
#v(0.2em)
#text(size: 7.6pt, style: "italic", fill: accent-dark)[Setiap baris adalah versi yang benar-benar bisa
didemokan pada checkpoint terkait, bukan sekadar rencana di atas kertas.]

#v(0.6em)
#eyebrow("Alur Proses")
#v(0.3em)
Siklus operasional SIKAP-PBL berjalan setiap minggu dan bermuara pada tiap checkpoint PBL.

#v(0.35em)
#{
  let flow-step(body) = block(
    width: 100%, fill: light, stroke: 1pt + primary, radius: 6pt, inset: 6pt, height: 2.5cm,
  )[#align(center + horizon)[#text(size: 7pt, weight: 600)[#body]]]
  let arrow() = align(center + horizon)[#text(size: 11pt, fill: accent)[→]]
  grid(columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr, auto, 1fr), column-gutter: 3pt,
    flow-step[Anggota mencatat aktivitas mingguan],
    arrow(),
    flow-step[Sistem menyimpan dan memverifikasi bukti],
    arrow(),
    flow-step[Ketua tim memantau dashboard timnya],
    arrow(),
    flow-step[Menjelang checkpoint, sistem menyusun dashboard partisipasi],
    arrow(),
    flow-step[Dosen mengekspor dashboard untuk penilaian],
  )
}

#v(0.6em)
#eyebrow("Tampilan Antarmuka")
#v(0.3em)
Halaman utama yang dirancang pada tahap proposal ini: (1) Formulir Catat Aktivitas Mingguan (Anggota
Tim), (2) Dashboard Partisipasi Tim (Ketua Tim), (3) Dashboard Lintas Tim (Dosen Pengampu), dan (4)
Dashboard Manajemen (Koordinator PBL).

#v(0.4em)
Tata letak keempat halaman ini sengaja disesuaikan dengan masalah dan solusi spesifik yang sudah
ditetapkan pada bagian Pemetaan Masalah ke Solusi, bukan dirancang bebas sebagai tampilan generik.
Formulir Catat Aktivitas dibuat seminimal mungkin karena masalahnya adalah ketiadaan bukti, bukan
kerumitan pelaporan. Dashboard Partisipasi Tim menonjolkan anggota dengan aktivitas terendah karena
itulah celah verifikasi yang selama ini dikeluhkan ketua tim. Dashboard Lintas Tim mengurutkan tim dari
yang paling perlu perhatian karena itu pula kebutuhan dosen yang mengawasi banyak tim sekaligus.
Dashboard Manajemen mengurutkan dosen pengampu dengan pola yang sama, karena masalah yang sama juga
dialami koordinator PBL di level yang lebih tinggi: mengawasi banyak dosen tanpa data keterlibatan yang
jelas.

#v(0.5em)
#{
  // High-fidelity app shell: browser chrome (traffic-light dots + URL pill +
  // user avatar), a left sidebar with a logo mark and icon-dot nav items,
  // and a light content pane holding a white elevated card, with a soft
  // drop shadow under the whole window. Reused across all three screens so
  // they read as one consistent product.
  let app-shell(url, active-idx, h, content, nav: ("Beranda", "Catat Aktivitas", "Dashboard Tim", "Ekspor")) = box(width: 100%, height: h + 5pt)[
    #place(dx: 3pt, dy: 5pt, rect(width: 100%, height: h, radius: 9pt, fill: rgb(0%, 0%, 0%, 14%)))
    #place(dx: 0pt, dy: 0pt)[
      #box(width: 100%, height: h, stroke: 1.2pt + border-c, radius: 9pt, clip: true, fill: white)[
        #block(width: 100%, height: 0.55cm, fill: rgb("#e4eae6"), inset: (x: 8pt, y: 5pt))[
          #grid(columns: (auto, 1fr, auto), column-gutter: 6pt,
            grid(columns: (6pt, 6pt, 6pt), column-gutter: 4pt,
              circle(radius: 2.6pt, fill: rgb("#e07a5f")),
              circle(radius: 2.6pt, fill: rgb("#e0c05f")),
              circle(radius: 2.6pt, fill: rgb("#7fae7f")),
            ),
            align(center)[
              #box(fill: white, radius: 999pt, inset: (x: 7pt, y: 1.5pt))[
                #text(size: 6pt, fill: rgb("#55605a"))[#url]
              ]
            ],
            box(width: 12pt, height: 12pt, radius: 999pt, fill: accent)[
              #align(center + horizon, text(size: 5.2pt, weight: 800, fill: white)[KN])
            ],
          )
        ]
        #grid(columns: (2.3cm, 1fr),
          block(width: 2.3cm, height: h - 0.55cm, fill: primary-dark, inset: (x: 7pt, y: 9pt))[
            #set par(justify: false)
            #grid(columns: (7pt, auto), column-gutter: 4pt,
              box(width: 7pt, height: 7pt, radius: 2pt, fill: accent),
              text(size: 6.6pt, weight: 800, fill: white, tracking: 0.5pt)[SIKAP-PBL],
            )
            #v(10pt)
            #let nav-item(label, active) = block(below: 6pt)[
              #box(fill: if active { primary } else { none }, radius: 4pt, inset: (x: 5pt, y: 3.5pt), width: 100%)[
                #grid(columns: (4pt, auto), column-gutter: 4pt,
                  align(horizon, box(width: 4pt, height: 4pt, radius: 999pt, fill: if active { white } else { rgb("#5a8a76") })),
                  text(size: 6.2pt, weight: if active { 700 } else { 500 }, fill: if active { white } else { rgb("#a9d3c2") })[#label],
                )
              ]
            ]
            #for (i, item) in nav.enumerate() [
              #nav-item(item, i == active-idx)
            ]
          ],
          block(width: 100%, height: h - 0.55cm, fill: rgb("#f2f5f3"), inset: 6pt)[
            #block(width: 100%, height: 100%, fill: white, radius: 7pt, stroke: 0.6pt + border-c, inset: 7pt)[
              #set par(justify: false)
              #content
            ]
          ],
        )
      ]
    ]
  ]

  grid(columns: (1fr, 1fr), column-gutter: 12pt,
    align(center)[
      #app-shell("sikap-pbl.app/catat-aktivitas", 1, 7.9cm)[
        #text(size: 7.8pt, weight: 700)[Formulir Catat Aktivitas Mingguan]
        #v(6pt)
        #text(size: 6.4pt, fill: rgb("#55605a"))[Tugas yang dikerjakan]
        #box(width: 100%, height: 16pt, fill: white, stroke: 1pt + border-c, radius: 4pt, inset: (left: 6pt, right: 6pt, top: 3pt))[
          #grid(columns: (1fr, auto),
            text(size: 6.8pt)[Implementasi formulir unggah bukti],
            align(horizon)[#text(size: 7pt, fill: rgb("#8a958f"))[⌄]],
          )
        ]
        #v(5pt)
        #text(size: 6.4pt, fill: rgb("#55605a"))[Waktu yang dihabiskan (jam)]
        #box(width: 100%, height: 16pt, fill: white, stroke: 1pt + border-c, radius: 4pt, inset: (left: 6pt, top: 3pt))[
          #text(size: 6.8pt)[4]
        ]
        #v(5pt)
        #text(size: 6.4pt, fill: rgb("#55605a"))[Bukti pendukung]
        #box(width: 100%, height: 16pt, fill: white, stroke: 1pt + border-c, radius: 4pt, inset: (left: 6pt, top: 3pt))[
          #text(size: 6.8pt)[tautan-commit-github.com/...]
        ]
        #v(8pt)
        #box(fill: accent, radius: 4pt, inset: (x: 11pt, y: 4.5pt))[
          #text(size: 6.8pt, weight: 600, fill: white)[Simpan Aktivitas]
        ]
      ]
      #v(0.3em)
      #text(size: 8pt, weight: 600)[1. Formulir Catat Aktivitas]
    ],
    align(center)[
      #app-shell("sikap-pbl.app/dashboard-dosen", 2, 7.4cm)[
        #text(size: 7.5pt, weight: 700)[Rekap Partisipasi Lintas Tim, Checkpoint Milestone 1]
        #v(7pt)
        #let row(name, val, color) = block(below: 5pt)[
          #grid(columns: (6pt, 1fr, auto), column-gutter: 5pt,
            align(horizon, box(width: 6pt, height: 6pt, radius: 999pt, fill: color)),
            text(size: 6.8pt)[#name],
            text(size: 6.8pt, weight: 700, fill: color)[#val],
          )
        ]
        #row("Koyok Ngene Lho", "84%", primary)
        #row("Tim Aksara", "91%", primary)
        #row("Tim Wicara", "67%", accent)
        #row("Tim Beringin", "76%", primary)
        #v(3pt)
        #text(size: 6.4pt, fill: accent-dark, style: "italic")[Diurutkan dari yang perlu perhatian.]
      ]
      #v(0.3em)
      #text(size: 8pt, weight: 600)[3. Dashboard Lintas Tim (Dosen)]
    ],
  )

  v(0.5em)
  align(center)[
    #app-shell("sikap-pbl.app/dashboard-tim", 2, 8.6cm)[
      #text(size: 7.8pt, weight: 700)[Partisipasi Koyok Ngene Lho, Menjelang Milestone 1]
      #v(8pt)
      #let bar(name, initials, pct, color) = block(below: 8pt)[
        #grid(columns: (14pt, auto), column-gutter: 5pt,
          box(width: 13pt, height: 13pt, radius: 999pt, fill: color)[
            #align(center + horizon, text(size: 5.6pt, weight: 800, fill: white)[#initials])
          ],
          align(horizon, text(size: 6.8pt, weight: 600)[#name]),
        )
        #v(3pt)
        #grid(columns: (1fr, auto), column-gutter: 5pt,
          box(width: 100%, height: 8pt, fill: rgb("#e4eae6"), radius: 3pt)[
            #box(width: pct, height: 8pt, fill: color, radius: 3pt)
          ],
          text(size: 6.4pt, weight: 700, fill: color)[#pct],
        )
      ]
      #bar("Raka A. P.", "RA", 92%, primary)
      #bar("Salsabila R. P.", "SR", 78%, primary)
      #bar("Farrel I. N.", "FI", 81%, primary)
      #bar("Nadia K. S.", "NK", 35%, accent)
      #v(2pt)
      #text(size: 6.6pt, fill: accent-dark, style: "italic")[1 anggota berada di bawah ambang
      partisipasi minggu ini.]
    ]
  ]
  align(center)[#v(0.3em) #text(size: 8pt, weight: 600)[2. Dashboard Partisipasi Tim (Ketua Tim)]]

  v(0.5em)
  align(center)[
    #app-shell("sikap-pbl.app/dashboard-manajemen", 2, 8.2cm, nav: ("Beranda", "Tim Diampu", "Dosen Pengampu", "Ekspor"))[
      #text(size: 7.5pt, weight: 700)[Rekap Keterlibatan Dosen Pengampu, Semester Berjalan]
      #v(7pt)
      #let dosen-row(name, stat, color) = block(below: 7pt)[
        #grid(columns: (6pt, 1fr), column-gutter: 5pt,
          align(horizon, box(width: 6pt, height: 6pt, radius: 999pt, fill: color)),
          block()[
            #text(size: 6.8pt, weight: 600)[#name]
            #linebreak()
            #text(size: 6pt, fill: rgb("#55605a"))[#stat]
          ],
        )
      ]
      #dosen-row("Dr. Yusuf H.", "10 tim diampu · belum pernah merespons · 4 checkpoint tanpa tindak lanjut", accent)
      #dosen-row("Rina K., M.Kom.", "8 tim diampu · rata-rata respons 2.5 hari · 1 checkpoint tanpa tindak lanjut", primary)
      #dosen-row("Dr. Bambang S.", "6 tim diampu · rata-rata respons 1.2 hari · 0 checkpoint tanpa tindak lanjut", primary)
      #dosen-row("Siti N., M.T.", "7 tim diampu · rata-rata respons 0.8 hari · 0 checkpoint tanpa tindak lanjut", primary)
      #v(3pt)
      #text(size: 6.4pt, fill: accent-dark, style: "italic")[Diurutkan dari yang paling jarang
      menindaklanjuti.]
    ]
  ]
  align(center)[#v(0.3em) #text(size: 8pt, weight: 600)[4. Dashboard Manajemen (Koordinator PBL)]]
}

#v(0.8em)
#mag(
  [Ketiga sketsa ini mewakili tiga sudut pandang atas data yang sama. Formulir Catat Aktivitas adalah
  titik masuk data bagi anggota tim, sedangkan Dashboard Partisipasi Tim merangkumnya untuk ketua tim
  per minggu berjalan.],
  [Warna oranye pada salah satu batang bukan hukuman otomatis, melainkan penanda visual bagi ketua tim
  untuk mengetahui anggota yang perlu diajak berdiskusi. Dashboard Lintas Tim merangkum sekali lagi
  pada level dosen, sehingga memungkinkan perbandingan cepat antar tim asuhan.],
)

#v(1.4em)

// ---------------------------------------------------------------------
// TIM & PETA JALAN
// ---------------------------------------------------------------------
#section-title("Pelaksana", "Rincian Pekerjaan dan Peta Jalan 16 Minggu", icon-kind: "team")

#eyebrow("Rincian Pekerjaan Tim")
#v(0.4em)
#table(
  columns: (1.3fr, 1.3fr, 2fr, 0.9fr),
  stroke: 0.6pt + border-c,
  inset: 6pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 8.6pt)[Bagian Besar]),
  table.cell(text(fill: white, weight: 700, size: 8.6pt)[Sub-bagian]),
  table.cell(text(fill: white, weight: 700, size: 8.6pt)[Tugas Rinci]),
  table.cell(text(fill: white, weight: 700, size: 8.6pt)[Penanggung Jawab]),
  text(size: 8.6pt)[1. Modul Pencatatan Aktivitas], text(size: 8.6pt)[1.1 Desain Basis Data],
    text(size: 8.6pt)[1.1.1 Rancang ERD Tim/Anggota/Kontribusi/Checkpoint], text(size: 8.6pt)[Raka],
  text(size: 8.6pt)[], text(size: 8.6pt)[],
    text(size: 8.6pt)[1.1.2 Implementasi skema dan migrasi], text(size: 8.6pt)[Raka],
  text(size: 8.6pt)[], text(size: 8.6pt)[1.2 Formulir Pencatatan],
    text(size: 8.6pt)[1.2.1 Wireframe formulir catat aktivitas], text(size: 8.6pt)[Salsabila],
  text(size: 8.6pt)[], text(size: 8.6pt)[],
    text(size: 8.6pt)[1.2.2 Implementasi formulir dan unggah bukti], text(size: 8.6pt)[Salsabila],
  text(size: 8.6pt)[2. Modul Dashboard Partisipasi], text(size: 8.6pt)[2.1 Rancangan Dashboard],
    text(size: 8.6pt)[2.1.1 Desain kueri rekap kontribusi per checkpoint], text(size: 8.6pt)[Farrel],
  text(size: 8.6pt)[], text(size: 8.6pt)[],
    text(size: 8.6pt)[2.1.2 Implementasi grafik partisipasi], text(size: 8.6pt)[Farrel],
  text(size: 8.6pt)[], text(size: 8.6pt)[2.2 Rekap Keterlibatan Dosen],
    text(size: 8.6pt)[2.2.1 Desain kueri status tindak lanjut dosen lintas tim], text(size: 8.6pt)[Farrel],
  text(size: 8.6pt)[3. Modul Pengujian], text(size: 8.6pt)[3.1 Rencana Uji],
    text(size: 8.6pt)[3.1.1 Susun skenario uji formulir dan dashboard], text(size: 8.6pt)[Nadia],
)

#v(1.2em)
#eyebrow("Peta Jalan")
#v(0.5em)
#block(width: 100%, breakable: false)[
  #line(start: (2%, 0pt), end: (98%, 0pt), stroke: 2.5pt + border-c)
  #place(dx: 0%, dy: -5pt, dot())
  #place(dx: 23%, dy: -5pt, dot())
  #place(dx: 48%, dy: -5pt, dot())
  #place(dx: 73%, dy: -5pt, dot())
  #place(dx: 96%, dy: -5pt, dot())
  #v(0.5em)
  #grid(columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    text(size: 8pt)[*Mg 1-3* \ Identifikasi masalah],
    text(size: 8pt)[*Mg 4* \ Proposal (CP-1)],
    text(size: 8pt)[*Mg 5-8* \ Modul inti (CP-2)],
    text(size: 8pt)[*Mg 9-12* \ Dashboard (CP-3)],
    text(size: 8pt)[*Mg 13-16* \ Uji & Demo (CP-4)],
  )
]

#v(1em)
#mag(
  [Pembagian kerja diselaraskan dengan peran masing-masing anggota pada mata kuliah yang diampu. Raka,
  Ketua Tim sekaligus Pengembang Utama, menangani back-end dan basis data karena pengalamannya paling
  banyak di bidang tersebut.],
  [Salsabila, Analis/Desainer, mengerjakan wireframe dan front-end agar dashboard mudah dibaca sekilas
  oleh dosen. Farrel, Sekretaris/Dokumentator, menyusun logbook dan merancang kueri dashboard agar
  datanya konsisten.],
  [Nadia, QA/Penguji, menguji klaim paling berani proposal ini: apakah pengingat otomatis benar-benar
  mempercepat respons anggota di grup diskusi.],
  [Hasil pengujian awal terhadap klaim tersebut belum sepenuhnya meyakinkan. Tim akan melaporkannya
  secara jujur pada Milestone 2, sesuai prinsip yang sama yang mendasari proyek ini: laporan berbasis
  bukti, bukan optimisme semata.],
)

#v(1.4em)
#section-title("Ukuran Keberhasilan", "Kapan Proyek Ini Dianggap Berhasil", icon-kind: "flag")

#mag(
  [Tim menetapkan kriteria keberhasilan yang konkret, bukan target yang sulit diukur seperti
  "meningkatkan kolaborasi tim". Aplikasi dinyatakan berhasil jika keempat entitas (`Tim`, `Anggota`,
  `Checkpoint`, `Kontribusi`) saling berelasi dengan data uji yang realistis, ketiga peran pengguna
  berfungsi sesuai hak aksesnya, dan dashboard partisipasi diperbarui otomatis pada keempat checkpoint.
  Seluruh proses pengembangan didokumentasikan lewat logbook mingguan yang dapat dibandingkan dengan
  rencana kerja awal.],
  [Sebagai indikator tambahan yang bersifat aspiratif, tim berharap frekuensi pesan "maaf baru sempat
  balas" di grup diskusi menurun mendekati checkpoint. Keberhasilan sesungguhnya tetap diukur dari
  ketiga kriteria konkret di atas, bukan dari harapan ini.],
)

#v(1.4em)
#section-title("Risiko dan Mitigasi", "Apa yang Bisa Meleset", icon-kind: "alert")

Tim menyadari tiga risiko utama yang bisa menghambat pengiriman SIKAP-PBL tepat waktu, dan menyiapkan
mitigasi untuk masing-masing sejak tahap proposal, bukan menunggu risiko itu terjadi.

#v(0.4em)
#table(
  columns: (1.8fr, 1.7fr, 2fr),
  stroke: 0.6pt + border-c,
  inset: 6.5pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Risiko]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Dampak]),
  table.cell(text(fill: white, weight: 700, size: 8.2pt)[Mitigasi]),
  text(size: 7.8pt)[Anggota tidak konsisten mencatat aktivitas mingguan], text(size: 7.8pt)[Dashboard partisipasi jadi tidak akurat], text(size: 7.8pt)[Pengingat otomatis H-3 checkpoint, ditinjau ketua tim tiap minggu],
  text(size: 7.8pt)[Server latihan tidak stabil menjelang demo], text(size: 7.8pt)[Dashboard tidak bisa diakses saat dinilai], text(size: 7.8pt)[Cadangan data lokal terjadwal, uji akses H-1 checkpoint],
  text(size: 7.8pt)[Cakupan basis data berubah di tengah semester], text(size: 7.8pt)[Modul yang sudah jadi perlu dirombak ulang], text(size: 7.8pt)[Skema disepakati beku sejak Proposal, perubahan hanya lewat revisi tercatat],
)

#v(1.4em)
#section-title("Mitra", "Koordinator PBL", icon-kind: "link")

Koordinator PBL Jurusan Teknologi Informasi berperan sebagai mitra utama proyek ini, sekaligus pengguna
langsung Dashboard Manajemen untuk memantau keterlibatan dosen pengampu lintas tim. Keterlibatannya
direncanakan pada dua titik, bukan menunggu masukan datang secara tidak terstruktur menjelang Demo Day.

#v(0.4em)
#block(breakable: false)[
  #table(
    columns: (1.6fr, 1fr, 2fr, 1.8fr),
    stroke: 0.6pt + border-c,
    inset: 6.5pt,
    fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
    table.cell(text(fill: white, weight: 700, size: 8pt)[Titik Keterlibatan]),
    table.cell(text(fill: white, weight: 700, size: 8pt)[Kapan]),
    table.cell(text(fill: white, weight: 700, size: 8pt)[Bentuk Keterlibatan]),
    table.cell(text(fill: white, weight: 700, size: 8pt)[Output]),
    text(size: 7.6pt)[Validasi kebutuhan], text(size: 7.6pt)[Fase 1 (Mg 1-3)], text(size: 7.6pt)[Sesi diskusi singkat sebelum struktur basis data dibangun penuh], text(size: 7.6pt)[Daftar kebutuhan dashboard lintas tim disepakati],
    text(size: 7.6pt)[Masukan indikator KPI], text(size: 7.6pt)[Milestone 2 (Mg 12)], text(size: 7.6pt)[Sesi diskusi singkat meninjau dashboard yang sudah berjalan], text(size: 7.6pt)[Indikator KPI tambahan (bila relevan) masuk cakupan Final],
  )
]

#v(1.4em)
#section-title("Lampiran", "Dokumen Pendukung", icon-kind: "doc")

Tim melampirkan empat jenis dokumen pendukung untuk memperkuat temuan pada bagian Masalah: catatan
wawancara informal dengan tiga ketua tim lain, tangkapan layar ilustratif pola "dibaca tanpa dibalas"
dari grup tim sendiri, cuplikan log notifikasi yang menggambarkan pola keterlibatan dosen pengampu
terhadap laporan mingguan tim, dan salinan rubrik penilaian PBL yang berlaku. Keempatnya dicuplikkan
satu per satu pada halaman berikut; dokumen lengkap tersedia atas permintaan dosen pengampu untuk
verifikasi lebih lanjut.

#pagebreak()
#block(width: 100%, fill: white, stroke: 0.8pt + border-c, radius: 4pt, inset: 14pt, breakable: false)[
  #set par(justify: false)
  #text(size: 9pt, weight: 700)[Catatan Wawancara Informal: Tiga Ketua Tim Lain (Identitas Disamarkan)]
  #v(0.5em)
  #line(length: 100%, stroke: 0.4pt + border-c)
  #v(0.6em)
  #text(size: 8.6pt, weight: 700, fill: accent-dark)[Ketua Tim A]
  #v(0.2em)
  #text(size: 8.6pt)[
    *T:* Bagaimana proses pembagian dan pelaporan tugas selama ini berjalan di timmu? \
    *J:* "Tugas dibagi rata di Minggu 1, tapi satu-dua orang akhirnya mengerjakan mayoritas bagian
    teknis." \
    #v(0.3em)
    *T:* Apakah kamu pernah menegur anggota yang tidak aktif? \
    *J:* "Pernah, tapi hanya lewat chat personal karena tidak enak menegur di grup besar."
  ]
  #v(0.6em)
  #text(size: 8.6pt, weight: 700, fill: accent-dark)[Ketua Tim B]
  #v(0.2em)
  #text(size: 8.6pt)[
    *T:* Apakah ada catatan tertulis soal siapa mengerjakan apa? \
    *J:* "Tidak ada, semua mengandalkan ingatan grup menjelang checkpoint." \
    #v(0.3em)
    *T:* Bagaimana dosen pengampu menanggapi laporan progres timmu? \
    *J:* "Laporan mingguan kami kirim rutin, tapi jarang ada balasan atau masukan dari dosen."
  ]
  #v(0.6em)
  #text(size: 8.6pt, weight: 700, fill: accent-dark)[Ketua Tim C]
  #v(0.2em)
  #text(size: 8.6pt)[
    *T:* Bagaimana kamu menilai kontribusi anggota selama ini? \
    *J:* "Saya hanya menebak dari siapa yang paling sering bicara di rapat, bukan dari pekerjaan yang
    benar-benar selesai." \
    #v(0.3em)
    *T:* Apakah kamu merasa dibimbing selama proyek berjalan? \
    *J:* "Lebih banyak jalan sendiri; masukan dari dosen biasanya baru muncul saat penilaian akhir."
  ]
]
#v(0.3em)
#align(center)[#text(size: 8pt, weight: 600)[Lampiran 1. Cuplikan Catatan Wawancara Informal]]

#pagebreak()
#align(center)[
  #box(width: 9.5cm, height: 9.3cm, stroke: 1.2pt + border-c, radius: 8pt, clip: true)[
    #rect(width: 100%, height: 0.8cm, fill: rgb("#e4eae6"))[
      #align(horizon)[#pad(left: 10pt)[#text(fill: rgb("#3a453f"), weight: 700, size: 8.5pt)[Grup: Tim Koyok Ngene Lho]]]
    ]
    #pad(x: 10pt, top: 10pt)[
      #set par(justify: false)
      #block(width: 72%, fill: rgb("#eef2f0"), radius: 6pt, inset: 6pt)[
        #text(size: 7.5pt)[Farrel: ada yang mau update progress? Masih Rabu, jangan nunggu H-1]
      ]
      #v(4pt)
      #text(size: 6.3pt, fill: rgb("#8a958f"))[Rabu, tidak ada balasan]
      #v(8pt)
      #block(width: 72%, fill: rgb("#eef2f0"), radius: 6pt, inset: 6pt)[
        #text(size: 7.5pt)[Farrel: tolong update progres masing-masing ya sebelum Jumat]
      ]
      #v(5pt)
      #align(right)[
        #block(width: 72%, fill: rgb("#dfeee6"), radius: 6pt, inset: 6pt)[
          #text(size: 7.5pt)[Kamu: siap, nanti aku kirim sebentar lagi]
        ]
      ]
      #v(5pt)
      #block(width: 72%, fill: rgb("#eef2f0"), radius: 6pt, inset: 6pt)[
        #text(size: 7.5pt)[Salsabila: aku juga belum sempat, weekend ini ya]
      ]
      #v(4pt)
      #align(right)[#text(size: 6.5pt, fill: rgb("#55605a"))[Dibaca oleh 4 dari 4 anggota, 09.14]]
      #v(10pt)
      #text(size: 7.3pt, style: "italic", fill: accent-dark)[(tidak ada balasan lanjutan hingga H-1
      checkpoint)]
    ]
  ]
]
#v(0.3em)
#align(center)[#text(size: 8pt, weight: 600)[Lampiran 2. Ilustrasi Pola "Dibaca Tanpa Dibalas"]]

#pagebreak()
#eyebrow("Lampiran 3")
#v(0.3em)
#text(size: 8.6pt)[Cuplikan log notifikasi berikut menggambarkan pola keterlibatan dosen pengampu
terhadap laporan mingguan yang dikirim tim pada tiap checkpoint.]
#v(0.35em)
#table(
  columns: (1.3fr, 1.7fr, 1.4fr, 1.8fr),
  stroke: 0.6pt + border-c,
  inset: 6.5pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Checkpoint]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Laporan Dikirim]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Status]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Tindak Lanjut Tercatat]),
  text(size: 7.6pt)[Milestone 1], text(size: 7.6pt)[Jumat, Mg 8, 09.41], text(size: 7.6pt)[Dibaca (centang biru)], text(size: 7.6pt)[Tidak ada],
  text(size: 7.6pt)[Milestone 2], text(size: 7.6pt)[Jumat, Mg 12, 09.38], text(size: 7.6pt)[Dibaca (centang biru)], text(size: 7.6pt)[Tidak ada],
  text(size: 7.6pt)[Final], text(size: 7.6pt)[Jumat, Mg 16, 09.45], text(size: 7.6pt)[Dibaca (centang biru)], text(size: 7.6pt)[Komentar singkat: "oke"],
)
#v(0.2em)
#text(size: 7.6pt, style: "italic", fill: accent-dark)[Log ini bersifat ilustratif, disusun dari
pengamatan tim terhadap pola keterlibatan dosen pengampu selama proyek berjalan; bukan data resmi
sistem akademik.]
#v(0.3em)
#align(center)[#text(size: 8pt, weight: 600)[Lampiran 3. Cuplikan Log Notifikasi Dosen Pengampu]]

#pagebreak()
#eyebrow("Lampiran 4")
#v(0.3em)
#table(
  columns: (1.4fr, 1fr, 1fr, 1fr, 1fr),
  stroke: 0.6pt + border-c,
  inset: 6pt,
  fill: (x, y) => if y == 0 { primary } else if calc.odd(y) { white } else { light },
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Kriteria]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Skor 1]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Skor 2]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Skor 3]),
  table.cell(text(fill: white, weight: 700, size: 7.8pt)[Skor 4]),
  text(size: 7.4pt)[Kontribusi Individu],
    text(size: 7pt)[Tidak ada bukti aktivitas],
    text(size: 7pt)[Aktivitas tercatat sebagian],
    text(size: 7pt)[Aktivitas tercatat, jarang terverifikasi],
    text(size: 7pt)[Aktivitas tercatat dan terverifikasi penuh],
  text(size: 7.4pt)[Ketepatan Waktu Pelaporan],
    text(size: 7pt)[Selalu terlambat tanpa keterangan],
    text(size: 7pt)[Sering terlambat],
    text(size: 7pt)[Kadang terlambat],
    text(size: 7pt)[Selalu tepat waktu],
  text(size: 7.4pt)[Kualitas Bukti Pendukung],
    text(size: 7pt)[Tidak ada bukti],
    text(size: 7pt)[Bukti tidak relevan],
    text(size: 7pt)[Bukti relevan, minim detail],
    text(size: 7pt)[Bukti relevan dan lengkap],
)
#v(0.2em)
#text(size: 7.6pt, style: "italic", fill: accent-dark)[Cuplikan ilustratif untuk menunjukkan struktur
penilaian; bukan salinan resmi rubrik PBL yang berlaku.]
#v(0.3em)
#align(center)[#text(size: 8pt, weight: 600)[Lampiran 4. Cuplikan Rubrik Penilaian Kontribusi Individu]]
