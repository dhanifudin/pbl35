"""
Shared data and style helpers for the TI Proposal-rubric tooling
(gen_rubrik_proposal.py and download_proposals.py).

Reads real, current data at run time rather than baking numbers into the
scripts, so the workbook always reflects whatever is in docs/ right now:

  - docs/Plotting Dosen Gasal 2026-2027.xlsx, sheet "Ploting" ONLY.
    The "Pengajuan Dosen LB" sheet in that same workbook contains NIDN, NIK,
    NPWP and bank-account numbers for part-time lecturers and must never be
    opened, read, or referenced by any script in this project.
  - docs/Pengumpulan Proposal PBL TI (Responses).xlsx, sheet "Form responses 1"
    (104 raw submissions; the older docs/Pengumpulan Proposal PBL (Jawaban).xlsx
    is an incomplete, superseded export and is intentionally not used).
"""
import re
from pathlib import Path

import openpyxl
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.formatting.rule import CellIsRule

ROOT = Path(__file__).resolve().parent.parent
DOSEN_SOURCE = ROOT / "docs" / "Plotting Dosen Gasal 2026-2027.xlsx"
ROSTER_SOURCE = ROOT / "docs" / "Pengumpulan Proposal PBL TI (Responses).xlsx"
MANIFEST_PATH = Path(__file__).resolve().parent / "proposals_manifest.json"
UPLOADS_DIR = ROOT / "docs" / "proposals-uploaded"

# ---------------------------------------------------------------------------
# Scope: TI Semester 3 (2nd-year cohort, TI_2A..TI_2I) and TI Semester 5
# (3rd-year cohort, TI_3A..TI_3I), per the real cohort-based class naming in
# docs/Plotting Dosen Gasal 2026-2027.xlsx.
# ---------------------------------------------------------------------------
SEM3_CLASSES = [f"TI_2{c}" for c in "ABCDEFGHI"]
SEM5_CLASSES = [f"TI_3{c}" for c in "ABCDEFGHI"]
ALL_CLASSES = SEM3_CLASSES + SEM5_CLASSES

# PBL-integrated courses per semester (confirmed against RPP-PBL-TI-Sem3.md /
# RPP-PBL-TI-Sem5.md -- not every course a class takes is PBL-integrated).
SEM3_COURSES = [
    "Manajemen Proyek",
    "Desain & Pemrograman Web",
    "Basis Data Lanjut",
    "Sistem Informasi Manajemen",
]
SEM5_COURSES = [
    "Pemrograman Mobile",
    "Pembelajaran Mesin",
    "Penjaminan Mutu Perangkat Lunak",
]


def is_sem3(class_code):
    return class_code.startswith("TI_2")


def semester_label(class_code):
    return "Semester 3" if is_sem3(class_code) else "Semester 5"


def courses_for_class(class_code):
    return SEM3_COURSES if is_sem3(class_code) else SEM5_COURSES


def sanitize_filename(name):
    name = re.sub(r'[\\/:*?"<>|]', "-", name)
    name = re.sub(r"\s+", " ", name).strip()
    return name[:120] if name else "tim"


def safe_sheet_name(name, max_len=31):
    """Excel sheet names: <=31 chars, no : \\ / ? * [ ]."""
    cleaned = re.sub(r'[:\\/?*\[\]]', "", name).strip()
    if len(cleaned) <= max_len:
        return cleaned
    truncated = cleaned[:max_len].rstrip()
    if " " in truncated:
        truncated = truncated.rsplit(" ", 1)[0]
    return truncated


