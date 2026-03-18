/// 8-point spacing grid and layout constants.
abstract final class AppSpacing {
  // ── Base scale ─────────────────────────────────────────────────────────────
  static const double xs   =  4;
  static const double sm   =  8;
  static const double md   = 16;
  static const double lg   = 24;
  static const double xl   = 32;
  static const double xxl  = 48;
  static const double xxxl = 64;

  // ── Component padding ──────────────────────────────────────────────────────
  static const double cardPadding   = 20;
  static const double cardPaddingLg = 28;
  static const double pagePadding   = 24;
  static const double pagePaddingLg = 32;

  // ── Border radii ───────────────────────────────────────────────────────────
  static const double radiusXs   =  4;
  static const double radiusSm   =  6;
  static const double radiusMd   =  8;
  static const double radiusLg   = 12;
  static const double radiusXl   = 16;
  static const double radiusXxl  = 24;
  static const double radiusChip = 20;
  static const double radiusFull = 999;

  // ── Layout constants ───────────────────────────────────────────────────────
  static const double sidebarWidth          = 240;
  static const double sidebarCollapsedWidth =  72;
  static const double sideSheetWidth        = 420;
  static const double topBarHeight          =  64;

  // ── Responsive breakpoints ─────────────────────────────────────────────────
  static const double breakpointMobile  =  600;
  static const double breakpointTablet  = 1024;
  static const double breakpointWide    = 1280;
  static const double breakpointDesktop = 1440;

  // ── KPI grid column widths ─────────────────────────────────────────────────
  static const double kpiCardMinWidth = 220;
}
