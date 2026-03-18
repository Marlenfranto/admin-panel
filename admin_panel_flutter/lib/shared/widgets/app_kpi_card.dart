import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import 'app_skeleton_loader.dart';

/// A KPI / stat card used in dashboard overview rows.
///
/// Shows an icon in a gradient circle, a large metric value, a label,
/// and an optional delta trend chip.
///
/// ```dart
/// AppKpiCard(
///   icon:    Icons.business_rounded,
///   value:   '24',
///   label:   'Total Organisations',
///   delta:   '+3 this month',
///   positive: true,
/// )
/// ```
class AppKpiCard extends StatefulWidget {
  const AppKpiCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.delta,
    this.positive,
    this.isLoading = false,
    this.accentColor,
  });

  final IconData icon;
  final String   value;
  final String   label;

  /// Short delta text, e.g. "+3 this month". Omit to hide the chip.
  final String? delta;

  /// `true` = green arrow-up, `false` = red arrow-down, `null` = neutral grey.
  final bool? positive;

  final bool   isLoading;

  /// Override the icon circle gradient — defaults to the brand gradient.
  final Color? accentColor;

  @override
  State<AppKpiCard> createState() => _AppKpiCardState();
}

class _AppKpiCardState extends State<AppKpiCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) return const _KpiSkeleton();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(minWidth: AppSpacing.kpiCardMinWidth),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: _hovered
                ? AppColors.dividerStrong
                : AppColors.divider,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _IconCircle(
                  icon:        widget.icon,
                  accentColor: widget.accentColor,
                ),
                if (widget.delta != null) ...[
                  const Spacer(),
                  _DeltaChip(
                    text:     widget.delta!,
                    positive: widget.positive,
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(widget.value, style: AppTextStyles.kpiValue),
            const SizedBox(height: 4),
            Text(widget.label, style: AppTextStyles.bodySm),
          ],
        ),
      ),
    );
  }
}

// ─── Sub-widgets ─────────────────────────────────────────────────────────────

class _IconCircle extends StatelessWidget {
  const _IconCircle({required this.icon, this.accentColor});
  final IconData icon;
  final Color?   accentColor;

  @override
  Widget build(BuildContext context) {
    final gradient = accentColor != null
        ? LinearGradient(
            colors: [
              accentColor!,
              accentColor!.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end:   Alignment.bottomRight,
          )
        : AppColors.brandGradientDiagonal;

    return Container(
      width:  44,
      height: 44,
      decoration: BoxDecoration(
        gradient:    gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:      (accentColor ?? AppColors.primary).withValues(alpha: 0.3),
            blurRadius: 8,
            offset:     const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  const _DeltaChip({required this.text, this.positive});
  final String text;
  final bool?  positive;

  @override
  Widget build(BuildContext context) {
    final Color fg;
    final Color bg;
    final IconData arrowIcon;

    if (positive == null) {
      fg = AppColors.onSurfaceMuted;
      bg = AppColors.surfaceVariant;
      arrowIcon = Icons.remove_rounded;
    } else if (positive!) {
      fg = AppColors.success;
      bg = AppColors.successSurface;
      arrowIcon = Icons.arrow_upward_rounded;
    } else {
      fg = AppColors.error;
      bg = AppColors.errorSurface;
      arrowIcon = Icons.arrow_downward_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:        bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border:       Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(arrowIcon, size: 11, color: fg),
          const SizedBox(width: 3),
          Text(
            text,
            style: AppTextStyles.labelSm.copyWith(color: fg),
          ),
        ],
      ),
    );
  }
}

/// Shimmer skeleton shown while [AppKpiCard.isLoading] is true.
class _KpiSkeleton extends StatelessWidget {
  const _KpiSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: AppSpacing.kpiCardMinWidth),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              AppSkeletonBox(width: 44, height: 44, radius: 12),
              const Spacer(),
              AppSkeletonBox(width: 60, height: 20, radius: AppSpacing.radiusChip),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppSkeletonBox(width: 72, height: 34),
          const SizedBox(height: 6),
          const AppSkeletonBox(width: 120, height: 14),
        ],
      ),
    );
  }
}

