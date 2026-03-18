import 'package:flutter/material.dart';

/// Centralised colour tokens for the entire application.
/// All colours follow the 8-point grid light-mode palette.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────
  static const primary   = Color(0xFFFF5722); // deep orange
  static const secondary = Color(0xFFE53935); // red

  // ── Gradients ──────────────────────────────────────────────────────────────
  static const brandGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const brandGradientDiagonal = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const brandGradientVertical = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ── Surfaces ───────────────────────────────────────────────────────────────
  static const background     = Color(0xFFF6F6FA); // off-white lavender tint
  static const surface        = Color(0xFFFFFFFF); // pure white
  static const surfaceVariant = Color(0xFFF0F0F6); // light grey (hover, headers)
  static const surfaceHigh    = Color(0xFFE8E8F2); // medium grey (shimmer)
  static const surfaceOverlay = Color(0xFFDDDDE8); // darker overlay

  // ── Text ───────────────────────────────────────────────────────────────────
  static const onSurface       = Color(0xFF111118); // near-black
  static const onSurfaceMuted  = Color(0xFF6B6B7E); // medium grey
  static const onSurfaceSubtle = Color(0xFF9898A8); // light grey

  // ── Borders ────────────────────────────────────────────────────────────────
  static const divider       = Color(0xFFE2E2EC);
  static const dividerStrong = Color(0xFFCACAD8);

  // ── Semantic ───────────────────────────────────────────────────────────────
  static const success = Color(0xFF16A34A); // slightly deeper green for light bg
  static const warning = Color(0xFFD97706); // amber — darker for contrast
  static const error   = Color(0xFFDC2626); // red — darker for contrast
  static const info    = Color(0xFF2563EB); // blue — darker for contrast

  // Surface tints for semantic colours (light pastels)
  static const successSurface = Color(0xFFF0FDF4);
  static const warningSurface = Color(0xFFFFFBEB);
  static const errorSurface   = Color(0xFFFEF2F2);
  static const infoSurface    = Color(0xFFEFF6FF);

  // ── Dark overlays (for hover / pressed states on light surfaces) ──────────
  static const overlay06 = Color(0x0F000000); //  6% black
  static const overlay10 = Color(0x1A000000); // 10% black
  static const overlay16 = Color(0x29000000); // 16% black

  // ── Module accent colours ─────────────────────────────────────────────────
  static const theory   = Color(0xFF2563EB); // blue
  static const aiExpert = Color(0xFF7C3AED); // violet
  static const training = Color(0xFFD97706); // amber
  static const assess   = Color(0xFF16A34A); // green
}
