import 'package:flutter/material.dart';
import '../controllers/luas_controller.dart';
import '../models/bangun_datar.dart';
import '../constants/app_colors.dart';
import '../constants/app_assets.dart';

class BangunDatarPage extends StatefulWidget {
  const BangunDatarPage({super.key});

  @override
  State<BangunDatarPage> createState() => _BangunDatarPageState();
}

class _BangunDatarPageState extends State<BangunDatarPage> {
  final LuasController controller = LuasController();

  List<TextEditingController> inputControllers = [];
  List<String?> inputErrors = [];
  String bangunDipilih = 'Persegi';
  double hasil = 0;
  String? pesanError;
  bool sudahHitung = false;

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
    final bangunColor = AppColors.bangunDatarColors[bangunDipilih] ?? AppColors.accentOrange;
    final assetPath = AppAssets.bangunDatarAssets[bangunDipilih];

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: Column(
        children: [
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 4),

                  if (!sudahHitung)
                    _buildPlaceholder(bangun, bangunColor, assetPath),

                  if (sudahHitung)
                    _buildHasil(bangunColor),

                  const SizedBox(height: 14),

                  _buildInputCard(bangun, bangunColor),

                  const SizedBox(height: 14),

                  if (pesanError != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEEEE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.accentRed.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded, color: AppColors.accentRed, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                                    pesanError!,
                                    style: TextStyle(color: AppColors.accentRed, fontSize: 13),
                                  ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 14),

                  GestureDetector(
                    onTap: hitung,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: bangunColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: bangunColor.withValues(alpha: 0.35),
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

          _buildBottomNav(context),
        ],
      ),
    );
  }

  // ── Header dengan tombol back ─────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.bgHeader,
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Row(
                children: [
                  // ── Tombol back ──────────────────────────────
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // ── Ikon bintang + judul ─────────────────────
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFD166),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      color: AppColors.bgHeader,
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

            // ── Chip scrollable bangun datar ─────────────────
            SizedBox(
              height: 88,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 8, bottom: 14),
                itemCount: BangunDatar.daftar.length,
                itemBuilder: (context, index) {
                  final b = BangunDatar.daftar[index];
                  final isActive = b.nama == bangunDipilih;
                  final color = AppColors.bangunDatarColors[b.nama] ?? AppColors.accentOrange;
                  final asset = AppAssets.bangunDatarAssets[b.nama];

                  return GestureDetector(
                    onTap: () => _onBangunChanged(b.nama),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isActive ? color : Colors.white.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isActive ? color : Colors.white.withValues(alpha: 0.18),
                          width: 1.5,
                        ),
                        boxShadow: isActive
                            ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 8, offset: const Offset(0, 3))]
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
    );
  }

  // ── Placeholder sebelum hitung ────────────────────────────────
  Widget _buildPlaceholder(dynamic bangun, Color color, String? assetPath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.purpleLight, width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.purpleDark,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Masukkan ukuran di bawah,\nlalu tekan Hitung!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.textHint, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ── Kartu hasil ───────────────────────────────────────────────
  Widget _buildHasil(Color color) {
    final hasilStr = hasil % 1 == 0 ? hasil.toInt().toString() : hasil.toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentGreen, width: 2),
        boxShadow: [
          BoxShadow(color: AppColors.accentGreen.withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.accentGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle_rounded, color: AppColors.accentGreen, size: 16),
                const SizedBox(width: 5),
                const Text(
                  'Hasil Luas',
                  style: TextStyle(
                    color: Color(0xFF0F6E56),
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
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: AppColors.purpleDark),
                ),
                const TextSpan(
                  text: ' cm²',
                  style: TextStyle(fontSize: 18, color: AppColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Card input ────────────────────────────────────────────────
  Widget _buildInputCard(dynamic bangun, Color bangunColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.purpleLight, width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit_rounded, color: bangunColor, size: 18),
              const SizedBox(width: 8),
              const Text(
                'Masukkan Ukuran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.purpleDark),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.bgPage,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'satuan: cm',
                  style: TextStyle(fontSize: 11, color: AppColors.textHint, fontWeight: FontWeight.w500),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6, left: 2),
                    child: Row(
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purpleDark,
                          ),
                        ),
                        const Text(
                          '  (cm)',
                          style: TextStyle(fontSize: 12, color: AppColors.textHint),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: inputControllers[index],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    onChanged: (v) => _onInputChanged(index, v),
                    style: TextStyle(
                      color: hasError ? AppColors.accentRed : AppColors.purpleDark,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Contoh: 10',
                      hintStyle: TextStyle(color: AppColors.textHint.withValues(alpha: 0.6), fontSize: 14),
                      prefixIcon: Icon(
                        Icons.straighten_rounded,
                        color: hasError ? AppColors.accentRed : bangunColor,
                        size: 20,
                      ),
                      suffixIcon: inputControllers.length > index && inputControllers[index].text.isNotEmpty
                          ? Icon(
                              hasError ? Icons.cancel_rounded : Icons.check_circle_rounded,
                              color: hasError ? AppColors.accentRed : AppColors.accentGreen,
                              size: 20,
                            )
                          : null,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError ? AppColors.accentRed.withValues(alpha: 0.5) : AppColors.purpleLight,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: hasError ? AppColors.accentRed : bangunColor,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.accentRed, width: 1.5),
                      ),
                      filled: true,
                      fillColor: hasError ? const Color(0xFFFFF0F0) : AppColors.bgPage,
                    ),
                  ),
                  if (hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        inputErrors[index]!,
                        style: TextStyle(fontSize: 11, color: AppColors.accentRed),
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

  // ── Bottom nav ────────────────────────────────────────────────
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        boxShadow: [
          BoxShadow(
            color: AppColors.purpleDark.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
          child: Row(
            children: [
              // Tab Bangun Datar (AKTIF)
              Expanded(
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.purpleDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 32,
                        height: 24,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 4,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFD166),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Bangun Datar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Tab Bangun Ruang (COMING SOON)
              Expanded(
                child: SizedBox(
                  height: 72,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.bgPage,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.purpleLight, width: 1.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 32,
                                height: 24,
                                child: CustomPaint(
                                  painter: _CubePainter(color: AppColors.textHint),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Bangun Ruang',
                                style: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -10,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accentRed,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentRed.withValues(alpha: 0.35),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'Coming Soon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _ikonBangun(String nama) {
    switch (nama) {
      case 'Persegi':         return Icons.crop_square_rounded;
      case 'Persegi Panjang': return Icons.crop_landscape_rounded;
      case 'Segitiga':        return Icons.change_history_rounded;
      case 'Lingkaran':       return Icons.circle_outlined;
      case 'Trapesium':       return Icons.tab_unselected_rounded;
      case 'Jajar Genjang':   return Icons.crop_landscape_rounded;
      case 'Belah Ketupat':   return Icons.diamond_outlined;
      case 'Layang-Layang':   return Icons.diamond_outlined;
      default:                return Icons.shape_line_rounded;
    }
  }
}

class _CubePainter extends CustomPainter {
  final Color color;
  const _CubePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final top    = Offset(w * 0.5,  0);
    final midL   = Offset(0,        h * 0.35);
    final midR   = Offset(w,        h * 0.35);
    final midMid = Offset(w * 0.5,  h * 0.7);
    final botL   = Offset(w * 0.12, h);
    final botR   = Offset(w * 0.88, h);
    final botMid = Offset(w * 0.5,  h);

    final top_ = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(midL.dx, midL.dy)
      ..lineTo(midMid.dx, midMid.dy)
      ..lineTo(midR.dx, midR.dy)
      ..close();
    canvas.drawPath(top_, Paint()..color = color.withValues(alpha: 0.15)..style = PaintingStyle.fill);
    canvas.drawPath(top_, paint);

    final left_ = Path()
      ..moveTo(midL.dx, midL.dy)
      ..lineTo(botL.dx, botL.dy)
      ..lineTo(botMid.dx, botMid.dy)
      ..lineTo(midMid.dx, midMid.dy)
      ..close();
    canvas.drawPath(left_, Paint()..color = color.withValues(alpha: 0.08)..style = PaintingStyle.fill);
    canvas.drawPath(left_, paint);

    final right_ = Path()
      ..moveTo(midR.dx, midR.dy)
      ..lineTo(botR.dx, botR.dy)
      ..lineTo(botMid.dx, botMid.dy)
      ..lineTo(midMid.dx, midMid.dy)
      ..close();
    canvas.drawPath(right_, Paint()..color = color.withValues(alpha: 0.22)..style = PaintingStyle.fill);
    canvas.drawPath(right_, paint);
  }

  @override
  bool shouldRepaint(_CubePainter old) => old.color != color;
}