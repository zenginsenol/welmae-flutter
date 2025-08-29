# Welmae - Design System ve UI/UX Rehberi

## 📋 **Doküman Bilgileri**

- **Versiyon**: 1.0.0
- **Oluşturulma Tarihi**: 29 Ağustos 2025
- **Son Güncelleme**: 29 Ağustos 2025
- **Hazırlayan**: AI Assistant
- **Onaylayan**: TBD
- **Durum**: Draft - Geliştirme Aşamasında

---

## 🎨 **1. Tasarım Felsefesi**

### **1.1 Tasarım Prensipleri**
- **Kullanıcı Odaklı**: Her tasarım kararı kullanıcı deneyimini iyileştirmeli
- **Basitlik**: Karmaşık özellikler basit arayüzlerle sunulmalı
- **Tutarlılık**: Tüm ekranlarda tutarlı tasarım dili
- **Erişilebilirlik**: Farklı yetenek seviyelerindeki kullanıcılar için uygun
- **Güvenilirlik**: Profesyonel ve güven veren görünüm

### **1.2 Hedef Kullanıcı Profili**
- **Yaş**: 25-45 yaş arası
- **Teknoloji Seviyesi**: Orta-İleri
- **Seyahat Sıklığı**: Ayda 1-2 kez
- **Cihaz Kullanımı**: Mobil öncelikli, tablet ve web destekli

---

## 🎨 **2. Renk Paleti**

### **2.1 Ana Renkler**

```dart
// Primary Colors
class AppColors {
  // Ana marka rengi - Seyahat ve güven
  static const Color primary = Color(0xFF2563EB);        // #2563EB
  static const Color primaryLight = Color(0xFF3B82F6);   // #3B82F6
  static const Color primaryDark = Color(0xFF1D4ED8);    // #1D4ED8
  
  // İkincil renk - Vurgu ve aksiyon
  static const Color secondary = Color(0xFF10B981);      // #10B981
  static const Color secondaryLight = Color(0xFF34D399); // #34D399
  static const Color secondaryDark = Color(0xFF059669);  // #059669
  
  // Nötr renkler - Metin ve arka plan
  static const Color neutral = Color(0xFF6B7280);        // #6B7280
  static const Color neutralLight = Color(0xFF9CA3AF);   // #9CA3AF
  static const Color neutralDark = Color(0xFF374151);    // #374151
}
```

### **2.2 Semantik Renkler**

```dart
// Semantic Colors
class SemanticColors {
  // Başarı durumları
  static const Color success = Color(0xFF10B981);        // #10B981
  static const Color successLight = Color(0xFFD1FAE5);  // #D1FAE5
  
  // Uyarı durumları
  static const Color warning = Color(0xFFF59E0B);        // #F59E0B
  static const Color warningLight = Color(0xFFFEF3C7);  // #FEF3C7
  
  // Hata durumları
  static const Color error = Color(0xFFEF4444);          // #EF4444
  static const Color errorLight = Color(0xFFFEE2E2);    // #FEE2E2
  
  // Bilgi durumları
  static const Color info = Color(0xFF3B82F6);           // #3B82F6
  static const Color infoLight = Color(0xFFDBEAFE);      // #DBEAFE
}
```

### **2.3 Arka Plan Renkleri**

```dart
// Background Colors
class BackgroundColors {
  // Ana arka plan
  static const Color primary = Color(0xFFFFFFFF);        // #FFFFFF
  static const Color secondary = Color(0xFFF9FAFB);     // #F9FAFB
  static const Color tertiary = Color(0xFFF3F4F6);      // #F3F4F6
  
  // Karanlık tema
  static const Color darkPrimary = Color(0xFF111827);    // #111827
  static const Color darkSecondary = Color(0xFF1F2937); // #1F2937
  static const Color darkTertiary = Color(0xFF374151);  // #374151
}
```

---

## 📝 **3. Tipografi Sistemi**

### **3.1 Font Ailesi**

```dart
// Typography System
class AppTypography {
  // Font family
  static const String fontFamily = 'Inter';
  static const String fontFamilyFallback = 'Roboto';
  
  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
```

### **3.2 Tipografi Ölçekleri**

```dart
// Typography Scale
class TypographyScale {
  // Display text - Ana başlıklar
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.16,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.22,
  );
  
  // Headline text - Alt başlıklar
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );
  
  // Title text - Sayfa başlıkları
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.27,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  // Body text - Ana metin
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  // Label text - Etiketler
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
}
```

---

## 📏 **4. Spacing ve Boyut Sistemi**

### **4.1 Spacing Ölçekleri**

