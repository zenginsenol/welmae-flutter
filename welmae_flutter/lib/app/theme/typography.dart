import 'package:flutter/material.dart';

/// Welmae App Typography System
/// 
/// Bu sınıf, uygulamanın tüm tipografi değerlerini tanımlar ve
/// tutarlı bir metin hiyerarşisi sağlar. Material Design 3 tipografi
/// sistemine dayalıdır.
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // Display Styles - Görüntüleme Stilleri
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57.0,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.16,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.22,
  );
  
  // Headline Styles - Başlık Stilleri
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.25,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.29,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.33,
  );
  
  // Title Styles - Başlık Stilleri
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.27,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  // Label Styles - Etiket Stilleri
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
  
  // Body Styles - Gövde Stilleri
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  // Custom Styles - Özel Stiller
  static const TextStyle button = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  static const TextStyle overline = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
    height: 1.60,
  );
  
  // Brand Styles - Marka Stilleri
  static const TextStyle brandLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );
  
  static const TextStyle brandMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.33,
  );
  
  static const TextStyle brandSmall = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.44,
  );
  
  // Navigation Styles - Navigasyon Stilleri
  static const TextStyle navLarge = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.40,
  );
  
  static const TextStyle navMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.50,
  );
  
  static const TextStyle navSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  // Card Styles - Kart Stilleri
  static const TextStyle cardTitle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.44,
  );
  
  static const TextStyle cardSubtitle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle cardBody = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  // Form Styles - Form Stilleri
  static const TextStyle formLabel = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle formInput = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.50,
  );
  
  static const TextStyle formHelper = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.33,
  );
  
  static const TextStyle formError = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.33,
  );
  
  // List Styles - Liste Stilleri
  static const TextStyle listTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 1.50,
  );
  
  static const TextStyle listSubtitle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle listCaption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.33,
  );
  
  // Status Styles - Durum Stilleri
  static const TextStyle statusSuccess = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle statusWarning = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle statusError = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  static const TextStyle statusInfo = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 1.43,
  );
  
  // Utility methods
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }
  
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
  
  static TextStyle withHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }
  
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }
  
  static TextStyle withDecoration(TextStyle style, TextDecoration decoration) {
    return style.copyWith(decoration: decoration);
  }
  
  static TextStyle withShadows(TextStyle style, List<Shadow> shadows) {
    return style.copyWith(shadows: shadows);
  }
  
  // Responsive typography helpers
  static TextStyle getResponsiveTextStyle(BuildContext context, TextStyle baseStyle) {
    final width = MediaQuery.of(context).size.width;
    double scaleFactor = 1.0;
    
    if (width < 600) {
      scaleFactor = 0.9; // Mobile: 90%
    } else if (width < 1024) {
      scaleFactor = 1.0; // Tablet: 100%
    } else {
      scaleFactor = 1.1; // Desktop: 110%
    }
    
    return baseStyle.copyWith(
      fontSize: baseStyle.fontSize! * scaleFactor,
    );
  }
  
  // Accessibility helpers
  static TextStyle withHighContrast(TextStyle style) {
    return style.copyWith(
      fontWeight: FontWeight.w600,
    );
  }
  
  static TextStyle withLargeText(TextStyle style) {
    return style.copyWith(
      fontSize: style.fontSize! * 1.2,
    );
  }
  
  // Theme-aware text styles
  static TextStyle getThemeAwareTextStyle(BuildContext context, TextStyle lightStyle, TextStyle darkStyle) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightStyle : darkStyle;
  }
}
