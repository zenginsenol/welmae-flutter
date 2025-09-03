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
  bool _isSignupHovered = false;
  bool _isLoginHovered = false;

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
    Navigator.pushNamed(context, '/location-selection');
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
              child: Column(
                children: [
                  // Üst kısım - Logo alanı
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  
                  // Alt kısım - Butonlar
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Kayıt Ol butonu
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => _isSignupHovered = true),
                            onExit: (_) => setState(() => _isSignupHovered = false),
                            child: GestureDetector(
                              onTap: _handleSignupTap,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: _isSignupHovered 
                                      ? const Color(0xFFA8D6D6) // Daha koyu teal
                                      : const Color(0xFFB8E6E6), // Açık teal/mint
                                  borderRadius: BorderRadius.circular(28),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'Kayıt Ol',
                                    style: TextStyle(
                                      color: const Color(0xFF013C3C), // Koyu teal
                                      fontSize: _isSignupHovered ? 18 : 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Giriş yapın linki
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => _isLoginHovered = true),
                            onExit: (_) => setState(() => _isLoginHovered = false),
                            child: GestureDetector(
                              onTap: _handleLoginTap,
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    const TextSpan(text: 'Üyeliğiniz mi var? '),
                                    TextSpan(
                                      text: 'Giriş yapın',
                                      style: TextStyle(
                                        color: _isLoginHovered 
                                            ? const Color(0xFF03A6A6) // Velmae teal
                                            : const Color(0xFFB8E6E6), // Açık teal
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
