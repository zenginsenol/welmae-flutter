import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';
import '../services/animation_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<FavoriteDestination> _favorites = [
    FavoriteDestination(
      id: '1',
      name: 'Eiffel Kulesi',
      location: 'Paris, Fransa',
      imageUrl: 'https://images.unsplash.com/photo-1511739001486-6bfe10ce785f',
      rating: 4.8,
      price: '€25',
      category: 'Landmark',
      isFavorite: true,
    ),
    FavoriteDestination(
      id: '2',
      name: 'Louvre Müzesi',
      location: 'Paris, Fransa',
      imageUrl: 'https://images.unsplash.com/photo-1564501049412-61c2a3083791',
      rating: 4.7,
      price: '€17',
      category: 'Museum',
      isFavorite: true,
    ),
    FavoriteDestination(
      id: '3',
      name: 'Santorini',
      location: 'Yunanistan',
      imageUrl: 'https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff',
      rating: 4.9,
      price: '€150',
      category: 'Island',
      isFavorite: true,
    ),
    FavoriteDestination(
      id: '4',
      name: 'Machu Picchu',
      location: 'Peru',
      imageUrl: 'https://images.unsplash.com/photo-1587595431973-160d0d94add1',
      rating: 4.9,
      price: '€50',
      category: 'Archaeological',
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorilerim',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.sort, color: theme.colorScheme.onSurface),
            onPressed: _showSortOptions,
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: theme.colorScheme.onSurface),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: _favorites.isEmpty
          ? _buildEmptyState(theme)
          : _buildFavoritesList(theme),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Henüz Favori Destinasyonunuz Yok',
            style: AppTypography.titleLarge.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Seyahat ederken beğendiğiniz yerleri\nfavorilere ekleyin ve kolayca erişin',
            style: AppTypography.bodyMedium.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed('/explore');
            },
            icon: const Icon(Icons.explore),
            label: const Text('Destinasyonları Keşfet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(ThemeData theme) {
    return ListView.builder(
      padding: AppSpacing.pagePadding,
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        return AnimatedFadeIn(
          duration: Duration(milliseconds: 300 + (index * 100)),
          child: _buildFavoriteCard(_favorites[index], theme),
        );
      },
    );
  }

  Widget _buildFavoriteCard(FavoriteDestination destination, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: InkWell(
        onTap: () {
          // Destinasyon detay sayfasına git
          Navigator.of(
            context,
          ).pushNamed('/destination', arguments: destination.id);
        },
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Görsel
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSizes.radiusLg),
                  ),
                  child: Image.network(
                    destination.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ),

                // Favori butonu
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        destination.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: destination.isFavorite
                            ? Colors.red
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        _toggleFavorite(destination);
                      },
                    ),
                  ),
                ),

                // Kategori etiketi
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Text(
                      destination.category,
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // İçerik
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık ve konum
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.name,
                              style: AppTypography.titleMedium.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    destination.location,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Fiyat
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusSm,
                          ),
                        ),
                        child: Text(
                          destination.price,
                          style: AppTypography.bodyMedium.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Rating ve aksiyonlar
                  Row(
                    children: [
                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            destination.rating.toString(),
                            style: AppTypography.bodyMedium.copyWith(
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' (${(destination.rating * 20).round()})',
                            style: AppTypography.bodySmall.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Aksiyon butonları
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _shareDestination(destination);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () {
                              _showDestinationOptions(destination);
                            },
                          ),
                        ],
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

  void _toggleFavorite(FavoriteDestination destination) {
    setState(() {
      destination.isFavorite = !destination.isFavorite;
    });

    // Provider'a bildir
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    if (destination.isFavorite) {
      appProvider.toggleFavorite(destination.id);
    } else {
      appProvider.toggleFavorite(destination.id);
    }

    // Snackbar göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          destination.isFavorite
              ? '${destination.name} favorilere eklendi'
              : '${destination.name} favorilerden çıkarıldı',
        ),
        backgroundColor: destination.isFavorite
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  void _shareDestination(FavoriteDestination destination) {
    // Paylaşım işlemi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${destination.name} paylaşılıyor...'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _showDestinationOptions(FavoriteDestination destination) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Detayları Görüntüle'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(
                  context,
                ).pushNamed('/destination', arguments: destination.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Paylaş'),
              onTap: () {
                Navigator.pop(context);
                _shareDestination(destination);
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Haritada Göster'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/map');
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favorilerden Çıkar'),
              onTap: () {
                Navigator.pop(context);
                _toggleFavorite(destination);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sıralama Seçenekleri',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('İsme Göre (A-Z)'),
              onTap: () {
                Navigator.pop(context);
                // Sıralama işlemi
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Puana Göre'),
              onTap: () {
                Navigator.pop(context);
                // Sıralama işlemi
              },
            ),
            ListTile(
              leading: const Icon(Icons.attach_money),
              title: const Text('Fiyata Göre'),
              onTap: () {
                Navigator.pop(context);
                // Sıralama işlemi
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Konuma Göre'),
              onTap: () {
                Navigator.pop(context);
                // Sıralama işlemi
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filtreleme Seçenekleri',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Landmark'),
              trailing: Checkbox(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(Icons.museum),
              title: const Text('Museum'),
              trailing: Checkbox(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(Icons.beach_access),
              title: const Text('Island'),
              trailing: Checkbox(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: const Icon(Icons.architecture),
              title: const Text('Archaeological'),
              trailing: Checkbox(value: true, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteDestination {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double rating;
  final String price;
  final String category;
  bool isFavorite;

  FavoriteDestination({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.category,
    this.isFavorite = false,
  });
}
