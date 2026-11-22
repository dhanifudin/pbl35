"""Analisis mendalam tujuh masalah PBL dari data survei monev.

Jalankan dari akar repo (sama seperti analyze_monev.py):
    uv run --with openpyxl python -I monev/analisis/analisis_masalah.py

Membaca data mentah dari docs/monev/ di tempat (tidak disalin), memakai pemetaan kolom dan
fungsi bantu dari monev/laporan/analyze_monev.py, dan HANYA menulis agregat ke
monev/analisis/data/analisis.json. Tidak ada baris responden, email, atau komentar yang
dicetak atau disimpan. Kelompok di bawah MIN_GROUP (5) disembunyikan.

Urutan kerja: (1) cocokkan angka yang sudah ada di agregat.json, (2) hitung analisis baru
dengan selang ketidakpastian, (3) uji sensitivitas, (4) tulis JSON.
"""
import collections
import datetime
import glob
import importlib.util
import json
import math
import os
import random
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", ".."))
OUT = os.environ.get("ANALISIS_OUT") or os.path.join(HERE, "data", "analisis.json")
AGG = os.path.join(ROOT, "monev", "laporan", "data", "agregat.json")

# memuat analyze_monev.py lewat path (mode -I menyembunyikan folder skrip dari sys.path)
_spec = importlib.util.spec_from_file_location("analyze_monev", os.path.join(ROOT, "monev", "laporan", "analyze_monev.py"))
am = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(am)
MIN = am.MIN_GROUP
SEED = int(os.environ.get("ANALISIS_SEED", "20261111"))
B_MEAN = 2000   # resample bootstrap untuk rata-rata dan selisih
B_MODEL = 600   # resample bootstrap untuk model regresi (lebih mahal)

# PIC kelas = pengampu mata kuliah inti (keputusan koordinator PBL, lihat Sosialisasi-PBL-TI-SIB.md)
PIC = {("TI", 3): "Manajemen Proyek", ("TI", 5): "Pembelajaran Mesin", ("SIB", 3): "Pemrograman Web", ("SIB", 5): "Pemrograman Web Lanjut"}

# ----------------------------------------------------------------------------- statistik dasar


def mean(xs):
    v = [x for x in xs if x is not None]
    return sum(v) / len(v) if v else None


def r1(x, d=1):
    return None if x is None else round(x, d)


def wilson(k, n, z=1.96):
    if not n:
        return None
    p = k / n
    den = 1 + z * z / n
    c = (p + z * z / (2 * n)) / den
    h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n)) / den
    return [round(100 * (c - h), 1), round(100 * (c + h), 1)]


def prop(flags):
    """flags: 0/1/None. Persentase dengan selang Wilson; disembunyikan bila n < MIN."""
    v = [f for f in flags if f is not None]
    n, k = len(v), sum(v)
    if n < MIN:
        return {"n": n, "disembunyikan": True}
    return {"n": n, "k": k, "pct": round(100 * k / n, 1), "ci": wilson(k, n)}


def boot_ci(items, stat, B=B_MEAN, seed=SEED):
    rng = random.Random(seed)
    n = len(items)
    vals = []
    for _ in range(B):
        s = [items[rng.randrange(n)] for _ in range(n)]
        v = stat(s)
        if v is not None:
            vals.append(v)
    if len(vals) < 0.9 * B:
        return None
    vals.sort()
    return [round(vals[int(0.025 * len(vals))], 3), round(vals[min(len(vals) - 1, int(0.975 * len(vals)))], 3)]


def pearson(xs, ys):
    pairs = [(x, y) for x, y in zip(xs, ys) if x is not None and y is not None]
    if len(pairs) < 30:
        return None
    mx = sum(p[0] for p in pairs) / len(pairs)
    my = sum(p[1] for p in pairs) / len(pairs)
    sxy = sum((x - mx) * (y - my) for x, y in pairs)
    sxx = sum((x - mx) ** 2 for x, _ in pairs)
    syy = sum((y - my) ** 2 for _, y in pairs)
    return sxy / math.sqrt(sxx * syy) if sxx and syy else None


def corr_with_ci(items, fx, fy):
    xs, ys = [fx(d) for d in items], [fy(d) for d in items]
    r = pearson(xs, ys)
    if r is None:
        return None
    return {"r": round(r, 2), "ci": boot_ci(items, lambda s: pearson([fx(d) for d in s], [fy(d) for d in s]), B=800),
            "n": sum(1 for x, y in zip(xs, ys) if x is not None and y is not None)}


def diff_means(items, flag, val, B=B_MEAN):
    """Rata-rata val pada kelompok flag=1 dikurangi flag=0, dengan selang bootstrap."""
    def stat(s):
        a = [val(d) for d in s if flag(d) == 1 and val(d) is not None]
        b = [val(d) for d in s if flag(d) == 0 and val(d) is not None]
        return mean(a) - mean(b) if len(a) >= 2 and len(b) >= 2 else None
    a = [val(d) for d in items if flag(d) == 1 and val(d) is not None]
    b = [val(d) for d in items if flag(d) == 0 and val(d) is not None]
    if len(a) < MIN or len(b) < MIN:
        return {"n_ya": len(a), "n_tidak": len(b), "disembunyikan": True}
    return {"n_ya": len(a), "n_tidak": len(b), "mean_ya": round(mean(a), 2), "mean_tidak": round(mean(b), 2),
            "selisih": round(mean(a) - mean(b), 2), "ci": boot_ci(items, stat, B=B)}


def solve(A, c):
    k = len(c)
    M = [row[:] + [c[i]] for i, row in enumerate(A)]
    for i in range(k):
        p = max(range(i, k), key=lambda r: abs(M[r][i]))
        M[i], M[p] = M[p], M[i]
        piv = M[i][i]
        if abs(piv) < 1e-12:
            return None
        M[i] = [v / piv for v in M[i]]
        for r in range(k):
            if r != i:
                f = M[r][i]
                M[r] = [a - f * b for a, b in zip(M[r], M[i])]
    return [M[i][k] for i in range(k)]


