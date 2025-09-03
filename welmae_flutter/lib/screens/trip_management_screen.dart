import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TripManagementScreen extends StatefulWidget {
  const TripManagementScreen({super.key});

  @override
  State<TripManagementScreen> createState() => _TripManagementScreenState();
}

class _TripManagementScreenState extends State<TripManagementScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedTab = 'Aktif';

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

  final List<String> tabs = ['Aktif', 'Planlanan', 'Talepler', 'Geçmiş'];

  // Mock trip management data
  final List<Map<String, dynamic>> trips = [
    {
      'id': '1',
      'title': 'Kapadokya Balon Turu',
      'destination': 'Nevşehir, Türkiye',
      'startDate': '15 Ağustos 2023',
      'endDate': '17 Ağustos 2023',
      'status': 'Aktif',
      'role': 'Sponsor',
      'participants': [
        {'name': 'Mehmet Kaya', 'role': 'Rehber', 'confirmed': true},
        {'name': 'Ayşe Demir', 'role': 'Katılımcı', 'confirmed': true},
        {'name': 'Ali Yılmaz', 'role': 'Katılımcı', 'confirmed': false},
      ],
      'budget': '₺2,500',
      'progress': 75,
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail01.png',
      'category': 'Doğa',
      'urgentActions': ['Otel rezervasyonu onayı bekleniyor'],
    },
    {
      'id': '2',
      'title': 'İstanbul Tarih Turu',
      'destination': 'İstanbul, Türkiye',
      'startDate': '25 Ekim 2023',
      'endDate': '27 Ekim 2023',
      'status': 'Planlanan',
      'role': 'Guide',
      'participants': [
        {'name': 'Zeynep Çelik', 'role': 'Sponsor', 'confirmed': true},
        {'name': 'Can Özkan', 'role': 'Katılımcı', 'confirmed': true},
      ],
      'budget': '₺1,800',
      'progress': 45,
      'imageUrl': 'assets/images/velmae/velmae-app_placedetail01.png',
      'category': 'Tarih',
      'urgentActions': ['Müze biletleri alınacak'],
    },
    {
      'id': '3',
      'title': 'Antalya Sahil Tatili',
      'destination': 'Antalya, Türkiye',
      'startDate': '5 Eylül 2023',
      'endDate': '9 Eylül 2023',
      'status': 'Talepler',
      'role': 'Sponsor',
      'participants': [
        {'name': 'Rehber Aranıyor', 'role': 'Rehber', 'confirmed': false},
      ],
      'budget': '₺3,200',
      'progress': 20,
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail02.png',
      'category': 'Deniz',
      'urgentActions': ['Rehber onayı bekleniyor', 'Konaklama planı eksik'],
    },
    {
      'id': '4',
      'title': 'Trabzon Doğa Gezisi',
      'destination': 'Trabzon, Türkiye',
      'startDate': '12 Haziran 2023',
      'endDate': '15 Haziran 2023',
      'status': 'Geçmiş',
      'role': 'Guide',
      'participants': [
        {'name': 'Fatma Kaya', 'role': 'Sponsor', 'confirmed': true},
        {'name': 'Burak Şen', 'role': 'Katılımcı', 'confirmed': true},
        {'name': 'Selin Aydın', 'role': 'Katılımcı', 'confirmed': true},
      ],
      'budget': '₺2,100',
      'progress': 100,
      'imageUrl': 'assets/images/velmae/velmae-app_tripdetail01.png',
      'category': 'Dağ',
      'urgentActions': [],
      'rating': 4.8,
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

  List<Map<String, dynamic>> get filteredTrips {
    return trips.where((trip) => trip['status'] == _selectedTab).toList();
  }

  int get urgentTasksCount {
    return trips
        .where((trip) => trip['urgentActions'].isNotEmpty)
        .fold(0, (sum, trip) => sum + (trip['urgentActions'] as List).length);
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
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTabBar(),
                  Expanded(child: _buildTripsList()),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildQuickActionsFAB(),
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
        'Gezi Yönetimi',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showFilterOptions(),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.filter_list, color: textDark, size: 20),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Aktif Geziler',
              trips.where((t) => t['status'] == 'Aktif').length.toString(),
              Icons.schedule,
              velmaePrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Acil Görevler',
              urgentTasksCount.toString(),
              Icons.priority_high,
              velmaeAccent,
            ),
          ),
        ],
      ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
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

  Widget _buildTabBar() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = _selectedTab == tab;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedTab = tab;
              });
              HapticFeedback.selectionClick();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? velmaePrimary : surfaceWhite,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? velmaePrimary : borderLight,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: velmaePrimary.withValues(alpha: 0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                tab,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : textMedium,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTripsList() {
    final filtered = filteredTrips;

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.travel_explore, size: 64, color: textLight),
            const SizedBox(height: 16),
            Text(
              _getEmptyStateMessage(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptyStateSubtitle(),
              style: const TextStyle(fontSize: 14, color: textMedium),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final trip = filtered[index];
        return _buildTripCard(trip, index);
      },
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip, int index) {
    final hasUrgentActions = (trip['urgentActions'] as List).isNotEmpty;

    return GestureDetector(
      onTap: () => _openTripDetails(trip),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasUrgentActions
                ? velmaeAccent.withValues(alpha: 0.3)
                : borderLight,
            width: hasUrgentActions ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Header with Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    child: Image.asset(
                      trip['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: backgroundLight,
                          child: const Icon(
                            Icons.landscape,
                            color: textLight,
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Role Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: trip['role'] == 'Sponsor'
                          ? velmaePrimary
                          : velmaeSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trip['role'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Progress Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${trip['progress']}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Urgent Indicator
                if (hasUrgentActions)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: velmaeAccent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.priority_high,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),

            // Trip Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: velmaeAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          trip['destination'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: textMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: trip['progress'] / 100,
                          backgroundColor: borderLight,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            trip['progress'] == 100
                                ? velmaeSecondary
                                : velmaePrimary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${trip['progress']}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: textMedium,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Trip Info
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.calendar_today,
                        '${trip['startDate']} - ${trip['endDate']}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.people,
                        '${trip['participants'].length} kişi',
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.account_balance_wallet,
                        trip['budget'],
                      ),
                      if (trip['rating'] != null) ...[
                        const SizedBox(width: 12),
                        _buildInfoChip(Icons.star, '${trip['rating']}'),
                      ],
                    ],
                  ),

                  // Urgent Actions
                  if (hasUrgentActions) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: velmaeAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: velmaeAccent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.warning,
                                color: velmaeAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Acil Görevler',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: velmaeAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ...(trip['urgentActions'] as List<String>).map(
                            (action) => Text(
                              '• $action',
                              style: const TextStyle(
                                fontSize: 12,
                                color: textMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          'Detaylar',
                          Icons.info_outline,
                          borderLight,
                          textMedium,
                          () => _openTripDetails(trip),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildActionButton(
                          'Mesaj',
                          Icons.chat_bubble_outline,
                          velmaePrimary,
                          Colors.white,
                          () => _openTripChat(trip),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: velmaePrimary, size: 14),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: textMedium)),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color == borderLight ? surfaceWhite : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 16),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsFAB() {
    return FloatingActionButton(
      onPressed: () => _showQuickActions(),
      backgroundColor: velmaePrimary,
      elevation: 8,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  String _getEmptyStateMessage() {
    switch (_selectedTab) {
      case 'Aktif':
        return 'Aktif geziniz yok';
      case 'Planlanan':
        return 'Planlanan geziniz yok';
      case 'Talepler':
        return 'Bekleyen talebiniz yok';
      case 'Geçmiş':
        return 'Geçmiş geziniz yok';
      default:
        return 'Gezi bulunamadı';
    }
  }

  String _getEmptyStateSubtitle() {
    switch (_selectedTab) {
      case 'Aktif':
        return 'Yeni bir gezi oluşturun veya\nmevcut gezilere katılın';
      case 'Planlanan':
        return 'Gelecek gezilerinizi planlayın';
      case 'Talepler':
        return 'Gezi taleplerini kontrol edin';
      case 'Geçmiş':
        return 'Tamamladığınız geziler burada görünür';
      default:
        return '';
    }
  }

  void _openTripDetails(Map<String, dynamic> trip) {
    Navigator.pushNamed(context, '/trip-detail', arguments: trip);
  }

  void _openTripChat(Map<String, dynamic> trip) {
    Navigator.pushNamed(context, '/messages');
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hızlı İşlemler',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
            const SizedBox(height: 20),
            _buildQuickActionTile(
              'Yeni Gezi Oluştur',
              Icons.add_location_alt,
              () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/create-trip');
              },
            ),
            _buildQuickActionTile(
              'Acil Görevleri Gör',
              Icons.priority_high,
              () {
                Navigator.pop(context);
                _showUrgentTasks();
              },
            ),
            _buildQuickActionTile('Mesajları Kontrol Et', Icons.chat, () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/messages');
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionTile(
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: velmaePrimary),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showUrgentTasks() {
    final urgentTrips = trips
        .where((trip) => (trip['urgentActions'] as List).isNotEmpty)
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: velmaeAccent),
            SizedBox(width: 8),
            Text('Acil Görevler'),
          ],
        ),
        content: urgentTrips.isEmpty
            ? const Text('Acil göreviniz bulunmuyor.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: urgentTrips.map((trip) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      ...(trip['urgentActions'] as List<String>).map(
                        (action) => Text('• $action'),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }).toList(),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filtrele ve Sırala',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
            const SizedBox(height: 20),
            _buildQuickActionTile(
              'Tarihe Göre Sırala',
              Icons.calendar_today,
              () {},
            ),
            _buildQuickActionTile(
              'Kategoriye Göre Filtrele',
              Icons.category,
              () {},
            ),
            _buildQuickActionTile(
              'Bütçeye Göre Sırala',
              Icons.attach_money,
              () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
