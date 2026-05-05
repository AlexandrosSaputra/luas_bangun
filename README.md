# 📐 Aplikasi Luas Bangun Datar

Aplikasi Flutter sederhana untuk menghitung luas berbagai bangun datar. Project ini dibuat untuk memenuhi tugas pembelajaran dasar pemrograman Dart dan Flutter.

Project ini merupakan versi pengembangan **v2 Bangun Datar**, dengan struktur aplikasi yang sudah dipisahkan menjadi beberapa bagian seperti halaman, controller, model, constants, utilities, dan widgets.

---

## ✨ Fitur Utama

- Menghitung luas berbagai bangun datar:
  - Persegi
  - Persegi Panjang
  - Segitiga
  - Lingkaran
  - Jajar Genjang
  - Trapesium
  - Belah Ketupat
  - Layang-Layang

- Input dinamis sesuai bangun datar yang dipilih
- Validasi input agar data tidak kosong atau bernilai negatif
- Tampilan modern, sederhana, dan ramah untuk anak-anak
- Splash screen sebagai halaman loading awal
- Home page sebagai halaman utama sebelum masuk ke fitur perhitungan
- About page untuk informasi tim pengembang
- Struktur project dibuat lebih rapi agar mudah dikembangkan
- Persiapan pengembangan fitur bangun ruang pada versi berikutnya

---

## 🎨 Palet Warna Aplikasi

Aplikasi ini menggunakan palet warna yang cerah dan ramah untuk anak-anak.

---

## 🧠 Konsep yang Digunakan

Project ini mengimplementasikan beberapa konsep dasar Dart dan Flutter:

- Variabel dan tipe data
- Percabangan `if-else` dan `switch`
- Fungsi
- Class dan object
- Struktur data model
- Pemisahan logic dan tampilan
- Navigasi antar halaman
- Penggunaan assets gambar
- Penggunaan constants untuk warna dan asset
- UI Flutter sederhana
- Pola struktur sederhana berbasis:
  - Model
  - Controller
  - Page
  - Utility
  - Widget

---

## 📁 Struktur Project

lib/
├── constants/
│   ├── app_assets.dart
│   └── app_colors.dart
│
├── controllers/
│   └── luas_controller.dart
│
├── models/
│   └── bangun_datar.dart
│
├── page/
│   ├── about_page.dart
│   ├── bangun_datar_page.dart
│   ├── home_page.dart
│   └── splash_page.dart
│
├── utils/
│   └── rumus_luas.dart
│
├── widgets/
│
└── main.dart

## 📁 Penjelasan Struktur

| Folder/File              | Fungsi                                                 |
| ------------------------ | ------------------------------------------------------ |
| `main.dart`              | Entry point aplikasi Flutter                           |
| `constants/`             | Menyimpan konfigurasi warna dan asset aplikasi         |
| `app_assets.dart`        | Menyimpan path asset gambar                            |
| `app_colors.dart`        | Menyimpan palet warna aplikasi                         |
| `controllers/`           | Mengatur logic perhitungan luas                        |
| `luas_controller.dart`   | Controller untuk menghubungkan input, model, dan rumus |
| `models/`                | Menyimpan struktur data bangun datar                   |
| `bangun_datar.dart`      | Model data untuk bangun datar                          |
| `page/`                  | Menyimpan halaman utama aplikasi                       |
| `splash_page.dart`       | Halaman loading awal aplikasi                          |
| `home_page.dart`         | Halaman utama sebelum masuk ke fitur                   |
| `bangun_datar_page.dart` | Halaman perhitungan luas bangun datar                  |
| `about_page.dart`        | Halaman informasi tim pengembang                       |
| `utils/`                 | Menyimpan fungsi bantuan atau rumus                    |
| `rumus_luas.dart`        | Kumpulan rumus perhitungan luas                        |
| `widgets/`               | Menyimpan komponen UI yang dapat digunakan ulang       |

## 🎯 Tujuan Project

Project ini dibuat untuk:

Memahami dasar pemrograman Dart
Belajar struktur project Flutter
Menerapkan pemisahan logic dan tampilan
Membuat aplikasi kalkulator luas bangun datar
Membuat UI Flutter sederhana yang menarik
Melatih penggunaan Git dan GitHub dalam pengembangan aplikasi
Mempersiapkan pengembangan fitur bangun ruang pada versi berikutnya

## 👨‍💻 Tim Pengembang

| Nama                           |        NBI |
| ------------------------------ | ---------: |
| Moch. Daniyal Farich Alfarisi  | 1462300176 |
| Alexandros Saputra             | 1462300235 |
| Mohammad Firdausi Hadi Pramono | 1462300239 |

Kelas: S
Mata Kuliah: Pengembangan Aplikasi Bergerak
Universitas : 17 Agustus 1945 Surabaya

## 📌 Catatan Pengembangan

Aplikasi ini masih dapat dikembangkan lebih lanjut dengan fitur:

Menambahkan animasi halaman
Menambahkan riwayat hasil perhitungan
Menambahkan fitur reset input
Menambahkan gambar/icon untuk setiap bangun datar
Menambahkan fitur bangun ruang
Menghitung volume dan luas permukaan bangun ruang
Menyimpan hasil perhitungan secara lokal

## 🔮 Rencana Versi Berikutnya

Pada versi berikutnya, aplikasi direncanakan mendukung fitur bangun ruang, seperti:

Kubus
Balok
Tabung
Kerucut
Bola
Prisma
Limas

Fitur tersebut akan dikembangkan pada branch: