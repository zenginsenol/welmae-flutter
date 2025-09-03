import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeOnboardingScreen extends StatefulWidget {
  const WelcomeOnboardingScreen({super.key});

  @override
  State<WelcomeOnboardingScreen> createState() =>
      _WelcomeOnboardingScreenState();
}

class _WelcomeOnboardingScreenState extends State<WelcomeOnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSignupTap() {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/signup');
  }

  void _handleLoginTap() {
    HapticFeedback.mediumImpact();
    Navigator.pushNamed(context, '/phone-onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/velmae_app_dev/velmae-app_onboarding.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Kayıt Ol butonu alanı (sağ alt)
                  Positioned(
                    bottom: size.height * 0.15,
                    right: size.width * 0.1,
                    child: GestureDetector(
                      onTap: _handleSignupTap,
                      child: Container(
                        width: size.width * 0.35,
                        height: 50,
                        color: Colors.transparent,
                      ),
                    ),
                  ),

                  // Giriş Yap butonu alanı (sol alt)
                  Positioned(
                    bottom: size.height * 0.15,
                    left: size.width * 0.1,
                    child: GestureDetector(
                      onTap: _handleLoginTap,
                      child: Container(
                        width: size.width * 0.35,
                        height: 50,
                        color: Colors.transparent,
                      ),
                    ),
                  ),

                  // Üst kısım - Logo alanı (isteğe bağlı)
                  Positioned(
                    top: size.height * 0.1,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        // Logo'ya tıklandığında splash screen'e dön
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      child: Container(
                        height: 80,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
