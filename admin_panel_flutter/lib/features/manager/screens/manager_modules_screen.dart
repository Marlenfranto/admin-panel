import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';
import '../../../src/providers.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

class ManagerModulesScreen extends ConsumerWidget {
  const ManagerModulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync   = ref.watch(managedOrganizationsProvider);
    final activeOrgId = ref.watch(activeOrgIdProvider);
    final configAsync = ref.watch(managerModuleConfigProvider);
    final teamsAsync  = ref.watch(activeOrgTeamsProvider);

    final config = configAsync.value;
    final globalEnabled = {
      'theory':        config?.theoryModule        ?? false,
      'aiExpert':      config?.aiExpertModule      ?? false,
      'smartTraining': config?.smartTrainingModule ?? false,
      'assessment':    config?.assessmentModule    ?? false,
    };

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsivePagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Text('Modules', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Configure per-user module access for your organization.',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Org selector strip (multi-org managers) ──────────────────────
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
                            org:      org,
                            isActive: isActive,
                            onTap: () => ref
                                .read(selectedOrgIdProvider.notifier)
                                .state = org.id,
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
            error:   (_, __) => const SizedBox.shrink(),
          ),

          // ── Per-user module configuration ──────────────────────────────
          if (activeOrgId != null)
            Builder(builder: (_) {
              // Collect users from the active org + all its teams,
              // and build a teamLabels map for display.
              final activeOrg  = ref.watch(activeOrgProvider);
              final teamLabels = <int, String>{};
              final seen       = <int>{};
              final allUsers   = <AppUser>[];

              for (final link in (activeOrg?.users ?? [])) {
                final u = link.appUser;
                if (u?.id != null && u!.role == Role.User && seen.add(u.id!)) {
                  allUsers.add(u);
                }
              }
              for (final team in (teamsAsync.value ?? [])) {
                for (final link in (team.users ?? [])) {
                  final u = link.appUser;
                  if (u?.id != null && u!.role == Role.User && seen.add(u.id!)) {
                    allUsers.add(u);
                    teamLabels[u.id!] = team.name;
                  }
                }
              }

              return UserModuleConfigPanel(
              orgUsers:   allUsers,
              teamLabels: teamLabels.isNotEmpty ? teamLabels : null,
              globalEnabled: globalEnabled,
              onLoadProgress: (userId) => ref
                  .read(clientProvider)
                  .manager
                  .getUserModuleProgress(userId, activeOrgId),
              onSaveProgress: (userId, states) async {
                for (final s in states) {
                  await ref
                      .read(clientProvider)
                      .manager
                      .setUserModuleProgress(
                        userId,
                        activeOrgId,
                        s.moduleId,
                        s.isEnabled,
                        s.deadline,
                      );
                  await ref
                      .read(clientProvider)
                      .manager
                      .updateUserModuleStatus(
                        userId,
                        activeOrgId,
                        s.moduleId,
                        s.status,
                        s.startedAt,
                        s.completedAt,
                      );
                }
              },
            ); // UserModuleConfigPanel
            }), // Builder
        ],
      ),
    );
  }
}

// ── Org chip (multi-org selector) ─────────────────────────────────────────────

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
          color:        isActive ? null : AppColors.surfaceVariant,
          gradient:     isActive ? AppColors.brandGradient : null,
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
                    color:      isActive ? Colors.white : AppColors.primary,
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

