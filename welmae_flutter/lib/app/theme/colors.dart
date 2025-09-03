import 'package:flutter/material.dart';

/// Welmae App Color System
/// 
/// Bu sınıf, uygulamanın tüm renk değerlerini tanımlar ve
/// tutarlı bir görsel kimlik sağlar. Material Design 3 renk
/// sistemine dayalıdır.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors - Ana Renkler
  static const Color primary = Color(0xFF6750A4);      // Ana marka rengi
  static const Color primaryContainer = Color(0xFFEADDFF); // Ana renk konteyner
  static const Color onPrimary = Color(0xFFFFFFFF);    // Ana renk üzerindeki metin
  static const Color onPrimaryContainer = Color(0xFF21005D); // Ana konteyner üzerindeki metin
  
  // Secondary Colors - İkincil Renkler
  static const Color secondary = Color(0xFF625B71);    // İkincil marka rengi
  static const Color secondaryContainer = Color(0xFFE8DEF8); // İkincil renk konteyner
  static const Color onSecondary = Color(0xFFFFFFFF);  // İkincil renk üzerindeki metin
  static const Color onSecondaryContainer = Color(0xFF1D192B); // İkincil konteyner üzerindeki metin
  
  // Tertiary Colors - Üçüncül Renkler
  static const Color tertiary = Color(0xFF7D5260);     // Üçüncül marka rengi
  static const Color tertiaryContainer = Color(0xFFFFD8E4); // Üçüncül renk konteyner
  static const Color onTertiary = Color(0xFFFFFFFF);   // Üçüncül renk üzerindeki metin
  static const Color onTertiaryContainer = Color(0xFF31111D); // Üçüncül konteyner üzerindeki metin
  
  // Surface Colors - Yüzey Renkleri
  static const Color surface = Color(0xFFFFFBFE);      // Ana yüzey rengi
  static const Color surfaceVariant = Color(0xFFE7E0EC); // Varyant yüzey rengi
  static const Color onSurface = Color(0xFF1C1B1F);    // Yüzey üzerindeki metin
  static const Color onSurfaceVariant = Color(0xFF49454F); // Varyant yüzey üzerindeki metin
  
  // Background Colors - Arka Plan Renkleri
  static const Color background = Color(0xFFFFFBFE);   // Ana arka plan rengi
  static const Color onBackground = Color(0xFF1C1B1F); // Arka plan üzerindeki metin
  
  // Error Colors - Hata Renkleri
  static const Color error = Color(0xFFB3261E);        // Hata rengi
  static const Color errorContainer = Color(0xFFF9DEDC); // Hata konteyner rengi
  static const Color onError = Color(0xFFFFFFFF);      // Hata üzerindeki metin
  static const Color onErrorContainer = Color(0xFF410E0B); // Hata konteyner üzerindeki metin
  
  // Outline Colors - Kenarlık Renkleri
  static const Color outline = Color(0xFF79747E);      // Kenarlık rengi
  static const Color outlineVariant = Color(0xFFCAC4D0); // Varyant kenarlık rengi
  
  // Shadow Colors - Gölge Renkleri
  static const Color shadow = Color(0xFF000000);       // Gölge rengi
  static const Color scrim = Color(0xFF000000);        // Scrim rengi
  
  // Inverse Colors - Ters Renkler
  static const Color inverseSurface = Color(0xFF313033); // Ters yüzey rengi
  static const Color inverseOnSurface = Color(0xFFF4EFF4); // Ters yüzey üzerindeki metin
  static const Color inversePrimary = Color(0xFFD0BCFF); // Ters ana renk
  
  // Brand Colors - Marka Renkleri
  static const Color brandPrimary = Color(0xFF6750A4);  // Marka ana rengi
  static const Color brandSecondary = Color(0xFF625B71); // Marka ikincil rengi
  static const Color brandAccent = Color(0xFF7D5260);   // Marka vurgu rengi
  
  // Semantic Colors - Anlamsal Renkler
  static const Color success = Color(0xFF4CAF50);       // Başarı rengi
  static const Color warning = Color(0xFFFF9800);       // Uyarı rengi
  static const Color info = Color(0xFF2196F3);          // Bilgi rengi
  
  // Neutral Colors - Nötr Renkler
  static const Color neutral50 = Color(0xFFFAFAFA);     // Çok açık gri
  static const Color neutral100 = Color(0xFFF5F5F5);    // Açık gri
  static const Color neutral200 = Color(0xFFEEEEEE);    // Orta açık gri
  static const Color neutral300 = Color(0xFFE0E0E0);    // Orta gri
  static const Color neutral400 = Color(0xFFBDBDBD);    // Orta koyu gri
  static const Color neutral500 = Color(0xFF9E9E9E);    // Orta gri
  static const Color neutral600 = Color(0xFF757575);    // Orta koyu gri
  static const Color neutral700 = Color(0xFF616161);    // Koyu gri
  static const Color neutral800 = Color(0xFF424242);    // Çok koyu gri
  static const Color neutral900 = Color(0xFF212121);    // En koyu gri
  
  // Transparent Colors - Şeffaf Renkler
  static const Color transparent = Colors.transparent;  // Tamamen şeffaf
  static const Color semiTransparent = Color(0x80000000); // Yarı şeffaf siyah
  
  // Gradient Colors - Gradyan Renkleri
  static const List<Color> primaryGradient = [
    Color(0xFF6750A4),
    Color(0xFF7C63A8),
    Color(0xFF9176AC),
  ];
  
  static const List<Color> secondaryGradient = [
    Color(0xFF625B71),
    Color(0xFF7A7385),
    Color(0xFF928B99),
  ];
  
  static const List<Color> surfaceGradient = [
    Color(0xFFFFFBFE),
    Color(0xFFF8F5FF),
    Color(0xFFF0EDFF),
  ];
  
  // Dark Theme Colors - Koyu Tema Renkleri
  static const Color darkPrimary = Color(0xFFD0BCFF);
  static const Color darkPrimaryContainer = Color(0xFF4F378B);
  static const Color darkOnPrimary = Color(0xFF381E72);
  static const Color darkOnPrimaryContainer = Color(0xFFEADDFF);
  
  static const Color darkSecondary = Color(0xFFCCC2DC);
  static const Color darkSecondaryContainer = Color(0xFF4A4458);
  static const Color darkOnSecondary = Color(0xFF332D41);
  static const Color darkOnSecondaryContainer = Color(0xFFE8DEF8);
  
  static const Color darkTertiary = Color(0xFFEFB8C8);
  static const Color darkTertiaryContainer = Color(0xFF633B48);
  static const Color darkOnTertiary = Color(0xFF492532);
  static const Color darkOnTertiaryContainer = Color(0xFFFFD8E4);
  
  static const Color darkSurface = Color(0xFF1C1B1F);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkOnSurfaceVariant = Color(0xFFCAC4D0);
  
  static const Color darkBackground = Color(0xFF1C1B1F);
  static const Color darkOnBackground = Color(0xFFE6E1E5);
  
  static const Color darkError = Color(0xFFF2B8B5);
  static const Color darkErrorContainer = Color(0xFF8C1D18);
  static const Color darkOnError = Color(0xFF601410);
  static const Color darkOnErrorContainer = Color(0xFFF9DEDC);
  
  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkOutlineVariant = Color(0xFF49454F);
  
  static const Color darkInverseSurface = Color(0xFFE6E1E5);
  static const Color darkInverseOnSurface = Color(0xFF313033);
  static const Color darkInversePrimary = Color(0xFF6750A4);
  
  // Utility methods
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
  
  static Color darken(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
  
  static Color lighten(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
  
  static bool isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }
  
  static bool isLight(Color color) {
    return color.computeLuminance() >= 0.5;
  }
  
  // Accessibility helpers
  static Color getContrastColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }
  
  static double getContrastRatio(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    
    final brightest = luminance1 > luminance2 ? luminance1 : luminance2;
    final darkest = luminance1 > luminance2 ? luminance2 : luminance1;
    
    return (brightest + 0.05) / (darkest + 0.05);
  }
  
  static bool isAccessible(Color foreground, Color background) {
    return getContrastRatio(foreground, background) >= 4.5;
  }
}
