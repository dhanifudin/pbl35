"""Aggregate PBL monev survey responses into anonymous summaries for the reports.

Run from the repo root:
    uv run --with openpyxl python -I monev/laporan/analyze_monev.py

Reads raw data from docs/monev/ (never copied), writes ONLY aggregates to
monev/laporan/data/agregat.json. Names, NIMs and grades in the class rosters are
never stored: rosters are only used to count students per class.
"""
import collections
import glob
import io
import json
import os
import re
import statistics
import zipfile

import openpyxl

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RAW = os.path.join(ROOT, "docs", "monev")
OUT = os.path.join(ROOT, "monev", "laporan", "data", "agregat.json")
MIN_GROUP = 5  # Panduan Monev section 7: groups below this are merged, not reported

# --------------------------------------------------------------------------- helpers


def load_sheet(path, sheet=None):
    wb = openpyxl.load_workbook(path, read_only=True, data_only=True)
    ws = wb[sheet] if sheet else wb.worksheets[0]
    rows = list(ws.iter_rows(values_only=True))
    return rows[0], rows[1:]


def likert(v):
    """'4 Setuju / Agree' -> 4 ; 'Tidak dapat menilai' / blank -> None."""
    if v is None:
        return None
    s = str(v).strip()
    return int(s[0]) if s[:1] in "12345" and (len(s) == 1 or s[1] in " .") else None


def idn(v):
    """Indonesian part of a bilingual 'ID / EN' answer."""
    return str(v).split(" / ")[0].strip()


def split_multi(cell):
    if cell in (None, ""):
        return []
    return [p.strip() for p in re.split(r", (?=[A-Z])", str(cell))]


def category(mean):
    if mean is None:
        return None
    if mean >= 4.21:
        return "Sangat baik"
    if mean >= 3.41:
        return "Baik"
    if mean >= 2.61:
        return "Cukup"
    if mean >= 1.81:
        return "Kurang"
    return "Sangat kurang"


def lk_stats(values):
    """values: raw cells of one Likert item -> dict."""
    nums = [likert(v) for v in values]
    valid = [x for x in nums if x is not None]
    n_all = len([v for v in values if v not in (None, "")])
    dist = [valid.count(i) for i in range(1, 6)]
    if not valid:
        return {"n": 0, "n_all": n_all, "mean": None, "pct_agree": None, "dist": dist, "cat": None}
    mean = sum(valid) / len(valid)
    return {
        "n": len(valid),
        "n_all": n_all,
        "mean": round(mean, 2),
        "pct_agree": round(100 * sum(1 for x in valid if x >= 4) / len(valid), 1),
        "dist": dist,
        "cat": category(mean),
    }


def freq(items, n_resp, top=None):
    c = collections.Counter(items)
    out = [{"label": k, "count": v, "pct": round(100 * v / n_resp, 1) if n_resp else 0} for k, v in c.most_common()]
    return out[:top] if top else out


def dist_of(values, order=None):
    vals = [idn(v) for v in values if v not in (None, "")]
    n = len(vals)
    c = collections.Counter(vals)
    keys = order or [k for k, _ in c.most_common()]
    return {"n": n, "items": [{"label": k, "count": c.get(k, 0), "pct": round(100 * c.get(k, 0) / n, 1) if n else 0} for k in keys]}


def fix_zero(v):
    """Google Sheets turned the answer '0 kali' into the number 0.0."""
    if isinstance(v, (int, float)) and v == 0:
        return "0 kali"
    return v


def norm_class(v):
    return re.sub(r"-+", "-", str(v).strip().upper()) if v else None


# --------------------------------------------------------------------------- rosters


def load_rosters():
    """Return {class_label: n_students} using counts only (e.g. 'TI-2B': 31)."""
    counts = {}
    for zpath in glob.glob(os.path.join(RAW, "drive-download-*.zip")):
        z = zipfile.ZipFile(zpath)
        for name in z.namelist():
            m = re.search(r"D4(TI|SIB)-(\d[A-Z])\.xlsx$", name)
            if not m:
                continue
            label = f"{m.group(1)}-{m.group(2)}"
            wb = openpyxl.load_workbook(io.BytesIO(z.read(name)), read_only=True, data_only=True)
            ws = wb["Rekap Nilai"]
            nim_col, n = None, 0
            for row in ws.iter_rows(values_only=True):
                if nim_col is None:
                    for i, c in enumerate(row):
                        if isinstance(c, str) and c.strip().upper().startswith("NIM"):
                            nim_col = i
                    continue
                if nim_col < len(row) and isinstance(row[nim_col], (int, float)) and row[nim_col] > 1e9:
                    n += 1
            counts[label] = n
    return counts


# --------------------------------------------------------------------------- student columns