def ols(X, y):
    """OLS dengan intersep. Mengembalikan koefisien baku (beta), koefisien mentah (b), R2."""
    n, k = len(X), len(X[0])
    mx = [sum(r[j] for r in X) / n for j in range(k)]
    sx = [math.sqrt(sum((r[j] - mx[j]) ** 2 for r in X) / (n - 1)) or 1.0 for j in range(k)]
    my = sum(y) / n
    sy = math.sqrt(sum((v - my) ** 2 for v in y) / (n - 1)) or 1.0
    Z = [[(r[j] - mx[j]) / sx[j] for j in range(k)] for r in X]
    t = [(v - my) / sy for v in y]
    A = [[sum(Z[i][a] * Z[i][b] for i in range(n)) for b in range(k)] for a in range(k)]
    c = [sum(Z[i][a] * t[i] for i in range(n)) for a in range(k)]
    for a in range(k):
        A[a][a] += 1e-8
    beta = solve(A, c)
    if beta is None:
        return None
    res = sum((t[i] - sum(beta[j] * Z[i][j] for j in range(k))) ** 2 for i in range(n))
    return {"beta": beta, "b": [beta[j] * sy / sx[j] for j in range(k)], "r2": 1 - res / sum(v * v for v in t), "n": n}


def model(items, preds, outcome, B=B_MODEL, seed=SEED):
    """preds: {nama: fungsi}. Penghapusan listwise. Mengembalikan beta/b dengan selang bootstrap."""
    names = list(preds)
    rows = []
    for d in items:
        xs = [preds[nm](d) for nm in names]
        y = outcome(d)
        if y is not None and all(x is not None for x in xs):
            rows.append((xs, y))
    if len(rows) < 40:
        return {"n": len(rows), "disembunyikan": True}
    fit = ols([r[0] for r in rows], [r[1] for r in rows])
    if fit is None:
        return {"n": len(rows), "gagal": True}
    rng = random.Random(seed)
    bs = [[] for _ in names]
    bb = [[] for _ in names]
    for _ in range(B):
        s = [rows[rng.randrange(len(rows))] for _ in rows]
        f = ols([r[0] for r in s], [r[1] for r in s])
        if f:
            for j in range(len(names)):
                bs[j].append(f["beta"][j])
                bb[j].append(f["b"][j])

    def ci(v):
        v.sort()
        return [round(v[int(0.025 * len(v))], 2), round(v[min(len(v) - 1, int(0.975 * len(v)))], 2)] if len(v) > 50 else None
    return {"n": fit["n"], "r2": round(fit["r2"], 2),
            "koef": [{"nama": nm, "beta": round(fit["beta"][j], 2), "beta_ci": ci(bs[j]), "b": round(fit["b"][j], 2), "b_ci": ci(bb[j])}
                     for j, nm in enumerate(names)]}


# ----------------------------------------------------------------------------- data responden (tanpa identitas)


def yn1(v):
    return None if not v else (1 if am.idn(v) == "Ya" else 0)


def derive(r, MON):
    key = r[2]
    b = am.BLOCKS[key]
    cls = am.row_class(r)
    d = {
        "prodi": b["prodi"], "sem": b["sem"], "seg": f"{b['prodi']} Sem {b['sem']}", "cls": cls, "mon": 1 if cls in MON else 0,
        "puas": am.likert(r[263]), "lanjut": am.likert(r[264]),
        "ops": [am.likert(r[c]) for _, c, _ in am.OPS],
        "berat": None if not r[267] else (1 if str(r[267])[0] in "45" else 0),
        "tahu_progres": yn1(r[247]), "konsisten": yn1(r[248]), "tahu_hubungi": yn1(r[249]),
        "tenggat": am.likert(r[250]), "kendala_review": am.likert(r[251]),
        "konsul0": None if r[244] is None else (1 if str(am.fix_zero(r[244])).startswith("0") else 0),
        "konsul_resp": am.idn(r[245]) if r[245] else None, "konsul_init": am.idn(r[246]) if r[246] else None,
        "imp": set(am.stu_multi([r], 266)), "mat": set(am.stu_multi([r], 268)), "best": set(am.stu_multi([r], 265)),
        "pernah_pbl": 0 if str(r[243]).startswith("Belum pernah") else 1,
        "courses": [],
    }
    for ci, cname in enumerate(b["courses"]):
        base = b["c0"] + 14 * ci
        d["courses"].append({
            "course": cname, "pic": 1 if PIC.get((b["prodi"], b["sem"])) == cname else 0,
            "acts": [am.likert(r[base + k]) for k in range(5)],
            "bc": [am.idn(r[base + 5 + k]) if r[base + 5 + k] else None for k in range(9)],
            "typ": am.idn(r[b["typ"] + ci]) if r[b["typ"] + ci] else None,
            "share": am.idn(r[b["share"] + ci]) if r[b["share"] + ci] else None,
        })
    return d


def agree(x):
    return None if x is None else (1 if x >= 4 else 0)


def low(x):
    return None if x is None else (1 if x <= 3 else 0)


def share_ya(d, idx):
    v = [1 if c["bc"][idx] == "Ya" else 0 for c in d["courses"] if c["bc"][idx]]
    return mean(v)


def share_latihan(d):
    v = [1 if c["typ"].startswith("Latihan") else 0 for c in d["courses"] if c["typ"]]
    return mean(v)


def share_type(d, pred):
    """Porsi mata kuliah responden yang jenis tugas utamanya memenuhi pred (mis. deliverable proyek)."""
    v = [1 if pred(c["typ"]) else 0 for c in d["courses"] if c["typ"]]
    return mean(v)


# ----------------------------------------------------------------------------- tabel segmen


def by_group(items, keyfn, indicator, min_n=MIN):
    groups = collections.OrderedDict()
    for d in items:
        g = keyfn(d)
        if g:
            groups.setdefault(g, []).append(d)
    out = []
    for g, rr in sorted(groups.items()):
        if len(rr) >= min_n:
            out.append({"kelompok": g, **indicator(rr)})
    return out


def ind_prop(fn):
    return lambda rr: prop([fn(d) for d in rr])


def ind_mean(fn):
    def f(rr):
        v = [fn(d) for d in rr if fn(d) is not None]
        return {"n": len(v), "mean": r1(mean(v), 2), "ci": boot_ci(v, lambda s: mean(s), B=800) if len(v) >= MIN else None}
    return f


# ----------------------------------------------------------------------------- pasca-stratifikasi


def make_cells(rosters):
    cells = {}
    for (p, s) in PIC:
        pref = f"{p}-{2 if s == 3 else 3}"
        cells[(p, s)] = sum(v for k, v in rosters.items() if k.startswith(pref))
    return cells


def poststrat(items, val, cells):
    """Estimasi rata-rata yang dibobot ke ukuran populasi per (prodi, semester)."""
    by = collections.defaultdict(list)
    for d in items:
        v = val(d)
        if v is not None:
            by[(d["prodi"], d["sem"])].append(v)
    num = sum(cells[c] * mean(v) for c, v in by.items() if v)
    den = sum(cells[c] for c, v in by.items() if v)
    return num / den if den else None


