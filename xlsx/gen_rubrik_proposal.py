"""
Generate one self-contained Proposal-grading rubric workbook PER CLASS for TI
Semester 3 (TI_2A..TI_2I) and TI Semester 5 (TI_3A..TI_3I) -- 18 files total.

Context: rpp/berita-acara.txt records a meeting (4 Sep 2026) mandating a
per-checkpoint rubric per PBL-integrated course, with the Proposal-checkpoint
rubric due Week 3. The course lecturer responsible for authoring it has not
submitted one, so this generic rubric is a real, usable fallback -- applied
uniformly across every class rather than tied to any one course's wording.

Each class has several PBL-integrated courses, each with its own dosen
pengampu. Every dosen grades the SAME teams independently, in their OWN
sheet (so multiple lecturers can fill in the same file without clashing),
using the shared 6-criteria rubric. A "Rekap" sheet in the same file then
pulls every lecturer's Nilai Akhir and Revisi note per team side by side and
computes the team's final average grade.

Scoring is GROUP-LEVEL ONLY. There is no individual-level row, column, or
sheet anywhere in this workbook: at the proposal phase there is no individual
work product to grade, and individual-contribution scoring stays entirely the
course lecturer's own responsibility at later checkpoints.

Team member note: the source submission form (docs/Pengumpulan Proposal PBL TI
(Responses).xlsx) never collected a structured team-member list -- only the
team name and team leader's name. There is no reliable way to auto-populate
full member rosters from it. The "Anggota Tim" column is pre-filled with the
known team leader and left as an editable (yellow) cell so the lecturer can
complete it from the proposal document's own "Identitas Tim" section while
grading.

Usage:
    uv run --with openpyxl python xlsx/gen_rubrik_proposal.py [output_dir]

Real data is read at generation time from:
    docs/Plotting Dosen Gasal 2026-2027.xlsx      (sheet "Ploting" only)
    docs/Pengumpulan Proposal PBL TI (Responses).xlsx

The "Berkas Proposal" column always links to the team's original Google Drive
submission -- it never links to a local copy.
"""
import json
import sys
from pathlib import Path

from openpyxl import Workbook
from openpyxl.utils import get_column_letter
from openpyxl.worksheet.datavalidation import DataValidation

sys.path.insert(0, str(Path(__file__).resolve().parent))
from extract_members import MEMBERS_MANIFEST_PATH  # noqa: E402
from rubrik_common import (  # noqa: E402
    ROOT,
    ALL_CLASSES,
    CRITERIA,
    add_not_100_check,
    courses_for_class,
    load_dosen_map,
    load_roster,
    merge_title,
    safe_sheet_name,
    section_title,
    semester_label,
    style_body_cell,
    style_computed_cell,
    style_header_cell,
    style_input_cell,
    FONT_SUBTITLE,
    FONT_LABEL,
    FONT_LINK,
    FILL_HEADER,
    FILL_COMPUTED,
    FILL_INPUT,
    CENTER,
    LEFT,
    WRAP_TOP,
)

N_CRIT = len(CRITERIA)
DEFAULT_OUTPUT_DIR = ROOT / "rpp" / "rubrik-proposal"

# Fixed layout for every lecturer sheet -- identical across all lecturers and
# all classes, since a lecturer sheet only ever shows ONE course/dosen (no
# variable-length dosen table), so team rows always start at the same row.
TITLE_ROW = 1
SUBTITLE_ROW = 2
SECTION_ROW = 4
HEADER_ROW = 5
ECHO_ROW = 6
TEAM_START = 7

# Lecturer-sheet columns: No, Nama Tim, Nama Ketua Tim, Anggota Tim,
# Judul Produk, N_CRIT score columns, Nilai Akhir, Revisi, Berkas Proposal.
COL_NO, COL_TIM, COL_KETUA, COL_ANGGOTA, COL_JUDUL = 1, 2, 3, 4, 5
COL_SCORE_START = 6
COL_NILAI = COL_SCORE_START + N_CRIT
COL_REVISI = COL_NILAI + 1
COL_BERKAS = COL_REVISI + 1
N_COLS = COL_BERKAS


