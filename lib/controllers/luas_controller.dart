import '../utils/rumus_luas.dart';

class LuasResult {
  final double? luas;
  final String? error;

  LuasResult({this.luas, this.error});

  bool get sukses => error == null && luas != null;
}

class LuasController {
  LuasResult hitungLuas(String namaBangun, List<double> input) {
    if (input.isEmpty) {
      return LuasResult(error: 'Input tidak boleh kosong.');
    }

    if (input.any((nilai) => nilai <= 0)) {
      return LuasResult(error: 'Semua nilai harus lebih besar dari nol.');
    }

    switch (namaBangun) {
      case 'Persegi':
        if (input.length != 1) {
          return LuasResult(error: 'Persegi membutuhkan satu nilai: sisi.');
        }
        return LuasResult(luas: RumusLuas.persegi(input[0]));
      case 'Persegi Panjang':
        if (input.length != 2) {
          return LuasResult(error: 'Persegi Panjang membutuhkan dua nilai: panjang dan lebar.');
        }
        return LuasResult(luas: RumusLuas.persegiPanjang(input[0], input[1]));
      case 'Segitiga':
        if (input.length != 2) {
          return LuasResult(error: 'Segitiga membutuhkan dua nilai: alas dan tinggi.');
        }
        return LuasResult(luas: RumusLuas.segitiga(input[0], input[1]));
      case 'Lingkaran':
        if (input.length != 1) {
          return LuasResult(error: 'Lingkaran membutuhkan satu nilai: jari-jari.');
        }
        return LuasResult(luas: RumusLuas.lingkaran(input[0]));
      case 'Jajar Genjang':
        if (input.length != 2) {
          return LuasResult(error: 'Jajar Genjang membutuhkan dua nilai: alas dan tinggi.');
        }
        return LuasResult(luas: RumusLuas.jajarGenjang(input[0], input[1]));
      case 'Trapesium':
        if (input.length != 3) {
          return LuasResult(error: 'Trapesium membutuhkan tiga nilai: sisi atas, sisi bawah, dan tinggi.');
        }
        return LuasResult(luas: RumusLuas.trapesium(input[0], input[1], input[2]));
      case 'Belah Ketupat':
        if (input.length != 2) {
          return LuasResult(error: 'Belah Ketupat membutuhkan dua nilai: diagonal 1 dan diagonal 2.');
        }
        return LuasResult(luas: RumusLuas.belahKetupat(input[0], input[1]));
      case 'Layang-Layang':
        if (input.length != 2) {
          return LuasResult(error: 'Layang-Layang membutuhkan dua nilai: diagonal 1 dan diagonal 2.');
        }
        return LuasResult(luas: RumusLuas.layangLayang(input[0], input[1]));
      default:
        return LuasResult(error: 'Bangun datar tidak dikenali.');
    }
  }
}
