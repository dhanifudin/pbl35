/**
 * Penilaian 360 PBL (Milestone 2): membuat form dan Rekap otomatis.
 *
 * Tujuan: mengumpulkan informasi lengkap tentang kontribusi nyata tiap anggota
 * (tim 4-6 orang) untuk memberi kredit dan memvalidasi kontribusi. Setiap anggota
 * menilai seluruh rekan DAN dirinya sendiri (360 derajat). Tidak ada pembatasan
 * privasi penilai: koordinator dan dosen dapat melihat siapa menilai siapa.
 *
 * Cara pakai (README-Penilaian-360.md memuat rincian):
 * 1. Buka https://script.google.com dengan akun Polinema koordinator, buat proyek baru.
 * 2. Tempel seluruh isi berkas ini, ganti DAFTAR_TIM dan BATAS_AKHIR.
 * 3. Jalankan buatFormPenilaian360 (beri izin). Tautan form, spreadsheet data mentah,
 *    dan spreadsheet Rekap muncul di Execution log.
 * 4. Jalankan pasangTrigger sekali agar Rekap terisi otomatis tiap ada tanggapan.
 * 5. Jalankan salinPerKelas bila rekap perlu dibagikan per kelas kepada dosen.
 */

// Satu baris per anggota: Kelas;Tim;Nama Anggota (pisah dengan titik koma).
// Contoh di bawah fiktif, ganti seluruhnya dengan daftar tim sebenarnya.
const DAFTAR_TIM = `
TI-2A;Tim Contoh Satu;Anggota A1
TI-2A;Tim Contoh Satu;Anggota A2
TI-2A;Tim Contoh Satu;Anggota A3
TI-2A;Tim Contoh Satu;Anggota A4
TI-2A;Tim Contoh Satu;Anggota A5
SIB-3C;Tim Contoh Dua;Anggota B1
SIB-3C;Tim Contoh Dua;Anggota B2
SIB-3C;Tim Contoh Dua;Anggota B3
SIB-3C;Tim Contoh Dua;Anggota B4
`;

const BATAS_AKHIR = '27 November 2026, pukul 23.59 WIB';
const JUDUL_FORM = 'Penilaian 360 PBL (Milestone 2)';
const UKURAN_TIM = { min: 4, maks: 6 };

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
};

const ASPEK = [
  ['Kontribusi pekerjaan', 'Seberapa besar dan baik pekerjaan yang diselesaikan.'],
  ['Tanggung jawab dan ketepatan waktu', 'Menyelesaikan tugas sesuai janji dan tenggat.'],
  ['Kerja sama dan komunikasi', 'Mudah diajak bekerja sama dan cepat membalas pesan tim.'],
  ['Kehadiran dan keterlibatan dalam rapat', 'Hadir dan ikut membahas dalam rapat tim.'],
];

// ===================================================================== daftar tim

function bacaDaftarTim_() {
  const hasil = {}; // kelas -> tim -> [anggota]
  DAFTAR_TIM.split('\n').map(function (s) { return s.trim(); }).filter(Boolean).forEach(function (baris) {
    const p = baris.split(';').map(function (s) { return s.trim(); });
    if (p.length < 3 || !p[0] || !p[1] || !p[2]) throw new Error('Baris tidak lengkap: ' + baris);
    hasil[p[0]] = hasil[p[0]] || {};
    hasil[p[0]][p[1]] = hasil[p[0]][p[1]] || [];
    hasil[p[0]][p[1]].push(p[2]);
  });
  Object.keys(hasil).forEach(function (k) {
    Object.keys(hasil[k]).forEach(function (t) {
      const n = hasil[k][t].length;
      if (n < 2) throw new Error('Tim ' + t + ' (' + k + ') harus punya minimal 2 anggota');
      if (n < UKURAN_TIM.min || n > UKURAN_TIM.maks) {
        Logger.log('PERINGATAN: tim ' + t + ' (' + k + ') beranggota ' + n + ', di luar rentang ' +
                   UKURAN_TIM.min + '-' + UKURAN_TIM.maks + '.');
      }
    });
  });
  return hasil;
}

