import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralised typography scale.
/// Uses system sans-serif as the base; swap [_font] for a Google Font
/// once the package is added.
abstract final class AppTextStyles {
  // ── Display ────────────────────────────────────────────────────────────────
  static const displayLg = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -1.0,
    height: 1.1,
  );

  static const displayMd = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // ── Headings ───────────────────────────────────────────────────────────────
  static const headingXl = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const headingLg = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static const headingMd = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.35,
  );

  static const headingSm = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
  );

  static const headingXs = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    height: 1.4,
  );

  // ── Body ───────────────────────────────────────────────────────────────────
  static const bodyLg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.6,
  );

  static const bodyMd = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.55,
  );

  static const bodySm = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceMuted,
    height: 1.5,
  );

  static const bodyXs = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceMuted,
    height: 1.5,
  );

  // ── Labels ─────────────────────────────────────────────────────────────────
  static const labelLg = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurface,
    letterSpacing: 0.2,
    height: 1.4,
  );

  static const labelMd = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceMuted,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const labelSm = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceMuted,
    letterSpacing: 0.4,
    height: 1.4,
  );

  // ── Special ────────────────────────────────────────────────────────────────
  static const kpiValue = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.onSurface,
    letterSpacing: -0.5,
    height: 1.1,
  );

  static const navLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceMuted,
    letterSpacing: 0.1,
    height: 1.3,
  );

  static const codeStyle = TextStyle(
    fontSize: 13,
    fontFamily: 'monospace',
    color: AppColors.onSurface,
    height: 1.6,
  );
}