# ---------------------------------------------------------------------------
# Generic, group-only Proposal rubric -- 6 criteria mapped to the required
# sections of Format-Proposal-PBL-TI-Sem3.md / Sem5.md, weights in clean 5%
# increments summing to 100%. No individual-level criteria exist anywhere:
# grading individual contribution is left entirely to the course lecturer at
# later checkpoints, per explicit instruction.
# ---------------------------------------------------------------------------
CRITERIA = [
    {
        "name": "Latar Belakang dan Rumusan Masalah",
        "weight": 20,
        "levels": [
            "Tidak ada latar belakang yang jelas; masalah tidak diuraikan atau tidak berdasar pada kondisi nyata.",
            "Latar belakang disampaikan secara umum tanpa data/observasi pendukung; rumusan masalah kabur dan tidak spesifik.",
            "Latar belakang cukup relevan namun bukti pendukung (wawancara, data, observasi) masih terbatas; rumusan masalah ada namun kurang tajam.",
            "Latar belakang didukung bukti yang memadai dan relevan dengan calon pengguna/mitra; rumusan masalah spesifik dan menjadi dasar solusi yang diusulkan.",
            "Latar belakang digali mendalam dengan bukti kuat dan beragam (wawancara, data kuantitatif, observasi langsung); rumusan masalah tajam, terukur, dan meyakinkan sebagai dasar seluruh proposal.",
        ],
    },
    {
        "name": "Deskripsi Produk dan Solusi",
        "weight": 20,
        "levels": [
            "Produk/solusi tidak dijelaskan, atau tidak berkaitan dengan masalah yang diangkat.",
            "Produk/solusi disebutkan secara umum tanpa penjelasan fitur atau cara kerja; keterkaitan dengan masalah lemah.",
            "Produk/solusi dan fitur utamanya dijelaskan, keterkaitan dengan masalah cukup jelas, namun nilai tambah dibanding pendekatan lain belum terlihat.",
            "Produk/solusi dijelaskan lengkap (fitur, cara kerja, pengguna sasaran) dan keterkaitannya dengan masalah kuat; nilai tambah solusi tergambar jelas.",
            "Produk/solusi dijelaskan lengkap dan meyakinkan, disertai alasan mengapa pendekatan ini paling sesuai dibanding alternatif lain, serta batasan solusi disampaikan secara jujur.",
        ],
    },
    {
        "name": "Rancangan Teknis Awal (ERD dan Wireframe)",
        "weight": 20,
        "levels": [
            "Tidak ada rancangan teknis; ERD dan wireframe tidak dilampirkan.",
            "ERD atau wireframe dilampirkan namun sangat sederhana, tidak konsisten dengan deskripsi produk, atau salah satunya tidak ada.",
            "ERD dan wireframe tersedia dan konsisten dengan deskripsi produk, namun detail entitas/atribut atau alur antarmuka masih minim.",
            "ERD dan wireframe tersedia lengkap, konsisten dengan deskripsi produk, entitas/atribut/alur digambarkan dengan jelas.",
            "ERD dan wireframe tersedia lengkap, rapi, dan konsisten; relasi antarentitas serta alur antarmuka menunjukkan pemahaman teknis yang matang terhadap kebutuhan produk.",
        ],
    },
    {
        "name": "Tujuan dan Ruang Lingkup Proyek",
        "weight": 15,
        "levels": [
            "Tujuan proyek tidak dirumuskan, atau ruang lingkup tidak disebutkan.",
            "Tujuan dirumuskan secara umum dan sulit diukur; batas ruang lingkup (yang dikerjakan/tidak dikerjakan) tidak jelas.",
            "Tujuan cukup jelas namun sebagian belum terukur; ruang lingkup disebutkan namun batasannya belum tegas.",
            "Tujuan dirumuskan jelas dan terukur, selaras dengan masalah dan solusi; ruang lingkup ditegaskan dengan batasan yang realistis.",
            "Tujuan dirumuskan jelas, terukur, dan selaras penuh dengan masalah/solusi; ruang lingkup ditegaskan dengan batasan realistis yang mempertimbangkan keterbatasan waktu/sumber daya tim.",
        ],
    },
    {
        "name": "Rencana Kerja dan Organisasi Tim (WBS, Jadwal, Pembagian Peran)",
        "weight": 15,
        "levels": [
            "Tidak ada rencana kerja; WBS, jadwal, dan pembagian peran tidak dilampirkan.",
            "Rencana kerja disebutkan secara umum; WBS/jadwal/pembagian peran ada namun tidak rinci atau tidak realistis.",
            "WBS, jadwal, dan pembagian peran tersedia dan cukup jelas, namun keterkaitan antar-anggota tim dengan modul kerja belum tegas.",
            "WBS, jadwal, dan pembagian peran tersedia rinci dan realistis; setiap anggota tim memiliki tanggung jawab modul yang jelas.",
            "WBS, jadwal, dan pembagian peran tersedia rinci, realistis, dan saling konsisten; beban kerja antaranggota tim tergambar seimbang dan risiko keterlambatan diantisipasi.",
        ],
    },
    {
        "name": "Kelengkapan dan Kualitas Dokumen (Lampiran, Kerapian, Konsistensi Antar-bagian)",
        "weight": 10,
        "levels": [
            "Dokumen tidak lengkap (bagian wajib hilang), format tidak rapi, dan/atau isi antar-bagian saling bertentangan.",
            "Dokumen memuat sebagian besar bagian wajib namun ada yang hilang/kurang lengkap; format dan konsistensi antar-bagian masih lemah.",
            "Dokumen lengkap secara struktur, format cukup rapi, namun ditemukan beberapa inkonsistensi kecil antar-bagian.",
            "Dokumen lengkap, rapi, dan konsisten antar-bagian, dengan lampiran pendukung yang relevan.",
            "Dokumen lengkap, rapi, dan konsisten penuh antar-bagian; lampiran pendukung relevan dan memperkuat argumen proposal secara keseluruhan.",
        ],
    },
]

