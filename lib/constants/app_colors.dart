import 'package:flutter/material.dart';

class AppColors {
  // ── Palet warna utama ─────────
  static const Color bgPage = Color(0xFFF5F0FF);
  static const Color bgHeader = Color(0xFF1E1E2E);
  static const Color bgCard = Colors.white;

  static const Color purple = Color(0xFF7C6FA0);
  static const Color purpleLight = Color(0xFFD4C8F0);
  static const Color purpleDark = Color(0xFF3A2E5A);

  static const Color accentGreen = Color(0xFF06D6A0);
  static const Color accentOrange = Color(0xFFFF8E53);
  static const Color accentRed = Color(0xFFFF6B6B);
  static const Color accentYellow = Color(0xFFFFD166);

  static const Color textHint = Color(0xFFA093C0);

  // ── Warna khusus bangun datar ─────────
  static const Map<String, Color> bangunDatarColors = {
    'Persegi': Color(0xFFFF8E53),
    'Persegi Panjang': Color(0xFFFFB347),
    'Segitiga': Color(0xFF06D6A0),
    'Lingkaran': Color(0xFFFF6B6B),
    'Trapesium': Color(0xFF9B5DE5),
    'Jajar Genjang': Color(0xFF00BBF9),
    'Belah Ketupat': Color(0xFFFF6B9D),
    'Layang-Layang': Color(0xFFFFC300),
  };
}