import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePhotosScreen extends StatefulWidget {
  const ProfilePhotosScreen({super.key});

  @override
  State<ProfilePhotosScreen> createState() => _ProfilePhotosScreenState();
}

class _ProfilePhotosScreenState extends State<ProfilePhotosScreen>
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
    'Şehir',
    'Doğa',
    'Deniz',
    'Dağ',
    'Tarih',
  ];

  // Mock photo data - will be replaced with backend data
  final List<Map<String, dynamic>> photos = [
    {
      'id': '1',
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail01.png',
      'title': 'Kapadokya Balloon Festival',
      'location': 'Nevşehir, Türkiye',
      'date': '15 Ağustos 2023',
      'likes': 125,
      'category': 'Doğa',
      'isLiked': true,
    },
    {
      'id': '2',
      'imageUrl': 'assets/images/velmae/velmae-app_countrydetail02.png',
      'title': 'Antalya Sunset',
      'location': 'Antalya, Türkiye',
      'date': '22 Temmuz 2023',
      'likes': 89,
      'category': 'Deniz',
      'isLiked': false,
    },
    {
      'id': '3',
      'imageUrl': 'assets/images/velmae/velmae-app_placedetail01.png',
      'title': 'Istanbul Hagia Sophia',
      'location': 'İstanbul, Türkiye',
      'date': '05 Eylül 2023',
      'likes': 234,
      'category': 'Tarih',
      'isLiked': true,
    },
    {
      'id': '4',
      'imageUrl': 'assets/images/velmae/velmae-app_placedetail02.png',
      'title': 'Pamukkale Terraces',
      'location': 'Denizli, Türkiye',
      'date': '12 Haziran 2023',
      'likes': 156,
      'category': 'Doğa',
      'isLiked': false,
    },
    {
      'id': '5',
      'imageUrl': 'assets/images/velmae/velmae-app_tripdetail01.png',
      'title': 'Trabzon Uzungöl',
      'location': 'Trabzon, Türkiye',
      'date': '28 Mayıs 2023',
      'likes': 98,
      'category': 'Dağ',
      'isLiked': true,
    },
    // Add more mock photos
    ...List.generate(
      15,
      (index) => {
        'id': '${index + 6}',
        'imageUrl': 'assets/images/velmae/velmae-app_countrydetail01.png',
        'title': 'Travel Photo ${index + 6}',
        'location': 'Türkiye',
        'date': '2023',
        'likes': 50 + (index * 10),
        'category': ['Şehir', 'Doğa', 'Deniz', 'Dağ', 'Tarih'][index % 5],
        'isLiked': index % 3 == 0,
      },
    ),
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

  List<Map<String, dynamic>> get filteredPhotos {
    if (_selectedFilter == 'Tümü') {
      return photos;
    }
    return photos
        .where((photo) => photo['category'] == _selectedFilter)
        .toList();
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
                  Expanded(child: _buildPhotoGrid()),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: _buildAddPhotoFAB(),
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
        'Fotoğraflarım',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => _showPhotoOptions(),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.more_vert, color: textDark, size: 20),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildHeader() {
    final totalPhotos = photos.length;
    final totalLikes = photos.fold<int>(
      0,
      (sum, photo) => sum + (photo['likes'] as int),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Toplam Fotoğraf',
              totalPhotos.toString(),
              Icons.photo_library,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatCard(
              'Toplam Beğeni',
              totalLikes.toString(),
              Icons.favorite,
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

  Widget _buildPhotoGrid() {
    final filtered = filteredPhotos;

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_library_outlined, size: 64, color: textLight),
            const SizedBox(height: 16),
            const Text(
              'Bu kategoride fotoğraf bulunamadı',
              style: TextStyle(fontSize: 16, color: textMedium),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final photo = filtered[index];
        return _buildPhotoCard(photo, index);
      },
    );
  }

  Widget _buildPhotoCard(Map<String, dynamic> photo, int index) {
    return GestureDetector(
      onTap: () => _openPhotoDetail(photo),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceWhite,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              offset: const Offset(0, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
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
                        photo['imageUrl'],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: backgroundLight,
                            child: const Icon(
                              Icons.image,
                              color: textLight,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Like Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleLike(photo['id']),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          photo['isLiked']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: photo['isLiked'] ? velmaeAccent : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  // Category Badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        photo['category'],
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Photo Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    photo['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    photo['location'],
                    style: const TextStyle(fontSize: 12, color: textMedium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: velmaeAccent, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${photo['likes']}',
                        style: const TextStyle(fontSize: 12, color: textMedium),
                      ),
                      const Spacer(),
                      Text(
                        photo['date'],
                        style: const TextStyle(fontSize: 10, color: textLight),
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

  Widget _buildAddPhotoFAB() {
    return FloatingActionButton(
      onPressed: () => _addNewPhoto(),
      backgroundColor: velmaePrimary,
      elevation: 8,
      child: const Icon(Icons.add_a_photo, color: Colors.white),
    );
  }

  void _toggleLike(String photoId) {
    setState(() {
      final photo = photos.firstWhere((p) => p['id'] == photoId);
      final wasLiked = photo['isLiked'];
      photo['isLiked'] = !wasLiked;
      photo['likes'] += wasLiked ? -1 : 1;
    });
    HapticFeedback.lightImpact();
  }

  void _openPhotoDetail(Map<String, dynamic> photo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PhotoDetailScreen(photo: photo)),
    );
  }

  void _addNewPhoto() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fotoğraf ekleme özelliği yakında!'),
        backgroundColor: velmaePrimary,
      ),
    );
  }

  void _showPhotoOptions() {
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
              'Fotoğraf Seçenekleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionTile('Tümünü İndir', Icons.download, () {}),
            _buildOptionTile('Paylaş', Icons.share, () {}),
            _buildOptionTile('Düzenle', Icons.edit, () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(String title, IconData icon, VoidCallback onTap) {
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
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

// Simple PhotoDetailScreen for viewing individual photos
class PhotoDetailScreen extends StatelessWidget {
  final Map<String, dynamic> photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          photo['title'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Image.asset(
          photo['imageUrl'],
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.white, size: 64);
          },
        ),
      ),
    );
  }
}
