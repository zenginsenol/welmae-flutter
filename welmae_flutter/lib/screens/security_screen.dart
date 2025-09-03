import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app/theme/typography.dart';
import '../app/theme/theme.dart';
import '../app/theme/dimensions.dart';
import '../app/theme/colors.dart';
import '../providers/user_provider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _isTwoFactorEnabled = false;
  bool _isBiometricEnabled = false;
  bool _isFaceIdEnabled = false;
  bool _isFingerprintEnabled = false;
  bool _isLoginNotificationsEnabled = true;
  bool _isSessionTimeoutEnabled = true;
  int _sessionTimeoutMinutes = 30;

  @override
  void initState() {
    super.initState();
    _loadSecuritySettings();
  }

  void _loadSecuritySettings() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (user != null) {
      setState(() {
        _isTwoFactorEnabled = user.isTwoFactorEnabled;
        _isBiometricEnabled = user.isBiometricEnabled;
        _isFaceIdEnabled = user.isFaceIdEnabled;
        _isFingerprintEnabled = user.isFingerprintEnabled;
        _isLoginNotificationsEnabled = user.isLoginNotificationsEnabled;
        _isSessionTimeoutEnabled = user.isSessionTimeoutEnabled;
        _sessionTimeoutMinutes = user.sessionTimeoutMinutes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Güvenlik',
          style: AppTypography.titleLarge.copyWith(color: AppColors.onSurface),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Summary
            _buildSecuritySummary(),
            const SizedBox(height: 32),

            // Authentication Methods
            _buildSectionTitle('Kimlik Doğrulama Yöntemleri'),
            const SizedBox(height: 16),
            _buildAuthenticationSection(),
            const SizedBox(height: 32),

            // Security Settings
            _buildSectionTitle('Güvenlik Ayarları'),
            const SizedBox(height: 16),
            _buildSecuritySettingsSection(),
            const SizedBox(height: 32),

            // Recent Activity
            _buildSectionTitle('Son Aktiviteler'),
            const SizedBox(height: 16),
            _buildRecentActivitySection(),
            const SizedBox(height: 32),

            // Security Actions
            _buildSecurityActions(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySummary() {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.security, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Güvenlik Durumu',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.isTwoFactorEnabled == true
                          ? 'Yüksek güvenlik seviyesi'
                          : 'Orta güvenlik seviyesi',
                      style: AppTypography.bodySmall.copyWith(
                        color: user?.isTwoFactorEnabled == true
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSecurityMetric(
                  title: 'İki Faktörlü',
                  value: user?.isTwoFactorEnabled == true,
                  icon: Icons.verified_user,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSecurityMetric(
                  title: 'Biyometrik',
                  value: user?.isBiometricEnabled == true,
                  icon: Icons.fingerprint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityMetric({
    required String title,
    required bool value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? AppColors.primaryContainer : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? AppColors.primary : AppColors.onSurfaceVariant,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTypography.bodySmall.copyWith(
                color: value ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ),
          Icon(
            value ? Icons.check_circle : Icons.circle_outlined,
            color: value ? AppColors.primary : AppColors.onSurfaceVariant,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.titleMedium.copyWith(
        color: AppColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildAuthenticationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Two-Factor Authentication
          _buildSwitchTile(
            title: 'İki Faktörlü Kimlik Doğrulama',
            subtitle: 'Hesabınıza erişim için ek güvenlik katmanı',
            value: _isTwoFactorEnabled,
            onChanged: (value) {
              setState(() {
                _isTwoFactorEnabled = value;
              });
              _showTwoFactorSetupDialog();
            },
            icon: Icons.verified_user,
          ),
          const SizedBox(height: 16),

          // Biometric Authentication
          _buildBiometricSection(),
        ],
      ),
    );
  }

  Widget _buildBiometricSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Biyometrik Kimlik Doğrulama',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.onSurface),
        ),
        const SizedBox(height: 12),

        // Face ID
        _buildBiometricTile(
          title: 'Face ID',
          subtitle: 'Yüz tanıma ile giriş yap',
          value: _isFaceIdEnabled,
          icon: Icons.face,
          onChanged: (value) {
            setState(() {
              _isFaceIdEnabled = value;
            });
          },
        ),
        const SizedBox(height: 12),

        // Fingerprint
        _buildBiometricTile(
          title: 'Parmak İzi',
          subtitle: 'Parmak izi ile giriş yap',
          value: _isFingerprintEnabled,
          icon: Icons.fingerprint,
          onChanged: (value) {
            setState(() {
              _isFingerprintEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildBiometricTile({
    required String title,
    required String subtitle,
    required bool value,
    required IconData icon,
    required ValueChanged<bool> onChanged,
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

  Widget _buildSecuritySettingsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        children: [
          // Login Notifications
          _buildSwitchTile(
            title: 'Giriş Bildirimleri',
            subtitle: 'Yeni cihazlardan giriş bildirimi al',
            value: _isLoginNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isLoginNotificationsEnabled = value;
              });
            },
            icon: Icons.notifications,
          ),
          const SizedBox(height: 16),

          // Session Timeout
          _buildSwitchTile(
            title: 'Oturum Zaman Aşımı',
            subtitle: 'Belirli süre işlem yapılmazsa oturumu kapat',
            value: _isSessionTimeoutEnabled,
            onChanged: (value) {
              setState(() {
                _isSessionTimeoutEnabled = value;
              });
            },
            icon: Icons.timer,
          ),
          if (_isSessionTimeoutEnabled) ...[
            const SizedBox(height: 12),
            _buildSessionTimeoutSelector(),
          ],
        ],
      ),
    );
  }

  Widget _buildSessionTimeoutSelector() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.timer, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Oturum süresi: $_sessionTimeoutMinutes dakika',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurface,
              ),
            ),
          ),
          PopupMenuButton<int>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),
            onSelected: (value) {
              setState(() {
                _sessionTimeoutMinutes = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 15, child: Text('15 dakika')),
              const PopupMenuItem(value: 30, child: Text('30 dakika')),
              const PopupMenuItem(value: 60, child: Text('1 saat')),
              const PopupMenuItem(value: 120, child: Text('2 saat')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Son Aktiviteler',
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Tüm aktiviteleri göster
                },
                child: Text(
                  'Tümünü Göster',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Activity List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _buildActivityItem(
                device: index == 0
                    ? 'iPhone 13 Pro'
                    : (index == 1 ? 'MacBook Pro' : 'Chrome (Windows)'),
                location: index == 0
                    ? 'İstanbul, Türkiye'
                    : (index == 1 ? 'Berlin, Almanya' : 'New York, ABD'),
                time: index == 0
                    ? '2 saat önce'
                    : (index == 1 ? '1 gün önce' : '3 gün önce'),
                isCurrentDevice: index == 0,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required String device,
    required String location,
    required String time,
    required bool isCurrentDevice,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentDevice
            ? AppColors.primaryContainer
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCurrentDevice ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCurrentDevice ? Icons.phone_iphone : Icons.devices,
              color: isCurrentDevice
                  ? AppColors.onPrimary
                  : AppColors.onSurface,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      device,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isCurrentDevice
                            ? AppColors.onPrimaryContainer
                            : AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isCurrentDevice) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Aktif',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: AppTypography.bodySmall.copyWith(
                    color: isCurrentDevice
                        ? AppColors.onPrimaryContainer
                        : AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.bodySmall.copyWith(
              color: isCurrentDevice
                  ? AppColors.onPrimaryContainer
                  : AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityActions() {
    return Column(
      children: [
        // Change Password
        _buildSecurityAction(
          title: 'Şifre Değiştir',
          subtitle: 'Hesabınızın şifresini güncelleyin',
          icon: Icons.lock_reset,
          onTap: () {
            Navigator.pushNamed(context, '/change-password');
          },
        ),
        const SizedBox(height: 12),

        // Active Sessions
        _buildSecurityAction(
          title: 'Aktif Oturumlar',
          subtitle: 'Tüm cihazlardaki oturumları yönetin',
          icon: Icons.devices,
          onTap: () {
            Navigator.pushNamed(context, '/active-sessions');
          },
        ),
        const SizedBox(height: 12),

        // Login History
        _buildSecurityAction(
          title: 'Giriş Geçmişi',
          subtitle: 'Tüm giriş denemelerini görüntüleyin',
          icon: Icons.history,
          onTap: () {
            Navigator.pushNamed(context, '/login-history');
          },
        ),
      ],
    );
  }

  Widget _buildSecurityAction({
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

  void _showTwoFactorSetupDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'İki Faktörlü Kimlik Doğrulama',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          content: Text(
            _isTwoFactorEnabled
                ? 'İki faktörlü kimlik doğrulama devredilecek. Devam etmek istiyor musunuz?'
                : 'İki faktörlü kimlik doğrulama aktif edilecek. Devam etmek istiyor musunuz?',
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // İki faktörlü kimlik doğrulama ayarları
                final userProvider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );
                userProvider.updateUser({
                  'isTwoFactorEnabled': _isTwoFactorEnabled,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: Text(
                _isTwoFactorEnabled ? 'Devre Dışı Bırak' : 'Aktif Et',
                style: AppTypography.bodyMedium.copyWith(
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
