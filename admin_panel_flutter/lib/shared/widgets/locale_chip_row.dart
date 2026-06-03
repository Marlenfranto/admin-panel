import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Horizontal chip row for locale selection inside a localization panel.
///
/// - Locales with an existing localization row render as a filled chip.
/// - Locales without one render as outlined (so admins know it's a draft slot).
/// - The default locale is marked with a star.
class LocaleChipRow extends StatelessWidget {
  const LocaleChipRow({
    super.key,
    required this.locales,
    required this.selectedLocaleKey,
    required this.existingLocaleKeys,
    required this.defaultLocaleKey,
    required this.onSelected,
  });

  final List<LocaleConfig> locales;
  final String selectedLocaleKey;
  final Set<String> existingLocaleKeys;
  final String defaultLocaleKey;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: locales.map((l) {
        final isSelected = l.localeKey == selectedLocaleKey;
        final hasContent = existingLocaleKeys.contains(l.localeKey);
        final isDefault = l.localeKey == defaultLocaleKey;
        return ChoiceChip(
          selected: isSelected,
          onSelected: (_) => onSelected(l.localeKey),
          showCheckmark: false,
          avatar: isDefault
              ? const Icon(Icons.star_rounded,
                  size: 14, color: AppColors.warning)
              : null,
          label: Text(
            hasContent ? l.localeKey : '+ ${l.localeKey}',
            style: TextStyle(
              fontWeight: hasContent ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : AppColors.onSurface,
            ),
          ),
          selectedColor: AppColors.primary,
          backgroundColor: hasContent
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.surface,
          side: BorderSide(
            color: isSelected
                ? AppColors.primary
                : hasContent
                    ? AppColors.primary.withValues(alpha: 0.4)
                    : AppColors.divider,
          ),
        );
      }).toList(),
    );
  }
}
