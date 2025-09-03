import 'package:flutter/material.dart';

class TypographyScale {
  // Font sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSize2XL = 20.0;
  static const double fontSize3XL = 24.0;
  static const double fontSize4XL = 32.0;
  static const double fontSize5XL = 40.0;

  // Line heights
  static const double lineHeightXS = 1.2;
  static const double lineHeightS = 1.3;
  static const double lineHeightM = 1.4;
  static const double lineHeightL = 1.5;
  static const double lineHeightXL = 1.6;

  // Letter spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingWider = 1.0;

  // Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Text styles
  static const TextStyle headlineXS = TextStyle(
    fontSize: fontSizeM,
    fontWeight: fontWeightSemiBold,
    height: lineHeightS,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headlineS = TextStyle(
    fontSize: fontSizeL,
    fontWeight: fontWeightSemiBold,
    height: lineHeightS,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headlineM = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: fontWeightSemiBold,
    height: lineHeightS,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headlineL = TextStyle(
    fontSize: fontSize2XL,
    fontWeight: fontWeightBold,
    height: lineHeightS,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headlineXL = TextStyle(
    fontSize: fontSize3XL,
    fontWeight: fontWeightBold,
    height: lineHeightXS,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headline2XL = TextStyle(
    fontSize: fontSize4XL,
    fontWeight: fontWeightBold,
    height: lineHeightXS,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headline3XL = TextStyle(
    fontSize: fontSize5XL,
    fontWeight: fontWeightBold,
    height: lineHeightXS,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle bodyXS = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: fontWeightRegular,
    height: lineHeightM,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyS = TextStyle(
    fontSize: fontSizeS,
    fontWeight: fontWeightRegular,
    height: lineHeightM,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyM = TextStyle(
    fontSize: fontSizeM,
    fontWeight: fontWeightRegular,
    height: lineHeightM,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyL = TextStyle(
    fontSize: fontSizeL,
    fontWeight: fontWeightRegular,
    height: lineHeightM,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyXL = TextStyle(
    fontSize: fontSizeXL,
    fontWeight: fontWeightRegular,
    height: lineHeightM,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle labelXS = TextStyle(
    fontSize: fontSizeXS,
    fontWeight: fontWeightMedium,
    height: lineHeightS,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle labelS = TextStyle(
    fontSize: fontSizeS,
    fontWeight: fontWeightMedium,
    height: lineHeightS,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle labelM = TextStyle(
    fontSize: fontSizeM,
    fontWeight: fontWeightMedium,
    height: lineHeightS,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle labelL = TextStyle(
    fontSize: fontSizeL,
    fontWeight: fontWeightMedium,
    height: lineHeightS,
    letterSpacing: letterSpacingNormal,
  );

  // Aliases for common usage
  static const TextStyle headlineLarge = headlineL;
  static const TextStyle bodyMedium = bodyM;
  static const TextStyle bodySmall = bodyS;
  static const TextStyle labelLarge = labelL;
}
