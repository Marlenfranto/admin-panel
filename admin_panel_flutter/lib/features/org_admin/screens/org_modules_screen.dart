import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/org_admin_providers.dart';
import '../../../src/providers.dart';

// ── Module metadata ───────────────────────────────────────────────────────────

class _ModuleMeta {
  const _ModuleMeta({
    required this.icon,
    required this.color,
    required this.label,
    required this.description,
  });
  final IconData icon;
  final Color    color;
  final String   label;
  final String   description;
}

const _modules = [
  _ModuleMeta(
    icon:        Icons.menu_book_rounded,
    color:       AppColors.theory,
    label:       'Theory',
    description: 'Learning content, chapters and study materials',
  ),
  _ModuleMeta(
    icon:        Icons.smart_toy_rounded,
    color:       AppColors.aiExpert,
    label:       'AR Expert',
    description: 'AI-powered expert assistance and chat sessions',
  ),
  _ModuleMeta(
    icon:        Icons.fitness_center_rounded,
    color:       AppColors.training,
    label:       'Smart Training',
    description: 'Adaptive training sessions and performance tracking',
  ),
  _ModuleMeta(
    icon:        Icons.quiz_rounded,
    color:       AppColors.assess,
    label:       'Assessment',
    description: 'Quizzes, tests and scoring parameters',
  ),
];

// ── Screen ────────────────────────────────────────────────────────────────────

class OrgModulesScreen extends ConsumerWidget {
  const OrgModulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(orgModuleConfigProvider);
    final myOrgAsync  = ref.watch(myOrganizationProvider);
    final usersAsync  = ref.watch(orgUsersProvider);
    final teamsAsync  = ref.watch(orgTeamsProvider);

    // Build userId → teamName map for the user list
    final teamLabels = <int, String>{};
    for (final team in teamsAsync.value ?? []) {
      for (final link in team.users ?? []) {
        if (link.appUser?.id != null) {
          teamLabels[link.appUser!.id!] = team.name;
        }
      }
    }

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
          // ── Header ─────────────────────────────────────────────────
          myOrgAsync.when(
            data: (org) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Modules', style: AppTextStyles.headingLg),
                const SizedBox(height: 4),
                Text(
                  org != null
                      ? 'Configure per-user module access for ${org.name}.'
                      : 'Configure per-user module access.',
                  style: AppTextStyles.bodySm,
                ),
              ],
            ),
            loading: () => const AppSkeletonBox(width: 280, height: 40),
            error:   (_, __) =>
                Text('Modules', style: AppTextStyles.headingLg),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Per-user module config ──────────────────────────────────
          if (usersAsync.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            UserModuleConfigPanel(
              orgUsers: (usersAsync.value ?? [])
                  .where((u) => u.role == Role.User)
                  .toList(),
              globalEnabled: globalEnabled,
              teamLabels: teamLabels,
              onLoadProgress: (userId) => ref
                  .read(clientProvider)
                  .organizationAdmin
                  .getOrgUserModuleProgress(userId),
              onSaveProgress: (userId, states) async {
                for (final s in states) {
                  await ref
                      .read(clientProvider)
                      .organizationAdmin
                      .setOrgUserModuleProgress(
                          userId, s.moduleId, s.isEnabled, s.deadline);
                  await ref
                      .read(clientProvider)
                      .organizationAdmin
                      .updateOrgUserModuleStatus(
                          userId, s.moduleId, s.status,
                          s.startedAt, s.completedAt);
                }
              },
            ),
        ],
      ),
    );
  }
}

// ── Section card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

// ── Card header ───────────────────────────────────────────────────────────────

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final Color    color;
  final String   title;
  final String   subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width:  38,
          height: 38,
          decoration: BoxDecoration(
            color:        color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,    style: AppTextStyles.headingSm),
              Text(subtitle, style: AppTextStyles.bodyXs),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Module toggle row ─────────────────────────────────────────────────────────

class _ModuleRow extends StatefulWidget {
  const _ModuleRow({required this.meta, required this.value, required this.onChange});
  final _ModuleMeta        meta;
  final bool               value;
  final ValueChanged<bool> onChange;

  @override
  State<_ModuleRow> createState() => _ModuleRowState();
}

class _ModuleRowState extends State<_ModuleRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color   = widget.meta.color;
    final enabled = widget.value;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => widget.onChange(!enabled),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 14),
          decoration: BoxDecoration(
            color:        _hovered ? AppColors.surfaceVariant : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width:  40,
                height: 40,
                decoration: BoxDecoration(
                  color:        enabled ? color.withValues(alpha: 0.15) : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(widget.meta.icon, size: 18, color: enabled ? color : AppColors.onSurfaceSubtle),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.meta.label,       style: AppTextStyles.labelLg.copyWith(color: enabled ? AppColors.onSurface : AppColors.onSurfaceMuted)),
                    const SizedBox(height: 2),
                    Text(widget.meta.description, style: AppTextStyles.bodyXs),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              AppStatusChip(
                label:   enabled ? 'Enabled' : 'Disabled',
                variant: enabled ? AppChipVariant.success : AppChipVariant.neutral,
                small:   true,
              ),
              const SizedBox(width: AppSpacing.sm),
              Switch(
                value:            enabled,
                onChanged:        widget.onChange,
                activeThumbColor: color,
                activeTrackColor: color.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Remove button ─────────────────────────────────────────────────────────────

class _RemoveButton extends StatefulWidget {
  const _RemoveButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_RemoveButton> createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<_RemoveButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Remove',
      child: MouseRegion(
        cursor:  SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width:  32,
            height: 32,
            decoration: BoxDecoration(
              color:        _hovered ? AppColors.error.withValues(alpha: 0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              size:  16,
              color: _hovered ? AppColors.error : AppColors.onSurfaceSubtle,
            ),
          ),
        ),
      ),
    );
  }
}
