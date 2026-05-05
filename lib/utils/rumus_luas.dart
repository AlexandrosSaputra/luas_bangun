import 'dart:math';

class RumusLuas {
  static double persegi(double sisi) => sisi * sisi;

  static double persegiPanjang(double panjang, double lebar) => panjang * lebar;

  static double segitiga(double alas, double tinggi) => 0.5 * alas * tinggi;

  static double lingkaran(double jariJari) => pi * jariJari * jariJari;

  static double jajarGenjang(double alas, double tinggi) => alas * tinggi;

  static double trapesium(double sisiAtas, double sisiBawah, double tinggi) =>
      0.5 * (sisiAtas + sisiBawah) * tinggi;

  static double belahKetupat(double diagonal1, double diagonal2) =>
      0.5 * diagonal1 * diagonal2;

  static double layangLayang(double diagonal1, double diagonal2) =>
      0.5 * diagonal1 * diagonal2;
}