def set_col_widths(ws, widths):
    for i, w in enumerate(widths, start=1):
        ws.column_dimensions[get_column_letter(i)].width = w


def load_members_manifest():
    if not MEMBERS_MANIFEST_PATH.exists():
        return {}
    return json.loads(MEMBERS_MANIFEST_PATH.read_text(encoding="utf-8"))


def anggota_tim_text(class_code, team, members_manifest):
    key = f"{class_code}::{team['nama_tim']}"
    entry = members_manifest.get(key)
    if entry and entry.get("members"):
        return "\n".join(f"{m['nama']} ({m['nim']})" for m in entry["members"])
    return f"Ketua: {team['ketua']}" if team["ketua"] else ""


def berkas_cell_content(team):
    if team.get("drive_url"):
        return "Buka tautan Drive", team["drive_url"]
    return "(tidak ada tautan)", None


# ---------------------------------------------------------------------------
# Petunjuk
# ---------------------------------------------------------------------------
def build_petunjuk_sheet(wb, class_code, courses):
    ws = wb.create_sheet("Petunjuk")
    set_col_widths(ws, [95])

    merge_title(ws, 1, 1, f"Rubrik Penilaian Proposal PBL - Kelas {class_code}", fill=FILL_HEADER)
    ws.row_dimensions[1].height = 28
    merge_title(
        ws, 2, 1,
        f"{semester_label(class_code)} - Checkpoint Proposal (Minggu 3)",
        font=FONT_SUBTITLE, fill=FILL_HEADER,
    )
    ws.row_dimensions[2].height = 20

    daftar_dosen = ", ".join(courses)
    lines = [
        ("", ""),
        ("Latar belakang", (
            "Rapat koordinasi PBL tanggal 4 September 2026 mewajibkan setiap mata kuliah terintegrasi "
            "PBL menyusun rubrik penilaian per checkpoint sendiri, dengan rubrik Proposal jatuh tempo "
            "pada Minggu 3. Hingga saat ini rubrik khusus per mata kuliah belum diserahkan, sehingga "
            "rubrik umum ini digunakan sebagai standar sementara yang berlaku sama untuk seluruh kelas."
        )),
        ("Setiap dosen menilai di sheet sendiri", (
            f"Kelas {class_code} diampu oleh {len(courses)} mata kuliah terintegrasi PBL: {daftar_dosen}. "
            "Setiap mata kuliah punya sheet penilaian sendiri (nama sheet = nama mata kuliah), sehingga "
            "setiap dosen pengampu dapat mengisi nilai secara independen dalam satu berkas yang sama "
            "tanpa saling menimpa isian dosen lain."
        )),
        ("Skala penilaian", (
            "Setiap kriteria dinilai pada skala 1-5 (1 = sangat kurang, 5 = sangat baik) melalui "
            "dropdown pada sel yang berwarna kuning. Deskriptor lengkap setiap level ada di sheet "
            "\"Rubrik\"."
        )),
        ("PENTING - penilaian hanya level kelompok", (
            "Seluruh penilaian pada workbook ini berada di level TIM/KELOMPOK. Tidak ada penilaian "
            "individu pada tahap proposal, karena pada fase ini belum ada produk kerja individu yang "
            "bisa dinilai terpisah dari dokumen tim. Penilaian kontribusi individu mahasiswa sepenuhnya "
            "menjadi kewenangan dosen pengampu masing-masing mata kuliah pada checkpoint berikutnya "
            "(Milestone 1, Milestone 2, dan Final), menggunakan mekanisme yang mereka tentukan sendiri."
        )),
        ("Kolom Anggota Tim", (
            "Formulir pengumpulan proposal tidak mengumpulkan daftar anggota tim secara terstruktur, "
            "hanya nama tim dan nama ketua tim. Kolom \"Anggota Tim\" sudah diisi awal dengan nama ketua "
            "dan berwarna kuning (bisa diedit) -- mohon lengkapi dengan anggota lain saat memeriksa "
            "proposal, mengacu pada bagian Identitas Tim di dokumen proposal masing-masing."
        )),
        ("Bobot kriteria", (
            "Bobot tiap kriteria (lihat sheet \"Rubrik\") dalam kelipatan 5% dan berjumlah 100%. Baris "
            "bobot ini digandakan (di-echo) di setiap sheet dosen tepat di atas grid penilaian agar "
            "rumus SUMPRODUCT selalu konsisten dengan sheet Rubrik dan tidak bisa tergeser."
        )),
        ("Nilai akhir tim", (
            "Dihitung otomatis (sel biru, jangan diedit manual) dengan rumus SUMPRODUCT(skor, bobot) / "
            "SUM(bobot) / 5 * 100, menghasilkan nilai pada skala 0-100, per dosen pengampu."
        )),
        ("Kolom Revisi", (
            "Kolom \"Revisi\" pada setiap sheet dosen adalah catatan bebas (bukan skor) untuk menuliskan "
            "hal yang perlu diperbaiki tim pada proposalnya, dari sudut pandang mata kuliah tersebut."
        )),
        ("Berkas proposal", (
            "Kolom \"Berkas Proposal\" berisi tautan langsung ke berkas yang diunggah tim di Google Drive."
        )),
        ("Sheet Rekap", (
            "Sheet \"Rekap\" merangkum Nilai Akhir dan Revisi dari SEMUA dosen pengampu kelas ini secara "
            "berdampingan per tim, lalu menghitung Nilai Rata-rata tim tersebut secara otomatis."
        )),
        ("Legenda warna", ""),
    ]

    row = 4
    for label, text in lines:
        if not label and not text:
            row += 1
            continue
        cell = ws.cell(row=row, column=1, value=label)
        cell.font = FONT_LABEL
        cell.alignment = LEFT
        row += 1
        if text:
            cell = ws.cell(row=row, column=1, value=text)
            style_body_cell(cell)
            ws.row_dimensions[row].height = 46
            row += 1
        row += 1

    legend_input = ws.cell(row=row, column=1, value="  Kuning -> sel input (dosen mengisi skor 1-5 / anggota tim / catatan revisi)")
    legend_input.fill = FILL_INPUT
    legend_input.font = FONT_LABEL
    row += 1
    legend_computed = ws.cell(row=row, column=1, value="  Biru   -> sel komputasi (jangan diedit manual)")
    legend_computed.fill = FILL_COMPUTED
    legend_computed.font = FONT_LABEL
    row += 1

    ws.sheet_view.showGridLines = False
    return ws