# course block layout: (key, class col, [course names], first course col, explained, attendance, type, share)
BLOCKS = {
    "TI Semester 3": dict(prodi="TI", sem=3, cls=3, courses=["Manajemen Proyek", "Desain dan Pemrograman Web", "Basis Data Lanjut", "Sistem Informasi Manajemen"], c0=4, expl=60, att=64, typ=68, share=72),
    "TI Semester 5": dict(prodi="TI", sem=5, cls=76, courses=["Pemrograman Mobile", "Pembelajaran Mesin", "Penjaminan Mutu Perangkat Lunak"], c0=77, expl=119, att=122, typ=125, share=128),
    "SIB Semester 3": dict(prodi="SIB", sem=3, cls=131, courses=["Pemrograman Web", "Basis Data Lanjut", "Desain UI/UX"], c0=132, expl=174, att=177, typ=180, share=183),
    "SIB Semester 5": dict(prodi="SIB", sem=5, cls=186, courses=["Pemrograman Web Lanjut", "Manajemen Proyek Sistem Informasi", "Penjaminan Mutu Perangkat Lunak"], c0=187, expl=229, att=232, typ=235, share=238),
}
ACT_LABELS = ["Mengaitkan materi dengan proyek", "Menyediakan waktu diskusi proyek", "Memeriksa progres proyek tim", "Memberi umpan balik proyek", "Membahas kendala teknis"]
BC_LABELS = [
    "Kontrak kuliah memuat kaitan dengan proyek", "Materi diberikan sebelum dibutuhkan milestone", "Contoh dan studi kasus berkaitan dengan proyek",
    "Tugas bagian dari proyek, bukan tugas tambahan", "Kriteria penilaian tugas sejalan dengan proyek", "Materi pendukung tersedia di LMS",
    "Materi disesuaikan saat tim mengalami kendala", "Materi terhubung dengan mata kuliah lain", "Dosen mengetahui topik proyek tim",
]

OPS = [  # label, student col, lecturer col
    ("Alur dan target milestone dijelaskan jelas", 252, 46),
    ("SOP dan template laporan membantu", 253, 47),
    ("Jadwal dan tenggat milestone realistis", 254, 48),
    ("Bimbingan dosen memadai", 255, 49),
    ("Tugas dan penilaian antar-mata kuliah selaras", 256, 50),
    ("Rubrik dan kriteria penilaian jelas", 257, 51),
    ("Penilaian adil terhadap kontribusi anggota", 258, 52),
    ("Fasilitas dan sumber daya memadai", 259, 53),
]
BEN = [
    ("Meningkatkan keterampilan teknis", 260, 57),
    ("Meningkatkan kerja sama dan komunikasi", 261, 58),
    ("Lebih siap menghadapi dunia kerja", 262, 59),
    ("Puas dengan pelaksanaan PBL", 263, 60),
    ("Setuju PBL dilanjutkan", 264, 61),
]
STU_COORD = [  # label, col, kind
    ("Dosen antar mata kuliah mengetahui progres proyek", 247, "yn"),
    ("Arahan dosen antar mata kuliah konsisten", 248, "yn"),
    ("Tim tahu harus menghubungi dosen siapa", 249, "yn"),
    ("Tenggat antar mata kuliah bertabrakan", 250, "lk"),
    ("Kendala tim baru diketahui dosen saat review", 251, "lk"),
]
LEC_COORD_YN = [
    ("Mengetahui topik proyek setiap tim", 35),
    ("Mengetahui dosen lain di kelas yang sama", 36),
    ("Ada kesepakatan pembagian peran antar dosen", 37),
    ("Jelas dosen rujukan utama tim", 38),
    ("Dosen saling mengetahui perkembangan tim", 39),
]
LEC_COORD_LK = [
    ("Menyelaraskan tenggat dengan dosen lain", 40),
    ("Menyelaraskan rubrik/penilaian dengan dosen lain", 41),
    ("Berbagi progres/kendala tim dengan dosen lain", 42),
    ("Membahas tim bermasalah bersama dosen lain", 43),
    ("Baru tahu kendala tim saat review milestone", 44),
]
LEC_ALIGN = [  # RPS and material alignment, 20-27
    ("RPS disesuaikan untuk mendukung PBL", 20), ("Urutan materi disesuaikan dengan milestone", 21),
    ("Contoh dan studi kasus memakai konteks proyek", 22), ("Tugas mata kuliah bagian dari deliverable proyek", 23),
    ("Rubrik tugas selaras dengan rubrik PBL", 24), ("Materi pendukung proyek tersedia di LMS", 25),
    ("Materi disesuaikan dengan kendala tim", 26), ("Materi/tugas dirancang bersama dosen lain", 27),
]


def col(rows, i):
    return [r[i] if i < len(r) else None for r in rows]


def stu_multi(rows, c):
    """Student multi-select: real options are bilingual 'ID / EN'; anything else is free text -> 'Lainnya'."""
    return [idn(x) if " / " in x else "Lainnya" for r in rows for x in split_multi(r[c])]


