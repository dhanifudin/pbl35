#!/usr/bin/env bash
# Build Typst + PDF for the Milestone 2 documents.
#  - SOP and Template: Markdown (source) -> pandoc -> .typ -> typst -> .pdf
#  - Contoh Laporan (4, satu per prodi dan semester): hand-written .typ using contoh-lib.typ -> typst -> .pdf
set -euo pipefail
cd "$(dirname "$0")"
conv() { # <basename> <title>
  sed 's#<div style="page-break-before:always"></div>#```{=typst}\n\#pagebreak()\n```#' "$1.md" \
  | pandoc -f markdown-smart -t typst --wrap=none --template=pandoc-template.typ -V title="$2" -o "$1.typ"
  sed -i 's/align(center)\[#table(/align(left)[#table(/' "$1.typ"
  typst compile --root .. "$1.typ" "$1.pdf"
}
conv SOP-Milestone-2-PBL "SOP Pelaksanaan Milestone 2 PBL"
conv Template-Laporan-Milestone-2-PBL "Template Laporan Milestone 2 PBL"
for f in Contoh-Laporan-Milestone-2-*.typ; do
  typst compile --root .. "$f" "${f%.typ}.pdf"
done
