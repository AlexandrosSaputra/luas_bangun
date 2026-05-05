import 'package:flutter/material.dart';
import '../controllers/luas_controller.dart';
import '../models/bangun_datar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LuasController controller = LuasController();

  List<TextEditingController> inputControllers = [];
  List<String?> inputErrors = [];
  String bangunDipilih = 'Persegi';
  double hasil = 0;
  String? pesanError;
  bool sudahHitung = false;

  // ── Palet warna terpadu (satu keluarga ungu-hangat) ──────────
  static const Color bgPage    = Color(0xFFF5F0FF);
  static const Color bgHeader  = Color(0xFF1E1E2E);
  static const Color bgCard    = Colors.white;
  static const Color purple    = Color(0xFF7C6FA0);
  static const Color purpleLight = Color(0xFFD4C8F0);
  static const Color purpleDark  = Color(0xFF3A2E5A);
  static const Color accentGreen = Color(0xFF06D6A0);
  static const Color accentOrange = Color(0xFFFF8E53);
  static const Color accentRed    = Color(0xFFFF6B6B);
  static const Color textHint   = Color(0xFFA093C0);

  static const Map<String, Color> bangunColors = {
    'Persegi':         Color(0xFFFF8E53),
    'Persegi Panjang': Color(0xFFFFB347),
    'Segitiga':        Color(0xFF06D6A0),
    'Lingkaran':       Color(0xFFFF6B6B),
    'Trapesium':       Color(0xFF9B5DE5),
    'Jajar Genjang':   Color(0xFF00BBF9),
    'Belah Ketupat':   Color(0xFFFF6B9D),
    'Layang-Layang':   Color(0xFFFFC300),
  };

  static const Map<String, String> bangunAssets = {
    'Persegi':         'assets/images/persegi.png',
    'Persegi Panjang': 'assets/images/persegi_panjang.png',
    'Segitiga':        'assets/images/segitiga.png',
    'Lingkaran':       'assets/images/lingkaran.png',
    'Jajar Genjang':   'assets/images/jajar_genjang.png',
    'Trapesium':       'assets/images/trapesium.png',
    'Belah Ketupat':   'assets/images/belah_ketupat.png',
    'Layang-Layang':   'assets/images/layang_layang.png',
  };

  @override
  void initState() {
    super.initState();
    _updateControllers();
  }

  void _updateControllers() {
    for (var c in inputControllers) {
      c.dispose();
    }
    final bangun = BangunDatar.daftar.firstWhere((b) => b.nama == bangunDipilih);
    inputControllers = List.generate(bangun.labelInput.length, (_) => TextEditingController());
    inputErrors = List.generate(bangun.labelInput.length, (_) => null);
  }

  void _onBangunChanged(String nama) {
    setState(() {
      bangunDipilih = nama;
      _updateControllers();
      hasil = 0;
      pesanError = null;
      sudahHitung = false;
    });
  }

  // Validasi real-time per field
  void _onInputChanged(int index, String value) {
    setState(() {
      if (value.isEmpty) {
        inputErrors[index] = null;
      } else {
        final nilai = double.tryParse(value);
        if (nilai == null) {
          inputErrors[index] = 'Harus berupa angka';
        } else if (nilai <= 0) {
          inputErrors[index] = 'Harus lebih dari 0';
        } else {
          inputErrors[index] = null;
        }
      }
    });
  }

  void hitung() {
    bool adaError = false;
    setState(() {
      for (int i = 0; i < inputControllers.length; i++) {
        final nilai = double.tryParse(inputControllers[i].text);
        if (nilai == null || nilai <= 0) {
          inputErrors[i] = 'Wajib diisi dengan angka positif';
          adaError = true;
        }
      }
    });
    if (adaError) return;

    final input = inputControllers.map((c) => double.parse(c.text)).toList();
    final LuasResult result = controller.hitungLuas(bangunDipilih, input);

    setState(() {
      if (result.sukses) {
        hasil = result.luas!;
        pesanError = null;
        sudahHitung = true;
      } else {
        hasil = 0;
        pesanError = result.error;
        sudahHitung = false;
      }
    });
  }

  @override
  void dispose() {
    for (var c in inputControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bangun = BangunDatar.daftar.firstWhere((b) => b.nama == bangunDipilih);
    final bangunColor = bangunColors[bangunDipilih] ?? accentOrange;
    final assetPath = bangunAssets[bangunDipilih];

    return Scaffold(
      backgroundColor: bgPage,
      body: Column(
        children: [

          // ── Header gelap + chip scrollable ──────────────────
          Container(
            color: bgHeader,
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD166),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.star_rounded,
                            color: bgHeader,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Hitung Luas Bangun Datar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 88,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 16, right: 8, bottom: 14),
                      itemCount: BangunDatar.daftar.length,
                      itemBuilder: (context, index) {
                        final b = BangunDatar.daftar[index];
                        final isActive = b.nama == bangunDipilih;
                        final color = bangunColors[b.nama] ?? accentOrange;
                        final asset = bangunAssets[b.nama];

                        return GestureDetector(
                          onTap: () => _onBangunChanged(b.nama),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isActive ? color : Colors.white.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isActive ? color : Colors.white.withOpacity(0.18),
                                width: 1.5,
                              ),
                              boxShadow: isActive
                                  ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))]
                                  : [],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: asset != null
                                      ? Image.asset(
                                          asset,
                                          fit: BoxFit.contain,
                                          color: Colors.white,
                                          colorBlendMode: BlendMode.srcIn,
                                        )
                                      : Icon(_ikonBangun(b.nama), color: Colors.white, size: 26),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  b.nama,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Body ────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),

                  // Placeholder / ilustrasi bangun terpilih
                  if (!sudahHitung)
                    _buildPlaceholder(bangun, bangunColor, assetPath),

                  // Hasil (muncul setelah hitung)
                  if (sudahHitung)
                    _buildHasil(bangunColor),

                  const SizedBox(height: 14),

                  // Card input
                  _buildInputCard(bangun, bangunColor),

                  const SizedBox(height: 14),

                  // Error global
                  if (pesanError != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEEEE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentRed.withOpacity(0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: accentRed, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(pesanError!, style: TextStyle(color: accentRed, fontSize: 13)),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 14),

                  // Tombol hitung
                  GestureDetector(
                    onTap: hitung,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: bangunColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: bangunColor.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calculate_rounded, color: Colors.white, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Hitung Sekarang!',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Placeholder sebelum hitung ─────────────────────────────
  Widget _buildPlaceholder(dynamic bangun, Color color, String? assetPath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: purpleLight, width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(12),
            child: assetPath != null
                ? Image.asset(assetPath, fit: BoxFit.contain, color: color, colorBlendMode: BlendMode.srcIn)
                : Icon(_ikonBangun(bangunDipilih), color: color, size: 40),
          ),
          const SizedBox(height: 12),
          Text(
            bangunDipilih,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: purpleDark),
          ),
          const SizedBox(height: 6),
          Text(
            'Masukkan ukuran di bawah,\nlalu tekan Hitung!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textHint, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ── Kartu hasil ────────────────────────────────────────────
  Widget _buildHasil(Color color) {
    final hasilStr = hasil % 1 == 0 ? hasil.toInt().toString() : hasil.toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentGreen, width: 2),
        boxShadow: [
          BoxShadow(color: accentGreen.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: accentGreen.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded, color: accentGreen, size: 16),
                const SizedBox(width: 5),
                Text(
                  'Hasil Luas',
                  style: TextStyle(
                    color: const Color(0xFF0F6E56),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: hasilStr,
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: purpleDark),
                ),
                const TextSpan(
                  text: ' cm²',
                  style: TextStyle(fontSize: 18, color: textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Card input dengan validasi real-time ───────────────────
  Widget _buildInputCard(dynamic bangun, Color bangunColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: purpleLight, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section — hierarki tipografi jelas
          Row(
            children: [
              Icon(Icons.edit_rounded, color: bangunColor, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Masukkan Ukuran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: purpleDark),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: bgPage,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'satuan: cm',
                  style: TextStyle(fontSize: 11, color: textHint, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          ...bangun.labelInput.asMap().entries.map((entry) {
            int index = entry.key;
            String label = entry.value;
            final hasError = inputErrors.length > index && inputErrors[index] != null;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label besar + satuan — hierarki jelas
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, left: 2),
                    child: Row(
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: purpleDark,
                          ),
                        ),
                        const Text(
                          '  (cm)',
                          style: TextStyle(fontSize: 12, color: textHint),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: inputControllers[index],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) => _onInputChanged(index, v),
                    style: TextStyle(
                      color: hasError ? accentRed : purpleDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Contoh: 10',
                      hintStyle: TextStyle(color: textHint.withOpacity(0.6), fontSize: 14),
                      prefixIcon: Icon(
                        Icons.straighten_rounded,
                        color: hasError ? accentRed : bangunColor,
                        size: 20,
                      ),
                      // Feedback real-time di suffix
                      suffixIcon: inputControllers.length > index && inputControllers[index].text.isNotEmpty
                          ? Icon(
                              hasError ? Icons.cancel_rounded : Icons.check_circle_rounded,
                              color: hasError ? accentRed : accentGreen,
                              size: 20,
                            )
                          : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError ? accentRed.withOpacity(0.5) : purpleLight,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError ? accentRed : bangunColor,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: accentRed, width: 1.5),
                      ),
                      filled: true,
                      fillColor: hasError ? const Color(0xFFFFF0F0) : bgPage,
                    ),
                  ),
                  // Pesan error per field
                  if (hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        inputErrors[index]!,
                        style: TextStyle(fontSize: 11, color: accentRed),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _ikonBangun(String nama) {
    switch (nama) {
      case 'Persegi':        return Icons.crop_square_rounded;
      case 'Persegi Panjang':return Icons.crop_landscape_rounded;
      case 'Segitiga':       return Icons.change_history_rounded;
      case 'Lingkaran':      return Icons.circle_outlined;
      case 'Trapesium':      return Icons.tab_unselected_rounded;
      case 'Jajar Genjang':  return Icons.crop_landscape_rounded;
      case 'Belah Ketupat':  return Icons.diamond_outlined;
      case 'Layang-Layang':  return Icons.diamond_outlined;
      default:               return Icons.shape_line_rounded;
    }
  }
}