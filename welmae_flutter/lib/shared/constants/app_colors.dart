import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryContainer = Color(0xFFE3F2FD);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF0D47A1);

  // Secondary colors
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryContainer = Color(0xFFE8F5E8);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF1B5E20);

  // Tertiary colors
  static const Color tertiary = Color(0xFFFF9800);
  static const Color tertiaryContainer = Color(0xFFFFF3E0);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFE65100);

  // Error colors
  static const Color error = Color(0xFFE53E3E);
  static const Color errorContainer = Color(0xFFFFEDED);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF742A2A);

  // Warning colors
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFFF7ED);
  static const Color onWarning = Color(0xFFFFFFFF);
  static const Color onWarningContainer = Color(0xFF92400E);

  // Success colors
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFECFDF5);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onSuccessContainer = Color(0xFF065F46);

  // Surface colors
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color onSurface = Color(0xFF000000);
  static const Color onSurfaceVariant = Color(0xFF757575);

  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF000000);

  // Outline colors
  static const Color outline = Color(0xFFE0E0E0);
  static const Color outlineVariant = Color(0xFFF5F5F5);

  // Neutral colors
  static const Color neutral = Color(0xFF9E9E9E);
  static const Color neutralLight = Color(0xFFBDBDBD);
  static const Color neutralDark = Color(0xFF424242);
  static const Color neutralVariant = Color(0xFFEEEEEE);

  // Additional brand colors
  static const Color brand = Color(0xFF1976D2);
  static const Color brandLight = Color(0xFF42A5F5);
  static const Color brandDark = Color(0xFF0D47A1);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, brandLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Opacity colors
  static Color primaryWithOpacity(double opacity) =>
      primary.withValues(alpha: opacity);
  static Color secondaryWithOpacity(double opacity) =>
      secondary.withValues(alpha: opacity);
  static Color errorWithOpacity(double opacity) =>
      error.withValues(alpha: opacity);
  static Color warningWithOpacity(double opacity) =>
      warning.withValues(alpha: opacity);
  static Color successWithOpacity(double opacity) =>
      success.withValues(alpha: opacity);

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkPrimaryContainer = Color(0xFF1565C0);
  static const Color darkOnPrimary = Color(0xFF003C8F);
  static const Color darkOnPrimaryContainer = Color(0xFFE3F2FD);

  static const Color darkSecondary = Color(0xFF81C784);
  static const Color darkSecondaryContainer = Color(0xFF388E3C);
  static const Color darkOnSecondary = Color(0xFF1B5E20);
  static const Color darkOnSecondaryContainer = Color(0xFFE8F5E8);

  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceVariant = Color(0xFF1E1E1E);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnSurfaceVariant = Color(0xFFB3B3B3);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkOnBackground = Color(0xFFFFFFFF);

  static const Color darkOutline = Color(0xFF424242);
  static const Color darkOutlineVariant = Color(0xFF2E2E2E);
}
