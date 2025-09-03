import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _floatingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _floatingAnimation;

  int _selectedIndex = 0;
  String _selectedCategory = 'Popüler';

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

  // Categories for destination filtering
  final List<String> categories = [
    'Popüler',
    'Deniz',
    'Dağ',
    'Tarih',
    'Doğa',
    'Şehir',
  ];

  // Mock data for destinations - will be replaced with backend data
  final List<Map<String, dynamic>> destinations = [
    {
      'id': '1',
      'name': 'Kapadokya',
      'location': 'Nevşehir, Türkiye',
      'image': 'assets/images/velmae/velmae-app_countrydetail01.png',
      'rating': 4.8,
      'price': '₺2,500',
      'category': 'Popüler',
      'tripCount': 156,
      'isFavorite': false,
    },
    {
      'id': '2',
      'name': 'Antalya',
      'location': 'Antalya, Türkiye',
      'image': 'assets/images/velmae/velmae-app_countrydetail02.png',
      'rating': 4.7,
      'price': '₺1,800',
      'category': 'Deniz',
      'tripCount': 234,
      'isFavorite': true,
    },
    {
      'id': '3',
      'name': 'İstanbul',
      'location': 'İstanbul, Türkiye',
      'image': 'assets/images/velmae/velmae-app_placedetail01.png',
      'rating': 4.9,
      'price': '₺3,200',
      'category': 'Şehir',
      'tripCount': 312,
      'isFavorite': false,
    },
    {
      'id': '4',
      'name': 'Pamukkale',
      'location': 'Denizli, Türkiye',
      'image': 'assets/images/velmae/velmae-app_placedetail02.png',
      'rating': 4.6,
      'price': '₺1,500',
      'category': 'Doğa',
      'tripCount': 89,
      'isFavorite': false,
    },
    {
      'id': '5',
      'name': 'Bodrum',
      'location': 'Muğla, Türkiye',
      'image': 'assets/images/velmae/velmae-app_placedetail03.png',
      'rating': 4.5,
      'price': '₺2,800',
      'category': 'Deniz',
      'tripCount': 178,
      'isFavorite': true,
    },
    {
      'id': '6',
      'name': 'Trabzon',
      'location': 'Trabzon, Türkiye',
      'image': 'assets/images/velmae/velmae-app_tripdetail01.png',
      'rating': 4.4,
      'price': '₺2,100',
      'category': 'Dağ',
      'tripCount': 92,
      'isFavorite': false,
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

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
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

    _floatingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _floatingController.repeat(reverse: true);
  }

  List<Map<String, dynamic>> get filteredDestinations {
    if (_selectedCategory == 'Popüler') {
      return destinations..sort(
        (a, b) => (b['tripCount'] as int).compareTo(a['tripCount'] as int),
      );
    }
    return destinations
        .where((dest) => dest['category'] == _selectedCategory)
        .toList();
  }

  void _toggleFavorite(String destinationId) {
    setState(() {
      final destination = destinations.firstWhere(
        (d) => d['id'] == destinationId,
      );
      destination['isFavorite'] = !destination['isFavorite'];
    });
    HapticFeedback.lightImpact();
  }

  void _navigateToDestination(String destinationId) {
    Navigator.pushNamed(
      context,
      '/destination-detail',
      arguments: destinationId,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundLight,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Column(
                  children: [
                    // Header
                    _buildHeader(),

                    // Search Bar
                    _buildSearchBar(),

                    // Category Tabs
                    _buildCategoryTabs(),

                    // Destinations Grid
                    Expanded(child: _buildDestinationsGrid()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigation(),
      floatingActionButton: _buildCreateTripFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Logo
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: velmaePrimary.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/velmae/velmae-app_appicon.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [velmaePrimary, velmaeSecondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 24,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Welcome Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Merhaba! 👋',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textMedium,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Nereyi keşfetmek istiyorsun?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
              ],
            ),
          ),

          // Notifications
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderLight),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: textDark,
                  size: 22,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: velmaeAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Destinasyon ara...',
          hintStyle: const TextStyle(color: textLight, fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: textLight, size: 22),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: velmaePrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 18),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
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
                category,
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

  Widget _buildDestinationsGrid() {
    final filtered = filteredDestinations;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final destination = filtered[index];
          return _buildDestinationCard(destination, index);
        },
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination, int index) {
    return GestureDetector(
      onTap: () => _navigateToDestination(destination['id']),
      child: AnimatedBuilder(
        animation: _floatingAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              0,
              _floatingAnimation.value * (index.isEven ? 4 : -4),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: surfaceWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
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
                              destination['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: backgroundLight,
                                  child: Icon(
                                    Icons.landscape,
                                    color: textLight,
                                    size: 48,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Favorite Button
                        Positioned(
                          top: 12,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => _toggleFavorite(destination['id']),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                destination['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: destination['isFavorite']
                                    ? velmaeAccent
                                    : textMedium,
                                size: 18,
                              ),
                            ),
                          ),
                        ),

                        // Rating Badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 12,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  destination['rating'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          destination['location'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: textMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              destination['price'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: velmaePrimary,
                              ),
                            ),
                            Text(
                              '${destination['tripCount']} gezi',
                              style: const TextStyle(
                                fontSize: 12,
                                color: textLight,
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
        },
      ),
    );
  }

  Widget _buildCreateTripFAB() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_floatingAnimation.value * 0.02),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [velmaePrimary, velmaeSecondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: velmaePrimary.withValues(alpha: 0.4),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pushNamed(context, '/create-trip');
                },
                borderRadius: BorderRadius.circular(32),
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, -2),
            blurRadius: 16,
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          HapticFeedback.selectionClick();

          // Navigate based on index
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              Navigator.pushNamed(context, '/explore');
              break;
            case 2:
              // FAB handles trip creation
              break;
            case 3:
              Navigator.pushNamed(context, '/messages');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: surfaceWhite,
        selectedItemColor: velmaePrimary,
        unselectedItemColor: textLight,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            label: 'Keşfet',
          ),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Mesajlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
