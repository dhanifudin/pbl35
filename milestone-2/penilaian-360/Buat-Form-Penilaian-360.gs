/**
 * Penilaian 360 PBL (Milestone 2): membuat form dan Rekap otomatis.
 *
 * Tujuan: mengumpulkan informasi lengkap tentang kontribusi nyata tiap anggota
 * (tim 4-6 orang) untuk memberi kredit dan memvalidasi kontribusi. Setiap anggota
 * menilai seluruh rekan DAN dirinya sendiri (360 derajat). Tidak ada pembatasan
 * privasi penilai: koordinator dan dosen dapat melihat siapa menilai siapa.
 *
 * Form ini TIDAK memakai daftar tim. Pengisi memilih kelas, mengetik nama tim, lalu
 * mengisi anggota satu per satu (termasuk dirinya sendiri) dengan mengetik nama.
 * Rekap mengenali tim dan anggota dari ketikan pengisi (tahan terhadap huruf besar
 * kecil, spasi, dan ejaan yang sedikit berbeda).
 *
 * Cara pakai (README-Penilaian-360.md memuat rincian):
 * 1. Buka https://script.google.com dengan akun Polinema koordinator, buat proyek baru.
 * 2. Tempel seluruh isi berkas ini dan cek BATAS_AKHIR.
 * 3. Jalankan buatFormPenilaian360 (beri izin). Tautan form, spreadsheet data mentah,
 *    dan spreadsheet Rekap muncul di Execution log.
 * 4. Jalankan pasangTrigger sekali agar Rekap terisi otomatis tiap ada tanggapan.
 * 5. Periksa penanda "Nama tim mirip" dan "Daftar anggota tidak konsisten" di Rekap Tim;
 *    perbaiki ejaan lewat ALIAS_TIM dan ALIAS_NAMA lalu jalankan hitungRekap.
 * 6. Jalankan salinPerKelas bila rekap perlu dibagikan per kelas kepada dosen.
 */

const BATAS_AKHIR = '27 November 2026, pukul 23.59 WIB';
const JUDUL_FORM = 'Penilaian 360 PBL (Milestone 2)';
const UKURAN_TIM = { min: 4, maks: 6 };

const KELAS = [
  'TI-2A', 'TI-2B', 'TI-2C', 'TI-2D', 'TI-2E', 'TI-2F', 'TI-2G', 'TI-2H', 'TI-2I',
  'TI-3A', 'TI-3B', 'TI-3C', 'TI-3D', 'TI-3E', 'TI-3F', 'TI-3G', 'TI-3H', 'TI-3I',
  'SIB-2A', 'SIB-2B', 'SIB-2C', 'SIB-2D', 'SIB-2E', 'SIB-2F', 'SIB-2G',
  'SIB-3A', 'SIB-3B', 'SIB-3C', 'SIB-3D', 'SIB-3E', 'SIB-3F', 'SIB-3G',
];

// Koreksi manual ejaan setelah dinormalkan (huruf kecil, tanpa tanda baca, satu spasi).
// Kiri: ejaan yang salah. Kanan: nama baku. Contoh: { 'tim jwa': 'Tim Jawa' }
const ALIAS_TIM = {};
const ALIAS_NAMA = {};

// Diri sendiri dihitung sama dengan satu penilai lain. Ubah bila koordinator ingin
// bobot lain (0 = penilaian diri tidak masuk Skor 360 dan Poin 360).
const BOBOT_DIRI = 1;

const AMBANG = {
  menonjol: 1.5,    // poin rekan > 1,5 x bagian adil (100/N)
  rendah: 0.5,      // poin rekan < 0,5 x bagian adil
  selisih: 15,      // selisih poin diri dan rekan
  uraianMin: 20,    // panjang minimal uraian pekerjaan (karakter)
  toleransiPoin: 0.5,
  pasifMin: 2,      // jumlah rekan yang menyebut seorang anggota hampir tidak berkontribusi
  miripNama: 0.8,   // kemiripan nama (0-1) untuk dianggap orang yang sama
  miripTim: 0.8,    // kemiripan nama tim dalam satu kelas untuk ditandai
};

const ASPEK = [
  ['Kontribusi pekerjaan', 'Seberapa besar dan baik pekerjaan yang diselesaikan.'],
  ['Tanggung jawab dan ketepatan waktu', 'Menyelesaikan tugas sesuai janji dan tenggat.'],
  ['Kerja sama dan komunikasi', 'Mudah diajak bekerja sama dan cepat membalas pesan tim.'],
  ['Kehadiran dan keterlibatan dalam rapat', 'Hadir dan ikut membahas dalam rapat tim.'],
];

// ===================================================================== membuat form

