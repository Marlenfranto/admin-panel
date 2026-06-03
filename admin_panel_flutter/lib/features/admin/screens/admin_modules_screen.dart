import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
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

class AdminModulesScreen extends ConsumerStatefulWidget {
  const AdminModulesScreen({super.key});

  @override
  ConsumerState<AdminModulesScreen> createState() => _AdminModulesScreenState();
}

class _AdminModulesScreenState extends ConsumerState<AdminModulesScreen> {
  Organization? _selectedOrg;
  bool _theory     = false;
  bool _ai         = false;
  bool _training   = false;
  bool _assessment = false;
  int  _passing    = 60;

  final _aiPromptCtrl = TextEditingController();
  // Per-locale AI prompt overrides, keyed by localeKey (e.g. "US-en").
  final Map<String, TextEditingController> _aiPromptTranslations = {};
  bool _saving = false;

  @override
  void dispose() {
    _aiPromptCtrl.dispose();
    for (final c in _aiPromptTranslations.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _loadConfig(ModuleConfig? config) {
    for (final c in _aiPromptTranslations.values) {
      c.dispose();
    }
    _aiPromptTranslations.clear();
    setState(() {
      if (config != null) {
        _theory = config.theoryModule;
        _ai = config.aiExpertModule;
        _training = config.smartTrainingModule;
        _assessment = config.assessmentModule;
        _passing = config.passingPercentage;
        _aiPromptCtrl.text = config.aiChatPrompt ?? '';
        for (final t in config.aiChatPromptTranslations ?? []) {
          // Prefer localeKey; fall back to languageCode for legacy entries
          // (Phase 2 backfill populated localeKey for all existing rows).
          final key = t.localeKey ?? t.languageCode;
          _aiPromptTranslations[key] =
              TextEditingController(text: t.prompt);
        }
      } else {
        _theory = _ai = _training = _assessment = false;
        _passing = 60;
        _aiPromptCtrl.text = '';
      }
    });
  }

  Future<void> _save() async {
    if (_selectedOrg == null) return;
    setState(() => _saving = true);
    try {
      final prompt = _aiPromptCtrl.text.trim();
      // Build LocalizedAiPrompt entries keyed by localeKey. languageCode is
      // derived from the key (the lowercase suffix after the dash) for
      // backward compat with the deprecated field.
      final promptTranslations = _aiPromptTranslations.entries
          .where((e) => e.value.text.trim().isNotEmpty)
          .map((e) {
            final localeKey = e.key;
            final dash = localeKey.indexOf('-');
            final languageCode =
                dash >= 0 ? localeKey.substring(dash + 1) : localeKey;
            return LocalizedAiPrompt(
              languageCode: languageCode,
              localeKey: localeKey,
              prompt: e.value.text.trim(),
            );
          })
          .toList();
      await ref.read(clientProvider).admin.setModuleConfig(
            _selectedOrg!.id!,
            _theory,
            _ai,
            _training,
            _assessment,
            // defaultLanguage / supportedLanguages are deprecated (non-persistent).
            // Locale management lives in the Locales screen.
            'en',
            const <SupportedLanguage>[],
            prompt.isEmpty ? null : prompt,
            promptTranslations.isEmpty ? null : promptTranslations,
            _passing,
          );
      ref.invalidate(moduleConfigProvider(_selectedOrg!.id!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuration saved.')),
        );
      }
    } catch (e) {
      if (mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
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
    final orgsAsync    = ref.watch(parentOrgsProvider);
    final allOrgsAsync = ref.watch(allOrganizationsProvider);


    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsivePagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Text('Module Configuration', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Enable or disable training modules per organization.',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Organization picker ──────────────────────────────────────────
          _SectionCard(
            child: orgsAsync.when(
              data: (orgs) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardHeader(
                    icon:  Icons.corporate_fare_rounded,
                    color: AppColors.primary,
                    title: 'Organization',
                    subtitle: _selectedOrg == null
                        ? 'Select an organization to configure'
                        : 'Configuring ${_selectedOrg!.name}',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  DropdownButtonFormField<Organization>(
                    value:      _selectedOrg,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      hintText: 'Select an organization',
                      prefixIcon: Icon(
                          Icons.search_rounded, size: 18),
                    ),
                    items: orgs
                        .map((o) => DropdownMenuItem(
                              value: o,
                              child: Text(o.name),
                            ))
                        .toList(),
                    onChanged: (org) async {
                      setState(() => _selectedOrg = org);
                      if (org != null) {
                        final cfg = await ref
                            .read(clientProvider)
                            .admin
                            .getModuleConfig(org.id!);
                        _loadConfig(cfg);
                      }
                    },
                  ),
                ],
              ),
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text(
                'Error: $e',
                style: AppTextStyles.bodySm
                    .copyWith(color: AppColors.error),
              ),
            ),
          ),

          if (_selectedOrg != null) ...[
            const SizedBox(height: AppSpacing.lg),

            // ── Module access ─────────────────────────────────────────────
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardHeader(
                    icon:     Icons.extension_rounded,
                    color:    AppColors.aiExpert,
                    title:    'Module Access',
                    subtitle: 'Toggle which modules are available to this organization',
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _ModuleRow(
                    meta:     _modules[0],
                    value:    _theory,
                    onChange: (v) => setState(() => _theory = v),
                  ),
                  const Divider(height: 1),
                  _ModuleRow(
                    meta:     _modules[1],
                    value:    _ai,
                    onChange: (v) => setState(() => _ai = v),
                  ),
                  const Divider(height: 1),
                  _ModuleRow(
                    meta:     _modules[2],
                    value:    _training,
                    onChange: (v) => setState(() => _training = v),
                  ),
                  const Divider(height: 1),
                  _ModuleRow(
                    meta:     _modules[3],
                    value:    _assessment,
                    onChange: (v) => setState(() => _assessment = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Passing score ─────────────────────────────────────────────
            _SectionCard(
              child: _PassingScoreRow(
                value:    _passing,
                onChanged: (v) => setState(() => _passing = v),
              ),
            ),
            // ── AR Expert AI prompt ───────────────────────────────────────
            if (_ai) ...[
              const SizedBox(height: AppSpacing.lg),
              _AiPromptCard(
                orgId: _selectedOrg!.id!,
                rootCtrl: _aiPromptCtrl,
                translations: _aiPromptTranslations,
                onTranslationChanged: () => setState(() {}),
              ),
            ],

            const SizedBox(height: AppSpacing.xl),

            // ── Save ─────────────────────────────────────────────────────
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

            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            const SizedBox(height: AppSpacing.lg),

            // ── Per-user module configuration ─────────────────────────────
            Builder(builder: (_) {
              // Collect users from the selected org + all its teams,
              // and build a teamLabels map for display.
              final allOrgs   = allOrgsAsync.value ?? [];
              final teams     = allOrgs
                  .where((o) => o.parentId == _selectedOrg!.id)
                  .toList();
              final teamLabels = <int, String>{};
              final seen       = <int>{};
              final allUsers   = <AppUser>[];

              for (final link in (_selectedOrg!.users ?? [])) {
                final u = link.appUser;
                if (u?.id != null && u!.role == Role.User && seen.add(u.id!)) {
                  allUsers.add(u);
                }
              }
              for (final team in teams) {
                for (final link in (team.users ?? [])) {
                  final u = link.appUser;
                  if (u?.id != null && u!.role == Role.User && seen.add(u.id!)) {
                    allUsers.add(u);
                    teamLabels[u.id!] = team.name;
                  }
                }
              }

              return UserModuleConfigPanel(
              orgUsers: allUsers,
              teamLabels: teamLabels.isNotEmpty ? teamLabels : null,
              globalEnabled: {
                'theory':        _theory,
                'aiExpert':      _ai,
                'smartTraining': _training,
                'assessment':    _assessment,
              },
              onLoadProgress: (userId) => ref
                  .read(clientProvider)
                  .admin
                  .getUserModuleProgress(userId, _selectedOrg!.id!),
              onSaveProgress: (userId, states) async {
                for (final s in states) {
                  await ref.read(clientProvider).admin.setUserModuleProgress(
                        userId,
                        _selectedOrg!.id!,
                        s.moduleId,
                        s.isEnabled,
                        s.deadline,
                      );
                  await ref.read(clientProvider).admin.updateUserModuleStatus(
                        userId,
                        _selectedOrg!.id!,
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
        ],
      ),
    );
  }
}

// ── Passing score row ─────────────────────────────────────────────────────────

class _PassingScoreRow extends StatelessWidget {
  const _PassingScoreRow({required this.value, required this.onChanged});

  final int                  value;
  final ValueChanged<int>    onChanged;

  // Colour shifts green → amber → red as the threshold rises.
  Color get _color {
    if (value >= 80) return AppColors.success;
    if (value >= 50) return AppColors.training; // amber
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final color = _color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CardHeader(
          icon:     Icons.emoji_events_rounded,
          color:    color,
          title:    'Passing Score',
          subtitle: 'Minimum percentage a user must score to pass any module',
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Percentage badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width:  76,
              height: 76,
              decoration: BoxDecoration(
                color:        color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: color.withValues(alpha: 0.30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$value',
                    style: AppTextStyles.headingLg.copyWith(color: color),
                  ),
                  Text('%', style: AppTextStyles.labelMd.copyWith(color: color)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),

            // Slider + tick labels
            Expanded(
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight:          4,
                      activeTrackColor:     color,
                      inactiveTrackColor:   color.withValues(alpha: 0.15),
                      thumbColor:           color,
                      overlayColor:         color.withValues(alpha: 0.12),
                      thumbShape:           const RoundSliderThumbShape(
                                              enabledThumbRadius: 8),
                      overlayShape:         const RoundSliderOverlayShape(
                                              overlayRadius: 18),
                    ),
                    child: Slider(
                      value:      value.toDouble(),
                      min:        0,
                      max:        100,
                      divisions:  100,
                      onChanged:  (v) => onChanged(v.round()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('0%',   style: AppTextStyles.bodyXs),
                        Text('50%',  style: AppTextStyles.bodyXs),
                        Text('100%', style: AppTextStyles.bodyXs),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Section card wrapper ──────────────────────────────────────────────────────

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

// ── Card header with icon ─────────────────────────────────────────────────────

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
              Text(title, style: AppTextStyles.headingSm),
              Text(subtitle, style: AppTextStyles.bodyXs),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Full-width module toggle row ──────────────────────────────────────────────

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
            color: _hovered
                ? AppColors.surfaceVariant
                : Colors.transparent,
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
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMd),
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
                    Text(
                      widget.meta.description,
                      style: AppTextStyles.bodyXs,
                    ),
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

// ── AR Expert AI prompt editor ────────────────────────────────────────────────
//
// Lists per-locale prompt overrides for the org's enabled LocaleConfig rows.
// The locale dropdown comes from the Locales screen; manage locales there.

class _AiPromptCard extends ConsumerWidget {
  const _AiPromptCard({
    required this.orgId,
    required this.rootCtrl,
    required this.translations,
    required this.onTranslationChanged,
  });

  final int orgId;
  final TextEditingController rootCtrl;
  final Map<String, TextEditingController> translations;
  final VoidCallback onTranslationChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localesAsync = ref.watch(adminLocaleConfigsProvider(orgId));
    final cfgAsync = ref.watch(moduleConfigProvider(orgId));
    final defaultLocaleKey =
        cfgAsync.value?.defaultLocaleKey ?? 'US-en';

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon: Icons.smart_toy_rounded,
            color: AppColors.aiExpert,
            title: 'AR Expert AI System Prompt',
            subtitle:
                'Sent as the system message for every AI chat session. '
                'Per-locale variants are served to users based on their '
                'preferred regional locale.',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Default ($defaultLocaleKey)',
            style: AppTextStyles.labelSm,
          ),
          const SizedBox(height: 4),
          TextField(
            controller: rootCtrl,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'You are a helpful AR Expert assistant…',
              alignLabelWithHint: true,
            ),
          ),
          localesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => Padding(
              padding: const EdgeInsets.only(top: AppSpacing.md),
              child: Text(
                'Could not load locales: $e',
                style: AppTextStyles.bodyXs
                    .copyWith(color: AppColors.error),
              ),
            ),
            data: (locales) {
              final others = locales
                  .where((l) => l.localeKey != defaultLocaleKey)
                  .toList();
              if (others.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Text(
                    'Add more locales in the Locales screen to provide '
                    'per-region prompt variants.',
                    style: AppTextStyles.bodyXs,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final l in others) ...[
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Text(
                          '${l.localeKey} — ${l.displayName}',
                          style: AppTextStyles.labelSm,
                        ),
                        if (l.fallbackLocaleKey != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            '· falls back to ${l.fallbackLocaleKey}',
                            style: AppTextStyles.bodyXs.copyWith(
                              color: AppColors.onSurfaceMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      controller: translations.putIfAbsent(
                        l.localeKey,
                        () => TextEditingController(),
                      ),
                      onChanged: (_) => onTranslationChanged(),
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText:
                            'System prompt for ${l.displayName} (leave blank to use default)',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

