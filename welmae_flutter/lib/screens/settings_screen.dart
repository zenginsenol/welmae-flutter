import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/theme/typography.dart';
import '../app/theme/theme.dart';
import '../app/theme/dimensions.dart';
import '../shared/constants/app_colors.dart';
import '../shared/constants/app_sizes.dart';
import '../shared/constants/app_spacing.dart';
import '../shared/constants/typography_scale.dart';
import '../providers/app_provider.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _locationServicesEnabled = true;
  String _selectedLanguage = 'Türkçe';
  String _selectedCurrency = 'TRY';

  final List<String> _languages = ['Türkçe', 'English', 'Deutsch', 'Français'];
  final List<String> _currencies = ['TRY', 'USD', 'EUR', 'GBP'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    setState(() {
      _isDarkMode = appProvider.isDarkMode;
      _notificationsEnabled = appProvider.notificationsEnabled;
      _locationServicesEnabled = appProvider.locationServicesEnabled;
      _selectedLanguage = appProvider.selectedLanguage;
      _selectedCurrency = appProvider.selectedCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Ayarlar',
          style: AppTypography.titleLarge.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // User Profile Section
          _buildProfileSection(),
          const SizedBox(height: 32),

          // Appearance Section
          _buildSection(
            title: 'Görünüm',
            children: [
              _buildSwitchTile(
                title: 'Karanlık Tema',
                subtitle: 'Karanlık tema kullan',
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                    appProvider.setDarkMode(value);
                  });
                },
                icon: Icons.dark_mode,
              ),
            ],
          ),

          // Notifications Section
          _buildSection(
            title: 'Bildirimler',
            children: [
              _buildSwitchTile(
                title: 'Bildirimler',
                subtitle: 'Push bildirimleri al',
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                    appProvider.setNotificationsEnabled(value);
                  });
                },
                icon: Icons.notifications,
              ),
            ],
          ),

          // Location Section
          _buildSection(
            title: 'Konum',
            children: [
              _buildSwitchTile(
                title: 'Konum Servisleri',
                subtitle: 'Konum tabanlı öneriler al',
                value: _locationServicesEnabled,
                onChanged: (value) {
                  setState(() {
                    _locationServicesEnabled = value;
                    appProvider.setLocationServicesEnabled(value);
                  });
                },
                icon: Icons.location_on,
              ),
            ],
          ),

          // Language & Region Section
          _buildSection(
            title: 'Dil ve Bölge',
            children: [
              _buildDropdownTile(
                title: 'Dil',
                subtitle: 'Uygulama dili',
                value: _selectedLanguage,
                items: _languages,
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                    appProvider.setSelectedLanguage(value);
                  });
                },
                icon: Icons.language,
              ),
              _buildDropdownTile(
                title: 'Para Birimi',
                subtitle: 'Fiyat para birimi',
                value: _selectedCurrency,
                items: _currencies,
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value!;
                    appProvider.setSelectedCurrency(value);
                  });
                },
                icon: Icons.attach_money,
              ),
            ],
          ),

          // Account Section
          _buildSection(
            title: 'Hesap',
            children: [
              _buildListTile(
                title: 'Profil Bilgileri',
                subtitle: 'Kişisel bilgilerinizi düzenleyin',
                icon: Icons.person,
                onTap: () {
                  Navigator.pushNamed(context, '/profile-edit');
                },
              ),
              _buildListTile(
                title: 'Güvenlik',
                subtitle: 'Şifre ve güvenlik ayarları',
                icon: Icons.security,
                onTap: () {
                  Navigator.pushNamed(context, '/security');
                },
              ),
              _buildListTile(
                title: 'Gizlilik',
                subtitle: 'Gizlilik ayarları',
                icon: Icons.privacy_tip,
                onTap: () {
                  Navigator.pushNamed(context, '/privacy');
                },
              ),
            ],
          ),

          // App Section
          _buildSection(
            title: 'Uygulama',
            children: [
              _buildListTile(
                title: 'Hakkında',
                subtitle: 'Uygulama versiyonu ve bilgileri',
                icon: Icons.info,
                onTap: () {
                  Navigator.pushNamed(context, '/about');
                },
              ),
              _buildListTile(
                title: 'Yardım ve Destek',
                subtitle: 'SSS ve destek ekibi',
                icon: Icons.help,
                onTap: () {
                  Navigator.pushNamed(context, '/help');
                },
              ),
              _buildListTile(
                title: 'Geri Bildirim',
                subtitle: 'Uygulama hakkında görüş bildirin',
                icon: Icons.feedback,
                onTap: () {
                  Navigator.pushNamed(context, '/feedback');
                },
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Logout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: AppColors.error, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Çıkış Yap',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryContainer],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                user?.name.isNotEmpty == true
                    ? user!.name.isNotEmpty
                          ? user.name[0].toUpperCase()
                          : 'S'
                    : 'S',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name.isNotEmpty == true ? user!.name : 'Senol Yılmaz',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email.isNotEmpty == true
                      ? user!.email
                      : 'senol.yilmaz@email.com',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile-edit');
            },
            icon: Icon(Icons.edit, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.bodySmall.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: AppColors.onSurfaceVariant,
        size: 20,
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Çıkış Yap',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          content: Text(
            'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'İptal',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Çıkış işlemi
                Provider.of<UserProvider>(context, listen: false).logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.error),
              ),
              child: Text(
                'Çıkış Yap',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
