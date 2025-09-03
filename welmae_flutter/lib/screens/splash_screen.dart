import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _shapeAnimationController;
  late Animation<double> _shapeAnimation;
  Timer? _timer;

  // Velmae Brand Colors
  static const Color velmaeTeal = Color(0xFF03A6A6);
  static const Color velmaeDarkTeal = Color(0xFF027d7d);
  static const Color velmaeLightTeal = Color(0xFF05D1D1);

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToNextScreen();
  }

  void _setupAnimations() {
    // Shape animation controller for teardrop to U transformation
    _shapeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Shape transformation animation (teardrop to U)
    _shapeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _shapeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animation
    _shapeAnimationController.forward();
  }

  void _navigateToNextScreen() {
    _timer = Timer(const Duration(milliseconds: 5000), () {
      if (mounted) {
        // Navigate to onboarding screen
        Navigator.pushReplacementNamed(context, '/welcome-onboarding');
      }
    });
  }

  @override
  void dispose() {
    _shapeAnimationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _shapeAnimation,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(120, 120),
              painter: TeardropToUPainter(
                progress: _shapeAnimation.value,
                color: velmaeTeal,
              ),
            );
          },
        ),
      ),
    );
  }
}

// Custom painter for teardrop to U shape transformation
class TeardropToUPainter extends CustomPainter {
  final double progress;
  final Color color;

  TeardropToUPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    if (progress < 0.5) {
      // Teardrop shape (first half of animation)
      final teardropProgress = progress * 2; // 0 to 1
      final currentRadius = radius * (0.5 + teardropProgress * 0.5);
      
      final path = Path();
      path.moveTo(center.dx, center.dy - currentRadius);
      path.quadraticBezierTo(
        center.dx + currentRadius * 0.7,
        center.dy - currentRadius * 0.3,
        center.dx + currentRadius * 0.3,
        center.dy + currentRadius * 0.5,
      );
      path.quadraticBezierTo(
        center.dx,
        center.dy + currentRadius * 0.8,
        center.dx - currentRadius * 0.3,
        center.dy + currentRadius * 0.5,
      );
      path.quadraticBezierTo(
        center.dx - currentRadius * 0.7,
        center.dy - currentRadius * 0.3,
        center.dx,
        center.dy - currentRadius,
      );
      path.close();

      canvas.drawPath(path, paint);

      // White circle inside
      final whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      
      final circleRadius = currentRadius * 0.15;
      canvas.drawCircle(
        Offset(center.dx, center.dy - currentRadius * 0.3),
        circleRadius,
        whitePaint,
      );
    } else {
      // U shape (second half of animation)
      final uProgress = (progress - 0.5) * 2; // 0 to 1
      final uRadius = radius * 0.8;
      final uWidth = uRadius * 1.2;
      final uHeight = uRadius * 1.5;

      final path = Path();
      
      // Left vertical line
      path.moveTo(center.dx - uWidth / 2, center.dy - uHeight / 2);
      path.lineTo(center.dx - uWidth / 2, center.dy + uHeight / 2);
      
      // Bottom curve
      path.quadraticBezierTo(
        center.dx,
        center.dy + uHeight / 2 + uRadius * 0.3,
        center.dx + uWidth / 2,
        center.dy + uHeight / 2,
      );
      
      // Right vertical line
      path.lineTo(center.dx + uWidth / 2, center.dy - uHeight / 2);
      
      // Top curve
      path.quadraticBezierTo(
        center.dx,
        center.dy - uHeight / 2 - uRadius * 0.1,
        center.dx - uWidth / 2,
        center.dy - uHeight / 2,
      );

      canvas.drawPath(path, paint);

      // White circle inside (top right)
      final whitePaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      
      final circleRadius = uRadius * 0.15;
      canvas.drawCircle(
        Offset(center.dx + uWidth / 2 - circleRadius, center.dy - uHeight / 2 + circleRadius),
        circleRadius,
        whitePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is TeardropToUPainter && oldDelegate.progress != progress;
  }
}
