import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../providers/user_providers.dart';

class UserModulesScreen extends ConsumerWidget {
  const UserModulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync = ref.watch(userModuleConfigProvider);

    return configAsync.when(
      data: (config) => _ModulesContent(config: config),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text('Error: $e',
            style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
      ),
    );
  }
}

class _ModulesContent extends StatelessWidget {
  const _ModulesContent({required this.config});
  final ModuleConfig? config;

  static const _modules = [
    _ModuleInfo(
      icon:    Icons.menu_book_rounded,
      color:   AppColors.theory,
      label:   'Theory',
      desc:    'Learn concepts, procedures and safety standards through structured lessons.',
      key:     'theory',
    ),
    _ModuleInfo(
      icon:    Icons.smart_toy_rounded,
      color:   AppColors.aiExpert,
      label:   'AR Expert',
      desc:    'Ask our AI assistant questions and get instant expert guidance.',
      key:     'ai',
    ),
    _ModuleInfo(
      icon:    Icons.fitness_center_rounded,
      color:   AppColors.training,
      label:   'Smart Training',
      desc:    'Practice hands-on skills with guided training exercises and real-time feedback.',
      key:     'training',
    ),
    _ModuleInfo(
      icon:    Icons.quiz_rounded,
      color:   AppColors.assess,
      label:   'Assessment',
      desc:    'Test your knowledge and competency with structured evaluations.',
      key:     'assessment',
    ),
  ];

  bool _isEnabled(String key) {
    if (config == null) return false;
    switch (key) {
      case 'theory':    return config!.theoryModule;
      case 'ai':        return config!.aiExpertModule;
      case 'training':  return config!.smartTrainingModule;
      case 'assessment': return config!.assessmentModule;
      default:          return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabledCount =
        _modules.where((m) => _isEnabled(m.key)).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Text('My Modules', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Modules available to you in your organization.',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Summary chip ─────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.extension_rounded,
                    size: 16, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  '$enabledCount of ${_modules.length} modules active',
                  style: AppTextStyles.labelMd
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Module grid ──────────────────────────────────────────────────
          if (config == null)
            _NoOrgCard()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final cols = constraints.maxWidth >= 900
                    ? 2
                    : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:    cols,
                    mainAxisSpacing:   AppSpacing.md,
                    crossAxisSpacing:  AppSpacing.md,
                    childAspectRatio:  cols == 2 ? 2.8 : 3.5,
                  ),
                  itemCount: _modules.length,
                  itemBuilder: (_, i) {
                    final m = _modules[i];
                    final enabled = _isEnabled(m.key);
                    return _ModuleCard(module: m, enabled: enabled);
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({required this.module, required this.enabled});
  final _ModuleInfo module;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final color = enabled ? module.color : AppColors.onSurfaceSubtle;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: enabled
            ? module.color.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: enabled
              ? module.color.withValues(alpha: 0.35)
              : AppColors.divider,
          width: enabled ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // ── Icon container ────────────────────────────────────────────
          Container(
            width:  52,
            height: 52,
            decoration: BoxDecoration(
              color: enabled
                  ? module.color.withValues(alpha: 0.15)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(module.icon, size: 24, color: color),
          ),
          const SizedBox(width: AppSpacing.md),

          // ── Text ──────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      module.label,
                      style: AppTextStyles.headingSm.copyWith(color: color),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      enabled
                          ? Icons.check_circle_rounded
                          : Icons.lock_rounded,
                      size:  14,
                      color: enabled ? AppColors.success : AppColors.onSurfaceSubtle,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  module.desc,
                  style: AppTextStyles.bodyXs.copyWith(
                    color: enabled
                        ? AppColors.onSurfaceMuted
                        : AppColors.onSurfaceSubtle,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoOrgCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(Icons.domain_disabled_rounded,
              size: 48, color: AppColors.onSurfaceSubtle),
          const SizedBox(height: AppSpacing.md),
          Text('No organization assigned',
              style: AppTextStyles.headingSm),
          const SizedBox(height: 4),
          Text(
            'Contact your administrator to be assigned to an organization.',
            style: AppTextStyles.bodySm,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ModuleInfo {
  const _ModuleInfo({
    required this.icon,
    required this.color,
    required this.label,
    required this.desc,
    required this.key,
  });

  final IconData icon;
  final Color    color;
  final String   label;
  final String   desc;
  final String   key;
}