assert sum(c["weight"] for c in CRITERIA) == 100, "rubric weights must sum to 100%"


def load_dosen_map(path=DOSEN_SOURCE):
    """Return {class_code: {course_name: dosen_name}} for the 18 in-scope
    classes and their PBL-integrated courses only. Reads ONLY the "Ploting"
    sheet -- "Pengajuan Dosen LB" is never opened."""
    wb = openpyxl.load_workbook(path, data_only=True)
    ws = wb["Ploting"]
    dosen_map = {cls: {} for cls in ALL_CLASSES}
    for row in ws.iter_rows(min_row=2, values_only=True):
        prodi, semester, mk, kelas, *_rest = row
        if prodi != "TI" or kelas not in dosen_map:
            continue
        dosen = row[7]
        if semester == 3.0 and mk in SEM3_COURSES:
            dosen_map[kelas][mk] = dosen
        elif semester == 5.0 and mk in SEM5_COURSES:
            dosen_map[kelas][mk] = dosen
    wb.close()
    return dosen_map


_ID_PATTERNS = [
    re.compile(r"[?&]id=([a-zA-Z0-9_-]+)"),
    re.compile(r"/d/([a-zA-Z0-9_-]+)"),
]


def extract_drive_id(url):
    if not url:
        return None
    for pattern in _ID_PATTERNS:
        m = pattern.search(url)
        if m:
            return m.group(1)
    return None


def _full_class_code(tingkat, kelas):
    if not tingkat or not kelas:
        return None
    kelas = str(kelas).strip()
    if "Semester 3" in tingkat:
        return f"TI_2{kelas}"
    if "Semester 5" in tingkat:
        return f"TI_3{kelas}"
    return None


# Teams confirmed to have submitted into this TI-only form by mistake: their
# downloaded proposals explicitly say "PROGRAM STUDI D-IV SISTEM INFORMASI
# BISNIS" on the cover AND every member's NIM carries the SIB program code
# ("...4107 06...") rather than TI's ("...4107 02..."). Verified individually
# before exclusion -- a single mismatched member (e.g. a cross-program
# collaborator) would NOT be grounds for exclusion, only an all-SIB roster.
EXCLUDED_NON_TI_TEAMS = {
    ("TI_3A", "Kelompok 1 Naga Laut"),
    ("TI_3B", "Kelompok-3"),
    ("TI_3B", "KELOMPOK 4"),
}


def load_roster(path=ROSTER_SOURCE):
    """Return {class_code: [team_dict, ...]}, deduped by (class_code,
    nama_tim) keeping the latest Timestamp per team, sorted by timestamp.
    Excludes EXCLUDED_NON_TI_TEAMS (confirmed SIB submissions into this
    TI-only form)."""
    wb = openpyxl.load_workbook(path, data_only=True)
    ws = wb["Form responses 1"]
    best = {}
    for row in ws.iter_rows(min_row=2, values_only=True):
        (timestamp, _email, tingkat, kelas, nama_tim, judul, ketua, berkas, _catatan) = row
        cls = _full_class_code(tingkat, kelas)
        if cls is None or not nama_tim:
            continue
        nama_tim = str(nama_tim).strip()
        if (cls, nama_tim) in EXCLUDED_NON_TI_TEAMS:
            continue
        key = (cls, nama_tim)
        prev = best.get(key)
        if prev is None or (timestamp and prev["timestamp"] and timestamp > prev["timestamp"]):
            best[key] = {
                "class_code": cls,
                "nama_tim": nama_tim,
                "ketua": (ketua or "").strip(),
                "judul": (judul or "").strip(),
                "drive_url": (berkas or "").strip(),
                "file_id": extract_drive_id(berkas),
                "timestamp": timestamp,
            }
    wb.close()

    roster = {cls: [] for cls in ALL_CLASSES}
    for (cls, _nama_tim), team in best.items():
        roster[cls].append(team)
    for cls in roster:
        roster[cls].sort(key=lambda t: (t["timestamp"] is None, t["timestamp"]))
    return roster