# ---------------------------------------------------------------------------
# Rubrik (master reference table, shared as-is by every class file)
# ---------------------------------------------------------------------------
def build_rubrik_sheet(wb):
    ws = wb.create_sheet("Rubrik")
    set_col_widths(ws, [4, 34, 9, 30, 30, 30, 30, 30])

    merge_title(ws, 1, 8, "Rubrik Penilaian Proposal (Umum, Berlaku Semua Kelas)", fill=FILL_HEADER)
    ws.row_dimensions[1].height = 26

    header_row = 3
    headers = ["No", "Kriteria", "Bobot (%)"] + [f"Level {i}" for i in range(1, 6)]
    for col, text in enumerate(headers, start=1):
        style_header_cell(ws.cell(row=header_row, column=col, value=text))
    ws.row_dimensions[header_row].height = 20

    r = header_row + 1
    for i, crit in enumerate(CRITERIA, start=1):
        style_body_cell(ws.cell(row=r, column=1, value=i), alignment=CENTER)
        style_body_cell(ws.cell(row=r, column=2, value=crit["name"]))
        style_body_cell(ws.cell(row=r, column=3, value=crit["weight"]), alignment=CENTER)
        for j, level_text in enumerate(crit["levels"], start=4):
            style_body_cell(ws.cell(row=r, column=j, value=level_text))
        ws.row_dimensions[r].height = 92
        r += 1

    total_row = r
    ws.cell(row=total_row, column=2, value="Total Bobot").font = FONT_LABEL
    total_cell = ws.cell(row=total_row, column=3, value=f"=SUM(C{header_row + 1}:C{r - 1})")
    style_computed_cell(total_cell)
    add_not_100_check(ws, total_cell.coordinate)

    ws.freeze_panes = "A4"
    ws.sheet_view.showGridLines = False
    return ws