def poststrat_ci(items, val, cells, B=B_MEAN, seed=SEED):
    rng = random.Random(seed)
    by = collections.defaultdict(list)
    for d in items:
        by[(d["prodi"], d["sem"])].append(d)
    vals = []
    for _ in range(B):
        s = []
        for g, rr in by.items():
            s += [rr[rng.randrange(len(rr))] for _ in rr]
        v = poststrat(s, val, cells)
        if v is not None:
            vals.append(v)
    vals.sort()
    return [round(vals[int(0.025 * len(vals))], 3), round(vals[int(0.975 * len(vals))], 3)] if vals else None


# ----------------------------------------------------------------------------- pemeriksaan terhadap agregat.json


def reproduce(S, rosters, MON):
    agg = json.load(open(AGG, encoding="utf-8"))["all"]["mhs"]
    results = []

    def chk(name, got, exp, tol):
        ok = got is not None and exp is not None and abs(got - exp) <= tol
        results.append({"cek": name, "hasil": r1(got, 3), "agregat": exp, "ok": bool(ok)})

    chk("n responden", len(S), agg["n"], 0)
    chk("rata-rata puas", mean([d["puas"] for d in S]), agg["ben"][3]["mean"], 0.01)
    chk("% beban berat", 100 * mean([d["berat"] for d in S]), agg["workload_heavy_pct"], 0.1)
    ten = [agree(d["tenggat"]) for d in S if d["tenggat"] is not None]
    chk("% tenggat bertabrakan (sering/selalu)", 100 * mean(ten), agg["coord"][3]["pct_oa"], 0.1)
    chk("% arahan dosen konsisten (Ya)", 100 * mean([d["konsisten"] for d in S]), agg["coord"][1]["ya"], 0.1)
    for k, (lab, _, _) in enumerate(am.OPS):
        exp = next(c["r_puas"] for c in agg["drivers"]["corr"] if c["label"] == lab)
        chk(f"r(puas, {lab})", pearson([d["ops"][k] for d in S], [d["puas"] for d in S]), exp, 0.01)
    total = sum(rosters.values())
    chk("tingkat respons", 100 * len(S) / total, agg["response"]["rate"], 0.1)
    enf = [d for d in S if d["mon"]]
    roster_enf = sum(v for k, v in rosters.items() if k in MON)
    chk("respons kelas dipantau", 100 * len(enf) / roster_enf, agg["monitored"]["enf"]["rate"], 0.1)
    return results


# ----------------------------------------------------------------------------- analisis per masalah


AFFECTED = {  # definisi "terdampak" per masalah (tingkat responden)
    "beban": ("Beban berat atau sangat berat", lambda d: d["berat"]),
    "jadwal": ("Tenggat antar mata kuliah sering/selalu bertabrakan", lambda d: agree(d["tenggat"])),
    "selaras": ("Tidak setuju tugas dan penilaian antar mata kuliah selaras", lambda d: low(d["ops"][4])),
    "koordinasi": ("Arahan dosen antar mata kuliah tidak konsisten", lambda d: None if d["konsisten"] is None else 1 - d["konsisten"]),
    "penilaian": ("Tidak setuju penilaian adil", lambda d: low(d["ops"][6])),
    "fasilitas": ("Tidak setuju fasilitas memadai", lambda d: low(d["ops"][7])),
    "bimbingan": ("Tim belum pernah berkonsultasi", lambda d: d["konsul0"]),
    # indikator tambahan: persepsi jadwal, kecukupan bimbingan, dan kejelasan dosen rujukan
    "jadwal_realistis": ("Tidak setuju jadwal dan tenggat milestone realistis", lambda d: low(d["ops"][2])),
    "bimbingan_kurang": ("Tidak setuju bimbingan dosen memadai", lambda d: low(d["ops"][3])),
    "rujukan": ("Tim tidak tahu harus menghubungi dosen siapa", lambda d: None if d["tahu_hubungi"] is None else 1 - d["tahu_hubungi"]),
}


def driver_models(S):
    preds = {lab: (lambda d, k=k: d["ops"][k]) for k, (lab, _, _) in enumerate(am.OPS)}
    preds.update({"Beban berat": lambda d: d["berat"], "Belum pernah konsultasi": lambda d: d["konsul0"],
                  "Arahan dosen konsisten": lambda d: d["konsisten"], "Tim tahu harus menghubungi dosen siapa": lambda d: d["tahu_hubungi"],
                  "Tenggat sering bertabrakan": lambda d: agree(d["tenggat"])})
    return {"puas": model(S, preds, lambda d: d["puas"]), "lanjut": model(S, preds, lambda d: d["lanjut"])}


def priority(S):
    """Satu model bersama: kepuasan ~ semua indikator 'terdampak'. Skor = prevalensi x kehilangan kepuasan."""
    preds = {k: v[1] for k, v in AFFECTED.items()}
    out = {}
    for outcome, fn in (("puas", lambda d: d["puas"]), ("lanjut", lambda d: d["lanjut"])):
        m = model(S, preds, fn)
        rows = []
        if "koef" in m:
            for c in m["koef"]:
                prev = prop([AFFECTED[c["nama"]][1](d) for d in S])
                raw = diff_means(S, AFFECTED[c["nama"]][1], fn)
                rows.append({"masalah": c["nama"], "definisi": AFFECTED[c["nama"]][0], "prevalensi": prev,
                             "selisih_mentah": raw, "koef_terkontrol": {"b": c["b"], "ci": c["b_ci"]},
                             "skor": None if "pct" not in prev else round(prev["pct"] / 100 * -c["b"], 3)})
            rows.sort(key=lambda x: -(x["skor"] if x["skor"] is not None else -9))
        out[outcome] = {"n": m.get("n"), "r2": m.get("r2"), "baris": rows}
    return out