LEC_COUNTS = {}  # (col, option) -> count over ALL lecturers, set in main()


def lec_multi(rows, c):
    """Lecturer multi-select: a singleton answer longer than 40 characters is free text -> 'Lainnya'."""
    out = []
    for r in rows:
        for x in split_multi(r[c]):
            out.append("Lainnya" if LEC_COUNTS.get((c, x), 0) <= 1 and len(x) > 40 else x)
    return out


def yn_dist(values):
    vals = [idn(v) for v in values if v not in (None, "")]
    n = len(vals)
    c = collections.Counter(vals)
    return {"n": n, "ya": round(100 * c["Ya"] / n, 1) if n else None, "sebagian": round(100 * c["Sebagian"] / n, 1) if n else None,
            "tidak": round(100 * c["Tidak"] / n, 1) if n else None, "tidak_tahu": round(100 * c["Tidak tahu"] / n, 1) if n else None}


def pct_oftenalways(values):
    nums = [likert(v) for v in values]
    nums = [x for x in nums if x is not None]
    return round(100 * sum(1 for x in nums if x >= 4) / len(nums), 1) if nums else None


# --------------------------------------------------------------------------- scope builder


def student_scope(rows, rosters, prodi):
    """rows: student rows of one scope. prodi: None | 'TI' | 'SIB'."""
    n = len(rows)
    out: dict = {"n": n}

    # response rate (per semester and per class)
    sems, classes = [], []
    for key, b in BLOCKS.items():
        if prodi and b["prodi"] != prodi:
            continue
        rr = [r for r in rows if r[2] == key]
        cls = collections.Counter(norm_class(r[b["cls"]]) for r in rr if r[b["cls"]])
        letter_prefix = f"{b['prodi']}-{2 if b['sem'] == 3 else 3}"
        roster_classes = {k: v for k, v in rosters.items() if k.startswith(letter_prefix)}
        total = sum(roster_classes.values())
        sems.append({"label": key, "n": len(rr), "roster": total, "rate": round(100 * len(rr) / total, 1) if total else None, "classes": len(roster_classes)})
        for k in sorted(roster_classes):
            classes.append({"prodi": b["prodi"], "sem": b["sem"], "label": k, "n": cls.get(k, 0), "roster": roster_classes[k],
                            "rate": round(100 * cls.get(k, 0) / roster_classes[k], 1) if roster_classes[k] else None})
        unknown = {k: v for k, v in cls.items() if k not in roster_classes}
        if unknown:
            print("WARNING unmatched class labels", key, unknown)
    tot = sum(s["roster"] for s in sems)
    out["response"] = {"sems": sems, "classes": classes, "roster": tot, "rate": round(100 * n / tot, 1) if tot else None}
    for c in classes:
        if c["n"] > c["roster"]:
            print("WARNING respondents exceed roster", c)

    out["ops"] = [{"label": l, **lk_stats(col(rows, c))} for l, c, _ in OPS]
    out["ben"] = [{"label": l, **lk_stats(col(rows, c))} for l, c, _ in BEN]
    allops = [likert(r[c]) for r in rows for _, c, _ in OPS]
    allops = [x for x in allops if x]
    out["ops_mean"] = round(sum(allops) / len(allops), 2) if allops else None
    out["ops_cat"] = category(out["ops_mean"])

    # understanding and experience
    out["k1"] = dist_of(col(rows, 241), ["2 Kurang paham", "3 Cukup paham", "4 Paham", "5 Sangat paham"])
    k1 = [likert(v) for v in col(rows, 241)]
    k1 = [x for x in k1 if x]
    out["k1_mean"] = round(sum(k1) / len(k1), 2) if k1 else None
    ok = sum(1 for v in col(rows, 242) if v and str(v).startswith("Pembelajaran yang berangkat dari masalah nyata"))
    out["k2_correct"] = round(100 * ok / n, 1)
    out["k3"] = dist_of(col(rows, 243), ["Belum pernah", "1 semester", "2 semester", "3 semester atau lebih"])

    # split by prior PBL experience
    groups = {"Belum pernah": [], "Pernah": []}
    for r in rows:
        (groups["Belum pernah"] if str(r[243]).startswith("Belum pernah") else groups["Pernah"]).append(r)
    out["by_experience"] = []
    for g, rr in groups.items():
        if len(rr) < MIN_GROUP:
            continue
        sat = lk_stats(col(rr, 263))
        cont = lk_stats(col(rr, 264))
        ops = [likert(r[c]) for r in rr for _, c, _ in OPS]
        ops = [x for x in ops if x]
        berat = sum(1 for v in col(rr, 267) if v and str(v)[0] in "45")
        out["by_experience"].append({"group": g, "n": len(rr), "ops_mean": round(sum(ops) / len(ops), 2), "sat_mean": sat["mean"], "sat_agree": sat["pct_agree"],
                                      "cont_mean": cont["mean"], "cont_agree": cont["pct_agree"], "berat_pct": round(100 * berat / len(rr), 1)})

    # consultation
    out["consult_freq"] = dist_of([fix_zero(v) for v in col(rows, 244)], ["0 kali", "1-2 kali", "3-5 kali", "Lebih dari 5 kali"])
    out["consult_resp"] = dist_of(col(rows, 245))
    out["consult_init"] = dist_of(col(rows, 246))

    # coordination (student view)
    out["coord"] = []
    for l, c, kind in STU_COORD:
        out["coord"].append({"label": l, "kind": kind, **(yn_dist(col(rows, c)) if kind == "yn" else {"pct_oa": pct_oftenalways(col(rows, c)), "n": len(col(rows, c))})})

    # best / improve / workload / material
    best = stu_multi(rows, 265)
    imp = stu_multi(rows, 266)
    mat = stu_multi(rows, 268)
    out["best"] = freq(best, n)
    out["improve"] = freq(imp, n)
    out["material"] = freq(mat, n)
    out["workload"] = dist_of(col(rows, 267), ["2 Ringan", "3 Sesuai", "4 Berat", "5 Sangat berat"])
    out["workload_heavy_pct"] = round(100 * sum(1 for v in col(rows, 267) if v and str(v)[0] in "45") / n, 1)

    # per course
    courses = []
    for key, b in BLOCKS.items():
        if prodi and b["prodi"] != prodi:
            continue
        rr = [r for r in rows if r[2] == key]
        for ci, cname in enumerate(b["courses"]):
            base = b["c0"] + 14 * ci
            acts = [pct_oftenalways(col(rr, base + k)) for k in range(5)]
            bc = [yn_dist(col(rr, base + 5 + k)) for k in range(9)]
            att = dist_of(col(rr, b["att"] + ci))
            attn = att["n"]
            all_att = next((i["pct"] for i in att["items"] if i["label"].startswith("Hadir di semua")), 0)
            expl = dist_of(col(rr, b["expl"] + ci))
            expl_ya = next((i["pct"] for i in expl["items"] if i["label"] == "Ya"), 0)
            typ = dist_of(col(rr, b["typ"] + ci))
            share = dist_of(col(rr, b["share"] + ci))
            share_ns = next((i["pct"] for i in share["items"] if i["label"].startswith("Tidak disampaikan")), 0)
            share_hi = next((i["pct"] for i in share["items"] if i["label"].startswith("> 50")), 0)
            courses.append({
                "prodi": b["prodi"], "sem": b["sem"], "course": cname, "n": len(rr),
                "acts": acts, "acts_mean": round(sum(a for a in acts if a is not None) / len(acts), 1),
                "bc_ya": [x["ya"] for x in bc], "bc_ya_mean": round(sum(x["ya"] for x in bc if x["ya"] is not None) / len(bc), 1),
                "bc_tidak_mean": round(sum(x["tidak"] for x in bc if x["tidak"] is not None) / len(bc), 1),
                "att_all": all_att, "att_n": attn, "expl_ya": expl_ya,
                "type": typ["items"], "share_not_stated": share_ns, "share_over50": share_hi,
            })
    out["courses"] = courses
    out["act_labels"] = ACT_LABELS
    out["bc_labels"] = BC_LABELS
    return out


