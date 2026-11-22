/**
 * Membuat Google Form "Pengumpulan Laporan Milestone 2 PBL" sesuai SOP dan
 * Draft Google Form Milestone 2 (Form 2).
 *
 * Cara pakai:
 * 1. Buka https://script.google.com dengan akun Polinema koordinator, buat proyek baru.
 * 2. Tempel seluruh isi berkas ini, lalu jalankan fungsi buatFormPengumpulanM2 dan beri izin.
 * 3. Alamat form untuk peserta dan alamat edit muncul di Execution log.
 * 4. Tambahkan pertanyaan unggah berkas (PDF) secara manual di bagian "Berkas".
 *    Apps Script tidak bisa membuat pertanyaan unggah berkas. Langkahnya ada di
 *    README-Form-Pengumpulan-M2.md.
 *
 * Form ini tidak ditutup otomatis. Koordinator menutupnya secara manual setelah batas akhir.
 */

const BATAS_AKHIR = '27 November 2026, pukul 23.59 WIB';
const JUDUL_FORM = 'Pengumpulan Laporan Milestone 2 PBL';
const LINK_INFORMASI = 'https://drive.google.com/drive/folders/1ihojXCwWLVCHyIHmGIm5OHN0xkZ8PXPU?usp=sharing';

const KELAS = [
  'TI-2A', 'TI-2B', 'TI-2C', 'TI-2D', 'TI-2E', 'TI-2F', 'TI-2G', 'TI-2H', 'TI-2I',
  'TI-3A', 'TI-3B', 'TI-3C', 'TI-3D', 'TI-3E', 'TI-3F', 'TI-3G', 'TI-3H', 'TI-3I',
  'SIB-2A', 'SIB-2B', 'SIB-2C', 'SIB-2D', 'SIB-2E', 'SIB-2F', 'SIB-2G',
  'SIB-3A', 'SIB-3B', 'SIB-3C', 'SIB-3D', 'SIB-3E', 'SIB-3F', 'SIB-3G',
];

const PERNYATAAN = [
  'Berkas memuat sampul, Lembar Status, Bab 1–5, dan lampiran sesuai struktur Template. Bab 4 memuat minimal 10 kasus uji.',
  'Setiap anggota sudah diminta mengisi Penilaian 360 lewat form terpisah. Hasilnya tidak perlu dilampirkan di laporan.',
  'Seluruh tautan eksternal sudah diuji di mode incognito dan dapat dibuka tanpa login.',
  'Laporan disusun mengikuti struktur Template dan bukan salinan Template.',
];

