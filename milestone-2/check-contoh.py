#!/usr/bin/env python3
"""Pemeriksa dokumen Milestone 2 (SOP, template, pustaka, empat contoh laporan).

Jalankan: python3 -I check-contoh.py [berkas ...]
Keluar dengan kode 1 bila ada pelanggaran.
"""
import glob, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
EXAMPLES = sorted(glob.glob(os.path.join(HERE, 'Contoh-Laporan-Milestone-2-*.typ')))
LIB = os.path.join(HERE, 'contoh-lib.typ')
DOCS = [os.path.join(HERE, 'SOP-Milestone-2-PBL.md'), os.path.join(HERE, 'Template-Laporan-Milestone-2-PBL.md')]

BANNED = [
    (r'dilepas|Dilepas', 'kata "dilepas" (pakai "dihapus")'),
    (r'baru di M2', 'label lama "baru di M2"'),
    (r'diisi di laporan akhir', 'label lama "diisi di laporan akhir"'),
    (r'\bMg\b', 'singkatan "Mg" (tulis "Minggu")'),
    (r'\[Jalan\]', 'status "Jalan" (tulis "Berjalan")'),
    (r'dikunci', 'kata "dikunci" (pakai "dibekukan")'),
    (r'Tiru ', 'kata "Tiru" (pakai "Ikuti")'),
    (r'\(contoh\)|\(alamat contoh\)|Angka contoh|Format contoh', 'tanda "(contoh)" berulang'),
    (r'Pindahkan dan perbarui', 'kalimat kaku "Pindahkan dan perbarui"'),
    (r'\[Tampil\]|\[Masuk\]|\[Muncul\]', 'hasil aktual satu kata (tulis klausa)'),
    (r'Posisi Kami di', '"Posisi Kami di" (pakai "Posisi Proyek pada")'),
    (r'(?i)konfirmasi kontribusi|cek kontribusi|kontribusi tengah', 'istilah lama untuk pemeriksaan kontribusi (pakai Penilaian 360 lewat Google Form)'),
]
STOCK = [
    r'dapat disimpulkan bahwa', r'perlu dicatat bahwa', r'hal ini menunjukkan bahwa', r'secara keseluruhan',
    r'dalam rangka', r'pada dasarnya', r'tidak hanya .{1,60} tetapi juga', r'dengan demikian', r'sangat penting',
    r'memainkan peran', r'menjadi landasan', r'di era ', r'penting untuk diketahui', r'tak dapat dipungkiri',
]
OLD_API = r'\b(?:card|feature-card|stat-tile|mag|avatar|eyebrow|section-title)\('
ALLOWED_STAGE = {'st-proposal', 'st-lanjutan', 'st-m2', 'st-akhir', 'st-hapus'}

errors = []
def err(f, msg):
    errors.append(f'{os.path.basename(f)}: {msg}')

def read(f):
    return open(f, encoding='utf-8').read()

def check_banned(f, text):
    for pat, why in BANNED:
        for m in re.finditer(pat, text):
            line = text.count('\n', 0, m.start()) + 1
            err(f, f'baris {line}: {why}')

def strip_code(text):
    text = re.sub(r'```.*?```', '', text, flags=re.S)
    return re.sub(r'`[^`\n]*`', '', text)

def check_labels(f, text):
    raw = text
    text = strip_code(text)
    defs = re.findall(r'(?<![\w-])(?:tabel|gambar|kode|shot|console|pdm-page)\("([^"]+)"', text)
    seen = set()
    for d in defs:
        if d in seen:
            err(f, f'label ganda: {d}')
        seen.add(d)
    for d in seen:
        if not re.search(r'@' + re.escape(d) + r'(?![\w-])', text):
            err(f, f'label tidak dirujuk di teks: {d}')
    for m in re.finditer(r'@([\w-]+)', text):
        if m.group(1) not in seen and not m.group(1).startswith('http'):
            err(f, f'rujukan ke label yang tidak ada: @{m.group(1)}')

def check_stage(f, text):
    for m in re.finditer(r'stage:\s*([^\s,)]+)', text):
        if m.group(1) not in ALLOWED_STAGE:
            err(f, f'label tahap tidak dikenal: {m.group(1)}')

def sections(text):
    parts = re.split(r'(?=#sec\(")', text)
    out = []
    for p in parts:
        m = re.match(r'#sec\("([^"]*)",\s*"([^"]*)"', p)
        if not m:
            continue
        body = re.split(r'\n#(?:chapter|part|lamp)\(|\n#pagebreak|\n#pdm-page|\n// ====', p, maxsplit=1)[0]
        out.append((m.group(1), m.group(2), body))
    return out

def prose_words(body):
    lines = body.split('\n')[1:]
    in_code = False
    words = 0
    paras = 0
    cur = 0
    for ln in lines:
        st = ln.strip()
        if st.startswith('```'):
            in_code = not in_code
            continue
        if in_code:
            continue
        if not st:
            if cur >= 20:
                paras += 1
            cur = 0
            continue
        if st[0] in '#(){}[]/-|"' or ln.startswith('  '):
            continue
        txt = re.sub(r'[*_`#@\\]', '', st)
        n = len(txt.split())
        words += n
        cur += n
    if cur >= 20:
        paras += 1
    return words, paras

