import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;
  static const double _desktopBreakpoint = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < _mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= _mobileBreakpoint && width < _tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= _desktopBreakpoint;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getResponsiveValue<T extends num>(
    BuildContext context, {
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile.toDouble();
    if (isTablet(context)) return tablet.toDouble();
    return desktop.toDouble();
  }

  static EdgeInsets getResponsivePadding(
    BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    final defaultMobile = const EdgeInsets.all(16.0);
    final defaultTablet = const EdgeInsets.all(24.0);
    final defaultDesktop = const EdgeInsets.all(32.0);

    if (isMobile(context)) return mobile ?? defaultMobile;
    if (isTablet(context)) return tablet ?? defaultTablet;
    return desktop ?? defaultDesktop;
  }

  static double getResponsiveFontSize(
    BuildContext context, {
    required double baseSize,
    double? mobileScale = 1.0,
    double? tabletScale = 1.1,
    double? desktopScale = 1.2,
  }) {
    final scale = getResponsiveValue(
      context,
      mobile: mobileScale ?? 1.0,
      tablet: tabletScale ?? 1.1,
      desktop: desktopScale ?? 1.2,
    );
    return baseSize * scale;
  }

  static int getResponsiveGridCount(
    BuildContext context, {
    int? mobile,
    int? tablet,
    int? desktop,
  }) {
    if (isMobile(context)) return mobile ?? 1;
    if (isTablet(context)) return tablet ?? 2;
    return desktop ?? 3;
  }

  static double getResponsiveSpacing(
    BuildContext context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    final defaultMobile = 8.0;
    final defaultTablet = 12.0;
    final defaultDesktop = 16.0;

    if (isMobile(context)) return mobile ?? defaultMobile;
    if (isTablet(context)) return tablet ?? defaultTablet;
    return desktop ?? defaultDesktop;
  }
}

// Responsive widget'lar
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context) && desktop != null) {
      return desktop!;
    }
    if (ResponsiveHelper.isTablet(context) && tablet != null) {
      return tablet!;
    }
    return mobile;
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveHelper._desktopBreakpoint && desktop != null) {
          return desktop!;
        }
        if (constraints.maxWidth >= ResponsiveHelper._tabletBreakpoint && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}

// Responsive grid
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final EdgeInsets padding;
  final int? mobileCrossAxisCount;
  final int? tabletCrossAxisCount;
  final int? desktopCrossAxisCount;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.padding = EdgeInsets.zero,
    this.mobileCrossAxisCount,
    this.tabletCrossAxisCount,
    this.desktopCrossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveHelper.getResponsiveGridCount(
      context,
      mobile: mobileCrossAxisCount ?? 1,
      tablet: tabletCrossAxisCount ?? 2,
      desktop: desktopCrossAxisCount ?? 3,
    );

    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: runSpacing,
        childAspectRatio: _getChildAspectRatio(context),
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
    );
  }

  double _getChildAspectRatio(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) return 1.0;
    if (ResponsiveHelper.isTablet(context)) return 1.2;
    return 1.5;
  }
}

// Responsive list
class ResponsiveList extends StatelessWidget {
  final List<Widget> children;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;
  final double? mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;

  const ResponsiveList({
    super.key,
    required this.children,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
    this.mobileSpacing,
    this.tabletSpacing,
    this.desktopSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ResponsiveHelper.getResponsiveSpacing(
      context,
      mobile: mobileSpacing ?? 8.0,
      tablet: tabletSpacing ?? 12.0,
      desktop: desktopSpacing ?? 16.0,
    );

    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => children[index],
    );
  }
}

// Responsive text
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double baseFontSize;
  final double? mobileScale;
  final double? tabletScale;
  final double? desktopScale;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.baseFontSize = 16.0,
    this.mobileScale,
    this.tabletScale,
    this.desktopScale,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      baseSize: baseFontSize,
      mobileScale: mobileScale,
      tabletScale: tabletScale,
      desktopScale: desktopScale,
    );

    final responsiveStyle = (style ?? const TextStyle()).copyWith(
      fontSize: fontSize,
    );

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

// Responsive container
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? mobileMargin;
  final EdgeInsets? tabletMargin;
  final EdgeInsets? desktopMargin;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
  });

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveHelper.getResponsivePadding(
      context,
      mobile: mobilePadding,
      tablet: tabletPadding,
      desktop: desktopPadding,
    );

    final margin = ResponsiveHelper.getResponsivePadding(
      context,
      mobile: mobileMargin,
      tablet: tabletMargin,
      desktop: desktopMargin,
    );

    final width = ResponsiveHelper.getResponsiveValue(
      context,
      mobile: mobileWidth ?? double.infinity,
      tablet: tabletWidth ?? double.infinity,
      desktop: desktopWidth ?? double.infinity,
    );

    final height = ResponsiveHelper.getResponsiveValue(
      context,
      mobile: mobileHeight ?? 0,
      tablet: tabletHeight ?? 0,
      desktop: desktopHeight ?? 0,
    );

    return Container(
      width: width == double.infinity ? null : width,
      height: height == 0 ? null : height,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}

// Accessibility helper
class AccessibilityHelper {
  static bool isAccessibilityEnabled(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }

  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.of(context).highContrast;
  }

  static bool isBoldTextEnabled(BuildContext context) {
    return MediaQuery.of(context).boldText;
  }

  static double getTextScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaler.scale(1.0);
  }

  static bool shouldUseLargeText(BuildContext context) {
    return getTextScaleFactor(context) > 1.2;
  }

  static bool shouldUseExtraLargeText(BuildContext context) {
    return getTextScaleFactor(context) > 1.5;
  }
}

// Responsive breakpoint constants
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1200;
  static const double largeDesktop = 1440;
}

// Responsive orientation helper
class OrientationHelper {
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static Widget buildResponsiveLayout({
    required BuildContext context,
    required Widget portrait,
    required Widget landscape,
  }) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return landscape;
        }
        return portrait;
      },
    );
  }
}