function buatFormPengumpulanM2() {
  const form = FormApp.create(JUDUL_FORM);

  form.setDescription(
    'Form ini digunakan untuk mengumpulkan Laporan Milestone 2 PBL.\n\n' +
    '• Satu tim mengumpulkan satu berkas PDF (Lembar Status, Bab 1–5, dan lampiran). Form diisi oleh Ketua Tim.\n' +
    '• Batas akhir pengumpulan: ' + BATAS_AKHIR + '.\n' +
    '• SOP, Template, dan contoh laporan Milestone 2 ada di folder berikut: ' + LINK_INFORMASI + '\n' +
    '• Ikuti susunan Template, tetapi tulis isi dari proyek tim sendiri.'
  );
  form.setCollectEmail(true);
  form.setAllowResponseEdits(true);        // jawaban bisa diubah sampai form ditutup
  form.setShowLinkToRespondAgain(false);
  form.setProgressBar(true);
  form.setConfirmationMessage(
    'Terima kasih. Laporan Milestone 2 tim telah diterima. Jawaban dapat diubah hingga batas akhir pengumpulan melalui tautan "Edit jawaban".'
  );
  try { form.setRequireLogin(true); } catch (e) { /* hanya tersedia di akun Workspace */ }

  // ---- Bagian 1: identitas tim
  form.addMultipleChoiceItem().setTitle('Program Studi').setChoiceValues([
    'Teknik Informatika (TI)', 'Sistem Informasi Bisnis (SIB)']).setRequired(true);
  form.addMultipleChoiceItem().setTitle('Tingkat dan Semester').setChoiceValues([
    'Tingkat 2, Semester 3', 'Tingkat 3, Semester 5']).setRequired(true);
  form.addListItem().setTitle('Kelas').setChoiceValues(KELAS).setRequired(true);
  form.addTextItem().setTitle('Nama Tim').setHelpText('Sama dengan proposal dan sampul.').setRequired(true);
  form.addTextItem().setTitle('Judul Produk').setHelpText('Sama dengan sampul.').setRequired(true);
  form.addTextItem().setTitle('Nama Ketua Tim').setHelpText('Nama lengkap sesuai data akademik.').setRequired(true);
  form.addTextItem().setTitle('NIM Ketua Tim').setHelpText('Hanya angka, 12 digit.').setRequired(true)
    .setValidation(FormApp.createTextValidation()
      .setHelpText('Isi 12 digit angka.')
      .requireTextMatchesPattern('^\\d{12}$')
      .build());

  // ---- Bagian 2: kondisi tim
  form.addPageBreakItem().setTitle('Kondisi Tim')
    .setHelpText('Semua pertanyaan wajib diisi. Seluruh pilihan diterima tanpa pengurangan nilai.');
  form.addMultipleChoiceItem().setTitle('Status Milestone 2 menurut tim').setChoiceValues([
    'Lengkap (alur utama berjalan dan dokumen wajib lengkap)',
    'Sebagian (alur utama berjalan tetapi sering gagal, atau ada dokumen yang belum ada)',
    'Kritis (alur utama belum berjalan)']).setRequired(true);
  form.addMultipleChoiceItem().setTitle('Bentuk demo yang diusulkan tim')
    .setHelpText('Dosen tiap kelas yang menentukan jadwal dan bentuk akhir demo (SOP Bagian 10.6). Pilihan ini hanya usulan tim.')
    .setChoiceValues(['Langsung', 'Video', 'Gabungan']).setRequired(true);
  form.addMultipleChoiceItem().setTitle('Cara deploy').setChoiceValues([
    'Server kampus', 'Hosting gratis atau milik sendiri', 'Lokal dengan video', 'Berkas instalasi (APK)']).setRequired(true);
  form.addMultipleChoiceItem().setTitle('Masukan pengguna').setChoiceValues([
    'Mitra', 'Calon pengguna (minimal 3 orang)', 'Pengguna pengganti']).setRequired(true);
  form.addCheckboxItem().setTitle('Jenis bukti pengujian (boleh lebih dari satu)').setChoiceValues([
    'Uji manual (minimal 10 kasus uji)', 'Uji otomatis', 'Uji coba oleh pengguna',
    'Uji kebenaran data', 'Hasil awal model', 'Laporan uji awal']).setRequired(true);
  form.addMultipleChoiceItem().setTitle('Dokumen tambahan mata kuliah').setChoiceValues([
    'Tidak ada',
    'Ada dan sudah dilampirkan pada Lampiran D',
    'Ada dan sudah dikumpulkan di tempat pengumpulan mata kuliah (misalnya lembar penilaian mandiri Manajemen Proyek) dan dicatat di Lampiran D']).setRequired(true);

  // ---- Bagian 3: berkas (pertanyaan unggah berkas ditambahkan manual di bagian ini)
  form.addPageBreakItem().setTitle('Berkas')
    .setHelpText('Unggah Laporan Milestone 2 dalam satu berkas PDF. Nama berkas: M2_<Kelas>_<NamaTim>.pdf. ' +
                 'Berkas yang terlalu besar cukup ditautkan sesuai SOP Bagian 13.');
  form.addCheckboxItem().setTitle('Pernyataan kelengkapan')
    .setHelpText('Centang semua pernyataan.')
    .setChoiceValues(PERNYATAAN).setRequired(true)
    .setValidation(FormApp.createCheckboxValidation()
      .setHelpText('Semua pernyataan harus dicentang.')
      .requireSelectExactly(PERNYATAAN.length)
      .build());
  form.addParagraphTextItem().setTitle('Catatan tambahan (opsional)')
    .setHelpText('Kendala atau informasi untuk koordinator.');

  Logger.log('Form peserta : ' + form.getPublishedUrl());
  Logger.log('Form edit    : ' + form.getEditUrl());
  Logger.log('Langkah berikutnya: tambahkan pertanyaan unggah berkas PDF di bagian "Berkas" (lihat README).');
}