function buatFormPenilaian360() {
  const form = FormApp.create(JUDUL_FORM);

  form.setDescription(
    'Form ini mengumpulkan informasi tentang kontribusi nyata setiap anggota tim, untuk memberi kredit dan memvalidasi kontribusi. ' +
    'Anda mengisi anggota tim satu per satu, termasuk diri Anda sendiri (penilaian 360 derajat). ' +
    'Isi sendiri, jujur, dan jangan berdiskusi dengan rekan satu tim. Tulis juga pekerjaan konkret tiap orang beserta buktinya.\n\n' +
    'Hasil dilihat koordinator PBL dan dosen pengampu, termasuk siapa memberi penilaian apa. Rekan satu tim tidak melihat hasilnya.\n\n' +
    'Estimasi waktu sekitar 10 sampai 15 menit untuk tim 6 orang. Batas akhir: ' + BATAS_AKHIR + '. ' +
    'Jawaban dapat diubah sampai batas akhir lewat tautan "Edit jawaban".'
  );
  form.setCollectEmail(true);
  form.setLimitOneResponsePerUser(true);   // butuh login akun Google
  form.setAllowResponseEdits(true);
  form.setShowLinkToRespondAgain(false);
  form.setProgressBar(true);
  form.setConfirmationMessage(
    'Terima kasih. Penilaian Anda sudah tercatat dan dilihat koordinator PBL serta dosen pengampu. ' +
    'Jawaban dapat diubah sampai batas akhir lewat tautan "Edit jawaban".'
  );
  try { form.setRequireLogin(true); } catch (e) { /* hanya tersedia di akun Workspace */ }

  // Halaman identitas
  const kelasId = form.addListItem().setTitle('Kelas').setChoiceValues(KELAS).setRequired(true).getId();
  const timId = form.addTextItem().setTitle('Nama Tim')
    .setHelpText('Tulis persis seperti nama tim pada proposal. Semua anggota tim harus menulis nama tim yang sama.')
    .setRequired(true).getId();
  form.addSectionHeaderItem()
    .setTitle('Sebelum mulai')
    .setHelpText('Anda akan mengisi anggota tim satu per satu (minimal 4, maksimal 6), termasuk diri Anda sendiri. ' +
                 'Siapkan lebih dulu pembagian 100 poin kontribusi untuk seluruh anggota, karena poin diisi per anggota. ' +
                 'Ketik nama lengkap yang sama untuk setiap orang agar mudah dikenali.');

  // Halaman anggota 1 sampai 6
  const hal = [], slots = [], lanjut = {};
  const angka = FormApp.createTextValidation().setHelpText('Isi angka 0 sampai 100.').requireNumberBetween(0, 100).build();
  for (let k = 1; k <= UKURAN_TIM.maks; k++) {
    hal.push(form.addPageBreakItem().setTitle('Anggota ' + k)
      .setHelpText('Isi satu anggota tim di halaman ini. Bila anggota ini adalah Anda sendiri, pilih "Ya" pada pertanyaan kedua. ' +
                   'Semua isian wajib.'));
    const namaId = form.addTextItem().setTitle('Nama anggota ke-' + k + ' (nama lengkap)').setRequired(true).getId();
    const diriId = form.addMultipleChoiceItem().setTitle('Apakah anggota ini adalah Anda sendiri?')
      .setChoiceValues(['Ya, ini saya', 'Bukan, ini rekan saya']).setRequired(true).getId();
    const gridId = form.addGridItem().setTitle('Penilaian anggota ke-' + k)
      .setHelpText('1 = sangat kurang, 5 = sangat baik.')
      .setRows(ASPEK.map(function (a) { return a[0]; }))
      .setColumns(['1', '2', '3', '4', '5']).setRequired(true).getId();
    const poinId = form.addTextItem().setTitle('Poin kontribusi anggota ke-' + k + ' (0 sampai 100)')
      .setHelpText('Bagikan 100 poin untuk seluruh anggota. Usahakan jumlahnya 100; bila tidak tepat 100, sistem menyesuaikan secara proporsional.')
      .setRequired(true).setValidation(angka).getId();
    const uraianId = form.addParagraphTextItem().setTitle('Apa saja yang dikerjakan anggota ke-' + k + '?')
      .setHelpText('Tulis tugas konkret dan buktinya (modul, halaman laporan, commit, dokumen). Bila ini Anda sendiri, tulis apa yang Anda kerjakan.')
      .setRequired(true).getId();
    slots.push({ namaId: namaId, diriId: diriId, gridId: gridId, poinId: poinId, uraianId: uraianId });
    if (k === UKURAN_TIM.min || k === UKURAN_TIM.min + 1) {
      lanjut[k] = form.addMultipleChoiceItem().setTitle('Apakah masih ada anggota berikutnya?').setRequired(true);
    }
  }

  // Halaman penutup
  const halPenutup = form.addPageBreakItem().setTitle('Penutup');
  const buktiId = form.addParagraphTextItem().setTitle('Bukti kontribusi Anda (opsional)')
    .setHelpText('Tautan commit, berkas, atau dokumen yang menunjukkan pekerjaan Anda.').getId();
  const terbaikId = form.addParagraphTextItem().setTitle('Siapa yang paling berkontribusi dalam tim, dan mengapa?')
    .setRequired(true).getId();
  const pasifId = form.addParagraphTextItem().setTitle('Adakah anggota yang hampir tidak berkontribusi? Jelaskan.')
    .setHelpText('Tulis nama dan alasannya. Bila tidak ada, tulis "Tidak ada".').setRequired(true).getId();
  const komentarId = form.addParagraphTextItem().setTitle('Komentar tambahan (opsional)')
    .setHelpText('Hal lain yang perlu diketahui koordinator.').getId();

  // Percabangan: setelah anggota ke-4 dan ke-5, tanyakan apakah ada anggota berikutnya
  [UKURAN_TIM.min, UKURAN_TIM.min + 1].forEach(function (k) {
    const q = lanjut[k];
    q.setChoices([
      q.createChoice('Ya, ada anggota ke-' + (k + 1), hal[k]),
      q.createChoice('Tidak, ini anggota terakhir', halPenutup),
    ]);
  });

  // Data mentah dan Rekap
  const mentah = SpreadsheetApp.create(JUDUL_FORM + ' - Data Mentah');
  form.setDestination(FormApp.DestinationType.SPREADSHEET, mentah.getId());
  const rekap = SpreadsheetApp.create('Rekap ' + JUDUL_FORM);

  PropertiesService.getScriptProperties().setProperties({
    FORM_ID: form.getId(), REKAP_ID: rekap.getId(), MENTAH_ID: mentah.getId(),
    STRUKTUR: JSON.stringify({ kelasId: kelasId, timId: timId, slots: slots, buktiId: buktiId,
                               terbaikId: terbaikId, pasifId: pasifId, komentarId: komentarId }),
  }, true);

  Logger.log('Form peserta   : ' + form.getPublishedUrl());
  Logger.log('Form edit      : ' + form.getEditUrl());
  Logger.log('Data mentah    : ' + mentah.getUrl() + '  (hanya koordinator)');
  Logger.log('Rekap          : ' + rekap.getUrl());
  Logger.log('Langkah berikutnya: jalankan pasangTrigger sekali.');
}

