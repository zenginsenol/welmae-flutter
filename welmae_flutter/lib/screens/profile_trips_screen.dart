import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTripsScreen extends StatefulWidget {
  const ProfileTripsScreen({super.key});

  @override
  State<ProfileTripsScreen> createState() => _ProfileTripsScreenState();
}

class _ProfileTripsScreenState extends State<ProfileTripsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  String _selectedFilter = 'Tümü';

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

  // Filter categories
  final List<String> filters = [
    'Tümü',
    'Tamamlanan',
    'Devam Eden',
    'Planlanan',
    'İptal Edilen',
  ];

  // Mock trip data - will be replaced with backend data
  final List<Map<String, dynamic>> trips = [
    {
      'id': '1',
      'title': 'Kapadokya Balon Turu',
      'destination': 'Nevşehir, Türkiye',
      'startDate': '15 Ağustos 2023',
      'endDate': '17 Ağustos 2023',
      'status': 'Tamamlanan',
      'type': 'Sponsor',
      'participants': 4,
      'rating': 4.8,
      'budget': '₺2,500',
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail01.png',
      'description':
          'Kapadokya\'nın eşsiz manzaralarını balon turunda keşfettik.',
      'guide': 'Mehmet Kaya',
      'category': 'Doğa',
    },
    {
      'id': '2',
      'title': 'Antalya Sahil Tatili',
      'destination': 'Antalya, Türkiye',
      'startDate': '22 Temmuz 2023',
      'endDate': '29 Temmuz 2023',
      'status': 'Tamamlanan',
      'type': 'Guide',
      'participants': 6,
      'rating': 4.6,
      'budget': '₺1,800',
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail02.png',
      'description': 'Antalya\'nın en güzel sahillerinde unutulmaz bir tatil.',
      'guide': 'Ben (Rehber)',
      'category': 'Deniz',
    },
    {
      'id': '3',
      'title': 'İstanbul Tarih Turu',
      'destination': 'İstanbul, Türkiye',
      'startDate': '10 Ekim 2023',
      'endDate': '12 Ekim 2023',
      'status': 'Devam Eden',
      'type': 'Sponsor',
      'participants': 3,
      'rating': null,
      'budget': '₺3,200',
      'imageUrl': 'assets/images/velmae/velmae-app_placedetail01.png',
      'description': 'İstanbul\'un tarihi yerlerini keşfetme gezisi.',
      'guide': 'Ayşe Demir',
      'category': 'Tarih',
    },
    {
      'id': '4',
      'title': 'Pamukkale Wellness',
      'destination': 'Denizli, Türkiye',
      'startDate': '25 Ekim 2023',
      'endDate': '27 Ekim 2023',
      'status': 'Planlanan',
      'type': 'Guide',
      'participants': 5,
      'rating': null,
      'budget': '₺1,500',
      'imageUrl': 'assets/images/velmae/velmae-app_placedetail02.png',
      'description': 'Pamukkale\'nin şifalı sularında rahatlama gezisi.',
      'guide': 'Ben (Rehber)',
      'category': 'Doğa',
    },
    {
      'id': '5',
      'title': 'Trabzon Doğa Turu',
      'destination': 'Trabzon, Türkiye',
      'startDate': '05 Haziran 2023',
      'endDate': '08 Haziran 2023',
      'status': 'İptal Edilen',
      'type': 'Sponsor',
      'participants': 2,
      'rating': null,
      'budget': '₺2,100',
      'imageUrl': 'assets/images/velmae/velmae-app_tripdetail01.png',
      'description': 'Trabzon\'un yeşil doğasında keşif gezisi.',
      'guide': 'Ali Yılmaz',
      'category': 'Dağ',
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
    if (_selectedFilter == 'Tümü') {
      return trips;
    }
    return trips.where((trip) => trip['status'] == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Tamamlanan':
        return velmaeSecondary;
      case 'Devam Eden':
        return velmaePrimary;
      case 'Planlanan':
        return velmaeOrange;
      case 'İptal Edilen':
        return velmaeAccent;
      default:
        return textMedium;
    }
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
                  _buildFilterTabs(),
                  Expanded(child: _buildTripsList()),
                ],
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
        'Gezi Geçmişim',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showTripStats(),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.analytics, color: textDark, size: 20),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeader() {
    final totalTrips = trips.length;
    final completedTrips = trips
        .where((trip) => trip['status'] == 'Tamamlanan')
        .length;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Toplam Gezi',
              totalTrips.toString(),
              Icons.map,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Tamamlanan',
              completedTrips.toString(),
              Icons.check_circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
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
          Icon(icon, color: velmaePrimary, size: 28),
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

  Widget _buildFilterTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
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
                filter,
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
            const Text(
              'Bu kategoride gezi bulunamadı',
              style: TextStyle(fontSize: 16, color: textMedium),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final trip = filtered[index];
        return _buildTripCard(trip, index);
      },
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip, int index) {
    final statusColor = _getStatusColor(trip['status']);

    return GestureDetector(
      onTap: () => _openTripDetail(trip),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderLight),
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
            // Trip Image and Status
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          velmaePrimary.withValues(alpha: 0.1),
                          velmaeSecondary.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Image.asset(
                      trip['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.landscape,
                          color: textLight,
                          size: 48,
                        );
                      },
                    ),
                  ),
                ),

                // Status Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trip['status'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Type Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: trip['type'] == 'Sponsor'
                          ? velmaePrimary
                          : velmaeSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trip['type'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
                  const SizedBox(height: 8),
                  Text(
                    trip['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: textMedium,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Trip Info Row
                  Row(
                    children: [
                      _buildInfoItem(
                        Icons.calendar_today,
                        '${trip['startDate']} - ${trip['endDate']}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildInfoItem(
                        Icons.people,
                        '${trip['participants']} kişi',
                      ),
                      const SizedBox(width: 16),
                      _buildInfoItem(
                        Icons.account_balance_wallet,
                        trip['budget'],
                      ),
                      if (trip['rating'] != null) ...[
                        const SizedBox(width: 16),
                        _buildInfoItem(Icons.star, '${trip['rating']}'),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Guide Info
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: velmaePrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Rehber: ${trip['guide']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: velmaePrimary, size: 14),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: textMedium)),
      ],
    );
  }

  void _openTripDetail(Map<String, dynamic> trip) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripDetailScreen(trip: trip)),
    );
  }

  void _showTripStats() {
    final completed = trips.where((t) => t['status'] == 'Tamamlanan').length;
    final ongoing = trips.where((t) => t['status'] == 'Devam Eden').length;
    final planned = trips.where((t) => t['status'] == 'Planlanan').length;
    final cancelled = trips.where((t) => t['status'] == 'İptal Edilen').length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Gezi İstatistikleri'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatRow('Tamamlanan', completed, velmaeSecondary),
            _buildStatRow('Devam Eden', ongoing, velmaePrimary),
            _buildStatRow('Planlanan', planned, velmaeOrange),
            _buildStatRow('İptal Edilen', cancelled, velmaeAccent),
          ],
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

  Widget _buildStatRow(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          Text(
            count.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// Simple TripDetailScreen for viewing individual trips
class TripDetailScreen extends StatelessWidget {
  final Map<String, dynamic> trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A)),
        ),
        title: Text(
          trip['title'],
          style: const TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Image
            Container(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                trip['imageUrl'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF8FAFC),
                    child: const Icon(
                      Icons.landscape,
                      size: 64,
                      color: Color(0xFF94A3B8),
                    ),
                  );
                },
              ),
            ),

            // Trip Details
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip['destination'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    trip['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF475569),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Gezi Bilgileri',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Tarih',
                    '${trip['startDate']} - ${trip['endDate']}',
                  ),
                  _buildDetailRow('Durum', trip['status']),
                  _buildDetailRow('Tip', trip['type']),
                  _buildDetailRow('Katılımcı', '${trip['participants']} kişi'),
                  _buildDetailRow('Bütçe', trip['budget']),
                  _buildDetailRow('Rehber', trip['guide']),
                  if (trip['rating'] != null)
                    _buildDetailRow('Değerlendirme', '${trip['rating']} ⭐'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