def p_respons(S, rosters, MON, cells):
    classes = []
    cnt = collections.Counter(d["cls"] for d in S if d["cls"])
    for lab in sorted(rosters):
        if lab[:2] in ("TI", "SI"):
            classes.append({"kelas": lab, "n": cnt.get(lab, 0), "roster": rosters[lab], "tingkat": r1(100 * cnt.get(lab, 0) / rosters[lab]),
                            "dipantau": 1 if lab in MON else 0})
    mix = []
    for (p, s), roster in cells.items():
        n = sum(1 for d in S if (d["prodi"], d["sem"]) == (p, s))
        mix.append({"sel": f"{p} Sem {s}", "n": n, "roster": roster, "pct_responden": r1(100 * n / len(S)), "pct_populasi": r1(100 * roster / sum(cells.values())),
                    "bobot": r1(roster / n, 2) if n else None})
    inds = {
        "Rata-rata kepuasan (1-5)": lambda d: d["puas"],
        "% puas (setuju atau sangat setuju)": lambda d: None if d["puas"] is None else 100 * agree(d["puas"]),
        "% beban berat": lambda d: None if d["berat"] is None else 100 * d["berat"],
        "% tenggat sering bertabrakan": lambda d: None if d["tenggat"] is None else 100 * agree(d["tenggat"]),
        "% arahan dosen konsisten": lambda d: None if d["konsisten"] is None else 100 * d["konsisten"],
        "% setuju fasilitas memadai": lambda d: None if d["ops"][7] is None else 100 * agree(d["ops"][7]),
        "% belum pernah konsultasi": lambda d: None if d["konsul0"] is None else 100 * d["konsul0"],
    }
    post = []
    for lab, fn in inds.items():
        raw = mean([fn(d) for d in S])
        ps = poststrat(S, fn, cells)
        post.append({"indikator": lab, "mentah": r1(raw, 2), "pasca_strat": r1(ps, 2), "ci_pasca_strat": poststrat_ci(S, fn, cells, B=800),
                     "bergeser": r1(ps - raw, 2)})
    mon = {}
    for lab, fn in [("puas", lambda d: d["puas"]), ("beban berat", lambda d: d["berat"]), ("tenggat bertabrakan", lambda d: agree(d["tenggat"])),
                    ("arahan konsisten", lambda d: d["konsisten"]), ("fasilitas (skor)", lambda d: d["ops"][7]), ("belum pernah konsultasi", lambda d: d["konsul0"])]:
        mon[lab] = diff_means(S, lambda d: d["mon"], fn)
    # kelas dengan respons >= MIN: korelasi tingkat respons dan kepuasan rata-rata kelas
    return {"kelas": classes, "komposisi": mix, "pasca_stratifikasi": post, "dipantau_vs_lain": mon}


def p_beban(S):
    out = {"prevalensi": prop([d["berat"] for d in S]), "per_semester": by_group(S, lambda d: d["seg"], ind_prop(lambda d: d["berat"])),
           "per_kelas": by_group(S, lambda d: d["cls"], ind_prop(lambda d: d["berat"]))}
    has_task = lambda d: None if not d["mat"] and d["berat"] is None else (1 if "Tugas mata kuliah menambah beban di luar proyek" in d["mat"] else 0)
    out["tugas_tambahan_dipilih"] = prop([has_task(d) for d in S])
    out["berat_jika_tugas_tambahan"] = diff_means(S, has_task, lambda d: d["berat"])
    out["berat_vs_tenggat"] = diff_means(S, lambda d: agree(d["tenggat"]), lambda d: d["berat"])
    out["berat_vs_kontribusi_timpang"] = diff_means(S, lambda d: 1 if "Kontribusi anggota tim tidak seimbang" in d["imp"] else 0, lambda d: d["berat"])
    out["berat_vs_belum_konsultasi"] = diff_means(S, lambda d: d["konsul0"], lambda d: d["berat"])
    out["korelasi_berat_dengan_porsi_tugas_bagian_proyek"] = corr_with_ci(S, lambda d: share_ya(d, 3), lambda d: d["berat"])
    out["korelasi_berat_dengan_porsi_latihan_umum"] = corr_with_ci(S, share_latihan, lambda d: d["berat"])
    preds = {"Tugas mata kuliah menambah beban": has_task, "Tenggat sering bertabrakan": lambda d: agree(d["tenggat"]),
             "Kontribusi tim tidak seimbang": lambda d: 1 if "Kontribusi anggota tim tidak seimbang" in d["imp"] else 0,
             "Porsi tugas bagian dari proyek": lambda d: share_ya(d, 3), "Porsi tugas utama latihan umum": share_latihan,
             "Belum pernah konsultasi": lambda d: d["konsul0"], "TI Sem 5": lambda d: 1 if d["seg"] == "TI Sem 5" else 0,
             "SIB Sem 3": lambda d: 1 if d["seg"] == "SIB Sem 3" else 0, "SIB Sem 5": lambda d: 1 if d["seg"] == "SIB Sem 5" else 0}
    out["model_beban_berat"] = model(S, preds, lambda d: d["berat"])
    out["dampak_pada_kepuasan"] = diff_means(S, lambda d: d["berat"], lambda d: d["puas"])
    out["dampak_pada_keinginan_lanjut"] = diff_means(S, lambda d: d["berat"], lambda d: d["lanjut"])
    return out