```dart
// Spacing System
class AppSpacing {
  // Base spacing unit: 4px
  static const double xs = 4.0;    // 4px
  static const double sm = 8.0;    // 8px
  static const double md = 16.0;   // 16px
  static const double lg = 24.0;   // 24px
  static const double xl = 32.0;   // 32px
  static const double xxl = 48.0;  // 48px
  static const double xxxl = 64.0; // 64px
  
  // Custom spacing
  static const double section = 80.0;  // 80px
  static const double page = 120.0;    // 120px
}
```

### **4.2 Boyut Sistemi**

```dart
// Size System
class AppSizes {
  // Icon sizes
  static const double iconXs = 16.0;   // 16px
  static const double iconSm = 20.0;   // 20px
  static const double iconMd = 24.0;   // 24px
  static const double iconLg = 32.0;   // 32px
  static const double iconXl = 48.0;   // 48px
  
  // Button sizes
  static const double buttonHeight = 48.0;      // 48px
  static const double buttonHeightSmall = 40.0; // 40px
  static const double buttonHeightLarge = 56.0; // 56px
  
  // Input sizes
  static const double inputHeight = 48.0;       // 48px
  static const double inputHeightSmall = 40.0;  // 40px
  static const double inputHeightLarge = 56.0;  // 56px
  
  // Border radius
  static const double radiusXs = 4.0;   // 4px
  static const double radiusSm = 8.0;   // 8px
  static const double radiusMd = 12.0;  // 12px
  static const double radiusLg = 16.0;  // 16px
  static const double radiusXl = 24.0;  // 24px
  static const double radiusFull = 9999.0; // Full rounded
}
```

---

## 🎭 **5. Elevation ve Gölge Sistemi**

### **5.1 Elevation Seviyeleri**

```dart
// Elevation System
class AppElevation {
  // Light theme shadows
  static List<BoxShadow> get level1 => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level2 => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 1),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level3 => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level4 => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> get level5 => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      offset: const Offset(0, 16),
      blurRadius: 32,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      offset: const Offset(0, 32),
      blurRadius: 64,
      spreadRadius: 0,
    ),
  ];
}
```

---

## 🔘 **6. Bileşen Kütüphanesi**

### **6.1 Button Bileşenleri**

```dart
// Button Components
class AppButtons {
  // Primary Button
  static Widget primary({
    required String text,
    required VoidCallback onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TypographyScale.labelLarge.copyWith(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
  
  // Secondary Button
  static Widget secondary({
    required String text,
    required VoidCallback onPressed,
    bool isFullWidth = false,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? AppSizes.buttonHeight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
        child: Text(
          text,
          style: TypographyScale.labelLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
  
  // Text Button
  static Widget text({
    required String text,
    required VoidCallback onPressed,
    Color? textColor,
    bool isFullWidth = false,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height ?? AppSizes.buttonHeight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: textColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
        child: Text(
          text,
          style: TypographyScale.labelLarge.copyWith(
            color: textColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
```

### **6.2 Input Bileşenleri**

```dart
// Input Components
class AppInputs {
  // Text Input
  static Widget text({
    required String label,
    String? hint,
    String? errorText,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isRequired = false,
    int? maxLines,
    int? maxLength,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TypographyScale.labelLarge.copyWith(
                color: AppColors.neutralDark,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TypographyScale.labelLarge.copyWith(
                  color: AppColors.error,
                ),
              ),
          ],
        ),
        SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: isPassword,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          onTap: onTap,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TypographyScale.bodyMedium.copyWith(
              color: AppColors.neutralLight,
            ),
            filled: true,
            fillColor: BackgroundColors.secondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: AppSpacing.xs),
          Text(
            errorText,
            style: TypographyScale.bodySmall.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
  
  // Search Input
  static Widget search({
    required String hint,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
  }) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TypographyScale.bodyMedium.copyWith(
          color: AppColors.neutralLight,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.neutralLight,
          size: AppSizes.iconMd,
        ),
        suffixIcon: controller?.text.isNotEmpty == true
            ? IconButton(
                onPressed: onClear,
                icon: Icon(
                  Icons.clear,
                  color: AppColors.neutralLight,
                  size: AppSizes.iconMd,
                ),
              )
            : null,
        filled: true,
        fillColor: BackgroundColors.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),
    );
  }
}
```

### **6.3 Card Bileşenleri**

