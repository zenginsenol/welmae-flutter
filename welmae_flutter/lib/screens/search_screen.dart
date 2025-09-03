import 'package:flutter/material.dart';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _recentSearches = [
    'Paris, Fransa',
    'Tokyo, Japonya',
    'New York, ABD',
    'İstanbul, Türkiye',
    'Londra, İngiltere',
  ];

  final List<String> _popularDestinations = [
    'Bali, Endonezya',
    'Santorini, Yunanistan',
    'Machu Picchu, Peru',
    'Petra, Ürdün',
    'Angkor Wat, Kamboçya',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isNotEmpty && !_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 10) {
          _recentSearches.removeLast();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arama',
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
      ),
      body: Column(
        children: [
          // Arama Çubuğu
          Container(
            padding: AppSpacing.pagePadding,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Nereye gitmek istiyorsunuz?',
                hintStyle: AppTypography.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
              ),
              style: AppTypography.bodyLarge.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              onChanged: _performSearch,
              onSubmitted: _performSearch,
            ),
          ),

          // Son Aramalar
          if (_recentSearches.isNotEmpty)
            _buildSection(
              title: 'Son Aramalar',
              items: _recentSearches,
              onTap: (item) => _performSearch(item),
              showDelete: true,
            ),

          // Popüler Destinasyonlar
          _buildSection(
            title: 'Popüler Destinasyonlar',
            items: _popularDestinations,
            onTap: (item) => _performSearch(item),
            showDelete: false,
          ),

          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<String> items,
    required Function(String) onTap,
    required bool showDelete,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppSpacing.pagePadding,
          child: Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: Icon(
                title == 'Son Aramalar' ? Icons.history : Icons.trending_up,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                item,
                style: AppTypography.bodyMedium.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              trailing: showDelete
                  ? IconButton(
                      icon: Icon(
                        Icons.close,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () {
                        setState(() {
                          _recentSearches.remove(item);
                        });
                      },
                    )
                  : null,
              onTap: () => onTap(item),
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
