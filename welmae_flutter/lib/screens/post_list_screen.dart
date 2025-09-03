import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../services/sound_haptic_service.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _posts = [];
  bool _isLoading = true;
  String _selectedFilter = 'all';
  String _selectedSort = 'latest';

  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _loadPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Seyahat Paylaşımları',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showFilterDialog,
            icon: Icon(Icons.filter_list, color: theme.colorScheme.onSurface),
          ),
          IconButton(
            onPressed: _showSortDialog,
            icon: Icon(Icons.sort, color: theme.colorScheme.onSurface),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          indicatorColor: theme.colorScheme.primary,
          tabs: const [
            Tab(text: 'Tümü'),
            Tab(text: 'Takip Edilenler'),
            Tab(text: 'Popüler'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPostList(_getFilteredPosts('all')),
          _buildPostList(_getFilteredPosts('following')),
          _buildPostList(_getFilteredPosts('popular')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-post');
        },
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPostList(List<Map<String, dynamic>> posts) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (posts.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _refreshPosts,
      child: ListView.builder(
        controller: _scrollController,
        padding: AppSpacing.pagePadding,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return _buildPostCard(post, index);
        },
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post, int index) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          _buildPostHeader(post, theme),

          // Post Content
          _buildPostContent(post, theme),

          // Post Media
          if (post['media'] != null && (post['media'] as List).isNotEmpty)
            _buildPostMedia(post['media'] as List, theme),

          // Post Actions
          _buildPostActions(post, theme),

          // Post Stats
          _buildPostStats(post, theme),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Map<String, dynamic> post, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // User Avatar
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(post['userAvatar'] ?? ''),
            backgroundColor: theme.colorScheme.primaryContainer,
            child: post['userAvatar'] == null
                ? Text(
                    post['userName'][0].toUpperCase(),
                    style: AppTypography.bodyLarge.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.md),

          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['userName'],
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  post['location'] ?? 'Bilinmeyen Konum',
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Post Time
          Text(
            _formatTime(post['createdAt']),
            style: AppTypography.bodySmall.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          // More Options
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            onSelected: (value) => _handlePostAction(value, post),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('Paylaş'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.report),
                    SizedBox(width: 8),
                    Text('Bildir'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent(Map<String, dynamic> post, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post['content'],
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Tags
          if (post['tags'] != null && (post['tags'] as List).isNotEmpty)
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: (post['tags'] as List)
                  .map<Widget>(
                    (tag) => Chip(
                      label: Text(
                        tag.startsWith('#') ? tag : '#$tag',
                        style: AppTypography.bodySmall.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      backgroundColor: theme.colorScheme.primaryContainer
                          .withValues(alpha: 0.2),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildPostMedia(List media, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      height: 200,
      child: PageView.builder(
        itemCount: media.length,
        itemBuilder: (context, index) {
          final mediaItem = media[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              image: DecorationImage(
                image: NetworkImage(mediaItem['url']),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPostActions(Map<String, dynamic> post, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          // Like Button
          _buildActionButton(
            icon: post['isLiked'] ? Icons.favorite : Icons.favorite_border,
            label: '${post['likeCount']}',
            isActive: post['isLiked'],
            onTap: () => _handleLike(post),
            theme: theme,
          ),

          const SizedBox(width: AppSpacing.lg),

          // Comment Button
          _buildActionButton(
            icon: Icons.comment_outlined,
            label: '${post['commentCount']}',
            isActive: false,
            onTap: () => _handleComment(post),
            theme: theme,
          ),

          const SizedBox(width: AppSpacing.lg),

          // Share Button
          _buildActionButton(
            icon: Icons.share_outlined,
            label: 'Paylaş',
            isActive: false,
            onTap: () => _handleShare(post),
            theme: theme,
          ),

          const Spacer(),

          // Save Button
          _buildActionButton(
            icon: post['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
            label: 'Kaydet',
            isActive: post['isSaved'],
            onTap: () => _handleSave(post),
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
        SoundHapticService.lightImpact();
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostStats(Map<String, dynamic> post, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppSizes.radiusLg),
          bottomRight: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      child: Row(
        children: [
          // Mood
          if (post['mood'] != null)
            Row(
              children: [
                Text(
                  post['mood']['emoji'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 4),
                Text(
                  post['mood']['name'],
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
            ),

          // Activities
          if (post['activities'] != null &&
              (post['activities'] as List).isNotEmpty)
            Expanded(
              child: Text(
                'Aktiviteler: ${(post['activities'] as List).take(3).join(', ')}',
                style: AppTypography.bodySmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.post_add,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Henüz post yok',
            style: AppTypography.titleLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'İlk seyahat deneyiminizi paylaşmaya başlayın!',
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/create-post');
            },
            icon: const Icon(Icons.add),
            label: const Text('İlk Post\'u Oluştur'),
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
  void _loadPosts() async {
    // Simüle edilmiş post yükleme
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _posts.addAll([
          {
            'id': '1',
            'userName': 'Senol Yılmaz',
            'userAvatar': null,
            'content':
                'Paris\'te muhteşem bir gün geçirdim! Eiffel Kulesi\'nin altında romantik bir piknik yaptık. Fransız mutfağının lezzetlerini keşfettik ve Seine Nehri boyunca yürüyüş yaptık. Bu şehir gerçekten büyüleyici! 🇫🇷✨',
            'location': 'Paris, Fransa',
            'createdAt': DateTime.now().subtract(const Duration(hours: 2)),
            'media': [
              {
                'url':
                    'https://images.unsplash.com/photo-1502602898535-fd0b3b7b8b8b?w=800',
              },
            ],
            'tags': ['paris', 'seyahat', 'eiffel', 'fransa'],
            'mood': {'name': 'Excited', 'emoji': '🤩'},
            'activities': ['Kültür', 'Yemek', 'Fotoğrafçılık'],
            'likeCount': 24,
            'commentCount': 8,
            'isLiked': false,
            'isSaved': true,
          },
          {
            'id': '2',
            'userName': 'Ayşe Demir',
            'userAvatar': null,
            'content':
                'Santorini\'de gün batımını izlemek inanılmaz bir deneyimdi. Beyaz evler ve mavi kubbeler arasında kaybolduk. Yerel tavernalarda geleneksel Yunan yemeklerini tattık. Bu ada cennet gibi! 🌅🏝️',
            'location': 'Santorini, Yunanistan',
            'createdAt': DateTime.now().subtract(const Duration(hours: 5)),
            'media': [
              {
                'url':
                    'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=800',
              },
            ],
            'tags': ['santorini', 'yunani', 'gunbatimi', 'ada'],
            'mood': {'name': 'Relaxed', 'emoji': '😌'},
            'activities': ['Doğa', 'Fotoğrafçılık', 'Yemek'],
            'likeCount': 31,
            'commentCount': 12,
            'isLiked': true,
            'isSaved': false,
          },
          {
            'id': '3',
            'userName': 'Mehmet Kaya',
            'userAvatar': null,
            'content':
                'Machu Picchu\'ya tırmanmak hayatımın en zorlu ama en ödüllendirici deneyimiydi. İnka uygarlığının kalıntılarını görmek ve And Dağları\'nın manzarasını izlemek paha biçilemez. Peru\'nun gizemli atmosferi beni büyüledi! 🏔️🌿',
            'location': 'Machu Picchu, Peru',
            'createdAt': DateTime.now().subtract(const Duration(days: 1)),
            'media': [
              {
                'url':
                    'https://images.unsplash.com/photo-1587595431973-160d0d94add1?w=800',
              },
            ],
            'tags': ['machupicchu', 'peru', 'inka', 'andlar'],
            'mood': {'name': 'Adventurous', 'emoji': '🏔️'},
            'activities': ['Doğa', 'Spor', 'Tarih', 'Kültür'],
            'likeCount': 45,
            'commentCount': 18,
            'isLiked': false,
            'isSaved': true,
          },
        ]);
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshPosts() async {
    setState(() {
      _isLoading = true;
      _posts.clear();
    });
    _loadPosts();
  }

  List<Map<String, dynamic>> _getFilteredPosts(String filter) {
    switch (filter) {
      case 'following':
        return _posts
            .where((post) => post['userName'] == 'Senol Yılmaz')
            .toList();
      case 'popular':
        return _posts.where((post) => post['likeCount'] > 20).toList();
      default:
        return _posts;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dk önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else {
      return '${difference.inDays} gün önce';
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrele'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Tümü'),
              value: 'all',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Sadece Fotoğraflar'),
              value: 'photos',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Sadece Videolar'),
              value: 'videos',
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sırala'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('En Yeni'),
              value: 'latest',
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('En Popüler'),
              value: 'popular',
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('En Çok Beğenilen'),
              value: 'mostLiked',
              groupValue: _selectedSort,
              onChanged: (value) {
                setState(() {
                  _selectedSort = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handlePostAction(String action, Map<String, dynamic> post) {
    switch (action) {
      case 'share':
        _handleShare(post);
        break;
      case 'report':
        _handleReport(post);
        break;
    }
  }

  void _handleLike(Map<String, dynamic> post) {
    setState(() {
      post['isLiked'] = !post['isLiked'];
      if (post['isLiked']) {
        post['likeCount']++;
      } else {
        post['likeCount']--;
      }
    });
  }

  void _handleComment(Map<String, dynamic> post) {
    // Comment ekranına git
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Yorum ekranına gidiliyor...')),
    );
  }

  void _handleShare(Map<String, dynamic> post) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Post paylaşılıyor...')));
  }

  void _handleSave(Map<String, dynamic> post) {
    setState(() {
      post['isSaved'] = !post['isSaved'];
    });
  }

  void _handleReport(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post bildirildi'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
