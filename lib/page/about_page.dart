import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // tambah di pubspec.yaml jika pakai link

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // ── Palet warna — sama persis dengan halaman lain ────────────
  static const Color bgPage     = Color(0xFFF5F0FF);
  static const Color bgHeader   = Color(0xFF1E1E2E);
  static const Color bgCard     = Colors.white;
  static const Color purpleLight = Color(0xFFD4C8F0);
  static const Color purpleDark  = Color(0xFF3A2E5A);
  static const Color accentGreen  = Color(0xFF06D6A0);
  static const Color accentOrange = Color(0xFFFF8E53);
  static const Color accentYellow = Color(0xFFFFD166);
  static const Color textHint    = Color(0xFFA093C0);

  // ── Data tim — ganti sesuai info asli ────────────────────────
  static const String appVersion = '1.0.0';
  static const String appDesc =
      'Aplikasi kalkulator untuk menghitung luas berbagai bangun datar '
      'secara cepat, mudah, dan akurat.';

  static const List<Map<String, String>> teamMembers = [
    {
      'name': 'Moch. Daniyal Farich Alfarisi',
      'nim': '1462300176',
      'role': 'Developer',
      'github': 'github.com/daniyal',
      'email': 'daniyal@email.com',  
    },
    {
      'name': 'Alexandros Saputra',
      'nim': '1462300235',
      'role': 'Developer',
      'github': 'github.com/alexandrossaputra',
      'email': 'alexandrossaputra@gmail.com',   
    },
    {
      'name': 'Mohammad Firdausi Hadi Pramono',
      'nim': '1462300239',
      'role': 'Developer',
      'github': 'github.com/firdausi',
      'email': 'firdausi@email.com',  
    },
  ];

  // Warna avatar tiap anggota — bisa diubah
  static const List<Color> avatarColors = [
    Color(0xFFFF8E53),
    Color(0xFF9B5DE5),
    Color(0xFF06D6A0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPage,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  _buildAppInfoCard(),
                  const SizedBox(height: 20),
                  _buildSectionLabel('Tim Pengembang'),
                  const SizedBox(height: 12),
                  ...teamMembers.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildMemberCard(e.key, e.value),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildVersionFooter(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header gelap dengan tombol back ──────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: bgHeader,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tentang Aplikasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'GeoHitung — Tim Pengembang',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: accentYellow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: bgHeader,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Card info aplikasi ────────────────────────────────────────
  Widget _buildAppInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: purpleDark,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: purpleDark.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: const Center(
              child: Text('📐', style: TextStyle(fontSize: 34)),
            ),
          ),
          const SizedBox(height: 14),

          // Nama app
          const Text(
            'GeoHitung',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),

          // Badge versi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: accentGreen.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: accentGreen.withOpacity(0.4)),
            ),
            child: Text(
              'Versi $appVersion',
              style: const TextStyle(
                color: accentGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Deskripsi
          Text(
            appDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.65),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ── Label section ─────────────────────────────────────────────
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: purpleDark,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    );
  }

  // ── Card per anggota tim ──────────────────────────────────────
  Widget _buildMemberCard(int index, Map<String, String> member) {
    final color = avatarColors[index % avatarColors.length];
    final initial = member['name']!.trim()[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: purpleLight, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: purpleDark.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: color.withOpacity(0.35), width: 2),
                ),
                child: Center(
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: color,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Nama & NIM
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name']!,
                      style: const TextStyle(
                        color: purpleDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'NIM: ${member['nim']}',
                      style: const TextStyle(
                        color: textHint,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Badge role
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  member['role'] ?? 'Developer',
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: purpleLight, height: 1),
          ),

          // Kontak
          Row(
            children: [
              _buildContactChip(
                icon: Icons.code_rounded,
                label: member['github'] ?? '-',
                color: color,
              ),
              const SizedBox(width: 8),
              _buildContactChip(
                icon: Icons.email_outlined,
                label: member['email'] ?? '-',
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Chip kontak kecil ─────────────────────────────────────────
  Widget _buildContactChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: bgPage,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: purpleLight),
        ),
        child: Row(
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: textHint,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Footer versi ──────────────────────────────────────────────
  Widget _buildVersionFooter() {
    return Column(
      children: [
        const Divider(color: purpleLight),
        const SizedBox(height: 10),
        Text(
          'GeoHitung v$appVersion · Dibuat dengan Flutter',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: textHint,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          '© 2024 Tim GeoHitung. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textHint,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}