# ---------------------------------------------------------------------------
# One sheet per lecturer/course
# ---------------------------------------------------------------------------
def build_lecturer_sheet(wb, sheet_name, class_code, course, dosen_name, teams, members_manifest):
    ws = wb.create_sheet(sheet_name)

    widths = [4, 22, 22, 26, 30] + [16] * N_CRIT + [12, 26, 24]
    set_col_widths(ws, widths)

    merge_title(ws, TITLE_ROW, N_COLS, f"Penilaian Proposal - {course}", fill=FILL_HEADER)
    ws.row_dimensions[TITLE_ROW].height = 26
    merge_title(
        ws, SUBTITLE_ROW, N_COLS,
        f"Kelas {class_code} - Dosen Pengampu: {dosen_name} - {semester_label(class_code)}",
        font=FONT_SUBTITLE, fill=FILL_HEADER,
    )
    ws.row_dimensions[SUBTITLE_ROW].height = 18

    section_title(ws, SECTION_ROW, N_COLS, "Penilaian Proposal per Tim (Nilai Kelompok)")

    headers = ["No", "Nama Tim", "Nama Ketua Tim", "Anggota Tim", "Judul Produk"]
    for crit in CRITERIA:
        headers.append(f"{crit['name']} ({crit['weight']}%)")
    headers += ["Nilai Akhir", "Revisi", "Berkas Proposal"]
    for col, text in enumerate(headers, start=1):
        style_header_cell(ws.cell(row=HEADER_ROW, column=col, value=text))
    ws.row_dimensions[HEADER_ROW].height = 42

    # Weight-echo row: mirrors sheet "Rubrik" weights directly, so SUMPRODUCT
    # below can never drift out of sync with the master rubric.
    ws.cell(row=ECHO_ROW, column=3, value="Bobot ->").font = FONT_LABEL
    ws.cell(row=ECHO_ROW, column=3).alignment = LEFT
    for i, crit in enumerate(CRITERIA):
        col = COL_SCORE_START + i
        style_computed_cell(ws.cell(row=ECHO_ROW, column=col, value=crit["weight"]))
    ws.row_dimensions[ECHO_ROW].height = 16

    score_start_letter = get_column_letter(COL_SCORE_START)
    score_end_letter = get_column_letter(COL_SCORE_START + N_CRIT - 1)
    dv = DataValidation(type="list", formula1='"1,2,3,4,5"', allow_blank=True)
    ws.add_data_validation(dv)

    if not teams:
        ws.merge_cells(start_row=TEAM_START, start_column=1, end_row=TEAM_START, end_column=N_COLS)
        style_body_cell(
            ws.cell(row=TEAM_START, column=1, value="Belum ada tim terdaftar untuk kelas ini."),
            alignment=CENTER,
        )

    for i, team in enumerate(teams):
        r = TEAM_START + i
        style_body_cell(ws.cell(row=r, column=COL_NO, value=i + 1), alignment=CENTER)
        style_body_cell(ws.cell(row=r, column=COL_TIM, value=team["nama_tim"]), alignment=LEFT)
        style_body_cell(ws.cell(row=r, column=COL_KETUA, value=team["ketua"]), alignment=LEFT)
        style_input_cell(
            ws.cell(row=r, column=COL_ANGGOTA, value=anggota_tim_text(class_code, team, members_manifest)),
            alignment=WRAP_TOP,
        )
        style_body_cell(ws.cell(row=r, column=COL_JUDUL, value=team["judul"]), alignment=WRAP_TOP)

        for j in range(N_CRIT):
            col = COL_SCORE_START + j
            cell = ws.cell(row=r, column=col)
            style_input_cell(cell)
            dv.add(cell)

        nilai_formula = (
            f"=IF(COUNT({score_start_letter}{r}:{score_end_letter}{r})<{N_CRIT},\"\","
            f"SUMPRODUCT({score_start_letter}{r}:{score_end_letter}{r},"
            f"${score_start_letter}${ECHO_ROW}:${score_end_letter}${ECHO_ROW})"
            f"/SUM(${score_start_letter}${ECHO_ROW}:${score_end_letter}${ECHO_ROW})/5*100)"
        )
        style_computed_cell(ws.cell(row=r, column=COL_NILAI, value=nilai_formula))

        style_input_cell(ws.cell(row=r, column=COL_REVISI), alignment=WRAP_TOP)

        text, link = berkas_cell_content(team)
        berkas_cell = ws.cell(row=r, column=COL_BERKAS, value=text)
        if link:
            berkas_cell.hyperlink = link
        style_body_cell(berkas_cell, alignment=CENTER)
        if link:
            berkas_cell.font = FONT_LINK

    ws.freeze_panes = ws.cell(row=HEADER_ROW + 1, column=COL_TIM).coordinate
    ws.sheet_view.showGridLines = False
    return ws