def lecturer_scope(rows):
    n = len(rows)
    out: dict = {"n": n}
    out["ops"] = [{"label": l, **lk_stats(col(rows, c))} for l, _, c in OPS]
    out["ben"] = [{"label": l, **lk_stats(col(rows, c))} for l, _, c in BEN]
    # extra lecturer-only operational items
    out["ops_extra"] = [{"label": l, **lk_stats(col(rows, c))} for l, c in [("Komunikasi antar dosen aktif", 54), ("Grup WhatsApp dosen efektif", 55), ("Informasi koordinator jelas dan tepat waktu", 56)]]
    allops = [likert(r[c]) for r in rows for _, _, c in OPS]
    allops = [x for x in allops if x]
    out["ops_mean"] = round(sum(allops) / len(allops), 2) if allops else None
    out["ops_cat"] = category(out["ops_mean"])
    out["experience"] = dist_of(col(rows, 3))
    out["k1"] = dist_of(col(rows, 4), ["2 Kurang paham", "3 Cukup paham", "4 Paham", "5 Sangat paham"])
    ok = sum(1 for v in col(rows, 5) if v and str(v).startswith("Membantu tim mengidentifikasi"))
    out["k2_correct"] = round(100 * ok / n, 1)
    out["understand"] = [{"label": l, **lk_stats(col(rows, c))} for l, c in [("Alur dan target milestone", 6), ("SOP dan template laporan", 7), ("Rubrik penilaian dan penerapannya", 8), ("Kontribusi mata kuliah terhadap proyek", 9)]]
    out["activities"] = [{"label": l, "pct_oa": pct_oftenalways(col(rows, 11 + k))} for k, l in enumerate(ACT_LABELS)]
    out["attendance"] = dist_of(col(rows, 16))
    out["consult_freq"] = dist_of([fix_zero(v) for v in col(rows, 17)], ["0 kali", "1-2 kali", "3-5 kali", "Lebih dari 5 kali"])
    out["align"] = [{"label": l, **yn_dist(col(rows, c))} for l, c in LEC_ALIGN]
    out["explain_start"] = yn_dist(col(rows, 28))
    out["share"] = dist_of(col(rows, 30))
    out["coord_freq"] = dist_of(col(rows, 32), ["Tidak pernah", "1-2 kali", "3-5 kali", "Lebih dari 5 kali"])
    out["wa"] = dist_of(col(rows, 33))
    out["meeting"] = dist_of(col(rows, 34), ["Selalu hadir", "Hadir sebagian", "Tidak pernah hadir"])
    out["coord_yn"] = [{"label": l, **yn_dist(col(rows, c))} for l, c in LEC_COORD_YN]
    out["coord_lk"] = [{"label": l, "pct_oa": pct_oftenalways(col(rows, c)),
                        "pct_never": round(100 * sum(1 for v in col(rows, c) if likert(v) in (1, 2)) / n, 1)} for l, c in LEC_COORD_LK]
    out["barriers"] = freq(lec_multi(rows, 45), n)
    out["material_barriers"] = freq(lec_multi(rows, 31), n)
    out["best"] = freq(lec_multi(rows, 62), n)
    out["improve"] = freq(lec_multi(rows, 63), n)
    out["support"] = freq(lec_multi(rows, 65), n)
    out["workload"] = dist_of(col(rows, 64), ["2 Ringan", "3 Sesuai", "4 Berat", "5 Sangat berat"])
    out["workload_heavy_pct"] = round(100 * sum(1 for v in col(rows, 64) if v and str(v)[0] in "45") / n, 1)
    return out


