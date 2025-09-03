import 'package:flutter/material.dart';

/// Welmae App Spacing System
/// 
/// Bu sınıf, uygulamanın tüm spacing ve boyut değerlerini tanımlar ve
/// tutarlı bir layout sağlar. 8px grid sistemine dayalıdır.
class AppSpacing {
  // Private constructor to prevent instantiation
  AppSpacing._();

  // Base spacing unit: 4px (8px grid system)
  static const double xs = 4.0;    // 4px
  static const double sm = 8.0;    // 8px
  static const double md = 16.0;   // 16px
  static const double lg = 24.0;   // 24px
  static const double xl = 32.0;   // 32px
  static const double xxl = 48.0;  // 48px
  static const double xxxl = 64.0; // 64px
  
  // Custom spacing values
  static const double section = 40.0;  // 40px - Bölümler arası
  static const double page = 20.0;    // 20px - Sayfa kenarları
  
  // Responsive spacing multipliers
  static const double mobileMultiplier = 1.0;    // Mobile: 1x
  static const double tabletMultiplier = 1.25;   // Tablet: 1.25x
  static const double desktopMultiplier = 1.5;   // Desktop: 1.5x
  
  // Utility methods for responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return baseSpacing * mobileMultiplier;
    } else if (width < 1024) {
      return baseSpacing * tabletMultiplier;
    } else {
      return baseSpacing * desktopMultiplier;
    }
  }
  
  // Common spacing combinations
  static const EdgeInsets pagePadding = EdgeInsets.all(page);
  static const EdgeInsets sectionPadding = EdgeInsets.all(section);
  static const EdgeInsets contentPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  
  // List spacing
  static const double listItemSpacing = md;
  static const double listSectionSpacing = lg;
  
  // Grid spacing
  static const double gridSpacing = md;
  static const double gridItemSpacing = sm;
}

/// Welmae App Size System
/// 
/// Bu sınıf, uygulamanın tüm boyut değerlerini tanımlar ve
/// tutarlı bir görsel hiyerarşi sağlar.
class AppSizes {
  // Private constructor to prevent instantiation
  AppSizes._();

  // Icon sizes - İkon boyutları
  static const double iconXs = 16.0;   // 16px - Çok küçük ikonlar
  static const double iconSm = 20.0;   // 20px - Küçük ikonlar
  static const double iconMd = 24.0;   // 24px - Orta boy ikonlar
  static const double iconLg = 32.0;   // 32px - Büyük ikonlar
  static const double iconXl = 48.0;   // 48px - Çok büyük ikonlar
  
  // Button sizes - Buton boyutları
  static const double buttonHeight = 48.0;      // 48px - Standart buton
  static const double buttonHeightSmall = 40.0; // 40px - Küçük buton
  static const double buttonHeightLarge = 56.0; // 56px - Büyük buton
  static const double buttonHeightIcon = 48.0;  // 48px - İkon buton
  
  // Input sizes - Giriş alanı boyutları
  static const double inputHeight = 48.0;       // 48px - Standart input
  static const double inputHeightSmall = 40.0;  // 40px - Küçük input
  static const double inputHeightLarge = 56.0;  // 56px - Büyük input
  static const double inputHeightSearch = 44.0; // 44px - Arama input
  
  // Border radius - Kenarlık yuvarlaklığı
  static const double radiusXs = 4.0;   // 4px - Çok küçük yuvarlaklık
  static const double radiusSm = 8.0;   // 8px - Küçük yuvarlaklık
  static const double radiusMd = 12.0;  // 12px - Orta yuvarlaklık
  static const double radiusLg = 16.0;  // 16px - Büyük yuvarlaklık
  static const double radiusXl = 24.0;  // 24px - Çok büyük yuvarlaklık
  static const double radiusFull = 9999.0; // Tam yuvarlak
  
  // Avatar sizes - Avatar boyutları
  static const double avatarXs = 24.0;  // 24px - Çok küçük avatar
  static const double avatarSm = 32.0;  // 32px - Küçük avatar
  static const double avatarMd = 48.0;  // 48px - Orta boy avatar
  static const double avatarLg = 64.0;  // 64px - Büyük avatar
  static const double avatarXl = 96.0;  // 96px - Çok büyük avatar
  
  // Image sizes - Görsel boyutları
  static const double imageThumbnail = 80.0;   // 80px - Küçük resim
  static const double imageSmall = 120.0;      // 120px - Küçük resim
  static const double imageMedium = 200.0;     // 200px - Orta boy resim
  static const double imageLarge = 300.0;      // 300px - Büyük resim
  static const double imageHero = 400.0;       // 400px - Hero resim
  
  // Card sizes - Kart boyutları
  static const double cardHeightSmall = 120.0; // 120px - Küçük kart
  static const double cardHeightMedium = 200.0; // 200px - Orta boy kart
  static const double cardHeightLarge = 280.0; // 280px - Büyük kart
  
  // App bar sizes - Uygulama çubuğu boyutları
  static const double appBarHeight = 56.0;     // 56px - Standart app bar
  static const double appBarHeightLarge = 64.0; // 64px - Büyük app bar
  static const double appBarHeightSmall = 48.0; // 48px - Küçük app bar
  
  // Bottom navigation sizes - Alt navigasyon boyutları
  static const double bottomNavHeight = 56.0;  // 56px - Alt navigasyon
  static const double bottomNavHeightLarge = 64.0; // 64px - Büyük alt navigasyon
  
  // Floating action button sizes - Yüzen aksiyon butonu boyutları
  static const double fabSize = 56.0;          // 56px - Standart FAB
  static const double fabSizeSmall = 40.0;     // 40px - Küçük FAB
  static const double fabSizeLarge = 64.0;     // 64px - Büyük FAB
  
  // Divider sizes - Ayırıcı boyutları
  static const double dividerThickness = 1.0;  // 1px - Standart divider
  static const double dividerThicknessThick = 2.0; // 2px - Kalın divider
  
  // Shadow sizes - Gölge boyutları
  static const double shadowBlurRadius = 8.0;  // 8px - Standart gölge
  static const double shadowSpreadRadius = 0.0; // 0px - Gölge yayılımı
  
  // Animation durations - Animasyon süreleri
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  
  // Responsive size helpers
  static double getResponsiveSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return baseSize * 0.9; // Mobile: 90%
    } else if (width < 1024) {
      return baseSize; // Tablet: 100%
    } else {
      return baseSize * 1.1; // Desktop: 110%
    }
  }
  
  // Common size combinations
  static const Size buttonSize = Size(double.infinity, buttonHeight);
  static const Size buttonSizeSmall = Size(double.infinity, buttonHeightSmall);
  static const Size buttonSizeLarge = Size(double.infinity, buttonHeightLarge);
  
  static const Size inputSize = Size(double.infinity, inputHeight);
  static const Size inputSizeSmall = Size(double.infinity, inputHeightSmall);
  static const Size inputSizeLarge = Size(double.infinity, inputHeightLarge);
  
  static const Size cardSize = Size(double.infinity, cardHeightMedium);
  static const Size cardSizeSmall = Size(double.infinity, cardHeightSmall);
  static const Size cardSizeLarge = Size(double.infinity, cardHeightLarge);
}