# ---------------------------------------------------------------------------
# Rekap -- recaps every lecturer's grade for every team in this class
# ---------------------------------------------------------------------------
def build_recap_sheet(wb, class_code, courses, lecturer_sheet_names, teams):
    ws = wb.create_sheet("Rekap")

    fixed_widths = [4, 22, 22, 26, 30]
    per_course_widths = [12, 26] * len(courses)
    tail_widths = [14, 24]
    set_col_widths(ws, fixed_widths + per_course_widths + tail_widths)

    n_cols = len(fixed_widths) + len(per_course_widths) + len(tail_widths)
    merge_title(ws, 1, n_cols, f"Rekap Nilai Proposal - Kelas {class_code} (Semua Dosen)", fill=FILL_HEADER)
    ws.row_dimensions[1].height = 26
    merge_title(
        ws, 2, n_cols,
        f"{semester_label(class_code)} - Checkpoint Proposal",
        font=FONT_SUBTITLE, fill=FILL_HEADER,
    )
    ws.row_dimensions[2].height = 18

    header_row = 4
    headers = ["No", "Nama Tim", "Nama Ketua Tim", "Anggota Tim", "Judul Produk"]
    for course in courses:
        headers += [f"Nilai - {course}", f"Revisi - {course}"]
    headers += ["Nilai Rata-rata", "Berkas Proposal"]
    for col, text in enumerate(headers, start=1):
        style_header_cell(ws.cell(row=header_row, column=col, value=text))
    ws.row_dimensions[header_row].height = 42

    avg_col = len(fixed_widths) + len(per_course_widths) + 1
    berkas_col = avg_col + 1
    team_start = header_row + 1

    if not teams:
        ws.merge_cells(start_row=team_start, start_column=1, end_row=team_start, end_column=n_cols)
        style_body_cell(
            ws.cell(row=team_start, column=1, value="Belum ada tim terdaftar untuk kelas ini."),
            alignment=CENTER,
        )

    anggota_col_letter = get_column_letter(COL_ANGGOTA)
    for i, team in enumerate(teams):
        r = team_start + i
        lecturer_row = TEAM_START + i  # same team index -> same row on every lecturer sheet
        first_lecturer_sheet = lecturer_sheet_names[0]

        style_body_cell(ws.cell(row=r, column=COL_NO, value=i + 1), alignment=CENTER)
        style_body_cell(ws.cell(row=r, column=COL_TIM, value=team["nama_tim"]), alignment=LEFT)
        style_body_cell(ws.cell(row=r, column=COL_KETUA, value=team["ketua"]), alignment=LEFT)
        style_body_cell(
            ws.cell(row=r, column=COL_ANGGOTA, value=f"='{first_lecturer_sheet}'!{anggota_col_letter}{lecturer_row}"),
            alignment=WRAP_TOP,
        )
        style_body_cell(ws.cell(row=r, column=COL_JUDUL, value=team["judul"]), alignment=WRAP_TOP)

        nilai_refs = []
        col = COL_JUDUL + 1
        for sheet_name in lecturer_sheet_names:
            nilai_col_letter = get_column_letter(COL_NILAI)
            revisi_col_letter = get_column_letter(COL_REVISI)
            nilai_ref = f"'{sheet_name}'!{nilai_col_letter}{lecturer_row}"
            style_computed_cell(ws.cell(row=r, column=col, value=f"={nilai_ref}"))
            nilai_refs.append(f"{get_column_letter(col)}{r}")
            col += 1
            style_body_cell(
                ws.cell(row=r, column=col, value=f"='{sheet_name}'!{revisi_col_letter}{lecturer_row}"),
                alignment=WRAP_TOP,
            )
            col += 1

        avg_formula = f'=IFERROR(AVERAGE({",".join(nilai_refs)}),"")'
        style_computed_cell(ws.cell(row=r, column=avg_col, value=avg_formula))

        text, link = berkas_cell_content(team)
        berkas_cell = ws.cell(row=r, column=berkas_col, value=text)
        if link:
            berkas_cell.hyperlink = link
        style_body_cell(berkas_cell, alignment=CENTER)
        if link:
            berkas_cell.font = FONT_LINK

    ws.freeze_panes = ws.cell(row=team_start, column=COL_TIM).coordinate
    ws.sheet_view.showGridLines = False
    return ws