def gap_table(stu, lec):
    out = []
    for key in ("ops", "ben"):
        for s, l in zip(stu[key], lec[key]):
            out.append({"group": key, "label": s["label"], "mhs_mean": s["mean"], "dosen_mean": l["mean"],
                        "mhs_agree": s["pct_agree"], "dosen_agree": l["pct_agree"],
                        "gap": round(l["mean"] - s["mean"], 2) if s["mean"] is not None and l["mean"] is not None else None})
    return out


# --------------------------------------------------------------------------- extra analysis (report v2)

COORDINATOR = "dian hanifudin"  # the PBL coordinator; used only to find the classes he teaches and monitored


def load_monitored_classes():
    """Class labels the coordinator teaches in PBL semesters 3 and 5 (he reminded students there)."""
    ws = openpyxl.load_workbook(os.path.join(ROOT, "docs", "Plotting Dosen Gasal 2026-2027.xlsx"), read_only=True, data_only=True)["Ploting"]
    out = set()
    for r in list(ws.iter_rows(values_only=True))[1:]:
        if r[7] and COORDINATOR in str(r[7]).lower() and r[0] in ("TI", "SIB") and r[1] and int(r[1]) in (3, 5):
            out.add(str(r[3]).replace("_", "-").upper())
    return out


def row_class(r):
    b = BLOCKS.get(r[2])
    if b and b["cls"] < len(r) and r[b["cls"]]:
        return norm_class(r[b["cls"]])
    return None


def mean_of(vals):
    v = [x for x in vals if x is not None]
    return round(sum(v) / len(v), 2) if v else None


def group_stats(rows):
    n = len(rows)
    ops = [likert(r[c]) for r in rows for _, c, _ in OPS]
    imp = collections.Counter(x for r in rows for x in set(stu_multi([r], 266)) if x != "Lainnya")
    return {
        "n": n, "ops_mean": mean_of(ops), "puas": mean_of([likert(r[263]) for r in rows]), "lanjut": mean_of([likert(r[264]) for r in rows]),
        "adil": mean_of([likert(r[258]) for r in rows]), "fasilitas": mean_of([likert(r[259]) for r in rows]),
        "berat": round(100 * sum(1 for r in rows if r[267] and str(r[267])[0] in "45") / n, 1),
        "konsisten": yn_dist(col(rows, 248))["ya"],
        "top": [{"label": k, "pct": round(100 * v / n, 1)} for k, v in imp.most_common(3)],
    }


def monitored_split(rows, rosters, mon, prodi):
    inscope = {k: v for k, v in rosters.items() if prodi is None or k.startswith(prodi + "-")}
    enf_cls = sorted(k for k in inscope if k in mon)
    enf = [r for r in rows if row_class(r) in mon]
    oth = [r for r in rows if row_class(r) not in mon]
    out = {"classes": enf_cls}
    for key, rr, roster in (("enf", enf, sum(inscope[k] for k in enf_cls)), ("oth", oth, sum(v for k, v in inscope.items() if k not in mon))):
        g = {"n": len(rr), "roster": roster, "rate": round(100 * len(rr) / roster, 1) if roster else None,
             "n_classes": len(enf_cls) if key == "enf" else len(inscope) - len(enf_cls)}
        if len(rr) >= MIN_GROUP:
            g["stats"] = group_stats(rr)
        out[key] = g
    out["share_enf"] = round(100 * len(enf) / len(rows), 1) if rows else None
    return out


