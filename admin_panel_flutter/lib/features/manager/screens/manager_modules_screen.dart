import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';
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

class ManagerModulesScreen extends ConsumerStatefulWidget {
  const ManagerModulesScreen({super.key});

  @override
  ConsumerState<ManagerModulesScreen> createState() =>
      _ManagerModulesScreenState();
}

class _ManagerModulesScreenState extends ConsumerState<ManagerModulesScreen> {
  bool? _theory;
  bool? _ai;
  bool? _training;
  bool? _assessment;
  final _aiPromptCtrl = TextEditingController();
  bool  _loaded       = false;
  bool  _saving       = false;

  @override
  void dispose() {
    _aiPromptCtrl.dispose();
    super.dispose();
  }

  void _loadConfig(ModuleConfig? config) {
    if (_loaded) return;
    setState(() {
      _theory     = config?.theoryModule ?? false;
      _ai         = config?.aiExpertModule ?? false;
      _training   = config?.smartTrainingModule ?? false;
      _assessment = config?.assessmentModule ?? false;
      _aiPromptCtrl.text = config?.aiChatPrompt ?? '';
      _loaded = true;
    });
  }

  // Reset loaded flag when org changes so we reload config for the new org.
  int? _lastOrgId;
  void _checkOrgChanged(int? orgId) {
    if (orgId != _lastOrgId) {
      _lastOrgId = orgId;
      _loaded    = false;
    }
  }

  Future<void> _save() async {
    if (_theory == null) return;
    setState(() => _saving = true);
    try {
      final prompt = _aiPromptCtrl.text.trim();
      final orgId  = ref.read(activeOrgIdProvider);
      if (orgId == null) return;
      await ref.read(clientProvider).manager.updateMyModuleConfig(
            orgId, _theory!, _ai!, _training!, _assessment!,
            prompt.isEmpty ? null : prompt,
          );
      ref.invalidate(managerModuleConfigProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:         Text('Configuration saved.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:         Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orgsAsync   = ref.watch(managedOrganizationsProvider);
    final activeOrgId = ref.watch(activeOrgIdProvider);
    final configAsync = ref.watch(managerModuleConfigProvider);

    _checkOrgChanged(activeOrgId);

    return configAsync.when(
      data: (config) {
        _loadConfig(config);
        if (_theory == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildContent(orgsAsync, activeOrgId);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text('Error: $e',
            style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
      ),
    );
  }

  Widget _buildContent(
    AsyncValue<List<Organization>> orgsAsync,
    int? activeOrgId,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Text('Module Configuration', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Enable or disable modules for your organization.',
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
                            onTap: () {
                              ref.read(selectedOrgIdProvider.notifier).state =
                                  org.id;
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
            error:   (_, __) => const SizedBox.shrink(),
          ),

          // ── Module access ────────────────────────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CardHeader(
                  icon:     Icons.extension_rounded,
                  color:    AppColors.aiExpert,
                  title:    'Module Access',
                  subtitle: 'Toggle which modules are available to your organization',
                ),
                const SizedBox(height: AppSpacing.md),
                _ModuleRow(
                  meta:     _modules[0],
                  value:    _theory!,
                  onChange: (v) => setState(() => _theory = v),
                ),
                const Divider(height: 1),
                _ModuleRow(
                  meta:     _modules[1],
                  value:    _ai!,
                  onChange: (v) => setState(() => _ai = v),
                ),
                const Divider(height: 1),
                _ModuleRow(
                  meta:     _modules[2],
                  value:    _training!,
                  onChange: (v) => setState(() => _training = v),
                ),
                const Divider(height: 1),
                _ModuleRow(
                  meta:     _modules[3],
                  value:    _assessment!,
                  onChange: (v) => setState(() => _assessment = v),
                ),
              ],
            ),
          ),

          // ── AR Expert AI prompt ──────────────────────────────────────────
          if (_ai == true) ...[
            const SizedBox(height: AppSpacing.lg),
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CardHeader(
                    icon:     Icons.smart_toy_rounded,
                    color:    AppColors.aiExpert,
                    title:    'AR Expert AI System Prompt',
                    subtitle: 'Sent as the system message for every AI chat session',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: _aiPromptCtrl,
                    maxLines:   6,
                    decoration: const InputDecoration(
                      hintText:           'You are a helpful AR Expert assistant…',
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: AppSpacing.xl),

          // ── Save ─────────────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppGradientButton(
                label:     'Save Configuration',
                icon:      Icons.save_rounded,
                isLoading: _saving,
                onPressed: _save,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Section card wrapper ───────────────────────────────────────────────────────

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

// ── Card header with icon ──────────────────────────────────────────────────────

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

// ── Full-width module toggle row ───────────────────────────────────────────────

class _ModuleRow extends StatefulWidget {
  const _ModuleRow({
    required this.meta,
    required this.value,
    required this.onChange,
  });

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
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceVariant : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Row(
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width:  40,
                height: 40,
                decoration: BoxDecoration(
                  color: enabled
                      ? color.withValues(alpha: 0.15)
                      : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(
                  widget.meta.icon,
                  size:  18,
                  color: enabled ? color : AppColors.onSurfaceSubtle,
                ),
              ),
              const SizedBox(width: 14),

              // Label + description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.meta.label,
                      style: AppTextStyles.labelLg.copyWith(
                        color: enabled
                            ? AppColors.onSurface
                            : AppColors.onSurfaceMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(widget.meta.description, style: AppTextStyles.bodyXs),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Status chip + switch
              AppStatusChip(
                label:   enabled ? 'Enabled' : 'Disabled',
                variant: enabled
                    ? AppChipVariant.success
                    : AppChipVariant.neutral,
                small: true,
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