// ===================================================================== membuat form

function buatFormPenilaian360() {
  const data = bacaDaftarTim_();
  const kelasList = Object.keys(data).sort();
  const form = FormApp.create(JUDUL_FORM);

  form.setDescription(
    'Form ini mengumpulkan informasi tentang kontribusi nyata setiap anggota tim, untuk memberi kredit dan memvalidasi kontribusi. ' +
    'Anda menilai seluruh rekan satu tim DAN diri Anda sendiri (penilaian 360 derajat). ' +
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

  // Bagian 1: kelas
  const qKelas = form.addListItem().setTitle('Kelas').setRequired(true);

  // Bagian kelas: pilih tim
  const halKelas = {}, qTim = {};
  kelasList.forEach(function (k) {
    halKelas[k] = form.addPageBreakItem().setTitle('Kelas ' + k).setHelpText('Pilih nama tim Anda.');
    qTim[k] = form.addListItem().setTitle('Nama Tim').setRequired(true);
  });

  // Bagian tim: satu per tim
  const halTim = {};
  const strukturTim = [];
  kelasList.forEach(function (k) {
    Object.keys(data[k]).sort().forEach(function (tim) {
      const anggota = data[k][tim];
      const hal = form.addPageBreakItem()
        .setTitle(tim + ' (' + k + ')')
        .setHelpText('Nilai seluruh anggota tim, termasuk diri Anda sendiri. Skala 1 (sangat kurang) sampai 5 (sangat baik). ' +
                     'Semua bagian wajib diisi, kecuali yang tertulis opsional.')
        .setGoToPage(FormApp.PageNavigationType.SUBMIT);
      halTim[k + '|' + tim] = hal;

      const namaAnda = form.addListItem().setTitle('Nama Anda').setChoiceValues(anggota).setRequired(true);

      const gridIds = ASPEK.map(function (a) {
        return form.addGridItem()
          .setTitle(a[0])
          .setHelpText(a[1] + ' Nilai semua anggota, termasuk diri Anda. 1 = sangat kurang, 5 = sangat baik.')
          .setRows(anggota)
          .setColumns(['1', '2', '3', '4', '5'])
          .setRequired(true).getId();
      });

      form.addSectionHeaderItem()
        .setTitle('Pembagian 100 poin kontribusi')
        .setHelpText('Bagikan 100 poin kepada seluruh anggota, termasuk diri Anda. Usahakan jumlahnya tepat 100; ' +
                     'bila tidak tepat 100, sistem menyesuaikan secara proporsional. Anggota yang berkontribusi lebih besar mendapat poin lebih banyak.');
      const angka = FormApp.createTextValidation()
        .setHelpText('Isi angka 0 sampai 100.')
        .requireNumberBetween(0, 100)
        .build();
      const poinIds = {};
      anggota.forEach(function (nama) {
        poinIds[nama] = form.addTextItem().setTitle('Poin untuk ' + nama)
          .setHelpText('Bila ini nama Anda sendiri, isi poin untuk diri Anda.')
          .setRequired(true).setValidation(angka).getId();
      });

      form.addSectionHeaderItem()
        .setTitle('Uraian pekerjaan tiap anggota')
        .setHelpText('Tulis tugas konkret yang benar-benar dikerjakan setiap orang dan buktinya (misalnya modul, halaman laporan, commit, dokumen). ' +
                     'Uraian ini dipakai dosen untuk memvalidasi kontribusi.');
      const uraianIds = {};
      anggota.forEach(function (nama) {
        uraianIds[nama] = form.addParagraphTextItem().setTitle('Apa saja yang dikerjakan ' + nama + '?')
          .setHelpText('Bila ini nama Anda sendiri, tulis apa yang Anda kerjakan. Sebutkan tugas konkret dan buktinya.')
          .setRequired(true).getId();
      });

      const buktiId = form.addParagraphTextItem().setTitle('Bukti kontribusi Anda (opsional)')
        .setHelpText('Tautan commit, berkas, atau dokumen yang menunjukkan pekerjaan Anda.').getId();
      const terbaikId = form.addParagraphTextItem().setTitle('Siapa yang paling berkontribusi dalam tim, dan mengapa?')
        .setRequired(true).getId();
      const pasifId = form.addParagraphTextItem().setTitle('Adakah anggota yang hampir tidak berkontribusi? Jelaskan.')
        .setHelpText('Tulis nama dan alasannya. Bila tidak ada, tulis "Tidak ada".').setRequired(true).getId();
      const komentarId = form.addParagraphTextItem().setTitle('Komentar tambahan (opsional)')
        .setHelpText('Hal lain yang perlu diketahui koordinator.').getId();

      strukturTim.push({
        kelas: k, tim: tim, anggota: anggota,
        namaAndaId: namaAnda.getId(), gridIds: gridIds, poinIds: poinIds, uraianIds: uraianIds,
        buktiId: buktiId, terbaikId: terbaikId, pasifId: pasifId, komentarId: komentarId,
      });
    });
  });

  // Hubungkan pilihan ke bagian
  qKelas.setChoices(kelasList.map(function (k) { return qKelas.createChoice(k, halKelas[k]); }));
  kelasList.forEach(function (k) {
    const q = qTim[k];
    q.setChoices(Object.keys(data[k]).sort().map(function (tim) {
      return q.createChoice(tim, halTim[k + '|' + tim]);
    }));
  });

  // Data mentah dan Rekap
  const mentah = SpreadsheetApp.create(JUDUL_FORM + ' - Data Mentah');
  form.setDestination(FormApp.DestinationType.SPREADSHEET, mentah.getId());
  const rekap = SpreadsheetApp.create('Rekap ' + JUDUL_FORM);

  const props = { FORM_ID: form.getId(), REKAP_ID: rekap.getId(), MENTAH_ID: mentah.getId(), INDEKS: JSON.stringify(strukturTim.map(function (_, i) { return 'T' + i; })) };
  strukturTim.forEach(function (t, i) { props['T' + i] = JSON.stringify(t); });
  PropertiesService.getScriptProperties().setProperties(props, true);

  Logger.log('Form peserta   : ' + form.getPublishedUrl());
  Logger.log('Form edit      : ' + form.getEditUrl());
  Logger.log('Data mentah    : ' + mentah.getUrl() + '  (hanya koordinator)');
  Logger.log('Rekap          : ' + rekap.getUrl());
  Logger.log('Langkah berikutnya: jalankan pasangTrigger sekali.');
}

// ===================================================================== rekap (logika murni)

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

function menyebut_(teks, nama) {
  return String(teks || '').toLowerCase().indexOf(String(nama).toLowerCase()) >= 0;
}

function tidakAda_(teks) {
  const t = String(teks || '').trim().toLowerCase();
  return t === '' || /^(tidak ada|tidak|nihil|-+|none)\.?$/.test(t);
}

function adaTautan_(teks) { return /https?:\/\//i.test(String(teks || '')); }

/**
 * @param {Array} timList  [{kelas, tim, anggota:[nama,...]}]
 * @param {Array} tanggapan [{kelas, tim, penilai, email, waktu, skor:[[1-5 per anggota] x4],
 *                            poin:[..per anggota], uraian:[..per anggota], bukti, terbaik, pasif, komentar}]
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
      const penanda = [];
      if (Math.abs(jumlah - 100) > AMBANG.toleransiPoin) { penanda.push('Poin dinormalkan'); poinBukan100++; }
      if (semuaSkor.length && semuaSkor.every(function (v) { return v === semuaSkor[0]; })) penanda.push('Skor seragam');
      if (N > 1 && p.every(function (v) { return v === p[0]; })) penanda.push('Poin sama rata');
      if (hitungPenilai[r.penilai] > 1) penanda.push('Nama ganda');
      if (t.anggota.indexOf(r.penilai) < 0) penanda.push('Penilai bukan anggota');
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
        return r.penilai !== nama && !tidakAda_(r.pasif) && menyebut_(r.pasif, nama);
      }).length;
      const disebutTerbaik = resps.filter(function (r) { return r.penilai !== nama && menyebut_(r.terbaik, nama); }).length;
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
    const penandaTim = [];
    if (pengisi.length < Math.ceil(N / 2)) penandaTim.push('Penilai kurang');
    if (Object.keys(hitungPenilai).some(function (n) { return hitungPenilai[n] > 1; })) penandaTim.push('Nama ganda');
    if (N < UKURAN_TIM.min || N > UKURAN_TIM.maks) penandaTim.push('Ukuran tim di luar ' + UKURAN_TIM.min + '-' + UKURAN_TIM.maks);
    rekapTim.push({
      kelas: t.kelas, tim: t.tim, ukuran: N, pengisi: pengisi.length,
      belum: t.anggota.filter(function (n) { return pengisi.indexOf(n) < 0; }).join(', '),
      terbaik: resps.map(function (r) { return r.penilai + ': ' + String(r.terbaik || '').trim(); }).join(' | '),
      pasif: resps.map(function (r) { return r.penilai + ': ' + String(r.pasif || '').trim(); }).join(' | '),
      poinBukan100: poinBukan100, penanda: penandaTim.join('; '),
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
  ['Nama ganda', 'Dua tanggapan memakai nama pengisi yang sama.'],
  ['Penilai kurang', '(Rekap Tim) Pengisi kurang dari separuh anggota tim.'],
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
    ['Kelas', 'Tim', 'Jumlah anggota', 'Jumlah pengisi', 'Belum mengisi', 'Paling berkontribusi (menurut penilai)',
     'Hampir tidak berkontribusi (menurut penilai)', 'Tanggapan dengan poin bukan 100', 'Penanda'],
    hasil.rekapTim.map(function (x) { return [x.kelas, x.tim, x.ukuran, x.pengisi, x.belum, x.terbaik, x.pasif, x.poinBukan100, x.penanda]; }));
  tulis_(ss, 'Penanda', ['Penanda', 'Arti'], PENANDA);
  ['Sheet1', 'Sheet 1', 'Lembar1', 'Lembar 1'].forEach(function (n) {
    const awal = ss.getSheetByName(n);
    if (awal && ss.getSheets().length > 1) ss.deleteSheet(awal);
  });
}

function muatStruktur_() {
  const p = PropertiesService.getScriptProperties();
  const indeks = JSON.parse(p.getProperty('INDEKS') || '[]');
  return { formId: p.getProperty('FORM_ID'), rekapId: p.getProperty('REKAP_ID'),
           tim: indeks.map(function (k) { return JSON.parse(p.getProperty(k)); }) };
}

function bacaTanggapan_(form, tim) {
  return form.getResponses().map(function (resp) {
    const peta = {};
    resp.getItemResponses().forEach(function (ir) { peta[ir.getItem().getId()] = ir.getResponse(); });
    const t = tim.filter(function (x) { return peta[x.namaAndaId] !== undefined; })[0];
    if (!t) return null;
    const nilai = function (id) { return peta[id] === undefined || peta[id] === null ? '' : peta[id]; };
    return {
      kelas: t.kelas, tim: t.tim, penilai: peta[t.namaAndaId], email: resp.getRespondentEmail(), waktu: resp.getTimestamp(),
      skor: t.gridIds.map(function (id) {
        return (peta[id] || []).map(function (v) { const n = parseInt(v, 10); return isNaN(n) ? null : n; });
      }),
      poin: t.anggota.map(function (n) { return nilai(t.poinIds[n]); }),
      uraian: t.anggota.map(function (n) { return nilai(t.uraianIds[n]); }),
      bukti: nilai(t.buktiId), terbaik: nilai(t.terbaikId), pasif: nilai(t.pasifId), komentar: nilai(t.komentarId),
    };
  }).filter(Boolean);
}

function hitungRekap() {
  const s = muatStruktur_();
  const form = FormApp.openById(s.formId);
  const hasil = hitungRekapData_(s.tim, bacaTanggapan_(form, s.tim));
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
  module.exports = { hitungRekapData_: hitungRekapData_, AMBANG: AMBANG };
}