ASPEK = [
    ("A", "Pelaksanaan PBL", [0, 1, 2, 3], ["Kendala teknis (teknologi, kode, bug)", "Mitra atau calon pengguna"]),
    ("B", "Integrasi antar-mata kuliah", [4], ["Keselarasan tugas antar-mata kuliah", "Pemahaman materi", "Arahan dan tugas antar dosen tidak terkoordinasi", "Tidak jelas dosen yang menjadi rujukan tim"]),
    ("C", "Penilaian dan umpan balik", [5, 6], ["Kejelasan ketentuan (SOP dan rubrik)", "Bimbingan atau umpan balik dosen"]),
    ("D", "Kolaborasi, beban, dan dukungan", [7], ["Waktu dan beban kerja", "Koordinasi tim", "Kontribusi anggota tim tidak seimbang", "Fasilitas dan sumber daya (server, data, perangkat)", "Penggunaan AI"]),
]


def aspek_stats(rows, lrows):
    out = []
    sets = [set(stu_multi([r], 266)) for r in rows]
    for code, name, idx, probs in ASPEK:
        sm = mean_of([likert(r[OPS[i][1]]) for r in rows for i in idx])
        lm = mean_of([likert(r[OPS[i][2]]) for r in lrows for i in idx])
        union = sum(1 for s in sets if s & set(probs))
        each = sorted(({"label": p, "pct": round(100 * sum(1 for s in sets if p in s) / len(rows), 1)} for p in probs), key=lambda x: -x["pct"])
        out.append({"code": code, "name": name, "items": [OPS[i][0] for i in idx], "mhs_mean": sm, "mhs_cat": category(sm), "dosen_mean": lm,
                    "dosen_cat": category(lm), "problem_pct": round(100 * union / len(rows), 1), "problems": each})
    return out


DUA_SISI = [  # (aspect, good option, problem option)
    ("SOP dan template", "SOP dan template laporan membantu", "Kejelasan ketentuan (SOP dan rubrik)"),
    ("Rubrik dan penilaian", "Rubrik dan penilaian jelas dan adil", "Kejelasan ketentuan (SOP dan rubrik)"),
    ("Bimbingan dosen", "Bimbingan dosen", "Bimbingan atau umpan balik dosen"),
    ("Umpan balik dosen", "Umpan balik dosen", "Bimbingan atau umpan balik dosen"),
    ("Materi dan tugas", "Materi kelas mendukung proyek", "Keselarasan tugas antar-mata kuliah"),
    ("Kerja sama tim", "Kerja sama tim", "Kontribusi anggota tim tidak seimbang"),
    ("Fasilitas", "Fasilitas dan sumber daya", "Fasilitas dan sumber daya (server, data, perangkat)"),
    ("Mitra atau calon pengguna", "Keterlibatan mitra atau calon pengguna", "Mitra atau calon pengguna"),
]


def dua_sisi(m):
    best = {i["label"]: i["pct"] for i in m["best"]}
    imp = {i["label"]: i["pct"] for i in m["improve"]}
    out = []
    for name, g, p in DUA_SISI:
        gb, pb = best.get(g, 0.0), imp.get(p, 0.0)
        out.append({"aspek": name, "baik": gb, "masalah": pb, "dua_sisi": gb >= 15 and pb >= 15})
    return out


def pearson(xs, ys):
    pairs = [(x, y) for x, y in zip(xs, ys) if x is not None and y is not None]
    if len(pairs) < 30:
        return None
    mx = sum(p[0] for p in pairs) / len(pairs)
    my = sum(p[1] for p in pairs) / len(pairs)
    sxy = sum((x - mx) * (y - my) for x, y in pairs)
    sxx = sum((x - mx) ** 2 for x, _ in pairs)
    syy = sum((y - my) ** 2 for _, y in pairs)
    return round(sxy / (sxx * syy) ** 0.5, 2) if sxx and syy else None


