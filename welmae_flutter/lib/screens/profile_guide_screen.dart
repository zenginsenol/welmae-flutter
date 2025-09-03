import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../shared/components/tier_restriction_widget.dart';

class ProfileGuideScreen extends StatefulWidget {
  const ProfileGuideScreen({super.key});

  @override
  State<ProfileGuideScreen> createState() => _ProfileGuideScreenState();
}

class _ProfileGuideScreenState extends State<ProfileGuideScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // Velmae Brand Colors
  static const Color velmaePrimary = Color(0xFF2563EB);
  static const Color velmaeSecondary = Color(0xFF10B981);
  static const Color velmaeAccent = Color(0xFFEF4444);
  static const Color velmaeOrange = Color(0xFFF97316);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Mock guide data
  final Map<String, dynamic> guideData = {
    'isVerifiedGuide': true,
    'guideLevel': 'Uzman Rehber',
    'totalTrips': 42,
    'rating': 4.8,
    'reviewCount': 156,
    'yearsExperience': 5,
    'languages': ['Türkçe', 'İngilizce', 'Almanca'],
    'specialties': [
      'Tarih Turları',
      'Doğa Gezileri',
      'Kültür Turları',
      'Fotoğraf Gezileri',
    ],
    'certifications': [
      'Turist Rehberi Lisansı',
      'İlk Yardım Sertifikası',
      'Dağcılık Sertifikası',
    ],
    'earnings': '₺12,450',
    'monthlyEarnings': '₺2,100',
  };

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGuideStatus(),
                    const SizedBox(height: 24),
                    _buildStatistics(),
                    const SizedBox(height: 24),
                    _buildEarnings(),
                    const SizedBox(height: 24),
                    _buildSpecialties(),
                    const SizedBox(height: 24),
                    _buildCertifications(),
                    const SizedBox(height: 24),
                    _buildLanguages(),
                    const SizedBox(height: 24),
                    _buildActions(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: surfaceWhite,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: textDark,
            size: 18,
          ),
        ),
      ),
      title: const Text(
        'Rehber Profili',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildGuideStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [velmaeSecondary, velmaeSecondary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: velmaeSecondary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.verified_user, color: Colors.white, size: 48),
          const SizedBox(height: 16),
          const Text(
            'Onaylı Rehber',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            guideData['guideLevel'],
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                '${guideData['rating']} (${guideData['reviewCount']} değerlendirme)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Toplam Gezi',
            guideData['totalTrips'].toString(),
            Icons.map,
            velmaePrimary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Deneyim',
            '${guideData['yearsExperience']} Yıl',
            Icons.timeline,
            velmaeOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: textMedium),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEarnings() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: velmaeSecondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: velmaeSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Kazançlar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Toplam Kazanç',
                      style: TextStyle(fontSize: 14, color: textMedium),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      guideData['earnings'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: velmaeSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bu Ay',
                      style: TextStyle(fontSize: 14, color: textMedium),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      guideData['monthlyEarnings'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: velmaePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialties() {
    return _buildSection(
      title: 'Uzmanlık Alanları',
      icon: Icons.star,
      color: velmaeOrange,
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: (guideData['specialties'] as List<String>).map((specialty) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: velmaeOrange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: velmaeOrange.withValues(alpha: 0.3)),
            ),
            child: Text(
              specialty,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: velmaeOrange,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCertifications() {
    return _buildSection(
      title: 'Sertifikalar',
      icon: Icons.verified,
      color: velmaePrimary,
      child: Column(
        children: (guideData['certifications'] as List<String>).map((cert) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderLight),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: velmaeSecondary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    cert,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textDark,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLanguages() {
    return _buildSection(
      title: 'Diller',
      icon: Icons.language,
      color: velmaeSecondary,
      child: Row(
        children: (guideData['languages'] as List<String>).map((language) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: velmaeSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: velmaeSecondary.withValues(alpha: 0.3)),
            ),
            child: Text(
              language,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: velmaeSecondary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        TierRestrictionWidget(
          feature: 'beGuide',
          child: _buildActionButton(
            'Rehber Ayarları',
            Icons.settings,
            velmaePrimary,
            () => _showGuideSettings(),
          ),
        ),
        const SizedBox(height: 12),
        TierRestrictionWidget(
          feature: 'analyticsAccess',
          child: _buildActionButton(
            'Kazanç Raporları',
            Icons.analytics,
            velmaeSecondary,
            () => _showEarningsReport(),
          ),
        ),
        const SizedBox(height: 12),
        TierRestrictionWidget(
          feature: 'customBadges',
          child: _buildActionButton(
            'Değerlendirmeler',
            Icons.star_rate,
            velmaeOrange,
            () => _showReviews(),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGuideSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rehber ayarları özelliği yakında!'),
        backgroundColor: velmaePrimary,
      ),
    );
  }

  void _showEarningsReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kazanç raporları özelliği yakında!'),
        backgroundColor: velmaeSecondary,
      ),
    );
  }

  void _showReviews() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Değerlendirmeler özelliği yakında!'),
        backgroundColor: velmaeOrange,
      ),
    );
  }
}
