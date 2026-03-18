import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

/// Builds the single light [ThemeData] for the application.
/// Uses Material 3 with a fully custom colour scheme — no M3 colour seeding.
abstract final class AppTheme {
  static ThemeData get light {
    const cs = ColorScheme(
      brightness: Brightness.light,
      // ── Brand ─────────────────────────────────────────────────────────────
      primary:            AppColors.primary,
      onPrimary:          Colors.white,
      primaryContainer:   Color(0xFFFFE8E0),
      onPrimaryContainer: Color(0xFFBF3000),
      // ── Secondary ─────────────────────────────────────────────────────────
      secondary:            AppColors.secondary,
      onSecondary:          Colors.white,
      secondaryContainer:   Color(0xFFFFE8E8),
      onSecondaryContainer: Color(0xFFB71C1C),
      // ── Tertiary (info) ───────────────────────────────────────────────────
      tertiary:            AppColors.info,
      onTertiary:          Colors.white,
      tertiaryContainer:   AppColors.infoSurface,
      onTertiaryContainer: Color(0xFF1D4ED8),
      // ── Error ─────────────────────────────────────────────────────────────
      error:            AppColors.error,
      onError:          Colors.white,
      errorContainer:   AppColors.errorSurface,
      onErrorContainer: Color(0xFF991B1B),
      // ── Surfaces ──────────────────────────────────────────────────────────
      surface:                      AppColors.surface,
      onSurface:                    AppColors.onSurface,
      surfaceContainerLowest:       AppColors.background,
      surfaceContainerLow:          AppColors.surface,
      surfaceContainer:             AppColors.surfaceVariant,
      surfaceContainerHigh:         AppColors.surfaceHigh,
      surfaceContainerHighest:      AppColors.surfaceOverlay,
      onSurfaceVariant:             AppColors.onSurfaceMuted,
      // ── Misc ──────────────────────────────────────────────────────────────
      outline:          AppColors.divider,
      outlineVariant:   AppColors.dividerStrong,
      shadow:           Color(0xFF000000),
      scrim:            Color(0x66000000),
      inverseSurface:   Color(0xFF1A1A1F),
      onInverseSurface: Color(0xFFE8E8EE),
      inversePrimary:   AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: AppColors.background,

      // ── AppBar ─────────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.headingSm,
        iconTheme: const IconThemeData(color: AppColors.onSurface, size: 20),
        actionsIconTheme:
            const IconThemeData(color: AppColors.onSurfaceMuted, size: 20),
        shape: const Border(bottom: BorderSide(color: AppColors.divider)),
      ),

      // ── Cards ──────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.divider),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // ── Divider ────────────────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ── Input fields ───────────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle:
            AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceMuted),
        hintStyle:
            AppTextStyles.bodyMd.copyWith(color: AppColors.onSurfaceSubtle),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        isDense: true,
      ),

      // ── FilledButton ───────────────────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTextStyles.labelLg,
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((s) {
            if (s.contains(WidgetState.hovered))
              return Colors.white.withValues(alpha: 0.08);
            if (s.contains(WidgetState.pressed))
              return Colors.white.withValues(alpha: 0.16);
            return null;
          }),
        ),
      ),

      // ── OutlinedButton ─────────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurface,
          side: const BorderSide(color: AppColors.dividerStrong),
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTextStyles.labelLg,
        ).copyWith(
          overlayColor:
              WidgetStateProperty.all(AppColors.overlay06),
        ),
      ),

      // ── TextButton ─────────────────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTextStyles.labelLg,
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
              AppColors.primary.withValues(alpha: 0.08)),
        ),
      ),

      // ── IconButton ─────────────────────────────────────────────────────────
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.onSurfaceMuted,
          hoverColor:      AppColors.overlay06,
          highlightColor:  AppColors.overlay10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),

      // ── Chip ───────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        side: const BorderSide(color: AppColors.divider),
        labelStyle: AppTextStyles.labelMd,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        ),
      ),

      // ── Switch ─────────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return Colors.white;
          return AppColors.onSurfaceSubtle;
        }),
        trackColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.surfaceHigh;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((s) {
          if (s.contains(WidgetState.selected)) return Colors.transparent;
          return AppColors.dividerStrong;
        }),
      ),

      // ── ListTile ───────────────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        tileColor:      Colors.transparent,
        textColor:      AppColors.onSurface,
        iconColor:      AppColors.onSurfaceMuted,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),

      // ── NavigationRail ─────────────────────────────────────────────────────
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.surface,
        unselectedIconTheme:
            const IconThemeData(color: AppColors.onSurfaceMuted, size: 20),
        selectedIconTheme:
            const IconThemeData(color: Colors.white, size: 20),
        unselectedLabelTextStyle: AppTextStyles.navLabel
            .copyWith(color: AppColors.onSurfaceMuted),
        selectedLabelTextStyle:
            AppTextStyles.navLabel.copyWith(color: AppColors.onSurface),
        indicatorColor:   Colors.transparent,
        elevation:        0,
        useIndicator:     false,
        groupAlignment:   -1.0,
        minWidth:         AppSpacing.sidebarCollapsedWidth,
        minExtendedWidth: AppSpacing.sidebarWidth,
      ),

      // ── TabBar ─────────────────────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelColor:           AppColors.primary,
        unselectedLabelColor: AppColors.onSurfaceMuted,
        indicatorColor:       AppColors.primary,
        dividerColor:         AppColors.divider,
        labelStyle:           AppTextStyles.labelLg,
        unselectedLabelStyle: AppTextStyles.labelLg,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        tabAlignment: TabAlignment.start,
      ),

      // ── Dialog ─────────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor:  AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.divider),
        ),
        titleTextStyle:   AppTextStyles.headingMd,
        contentTextStyle: AppTextStyles.bodyMd,
      ),

      // ── SnackBar ───────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.onSurface,
        contentTextStyle:
            AppTextStyles.bodyMd.copyWith(color: AppColors.surface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        behavior:  SnackBarBehavior.floating,
        elevation: 4,
      ),

      // ── PopupMenu ──────────────────────────────────────────────────────────
      popupMenuTheme: PopupMenuThemeData(
        color:            AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.divider),
        ),
        textStyle: AppTextStyles.bodyMd,
      ),

      // ── Tooltip ────────────────────────────────────────────────────────────
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.onSurface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        textStyle:
            AppTextStyles.labelMd.copyWith(color: AppColors.surface),
        waitDuration: const Duration(milliseconds: 600),
      ),

      // ── ProgressIndicator ──────────────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color:            AppColors.primary,
        linearTrackColor: AppColors.surfaceVariant,
      ),

      // ── Dropdown ───────────────────────────────────────────────────────────
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            borderSide:
                const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          isDense: true,
        ),
        menuStyle: MenuStyle(
          backgroundColor:
              WidgetStateProperty.all(AppColors.surface),
          surfaceTintColor:
              WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(8),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              side: const BorderSide(color: AppColors.divider),
            ),
          ),
        ),
      ),

      // ── TextTheme ──────────────────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge:   AppTextStyles.displayLg,
        displayMedium:  AppTextStyles.displayMd,
        headlineLarge:  AppTextStyles.headingXl,
        headlineMedium: AppTextStyles.headingLg,
        headlineSmall:  AppTextStyles.headingMd,
        titleLarge:     AppTextStyles.headingMd,
        titleMedium:    AppTextStyles.headingSm,
        titleSmall:     AppTextStyles.headingXs,
        bodyLarge:      AppTextStyles.bodyLg,
        bodyMedium:     AppTextStyles.bodyMd,
        bodySmall:      AppTextStyles.bodySm,
        labelLarge:     AppTextStyles.labelLg,
        labelMedium:    AppTextStyles.labelMd,
        labelSmall:     AppTextStyles.labelSm,
      ),
    );
  }
}
