import 'package:flutter/material.dart';

// Simple AnimationType class to fix undefined errors
class AnimationType {
  final String name;

  const AnimationType(this.name);

  // Common animation types
  static const fadeIn = AnimationType('fadeIn');
  static const fadeOut = AnimationType('fadeOut');
  static const slideInFromBottom = AnimationType('slideInFromBottom');
  static const slideInFromTop = AnimationType('slideInFromTop');
  static const slideInFromLeft = AnimationType('slideInFromLeft');
  static const slideInFromRight = AnimationType('slideInFromRight');
  static const scaleIn = AnimationType('scaleIn');
  static const scaleOut = AnimationType('scaleOut');
  static const rotateIn = AnimationType('rotateIn');
  static const rotateOut = AnimationType('rotateOut');
  static const bounceIn = AnimationType('bounceIn');
  static const bounceOut = AnimationType('bounceOut');
  static const elasticIn = AnimationType('elasticIn');
  static const elasticOut = AnimationType('elasticOut');
  static const flipIn = AnimationType('flipIn');
  static const flipOut = AnimationType('flipOut');
  static const shake = AnimationType('shake');
  static const pulse = AnimationType('pulse');
  static const wobble = AnimationType('wobble');
  static const jello = AnimationType('jello');
  static const heartBeat = AnimationType('heartBeat');
  static const flash = AnimationType('flash');
  static const rubberBand = AnimationType('rubberBand');
  static const swing = AnimationType('swing');
  static const tada = AnimationType('tada');
  static const rollIn = AnimationType('rollIn');
  static const rollOut = AnimationType('rollOut');
  static const zoomIn = AnimationType('zoomIn');
  static const zoomOut = AnimationType('zoomOut');
  static const lightSpeedIn = AnimationType('lightSpeedIn');
  static const lightSpeedOut = AnimationType('lightSpeedOut');
  static const hinge = AnimationType('hinge');
  static const jackInTheBox = AnimationType('jackInTheBox');
  static const rollInDiagonal = AnimationType('rollInDiagonal');
  static const rollOutDiagonal = AnimationType('rollOutDiagonal');

