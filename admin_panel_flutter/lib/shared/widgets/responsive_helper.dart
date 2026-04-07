import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Breakpoint enum
// ─────────────────────────────────────────────────────────────────────────────

/// Screen-size categories used for responsive layout decisions.
enum ScreenType { mobile, tablet, desktop }

// ─────────────────────────────────────────────────────────────────────────────
// Responsive BuildContext extension
// ─────────────────────────────────────────────────────────────────────────────

/// Convenience helpers for responsive layout decisions.
///
/// Usage:
/// ```dart
/// final isMobile = context.isMobile;
/// final padding  = context.responsivePadding;
/// final cols     = context.responsiveColumns(minWidth: 300);
/// ```
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  // ── Breakpoint queries ──────────────────────────────────────────────────

  ScreenType get screenType {
    final w = screenWidth;
    if (w < AppSpacing.breakpointMobile) return ScreenType.mobile;
    if (w < AppSpacing.breakpointTablet) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  bool get isMobile  => screenWidth < AppSpacing.breakpointMobile;
  bool get isTablet  =>
      screenWidth >= AppSpacing.breakpointMobile &&
      screenWidth < AppSpacing.breakpointTablet;
  bool get isDesktop => screenWidth >= AppSpacing.breakpointTablet;

  /// True for anything below the tablet breakpoint (< 1024).
  bool get isCompact => screenWidth < AppSpacing.breakpointTablet;

  // ── Responsive values ───────────────────────────────────────────────────

  /// Page-level padding that shrinks on mobile.
  double get responsivePagePadding =>
      isMobile ? AppSpacing.md : AppSpacing.pagePadding;

  /// Horizontal body padding that adapts to screen width.
  EdgeInsets get responsiveBodyPadding => EdgeInsets.all(responsivePagePadding);

  /// How many grid columns fit at the current width, given a minimum card width.
  int responsiveColumns({double minWidth = AppSpacing.kpiCardMinWidth}) {
    final available = screenWidth - (responsivePagePadding * 2);
    return (available / minWidth).floor().clamp(1, 4);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Responsive layout widgets
// ─────────────────────────────────────────────────────────────────────────────

/// Chooses between [mobile], [tablet], and [desktop] child widgets based on
/// the current screen width. Falls back to [tablet] → [mobile] when omitted.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    final type = context.screenType;
    return switch (type) {
      ScreenType.desktop => desktop ?? tablet ?? mobile,
      ScreenType.tablet  => tablet ?? mobile,
      ScreenType.mobile  => mobile,
    };
  }
}

/// A responsive page header that shows title/subtitle and an action button.
///
/// On **mobile** the inline action is hidden when the screen uses a
/// [ScreenWithFab] wrapper (the FAB replaces it).
/// On **tablet / desktop** the action is shown inline to the right.
class ResponsivePageHeader extends StatelessWidget {
  const ResponsivePageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String  title;
  final String  subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final titleColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headingLg),
        const SizedBox(height: 4),
        Text(subtitle, style: AppTextStyles.bodySm),
      ],
    );

    // On mobile the FAB handles the action — hide the inline button.
    if (action == null || isMobile) return titleColumn;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: titleColumn),
        const SizedBox(width: AppSpacing.md),
        action!,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile FAB wrapper — self-contained, no cross-widget state
// ─────────────────────────────────────────────────────────────────────────────

/// Extra bottom space so scroll content clears the FAB.
const kFabClearance = 80.0;

/// Wraps a scrollable screen body and overlays a branded FAB on mobile.
///
/// On desktop / tablet the [child] is rendered as-is (no FAB).
/// On mobile:
///   * The child is given extra bottom padding so the last item isn't
///     hidden behind the FAB.
///   * A gradient FAB is positioned at the bottom-right corner.
///
/// This widget is entirely self-contained — no InheritedWidgets, no
/// ChangeNotifiers, no callbacks across the tree.
///
/// ```dart
/// ScreenWithFab(
///   icon:      Icons.add_rounded,
///   label:     'Add',
///   onPressed: () => _showSheet(context),
///   child:     SingleChildScrollView( ... ),
/// )
/// ```
class ScreenWithFab extends StatelessWidget {
  const ScreenWithFab({
    super.key,
    required this.child,
    required this.onPressed,
    this.icon  = Icons.add_rounded,
    this.label,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final IconData icon;

  /// If non-null an extended pill-shaped FAB is shown; otherwise a circle FAB.
  final String? label;

  @override
  Widget build(BuildContext context) {
    if (!context.isMobile || onPressed == null) return child;

    return Stack(
      children: [
        // Add bottom padding so scroll content clears the FAB area.
        Padding(
          padding: const EdgeInsets.only(bottom: kFabClearance),
          child: child,
        ),

        // Branded gradient FAB
        Positioned(
          right:  AppSpacing.md,
          bottom: AppSpacing.md,
          child: label != null
              ? _buildExtendedFab(context)
              : _buildCircleFab(context),
        ),
      ],
    );
  }

  Widget _buildExtendedFab(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: AppColors.primary.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: AppColors.brandGradientDiagonal,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  label!,
                  style: AppTextStyles.labelMd.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleFab(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      elevation: 6,
      shadowColor: AppColors.primary.withValues(alpha: 0.4),
      color: Colors.transparent,
      child: Ink(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          gradient: AppColors.brandGradientDiagonal,
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile data card shell
// ─────────────────────────────────────────────────────────────────────────────

/// Consistent card container used by [AppDataTable.mobileCardBuilder]
/// implementations. Provides the standard border, radius and padding so
/// every mobile-card replacement looks uniform across the app.
class MobileDataCard extends StatelessWidget {
  const MobileDataCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border:       Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

/// Trailing action row used inside [MobileDataCard]s — shows edit and delete
/// icon-buttons in a compact row aligned to the trailing edge.
class MobileCardActions extends StatelessWidget {
  const MobileCardActions({
    super.key,
    this.onEdit,
    this.onDelete,
    this.extraActions,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final List<Widget>? extraActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (extraActions != null) ...extraActions!,
        if (onEdit != null)
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 16),
            tooltip: 'Edit',
            color: AppColors.onSurfaceMuted,
            onPressed: onEdit,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        if (onDelete != null)
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, size: 16),
            tooltip: 'Delete',
            color: AppColors.error,
            onPressed: onDelete,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}
