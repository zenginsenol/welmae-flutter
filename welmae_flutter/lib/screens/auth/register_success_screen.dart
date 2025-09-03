import 'package:flutter/material.dart';

class RegisterSuccessScreen extends StatefulWidget {
  final String firstName;
  final String email;

  const RegisterSuccessScreen({
    super.key,
    required this.firstName,
    required this.email,
  });

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

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
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
  }

  void _handleContinue() {
    // Navigate to home screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false, // Remove all previous routes
    );
  }

  @override
  void dispose() {
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
                      child: Column(
                        children: [
                          const Spacer(),
                          _buildSuccessIcon(),
                          const SizedBox(height: 40),
                          _buildTitle(),
                          const SizedBox(height: 20),
                          _buildSubtitle(),
                          const SizedBox(height: 40),
                          _buildContinueButton(),
                          const Spacer(),
                          _buildFooter(),
                        ],
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

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: successGreen,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: successGreen.withValues(alpha: 0.3),
              offset: const Offset(0, 12),
              blurRadius: 32,
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
        ),
      ),
      child: Text(
        'Hoş Geldiniz ${widget.firstName}!',
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textDark,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSubtitle() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOutBack),
        ),
      ),
      child: Text(
        '${widget.email} adresine doğrulama e-postası gönderildi.\n\nHesabınız oluşturuldu ve artık Velmae\'yi kullanmaya hazırsınız!',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: textMedium,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContinueButton() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOutBack),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
            onTap: _handleContinue,
            borderRadius: BorderRadius.circular(16),
            child: const Center(
              child: Text(
                'Keşfetmeye Başla',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.7, 1.0, curve: Curves.easeOutBack),
        ),
      ),
      child: const Text(
        'Velmae ile Türkiye\'nin her köşesini\nkeşfedin ve deneyimlerinizi paylaşın.',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: textLight,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}