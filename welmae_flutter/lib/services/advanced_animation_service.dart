import 'package:flutter/material.dart';
import 'dart:math' as math;

class AdvancedAnimationService {
  // Parallax Scroll Effect
  static Widget buildParallaxScrollEffect({
    required Widget child,
    required ScrollController scrollController,
    double parallaxFactor = 0.5,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double offset = scrollController.hasClients ? scrollController.offset : 0;
        return Transform.translate(
          offset: Offset(0, offset * parallaxFactor),
          child: child,
        );
      },
      child: child,
    );
  }

  // Staggered List Animation
  static Widget buildStaggeredList({
    required List<Widget> children,
    Duration baseDuration = const Duration(milliseconds: 300),
    Duration staggerDelay = const Duration(milliseconds: 100),
    Curve curve = Curves.easeOutBack,
  }) {
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: AnimationController(
            duration: baseDuration + (staggerDelay * index),
            vsync: Navigator.of(context),
          )..forward(),
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: AnimationController(
                  duration: baseDuration + (staggerDelay * index),
                  vsync: Navigator.of(context),
                )..forward(),
                curve: curve,
              )),
              child: FadeTransition(
                opacity: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(CurvedAnimation(
                  parent: AnimationController(
                    duration: baseDuration + (staggerDelay * index),
                    vsync: Navigator.of(context),
                  )..forward(),
                  curve: curve,
                )),
                child: children[index],
              ),
            );
          },
        );
      },
    );
  }

  // Morphing Shape Animation
  static Widget buildMorphingShape({
    required Widget child,
    required AnimationController controller,
    double morphFactor = 0.0,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: MorphingShapePainter(morphFactor),
          child: child,
        );
      },
      child: child,
    );
  }

  // Floating Action Button with Morphing
  static Widget buildMorphingFAB({
    required IconData icon,
    required VoidCallback onPressed,
    required AnimationController controller,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (controller.value * 0.1),
          child: FloatingActionButton(
            onPressed: onPressed,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            child: AnimatedRotation(
              turns: controller.value * 0.25,
              duration: const Duration(milliseconds: 300),
              child: Icon(icon),
            ),
          ),
        );
      },
    );
  }

  // Shimmer Loading Effect
  static Widget buildShimmerLoading({
    required Widget child,
    required AnimationController controller,
    Color shimmerColor = Colors.white,
    Color baseColor = Colors.grey,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor,
                shimmerColor,
                baseColor,
              ],
              stops: [
                0.0,
                controller.value,
                1.0,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: child,
    );
  }

  // 3D Card Flip Animation
  static Widget build3DCardFlip({
    required Widget front,
    required Widget back,
    required AnimationController controller,
    double perspective = 0.001,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final isFront = controller.value < 0.5;
        final rotation = controller.value * math.pi;
        
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, perspective)
            ..rotateY(rotation),
          alignment: Alignment.center,
          child: isFront ? front : Transform(
            transform: Matrix4.identity()..rotateY(math.pi),
            alignment: Alignment.center,
            child: back,
          ),
        );
      },
    );
  }

  // Elastic Bounce Animation
  static Widget buildElasticBounce({
    required Widget child,
    required AnimationController controller,
    double bounceIntensity = 1.2,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (math.sin(controller.value * math.pi * 2) * bounceIntensity * 0.1),
          child: child,
        );
      },
      child: child,
    );
  }

  // Wave Animation
  static Widget buildWaveAnimation({
    required Widget child,
    required AnimationController controller,
    int waveCount = 3,
    double waveAmplitude = 20.0,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(
            animation: controller,
            waveCount: waveCount,
            waveAmplitude: waveAmplitude,
          ),
          child: child,
        );
      },
      child: child,
    );
  }

  // Particle System Animation
  static Widget buildParticleSystem({
    required Widget child,
    required AnimationController controller,
    int particleCount = 50,
    Color particleColor = Colors.blue,
  }) {
    return Stack(
      children: [
        child,
        ...List.generate(particleCount, (index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final random = math.Random(index);
              final x = random.nextDouble() * 400;
              final y = random.nextDouble() * 800;
              final delay = random.nextDouble();
              
              return Positioned(
                left: x,
                top: y + (controller.value * 100 * delay),
                child: Opacity(
                  opacity: (1.0 - controller.value) * (1.0 - delay),
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: particleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  // Magnetic Effect
  static Widget buildMagneticEffect({
    required Widget child,
    required Offset magnetCenter,
    double magnetStrength = 100.0,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanUpdate: (details) {
            // Magnetic effect logic - center, distance and force calculation for future use
            // final center = Offset(
            //   constraints.maxWidth / 2,
            //   constraints.maxHeight / 2,
            // );
            // final distance = (details.localPosition - center).distance;
            // final force = magnetStrength / (distance + 1);
          },
          child: child,
        );
      },
    );
  }

  // Liquid Fill Animation
  static Widget buildLiquidFill({
    required double fillPercentage,
    required AnimationController controller,
    Color liquidColor = Colors.blue,
    double waveHeight = 10.0,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidFillPainter(
            fillPercentage: fillPercentage,
            liquidColor: liquidColor,
            waveHeight: waveHeight,
            animation: controller,
          ),
        );
      },
    );
  }

  // Confetti Animation
  static Widget buildConfettiAnimation({
    required Widget child,
    required AnimationController controller,
    int confettiCount = 100,
    List<Color> colors = const [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple],
  }) {
    return Stack(
      children: [
        child,
        ...List.generate(confettiCount, (index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final random = math.Random(index);
              final color = colors[random.nextInt(colors.length)];
              final x = random.nextDouble() * 400;
              final y = random.nextDouble() * 800;
              final rotation = random.nextDouble() * 360;
              final scale = 0.5 + random.nextDouble() * 0.5;
              
              return Positioned(
                left: x,
                top: y + (controller.value * 200),
                child: Transform.rotate(
                  angle: rotation * math.pi / 180,
                  child: Transform.scale(
                    scale: scale * (1.0 - controller.value),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

// Custom Painters
class MorphingShapePainter extends CustomPainter {
  final double morphFactor;
  
  MorphingShapePainter(this.morphFactor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    
    // Morphing logic
    for (int i = 0; i < 360; i += 10) {
      final angle = i * math.pi / 180;
      final morphRadius = radius + (math.sin(angle * 3 + morphFactor * math.pi * 2) * 20);
      final x = center.dx + math.cos(angle) * morphRadius;
      final y = center.dy + math.sin(angle) * morphRadius;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final int waveCount;
  final double waveAmplitude;
  
  WavePainter({
    required this.animation,
    required this.waveCount,
    required this.waveAmplitude,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(0, size.height);
    
    for (double x = 0; x <= size.width; x++) {
      double y = size.height / 2;
      for (int i = 0; i < waveCount; i++) {
        y += math.sin((x / size.width * 2 * math.pi * (i + 1)) + animation.value * 2 * math.pi) * waveAmplitude / (i + 1);
      }
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class LiquidFillPainter extends CustomPainter {
  final double fillPercentage;
  final Color liquidColor;
  final double waveHeight;
  final Animation<double> animation;
  
  LiquidFillPainter({
    required this.fillPercentage,
    required this.liquidColor,
    required this.waveHeight,
    required this.animation,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = liquidColor
      ..style = PaintingStyle.fill;
    
    final fillHeight = size.height * (1.0 - fillPercentage);
    final path = Path();
    
    path.moveTo(0, size.height);
    path.lineTo(0, fillHeight);
    
    for (double x = 0; x <= size.width; x++) {
      final y = fillHeight + math.sin((x / size.width * 2 * math.pi) + animation.value * 2 * math.pi) * waveHeight;
      path.lineTo(x, y);
    }
    
    path.lineTo(size.width, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
