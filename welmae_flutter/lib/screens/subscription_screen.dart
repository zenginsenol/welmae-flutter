import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedPlan = 'gold';

  // Velmae Brand Colors
  static const Color velmaePrimary = Color(0xFF2563EB);
  static const Color velmaeSecondary = Color(0xFF10B981);
  static const Color velmaeAccent = Color(0xFFEF4444);
  static const Color velmaeOrange = Color(0xFFF97316);
  static const Color velmaeGold = Color(0xFFEAB308);
  static const Color velmaePlatinum = Color(0xFF6B7280);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);

  // Subscription Plans
  final List<Map<String, dynamic>> plans = [
    {
      'id': 'bronze',
      'name': 'Bronze',
      'title': 'Başlangıç',
      'price': 'Ücretsiz',
      'monthlyPrice': '₺0',
      'color': velmaePrimary,
      'icon': Icons.star_border,
      'features': [
        '2 gezi oluşturma hakkı/ay',
        '5 katılımcı/gezi',
        '10 fotoğraf yükleme/gün',
        '50 mesaj/gün',
        'Temel profil özelleştirmesi',
        'Standart arama filtreleri',
        'E-posta desteği',
        'Basit istatistikler',
      ],
      'limitations': [
        'Premium kategorilere erişim yok',
        'Öncelikli destek yok',
        'Gelişmiş filtreleme yok',
        'Sponsor gezi oluşturma yok',
        'Rehberlik yapma yetkisi yok',
        'Özel rozetler yok',
      ],
    },
    {
      'id': 'silver',
      'name': 'Silver',
      'title': 'Popüler',
      'price': '₺19.99/ay',
      'monthlyPrice': '₺19.99',
      'color': velmaeGold,
      'icon': Icons.star,
      'isPopular': true,
      'features': [
        '5 gezi oluşturma hakkı/ay',
        '10 katılımcı/gezi',
        '50 fotoğraf yükleme/gün',
        '200 mesaj/gün',
        'Gelişmiş profil özelleştirmesi',
        'Premium arama filtreleri',
        'Öncelikli müşteri desteği',
        'Detaylı analitik raporlar',
        'Özel rozetler ve simgeler',
        'Sponsor gezi oluşturma',
        'Rehberlik yapma yetkisi',
      ],
      'limitations': [
        'Sınırsız gezi oluşturma yok',
        'Sınırsız katılımcı yok',
        'VIP müşteri desteği yok',
      ],
    },
    {
      'id': 'gold',
      'name': 'Gold',
      'title': 'Premium',
      'price': '₺29.99/ay',
      'monthlyPrice': '₺29.99',
      'color': velmaePlatinum,
      'icon': Icons.diamond,
      'features': [
        'Sınırsız gezi oluşturma',
        'Sınırsız katılımcı/gezi',
        'Sınırsız fotoğraf yükleme',
        'Sınırsız mesajlaşma',
        'Gelişmiş profil özelleştirmesi',
        'Premium arama filtreleri',
        'Öncelikli müşteri desteği',
        'Detaylı analitik raporlar',
        'Özel rozetler ve simgeler',
        'Sponsor gezi oluşturma',
        'Rehberlik yapma yetkisi',
        'VIP müşteri desteği',
        'Özel etkinliklere davetiye',
        'Erken erişim özellikleri',
      ],
      'limitations': [],
    },
    {
      'id': 'platinum',
      'name': 'Platinum',
      'title': 'Premium',
      'price': '₺49.99/ay',
      'monthlyPrice': '₺49.99',
      'color': velmaePlatinum,
      'icon': Icons.diamond,
      'features': [
        'Gold\'un tüm özellikleri',
        'VIP müşteri desteği',
        'Kişisel hesap yöneticisi',
        'Özel etkinliklere davetiye',
        'API erişimi',
        'Beyaz etiket çözümler',
        'Kurumsal analitikler',
        'Sınırsız depolama',
        'Özelleştirilebilir arayüz',
      ],
      'limitations': [],
    },
  ];

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
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildPlanCards(),
                    _buildComparisonTable(),
                    _buildSubscribeButton(),
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
        'Üyelik Planları',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [velmaeGold, velmaeOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: velmaeGold.withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Premium Özellikler',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Size en uygun planı seçin ve Velmae\'nin\ntüm özelliklerinden faydalanın',
            style: TextStyle(fontSize: 16, color: textMedium, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCards() {
    return Container(
      height: 480,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: PageView.builder(
        itemCount: plans.length,
        onPageChanged: (index) {
          setState(() {
            _selectedPlan = plans[index]['id'];
          });
        },
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildPlanCard(plan),
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final isSelected = _selectedPlan == plan['id'];
    final isPlatinum = plan['id'] == 'platinum';
    final isGold = plan['id'] == 'gold';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = plan['id'];
        });
        HapticFeedback.selectionClick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? plan['color'] : borderLight,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSelected ? plan['color'] : Colors.black).withValues(
                alpha: 0.1,
              ),
              offset: const Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: plan['color'].withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
                  if (plan['isPopular'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: velmaeOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'En Popüler',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  if (plan['isPopular'] == true) const SizedBox(height: 12),

                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: plan['color'],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(plan['icon'], color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    plan['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: plan['color'],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan['title'],
                    style: const TextStyle(fontSize: 14, color: textMedium),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    plan['price'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                ],
              ),
            ),

            // Features
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ...plan['features'].take(5).map<Widget>((feature) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: plan['color'].withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.check,
                                color: plan['color'],
                                size: 14,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: textMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    if (plan['features'].length > 5) ...[
                      const SizedBox(height: 8),
                      Text(
                        '+${plan['features'].length - 5} özellik daha',
                        style: TextStyle(
                          fontSize: 12,
                          color: plan['color'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonTable() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Özellik Karşılaştırması',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
          const SizedBox(height: 20),
          _buildComparisonRow('Gezi Oluşturma', '2/ay', '5/ay', 'Sınırsız'),
          _buildComparisonRow('Katılımcı/Gezi', '5', '10', 'Sınırsız'),
          _buildComparisonRow(
            'Fotoğraf Yükleme',
            '10/gün',
            '50/gün',
            'Sınırsız',
          ),
          _buildComparisonRow('Mesajlaşma', '50/gün', '200/gün', 'Sınırsız'),
          _buildComparisonRow('Sponsor Gezi', '✗', '✓', '✓'),
          _buildComparisonRow('Rehberlik Yetkisi', '✗', '✓', '✓'),
          _buildComparisonRow('Özel Rozetler', '✗', '✓', '✓'),
          _buildComparisonRow('Müşteri Desteği', 'E-posta', 'Öncelikli', 'VIP'),
          _buildComparisonRow('Analitik Raporlar', '✗', '✓', '✓'),
          _buildComparisonRow('Özel Etkinlikler', '✗', '✗', '✓'),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(
    String feature,
    String bronze,
    String silver,
    String gold,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 14,
                color: textDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              bronze,
              style: const TextStyle(fontSize: 14, color: textMedium),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              silver,
              style: const TextStyle(fontSize: 14, color: textMedium),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              gold,
              style: const TextStyle(fontSize: 14, color: textMedium),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscribeButton() {
    final selectedPlan = plans.firstWhere(
      (plan) => plan['id'] == _selectedPlan,
    );
    final isFree = selectedPlan['id'] == 'bronze';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: isFree
                  ? null
                  : LinearGradient(
                      colors: [
                        selectedPlan['color'],
                        selectedPlan['color'].withValues(alpha: 0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
              color: isFree ? selectedPlan['color'] : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: selectedPlan['color'].withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleSubscribe(),
                borderRadius: BorderRadius.circular(16),
                child: Center(
                  child: Text(
                    isFree
                        ? 'Mevcut Plan'
                        : '${selectedPlan['name']} Planına Geç',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isFree
                ? 'Şu anda Bronze üyesiniz'
                : 'İstediğiniz zaman iptal edebilirsiniz',
            style: const TextStyle(fontSize: 14, color: textMedium),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleSubscribe() {
    HapticFeedback.mediumImpact();

    final selectedPlan = plans.firstWhere(
      (plan) => plan['id'] == _selectedPlan,
    );

    if (selectedPlan['id'] == 'bronze') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Zaten Bronze üyesiniz!'),
          backgroundColor: velmaePrimary,
        ),
      );
      return;
    }

    // Show subscription success
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(selectedPlan['icon'], color: selectedPlan['color']),
            const SizedBox(width: 12),
            Text('${selectedPlan['name']} Üyeliği'),
          ],
        ),
        content: Text(
          '${selectedPlan['name']} planına başarıyla abone oldunuz! Premium özelliklerin keyfini çıkarın.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
