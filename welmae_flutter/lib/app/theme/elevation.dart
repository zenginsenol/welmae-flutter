import 'package:flutter/material.dart';

/// Welmae App Elevation System
/// 
/// Bu sınıf, uygulamanın tüm elevation ve gölge değerlerini tanımlar ve
/// Material Design 3 elevation sistemine uygun tutarlı bir derinlik sağlar.
class AppElevation {
  // Private constructor to prevent instantiation
  AppElevation._();

  // Light theme shadows - Açık tema gölgeleri
  static List<BoxShadow> get level1 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level2 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 1),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level3 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level4 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level5 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      offset: const Offset(0, 32),
      blurRadius: 64,
      spreadRadius: 0,
    ),
  ];
  
  // Dark theme shadows - Karanlık tema gölgeleri
  static List<BoxShadow> get darkLevel1 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get darkLevel2 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 1),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get darkLevel3 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get darkLevel4 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get darkLevel5 => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.2),
      offset: const Offset(0, 32),
      blurRadius: 64,
      spreadRadius: 0,
    ),
  ];
  
  // Custom shadows - Özel gölgeler
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      offset: const Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get floatingShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get modalShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      offset: const Offset(0, 8),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      offset: const Offset(0, 16),
      blurRadius: 48,
      spreadRadius: 0,
    ),
  ];
  
  // Interactive shadows - Etkileşimli gölgeler
  static List<BoxShadow> get pressedShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get hoverShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      offset: const Offset(0, 3),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get focusShadow => [
    BoxShadow(
      color: Colors.blue.withValues(alpha: 0.2),
      offset: const Offset(0, 0),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  // Utility methods - Yardımcı metodlar
  
  /// Verilen elevation seviyesine göre gölge döndürür
  static List<BoxShadow> getShadowByLevel(int level, {bool isDark = false}) {
    switch (level) {
      case 1:
        return isDark ? darkLevel1 : level1;
      case 2:
        return isDark ? darkLevel2 : level2;
      case 3:
        return isDark ? darkLevel3 : level3;
      case 4:
        return isDark ? darkLevel4 : level4;
      case 5:
        return isDark ? darkLevel5 : level5;
      default:
        return isDark ? darkLevel1 : level1;
    }
  }
  
  /// Verilen elevation seviyesine göre Material elevation değeri döndürür
  static double getMaterialElevation(int level) {
    switch (level) {
      case 1:
        return 1.0;
      case 2:
        return 2.0;
      case 3:
        return 4.0;
      case 4:
        return 8.0;
      case 5:
        return 16.0;
      default:
        return 1.0;
    }
  }
  
  /// Verilen elevation seviyesine göre gölge rengi döndürür
  static Color getShadowColor(int level, {bool isDark = false}) {
    final opacity = isDark ? 0.3 : 0.1;
    return Colors.black.withValues(alpha: opacity * level);
  }
  
  /// Verilen elevation seviyesine göre gölge offset'i döndürür
  static Offset getShadowOffset(int level) {
    return Offset(0, level.toDouble());
  }
  
  /// Verilen elevation seviyesine göre gölge blur radius'u döndürür
  static double getShadowBlurRadius(int level) {
    return level * 4.0;
  }
  
  /// Verilen elevation seviyesine göre gölge spread radius'u döndürür
  static double getShadowSpreadRadius(int level) {
    return 0.0;
  }
  
  /// Özel gölge oluşturur
  static List<BoxShadow> createCustomShadow({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return [
      BoxShadow(
        color: color ?? Colors.black.withValues(alpha: 0.1),
        offset: offset ?? const Offset(0, 2),
        blurRadius: blurRadius ?? 8.0,
        spreadRadius: spreadRadius ?? 0.0,
      ),
    ];
  }
  
  /// Çoklu gölge oluşturur
  static List<BoxShadow> createMultiShadow(List<BoxShadow> shadows) {
    return shadows;
  }
  
  /// Gölgeyi kaldırır (no shadow)
  static List<BoxShadow> get noShadow => [];
}