def build_class_workbook(class_code, dosen_map, roster, members_manifest):
    teams = roster.get(class_code, [])
    courses = courses_for_class(class_code)
    class_dosen = dosen_map.get(class_code, {})

    wb = Workbook()
    wb.remove(wb.active)

    build_petunjuk_sheet(wb, class_code, courses)
    build_rubrik_sheet(wb)

    lecturer_sheet_names = []
    used_names = set()
    for course in courses:
        sheet_name = safe_sheet_name(course)
        base, suffix = sheet_name, 2
        while sheet_name in used_names:
            sheet_name = safe_sheet_name(f"{base} ({suffix})")
            suffix += 1
        used_names.add(sheet_name)
        lecturer_sheet_names.append(sheet_name)
        dosen_name = class_dosen.get(course, "(belum ada data)")
        build_lecturer_sheet(wb, sheet_name, class_code, course, dosen_name, teams, members_manifest)

    build_recap_sheet(wb, class_code, courses, lecturer_sheet_names, teams)

    return wb


def main():
    out_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_OUTPUT_DIR
    out_dir.mkdir(parents=True, exist_ok=True)

    dosen_map = load_dosen_map()
    roster = load_roster()
    members_manifest = load_members_manifest()

    written = []
    for class_code in ALL_CLASSES:
        wb = build_class_workbook(class_code, dosen_map, roster, members_manifest)
        out_path = out_dir / f"Rubrik-Penilaian-Proposal-{class_code}.xlsx"
        wb.save(out_path)
        written.append((class_code, out_path, len(wb.sheetnames), len(roster.get(class_code, []))))

    print(f"Ditulis {len(written)} berkas ke {out_dir}")
    for class_code, out_path, n_sheets, n_teams in written:
        print(f"  {out_path.name}: {n_sheets} sheet, {n_teams} tim")

    total_teams = sum(len(v) for v in roster.values())
    print(
        f"Anggota tim terisi otomatis untuk {len(members_manifest)}/{total_teams} tim "
        f"(dari xlsx/members_manifest.json); sisanya memakai placeholder \"Ketua: <nama>\" "
        f"untuk dilengkapi manual."
    )


if __name__ == "__main__":
    main()
