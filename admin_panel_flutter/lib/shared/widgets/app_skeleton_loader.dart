import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Primitive skeleton box — use this to compose any skeleton layout.
// ─────────────────────────────────────────────────────────────────────────────

/// A single shimmer rectangle/pill used as a building block for skeleton UIs.
class AppSkeletonBox extends StatelessWidget {
  const AppSkeletonBox({
    super.key,
    this.width,
    this.height = 16,
    this.radius,
  });

  final double? width;
  final double  height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:      AppColors.surfaceHigh,
      highlightColor: AppColors.surface,
      child: Container(
        width:  width,
        height: height,
        decoration: BoxDecoration(
          color:        AppColors.surfaceHigh,
          borderRadius: BorderRadius.circular(
            radius ?? AppSpacing.radiusSm,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pre-composed skeleton variants
// ─────────────────────────────────────────────────────────────────────────────

/// Skeleton that mimics a full KPI card row (n cards side-by-side).
class AppKpiRowSkeleton extends StatelessWidget {
  const AppKpiRowSkeleton({super.key, this.count = 4});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: List.generate(
        count,
        (_) => SizedBox(
          width: AppSpacing.kpiCardMinWidth,
          child: _SingleKpiSkeleton(),
        ),
      ),
    );
  }
}

class _SingleKpiSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              AppSkeletonBox(width: 56, height: 20, radius: AppSpacing.radiusChip),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppSkeletonBox(width: 68, height: 32),
          const SizedBox(height: 6),
          const AppSkeletonBox(width: 110, height: 13),
        ],
      ),
    );
  }
}

/// Skeleton that mimics a list of table rows.
class AppTableSkeleton extends StatelessWidget {
  const AppTableSkeleton({super.key, this.rows = 6});
  final int rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (i) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical:   14,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.divider),
            ),
          ),
          child: Row(
            children: [
              AppSkeletonBox(
                width:  32,
                height: 32,
                radius: AppSpacing.radiusChip,
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: AppSkeletonBox(
                  height: 14,
                  radius: AppSpacing.radiusSm,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: AppSkeletonBox(
                  height: 14,
                  radius: AppSpacing.radiusSm,
                ),
              ),
              const SizedBox(width: 16),
              AppSkeletonBox(
                width:  64,
                height: 22,
                radius: AppSpacing.radiusChip,
              ),
            ],
          ),
        );
      }),
    );
  }
}

/// Generic card-body skeleton with a few lines of text.
class AppCardSkeleton extends StatelessWidget {
  const AppCardSkeleton({super.key, this.lines = 3});
  final int lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:     const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < lines; i++) ...[
            AppSkeletonBox(
              width:  i == 0 ? 140 : double.infinity,
              height: i == 0 ? 18  : 14,
            ),
            if (i < lines - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