def p_jadwal(S, L):
    f = lambda d: agree(d["tenggat"])
    dist = collections.Counter(d["tenggat"] for d in S if d["tenggat"] is not None)
    out = {"prevalensi": prop([f(d) for d in S]), "sebaran_skor_1_5": {str(k): dist.get(k, 0) for k in range(1, 6)},
           "per_semester": by_group(S, lambda d: d["seg"], ind_prop(f)), "per_kelas": by_group(S, lambda d: d["cls"], ind_prop(f)),
           "kendala_baru_diketahui_saat_review": prop([agree(d["kendala_review"]) for d in S]),
           "per_semester_kendala_review": by_group(S, lambda d: d["seg"], ind_prop(lambda d: agree(d["kendala_review"])))}
    out["berat_jika_tenggat_bertabrakan"] = diff_means(S, f, lambda d: d["berat"])
    out["jadwal_realistis_jika_tenggat_bertabrakan"] = diff_means(S, f, lambda d: d["ops"][2])
    out["puas_jika_tenggat_bertabrakan"] = diff_means(S, f, lambda d: d["puas"])
    out["lanjut_jika_tenggat_bertabrakan"] = diff_means(S, f, lambda d: d["lanjut"])
    out["korelasi_tenggat_dengan_jadwal_realistis"] = corr_with_ci(S, lambda d: d["tenggat"], lambda d: d["ops"][2])
    unreal = lambda d: low(d["ops"][2])
    out["jadwal_tidak_realistis"] = prop([unreal(d) for d in S])
    out["per_semester_tidak_realistis"] = by_group(S, lambda d: d["seg"], ind_prop(unreal))
    out["per_kelas_tidak_realistis"] = by_group(S, lambda d: d["cls"], ind_prop(unreal))
    out["lanjut_jika_jadwal_tidak_realistis"] = diff_means(S, unreal, lambda d: d["lanjut"])
    out["puas_jika_jadwal_tidak_realistis"] = diff_means(S, unreal, lambda d: d["puas"])
    out["berat_jika_jadwal_tidak_realistis"] = diff_means(S, unreal, lambda d: d["berat"])
    out["pilih_waktu_beban_sebagai_masalah"] = prop([1 if "Waktu dan beban kerja" in d["imp"] else 0 for d in S])
    out["waktu_beban_jika_tenggat"] = diff_means(S, f, lambda d: 1 if "Waktu dan beban kerja" in d["imp"] else 0)
    # sisi dosen: seberapa sering dosen menyelaraskan tenggat satu sama lain
    lk = []
    for lab, c in am.LEC_COORD_LK:
        vals = [am.likert(r[c]) for r in L["rows"]]
        v = [x for x in vals if x is not None]
        lk.append({"butir": lab, "n": len(v), "tidak_pernah_atau_jarang": sum(1 for x in v if x <= 2), "kadang": sum(1 for x in v if x == 3),
                   "sering_atau_selalu": sum(1 for x in v if x >= 4)})
    out["dosen_menyelaraskan"] = lk
    out["dosen_jadwal_realistis"] = {"mahasiswa": r1(mean([d["ops"][2] for d in S]), 2), "dosen": r1(mean([am.likert(r[48]) for r in L["rows"]]), 2)}
    # Apakah tugas terpisah per mata kuliah berkaitan dengan lebih banyak tenggat bertabrakan?
    # (menguji apakah satu paket pengumpulan terpadu per milestone masuk akal)
    deliv = lambda d: share_type(d, lambda t: t.startswith("Deliverable"))
    latih = lambda d: share_type(d, lambda t: t.startswith("Latihan"))
    kuis = lambda d: 1 if any(c["typ"] and c["typ"].startswith("Kuis") for c in d["courses"]) else 0
    empat = lambda d: 1 if len(d["courses"]) == 4 else 0
    out["tenggat_vs_porsi_deliverable"] = corr_with_ci(S, deliv, f)
    out["tenggat_vs_porsi_latihan"] = corr_with_ci(S, latih, f)
    out["tenggat_vs_porsi_tugas_bagian_proyek"] = corr_with_ci(S, lambda d: share_ya(d, 3), f)
    out["tidak_realistis_vs_porsi_deliverable"] = corr_with_ci(S, deliv, unreal)
    out["tidak_realistis_vs_porsi_latihan"] = corr_with_ci(S, latih, unreal)
    out["responden_dengan_kuis_atau_ujian_sebagai_tugas_utama"] = prop([kuis(d) for d in S])
    out["tenggat_jika_ada_kuis_atau_ujian_sebagai_tugas_utama"] = diff_means(S, kuis, f)
    out["tenggat_empat_vs_tiga_mata_kuliah"] = diff_means(S, empat, f)
    return out


def course_table(S):
    rows = []
    for key in am.BLOCKS:
        b = am.BLOCKS[key]
        rr = [d for d in S if (d["prodi"], d["sem"]) == (b["prodi"], b["sem"])]
        for ci, cname in enumerate(b["courses"]):
            cs = [d["courses"][ci] for d in rr]
            n = len(cs)
            if n < MIN:
                continue
            ya = [1 if c["bc"][3] == "Ya" else 0 for c in cs if c["bc"][3]]
            kr = [1 if c["bc"][4] == "Ya" else 0 for c in cs if c["bc"][4]]
            ac = [mean([1 if (x is not None and x >= 4) else 0 for x in c["acts"] if x is not None]) for c in cs]
            rows.append({"prodi": b["prodi"], "sem": b["sem"], "mata_kuliah": cname, "pic": 1 if PIC.get((b["prodi"], b["sem"])) == cname else 0, "n": n,
                         "tugas_bagian_proyek": prop(ya), "kriteria_sejalan": prop(kr), "kegiatan_pbl_sering": r1(100 * mean(ac), 1)})
    return rows


def pic_vs_support(S):
    """Per responden: rata-rata di mata kuliah PIC dikurangi rata-rata di mata kuliah pendukung (berpasangan)."""
    def unit(d, fn):
        p = [fn(c) for c in d["courses"] if c["pic"]]
        s = [fn(c) for c in d["courses"] if not c["pic"]]
        p, s = [x for x in p if x is not None], [x for x in s if x is not None]
        return (mean(p) - mean(s)) if p and s else None
    fns = {"tugas_bagian_proyek": lambda c: None if not c["bc"][3] else (1 if c["bc"][3] == "Ya" else 0),
           "kriteria_sejalan": lambda c: None if not c["bc"][4] else (1 if c["bc"][4] == "Ya" else 0),
           "kegiatan_pbl_sering": lambda c: mean([1 if x >= 4 else 0 for x in c["acts"] if x is not None]) if any(x is not None for x in c["acts"]) else None}
    out = {}
    for nm, fn in fns.items():
        v = [unit(d, fn) for d in S]
        v = [x for x in v if x is not None]
        pa = mean([x for d in S for x in [mean([fn(c) for c in d["courses"] if c["pic"] and fn(c) is not None])] if x is not None])
        su = mean([x for d in S for x in [mean([fn(c) for c in d["courses"] if not c["pic"] and fn(c) is not None])] if x is not None])
        out[nm] = {"n": len(v), "pic": r1(100 * pa, 1), "pendukung": r1(100 * su, 1), "selisih_poin": r1(100 * mean(v), 1),
                   "ci": [round(100 * x, 1) for x in boot_ci(v, lambda s: mean(s), B=1000)] if len(v) >= MIN else None}
    out["per_semester"] = []
    for seg in sorted(set(d["seg"] for d in S)):
        rr = [d for d in S if d["seg"] == seg]
        if len(rr) >= MIN:
            v = [x for x in (unit(d, fns["tugas_bagian_proyek"]) for d in rr) if x is not None]
            out["per_semester"].append({"sel": seg, "n": len(v), "tugas_bagian_proyek_selisih_poin": r1(100 * mean(v), 1),
                                        "ci": [round(100 * x, 1) for x in boot_ci(v, lambda s: mean(s), B=1000)] if len(v) >= MIN else None})
    return out


