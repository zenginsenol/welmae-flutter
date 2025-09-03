import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Form focus nodes
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _locationFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  String _selectedGender = 'Kadın';
  DateTime? _birthDate;
  String _selectedInterests = '';
  bool _isGuideAccount = false;
  bool _isPrivateAccount = false;
  bool _showEmail = true;
  bool _showPhone = false;

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

  final List<String> genderOptions = [
    'Kadın',
    'Erkek',
    'Diğer',
    'Belirtmek İstemiyorum',
  ];
  final List<String> interestOptions = [
    'Şehir Turları',
    'Doğa Gezileri',
    'Kültür Turları',
    'Macera Sporları',
    'Deniz Tatili',
    'Dağ Tırmanışı',
    'Fotoğrafçılık',
    'Yemek Kültürü',
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadUserData();
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

  void _loadUserData() {
    // Load existing user data - replace with backend call
    _nameController.text = 'Ayşe Kaya';
    _usernameController.text = 'aysekaya';
    _bioController.text =
        'Seyahat tutkunu, fotoğraf meraklısı. Yeni yerler keşfetmeyi ve anılarımı paylaşmayı seviyorum.';
    _locationController.text = 'İstanbul, Türkiye';
    _phoneController.text = '+90 (555) 123 45 67';
    _emailController.text = 'ayse.kaya@email.com';
    _birthDate = DateTime(1995, 5, 15);
    _selectedInterests = 'Şehir Turları, Fotoğrafçılık, Yemek Kültürü';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _bioFocus.dispose();
    _locationFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: _buildAppBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfilePictureSection(),
                    const SizedBox(height: 32),
                    _buildBasicInfoSection(),
                    const SizedBox(height: 24),
                    _buildContactInfoSection(),
                    const SizedBox(height: 24),
                    _buildPersonalInfoSection(),
                    const SizedBox(height: 24),
                    _buildInterestsSection(),
                    const SizedBox(height: 24),
                    _buildAccountSettingsSection(),
                    const SizedBox(height: 32),
                    _buildSaveButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
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
        'Profili Düzenle',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: _handleSave,
          child: const Text(
            'Kaydet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: velmaePrimary,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildProfilePictureSection() {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: borderLight, width: 3),
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
                    child: const Icon(Icons.person, color: textLight, size: 60),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _changeProfilePicture,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: velmaePrimary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: velmaePrimary.withValues(alpha: 0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Profil fotoğrafınızı değiştirin',
            style: TextStyle(fontSize: 14, color: textMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: 'Temel Bilgiler',
      children: [
        _buildTextField(
          label: 'Ad Soyad',
          controller: _nameController,
          focusNode: _nameFocus,
          icon: Icons.person,
          hint: 'Adınızı ve soyadınızı girin',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Kullanıcı Adı',
          controller: _usernameController,
          focusNode: _usernameFocus,
          icon: Icons.alternate_email,
          hint: 'Benzersiz kullanıcı adınız',
          prefix: '@',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Biyografi',
          controller: _bioController,
          focusNode: _bioFocus,
          icon: Icons.edit,
          hint: 'Kendinizi tanıtın...',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return _buildSection(
      title: 'İletişim Bilgileri',
      children: [
        _buildTextField(
          label: 'Konum',
          controller: _locationController,
          focusNode: _locationFocus,
          icon: Icons.location_on,
          hint: 'Bulunduğunuz şehir',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Telefon',
          controller: _phoneController,
          focusNode: _phoneFocus,
          icon: Icons.phone,
          hint: '+90 (5XX) XXX XX XX',
          suffix: _buildVisibilityToggle(_showPhone, (value) {
            setState(() {
              _showPhone = value;
            });
          }),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'E-posta',
          controller: _emailController,
          focusNode: _emailFocus,
          icon: Icons.email,
          hint: 'email@example.com',
          suffix: _buildVisibilityToggle(_showEmail, (value) {
            setState(() {
              _showEmail = value;
            });
          }),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      title: 'Kişisel Bilgiler',
      children: [
        _buildDropdownField(
          label: 'Cinsiyet',
          value: _selectedGender,
          items: genderOptions,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        _buildDateField(
          label: 'Doğum Tarihi',
          date: _birthDate,
          onTap: _selectBirthDate,
          icon: Icons.cake,
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    return _buildSection(
      title: 'İlgi Alanları',
      children: [
        GestureDetector(
          onTap: _selectInterests,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderLight),
            ),
            child: Row(
              children: [
                const Icon(Icons.interests, color: velmaePrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'İlgi Alanları',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedInterests.isEmpty
                            ? 'İlgi alanlarınızı seçin'
                            : _selectedInterests,
                        style: TextStyle(
                          fontSize: 14,
                          color: _selectedInterests.isEmpty
                              ? textLight
                              : textMedium,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: textLight, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSettingsSection() {
    return _buildSection(
      title: 'Hesap Ayarları',
      children: [
        _buildSwitchTile(
          title: 'Rehber Hesabı',
          subtitle: 'Diğer kullanıcılara rehberlik hizmeti sunun',
          value: _isGuideAccount,
          onChanged: (value) {
            setState(() {
              _isGuideAccount = value;
            });
          },
          icon: Icons.tour,
        ),
        const SizedBox(height: 12),
        _buildSwitchTile(
          title: 'Özel Hesap',
          subtitle: 'Profilinizi yalnızca takipçilerinizle paylaşın',
          value: _isPrivateAccount,
          onChanged: (value) {
            setState(() {
              _isPrivateAccount = value;
            });
          },
          icon: Icons.lock,
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required String hint,
    String? prefix,
    Widget? suffix,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLight),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: textLight),
              prefixIcon: Icon(icon, color: velmaePrimary),
              prefixText: prefix,
              suffixIcon: suffix,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderLight),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: velmaePrimary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            items: items.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderLight),
            ),
            child: Row(
              children: [
                Icon(icon, color: velmaePrimary),
                const SizedBox(width: 12),
                Text(
                  date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Doğum tarihinizi seçin',
                  style: TextStyle(
                    fontSize: 16,
                    color: date != null ? textDark : textLight,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.calendar_today, color: textLight, size: 16),
              ],
            ),
          ),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, color: velmaePrimary),
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

  Widget _buildVisibilityToggle(bool isVisible, ValueChanged<bool> onChanged) {
    return IconButton(
      onPressed: () => onChanged(!isVisible),
      icon: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: isVisible ? velmaePrimary : textLight,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [velmaePrimary, velmaeSecondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: velmaePrimary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleSave,
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Değişiklikleri Kaydet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeProfilePicture() {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil fotoğrafı değiştirme özelliği yakında!'),
        backgroundColor: velmaePrimary,
      ),
    );
  }

  void _selectBirthDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _selectInterests() {
    showModalBottomSheet(
      context: context,
      backgroundColor: surfaceWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final selectedList = _selectedInterests
            .split(', ')
            .where((s) => s.isNotEmpty)
            .toList();
        final tempSelected = Set<String>.from(selectedList);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: borderLight,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'İlgi Alanlarınızı Seçin',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: interestOptions.length,
                      itemBuilder: (context, index) {
                        final interest = interestOptions[index];
                        final isSelected = tempSelected.contains(interest);

                        return CheckboxListTile(
                          title: Text(interest),
                          value: isSelected,
                          onChanged: (value) {
                            setModalState(() {
                              if (value == true) {
                                tempSelected.add(interest);
                              } else {
                                tempSelected.remove(interest);
                              }
                            });
                          },
                          activeColor: velmaePrimary,
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('İptal'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedInterests = tempSelected.join(', ');
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: velmaePrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Kaydet',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleSave() {
    HapticFeedback.mediumImpact();

    // Validate form
    if (_nameController.text.isEmpty || _usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ad Soyad ve Kullanıcı Adı alanları zorunludur!'),
          backgroundColor: velmaeAccent,
        ),
      );
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profil bilgileriniz başarıyla güncellendi!'),
        backgroundColor: velmaeSecondary,
      ),
    );

    Navigator.pop(context);
  }
}
