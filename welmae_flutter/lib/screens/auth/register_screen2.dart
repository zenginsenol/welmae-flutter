import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const RegisterScreen2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2>
    with TickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
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

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      // Basic password validation: at least 6 characters
      _isPasswordValid = password.length >= 6;
    });
  }

  void _validateConfirmPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    setState(() {
      _isConfirmPasswordValid =
          password == confirmPassword && password.isNotEmpty;
    });
  }

  bool get _isFormValid => _isPasswordValid && _isConfirmPasswordValid;

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
        '/register-step3',
        arguments: {
          'firstName': widget.firstName,
          'lastName': widget.lastName,
          'email': widget.email,
          'password': _passwordController.text,
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
          'Şifre Oluşturun',
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
          'Hesabınızın güvenliği için güçlü bir\\nşifre oluşturun',
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
        _buildPasswordInput(),
        const SizedBox(height: 20),
        _buildConfirmPasswordInput(),
        const SizedBox(height: 20),
        _buildPasswordRequirements(),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _passwordFocusNode.hasFocus
              ? velmaePrimary
              : _isPasswordValid
              ? successGreen
              : borderLight,
          width: _passwordFocusNode.hasFocus || _isPasswordValid ? 2 : 1,
        ),
        boxShadow: [
          if (_passwordFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscurePassword,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Şifreniz',
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
              Icons.lock_outline,
              color: velmaePrimary,
              size: 24,
            ),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: velmaePrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: velmaePrimary,
                    size: 24,
                  ),
                ),
              ),
              if (_isPasswordValid)
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: successGreen, size: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return Container(
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _confirmPasswordFocusNode.hasFocus
              ? velmaePrimary
              : _isConfirmPasswordValid
              ? successGreen
              : borderLight,
          width: _confirmPasswordFocusNode.hasFocus || _isConfirmPasswordValid
              ? 2
              : 1,
        ),
        boxShadow: [
          if (_confirmPasswordFocusNode.hasFocus)
            BoxShadow(
              color: velmaePrimary.withValues(alpha: 0.12),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
        ],
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        focusNode: _confirmPasswordFocusNode,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscureConfirmPassword,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textDark,
        ),
        decoration: InputDecoration(
          hintText: 'Şifrenizi tekrar girin',
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
              Icons.lock_outline,
              color: velmaePrimary,
              size: 24,
            ),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: velmaePrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: velmaePrimary,
                    size: 24,
                  ),
                ),
              ),
              if (_isConfirmPasswordValid)
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: successGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.check, color: successGreen, size: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Şifre Gereksinimleri:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                _passwordController.text.length >= 6
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: _passwordController.text.length >= 6
                    ? successGreen
                    : textLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'En az 6 karakter',
                style: TextStyle(fontSize: 14, color: textMedium),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                _passwordController.text == _confirmPasswordController.text &&
                        _passwordController.text.isNotEmpty
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color:
                    _passwordController.text ==
                            _confirmPasswordController.text &&
                        _passwordController.text.isNotEmpty
                    ? successGreen
                    : textLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Şifreler eşleşiyor',
                style: TextStyle(fontSize: 14, color: textMedium),
              ),
            ],
          ),
        ],
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
