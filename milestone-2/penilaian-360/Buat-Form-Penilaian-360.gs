/**
 * Membuat Google Form "Penilaian 360 PBL (Milestone 2)" sesuai SOP Bagian 9.3
 * dan Draft Google Form Milestone 2 (Form 3).
 *
 * Cara pakai:
 * 1. Buka https://script.google.com dengan akun Polinema koordinator, buat proyek baru.
 * 2. Tempel seluruh isi berkas ini, lalu ganti DAFTAR_TIM dan BATAS_AKHIR di bawah.
 * 3. Jalankan fungsi buatFormPenilaian360 dan beri izin. Alamat form dan alamat edit
 *    muncul di Execution log. Form dibuat di Drive pemilik skrip.
 * 4. Ikuti daftar periksa di README-Penilaian-360.md sebelum membagikan form.
 */

// Satu baris per anggota: Kelas;Tim;Nama Anggota (pisah dengan titik koma).
// Salin dari spreadsheet daftar tim. Contoh di bawah fiktif, ganti seluruhnya.
const DAFTAR_TIM = `
TI-2A;Tim Contoh Satu;Anggota A1
TI-2A;Tim Contoh Satu;Anggota A2
TI-2A;Tim Contoh Satu;Anggota A3
TI-2A;Tim Contoh Satu;Anggota A4
TI-2A;Tim Contoh Dua;Anggota B1
TI-2A;Tim Contoh Dua;Anggota B2
TI-2A;Tim Contoh Dua;Anggota B3
SIB-3C;Tim Contoh Tiga;Anggota C1
SIB-3C;Tim Contoh Tiga;Anggota C2
SIB-3C;Tim Contoh Tiga;Anggota C3
`;

const BATAS_AKHIR = '[tanggal], pukul 23.59 WIB';
const JUDUL_FORM = 'Penilaian 360 PBL (Milestone 2)';

const ASPEK = [
  ['Kontribusi pekerjaan', 'Seberapa besar dan baik pekerjaan yang diselesaikan.'],
  ['Tanggung jawab dan ketepatan waktu', 'Menyelesaikan tugas sesuai janji dan tenggat.'],
  ['Kerja sama dan komunikasi', 'Mudah diajak bekerja sama dan cepat membalas pesan tim.'],
  ['Kehadiran dan keterlibatan dalam rapat', 'Hadir dan ikut membahas dalam rapat tim.'],
];

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
      if (hasil[k][t].length < 2) throw new Error('Tim ' + t + ' (' + k + ') harus punya minimal 2 anggota');
    });
  });
  return hasil;
}

function buatFormPenilaian360() {
  const data = bacaDaftarTim_();
  const kelasList = Object.keys(data).sort();
  const form = FormApp.create(JUDUL_FORM);

  form.setDescription(
    'Form ini dipakai untuk menilai kontribusi seluruh anggota tim, termasuk diri Anda sendiri. ' +
    'Isi sendiri dan jangan berdiskusi dengan rekan satu tim. ' +
    'Jawaban hanya dilihat koordinator PBL dan dosen pengampu. Rekan satu tim tidak melihat jawaban Anda.\n\n' +
    'Estimasi waktu sekitar 3 menit. Batas akhir: ' + BATAS_AKHIR + '. ' +
    'Jawaban dapat diubah sampai batas akhir lewat tautan "Edit jawaban".'
  );
  form.setCollectEmail(true);
  form.setLimitOneResponsePerUser(true);   // butuh login akun Google
  form.setAllowResponseEdits(true);
  form.setShowLinkToRespondAgain(false);
  form.setProgressBar(true);
  form.setConfirmationMessage(
    'Terima kasih. Penilaian Anda sudah tercatat dan hanya dilihat koordinator PBL serta dosen pengampu. ' +
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
  kelasList.forEach(function (k) {
    Object.keys(data[k]).sort().forEach(function (tim) {
      const anggota = data[k][tim];
      const hal = form.addPageBreakItem()
        .setTitle(tim + ' (' + k + ')')
        .setHelpText('Nilai seluruh anggota tim, termasuk diri Anda sendiri. Skala 1 (sangat kurang) sampai 5 (sangat baik).')
        .setGoToPage(FormApp.PageNavigationType.SUBMIT);
      halTim[k + '|' + tim] = hal;

      form.addListItem().setTitle('Nama Anda').setChoiceValues(anggota).setRequired(true);

      ASPEK.forEach(function (a) {
        form.addGridItem()
          .setTitle(a[0])
          .setHelpText(a[1] + ' 1 = sangat kurang, 5 = sangat baik.')
          .setRows(anggota)
          .setColumns(['1', '2', '3', '4', '5'])
          .setRequired(true);
      });

      form.addSectionHeaderItem()
        .setTitle('Pembagian 100 poin kontribusi')
        .setHelpText('Bagikan 100 poin kepada seluruh anggota, termasuk diri Anda. Jumlah seluruhnya harus tepat 100. ' +
                     'Anggota yang berkontribusi lebih besar mendapat poin lebih banyak.');
      const angka = FormApp.createTextValidation()
        .setHelpText('Isi angka 0 sampai 100.')
        .requireNumberBetween(0, 100)
        .build();
      anggota.forEach(function (nama) {
        form.addTextItem().setTitle('Poin untuk ' + nama).setRequired(true).setValidation(angka);
      });

      form.addParagraphTextItem()
        .setTitle('Komentar singkat (opsional)')
        .setHelpText('Hal yang perlu diketahui koordinator. Tidak dibagikan ke rekan satu tim.');
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

  Logger.log('Form peserta : ' + form.getPublishedUrl());
  Logger.log('Form edit    : ' + form.getEditUrl());
}
