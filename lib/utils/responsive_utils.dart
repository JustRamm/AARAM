import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 && 
           MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static bool isWeb(BuildContext context) {
    return MediaQuery.of(context).size.width > 0 && 
           MediaQuery.of(context).size.height > 0;
  }

  // Platform detection
  static bool isIOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS;
  }

  static bool isAndroid(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.android;
  }

  static bool isMacOS(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.macOS;
  }

  static bool isWindows(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.windows;
  }

  static bool isLinux(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.linux;
  }

  // Simple responsive values
  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14,
    double tablet = 16,
    double desktop = 18,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static double getResponsiveSpacing(BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static double getResponsiveIconSize(BuildContext context, {
    double mobile = 24,
    double tablet = 28,
    double desktop = 32,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static double getResponsiveLogoSize(BuildContext context, {
    double mobile = 80,
    double tablet = 120,
    double desktop = 160,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static EdgeInsets getResponsivePadding(BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    double padding = getResponsiveSpacing(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.all(padding);
  }

  static EdgeInsets getResponsiveMargin(BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    double margin = getResponsiveSpacing(context, mobile: mobile, tablet: tablet, desktop: desktop);
    return EdgeInsets.all(margin);
  }

  static double getResponsiveBorderRadius(BuildContext context, {
    double mobile = 12,
    double tablet = 16,
    double desktop = 20,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static double getResponsiveButtonHeight(BuildContext context, {
    double mobile = 48,
    double tablet = 56,
    double desktop = 64,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static EdgeInsets getResponsiveCardPadding(BuildContext context) {
    return EdgeInsets.all(getResponsiveSpacing(context, mobile: 12, tablet: 16, desktop: 20));
  }

  static int getResponsiveGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 4;
  }

  static double getResponsiveAspectRatio(BuildContext context) {
    if (isMobile(context)) return 1.2;
    if (isTablet(context)) return 1.5;
    return 1.8;
  }

  // Platform-adjusted values (simplified)
  static double getPlatformAdjustedFontSize(BuildContext context, double baseSize) {
    if (isWindows(context) || isMacOS(context)) {
      return baseSize * 0.9; // Slightly smaller on desktop
    }
    return baseSize;
  }

  static double getPlatformAdjustedSpacing(BuildContext context, double baseSpacing) {
    if (isWindows(context) || isMacOS(context)) {
      return baseSpacing * 0.8; // Tighter spacing on desktop
    }
    return baseSpacing;
  }
}