  // Directional animations
  static const fadeInUp = AnimationType('fadeInUp');
  static const fadeInDown = AnimationType('fadeInDown');
  static const fadeInLeft = AnimationType('fadeInLeft');
  static const fadeInRight = AnimationType('fadeInRight');
  static const fadeOutUp = AnimationType('fadeOutUp');
  static const fadeOutDown = AnimationType('fadeOutDown');
  static const fadeOutLeft = AnimationType('fadeOutLeft');
  static const fadeOutRight = AnimationType('fadeOutRight');
  static const slideInUp = AnimationType('slideInUp');
  static const slideInDown = AnimationType('slideInDown');
  static const slideInLeft = AnimationType('slideInLeft');
  static const slideInRight = AnimationType('slideInRight');
  static const slideOutUp = AnimationType('slideOutUp');
  static const slideOutDown = AnimationType('slideOutDown');
  static const slideOutLeft = AnimationType('slideOutLeft');
  static const slideOutRight = AnimationType('slideOutRight');
  static const zoomInUp = AnimationType('zoomInUp');
  static const zoomInDown = AnimationType('zoomInDown');
  static const zoomInLeft = AnimationType('zoomInLeft');
  static const zoomInRight = AnimationType('zoomInRight');
  static const zoomOutUp = AnimationType('zoomOutUp');
  static const zoomOutDown = AnimationType('zoomOutDown');
  static const zoomOutLeft = AnimationType('zoomOutLeft');
  static const zoomOutRight = AnimationType('zoomOutRight');
  static const flipInX = AnimationType('flipInX');
  static const flipOutX = AnimationType('flipOutX');
  static const flipInY = AnimationType('flipInY');
  static const flipOutY = AnimationType('flipOutY');
  static const rotateInDownLeft = AnimationType('rotateInDownLeft');
  static const rotateInDownRight = AnimationType('rotateInDownRight');
  static const rotateInUpLeft = AnimationType('rotateInUpLeft');
  static const rotateInUpRight = AnimationType('rotateInUpRight');
  static const rotateOutDownLeft = AnimationType('rotateOutDownLeft');
  static const rotateOutDownRight = AnimationType('rotateOutDownRight');
  static const rotateOutUpLeft = AnimationType('rotateOutUpLeft');
  static const rotateOutUpRight = AnimationType('rotateOutUpRight');
  static const lightSpeedInRight = AnimationType('lightSpeedInRight');
  static const lightSpeedInLeft = AnimationType('lightSpeedInLeft');
  static const lightSpeedOutRight = AnimationType('lightSpeedOutRight');
  static const lightSpeedOutLeft = AnimationType('lightSpeedOutLeft');
  static const hingeLeft = AnimationType('hingeLeft');
  static const hingeRight = AnimationType('hingeRight');
  static const hingeUp = AnimationType('hingeUp');
  static const hingeDown = AnimationType('hingeDown');
  static const jackInTheBoxIn = AnimationType('jackInTheBoxIn');
  static const jackInTheBoxOut = AnimationType('jackInTheBoxOut');
  static const rollInUp = AnimationType('rollInUp');
  static const rollInDown = AnimationType('rollInDown');
  static const rollOutUp = AnimationType('rollOutUp');
  static const rollOutDown = AnimationType('rollOutDown');
  static const rollInLeft = AnimationType('rollInLeft');
  static const rollInRight = AnimationType('rollInRight');
  static const rollOutLeft = AnimationType('rollOutLeft');
  static const rollOutRight = AnimationType('rollOutRight');
  static const rollInDiagonalUpLeft = AnimationType('rollInDiagonalUpLeft');
  static const rollInDiagonalUpRight = AnimationType('rollInDiagonalUpRight');
  static const rollInDiagonalDownLeft = AnimationType('rollInDiagonalDownLeft');
  static const rollInDiagonalDownRight = AnimationType(
    'rollInDiagonalDownRight',
  );
  static const rollOutDiagonalUpLeft = AnimationType('rollOutDiagonalUpLeft');
  static const rollOutDiagonalUpRight = AnimationType('rollOutDiagonalUpRight');
  static const rollOutDiagonalDownLeft = AnimationType(
    'rollOutDiagonalDownLeft',
  );
  static const rollOutDiagonalDownRight = AnimationType(
    'rollOutDiagonalDownRight',
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnimationType &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'AnimationType($name)';
}

class AppAnimations {
  // Animation Durations
  static const Duration durationMicro = Duration(milliseconds: 100);
  static const Duration durationTiny = Duration(milliseconds: 150);
  static const Duration durationExtraSmall = Duration(milliseconds: 200);
  static const Duration durationSmall = Duration(milliseconds: 300);
  static const Duration durationMedium = Duration(milliseconds: 500);
  static const Duration durationLarge = Duration(milliseconds: 700);
  static const Duration durationExtraLarge = Duration(milliseconds: 1000);
  static const Duration durationHuge = Duration(milliseconds: 1500);

  // Animation Curves
  static const Curve curveMicro = Curves.easeIn;
  static const Curve curveTiny = Curves.easeInSine;
  static const Curve curveExtraSmall = Curves.easeInQuad;
  static const Curve curveSmall = Curves.easeInCubic;
  static const Curve curveMedium = Curves.easeInOut;
  static const Curve curveLarge = Curves.easeOutCubic;
  static const Curve curveExtraLarge = Curves.easeOutQuad;
  static const Curve curveHuge = Curves.easeOutSine;

  // Default Animation Settings
  static const Duration defaultDuration = durationMedium;
  static const Curve defaultCurve = curveMedium;
  static const Duration fastDuration = durationSmall;
  static const Curve fastCurve = curveSmall;
  static const Duration slowDuration = durationLarge;
  static const Curve slowCurve = curveLarge;
  static const Duration instantDuration = durationMicro;
  static const Curve instantCurve = curveMicro;
  static const Duration delayedDuration = durationExtraLarge;
  static const Curve delayedCurve = curveExtraLarge;
}