# ---------------------------------------------------------------------------
# Shared openpyxl style constants (same Polinema blue/amber palette as
# rpp/Rubrik-Penilaian-PWL-SIB-Sem5.xlsx).
# ---------------------------------------------------------------------------
COLOR_PRIMARY = "003B7A"
COLOR_PRIMARY_DARK = "00274F"
COLOR_ACCENT = "F5A623"
COLOR_LIGHT = "E8F0FB"
COLOR_LIGHT_2 = "FFF8E6"
COLOR_BORDER = "C5D4E8"
COLOR_WHITE = "FFFFFF"
COLOR_TEXT = "1A1A2E"
COLOR_BAD = "FDEAEA"
COLOR_BAD_TEXT = "B00020"
COLOR_LINK = "1155CC"

FONT_TITLE = Font(name="Calibri", size=16, bold=True, color=COLOR_WHITE)
FONT_SUBTITLE = Font(name="Calibri", size=11, color=COLOR_LIGHT)
FONT_SECTION = Font(name="Calibri", size=12, bold=True, color=COLOR_WHITE)
FONT_HEADER = Font(name="Calibri", size=10, bold=True, color=COLOR_WHITE)
FONT_BODY = Font(name="Calibri", size=10, color=COLOR_TEXT)
FONT_LABEL = Font(name="Calibri", size=10, bold=True, color=COLOR_TEXT)
FONT_COMPUTED = Font(name="Calibri", size=10, bold=True, color=COLOR_PRIMARY_DARK)
FONT_LINK = Font(name="Calibri", size=10, color=COLOR_LINK, underline="single")

FILL_HEADER = PatternFill("solid", fgColor=COLOR_PRIMARY)
FILL_SECTION = PatternFill("solid", fgColor=COLOR_PRIMARY_DARK)
FILL_INPUT = PatternFill("solid", fgColor=COLOR_LIGHT_2)
FILL_COMPUTED = PatternFill("solid", fgColor=COLOR_LIGHT)

_thin = Side(style="thin", color=COLOR_BORDER)
BORDER_ALL = Border(left=_thin, right=_thin, top=_thin, bottom=_thin)

WRAP_TOP = Alignment(horizontal="left", vertical="top", wrap_text=True)
CENTER = Alignment(horizontal="center", vertical="center", wrap_text=True)
LEFT = Alignment(horizontal="left", vertical="center", wrap_text=True)


def style_header_cell(cell, alignment=CENTER):
    cell.font = FONT_HEADER
    cell.fill = FILL_HEADER
    cell.alignment = alignment
    cell.border = BORDER_ALL


def style_input_cell(cell, alignment=CENTER):
    cell.fill = FILL_INPUT
    cell.font = FONT_BODY
    cell.alignment = alignment
    cell.border = BORDER_ALL


def style_computed_cell(cell, alignment=CENTER):
    cell.fill = FILL_COMPUTED
    cell.font = FONT_COMPUTED
    cell.alignment = alignment
    cell.border = BORDER_ALL


def style_body_cell(cell, alignment=WRAP_TOP):
    cell.font = FONT_BODY
    cell.alignment = alignment
    cell.border = BORDER_ALL


def merge_title(ws, row, span, text, font=FONT_TITLE, alignment=LEFT, start_col=1, fill=None):
    ws.merge_cells(start_row=row, start_column=start_col, end_row=row, end_column=start_col + span - 1)
    cell = ws.cell(row=row, column=start_col, value=text)
    cell.font = font
    cell.alignment = alignment
    if fill:
        for col in range(start_col, start_col + span):
            ws.cell(row=row, column=col).fill = fill
    return cell


def section_title(ws, row, span, text, start_col=1):
    ws.merge_cells(start_row=row, start_column=start_col, end_row=row, end_column=start_col + span - 1)
    cell = ws.cell(row=row, column=start_col, value=text)
    cell.font = FONT_SECTION
    cell.alignment = LEFT
    for col in range(start_col, start_col + span):
        c = ws.cell(row=row, column=col)
        c.fill = FILL_SECTION
        c.border = BORDER_ALL
    return cell


def add_not_100_check(ws, cell_ref):
    ws.conditional_formatting.add(
        cell_ref,
        CellIsRule(
            operator="notEqual",
            formula=["100"],
            fill=PatternFill("solid", fgColor=COLOR_BAD),
            font=Font(color=COLOR_BAD_TEXT, bold=True),
        ),
    )
