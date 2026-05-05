class BangunDatar {
  final String nama;
  final List<String> labelInput;

  const BangunDatar({
    required this.nama,
    required this.labelInput,
  });

  static const List<BangunDatar> daftar = [
    BangunDatar(nama: 'Persegi', labelInput: ['Sisi']),
    BangunDatar(nama: 'Persegi Panjang', labelInput: ['Panjang', 'Lebar']),
    BangunDatar(nama: 'Segitiga', labelInput: ['Alas', 'Tinggi']),
    BangunDatar(nama: 'Lingkaran', labelInput: ['Jari-jari']),
    BangunDatar(nama: 'Jajar Genjang', labelInput: ['Alas', 'Tinggi']),
    BangunDatar(nama: 'Trapesium', labelInput: ['Sisi Atas', 'Sisi Bawah', 'Tinggi']),
    BangunDatar(nama: 'Belah Ketupat', labelInput: ['Diagonal 1', 'Diagonal 2']),
    BangunDatar(nama: 'Layang-Layang', labelInput: ['Diagonal 1', 'Diagonal 2']),
  ];
}