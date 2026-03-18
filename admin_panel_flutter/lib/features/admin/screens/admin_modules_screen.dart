import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
import '../../../src/providers.dart';

// ── Language entry helper ─────────────────────────────────────────────────────

class _LangEntry {
  _LangEntry({String code = '', String name = '', String url = ''})
      : codeCtrl = TextEditingController(text: code),
        nameCtrl = TextEditingController(text: name),
        urlCtrl  = TextEditingController(text: url);

  final TextEditingController codeCtrl;
  final TextEditingController nameCtrl;
  final TextEditingController urlCtrl;

  SupportedLanguage toModel() => SupportedLanguage(
        code:       codeCtrl.text.trim(),
        name:       nameCtrl.text.trim(),
        contentUrl: urlCtrl.text.trim().isEmpty ? null : urlCtrl.text.trim(),
      );

  void dispose() {
    codeCtrl.dispose();
    nameCtrl.dispose();
    urlCtrl.dispose();
  }
}

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

  final _defaultLangCtrl = TextEditingController(text: 'en');
  final _aiPromptCtrl    = TextEditingController();
  List<_LangEntry> _languages = [];
  bool _saving = false;

  @override
  void dispose() {
    _defaultLangCtrl.dispose();
    _aiPromptCtrl.dispose();
    for (final l in _languages) {
      l.dispose();
    }
    super.dispose();
  }

  void _loadConfig(ModuleConfig? config) {
    for (final l in _languages) {
      l.dispose();
    }
    setState(() {
      if (config != null) {
        _theory     = config.theoryModule;
        _ai         = config.aiExpertModule;
        _training   = config.smartTrainingModule;
        _assessment = config.assessmentModule;
        _defaultLangCtrl.text = config.defaultLanguage;
        _aiPromptCtrl.text    = config.aiChatPrompt ?? '';
        _languages = (config.supportedLanguages ?? [])
            .map((l) => _LangEntry(
                  code: l.code,
                  name: l.name,
                  url:  l.contentUrl ?? '',
                ))
            .toList();
      } else {
        _theory = _ai = _training = _assessment = false;
        _defaultLangCtrl.text = 'en';
        _aiPromptCtrl.text    = '';
        _languages = [];
      }
    });
  }

  Future<void> _save() async {
    if (_selectedOrg == null) return;
    setState(() => _saving = true);
    try {
      final prompt = _aiPromptCtrl.text.trim();
      await ref.read(clientProvider).admin.setModuleConfig(
            _selectedOrg!.id!,
            _theory,
            _ai,
            _training,
            _assessment,
            _defaultLangCtrl.text.trim().isEmpty
                ? 'en'
                : _defaultLangCtrl.text.trim(),
            _languages.map((l) => l.toModel()).toList(),
            prompt.isEmpty ? null : prompt,
          );
      ref.invalidate(moduleConfigProvider(_selectedOrg!.id!));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Configuration saved.')),
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
    final orgsAsync = ref.watch(allOrganizationsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
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

            // ── Language settings ─────────────────────────────────────────
            _SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardHeader(
                    icon:     Icons.language_rounded,
                    color:    AppColors.info,
                    title:    'Language Settings',
                    subtitle: 'Configure the default and supported content languages',
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Default language row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Default Language',
                                style: AppTextStyles.labelMd),
                            const SizedBox(height: 4),
                            Text(
                              'Used when no language is specified',
                              style: AppTextStyles.bodyXs,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      SizedBox(
                        width: 160,
                        child: TextField(
                          controller: _defaultLangCtrl,
                          decoration: const InputDecoration(
                            hintText:  'en',
                            prefixIcon: Icon(
                                Icons.translate_rounded, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Supported languages header
                  Row(
                    children: [
                      Text('Supported Languages',
                          style: AppTextStyles.labelMd),
                      const Spacer(),
                      TextButton.icon(
                        icon:  const Icon(Icons.add_rounded, size: 15),
                        label: const Text('Add Language'),
                        onPressed: () =>
                            setState(() => _languages.add(_LangEntry())),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  if (_languages.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                            color: AppColors.divider,
                            style: BorderStyle.solid),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.language_rounded,
                              size: 28,
                              color: AppColors.onSurfaceSubtle),
                          const SizedBox(height: 8),
                          Text(
                            'No supported languages yet',
                            style: AppTextStyles.bodyXs,
                          ),
                        ],
                      ),
                    )
                  else ...[
                    // Column headers
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppSpacing.xs,
                          left: 2,
                          right: 40),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text('CODE',
                                style: AppTextStyles.labelSm.copyWith(
                                    letterSpacing: 0.6)),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          SizedBox(
                            width: 160,
                            child: Text('NAME',
                                style: AppTextStyles.labelSm.copyWith(
                                    letterSpacing: 0.6)),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text('CONTENT URL (OPTIONAL)',
                                style: AppTextStyles.labelSm.copyWith(
                                    letterSpacing: 0.6)),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(_languages.length, (i) {
                      final entry = _languages[i];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppSpacing.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80,
                              child: TextField(
                                controller: entry.codeCtrl,
                                decoration: const InputDecoration(
                                  hintText: 'en',
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            SizedBox(
                              width: 160,
                              child: TextField(
                                controller: entry.nameCtrl,
                                decoration: const InputDecoration(
                                  hintText: 'English',
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: TextField(
                                controller: entry.urlCtrl,
                                decoration: const InputDecoration(
                                  hintText: 'https://…/content.json',
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            _RemoveButton(
                              onTap: () => setState(() {
                                entry.dispose();
                                _languages.removeAt(i);
                              }),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),

            // ── AR Expert AI prompt ───────────────────────────────────────
            if (_ai) ...[
              const SizedBox(height: AppSpacing.lg),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardHeader(
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
                        hintText: 'You are a helpful AR Expert assistant…',
                        alignLabelWithHint: true,
                      ),
                    ),
                  ],
                ),
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
          ],
        ],
      ),
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
              color: _hovered
                  ? AppColors.error.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              Icons.delete_outline_rounded,
              size:  16,
              color: _hovered
                  ? AppColors.error
                  : AppColors.onSurfaceSubtle,
            ),
          ),
        ),
      ),
    );
  }
}
