import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../services/sound_haptic_service.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _followers = [];
  final List<Map<String, dynamic>> _following = [];
  final List<Map<String, dynamic>> _suggestions = [];

  bool _isLoading = true;
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadFriendsData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Arkadaşlar',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showAddFriendDialog,
            icon: Icon(Icons.person_add, color: theme.colorScheme.onSurface),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          tabs: [
            Tab(text: 'Takipçiler (${_followers.length})'),
            Tab(text: 'Takip Edilenler (${_following.length})'),
            Tab(text: 'Öneriler (${_suggestions.length})'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(theme),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFollowersTab(theme),
                _buildFollowingTab(theme),
                _buildSuggestionsTab(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Arkadaş ara...',
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              _searchController.clear();
              _performSearch('');
            },
            icon: Icon(Icons.clear, color: theme.colorScheme.onSurfaceVariant),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: theme.colorScheme.surface,
        ),
        onChanged: _performSearch,
      ),
    );
  }

  Widget _buildFollowersTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_followers.isEmpty) {
      return _buildEmptyState(
        'Takipçiniz yok',
        'Henüz kimse sizi takip etmiyor',
        theme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _followers.length,
      itemBuilder: (context, index) {
        final follower = _followers[index];
        return _buildFriendCard(follower, theme, 'follower');
      },
    );
  }

  Widget _buildFollowingTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_following.isEmpty) {
      return _buildEmptyState(
        'Takip ettiğiniz yok',
        'Henüz kimseyi takip etmiyorsunuz',
        theme,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _following.length,
      itemBuilder: (context, index) {
        final following = _following[index];
        return _buildFriendCard(following, theme, 'following');
      },
    );
  }

  Widget _buildSuggestionsTab(ThemeData theme) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_suggestions.isEmpty) {
      return _buildEmptyState('Öneri yok', 'Şu anda öneri bulunmuyor', theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = _suggestions[index];
        return _buildFriendCard(suggestion, theme, 'suggestion');
      },
    );
  }

  Widget _buildFriendCard(
    Map<String, dynamic> friend,
    ThemeData theme,
    String type,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: friend['avatar'] != null
              ? NetworkImage(friend['avatar'])
              : null,
          backgroundColor: theme.colorScheme.primaryContainer,
          child: friend['avatar'] == null
              ? Text(
                  friend['name'][0].toUpperCase(),
                  style: AppTypography.titleMedium.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : null,
        ),
        title: Text(
          friend['name'],
          style: AppTypography.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              friend['location'] ?? 'Konum belirtilmemiş',
              style: AppTypography.bodySmall.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (friend['mutualFriends'] != null) ...[
              const SizedBox(height: 4),
              Text(
                '${friend['mutualFriends']} ortak arkadaş',
                style: AppTypography.bodySmall.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        trailing: _buildActionButton(friend, theme, type),
        onTap: () => _showFriendProfile(friend),
      ),
    );
  }

  Widget _buildActionButton(
    Map<String, dynamic> friend,
    ThemeData theme,
    String type,
  ) {
    switch (type) {
      case 'follower':
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              onPressed: () => _followUser(friend),
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
              ),
              child: const Text('Takip Et'),
            ),
            const SizedBox(width: AppSpacing.xs),
            IconButton(
              onPressed: () => _removeFollower(friend),
              icon: Icon(Icons.person_remove, color: Colors.red, size: 20),
            ),
          ],
        );

      case 'following':
        return ElevatedButton(
          onPressed: () => _unfollowUser(friend),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            foregroundColor: theme.colorScheme.onSurfaceVariant,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
          ),
          child: const Text('Takibi Bırak'),
        );

      case 'suggestion':
        return ElevatedButton(
          onPressed: () => _followUser(friend),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
          ),
          child: const Text('Takip Et'),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildEmptyState(String title, String subtitle, ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            title,
            style: AppTypography.titleLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (title == 'Takip ettiğiniz yok')
            ElevatedButton.icon(
              onPressed: _showAddFriendDialog,
              icon: const Icon(Icons.person_add),
              label: const Text('Arkadaş Bul'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
            ),
        ],
      ),
    );
  }

  // Helper Methods
  void _loadFriendsData() async {
    // Simüle edilmiş veri yükleme
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _followers.addAll([
          {
            'id': '1',
            'name': 'Ayşe Demir',
            'avatar': null,
            'location': 'İstanbul, Türkiye',
            'mutualFriends': 3,
            'isFollowing': false,
          },
          {
            'id': '2',
            'name': 'Mehmet Kaya',
            'avatar': null,
            'location': 'Ankara, Türkiye',
            'mutualFriends': 5,
            'isFollowing': false,
          },
          {
            'id': '3',
            'name': 'Fatma Özkan',
            'avatar': null,
            'location': 'İzmir, Türkiye',
            'mutualFriends': 2,
            'isFollowing': false,
          },
        ]);

        _following.addAll([
          {
            'id': '4',
            'name': 'Ali Yıldız',
            'avatar': null,
            'location': 'Bursa, Türkiye',
            'mutualFriends': 4,
            'isFollowing': true,
          },
          {
            'id': '5',
            'name': 'Zeynep Arslan',
            'avatar': null,
            'location': 'Antalya, Türkiye',
            'mutualFriends': 1,
            'isFollowing': true,
          },
        ]);

        _suggestions.addAll([
          {
            'id': '6',
            'name': 'Can Öztürk',
            'avatar': null,
            'location': 'Trabzon, Türkiye',
            'mutualFriends': 2,
            'isFollowing': false,
          },
          {
            'id': '7',
            'name': 'Elif Çelik',
            'avatar': null,
            'location': 'Konya, Türkiye',
            'mutualFriends': 3,
            'isFollowing': false,
          },
          {
            'id': '8',
            'name': 'Burak Şahin',
            'avatar': null,
            'location': 'Gaziantep, Türkiye',
            'mutualFriends': 1,
            'isFollowing': false,
          },
        ]);

        _isLoading = false;
      });
    }
  }

  void _performSearch(String query) {
    // Arama işlevselliği
    setState(() {
      // Filtreleme mantığı burada uygulanacak
    });
  }

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Arkadaş Ekle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Kullanıcı adı veya e-posta',
                hintText: 'arkadas@email.com',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Arkadaş eklemek için kullanıcı adı veya e-posta adresini girin.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _addFriend();
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }

  void _showFriendProfile(Map<String, dynamic> friend) {
    Navigator.pushNamed(
      context,
      '/profile',
      arguments: {'userId': friend['id']},
    );
  }

  void _followUser(Map<String, dynamic> user) {
    setState(() {
      if (_suggestions.contains(user)) {
        _suggestions.remove(user);
        _following.add({...user, 'isFollowing': true});
      } else if (_followers.contains(user)) {
        _followers.remove(user);
        _following.add({...user, 'isFollowing': true});
      }
    });

    SoundHapticService.successFeedback();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${user['name']} takip edilmeye başlandı'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _unfollowUser(Map<String, dynamic> user) {
    setState(() {
      _following.remove(user);
    });

    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${user['name']} takip edilmeyi bıraktınız'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _removeFollower(Map<String, dynamic> user) {
    setState(() {
      _followers.remove(user);
    });

    SoundHapticService.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${user['name']} takipçi listesinden kaldırıldı'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _addFriend() {
    SoundHapticService.successFeedback();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Arkadaşlık isteği gönderildi'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
