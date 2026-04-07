import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';

class ManagerOverviewScreen extends ConsumerWidget {
  const ManagerOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync    = ref.watch(managedOrganizationsProvider);
    final activeOrgId  = ref.watch(activeOrgIdProvider);
    final activeOrg    = ref.watch(activeOrgProvider);
    final configAsync  = ref.watch(managerModuleConfigProvider);
    final assetsAsync  = ref.watch(managerAssetsProvider);

    final config = configAsync.value;
    final assets = assetsAsync.value ?? [];

    final userCount   = activeOrg?.users?.length ?? 0;
    final assetCount  = assets.length;
    final moduleCount = config == null ? 0 : [
      config.theoryModule,
      config.aiExpertModule,
      config.smartTrainingModule,
      config.assessmentModule,
    ].where((e) => e).length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsivePagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Text('Overview', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Manage your organizations',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Org selector strip ─────────────────────────────────────────
          orgsAsync.when(
            data: (orgs) {
              if (orgs.length <= 1) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organizations', style: AppTextStyles.labelMd),
                  const SizedBox(height: AppSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: orgs.map((org) {
                        final isActive = org.id == activeOrgId;
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: _OrgChip(
                            org: org,
                            isActive: isActive,
                            onTap: () {
                              ref.read(selectedOrgIdProvider.notifier).state = org.id;
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // ── Stat cards ─────────────────────────────────────────────────
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _StatCard(
                icon:        Icons.group_rounded,
                accentColor: AppColors.primary,
                value:       '$userCount',
                label:       'Team Members',
                isLoading:   orgsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.extension_rounded,
                accentColor: AppColors.aiExpert,
                value:       '$moduleCount',
                label:       'Active Modules',
                isLoading:   configAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.perm_media_rounded,
                accentColor: AppColors.training,
                value:       '$assetCount',
                label:       'Assets',
                isLoading:   assetsAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Module status card ─────────────────────────────────────────
          if (config != null) _ModuleStatusCard(config: config),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Org chip for selector strip
// ─────────────────────────────────────────────────────────────────────────────

class _OrgChip extends StatelessWidget {
  const _OrgChip({
    required this.org,
    required this.isActive,
    required this.onTap,
  });

  final Organization org;
  final bool         isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initial = (org.name.isNotEmpty ? org.name[0] : '?').toUpperCase();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isActive ? null : AppColors.surfaceVariant,
          gradient: isActive ? AppColors.brandGradient : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.0)
                : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width:  28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withValues(alpha: 0.25)
                    : AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: AppTextStyles.labelMd.copyWith(
                    color: isActive ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              org.name,
              style: AppTextStyles.labelMd.copyWith(
                color: isActive ? Colors.white : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat card (compact, no boxShadow)
// ─────────────────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.accentColor,
    required this.value,
    required this.label,
    required this.isLoading,
  });

  final IconData icon;
  final Color    accentColor;
  final String   value;
  final String   label;
  final bool     isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppSkeletonBox(
          width: 200, height: 72, radius: AppSpacing.radiusLg);
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width:  40,
            height: 40,
            decoration: BoxDecoration(
              color:        accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(icon, size: 18, color: accentColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.headingMd),
              Text(label, style: AppTextStyles.bodyXs),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Module status card
// ─────────────────────────────────────────────────────────────────────────────

class _ModuleStatusCard extends StatelessWidget {
  const _ModuleStatusCard({required this.config});
  final dynamic config; // ModuleConfig

  @override
  Widget build(BuildContext context) {
    final modules = [
      (Icons.menu_book_rounded,      AppColors.theory,    'Theory',     config.theoryModule as bool),
      (Icons.smart_toy_rounded,      AppColors.aiExpert,  'AR Expert',  config.aiExpertModule as bool),
      (Icons.fitness_center_rounded, AppColors.training,  'Training',   config.smartTrainingModule as bool),
      (Icons.quiz_rounded,           AppColors.assess,    'Assessment', config.assessmentModule as bool),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Module Status', style: AppTextStyles.headingSm),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: modules.map((m) {
              final (icon, color, label, enabled) = m;
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: 10),
                decoration: BoxDecoration(
                  color: enabled
                      ? color.withValues(alpha: 0.1)
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(
                    color: enabled
                        ? color.withValues(alpha: 0.3)
                        : AppColors.divider,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16,
                        color: enabled ? color : AppColors.onSurfaceSubtle),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: AppTextStyles.labelMd.copyWith(
                        color: enabled ? color : AppColors.onSurfaceSubtle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      enabled
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      size:  14,
                      color: enabled ? AppColors.success : AppColors.onSurfaceSubtle,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