EXEMPT = {'4.6', '5.4', '5.5', '1.2'}

def check_style(f, text):
    plain = strip_code(text)
    for pat in STOCK:
        for m in re.finditer(pat, plain, flags=re.I):
            err(f, f'frasa klise: "{m.group(0)}"')
    n = len(re.findall(r'(?:^|[.!?]\s+)(?:Tabel|Gambar|Potongan kode) @[\w-]+ (?:memuat|menunjukkan|memperlihatkan|menggambarkan|berisi)', plain, flags=re.M))
    if n > 2:
        err(f, f'{n} kalimat berpola "Tabel/Gambar @x menunjukkan" (maksimal 2)')
    for m in re.finditer(OLD_API, text):
        err(f, f'memakai komponen lama: {m.group(0)}')
    body = plain.split('#part("Lampiran"')[0]
    nt = len(re.findall(r'#tabel\(', body))
    if nt > 14:
        err(f, f'{nt} tabel bernomor di Bab 1-5 (maksimal 14)')
    bold = len(re.findall(r'(?<![\w*])\*[^*\n]{2,80}\*(?![\w*])', plain))
    if bold > 40:
        err(f, f'{bold} teks tebal (maksimal 40)')
    for m in re.finditer(r'#lead\[(.*?)\]', plain, flags=re.S):
        if len(m.group(1).split()) > 50:
            err(f, 'ringkasan bab (lead) lebih dari 50 kata')

def check_example(f, text):
    check_banned(f, text)
    check_style(f, text)
    want = {'TI-Sem3': 'cover-sikap', 'TI-Sem5': 'cover-celah', 'SIB-Sem3': 'cover-cucik', 'SIB-Sem5': 'cover-kosku'}
    for key, fn in want.items():
        if key in os.path.basename(f) and f'#{fn}(' not in text:
            err(f, f'sampul harus memakai {fn}')
    if re.search(r'#cover\(', text):
        err(f, 'memakai sampul bersama #cover( (pakai sampul sendiri)')
    check_labels(f, text)
    check_stage(f, text)
    name = os.path.basename(f)
    for num, title, body in sections(text):
        if num.startswith('S.') or num == '' or num in EXEMPT:
            continue
        w, p = prose_words(body)
        if w < 70 or p < 2:
            err(f, f'bagian {num} {title}: prosa {w} kata, {p} paragraf (minimal 70 kata dan 2 paragraf)')
    # stack
    if 'SIB-Sem5' not in name and re.search(r'Laravel', text):
        err(f, 'menyebut Laravel di luar SIB Semester 5')
    for w in ['Tailwind', 'Pest', 'Pinia']:
        if re.search(r'\b' + w + r'\b', text):
            err(f, f'menyebut {w}')
    if 'MySQL' in text and 'TI-Sem3' not in name:
        err(f, 'menyebut MySQL')
    # wajib ada
    need = ['pdm-page(', 'gantt(', 'wire(', 'FR-01', 'NFR-01', 'SRS', 'Figma']
    need += ['kamus data']
    if 'SIB-Sem5' in name:
        need += ['Postman']
    for n in need:
        if n not in text:
            err(f, f'tidak memuat "{n}"')
    c = re.search(r'#lamp\("C", "Dokumen Rujukan".*?(?=#pagebreak|\Z)', text, re.S)
    if not c:
        err(f, 'Lampiran C bukan "Dokumen Rujukan"')
    else:
        for n in ['SRS', 'Figma', 'WBS']:
            if n not in c.group(0):
                err(f, f'Lampiran C tidak memuat dokumen rujukan "{n}"')
    if ('TI-Sem3' in name or 'SIB-Sem5' in name) and 'D.1' not in text:
        err(f, 'tidak memuat sub-lampiran D.1')
    e = re.search(r'#lamp\("E".*?(?=#pagebreak|\Z)', text, re.S)
    if not e:
        err(f, 'tidak ada Lampiran E')
    else:
        for n in ['SRS', 'Figma', 'WBS', 'example.com']:
            if n not in e.group(0):
                err(f, f'Lampiran E tidak memuat "{n}"')

def main(argv):
    targets = argv or (EXAMPLES + [LIB] + DOCS)
    for f in targets:
        f = os.path.abspath(f)
        text = read(f)
        if f in EXAMPLES or os.path.basename(f).startswith('Contoh-Laporan'):
            check_example(f, text)
        elif f.endswith('.md'):
            check_banned(f, text)
        else:
            check_banned(f, re.sub(r'(?m)^#let st-.*$', '', text))
    if errors:
        print('\n'.join(errors))
        print(f'\n{len(errors)} pelanggaran')
        return 1
    print('semua pemeriksaan lulus')
    return 0

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
