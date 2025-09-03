import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _privateProfile = false;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _selectedLanguage = 'Türkçe';

  // Velmae Brand Colors
  static const Color velmaePrimary = Color(0xFF2563EB);
  static const Color velmaeSecondary = Color(0xFF10B981);
  static const Color velmaeAccent = Color(0xFFEF4444);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMedium = Color(0xFF475569);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection('Gizlilik', [
              _buildSwitchTile(
                'Özel Profil',
                'Profilinizi sadece takipçileriniz görebilir',
                _privateProfile,
                (value) => setState(() => _privateProfile = value),
                Icons.lock,
              ),
              _buildSwitchTile(
                'Konum Paylaşımı',
                'Konumunuzu diğer kullanıcılarla paylaşın',
                _locationEnabled,
                (value) => setState(() => _locationEnabled = value),
                Icons.location_on,
              ),
            ]),
            _buildSection('Bildirimler', [
              _buildSwitchTile(
                'Push Bildirimleri',
                'Anlık bildirimler alın',
                _pushNotifications,
                (value) => setState(() => _pushNotifications = value),
                Icons.notifications,
              ),
              _buildSwitchTile(
                'E-posta Bildirimleri',
                'E-posta ile bildirim alın',
                _emailNotifications,
                (value) => setState(() => _emailNotifications = value),
                Icons.email,
              ),
            ]),
            _buildSection('Uygulama', [
              _buildLanguageTile(),
              _buildTile(
                'Tema',
                'Açık tema',
                Icons.palette,
                () => _showThemeOptions(),
              ),
            ]),
            _buildSection('Hesap', [
              _buildTile(
                'Hesap Bilgileri',
                'Hesap detaylarını görüntüle',
                Icons.account_circle,
                () => Navigator.pushNamed(context, '/profile-edit'),
              ),
              _buildTile(
                'Güvenlik',
                'Şifre ve güvenlik ayarları',
                Icons.security,
                () => _showSecurityOptions(),
              ),
              _buildTile(
                'Veri İndirme',
                'Verilerinizi indirin',
                Icons.download,
                () => _downloadData(),
              ),
            ]),
            _buildSection('Destek', [
              _buildTile(
                'Yardım Merkezi',
                'SSS ve yardım konuları',
                Icons.help,
                () => _showHelp(),
              ),
              _buildTile(
                'İletişim',
                'Bizimle iletişime geçin',
                Icons.contact_support,
                () => _contactSupport(),
              ),
              _buildTile(
                'Geri Bildirim',
                'Görüşlerinizi paylaşın',
                Icons.feedback,
                () => _sendFeedback(),
              ),
            ]),
            _buildSection('Yasal', [
              _buildTile(
                'Kullanım Koşulları',
                'Şartlar ve koşullar',
                Icons.description,
                () => _showTerms(),
              ),
              _buildTile(
                'Gizlilik Politikası',
                'Veri koruma politikası',
                Icons.privacy_tip,
                () => _showPrivacyPolicy(),
              ),
            ]),
            _buildDangerSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: surfaceWhite,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: textDark,
            size: 18,
          ),
        ),
      ),
      title: const Text(
        'Ayarlar',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textDark,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: borderLight)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: velmaePrimary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: textMedium),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: velmaePrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: velmaePrimary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: textMedium),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile() {
    return GestureDetector(
      onTap: _showLanguageOptions,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: backgroundLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.language, color: velmaePrimary, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dil',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedLanguage,
                    style: const TextStyle(fontSize: 12, color: textMedium),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: velmaeAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Hesap İşlemleri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: velmaeAccent,
              ),
            ),
          ),
          _buildDangerTile(
            'Çıkış Yap',
            'Hesabınızdan güvenli şekilde çıkış yapın',
            Icons.logout,
            _logout,
          ),
          _buildDangerTile(
            'Hesabı Sil',
            'Hesabınızı kalıcı olarak silin',
            Icons.delete_forever,
            _deleteAccount,
          ),
        ],
      ),
    );
  }

  Widget _buildDangerTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: borderLight)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: velmaeAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: velmaeAccent, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: velmaeAccent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: textMedium),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
          ],
        ),
      ),
    );
  }

  void _showLanguageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Dil Seçin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              ...['Türkçe', 'English', 'Deutsch'].map((lang) {
                return ListTile(
                  title: Text(lang),
                  trailing: _selectedLanguage == lang
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    setState(() => _selectedLanguage = lang);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showThemeOptions() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Tema seçenekleri yakında!')));
  }

  void _showSecurityOptions() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Güvenlik ayarları yakında!')));
  }

  void _downloadData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Veri indirme özelliği yakında!')),
    );
  }

  void _showHelp() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Yardım merkezi yakında!')));
  }

  void _contactSupport() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Destek sistemi yakında!')));
  }

  void _sendFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Geri bildirim sistemi yakında!')),
    );
  }

  void _showTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kullanım koşulları yakında!')),
    );
  }

  void _showPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gizlilik politikası yakında!')),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış Yap'),
        content: const Text(
          'Hesabınızdan çıkış yapmak istediğinizden emin misiniz?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            style: ElevatedButton.styleFrom(backgroundColor: velmaeAccent),
            child: const Text(
              'Çıkış Yap',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hesabı Sil', style: TextStyle(color: velmaeAccent)),
        content: const Text(
          'Bu işlem geri alınamaz. Tüm verileriniz kalıcı olarak silinecek.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hesap silme işlemi yakında!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: velmaeAccent),
            child: const Text('Sil', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
