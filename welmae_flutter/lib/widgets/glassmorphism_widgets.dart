import 'package:flutter/material.dart';
import 'dart:ui';
import '../app/theme/typography.dart';
import '../app/theme/dimensions.dart';

class GlassmorphismWidgets {
  // Glassmorphism Container
  static Widget buildGlassContainer({
    required Widget child,
    double blur = 10.0,
    double opacity = 0.2,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 16.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
  }) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: (backgroundColor ?? Colors.white).withValues(
                alpha: opacity,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: borderColor != null
                  ? Border.all(
                      color: borderColor.withValues(alpha: 0.3),
                      width: borderWidth,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // Glassmorphism Card
  static Widget buildGlassCard({
    required Widget child,
    double blur = 15.0,
    double opacity = 0.15,
    Color? borderColor,
    double borderWidth = 1.5,
    double borderRadius = 20.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    List<BoxShadow>? customShadows,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(AppSpacing.md),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: (backgroundColor ?? Colors.white).withValues(
                alpha: opacity,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: (borderColor ?? Colors.white).withValues(alpha: 0.3),
                width: borderWidth,
              ),
              boxShadow:
                  customShadows ??
                  [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 25,
                      offset: const Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // Glassmorphism Button
  static Widget buildGlassButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    double blur = 10.0,
    double opacity = 0.2,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 25.0,
    EdgeInsetsGeometry? padding,
    Color? textColor,
    Color? backgroundColor,
    double? width,
    double? height,
    bool isOutlined = false,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Container(
                padding:
                    padding ??
                    const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                decoration: BoxDecoration(
                  color: isOutlined
                      ? Colors.transparent
                      : (backgroundColor ?? Colors.white).withValues(
                          alpha: opacity,
                        ),
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    color: (borderColor ?? Colors.white).withValues(alpha: 0.3),
                    width: borderWidth,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: textColor ?? Colors.white, size: 20),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      text,
                      style: AppTypography.bodyMedium.copyWith(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Glassmorphism Input Field
  static Widget buildGlassInput({
    required String label,
    String? hint,
    TextEditingController? controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    double blur = 10.0,
    double opacity = 0.15,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 16.0,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? textColor,
    Color? labelColor,
  }) {
    return GlassmorphismWidgets.buildGlassContainer(
      blur: blur,
      opacity: opacity,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      padding: padding ?? const EdgeInsets.all(AppSpacing.md),
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: labelColor ?? Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              if (prefixIcon != null) ...[
                Icon(
                  prefixIcon,
                  color: textColor ?? Colors.white.withValues(alpha: 0.7),
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color:
                          textColor?.withValues(alpha: 0.5) ??
                          Colors.white.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: onSuffixTap,
                  child: Icon(
                    suffixIcon,
                    color: textColor ?? Colors.white.withValues(alpha: 0.7),
                    size: 20,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // Glassmorphism Navigation Bar
  static Widget buildGlassNavigationBar({
    required List<GlassNavigationItem> items,
    required int currentIndex,
    required ValueChanged<int> onTap,
    double blur = 20.0,
    double opacity = 0.1,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 25.0,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(AppSpacing.lg),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: (backgroundColor ?? Colors.white).withValues(
                alpha: opacity,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: (borderColor ?? Colors.white).withValues(alpha: 0.3),
                width: borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == currentIndex;

                return GestureDetector(
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(borderRadius - 5),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.7),
                          size: 24,
                        ),
                        if (isSelected) ...[
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            item.label,
                            style: AppTypography.bodySmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // Glassmorphism Modal
  static Widget buildGlassModal({
    required Widget child,
    double blur = 25.0,
    double opacity = 0.1,
    Color? borderColor,
    double borderWidth = 1.5,
    double borderRadius = 25.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: (backgroundColor ?? Colors.white).withValues(
                alpha: opacity,
              ),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: (borderColor ?? Colors.white).withValues(alpha: 0.3),
                width: borderWidth,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 25),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -10),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // Glassmorphism Progress Bar
  static Widget buildGlassProgressBar({
    required double progress,
    double blur = 10.0,
    double opacity = 0.15,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 25.0,
    double height = 8.0,
    Color? backgroundColor,
    Color? progressColor,
    Color? textColor,
    bool showPercentage = true,
  }) {
    return GlassmorphismWidgets.buildGlassContainer(
      blur: blur,
      opacity: opacity,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      padding: const EdgeInsets.all(AppSpacing.sm),
      backgroundColor: backgroundColor,
      child: Column(
        children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: progressColor ?? Colors.blue,
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: (progressColor ?? Colors.blue).withValues(
                        alpha: 0.5,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (showPercentage) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${(progress * 100).round()}%',
              style: AppTypography.bodySmall.copyWith(
                color: textColor ?? Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Glassmorphism Chip
  static Widget buildGlassChip({
    required String label,
    IconData? icon,
    VoidCallback? onTap,
    bool isSelected = false,
    double blur = 10.0,
    double opacity = 0.15,
    Color? borderColor,
    double borderWidth = 1.0,
    double borderRadius = 20.0,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
    Color? textColor,
    Color? selectedColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassmorphismWidgets.buildGlassContainer(
        blur: blur,
        opacity: isSelected ? 0.3 : opacity,
        borderColor: isSelected ? selectedColor : borderColor,
        borderWidth: isSelected ? 2.0 : borderWidth,
        borderRadius: borderRadius,
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
        backgroundColor: isSelected ? selectedColor : backgroundColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? Colors.white, size: 18),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: textColor ?? Colors.white,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassNavigationItem {
  final String label;
  final IconData icon;

  const GlassNavigationItem({required this.label, required this.icon});
}
