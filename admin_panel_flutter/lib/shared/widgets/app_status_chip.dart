import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

enum AppChipVariant { success, warning, error, info, neutral, primary }

/// A compact coloured status indicator chip.
///
/// ```dart
/// AppStatusChip(label: 'Active',   variant: AppChipVariant.success)
/// AppStatusChip(label: 'Disabled', variant: AppChipVariant.neutral)
/// AppStatusChip.fromBool(value: config.theoryModule, trueLabel: 'Enabled')
/// ```
class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.label,
    this.variant = AppChipVariant.neutral,
    this.dot = true,
    this.small = false,
    this.icon,
  });

  /// Convenience constructor: green when [value] is true, neutral when false.
  factory AppStatusChip.fromBool({
    Key? key,
    required bool value,
    String trueLabel  = 'Enabled',
    String falseLabel = 'Disabled',
    bool dot = true,
  }) {
    return AppStatusChip(
      key: key,
      label:   value ? trueLabel  : falseLabel,
      variant: value ? AppChipVariant.success : AppChipVariant.neutral,
      dot: dot,
    );
  }

  final String         label;
  final AppChipVariant variant;
  final bool           dot;
  final bool           small;
  final IconData?      icon;

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = _colors();
    final vPad = small ? 2.0 : 4.0;
    final hPad = small ? 8.0 : 10.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: small ? 11 : 12, color: fg),
            SizedBox(width: small ? 3 : 4),
          ] else if (dot) ...[
            Container(
              width:  small ? 5 : 6,
              height: small ? 5 : 6,
              decoration: BoxDecoration(
                color:  fg,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: small ? 3 : 5),
          ],
          Text(
            label,
            style: (small ? AppTextStyles.labelSm : AppTextStyles.labelMd)
                .copyWith(color: fg),
          ),
        ],
      ),
    );
  }

  (Color fg, Color bg) _colors() => switch (variant) {
    AppChipVariant.success => (AppColors.success, AppColors.successSurface),
    AppChipVariant.warning => (AppColors.warning, AppColors.warningSurface),
    AppChipVariant.error   => (AppColors.error,   AppColors.errorSurface),
    AppChipVariant.info    => (AppColors.info,     AppColors.infoSurface),
    AppChipVariant.primary => (
        AppColors.primary,
        AppColors.primary.withValues(alpha: 0.12),
      ),
    AppChipVariant.neutral => (
        AppColors.onSurfaceMuted,
        AppColors.surfaceVariant,
      ),
  };
}