```dart
// Card Components
class AppCards {
  // Basic Card
  static Widget basic({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    List<BoxShadow>? boxShadow,
    BorderRadius? borderRadius,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: margin ?? EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor ?? BackgroundColors.primary,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusMd),
        boxShadow: boxShadow ?? AppElevation.level1,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.radiusMd),
          child: Padding(
            padding: padding ?? EdgeInsets.all(AppSpacing.md),
            child: child,
          ),
        ),
      ),
    );
  }
  
  // Travel Card
  static Widget travel({
    required String title,
    required String location,
    required String imageUrl,
    required String price,
    required double rating,
    required VoidCallback onTap,
    bool isFavorite = false,
    VoidCallback? onFavoriteToggle,
  }) {
    return AppCards.basic(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: BackgroundColors.tertiary,
                      child: Icon(
                        Icons.image,
                        size: AppSizes.iconXl,
                        color: AppColors.neutralLight,
                      ),
                    );
                  },
                ),
              ),
              if (onFavoriteToggle != null)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: IconButton(
                    onPressed: onFavoriteToggle,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.error : Colors.white,
                      size: AppSizes.iconMd,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ),
              Positioned(
                bottom: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  child: Text(
                    price,
                    style: TypographyScale.labelMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: TypographyScale.titleMedium.copyWith(
              color: AppColors.neutralDark,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: AppSizes.iconSm,
                color: AppColors.neutralLight,
              ),
              SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  location,
                  style: TypographyScale.bodyMedium.copyWith(
                    color: AppColors.neutralLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.star,
                size: AppSizes.iconSm,
                color: AppColors.warning,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                rating.toString(),
                style: TypographyScale.bodyMedium.copyWith(
                  color: AppColors.neutralDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

---

## 📱 **7. Responsive Tasarım Sistemi**

### **7.1 Breakpoint Sistemi**

```dart
// Responsive Breakpoints
class AppBreakpoints {
  // Mobile first approach
  static const double mobile = 0;      // 0px - 599px
  static const double tablet = 600;    // 600px - 1023px
  static const double desktop = 1024;  // 1024px - 1439px
  static const double wide = 1440;     // 1440px+
  
  // Helper methods
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tablet;
      
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet &&
      MediaQuery.of(context).size.width < desktop;
      
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;
      
  static bool isWide(BuildContext context) =>
      MediaQuery.of(context).size.width >= wide;
}
```

### **7.2 Responsive Layout Helper'ları**

```dart
// Responsive Layout Helpers
class ResponsiveLayout {
  // Responsive padding
  static EdgeInsets responsivePadding(BuildContext context) {
    if (AppBreakpoints.isMobile(context)) {
      return EdgeInsets.all(AppSpacing.md);
    } else if (AppBreakpoints.isTablet(context)) {
      return EdgeInsets.all(AppSpacing.lg);
    } else {
      return EdgeInsets.all(AppSpacing.xl);
    }
  }
  
  // Responsive margin
  static EdgeInsets responsiveMargin(BuildContext context) {
    if (AppBreakpoints.isMobile(context)) {
      return EdgeInsets.all(AppSpacing.sm);
    } else if (AppBreakpoints.isTablet(context)) {
      return EdgeInsets.all(AppSpacing.md);
    } else {
      return EdgeInsets.all(AppSpacing.lg);
    }
  }
  