def p_selaras(S, L):
    out = {"per_mata_kuliah": course_table(S), "pic_vs_pendukung": pic_vs_support(S),
           "selaras_dinilai_setuju": prop([agree(d["ops"][4]) for d in S]), "per_semester": by_group(S, lambda d: d["seg"], ind_prop(lambda d: agree(d["ops"][4])))}
    out["porsi_tugas_bagian_proyek_vs_berat"] = corr_with_ci(S, lambda d: share_ya(d, 3), lambda d: d["berat"])
    out["porsi_tugas_bagian_proyek_vs_puas"] = corr_with_ci(S, lambda d: share_ya(d, 3), lambda d: d["puas"])
    out["porsi_tugas_bagian_proyek_vs_selaras"] = corr_with_ci(S, lambda d: share_ya(d, 3), lambda d: d["ops"][4])
    typ = collections.Counter()
    for d in S:
        for c in d["courses"]:
            if c["typ"]:
                typ[(c["pic"], c["typ"])] += 1
    out["jenis_tugas_utama"] = [{"jenis": t, "pic": p, "n": n} for (p, t), n in sorted(typ.items()) if n >= MIN]
    out["dosen_vs_mahasiswa"] = {"dosen_tugas_bagian_deliverable_ya": am.yn_dist([r[23] for r in L["rows"]])["ya"],
                                 "mahasiswa_tugas_bagian_proyek_ya": r1(100 * mean([1 if c["bc"][3] == "Ya" else 0 for d in S for c in d["courses"] if c["bc"][3]]), 1)}
    return out


def lec_groups(L):
    rows = L["rows"]
    res = {}
    for lab, fn in [("mengampu TI", lambda r: "TI" in [x.split()[0] for x in str(r[2]).split(", ")]),
                    ("mengampu SIB", lambda r: "SIB" in [x.split()[0] for x in str(r[2]).split(", ")]),
                    ("pertama kali mengampu PBL", lambda r: str(r[3]).startswith("Pertama")),
                    ("sudah pernah mengampu PBL", lambda r: not str(r[3]).startswith("Pertama"))]:
        rr = [r for r in rows if fn(r)]
        res[lab] = rr
    return res


def p_koordinasi(S, L):
    f = lambda d: None if d["konsisten"] is None else 1 - d["konsisten"]
    out = {"konsisten_ya": prop([d["konsisten"] for d in S]), "per_semester": by_group(S, lambda d: d["seg"], ind_prop(lambda d: d["konsisten"])),
           "per_kelas": by_group(S, lambda d: d["cls"], ind_prop(lambda d: d["konsisten"])),
           "tahu_hubungi_ya": prop([d["tahu_hubungi"] for d in S]), "dosen_tahu_progres_ya": prop([d["tahu_progres"] for d in S]),
           "tidak_jelas_rujukan_dipilih": prop([1 if "Tidak jelas dosen yang menjadi rujukan tim" in d["imp"] else 0 for d in S]),
           "arahan_tidak_terkoordinasi_dipilih": prop([1 if "Arahan dan tugas antar dosen tidak terkoordinasi" in d["imp"] else 0 for d in S])}
    out["puas_jika_tidak_konsisten"] = diff_means(S, f, lambda d: d["puas"])
    out["lanjut_jika_tidak_konsisten"] = diff_means(S, f, lambda d: d["lanjut"])
    out["puas_jika_tidak_tahu_hubungi"] = diff_means(S, lambda d: None if d["tahu_hubungi"] is None else 1 - d["tahu_hubungi"], lambda d: d["puas"])
    out["konsisten_jika_tahu_hubungi"] = diff_means(S, lambda d: d["tahu_hubungi"], lambda d: d["konsisten"])
    out["tenggat_bertabrakan_jika_tidak_konsisten"] = diff_means(S, f, lambda d: agree(d["tenggat"]))
    out["dipantau_vs_lain_konsisten"] = diff_means(S, lambda d: d["mon"], lambda d: d["konsisten"])
    rows = L["rows"]
    n = len(rows)
    out["dosen"] = {"n": n, "rujukan_utama_jelas": am.yn_dist([r[38] for r in rows]), "kesepakatan_peran": am.yn_dist([r[37] for r in rows]),
                    "mengetahui_dosen_lain": am.yn_dist([r[36] for r in rows]), "saling_mengetahui_perkembangan": am.yn_dist([r[39] for r in rows]),
                    "kehadiran_rapat": am.dist_of(am.col(rows, 34), ["Selalu hadir", "Hadir sebagian", "Tidak pernah hadir"])["items"],
                    "wa": am.dist_of(am.col(rows, 33))["items"], "frekuensi_koordinasi": am.dist_of(am.col(rows, 32), ["Tidak pernah", "1-2 kali", "3-5 kali", "Lebih dari 5 kali"])["items"],
                    "hambatan": am.freq(am.lec_multi(rows, 45), n), "dukungan_diminta": am.freq(am.lec_multi(rows, 65), n)}
    grp = {}
    for lab, rr in lec_groups(L).items():
        if len(rr) >= MIN:
            m = len(rr)
            grp[lab] = {"n": m, "rujukan_jelas_ya": am.yn_dist([r[38] for r in rr])["ya"], "kesepakatan_peran_ya": am.yn_dist([r[37] for r in rr])["ya"],
                        "selalu_hadir_rapat": r1(100 * sum(1 for r in rr if str(r[34]).startswith("Selalu")) / m, 1),
                        "hambatan_beban": r1(100 * sum(1 for r in rr if "Beban mengajar dan administrasi lain" in am.split_multi(r[45])) / m, 1)}
    out["dosen_per_kelompok"] = grp
    return out


