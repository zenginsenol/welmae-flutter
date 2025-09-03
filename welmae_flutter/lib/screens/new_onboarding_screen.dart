import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOnboardingScreen extends StatefulWidget {
  const NewOnboardingScreen({super.key});

  @override
  State<NewOnboardingScreen> createState() => _NewOnboardingScreenState();
}

class _NewOnboardingScreenState extends State<NewOnboardingScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  late AnimationController _animationController;
  late AnimationController _heartbeatController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isPhoneValid = false;
  bool _isLoading = false;

  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeDarkTeal = Color(0xFF027d7d);
  static const Color velmaeLightTeal = Color(0xFF05D1D1);
  static const Color velmaeMint = Color(0xFF10B981);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color backgroundColor = Color(0xFFF8FAFC);
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

    _heartbeatController = AnimationController(
      duration: const Duration(milliseconds: 1600),
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _heartbeatController.repeat(reverse: true);
  }

  void _validatePhone() {
    final phone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    setState(() {
      // Turkish phone numbers: 0 + 10 digits = 11 total digits
      _isPhoneValid = phone.length == 11;
    });
  }

  String _formatPhoneNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return '';

    String formatted = '';
    if (digitsOnly.length >= 1) {
      formatted = '+90 ';
      if (digitsOnly.length > 1) {
        // Handle the leading 0 for Turkish numbers
        if (digitsOnly[0] == '0') {
          formatted += '(${digitsOnly.substring(1, 4)})';
          if (digitsOnly.length > 4) {
            formatted += ' ${digitsOnly.substring(4, 7)}';
            if (digitsOnly.length > 7) {
              formatted += ' ${digitsOnly.substring(7, 9)}';
              if (digitsOnly.length > 9) {
                formatted += ' ${digitsOnly.substring(9, 11)}';
              }
            }
          }
        } else {
          formatted += '(${digitsOnly.substring(0, 3)})';
          if (digitsOnly.length > 3) {
            formatted += ' ${digitsOnly.substring(3, 6)}';
            if (digitsOnly.length > 6) {
              formatted += ' ${digitsOnly.substring(6, 8)}';
              if (digitsOnly.length > 8) {
                formatted += ' ${digitsOnly.substring(8, 10)}';
              }
            }
          }
        }
      }
    }
    return formatted;
  }

  Future<void> _handleContinue() async {
    if (!_isPhoneValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Navigate to OTP verification screen
        Navigator.pushNamed(
          context,
          '/otp-verification',
          arguments: {
            'phoneNumber': _phoneController.text,
            'otpId': 'mock-otp-id-123',
            'expiresAt': DateTime.now().add(const Duration(minutes: 5)),
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heartbeatController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - padding.top - padding.bottom,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),

                          // Header Section
                          _buildHeaderSection(),

                          const SizedBox(height: 60),

                          // Phone Input Section
                          _buildPhoneInputSection(),

                          const SizedBox(height: 40),

                          // Continue Button
                          _buildContinueButton(),

                          const SizedBox(height: 40),

                          // Terms and Privacy
                          _buildTermsSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                offset: const Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: textDark,
          ),
        ),

        const SizedBox(height: 32),

        // Title
        const Text(
          'Telefon Numaranızı\nGirin',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textDark,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 16),

        // Subtitle
        Text(
          'Hesabınıza giriş yapmak için telefon numaranızı girin. Size SMS ile doğrulama kodu göndereceğiz.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textMedium,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Telefon Numaranız',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textDark,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _phoneFocusNode.hasFocus
                  ? velmaeTeal
                  : _isPhoneValid
                  ? successGreen
                  : borderLight,
              width: _phoneFocusNode.hasFocus || _isPhoneValid ? 2 : 1,
            ),
            boxShadow: [
              if (_phoneFocusNode.hasFocus)
                BoxShadow(
                  color: velmaeTeal.withValues(alpha: 0.12),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
            ],
          ),
          child: TextFormField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            onChanged: (value) {
              final formatted = _formatPhoneNumber(value);
              if (formatted != _phoneController.text) {
                _phoneController.value = TextEditingValue(
                  text: formatted,
                  selection: TextSelection.collapsed(offset: formatted.length),
                );
              }
            },
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textDark,
              letterSpacing: 0.5,
            ),
            decoration: InputDecoration(
              hintText: '+90 (5XX) XXX XX XX',
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
                  color: velmaeTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.phone_rounded,
                  color: velmaeTeal,
                  size: 24,
                ),
              ),
              suffixIcon: _isPhoneValid
                  ? Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: successGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: successGreen,
                        size: 24,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: _isPhoneValid
            ? const LinearGradient(
                colors: [velmaeTeal, velmaeMint],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: _isPhoneValid ? null : borderLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _isPhoneValid
            ? [
                BoxShadow(
                  color: velmaeTeal.withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isPhoneValid && !_isLoading ? _handleContinue : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.center,
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    'Devam Et',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _isPhoneValid ? Colors.white : textLight,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsSection() {
    return Column(
      children: [
        Text(
          'Devam ederek Kullanım Koşulları ve Gizlilik Politikamızı kabul etmiş olursunuz.',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: textLight,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zaten hesabınız var mı? ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: textMedium,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to login
                Navigator.pushNamed(context, '/phone-onboarding');
              },
              child: Text(
                'Giriş Yapın',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: velmaeTeal,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
