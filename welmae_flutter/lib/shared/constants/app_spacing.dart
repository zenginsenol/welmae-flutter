import 'package:flutter/material.dart';

class AppSpacing {
  // Basic spacing values
  static const double none = 0.0;
  static const double micro = 2.0;
  static const double tiny = 4.0;
  static const double extraSmall = 8.0;
  static const double small = 12.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double huge = 48.0;
  static const double massive = 64.0;
  static const double gigantic = 96.0;
  static const double colossal = 128.0;

  // Short aliases for common usage
  static const double lg = large;  // 24.0
  static const double xxl = massive;  // 64.0
  static const double md = medium;  // 16.0
  static const double xl = extraLarge;  // 32.0
  static const double sm = small;  // 12.0

  // Common EdgeInsets
  static const EdgeInsets paddingNone = EdgeInsets.zero;
  static const EdgeInsets paddingMicro = EdgeInsets.all(micro);
  static const EdgeInsets paddingTiny = EdgeInsets.all(tiny);
  static const EdgeInsets paddingExtraSmall = EdgeInsets.all(extraSmall);
  static const EdgeInsets paddingSmall = EdgeInsets.all(small);
  static const EdgeInsets paddingMedium = EdgeInsets.all(medium);
  static const EdgeInsets paddingLarge = EdgeInsets.all(large);
  static const EdgeInsets paddingExtraLarge = EdgeInsets.all(extraLarge);
  static const EdgeInsets paddingHuge = EdgeInsets.all(huge);

  // Horizontal padding
  static const EdgeInsets paddingHorizontalMicro = EdgeInsets.symmetric(
    horizontal: micro,
  );
  static const EdgeInsets paddingHorizontalTiny = EdgeInsets.symmetric(
    horizontal: tiny,
  );
  static const EdgeInsets paddingHorizontalExtraSmall = EdgeInsets.symmetric(
    horizontal: extraSmall,
  );
  static const EdgeInsets paddingHorizontalSmall = EdgeInsets.symmetric(
    horizontal: small,
  );
  static const EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(
    horizontal: medium,
  );
  static const EdgeInsets paddingHorizontalLarge = EdgeInsets.symmetric(
    horizontal: large,
  );
  static const EdgeInsets paddingHorizontalExtraLarge = EdgeInsets.symmetric(
    horizontal: extraLarge,
  );

  // Vertical padding
  static const EdgeInsets paddingVerticalMicro = EdgeInsets.symmetric(
    vertical: micro,
  );
  static const EdgeInsets paddingVerticalTiny = EdgeInsets.symmetric(
    vertical: tiny,
  );
  static const EdgeInsets paddingVerticalExtraSmall = EdgeInsets.symmetric(
    vertical: extraSmall,
  );
  static const EdgeInsets paddingVerticalSmall = EdgeInsets.symmetric(
    vertical: small,
  );
  static const EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(
    vertical: medium,
  );
  static const EdgeInsets paddingVerticalLarge = EdgeInsets.symmetric(
    vertical: large,
  );
  static const EdgeInsets paddingVerticalExtraLarge = EdgeInsets.symmetric(
    vertical: extraLarge,
  );

  // SizedBox helpers
  static const SizedBox verticalSpaceMicro = SizedBox(height: micro);
  static const SizedBox verticalSpaceTiny = SizedBox(height: tiny);
  static const SizedBox verticalSpaceExtraSmall = SizedBox(height: extraSmall);
  static const SizedBox verticalSpaceSmall = SizedBox(height: small);
  static const SizedBox verticalSpaceMedium = SizedBox(height: medium);
  static const SizedBox verticalSpaceLarge = SizedBox(height: large);
  static const SizedBox verticalSpaceExtraLarge = SizedBox(height: extraLarge);
  static const SizedBox verticalSpaceHuge = SizedBox(height: huge);

  static const SizedBox horizontalSpaceMicro = SizedBox(width: micro);
  static const SizedBox horizontalSpaceTiny = SizedBox(width: tiny);
  static const SizedBox horizontalSpaceExtraSmall = SizedBox(width: extraSmall);
  static const SizedBox horizontalSpaceSmall = SizedBox(width: small);
  static const SizedBox horizontalSpaceMedium = SizedBox(width: medium);
  static const SizedBox horizontalSpaceLarge = SizedBox(width: large);
  static const SizedBox horizontalSpaceExtraLarge = SizedBox(width: extraLarge);
  static const SizedBox horizontalSpaceHuge = SizedBox(width: huge);

  // Gap helpers (for Flex widgets)
  static double get gapMicro => micro;
  static double get gapTiny => tiny;
  static double get gapExtraSmall => extraSmall;
  static double get gapSmall => small;
  static double get gapMedium => medium;
  static double get gapLarge => large;
  static double get gapExtraLarge => extraLarge;
  static double get gapHuge => huge;

  // Common margins
  static const EdgeInsets marginNone = EdgeInsets.zero;
  static const EdgeInsets marginMicro = EdgeInsets.all(micro);
  static const EdgeInsets marginTiny = EdgeInsets.all(tiny);
  static const EdgeInsets marginExtraSmall = EdgeInsets.all(extraSmall);
  static const EdgeInsets marginSmall = EdgeInsets.all(small);
  static const EdgeInsets marginMedium = EdgeInsets.all(medium);
  static const EdgeInsets marginLarge = EdgeInsets.all(large);
  static const EdgeInsets marginExtraLarge = EdgeInsets.all(extraLarge);

  // Custom spacing methods
  static EdgeInsets symmetric({double? horizontal, double? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 0.0,
      vertical: vertical ?? 0.0,
    );
  }

  static EdgeInsets only({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? 0.0,
      top: top ?? 0.0,
      right: right ?? 0.0,
      bottom: bottom ?? 0.0,
    );
  }

  static SizedBox verticalSpace(double height) => SizedBox(height: height);
  static SizedBox horizontalSpace(double width) => SizedBox(width: width);
}
