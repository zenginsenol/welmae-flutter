import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1>
    with TickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  bool _isFirstNameValid = false;
  bool _isLastNameValid = false;
  bool _isEmailValid = false;
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

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _firstNameController.addListener(_validateFirstName);
    _lastNameController.addListener(_validateLastName);
    _emailController.addListener(_validateEmail);
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

  void _validateFirstName() {
    setState(() {
      _isFirstNameValid = _firstNameController.text.trim().isNotEmpty;
    });
  }

  void _validateLastName() {
    setState(() {
      _isLastNameValid = _lastNameController.text.trim().isNotEmpty;
    });
  }

  void _validateEmail() {
    final email = _emailController.text.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      _isEmailValid = emailRegex.hasMatch(email);
    });
  }

  bool get _isFormValid =>
      _isFirstNameValid && _isLastNameValid && _isEmailValid;

  void _handleContinue() async {
    if (!_isFormValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.mediumImpact();

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 700));

    if (mounted) {
      // Navigate to next step
      Navigator.pushNamed(
        context,
        '/register-step2',
        arguments: {
          'firstName': _firstNameController.text.trim(),
          'lastName': _lastNameController.text.trim(),
          'email': _emailController.text.trim(),
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
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
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: velmaePrimary.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/images/velmae/velmae-app_appicon.png',
          width: 80,
          height: 80,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [velmaePrimary, velmaeSecondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.travel_explore,
                color: Colors.white,
                size: 40,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'Velmae\'ye Hoş Geldiniz',
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
          'Hesabınızı oluşturmak için bilgilerinizi\ngirin',
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
        _buildFirstNameInput(),
        const SizedBox(height: 20),
        _buildLastNameInput(),
        const SizedBox(height: 20),
        _buildEmailInput(),
      ],
    );
  }

  Widget _buildFirstNameInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _firstNameFocusNode.hasFocus
              ? velmaePrimary
              : _isFirstNameValid
              ? successGreen
              : borderLight,
          width: _firstNameFocusNode.hasFocus || _isFirstNameValid ? 2 : 1,
        ),
        boxShadow: [
          if (_firstNameFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _firstNameController,
        focusNode: _firstNameFocusNode,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Adınız',
          hintStyle: const TextStyle(
            fontSize: 18,
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
              Icons.person_outline,
              color: velmaePrimary,
              size: 24,
            ),
          ),
          suffixIcon: _isFirstNameValid
              ? Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: successGreen, size: 24),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildLastNameInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _lastNameFocusNode.hasFocus
              ? velmaePrimary
              : _isLastNameValid
              ? successGreen
              : borderLight,
          width: _lastNameFocusNode.hasFocus || _isLastNameValid ? 2 : 1,
        ),
        boxShadow: [
          if (_lastNameFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _lastNameController,
        focusNode: _lastNameFocusNode,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Soyadınız',
          hintStyle: const TextStyle(
            fontSize: 18,
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
              Icons.person_outline,
              color: velmaePrimary,
              size: 24,
            ),
          ),
          suffixIcon: _isLastNameValid
              ? Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: successGreen, size: 24),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _emailFocusNode.hasFocus
              ? velmaePrimary
              : _isEmailValid
              ? successGreen
              : borderLight,
          width: _emailFocusNode.hasFocus || _isEmailValid ? 2 : 1,
        ),
        boxShadow: [
          if (_emailFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _emailController,
        focusNode: _emailFocusNode,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'E-posta adresiniz',
          hintStyle: const TextStyle(
            fontSize: 18,
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
              Icons.email_outlined,
              color: velmaePrimary,
              size: 24,
            ),
          ),
          suffixIcon: _isEmailValid
              ? Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: successGreen, size: 24),
                )
              : null,
        ),
      ),
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
                    'Devam Et',
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