def p_penilaian(S, L):
    f_adil, f_rub = (lambda d: agree(d["ops"][6])), (lambda d: agree(d["ops"][5]))
    imb = lambda d: 1 if "Kontribusi anggota tim tidak seimbang" in d["imp"] else 0
    out = {"adil_setuju": prop([f_adil(d) for d in S]), "rubrik_jelas_setuju": prop([f_rub(d) for d in S]),
           "per_semester_adil": by_group(S, lambda d: d["seg"], ind_prop(f_adil)), "per_semester_rubrik": by_group(S, lambda d: d["seg"], ind_prop(f_rub)),
           "kontribusi_timpang_dipilih": prop([imb(d) for d in S]), "per_semester_timpang": by_group(S, lambda d: d["seg"], ind_prop(imb))}
    out["adil_jika_timpang"] = diff_means(S, imb, lambda d: d["ops"][6])
    out["puas_jika_timpang"] = diff_means(S, imb, lambda d: d["puas"])
    out["puas_jika_tidak_adil"] = diff_means(S, lambda d: low(d["ops"][6]), lambda d: d["puas"])
    out["lanjut_jika_tidak_adil"] = diff_means(S, lambda d: low(d["ops"][6]), lambda d: d["lanjut"])
    preds = {"Rubrik jelas": lambda d: d["ops"][5], "Kontribusi tim tidak seimbang": imb, "Bimbingan dosen memadai": lambda d: d["ops"][3],
             "Arahan dosen konsisten": lambda d: d["konsisten"], "Tenggat sering bertabrakan": lambda d: agree(d["tenggat"]),
             "Beban berat": lambda d: d["berat"], "SOP dan template membantu": lambda d: d["ops"][1]}
    out["model_penilaian_adil"] = model(S, preds, lambda d: d["ops"][6])
    out["korelasi_rubrik_adil"] = corr_with_ci(S, lambda d: d["ops"][5], lambda d: d["ops"][6])
    rows = L["rows"]
    out["dosen"] = {"n": len(rows), "kontribusi_timpang_dipilih": prop([1 if "Kontribusi anggota tim mahasiswa tidak seimbang" in am.split_multi(r[63]) else 0 for r in rows]),
                    "rubrik_jelas_rata": r1(mean([am.likert(r[51]) for r in rows]), 2), "adil_rata": r1(mean([am.likert(r[52]) for r in rows]), 2),
                    "mahasiswa_rubrik_rata": r1(mean([d["ops"][5] for d in S]), 2), "mahasiswa_adil_rata": r1(mean([d["ops"][6] for d in S]), 2),
                    "meminta_panduan_contoh": prop([1 if "Panduan dan contoh penilaian" in am.split_multi(r[65]) else 0 for r in rows])}
    return out


def p_fasilitas(S, L, MON):
    fa = lambda d: agree(d["ops"][7])
    out = {"fasilitas_setuju": prop([fa(d) for d in S]), "fasilitas_skor": {"mean": r1(mean([d["ops"][7] for d in S]), 2)},
           "per_semester_fasilitas": by_group(S, lambda d: d["seg"], ind_mean(lambda d: d["ops"][7])),
           "per_prodi_fasilitas": by_group(S, lambda d: d["prodi"], ind_mean(lambda d: d["ops"][7])),
           "fasilitas_ti_vs_sib": diff_means(S, lambda d: 1 if d["prodi"] == "TI" else 0, lambda d: d["ops"][7]),
           "fasilitas_pilih_masalah": prop([1 if "Fasilitas dan sumber daya (server, data, perangkat)" in d["imp"] else 0 for d in S]),
           "per_prodi_fasilitas_masalah": by_group(S, lambda d: d["prodi"], ind_prop(lambda d: 1 if "Fasilitas dan sumber daya (server, data, perangkat)" in d["imp"] else 0)),
           "belum_konsultasi": prop([d["konsul0"] for d in S]), "per_semester_belum_konsultasi": by_group(S, lambda d: d["seg"], ind_prop(lambda d: d["konsul0"])),
           "per_kelas_belum_konsultasi": by_group(S, lambda d: d["cls"], ind_prop(lambda d: d["konsul0"])),
           "dipantau_vs_lain_belum_konsultasi": diff_means(S, lambda d: d["mon"], lambda d: d["konsul0"])}
    out["puas_jika_belum_konsultasi"] = diff_means(S, lambda d: d["konsul0"], lambda d: d["puas"])
    out["bimbingan_memadai_jika_belum_konsultasi"] = diff_means(S, lambda d: d["konsul0"], lambda d: d["ops"][3])
    out["puas_jika_fasilitas_rendah"] = diff_means(S, lambda d: low(d["ops"][7]), lambda d: d["puas"])
    out["korelasi_fasilitas_puas"] = corr_with_ci(S, lambda d: d["ops"][7], lambda d: d["puas"])
    out["respons_dosen"] = [{"label": k, "n": v} for k, v in collections.Counter(d["konsul_resp"] for d in S if d["konsul_resp"]).most_common() if v >= MIN]
    mat_late = lambda d: 1 if "Materi terlambat dibanding kebutuhan milestone" in d["mat"] else 0
    out["materi_terlambat_dipilih"] = prop([mat_late(d) for d in S])
    out["materi_tidak_sebelum_milestone"] = prop([1 if c["bc"][1] == "Tidak" else 0 for d in S for c in d["courses"] if c["bc"][1]])
    out["materi_terlambat_jika_ada_mk_tidak"] = diff_means(S, lambda d: 1 if any(c["bc"][1] == "Tidak" for c in d["courses"]) else 0, mat_late)
    # Eksploratif: deployment dibutuhkan untuk aplikasi web dan untuk pengujian di Penjaminan Mutu (TI Sem 5, SIB Sem 5).
    # Apakah skor fasilitas berbeda menurut jenis kebutuhan itu?
    out["fasilitas_semester_pmpl_vs_tanpa"] = diff_means(S, lambda d: 1 if d["seg"] in ("TI Sem 5", "SIB Sem 5") else 0, lambda d: d["ops"][7])
    out["fasilitas_semester_web_vs_mobile"] = diff_means(S, lambda d: 1 if d["seg"] in ("TI Sem 3", "SIB Sem 3", "SIB Sem 5") else 0, lambda d: d["ops"][7])
    rows = L["rows"]
    out["dosen"] = {"n": len(rows), "frekuensi_konsultasi": am.dist_of([am.fix_zero(v) for v in am.col(rows, 17)], ["0 kali", "1-2 kali", "3-5 kali", "Lebih dari 5 kali"])["items"],
                    "fasilitas_rata_dosen": r1(mean([am.likert(r[53]) for r in rows]), 2), "fasilitas_rata_mahasiswa": r1(mean([d["ops"][7] for d in S]), 2),
                    "hambatan_materi": am.freq(am.lec_multi(rows, 31), len(rows))}
    return out


# ----------------------------------------------------------------------------- ukuran keberhasilan


def mdd(p, n, za=1.96, zb=0.84):
    """Selisih terkecil (poin persen) yang bisa dibuktikan antara dua survei berukuran n yang sama
    (uji dua sisi 5%, daya 80%), untuk proporsi sekitar p."""
    return round(100 * (za + zb) * math.sqrt(2 * p * (1 - p) / n), 1) if n else None


