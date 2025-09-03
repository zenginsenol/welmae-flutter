import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late TabController _tabController;

  int _selectedTabIndex = 0;

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

  // Mock user data - will be replaced with backend data
  final Map<String, dynamic> userData = {
    'name': 'Ayşe Kaya',
    'username': '@aysekaya',
    'location': 'İstanbul, Türkiye',
    'bio':
        'Seyahat tutkunu, fotoğraf meraklısı. Yeni yerler keşfetmeyi ve anılarımı paylaşmayı seviyorum.',
    'photoCount': 156,
    'tripCount': 23,
    'followerCount': 892,
    'followingCount': 145,
    'rating': 4.8,
    'tier': 'Gold',
    'joinDate': 'Mart 2023',
    'isVerified': true,
    'isGuide': true,
  };

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    _buildAppBar(),
                    _buildProfileHeader(),
                    _buildTabBar(),
                  ];
                },
                body: _buildTabBarView(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: backgroundLight,
      elevation: 0,
      floating: false,
      pinned: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: textDark,
            size: 18,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile-settings');
          },
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Icon(Icons.settings, color: textDark, size: 20),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture and Basic Info
            Row(
              children: [
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: userData['tier'] == 'Gold'
                              ? velmaeOrange
                              : velmaePrimary,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          color: backgroundLight,
                          child: const Icon(
                            Icons.person,
                            color: textLight,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    if (userData['isVerified'])
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: velmaeSecondary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: 20),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['name'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData['username'],
                        style: const TextStyle(fontSize: 16, color: textMedium),
                      ),
                      const SizedBox(height: 8),
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
                              userData['location'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: textMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Bio
            Text(
              userData['bio'],
              style: const TextStyle(
                fontSize: 16,
                color: textMedium,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatItem('Fotoğraf', userData['photoCount']),
                ),
                Container(width: 1, height: 40, color: borderLight),
                Expanded(child: _buildStatItem('Gezi', userData['tripCount'])),
                Container(width: 1, height: 40, color: borderLight),
                Expanded(
                  child: _buildStatItem('Takipçi', userData['followerCount']),
                ),
                Container(width: 1, height: 40, color: borderLight),
                Expanded(
                  child: _buildStatItem('Takip', userData['followingCount']),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Rating and Tier
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surfaceWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderLight),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          '${userData['rating']} Puan',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: userData['tier'] == 'Gold'
                          ? velmaeOrange
                          : velmaePrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${userData['tier']} Üye',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Profili Düzenle',
                    Icons.edit,
                    velmaePrimary,
                    () => Navigator.pushNamed(context, '/profile-edit'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    'Paylaş',
                    Icons.share,
                    velmaeSecondary,
                    () => _shareProfile(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: textMedium)),
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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TabBarDelegate(
        TabBar(
          controller: _tabController,
          indicatorColor: velmaePrimary,
          indicatorWeight: 3,
          labelColor: velmaePrimary,
          unselectedLabelColor: textMedium,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Fotoğraflar'),
            Tab(text: 'Geziler'),
            Tab(text: 'Rehberlik'),
            Tab(text: 'Bilgiler'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildPhotosTab(),
        _buildTripsTab(),
        _buildGuideTab(),
        _buildInfoTab(),
      ],
    );
  }

  Widget _buildPhotosTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: 15, // Mock data
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundLight,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: textLight, size: 32),
        );
      },
    );
  }

  Widget _buildTripsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 8, // Mock data
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: backgroundLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.landscape, color: textLight),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kapadokya Gezisi ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '15-17 Ağustos 2023',
                      style: const TextStyle(fontSize: 14, color: textMedium),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (userData['isGuide']) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderLight),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.verified_user,
                    color: velmaeSecondary,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Onaylı Rehber',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bu kullanıcı Velmae tarafından onaylanmış bir rehberdir.',
                    style: const TextStyle(fontSize: 16, color: textMedium),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surfaceWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderLight),
              ),
              child: Column(
                children: [
                  const Icon(Icons.person, color: textLight, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Rehber Değil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bu kullanıcı henüz rehberlik hizmeti vermiyor.',
                    style: const TextStyle(fontSize: 16, color: textMedium),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoCard('Katılma Tarihi', userData['joinDate']),
          const SizedBox(height: 16),
          _buildInfoCard('Üyelik Seviyesi', userData['tier']),
          const SizedBox(height: 16),
          _buildInfoCard('Toplam Gezi', '${userData['tripCount']} gezi'),
          const SizedBox(height: 16),
          _buildInfoCard(
            'Toplam Fotoğraf',
            '${userData['photoCount']} fotoğraf',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderLight),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: textMedium)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  void _shareProfile() {
    HapticFeedback.lightImpact();
    // Implement profile sharing
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: const Color(0xFFF8FAFC), child: tabBar);
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