  // Responsive spacing
  static double responsiveSpacing(BuildContext context) {
    if (AppBreakpoints.isMobile(context)) {
      return AppSpacing.md;
    } else if (AppBreakpoints.isTablet(context)) {
      return AppSpacing.lg;
    } else {
      return AppSpacing.xl;
    }
  }
}
```

---

## 🌙 **8. Tema Sistemi**

### **8.1 Light Theme**

```dart
// Light Theme
class AppLightTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: BackgroundColors.primary,
      background: BackgroundColors.primary,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.neutralDark,
      onBackground: AppColors.neutralDark,
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TypographyScale.displayLarge.copyWith(
        color: AppColors.neutralDark,
      ),
      displayMedium: TypographyScale.displayMedium.copyWith(
        color: AppColors.neutralDark,
      ),
      displaySmall: TypographyScale.displaySmall.copyWith(
        color: AppColors.neutralDark,
      ),
      headlineLarge: TypographyScale.headlineLarge.copyWith(
        color: AppColors.neutralDark,
      ),
      headlineMedium: TypographyScale.headlineMedium.copyWith(
        color: AppColors.neutralDark,
      ),
      headlineSmall: TypographyScale.headlineSmall.copyWith(
        color: AppColors.neutralDark,
      ),
      titleLarge: TypographyScale.titleLarge.copyWith(
        color: AppColors.neutralDark,
      ),
      titleMedium: TypographyScale.titleMedium.copyWith(
        color: AppColors.neutralDark,
      ),
      titleSmall: TypographyScale.titleSmall.copyWith(
        color: AppColors.neutralDark,
      ),
      bodyLarge: TypographyScale.bodyLarge.copyWith(
        color: AppColors.neutralDark,
      ),
      bodyMedium: TypographyScale.bodyMedium.copyWith(
        color: AppColors.neutralDark,
      ),
      bodySmall: TypographyScale.bodySmall.copyWith(
        color: AppColors.neutralDark,
      ),
      labelLarge: TypographyScale.labelLarge.copyWith(
        color: AppColors.neutralDark,
      ),
      labelMedium: TypographyScale.labelMedium.copyWith(
        color: AppColors.neutralDark,
      ),
      labelSmall: TypographyScale.labelSmall.copyWith(
        color: AppColors.neutralDark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: BackgroundColors.secondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    ),
    cardTheme: CardTheme(
      color: BackgroundColors.primary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      margin: EdgeInsets.all(AppSpacing.md),
    ),
  );
}
```

### **8.2 Dark Theme**

```dart
// Dark Theme
class AppDarkTheme {
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: BackgroundColors.darkSecondary,
      background: BackgroundColors.darkPrimary,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),
    textTheme: TextTheme(
      displayLarge: TypographyScale.displayLarge.copyWith(
        color: Colors.white,
      ),
      displayMedium: TypographyScale.displayMedium.copyWith(
        color: Colors.white,
      ),
      displaySmall: TypographyScale.displaySmall.copyWith(
        color: Colors.white,
      ),
      headlineLarge: TypographyScale.headlineLarge.copyWith(
        color: Colors.white,
      ),
      headlineMedium: TypographyScale.headlineMedium.copyWith(
        color: Colors.white,
      ),
      headlineSmall: TypographyScale.headlineSmall.copyWith(
        color: Colors.white,
      ),
      titleLarge: TypographyScale.titleLarge.copyWith(
        color: Colors.white,
      ),
      titleMedium: TypographyScale.titleMedium.copyWith(
        color: Colors.white,
      ),
      titleSmall: TypographyScale.titleSmall.copyWith(
        color: Colors.white,
      ),
      bodyLarge: TypographyScale.bodyLarge.copyWith(
        color: Colors.white,
      ),
      bodyMedium: TypographyScale.bodyMedium.copyWith(
        color: Colors.white,
      ),
      bodySmall: TypographyScale.bodySmall.copyWith(
        color: Colors.white,
      ),
      labelLarge: TypographyScale.labelLarge.copyWith(
        color: Colors.white,
      ),
      labelMedium: TypographyScale.labelMedium.copyWith(
        color: Colors.white,
      ),
      labelSmall: TypographyScale.labelSmall.copyWith(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        side: BorderSide(color: AppColors.primaryLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: BackgroundColors.darkTertiary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide(color: AppColors.primaryLight),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        borderSide: BorderSide(color: AppColors.error),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
    ),
    cardTheme: CardTheme(
      color: BackgroundColors.darkSecondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      margin: EdgeInsets.all(AppSpacing.md),
    ),
  );
}
```

---

## ♿ **9. Erişilebilirlik**

### **9.1 Erişilebilirlik Standartları**
- **WCAG 2.1 AA** uyumluluğu
- **Screen Reader** desteği
- **Keyboard Navigation** desteği
- **High Contrast** modları
- **Large Text** seçenekleri

### **9.2 Erişilebilirlik Uygulamaları**

```dart
// Accessibility Helpers
class AccessibilityHelpers {
  // Semantic label
  static String getSemanticLabel(String text, String context) {
    return '$text, $context';
  }
  
  // Screen reader hint
  static String getScreenReaderHint(String action, String target) {
    return '$action $target';
  }
  
  // High contrast support
  static Color getHighContrastColor(Color baseColor, BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    if (brightness == Brightness.dark) {
      return baseColor.withOpacity(0.9);
    } else {
      return baseColor.withOpacity(0.8);
    }
  }
}
```

---

## 🔗 **10. İlgili Dokümanlar**

- [Component Library](./components.md)
- [Screen Specifications](./screens.md)
- [User Interface Flows](./ui-flows.md)
- [Technical Architecture](../technical/architecture.md)
- [Task Matrix](../project/task-matrix.md)

---

## 📝 **11. Değişiklik Geçmişi**

| Versiyon | Tarih | Değişiklik | Yazan |
|----------|-------|------------|-------|
| 1.0.0 | 29.08.2025 | İlk versiyon | AI Assistant |

---

## 📞 **12. İletişim**

- **Design Lead**: TBD
- **UI/UX Team**: TBD
- **Frontend Team**: TBD
- **Product Owner**: Senol