// ===================================================================== pengenalan tim dan nama (logika murni)

function adaAngka_(x) { return typeof x === 'number' && !isNaN(x); }

function rata_(arr) {
  const v = arr.filter(adaAngka_);
  return v.length ? v.reduce(function (a, b) { return a + b; }, 0) / v.length : null;
}

function bulat_(x, d) {
  if (!adaAngka_(x)) return '';
  const f = Math.pow(10, d === undefined ? 2 : d);
  return Math.round(x * f) / f;
}

function angkaPoin_(x) {
  const v = parseFloat(String(x === undefined || x === null ? '' : x).replace(',', '.'));
  return isNaN(v) ? 0 : v;
}

/** Nama lengkap disebut, atau nama depan disebut (hanya bila tidak ada anggota lain bernama depan sama). */
function menyebut_(teks, nama, semua) {
  const t = ' ' + normTeks_(teks) + ' ', n = normTeks_(nama);
  if (!n) return false;
  if (t.indexOf(' ' + n + ' ') >= 0) return true;
  const depan = n.split(' ')[0];
  const kembar = (semua || []).filter(function (x) { return normTeks_(x).split(' ')[0] === depan; }).length > 1;
  return depan.length >= 3 && !kembar && t.indexOf(' ' + depan + ' ') >= 0;
}

function tidakAda_(teks) {
  const t = String(teks || '').trim().toLowerCase();
  return t === '' || /^(tidak ada|tidak|nihil|-+|none)\.?$/.test(t);
}

