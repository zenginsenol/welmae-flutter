import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<MapLocation> _locations = [
    MapLocation(
      id: '1',
      name: 'Eiffel Kulesi',
      description: 'Paris\'in simgesi',
      latitude: 48.8584,
      longitude: 2.2945,
      type: LocationType.landmark,
      rating: 4.8,
    ),
    MapLocation(
      id: '2',
      name: 'Louvre Müzesi',
      description: 'Dünyanın en büyük sanat müzesi',
      latitude: 48.8606,
      longitude: 2.3376,
      type: LocationType.museum,
      rating: 4.7,
    ),
    MapLocation(
      id: '3',
      name: 'Notre Dame',
      description: 'Gotik mimarinin şaheseri',
      latitude: 48.8530,
      longitude: 2.3499,
      type: LocationType.church,
      rating: 4.6,
    ),
    MapLocation(
      id: '4',
      name: 'Arc de Triomphe',
      description: 'Zafer takı',
      latitude: 48.8738,
      longitude: 2.2950,
      type: LocationType.landmark,
      rating: 4.5,
    ),
  ];

  MapLocation? _selectedLocation;
  bool _isMapFullscreen = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Harita',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isMapFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              setState(() {
                _isMapFullscreen = !_isMapFullscreen;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Harita Alanı (Placeholder)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSizes.radiusLg),
              ),
              child: Stack(
                children: [
                  // Harita Placeholder
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Harita Yükleniyor...',
                          style: AppTypography.titleMedium.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Google Maps entegrasyonu yakında',
                          style: AppTypography.bodyMedium.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Konum İşaretçileri
                  ..._locations.map(
                    (location) => _buildLocationMarker(location, theme),
                  ),
                ],
              ),
            ),
          ),

          // Konum Listesi
          if (!_isMapFullscreen) ...[
            Container(
              height: 200,
              padding: AppSpacing.pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yakındaki Yerler',
                    style: AppTypography.titleMedium.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _locations.length,
                      itemBuilder: (context, index) {
                        return _buildLocationCard(_locations[index], theme);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLocationDialog,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add_location),
      ),
    );
  }

  Widget _buildLocationMarker(MapLocation location, ThemeData theme) {
    final isSelected = _selectedLocation?.id == location.id;

    return Positioned(
      left: (location.longitude + 180) * 2, // Basit konum hesaplama
      top: (90 - location.latitude) * 2,
      child: GestureDetector(
        onTap: () => _selectLocation(location),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            _getLocationIcon(location.type),
            size: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard(MapLocation location, ThemeData theme) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () => _selectLocation(location),
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getLocationIcon(location.type),
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        location.name,
                        style: AppTypography.bodyLarge.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  location.description,
                  style: AppTypography.bodySmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      location.rating.toString(),
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${location.latitude.toStringAsFixed(2)}, ${location.longitude.toStringAsFixed(2)}',
                      style: AppTypography.bodySmall.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getLocationIcon(LocationType type) {
    switch (type) {
      case LocationType.landmark:
        return Icons.location_on;
      case LocationType.museum:
        return Icons.museum;
      case LocationType.church:
        return Icons.church;
      case LocationType.restaurant:
        return Icons.restaurant;
      case LocationType.hotel:
        return Icons.hotel;
      case LocationType.shop:
        return Icons.shopping_bag;
    }
  }

  void _selectLocation(MapLocation location) {
    setState(() {
      _selectedLocation = location;
    });

    _showLocationDetails(location);
  }

  void _showLocationDetails(MapLocation location) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLg),
        ),
      ),
      builder: (context) => Container(
        padding: AppSpacing.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Başlık
            Text(
              location.name,
              style: AppTypography.titleLarge.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),

            // Açıklama
            Text(
              location.description,
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Detaylar
            Row(
              children: [
                Icon(Icons.star, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${location.rating} / 5.0',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                Icon(Icons.location_on, color: theme.colorScheme.secondary),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '${location.latitude.toStringAsFixed(4)}, ${location.longitude.toStringAsFixed(4)}',
                  style: AppTypography.bodyMedium.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Aksiyon Butonları
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Rota planlama
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Rota Planla'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // Favorilere ekle
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('Favorilere Ekle'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  void _showAddLocationDialog() {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Yeni Konum Ekle',
          style: AppTypography.titleLarge.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Konum Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              decoration: InputDecoration(
                labelText: 'Açıklama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'İptal',
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Konum ekleme işlemi
            },
            child: Text(
              'Ekle',
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum LocationType { landmark, museum, church, restaurant, hotel, shop }

class MapLocation {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final LocationType type;
  final double rating;

  const MapLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.rating,
  });
}