def ukuran_keberhasilan(S, L, rosters):
    """Tiap ukuran: nilai sekarang, selang 95%, target di tepi selang, dan selisih terkecil yang bisa dibuktikan.
    Target di tepi selang adalah batas praktis; membuktikan perubahan nyata butuh selisih yang lebih besar."""
    rows = L["rows"]

    def item(label, flags, arah, catatan=None):
        v = [f for f in flags if f is not None]
        n, k = len(v), sum(v)
        if n < MIN:
            return None
        p = k / n
        ci = wilson(k, n)
        out = {"ukuran": label, "arah": arah, "n": n, "persen": round(100 * p, 1), "ci": ci,
               "target_persen": ci[0] if arah == "turun" else ci[1], "selisih_terkecil_terbukti_poin": mdd(p, n)}
        if catatan:
            out["catatan"] = catatan
        return out

    lec = lambda col: [yn1(r[col]) for r in rows]
    note_l = "n = 22: perubahan kecil tidak bisa dibuktikan; pantau angka mentah dan cerita dosen"
    out = [
        item("Beban berat atau sangat berat", [d["berat"] for d in S], "turun"),
        item("Tenggat antar mata kuliah sering atau selalu bertabrakan", [agree(d["tenggat"]) for d in S], "turun"),
        item("Tidak setuju jadwal dan tenggat milestone realistis", [low(d["ops"][2]) for d in S], "turun"),
        item("Setuju fasilitas dan sumber daya memadai", [agree(d["ops"][7]) for d in S], "naik"),
        item("Setuju rubrik dan kriteria penilaian jelas", [agree(d["ops"][5]) for d in S], "naik"),
        item("Setuju penilaian adil terhadap kontribusi anggota", [agree(d["ops"][6]) for d in S], "naik"),
        item("Arahan dosen antar mata kuliah konsisten (Ya)", [d["konsisten"] for d in S], "naik"),
        item("Tim tahu harus menghubungi dosen siapa (Ya)", [d["tahu_hubungi"] for d in S], "naik"),
        item("Setuju tugas dan penilaian antar mata kuliah selaras", [agree(d["ops"][4]) for d in S], "naik"),
        item("Dosen: jelas dosen rujukan utama tim (Ya)", lec(38), "naik", note_l),
        item("Dosen: ada kesepakatan pembagian peran antar dosen (Ya)", lec(37), "naik", note_l),
    ]
    total = sum(rosters.values())
    cnt = collections.Counter(d["cls"] for d in S if d["cls"])
    ok_classes = sum(1 for k in rosters if cnt.get(k, 0) >= MIN)
    out.append({"ukuran": "Tingkat respons mahasiswa", "arah": "naik", "n": total, "persen": round(100 * len(S) / total, 1),
                "target_persen": 70.0, "catatan": "Target 70% ditetapkan program, bukan dari selang"})
    out.append({"ukuran": "Kelas dengan sedikitnya 5 responden", "arah": "naik", "n": len(rosters), "nilai": ok_classes, "target": len(rosters)})
    return [o for o in out if o]


# ----------------------------------------------------------------------------- sensitivitas


def sensitivity(S):
    def top_drivers(items):
        m = driver_models(items)["puas"]
        if "koef" not in m:
            return None
        ranked = sorted(m["koef"], key=lambda c: -abs(c["beta"]))
        return [(c["nama"], c["beta"]) for c in ranked[:4]]

    def effects(items):
        return {k: diff_means(items, v[1], lambda d: d["puas"], B=600).get("selisih") for k, v in AFFECTED.items()}

    no_sib5 = [d for d in S if d["seg"] != "SIB Sem 5"]
    return {"semua": {"top_driver_puas": top_drivers(S), "efek_terhadap_puas": effects(S)},
            "tanpa_SIB_Sem5": {"n": len(no_sib5), "top_driver_puas": top_drivers(no_sib5), "efek_terhadap_puas": effects(no_sib5)}}


# ----------------------------------------------------------------------------- main


def main():
    rosters = am.load_rosters()
    MON = am.load_monitored_classes()
    _, srows = am.load_sheet(glob.glob(os.path.join(am.RAW, "*Mahasiswa*.xlsx"))[0])
    _, lrows = am.load_sheet(glob.glob(os.path.join(am.RAW, "*Dosen*.xlsx"))[0])
    srows = [r for r in srows if r and r[0]]
    lrows = [r for r in lrows if r and r[0]]
    for r in lrows:
        for c in (31, 45, 62, 63, 65):
            for x in am.split_multi(r[c]):
                am.LEC_COUNTS[(c, x)] = am.LEC_COUNTS.get((c, x), 0) + 1
    S = [derive(r, MON) for r in srows]
    L = {"rows": lrows}
    cells = make_cells(rosters)
    print(f"mahasiswa={len(S)} dosen={len(lrows)} kelas={len(rosters)} dipantau={len(MON)}")

    checks = reproduce(S, rosters, MON)
    bad = [c for c in checks if not c["ok"]]
    print(f"pemeriksaan terhadap agregat.json: {len(checks) - len(bad)}/{len(checks)} cocok")
    for c in bad:
        print("  TIDAK COCOK:", c)
    if bad:
        sys.exit(1)

    result = {"meta": {"dibuat": datetime.date.today().isoformat(), "n_mahasiswa": len(S), "n_dosen": len(lrows), "min_kelompok": MIN, "seed": SEED,
                       "bootstrap": B_MEAN, "bootstrap_model": B_MODEL, "pic": [{"prodi": p, "sem": s, "mata_kuliah": c} for (p, s), c in PIC.items()],
                       "catatan": "Hanya agregat. Kelompok di bawah n minimum disembunyikan. Asosiasi bukan bukti sebab-akibat."},
              "pemeriksaan": checks}
    result["umum"] = {"model_pendorong": driver_models(S), "prioritas": priority(S)}
    print("... model pendorong dan prioritas selesai")
    result["p1_respons"] = p_respons(S, rosters, MON, cells)
    result["p2_beban"] = p_beban(S)
    result["p3_jadwal"] = p_jadwal(S, L)
    result["p4_selaras"] = p_selaras(S, L)
    result["p5_koordinasi"] = p_koordinasi(S, L)
    result["p6_penilaian"] = p_penilaian(S, L)
    result["p7_fasilitas_bimbingan"] = p_fasilitas(S, L, MON)
    print("... analisis per masalah selesai")
    result["sensitivitas"] = sensitivity(S)
    result["ukuran_keberhasilan"] = ukuran_keberhasilan(S, L, rosters)
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(result, f, ensure_ascii=False, indent=1)
    print("Menulis", OUT)


if __name__ == "__main__":
    main()
