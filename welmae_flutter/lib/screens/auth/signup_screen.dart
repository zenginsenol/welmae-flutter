import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  late AnimationController _animationController;
  late AnimationController _shakeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _shakeAnimation;
  bool _isPhoneValid = false;
  bool _isLoading = false;
  bool _acceptTerms = false;

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
    _phoneController.addListener(_validatePhone);
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
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

    _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticInOut),
    );

    _animationController.forward();
  }

  void _validatePhone() {
    final phone = _phoneController.text.replaceAll(RegExp(r'[^\\d]'), '');
    setState(() {
      _isPhoneValid = phone.length == 11;
    });
  }

  String _formatPhoneNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^\\d]'), '');
    if (digitsOnly.isEmpty) return '';

    String formatted = '';
    if (digitsOnly.length >= 1) {
      formatted = '+90 ';
      if (digitsOnly.length > 1) {
        String phoneDigits = digitsOnly;
        if (phoneDigits.startsWith('0')) {
          phoneDigits = phoneDigits.substring(1);
        }

        if (phoneDigits.length >= 1) {
          final part1 = phoneDigits.substring(
            0,
            phoneDigits.length.clamp(0, 3),
          );
          formatted += '($part1';
          if (phoneDigits.length > 3) {
            formatted += ') ';
            final part2 = phoneDigits.substring(
              3,
              phoneDigits.length.clamp(0, 6),
            );
            formatted += part2;
            if (phoneDigits.length > 6) {
              formatted += ' ';
              final part3 = phoneDigits.substring(
                6,
                phoneDigits.length.clamp(0, 8),
              );
              formatted += part3;
              if (phoneDigits.length > 8) {
                formatted += ' ';
                final part4 = phoneDigits.substring(
                  8,
                  phoneDigits.length.clamp(0, 10),
                );
                formatted += part4;
              }
            }
          }
        }
      }
    }
    return formatted;
  }

  void _handleSignup() async {
    if (!_isPhoneValid || !_acceptTerms || _isLoading) {
      _shakeController.forward().then((_) => _shakeController.reset());
      return;
    }

    setState(() {
      _isLoading = true;
    });

    HapticFeedback.mediumImpact();

    final cleanPhone = _phoneController.text.replaceAll(RegExp(r'[^\\d]'), '');
    String phoneNumber = cleanPhone;

    if (phoneNumber.startsWith('0')) {
      phoneNumber = '+90${phoneNumber.substring(1)}';
    } else if (!phoneNumber.startsWith('90')) {
      phoneNumber = '+90$phoneNumber';
    } else {
      phoneNumber = '+$phoneNumber';
    }

    await Future.delayed(const Duration(milliseconds: 700));

    if (mounted) {
      Navigator.pushNamed(
        context,
        '/otp-verification',
        arguments: {
          'phoneNumber': phoneNumber,
          'otpId': 'mock_otp_id_${DateTime.now().millisecondsSinceEpoch}',
          'expiresAt': DateTime.now()
              .add(const Duration(minutes: 5))
              .toIso8601String(),
          'isSignup': true,
        },
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _animationController.dispose();
    _shakeController.dispose();
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
                            _buildPhoneInput(),
                            const SizedBox(height: 24),
                            _buildTermsCheckbox(),
                            const SizedBox(height: 32),
                            _buildSignupButton(),
                            const SizedBox(height: 24),
                            _buildAlternativeOptions(),
                            const Spacer(),
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
          'Telefon numaranızla hızlıca\\nhesap oluşturun ve keşfe başlayın',
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

  Widget _buildPhoneInput() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _shakeAnimation.value * 10 * (1 - _shakeAnimation.value),
            0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: surfaceWhite,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isPhoneValid
                    ? successGreen
                    : _phoneFocusNode.hasFocus
                    ? velmaePrimary
                    : borderLight,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textDark,
                letterSpacing: 0.5,
              ),
              decoration: InputDecoration(
                hintText: '+90 (5XX) XXX XX XX',
                hintStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textLight,
                ),
                prefixIcon: Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(left: 20, right: 16),
                  child: const Center(
                    child: Icon(Icons.phone, color: velmaePrimary, size: 24),
                  ),
                ),
                suffixIcon: _isPhoneValid
                    ? Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(right: 20),
                        child: const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: successGreen,
                            size: 24,
                          ),
                        ),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20,
                ),
              ),
              onChanged: (value) {
                final formatted = _formatPhoneNumber(value);
                if (formatted != value) {
                  _phoneController.value = TextEditingValue(
                    text: formatted,
                    selection: TextSelection.collapsed(
                      offset: formatted.length,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTermsCheckbox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _acceptTerms = !_acceptTerms;
        });
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: _acceptTerms ? velmaePrimary : Colors.transparent,
              border: Border.all(
                color: _acceptTerms ? velmaePrimary : borderLight,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: _acceptTerms
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                text: 'Kullanım Koşulları ve ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: textMedium,
                ),
                children: [
                  TextSpan(
                    text: 'Gizlilik Politikası',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: velmaePrimary,
                    ),
                  ),
                  TextSpan(
                    text: "'nı kabul ediyorum",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: textMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    final bool isEnabled = _isPhoneValid && _acceptTerms;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? LinearGradient(
                colors: [velmaePrimary, velmaeSecondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: isEnabled ? null : borderLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isEnabled
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
          onTap: isEnabled ? _handleSignup : null,
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
                      color: isEnabled ? Colors.white : textLight,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlternativeOptions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 1, color: borderLight)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'veya',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textLight,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: borderLight)),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
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
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Text(
      'Velmae ile Türkiye\'nin her köşesini\\nkeşfedin ve deneyimlerinizi paylaşın.',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textLight,
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    );
  }
}