function adaTautan_(teks) { return /https?:\/\//i.test(String(teks || '')); }

/** Huruf kecil, tanpa aksen dan tanda baca, satu spasi. */
function normTeks_(s) {
  return String(s === undefined || s === null ? '' : s).normalize('NFD').replace(/[̀-ͯ]/g, '')
    .toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();
}

function lev_(a, b) {
  const m = a.length, n = b.length;
  if (!m) return n;
  if (!n) return m;
  let prev = [], cur = [];
  for (let j = 0; j <= n; j++) prev[j] = j;
  for (let i = 1; i <= m; i++) {
    cur = [i];
    for (let j = 1; j <= n; j++) {
      cur[j] = Math.min(prev[j] + 1, cur[j - 1] + 1, prev[j - 1] + (a.charAt(i - 1) === b.charAt(j - 1) ? 0 : 1));
    }
    prev = cur;
  }
  return prev[n];
}

function mirip_(a, b) {
  const L = Math.max(a.length, b.length);
  return L ? 1 - lev_(a, b) / L : 1;
}

/** Sama bila: identik, semua kata nama yang lebih pendek termuat di nama yang lebih panjang
 *  (kata 1-2 huruf dianggap singkatan awalan), atau kemiripan ejaan tinggi. */
function samaNama_(na, nb) {
  if (!na || !nb) return false;
  if (na === nb) return true;
  const ta = na.split(' '), tb = nb.split(' ');
  const aPendek = na.length <= nb.length;
  const pendek = aPendek ? ta : tb, panjang = aPendek ? tb : ta;
  const termuat = pendek.every(function (s) {
    return panjang.some(function (l) { return l === s || (s.length <= 2 && l.indexOf(s) === 0); });
  });
  if (termuat) return true;
  return mirip_(na, nb) >= AMBANG.miripNama;
}

function paling_(daftar) {
  // ejaan asli yang paling sering; bila seri, yang paling panjang
  const hit = {};
  daftar.forEach(function (x) { hit[x] = (hit[x] || 0) + 1; });
  return Object.keys(hit).sort(function (a, b) { return hit[b] - hit[a] || b.length - a.length; })[0];
}

/**
 * Mengubah tanggapan mentah menjadi daftar tim dan tanggapan yang sejajar dengan daftar anggota baku.
 * @param {Array} raws [{kelas, tim, email, waktu, anggota:[{nama, diri, skor:[4], poin, uraian}], bukti, terbaik, pasif, komentar}]
 */
function susunTimDanTanggapan_(raws) {
  const grup = {};
  raws.forEach(function (r) {
    let n = normTeks_(r.tim);
    if (ALIAS_TIM[n]) n = normTeks_(ALIAS_TIM[n]);
    const kunci = r.kelas + '|' + n;
    (grup[kunci] = grup[kunci] || { kelas: r.kelas, normTim: n, resps: [] }).resps.push(r);
  });

  const timList = [], tanggapan = [];
  const kunciList = Object.keys(grup).sort();
  kunciList.forEach(function (kunci) {
    const g = grup[kunci];
    // Nama tim baku: ALIAS bila ada, kalau tidak ejaan paling sering
    const ejaanTim = g.resps.map(function (r) { return String(r.tim || '').trim(); });
    let namaTim = paling_(ejaanTim);
    Object.keys(ALIAS_TIM).forEach(function (k) { if (normTeks_(ALIAS_TIM[k]) === g.normTim) namaTim = ALIAS_TIM[k]; });
    const variasiTim = Object.keys(ejaanTim.reduce(function (o, e) { o[e] = 1; return o; }, {}))
      .filter(function (e) { return e !== namaTim; });

    // Kelompokkan nama anggota
    const entri = {};
    g.resps.forEach(function (r) {
      r.anggota.forEach(function (a) {
        let n = normTeks_(a.nama);
        if (ALIAS_NAMA[n]) n = normTeks_(ALIAS_NAMA[n]);
        if (!n) return;
        const e = entri[n] = entri[n] || { norm: n, asli: [], hitung: 0 };
        e.asli.push(String(ALIAS_NAMA[normTeks_(a.nama)] || a.nama).trim());
        e.hitung++;
      });
    });
    const urut = Object.keys(entri).map(function (k) { return entri[k]; })
      .sort(function (a, b) { return b.hitung - a.hitung || b.norm.length - a.norm.length; });
    const klaster = [], ambigu = [];
    urut.forEach(function (e) {
      const cocok = klaster.filter(function (c) { return samaNama_(e.norm, c.rep.norm); });
      if (cocok.length === 1) { cocok[0].anggota.push(e); }
      else if (cocok.length === 0) { klaster.push({ rep: e, anggota: [e] }); }
      else {
        ambigu.push(e.asli[0]);
        cocok.sort(function (a, b) { return mirip_(e.norm, b.rep.norm) - mirip_(e.norm, a.rep.norm); })[0].anggota.push(e);
      }
    });
    const nama = klaster.map(function (c) {
      return paling_([].concat.apply([], c.anggota.map(function (e) { return e.asli; })));
    });
    const petaNorm = {};
    klaster.forEach(function (c, i) { c.anggota.forEach(function (e) { petaNorm[e.norm] = i; }); });
    const variasiNama = [];
    klaster.forEach(function (c, i) {
      const lain = Object.keys(c.anggota.reduce(function (o, e) { e.asli.forEach(function (x) { o[x] = 1; }); return o; }, {}))
        .filter(function (x) { return x !== nama[i]; });
      if (lain.length) variasiNama.push(nama[i] + ' (ejaan lain: ' + lain.join(', ') + ')');
    });

    const penandaTim = [];
    if (nama.length > UKURAN_TIM.maks || nama.length < UKURAN_TIM.min) {
      penandaTim.push('Daftar anggota tidak konsisten (' + nama.length + ' nama berbeda)');
    }
    if (ambigu.length) penandaTim.push('Nama ambigu: ' + ambigu.join(', '));

    timList.push({ kelas: g.kelas, tim: namaTim, anggota: nama, penandaTim: penandaTim,
                   variasiTim: variasiTim.join(', '), variasiNama: variasiNama.join('; '), _normTim: g.normTim });

    g.resps.forEach(function (r) {
      const skor = ASPEK.map(function () { return nama.map(function () { return null; }); });
      const poin = nama.map(function () { return 0; });
      const uraian = nama.map(function () { return ''; });
      const terisi = {};
      const diri = [];
      let ganda = false;
      r.anggota.forEach(function (a) {
        let n = normTeks_(a.nama);
        if (ALIAS_NAMA[n]) n = normTeks_(ALIAS_NAMA[n]);
        const i = petaNorm[n];
        if (i === undefined) return;
        if (terisi[i]) ganda = true;
        terisi[i] = true;
        ASPEK.forEach(function (_, ai) { skor[ai][i] = a.skor && adaAngka_(a.skor[ai]) ? a.skor[ai] : null; });
        poin[i] = a.poin;
        uraian[i] = a.uraian;
        if (a.diri) diri.push(i);
      });
      const tambahan = [];
      if (diri.length !== 1) tambahan.push('Penanda diri tidak tepat');
      if (Object.keys(terisi).length < nama.length) tambahan.push('Penilaian tidak lengkap');
      if (ganda) tambahan.push('Anggota ganda dalam satu tanggapan');
      tanggapan.push({
        kelas: g.kelas, tim: namaTim, penilai: diri.length ? nama[diri[0]] : '(tidak diketahui)',
        email: r.email || '', waktu: r.waktu, skor: skor, poin: poin, uraian: uraian,
        bukti: r.bukti || '', terbaik: r.terbaik || '', pasif: r.pasif || '', komentar: r.komentar || '',
        penandaTambahan: tambahan,
      });
    });
  });

  // Tandai nama tim yang mirip dalam satu kelas
  timList.forEach(function (a, i) {
    timList.forEach(function (b, j) {
      if (j <= i || a.kelas !== b.kelas) return;
      const bersama = a.anggota.filter(function (x) {
        return b.anggota.some(function (y) { return normTeks_(x) === normTeks_(y); });
      }).length;
      const mir = mirip_(a._normTim, b._normTim) >= AMBANG.miripTim || bersama >= Math.max(2, Math.ceil(Math.min(a.anggota.length, b.anggota.length) / 2));
      if (mir) {
        a.penandaTim.push('Nama tim mirip: ' + b.tim);
        b.penandaTim.push('Nama tim mirip: ' + a.tim);
      }
    });
  });
  return { timList: timList, tanggapan: tanggapan };
}

// ===================================================================== rekap (logika murni)

/**
 * @param {Array} timList  [{kelas, tim, anggota:[nama,...], penandaTim:[], variasiTim, variasiNama}]
 * @param {Array} tanggapan [{kelas, tim, penilai, email, waktu, skor:[[1-5 per anggota] x4],
 *                            poin:[..per anggota], uraian:[..per anggota], bukti, terbaik, pasif, komentar,
 *                            penandaTambahan:[]}]
 */
function hitungRekapData_(timList, tanggapan) {
  const rekapMhs = [], rincian = [], rekapTim = [], rangkuman = [];

  timList.forEach(function (t) {
    const N = t.anggota.length;
    const resps = tanggapan.filter(function (r) { return r.kelas === t.kelas && r.tim === t.tim; });
    const hitungPenilai = {};
    resps.forEach(function (r) { hitungPenilai[r.penilai] = (hitungPenilai[r.penilai] || 0) + 1; });

    const rows = [];
    let poinBukan100 = 0;
    resps.forEach(function (r) {
      const p = t.anggota.map(function (_, i) { return angkaPoin_(r.poin[i]); });
      const jumlah = p.reduce(function (a, b) { return a + b; }, 0);
      const norm = p.map(function (v) { return jumlah > 0 ? v / jumlah * 100 : null; });
      const semuaSkor = [].concat.apply([], r.skor).filter(adaAngka_);
      const penanda = (r.penandaTambahan || []).slice();
      if (Math.abs(jumlah - 100) > AMBANG.toleransiPoin) { penanda.push('Poin dinormalkan'); poinBukan100++; }
      if (semuaSkor.length && semuaSkor.every(function (v) { return v === semuaSkor[0]; })) penanda.push('Skor seragam');
      if (N > 1 && p.every(function (v) { return v === p[0]; })) penanda.push('Poin sama rata');
      if (hitungPenilai[r.penilai] > 1) penanda.push('Nama ganda');
      t.anggota.forEach(function (nama, i) {
        rows.push({
          kelas: t.kelas, tim: t.tim, penilai: r.penilai, email: r.email || '', dinilai: nama,
          jenis: r.penilai === nama ? 'Diri' : 'Rekan',
          skor: ASPEK.map(function (_, a) { return r.skor[a] ? (r.skor[a][i] === undefined ? null : r.skor[a][i]) : null; }),
          poinAsli: p[i], poinNorm: norm[i], uraian: String(r.uraian[i] || '').trim(),
          penanda: penanda.join('; '), bukti: r.bukti || '',
        });
      });
    });
    rows.forEach(function (x) { rincian.push(x); });

    const mhsTim = t.anggota.map(function (nama) {
      const baris = rows.filter(function (x) { return x.dinilai === nama; });
      const diri = baris.filter(function (x) { return x.jenis === 'Diri'; });
      const rekan = baris.filter(function (x) { return x.jenis === 'Rekan'; });
      const rerataAsp = function (set, a) { return rata_(set.map(function (x) { return x.skor[a]; })); };
      const rerataTotal = function (set) { return rata_(set.map(function (x) { return rata_(x.skor); })); };
      const bobot = function (x) { return x.jenis === 'Diri' ? BOBOT_DIRI : 1; };
      let sw = 0, sk = 0, sp = 0, swp = 0;
      baris.forEach(function (x) {
        const w = bobot(x), tot = rata_(x.skor);
        if (adaAngka_(tot)) { sk += w * tot; sw += w; }
        if (adaAngka_(x.poinNorm)) { sp += w * x.poinNorm; swp += w; }
      });
      const poinDiri = rata_(diri.map(function (x) { return x.poinNorm; }));
      const poinRekan = rata_(rekan.map(function (x) { return x.poinNorm; }));
      const uraianNama = baris.map(function (x) { return x.uraian; });
      const bukti = (diri.length ? diri[0].bukti : '');
      const disebutPasif = resps.filter(function (r) {
        return r.penilai !== nama && !tidakAda_(r.pasif) && menyebut_(r.pasif, nama, t.anggota);
      }).length;
      const disebutTerbaik = resps.filter(function (r) { return r.penilai !== nama && menyebut_(r.terbaik, nama, t.anggota); }).length;
      const bagianAdil = 100 / N;
      const penanda = [];
      if (!resps.some(function (r) { return r.penilai === nama; })) penanda.push('Belum mengisi');
      if (adaAngka_(poinRekan) && poinRekan > AMBANG.menonjol * bagianAdil) penanda.push('Menonjol');
      if (adaAngka_(poinRekan) && poinRekan < AMBANG.rendah * bagianAdil) penanda.push('Rendah');
      if (adaAngka_(poinDiri) && adaAngka_(poinRekan)) {
        const sel = poinDiri - poinRekan;
        if (sel > AMBANG.selisih) penanda.push('Menilai diri tinggi');
        if (sel < -AMBANG.selisih) penanda.push('Menilai diri rendah');
      }
      if (disebutPasif >= AMBANG.pasifMin) penanda.push('Dituduh pasif');
      const pendek = uraianNama.filter(function (u) { return u.length < AMBANG.uraianMin; }).length;
      if (baris.length && pendek > 0) penanda.push('Uraian pendek (' + pendek + ')');
      if (baris.length && !adaTautan_(bukti) && !uraianNama.some(adaTautan_)) penanda.push('Tanpa bukti');
      return {
        kelas: t.kelas, tim: t.tim, nama: nama,
        mengisi: resps.some(function (r) { return r.penilai === nama; }) ? 'Ya' : 'Belum',
        nilaiDiri: rerataTotal(diri), poinDiri: poinDiri,
        nRekan: rekan.length ? new Set(rekan.map(function (x) { return x.penilai; })).size : 0,
        rekanAsp: ASPEK.map(function (_, a) { return rerataAsp(rekan, a); }),
        rekanTotal: rerataTotal(rekan), poinRekan: poinRekan,
        skor360: sw > 0 ? sk / sw : null,
        poin360Mentah: swp > 0 ? sp / swp : null,
        selisih: adaAngka_(poinDiri) && adaAngka_(poinRekan) ? poinDiri - poinRekan : null,
        disebutTerbaik: disebutTerbaik, disebutPasif: disebutPasif, penanda: penanda,
      };
    });

    // Skala Poin 360 antar anggota agar jumlahnya 100
    const totalMentah = mhsTim.reduce(function (a, m) { return a + (adaAngka_(m.poin360Mentah) ? m.poin360Mentah : 0); }, 0);
    mhsTim.forEach(function (m) { m.poin360 = totalMentah > 0 && adaAngka_(m.poin360Mentah) ? m.poin360Mentah / totalMentah * 100 : null; });
    mhsTim.forEach(function (m) {
      m.peringkat = adaAngka_(m.poin360)
        ? 1 + mhsTim.filter(function (o) { return adaAngka_(o.poin360) && o.poin360 > m.poin360 + 1e-9; }).length : '';
      rekapMhs.push(m);
    });

    mhsTim.forEach(function (m) {
      rows.filter(function (x) { return x.dinilai === m.nama; }).forEach(function (x) {
        rangkuman.push({ kelas: t.kelas, tim: t.tim, nama: m.nama, sumber: x.penilai, jenis: x.jenis, uraian: x.uraian,
                         bukti: x.jenis === 'Diri' ? x.bukti : '' });
      });
    });

    const pengisi = Object.keys(hitungPenilai).filter(function (n) { return t.anggota.indexOf(n) >= 0; });
    const penandaTim = (t.penandaTim || []).slice();
    if (pengisi.length < Math.ceil(N / 2)) penandaTim.push('Penilai kurang');
    if (Object.keys(hitungPenilai).some(function (n) { return hitungPenilai[n] > 1; })) penandaTim.push('Nama ganda');
    rekapTim.push({
      kelas: t.kelas, tim: t.tim, ukuran: N, pengisi: pengisi.length, tanggapan: resps.length,
      belum: t.anggota.filter(function (n) { return pengisi.indexOf(n) < 0; }).join(', '),
      terbaik: resps.map(function (r) { return r.penilai + ': ' + String(r.terbaik || '').trim(); }).join(' | '),
      pasif: resps.map(function (r) { return r.penilai + ': ' + String(r.pasif || '').trim(); }).join(' | '),
      poinBukan100: poinBukan100, variasiTim: t.variasiTim || '', variasiNama: t.variasiNama || '',
      penanda: penandaTim.join('; '),
    });
  });
  return { rekapMhs: rekapMhs, rincian: rincian, rekapTim: rekapTim, rangkuman: rangkuman };
}

// ===================================================================== rekap (spreadsheet)

const PENANDA = [
  ['Menonjol', 'Poin dari rekan lebih dari 1,5 kali bagian adil (100 dibagi jumlah anggota).'],
  ['Rendah', 'Poin dari rekan kurang dari 0,5 kali bagian adil.'],
  ['Menilai diri tinggi / rendah', 'Poin diri lebih tinggi / lebih rendah dari rerata poin rekan lebih dari 15 poin.'],
  ['Dituduh pasif', 'Dua rekan atau lebih menyebut anggota ini hampir tidak berkontribusi.'],
  ['Uraian pendek (n)', 'Ada n uraian pekerjaan tentang anggota ini yang kurang dari 20 karakter.'],
  ['Tanpa bukti', 'Tidak ada tautan bukti dari anggota itu sendiri dan tidak ada uraian tentangnya yang memuat tautan.'],
  ['Belum mengisi', 'Anggota ini belum mengirim penilaian.'],
  ['Poin dinormalkan', '(Rincian Penilai) Jumlah poin penilai tidak 100; poin disesuaikan secara proporsional ke 100.'],
  ['Skor seragam', '(Rincian Penilai) Penilai memberi nilai sama ke semua baris di semua kisi.'],
  ['Poin sama rata', '(Rincian Penilai) Penilai membagi poin sama untuk semua anggota.'],
  ['Penanda diri tidak tepat', '(Rincian Penilai) Jumlah halaman anggota yang ditandai "ini saya" bukan tepat satu.'],
  ['Penilaian tidak lengkap', '(Rincian Penilai) Penilai tidak menilai semua anggota yang dikenali dalam tim.'],
  ['Anggota ganda dalam satu tanggapan', '(Rincian Penilai) Dua halaman anggota dikenali sebagai orang yang sama.'],
  ['Nama ganda', 'Dua tanggapan memakai nama pengisi yang sama.'],
  ['Penilai kurang', '(Rekap Tim) Pengisi kurang dari separuh anggota tim.'],
  ['Daftar anggota tidak konsisten (n nama berbeda)', '(Rekap Tim) Jumlah nama berbeda di luar rentang 4-6; biasanya salah ketik. Koreksi lewat ALIAS_NAMA.'],
  ['Nama tim mirip: X', '(Rekap Tim) Nama tim hampir sama atau anggotanya banyak yang sama dengan tim X. Gabungkan lewat ALIAS_TIM bila itu tim yang sama.'],
  ['Nama ambigu: X', '(Rekap Tim) Nama X cocok dengan lebih dari satu anggota; periksa apakah ada dua orang dengan nama depan sama.'],
];

function sheet_(ss, nama) {
  const s = ss.getSheetByName(nama) || ss.insertSheet(nama);
  s.clear();
  return s;
}

function tulis_(ss, nama, header, baris) {
  const s = sheet_(ss, nama);
  const data = [header].concat(baris);
  s.getRange(1, 1, data.length, header.length).setValues(data);
  s.getRange(1, 1, 1, header.length).setFontWeight('bold').setBackground('#e8f0fe');
  s.setFrozenRows(1);
  s.autoResizeColumns(1, header.length);
}

function tulisRekap_(ss, hasil) {
  tulis_(ss, 'Rekap Mahasiswa',
    ['Kelas', 'Tim', 'Nama', 'Mengisi', 'Nilai diri (rerata 4 aspek)', 'Poin diri', 'Jumlah penilai rekan',
     ASPEK[0][0] + ' (rekan)', ASPEK[1][0] + ' (rekan)', ASPEK[2][0] + ' (rekan)', ASPEK[3][0] + ' (rekan)',
     'Rerata rekan (4 aspek)', 'Poin rekan', 'Skor 360', 'Poin 360', 'Selisih poin diri-rekan', 'Peringkat dalam tim',
     'Disebut paling berkontribusi (rekan)', 'Disebut pasif (rekan)', 'Penanda'],
    hasil.rekapMhs.map(function (m) {
      return [m.kelas, m.tim, m.nama, m.mengisi, bulat_(m.nilaiDiri), bulat_(m.poinDiri, 1), m.nRekan]
        .concat(m.rekanAsp.map(function (x) { return bulat_(x); }))
        .concat([bulat_(m.rekanTotal), bulat_(m.poinRekan, 1), bulat_(m.skor360), bulat_(m.poin360, 1), bulat_(m.selisih, 1),
                 m.peringkat, m.disebutTerbaik, m.disebutPasif, m.penanda.join('; ')]);
    }));
  tulis_(ss, 'Rincian Penilai',
    ['Kelas', 'Tim', 'Penilai', 'Email', 'Dinilai', 'Jenis', ASPEK[0][0], ASPEK[1][0], ASPEK[2][0], ASPEK[3][0],
     'Poin asli', 'Poin dinormalkan', 'Uraian pekerjaan', 'Penanda penilai'],
    hasil.rincian.map(function (x) {
      return [x.kelas, x.tim, x.penilai, x.email, x.dinilai, x.jenis]
        .concat(x.skor.map(function (v) { return adaAngka_(v) ? v : ''; }))
        .concat([x.poinAsli, bulat_(x.poinNorm, 1), x.uraian, x.penanda]);
    }));
  tulis_(ss, 'Rangkuman Pekerjaan',
    ['Kelas', 'Tim', 'Nama', 'Ditulis oleh', 'Jenis', 'Uraian pekerjaan', 'Bukti (dari diri sendiri)'],
    hasil.rangkuman.map(function (x) { return [x.kelas, x.tim, x.nama, x.sumber, x.jenis, x.uraian, x.bukti]; }));
  tulis_(ss, 'Rekap Tim',
    ['Kelas', 'Tim', 'Jumlah anggota dikenali', 'Jumlah pengisi', 'Jumlah tanggapan', 'Belum mengisi',
     'Paling berkontribusi (menurut penilai)', 'Hampir tidak berkontribusi (menurut penilai)',
     'Tanggapan dengan poin bukan 100', 'Ejaan lain nama tim', 'Ejaan lain nama anggota', 'Penanda'],
    hasil.rekapTim.map(function (x) {
      return [x.kelas, x.tim, x.ukuran, x.pengisi, x.tanggapan, x.belum, x.terbaik, x.pasif, x.poinBukan100,
              x.variasiTim, x.variasiNama, x.penanda];
    }));
  tulis_(ss, 'Penanda', ['Penanda', 'Arti'], PENANDA);
  ['Sheet1', 'Sheet 1', 'Lembar1', 'Lembar 1'].forEach(function (n) {
    const awal = ss.getSheetByName(n);
    if (awal && ss.getSheets().length > 1) ss.deleteSheet(awal);
  });
}

function muatStruktur_() {
  const p = PropertiesService.getScriptProperties();
  return { formId: p.getProperty('FORM_ID'), rekapId: p.getProperty('REKAP_ID'),
           struktur: JSON.parse(p.getProperty('STRUKTUR')) };
}

function bacaTanggapan_(form, s) {
  return form.getResponses().map(function (resp) {
    const peta = {};
    resp.getItemResponses().forEach(function (ir) { peta[ir.getItem().getId()] = ir.getResponse(); });
    if (peta[s.kelasId] === undefined) return null;
    const teks = function (id) { return peta[id] === undefined || peta[id] === null ? '' : peta[id]; };
    const anggota = [];
    s.slots.forEach(function (sl) {
      const nama = String(teks(sl.namaId)).trim();
      if (!nama) return;
      anggota.push({
        nama: nama,
        diri: String(teks(sl.diriId)).indexOf('Ya') === 0,
        skor: (peta[sl.gridId] || []).map(function (v) { const n = parseInt(v, 10); return isNaN(n) ? null : n; }),
        poin: teks(sl.poinId), uraian: teks(sl.uraianId),
      });
    });
    return { kelas: peta[s.kelasId], tim: teks(s.timId), email: resp.getRespondentEmail(), waktu: resp.getTimestamp(),
             anggota: anggota, bukti: teks(s.buktiId), terbaik: teks(s.terbaikId), pasif: teks(s.pasifId),
             komentar: teks(s.komentarId) };
  }).filter(Boolean);
}

function hitungRekap() {
  const s = muatStruktur_();
  const form = FormApp.openById(s.formId);
  const susun = susunTimDanTanggapan_(bacaTanggapan_(form, s.struktur));
  const hasil = hitungRekapData_(susun.timList, susun.tanggapan);
  tulisRekap_(SpreadsheetApp.openById(s.rekapId), hasil);
  return hasil;
}

/** Jalankan sekali: Rekap diperbarui otomatis setiap ada tanggapan baru. */
function pasangTrigger() {
  const s = muatStruktur_();
  ScriptApp.getProjectTriggers().filter(function (t) { return t.getHandlerFunction() === 'hitungRekap'; })
    .forEach(function (t) { ScriptApp.deleteTrigger(t); });
  ScriptApp.newTrigger('hitungRekap').forForm(FormApp.openById(s.formId)).onFormSubmit().create();
  hitungRekap();
  Logger.log('Pemicu terpasang. Rekap: ' + SpreadsheetApp.openById(s.rekapId).getUrl());
}

/** Membuat satu spreadsheet rekap per kelas untuk dibagikan baca-saja ke dosen kelas itu. */
function salinPerKelas() {
  const hasil = hitungRekap();
  const kelas = {};
  hasil.rekapTim.forEach(function (x) { kelas[x.kelas] = true; });
  Object.keys(kelas).sort().forEach(function (k) {
    const per = function (a) { return a.filter(function (x) { return x.kelas === k; }); };
    const ss = SpreadsheetApp.create('Rekap Penilaian 360 PBL - ' + k);
    tulisRekap_(ss, { rekapMhs: per(hasil.rekapMhs), rincian: per(hasil.rincian), rekapTim: per(hasil.rekapTim), rangkuman: per(hasil.rangkuman) });
    Logger.log(k + ': ' + ss.getUrl());
  });
}

if (typeof module !== 'undefined') {
  module.exports = { susunTimDanTanggapan_: susunTimDanTanggapan_, hitungRekapData_: hitungRekapData_, AMBANG: AMBANG,
                     normTeks_: normTeks_, samaNama_: samaNama_ };
}