def drivers(rows):
    puas = [likert(r[263]) for r in rows]
    lanjut = [likert(r[264]) for r in rows]
    corr = []
    for lab, c, _ in OPS:
        xs = [likert(r[c]) for r in rows]
        corr.append({"label": lab, "r_puas": pearson(xs, puas), "r_lanjut": pearson(xs, lanjut)})
    corr.sort(key=lambda x: -(x["r_puas"] if x["r_puas"] is not None else -9))

    def grouped(name, fn):
        groups = collections.OrderedDict()
        for r in rows:
            g = fn(r)
            if g:
                groups.setdefault(g, []).append(r)
        gl = [{"label": g, "n": len(rr), "puas": mean_of([likert(r[263]) for r in rr]), "lanjut": mean_of([likert(r[264]) for r in rr])}
              for g, rr in groups.items() if len(rr) >= MIN_GROUP]
        return {"factor": name, "groups": gl}

    def yn(c):
        return lambda r: None if not r[c] else ("Ya" if idn(r[c]) == "Ya" else "Sebagian atau tidak")

    ct = [
        grouped("Beban PBL dibanding waktu tersedia", lambda r: None if not r[267] else ("Ringan atau sesuai" if str(r[267])[0] in "123" else "Berat atau sangat berat")),
        grouped("Konsultasi dengan dosen di luar jam kuliah", lambda r: None if r[244] is None else ("Belum pernah" if str(fix_zero(r[244])).startswith("0") else "Pernah")),
        grouped("Arahan dosen antar mata kuliah konsisten", yn(248)),
        grouped("Tim tahu harus menghubungi dosen siapa", yn(249)),
        grouped("Dosen antar mata kuliah mengetahui progres proyek", yn(247)),
    ]
    return {"corr": corr, "cross": [c for c in ct if len(c["groups"]) >= 2]}


def sem_stats(rows):
    out = []
    for key in BLOCKS:
        rr = [r for r in rows if r[2] == key]
        if len(rr) >= MIN_GROUP:
            out.append({"label": key, **group_stats(rr)})
    return out


def pooled_courses(rows):
    """Pool the per-course answers over all respondents and courses of the scope."""
    items = [collections.Counter() for _ in range(9)]
    acts = [[] for _ in range(5)]
    typ, share = collections.Counter(), collections.Counter()
    n_ct = 0
    for key, b in BLOCKS.items():
        for r in (x for x in rows if x[2] == key):
            for ci in range(len(b["courses"])):
                base = b["c0"] + 14 * ci
                for k in range(5):
                    acts[k].append(r[base + k])
                for k in range(9):
                    if r[base + 5 + k]:
                        items[k][idn(r[base + 5 + k])] += 1
                if r[b["typ"] + ci]:
                    typ[idn(r[b["typ"] + ci])] += 1
                if r[b["share"] + ci]:
                    share[idn(r[b["share"] + ci])] += 1
                n_ct += 1
    bc = []
    for k, lab in enumerate(BC_LABELS):
        c = items[k]
        tot = sum(c.values()) or 1
        bc.append({"label": lab, "ya": round(100 * c["Ya"] / tot, 1), "sebagian": round(100 * c["Sebagian"] / tot, 1), "tidak": round(100 * c["Tidak"] / tot, 1)})
    pt, ps = sum(typ.values()) or 1, sum(share.values()) or 1
    return {"bc": bc, "acts": [{"label": ACT_LABELS[k], "pct_oa": pct_oftenalways(acts[k])} for k in range(5)],
            "type": [{"label": k, "pct": round(100 * v / pt, 1)} for k, v in typ.most_common()],
            "share": [{"label": k, "pct": round(100 * v / ps, 1)} for k, v in share.most_common()], "n": n_ct}


def lec_extra(lrows):
    n = len(lrows)
    out = {"consult_resp": dist_of(col(lrows, 18)), "consult_init": dist_of(col(lrows, 19)),
           "types": freq([x for r in lrows for x in split_multi(r[29])], n),
           "sosialisasi": freq([x for r in lrows for x in split_multi(r[10])], n)}
    groups = {"Pertama kali mengampu PBL": [], "Sudah pernah mengampu PBL": []}
    for r in lrows:
        groups["Pertama kali mengampu PBL" if str(r[3]).startswith("Pertama") else "Sudah pernah mengampu PBL"].append(r)
    exp = []
    for g, rr in groups.items():
        if len(rr) >= MIN_GROUP:
            ok = sum(1 for r in rr if r[5] and str(r[5]).startswith("Membantu tim mengidentifikasi"))
            exp.append({"group": g, "n": len(rr), "k1": mean_of([likert(r[4]) for r in rr]), "k2_correct": round(100 * ok / len(rr), 1),
                        "ops_mean": mean_of([likert(r[c]) for r in rr for _, _, c in OPS]), "puas": mean_of([likert(r[60]) for r in rr])})
    out["by_experience"] = exp
    return out


# --------------------------------------------------------------------------- lecturer roster

PBL_COURSES = {
    ("TI", 3): ["Manajemen Proyek", "Desain & Pemrograman Web", "Basis Data Lanjut", "Sistem Informasi Manajemen"],
    ("TI", 5): ["Pemrograman Mobile", "Pembelajaran Mesin", "Penjaminan Mutu Perangkat Lunak"],
    ("SIB", 3): ["Pemrograman Web", "Basis Data Lanjut", "Desain UI/UX"],
    ("SIB", 5): ["Pemrograman Web Lanjut", "Manajemen Proyek Sistem Informasi", "Penjaminan Mutu"],
}


