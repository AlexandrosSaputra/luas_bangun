# 📐 Aplikasi Luas Bangun Datar

Aplikasi Flutter sederhana untuk menghitung luas berbagai bangun datar. Project ini dibuat untuk memenuhi tugas pembelajaran dasar pemrograman Dart dan Flutter.

---

## ✨ Fitur Utama

* Menghitung luas berbagai bangun datar:

  * Persegi
  * Persegi Panjang
  * Segitiga
  * Lingkaran
  * Jajar Genjang
  * Trapesium
  * Belah Ketupat
  * Layang-Layang

* Input dinamis sesuai bangun datar yang dipilih

* Validasi input (tidak boleh kosong / negatif)

* Tampilan modern minimalis

* Menggunakan warna utama:

  * 🎨 Primary: Biru
  * 🎨 Secondary: Putih

---

## 🧠 Konsep yang Digunakan

Project ini mengimplementasikan konsep dasar Dart:

* Variabel dan Tipe Data
* Percabangan (`if-else` / `switch`)
* Fungsi
* Input dan Output
* UI Flutter sederhana

---

## 📁 Struktur Project

```
lib/
├── main.dart
├── models/
│   └── bangun_datar.dart
├── utils/
│   └── rumus_luas.dart
├── controllers/
│   └── luas_controller.dart
└── pages/
    └── home_page.dart
```

### Penjelasan:

* **models/** → Menyimpan struktur data bangun datar
* **utils/** → Berisi rumus perhitungan luas
* **controllers/** → Mengatur logika perhitungan
* **pages/** → Tampilan UI aplikasi
* **main.dart** → Entry point aplikasi

---

## 🧮 Rumus yang Digunakan

### Persegi

L = s^2

### Persegi Panjang

L = p \times l

### Segitiga

L = \frac{1}{2} \times a \times t

### Lingkaran

L = \pi r^2

### Trapesium

L = \frac{1}{2}(a + b)t

### Belah Ketupat / Layang-Layang

L = \frac{1}{2} d_1 \times d_2

---

## 🚀 Cara Menjalankan

1. Pastikan Flutter sudah terinstall
2. Clone repository ini:

   ```bash
   git clone <repository-url>
   ```
3. Masuk ke folder project:

   ```bash
   cd luas_bangun_datar
   ```
4. Install dependencies:

   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi:

   ```bash
   flutter run
   ```

---

## 🎯 Tujuan Project

Project ini dibuat untuk:

* Memahami dasar pemrograman Dart
* Belajar struktur project Flutter
* Menerapkan konsep MVC sederhana
* Membuat UI Flutter dasar yang menarik

---

## 📸 Tampilan Aplikasi

*(Tambahkan screenshot di sini jika ada)*

---

## 👨‍💻 Author

* Nama: (Isi nama kamu)
* Kelas: (Isi kelas)
* Mata Kuliah: Pemrograman Mobile / Flutter

---

## 📌 Catatan

Aplikasi ini masih sederhana dan dapat dikembangkan lebih lanjut seperti:

* Menambahkan animasi
* Menyimpan riwayat perhitungan
* Menambahkan bangun ruang (volume)