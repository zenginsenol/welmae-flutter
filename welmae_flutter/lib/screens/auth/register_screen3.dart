import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterScreen3 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const RegisterScreen3({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterScreen3> createState() => _RegisterScreen3State();
}

class _RegisterScreen3State extends State<RegisterScreen3>
    with TickerProviderStateMixin {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final FocusNode _bioFocusNode = FocusNode();
  final FocusNode _locationFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  File? _profileImage;
  String? _selectedGender;
  DateTime? _selectedBirthDate;
  List<String> _selectedInterests = [];
  bool _isLoading = false;

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
  static const Color successGreen = Color(0xFF059669);
  static const Color errorRed = Color(0xFFDC2626);

  // Sample interests for selection
  final List<String> _interests = [
    'Dağcılık',
    'Kamp',
    'Plaj',
    'Tarih',
    'Kültür',
    'Yemek',
    'Fotoğrafçılık',
    'Yürüyüş',
    'Bisiklet',
    'Kayak',
    'Sörf',
    'Yüzme',
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
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

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Görsel seçilirken bir hata oluştu'),
            backgroundColor: errorRed,
          ),
        );
      }
    }
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(
        const Duration(days: 365 * 13),
      ), // At least 13 years old
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: velmaePrimary,
              onPrimary: Colors.white,
              surface: surfaceWhite,
              onSurface: textDark,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: velmaePrimary),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedBirthDate) {
      setState(() {
        _selectedBirthDate = picked;
      });
    }
  }

  void _toggleInterest(String interest) {
    setState(() {
      if (_selectedInterests.contains(interest)) {
        _selectedInterests.remove(interest);
      } else {
        if (_selectedInterests.length < 5) {
          // Limit to 5 interests
          _selectedInterests.add(interest);
        }
      }
    });
  }

  bool get _isFormValid {
    // At least one of profile image, bio, location, gender, birth date or interests should be filled
    return _profileImage != null ||
        _bioController.text.trim().isNotEmpty ||
        _locationController.text.trim().isNotEmpty ||
        _selectedGender != null ||
        _selectedBirthDate != null ||
        _selectedInterests.isNotEmpty;
  }

  void _handleContinue() async {
    if (!_isFormValid && !_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.mediumImpact();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      // Navigate to success screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/register-success',
        (route) => false, // Remove all previous routes
        arguments: {'firstName': widget.firstName, 'email': widget.email},
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    _locationController.dispose();
    _bioFocusNode.dispose();
    _locationFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: backgroundLight,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    velmaePrimary.withValues(alpha: 0.1),
                    backgroundLight,
                    velmaeSecondary.withValues(alpha: 0.05),
                  ],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          size.height - padding.top - padding.bottom - 80.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        32.0,
                        padding.top + 40.0,
                        32.0,
                        padding.bottom + 40.0,
                      ),
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Column(
                          children: [
                            _buildHeader(),
                            const SizedBox(height: 40),
                            _buildLogo(),
                            const SizedBox(height: 32),
                            _buildTitle(),
                            const SizedBox(height: 32),
                            _buildForm(),
                            const SizedBox(height: 32),
                            _buildContinueButton(),
                            const SizedBox(height: 24),
                            _buildFooter(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: textDark,
              size: 20,
            ),
          ),
        ),
        const Spacer(),
        const Text(
          'Hesap Oluştur',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const Spacer(),
        const SizedBox(width: 44),
      ],
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.3),
              offset: const Offset(0, 8),
              blurRadius: 24,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: _profileImage != null
              ? Image.file(
                  _profileImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/velmae/velmae-app_appicon.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [velmaePrimary, velmaeSecondary],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'Profilinizi Tamamlayın',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: textDark,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          'Profilinizi tamamlayarak diğer kullanıcılarla\\ndaha iyi bağlantı kurabilirsiniz',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textMedium,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _buildBioInput(),
        const SizedBox(height: 20),
        _buildLocationInput(),
        const SizedBox(height: 20),
        _buildGenderSelector(),
        const SizedBox(height: 20),
        _buildBirthDateSelector(),
        const SizedBox(height: 20),
        _buildInterestsSelector(),
      ],
    );
  }

  Widget _buildBioInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _bioFocusNode.hasFocus ? velmaePrimary : borderLight,
          width: _bioFocusNode.hasFocus ? 2 : 1,
        ),
        boxShadow: [
          if (_bioFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _bioController,
        focusNode: _bioFocusNode,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Kendinizi tanıtın...',
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textLight,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: velmaePrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: velmaePrimary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _locationFocusNode.hasFocus ? velmaePrimary : borderLight,
          width: _locationFocusNode.hasFocus ? 2 : 1,
        ),
        boxShadow: [
          if (_locationFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _locationController,
        focusNode: _locationFocusNode,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Şehir',
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textLight,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          prefixIcon: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: velmaePrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.location_on_outlined,
              color: velmaePrimary,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cinsiyet',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildGenderOption('Erkek', 'male'),
            const SizedBox(width: 16),
            _buildGenderOption('Kadın', 'female'),
            const SizedBox(width: 16),
            _buildGenderOption('Diğer', 'other'),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String label, String value) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = isSelected ? null : value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? velmaePrimary : surfaceWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? velmaePrimary : borderLight,
            width: isSelected ? 0 : 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : textDark,
          ),
        ),
      ),
    );
  }

  Widget _buildBirthDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Doğum Tarihi',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _selectBirthDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _selectedBirthDate != null ? successGreen : borderLight,
                width: _selectedBirthDate != null ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: velmaePrimary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedBirthDate != null
                        ? '${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
                        : 'Tarih seçin',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _selectedBirthDate != null ? textDark : textLight,
                    ),
                  ),
                ),
                if (_selectedBirthDate != null)
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: successGreen,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'İlgi Alanları (En fazla 5)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _interests
              .map(
                (interest) => GestureDetector(
                  onTap: () => _toggleInterest(interest),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedInterests.contains(interest)
                          ? velmaePrimary
                          : surfaceWhite,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _selectedInterests.contains(interest)
                            ? velmaePrimary
                            : borderLight,
                        width: _selectedInterests.contains(interest) ? 0 : 1,
                      ),
                    ),
                    child: Text(
                      interest,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: _selectedInterests.contains(interest)
                            ? Colors.white
                            : textDark,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: _isFormValid
            ? LinearGradient(
                colors: [velmaePrimary, velmaeSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: _isFormValid ? null : borderLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _isFormValid
            ? [
                BoxShadow(
                  color: velmaePrimary.withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isFormValid && !_isLoading ? _handleContinue : null,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    'Hesap Oluştur',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _isFormValid ? Colors.white : textLight,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/login');
      },
      child: RichText(
        text: const TextSpan(
          text: 'Zaten hesabınız var mı? ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textMedium,
          ),
          children: [
            TextSpan(
              text: 'Giriş Yapın',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: velmaePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
