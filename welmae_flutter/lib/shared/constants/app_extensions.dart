import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

extension TextStyleExtensions on BuildContext {
  // Display Text Styles
  TextStyle get displayLarge => AppTextStyles.displayLarge;
  TextStyle get displayMedium => AppTextStyles.displayMedium;
  TextStyle get displaySmall => AppTextStyles.displaySmall;

  // Headline Text Styles
  TextStyle get headlineLarge => AppTextStyles.headlineLarge;
  TextStyle get headlineMedium => AppTextStyles.headlineMedium;
  TextStyle get headlineSmall => AppTextStyles.headlineSmall;

  // Title Text Styles
  TextStyle get titleLarge => AppTextStyles.titleLarge;
  TextStyle get titleMedium => AppTextStyles.titleMedium;
  TextStyle get titleSmall => AppTextStyles.titleSmall;

  // Label Text Styles
  TextStyle get labelLarge => AppTextStyles.labelLarge;
  TextStyle get labelMedium => AppTextStyles.labelMedium;
  TextStyle get labelSmall => AppTextStyles.labelSmall;

  // Body Text Styles
  TextStyle get bodyLarge => AppTextStyles.bodyLarge;
  TextStyle get bodyMedium => AppTextStyles.bodyMedium;
  TextStyle get bodySmall => AppTextStyles.bodySmall;

  // Hero Text Styles
  TextStyle get hero => AppTextStyles.hero;

  // Mega Text Styles
  TextStyle get mega => AppTextStyles.mega;

  // Giga Text Styles
  TextStyle get giga => AppTextStyles.giga;

  // Tera Text Styles
  TextStyle get tera => AppTextStyles.tera;

  // Peta Text Styles
  TextStyle get peta => AppTextStyles.peta;

  // Exa Text Styles
  TextStyle get exa => AppTextStyles.exa;

  // Zetta Text Styles
  TextStyle get zetta => AppTextStyles.zetta;

  // Yotta Text Styles
  TextStyle get yotta => AppTextStyles.yotta;
}

extension ColorExtensions on BuildContext {
  // Primary colors
  Color get primary => Theme.of(this).colorScheme.primary;
  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;
  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;
  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  // Secondary colors
  Color get secondary => Theme.of(this).colorScheme.secondary;
  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;
  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;
  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;

  // Tertiary colors
  Color get tertiary => Theme.of(this).colorScheme.tertiary;
  Color get onTertiary => Theme.of(this).colorScheme.onTertiary;
  Color get tertiaryContainer => Theme.of(this).colorScheme.tertiaryContainer;
  Color get onTertiaryContainer =>
      Theme.of(this).colorScheme.onTertiaryContainer;

  // Error colors
  Color get error => Theme.of(this).colorScheme.error;
  Color get onError => Theme.of(this).colorScheme.onError;
  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;
  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  // Background colors
  Color get background => Theme.of(this).colorScheme.surface;
  Color get onBackground => Theme.of(this).colorScheme.onSurface;

  // Surface colors
  Color get surface => Theme.of(this).colorScheme.surface;
  Color get onSurface => Theme.of(this).colorScheme.onSurface;
  Color get surfaceVariant =>
      Theme.of(this).colorScheme.surfaceContainerHighest;
  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  // Outline colors
  Color get outline => Theme.of(this).colorScheme.outline;
  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;
}

extension BuildContextExtensions on BuildContext {
  // Theme extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Spacing extensions
  double get micro => AppSpacing.micro;
  double get tiny => AppSpacing.tiny;
  double get extraSmall => AppSpacing.extraSmall;
  double get small => AppSpacing.small;
  double get medium => AppSpacing.medium;
  double get large => AppSpacing.large;
  double get extraLarge => AppSpacing.extraLarge;
  double get huge => AppSpacing.huge;
  double get massive => AppSpacing.massive;
  double get gigantic => AppSpacing.gigantic;
  double get colossal => AppSpacing.colossal;
}
