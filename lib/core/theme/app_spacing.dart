/// Design system spacing constants (8px base unit)
class AppSpacing {
  // Base unit
  static const double base = 8.0;

  // Spacing scale
  static const double xs = base * 0.5; // 4px
  static const double sm = base; // 8px
  static const double md = base * 2; // 16px
  static const double lg = base * 3; // 24px
  static const double xl = base * 4; // 32px
  static const double xxl = base * 6; // 48px
  static const double xxxl = base * 8; // 64px

  // Specific use cases
  static const double cardPadding = md;
  static const double pagePadding = md;
  static const double sectionSpacing = lg;
  static const double itemSpacing = sm;
  static const double fabMargin = md;

  // Border radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Elevation
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;
}
