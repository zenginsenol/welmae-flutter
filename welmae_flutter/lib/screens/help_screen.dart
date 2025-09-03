import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/theme/typography.dart';
import '../app/theme/theme.dart';
import '../app/theme/dimensions.dart';
import '../app/theme/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int _selectedCategory = 0;

  final List<String> _categories = [
    'Genel',
    'Hesap',
    'Ödemeler',
    'Güvenlik',
    'Teknik',
  ];

  final List<Map<String, dynamic>> _helpItems = [
    {
      'title': 'Nasıl başlarım?',
      'subtitle': 'Uygulamayı kullanmaya başlamak için rehber',
      'icon': Icons.play_circle_outline,
      'category': 'Genel',
    },
    {
      'title': 'Profil oluşturma',
      'subtitle': 'Kişisel profilinizi nasıl oluşturursunuz',
      'icon': Icons.person_add_outlined,
      'category': 'Genel',
    },
    {
      'title': 'Hesap ayarları',
      'subtitle': 'Hesap ayarlarınızı nasıl yönetirsiniz',
      'icon': Icons.settings_outlined,
      'category': 'Hesap',
    },
    {
      'title': 'Şifremi unuttum',
      'subtitle': 'Şifrenizi nasıl sıfırlarsınız',
      'icon': Icons.lock_reset_outlined,
      'category': 'Hesap',
    },
    {
      'title': 'Ödeme yöntemleri',
      'subtitle': 'Desteklenen ödeme yöntemleri',
      'icon': Icons.credit_card_outlined,
      'category': 'Ödemeler',
    },
    {
      'title': 'Fatura görüntüleme',
      'subtitle': 'Faturalarınızı nasıl görüntülersiniz',
      'icon': Icons.receipt_long_outlined,
      'category': 'Ödemeler',
    },
    {
      'title': 'İki faktörlü doğrulama',
      'subtitle': 'Hesabınızı nasıl korursunuz',
      'icon': Icons.security,
      'category': 'Güvenlik',
    },
    {
      'title': 'Gizlilik ayarları',
      'subtitle': 'Kişisel verilerinizi nasıl korursunuz',
      'icon': Icons.privacy_tip_outlined,
      'category': 'Güvenlik',
    },
    {
      'title': 'Sıkça sorulan sorular',
      'subtitle': 'En çok sorulan sorular ve cevapları',
      'icon': Icons.help_outline,
      'category': 'Teknik',
    },
    {
      'title': 'Sistem gereksinimleri',
      'subtitle': 'Uygulamayı çalıştırmak için gerekenler',
      'icon': Icons.computer_outlined,
      'category': 'Teknik',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Yardım',
          style: AppTypography.titleLarge.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),
          const SizedBox(height: 16),

          // Categories
          _buildCategories(),
          const SizedBox(height: 16),

          // Help Items
          Expanded(child: _buildHelpItems()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Yardım arayın...',
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.onSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          filled: true,
          fillColor: AppColors.surface,
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                _categories[index],
                style: AppTypography.bodySmall.copyWith(
                  color: isSelected
                      ? AppColors.onPrimary
                      : AppColors.onSurfaceVariant,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = index;
                });
              },
              backgroundColor: AppColors.surfaceVariant,
              selectedColor: AppColors.primary,
              checkmarkColor: AppColors.onPrimary,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHelpItems() {
    final filteredItems = _helpItems
        .where(
          (item) =>
              _selectedCategory == 0 ||
              item['category'] == _categories[_selectedCategory],
        )
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return _buildHelpItem(item);
      },
    );
  }

  Widget _buildHelpItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(item['icon'], color: AppColors.primary, size: 20),
        ),
        title: Text(
          item['title'],
          style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
        ),
        subtitle: Text(
          item['subtitle'],
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: AppColors.onSurfaceVariant,
          size: 20,
        ),
        onTap: () {
          _showHelpDetail(item);
        },
      ),
    );
  }

  void _showHelpDetail(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            item['title'],
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['subtitle'],
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Bu konu hakkında daha fazla bilgi için:',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                _buildHelpAction(
                  title: 'Detaylı rehberi oku',
                  icon: Icons.article_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    // Detaylı rehberi göster
                  },
                ),
                const SizedBox(height: 8),
                _buildHelpAction(
                  title: 'Video izle',
                  icon: Icons.play_circle_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    // Videoyu göster
                  },
                ),
                const SizedBox(height: 8),
                _buildHelpAction(
                  title: 'Destek talebi oluştur',
                  icon: Icons.support_agent_outlined,
                  onTap: () {
                    Navigator.pop(context);
                    _createSupportTicket();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Kapat',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHelpAction({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 20),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.onSurface),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: AppColors.onSurfaceVariant,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  void _createSupportTicket() {
    Navigator.pushNamed(context, '/support-ticket');
  }
}