def load_dosen_roster():
    """Distinct lecturers teaching the 13 PBL courses (counts only; names are not kept)."""
    ws = openpyxl.load_workbook(os.path.join(ROOT, "docs", "Plotting Dosen Gasal 2026-2027.xlsx"), read_only=True, data_only=True)["Ploting"]
    sets = {"TI": set(), "SIB": set()}
    for r in list(ws.iter_rows(values_only=True))[1:]:
        if r[0] in sets and r[1] and r[7] and (r[0], int(r[1])) in PBL_COURSES and r[2] in PBL_COURSES[(r[0], int(r[1]))]:
            sets[r[0]].add(str(r[7]).strip())
    return {"all": len(sets["TI"] | sets["SIB"]), "ti": len(sets["TI"]), "sib": len(sets["SIB"]), "both": len(sets["TI"] & sets["SIB"])}


# --------------------------------------------------------------------------- main


def main():
    rosters = load_rosters()
    MON = load_monitored_classes()
    print("Monitored classes:", sorted(MON))
    print("Roster classes:", len(rosters), "students:", sum(rosters.values()))
    _, srows = load_sheet(glob.glob(os.path.join(RAW, "*Mahasiswa*.xlsx"))[0])
    _, lrows = load_sheet(glob.glob(os.path.join(RAW, "*Dosen*.xlsx"))[0])
    srows = [r for r in srows if r and r[0]]
    lrows = [r for r in lrows if r and r[0]]
    print("Students:", len(srows), "Lecturers:", len(lrows))

    def lec_prodi(p):
        return [r for r in lrows if p in [x.split()[0] for x in str(r[2]).split(", ")]]

    for r in lrows:
        for c in (31, 45, 62, 63, 65):
            for x in split_multi(r[c]):
                LEC_COUNTS[(c, x)] = LEC_COUNTS.get((c, x), 0) + 1

    result = {"meta": {"mahasiswa_n": len(srows), "dosen_n": len(lrows), "roster_n": sum(rosters.values()), "min_group": MIN_GROUP}}
    scopes = {"all": (srows, lrows, None),
              "ti": ([r for r in srows if str(r[2]).startswith("TI")], lec_prodi("TI"), "TI"),
              "sib": ([r for r in srows if str(r[2]).startswith("SIB")], lec_prodi("SIB"), "SIB")}
    for name, (s, l, p) in scopes.items():
        stu, lec = student_scope(s, rosters, p), lecturer_scope(l)
        stu["monitored"] = monitored_split(s, rosters, MON, p)
        stu["aspek"] = aspek_stats(s, l)
        stu["dua_sisi"] = dua_sisi(stu)
        stu["drivers"] = drivers(s)
        stu["sem_stats"] = sem_stats(s)
        stu["pooled"] = pooled_courses(s)
        lec.update(lec_extra(l))
        result[name] = {"mhs": stu, "dosen": lec, "gap": gap_table(stu, lec)}
    result["meta"]["dosen_ti"] = len(scopes["ti"][1])
    result["meta"]["dosen_sib"] = len(scopes["sib"][1])
    result["meta"]["dosen_both"] = len(scopes["ti"][1]) + len(scopes["sib"][1]) - len(lrows)
    dr = load_dosen_roster()
    result["meta"]["dosen_roster"] = dr
    for key in ("all", "ti", "sib"):
        n_l = result[key]["dosen"]["n"]
        result[key]["dosen"]["roster"] = dr[key]
        result[key]["dosen"]["rate"] = round(100 * n_l / dr[key], 1)
        print(f"Lecturer response {key}: {n_l}/{dr[key]} = {result[key]['dosen']['rate']}%")
    result["meta"]["dosen_sem"] = dist_of([", ".join(sorted(str(r[2]).split(", "))) for r in lrows])["items"]

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=1)
    print("Wrote", OUT)

    # console sanity summary
    for name in ("all", "ti", "sib"):
        m = result[name]["mhs"]
        d = result[name]["dosen"]
        print(f"\n== {name}: mhs n={m['n']} rate={m['response']['rate']}% (roster {m['response']['roster']}) | dosen n={d['n']}")
        print("  ops_mean mhs", m["ops_mean"], m["ops_cat"], "| dosen", d["ops_mean"], d["ops_cat"])
        print("  puas mhs", m["ben"][3]["mean"], "dosen", d["ben"][3]["mean"], "| lanjut mhs", m["ben"][4]["mean"], "dosen", d["ben"][4]["mean"])
        print("  top improve:", [(i["label"], i["count"]) for i in m["improve"][:4]])
        print("  sems:", [(s["label"], s["n"], s["roster"], s["rate"]) for s in m["response"]["sems"]])


if __name__ == "__main__":
    main()
