import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/user_providers.dart';

class UserModulesScreen extends ConsumerWidget {
  const UserModulesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAsync   = ref.watch(userModuleConfigProvider);
    final progressAsync = ref.watch(userModuleProgressProvider);
    final historyAsync  = ref.watch(userTrainingHistoryProvider);

    return configAsync.when(
      data: (config) => progressAsync.when(
        data: (progress) => _ModulesContent(
          config:        config,
          progress:      progress,
          historyAsync:  historyAsync,
          passingPct:    config?.passingPercentage ?? 60,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(
          child: Text('Error: $e',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error:   (e, _) => Center(
        child: Text('Error: $e',
            style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ModulesContent extends StatelessWidget {
  const _ModulesContent({
    required this.config,
    required this.progress,
    required this.historyAsync,
    required this.passingPct,
  });

  final ModuleConfig?                          config;
  final List<UserModuleProgress>               progress;
  final AsyncValue<List<TrainingSessionResult>> historyAsync;
  final int                                    passingPct;

  static const _allModules = [
    _ModuleInfo(
      icon:  Icons.menu_book_rounded,
      color: AppColors.theory,
      label: 'Theory',
      desc:  'Learn concepts, procedures and safety standards through structured lessons.',
      key:   'theory',
    ),
    _ModuleInfo(
      icon:  Icons.smart_toy_rounded,
      color: AppColors.aiExpert,
      label: 'AR Expert',
      desc:  'Ask our AI assistant questions and get instant expert guidance.',
      key:   'aiExpert',
    ),
    _ModuleInfo(
      icon:  Icons.fitness_center_rounded,
      color: AppColors.training,
      label: 'Smart Training',
      desc:  'Practice hands-on skills with guided training exercises and real-time feedback.',
      key:   'smartTraining',
    ),
    _ModuleInfo(
      icon:  Icons.quiz_rounded,
      color: AppColors.assess,
      label: 'Assessment',
      desc:  'Test your knowledge and competency with structured evaluations.',
      key:   'assessment',
    ),
  ];

  bool _isGlobalEnabled(String key) {
    if (config == null) return false;
    return switch (key) {
      'theory'        => config!.theoryModule,
      'aiExpert'      => config!.aiExpertModule,
      'smartTraining' => config!.smartTrainingModule,
      'assessment'    => config!.assessmentModule,
      _               => false,
    };
  }

  bool _isEffectiveEnabled(String key) {
    final record = _progressFor(key);
    return record?.isEnabled ?? _isGlobalEnabled(key);
  }

  UserModuleProgress? _progressFor(String key) {
    try {
      return progress.firstWhere((p) => p.moduleId == key);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (config == null) {
      return const SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.pagePadding),
        child: _NoOrgCard(),
      );
    }

    final enabledModules = _allModules
        .where((m) => _isEffectiveEnabled(m.key))
        .toList();

    final overdueCount = enabledModules.where((m) {
      final p = _progressFor(m.key);
      return p != null &&
          p.deadline != null &&
          p.deadline!.isBefore(DateTime.now()) &&
          p.status != ModuleProgressStatus.completed;
    }).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Text('My Modules', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(
            'Modules assigned to you by your organization.',
            style: AppTextStyles.bodySm,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Summary strip ────────────────────────────────────────────────
          Row(
            children: [
              _SummaryChip(
                icon:  Icons.extension_rounded,
                label: '${enabledModules.length} module${enabledModules.length == 1 ? "" : "s"} assigned',
                color: AppColors.primary,
              ),
              if (overdueCount > 0) ...[
                const SizedBox(width: AppSpacing.sm),
                _SummaryChip(
                  icon:  Icons.warning_rounded,
                  label: '$overdueCount overdue',
                  color: AppColors.error,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Module cards ─────────────────────────────────────────────────
          if (enabledModules.isEmpty)
            const _NoModulesCard()
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final twoCol = constraints.maxWidth >= 900;
                final cardWidth = twoCol
                    ? (constraints.maxWidth - AppSpacing.md) / 2
                    : constraints.maxWidth;
                return Wrap(
                  spacing:    AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  children: enabledModules.map((m) {
                    return SizedBox(
                      width: cardWidth,
                      child: _ModuleCard(
                        module:   m,
                        progress: _progressFor(m.key),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

          // ── Training history section ──────────────────────────────────────
          if (_isEffectiveEnabled('smartTraining')) ...[
            const SizedBox(height: AppSpacing.xl),
            _TrainingHistorySection(
              historyAsync: historyAsync,
              passingPct:   passingPct,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Summary chip ──────────────────────────────────────────────────────────────

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String   label;
  final Color    color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
      decoration: BoxDecoration(
        color:        color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(label, style: AppTextStyles.labelSm.copyWith(color: color)),
        ],
      ),
    );
  }
}

// ── Module card ───────────────────────────────────────────────────────────────

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
    required this.module,
    required this.progress,
  });

  final _ModuleInfo          module;
  final UserModuleProgress?  progress;

  static final _dateFmt = DateFormat('MMM d, y');

  bool get _isOverdue {
    final d = progress?.deadline;
    return d != null &&
        d.isBefore(DateTime.now()) &&
        progress?.status != ModuleProgressStatus.completed;
  }

  int get _daysOverdue {
    final d = progress?.deadline;
    if (d == null) return 0;
    return DateTime.now().difference(d).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final overdue  = _isOverdue;
    final status   = progress?.status ?? ModuleProgressStatus.notStarted;
    final deadline = progress?.deadline;

    final cardColor   = overdue ? AppColors.errorSurface : module.color.withValues(alpha: 0.08);
    final borderColor = overdue
        ? AppColors.error.withValues(alpha: 0.50)
        : module.color.withValues(alpha: 0.35);
    final iconBg = overdue
        ? AppColors.error.withValues(alpha: 0.12)
        : module.color.withValues(alpha: 0.15);
    final iconColor  = overdue ? AppColors.error : module.color;
    final labelColor = overdue ? AppColors.error : module.color;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color:        cardColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card body ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: icon + label + description
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:  48,
                      height: 48,
                      decoration: BoxDecoration(
                        color:        iconBg,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: Icon(module.icon, size: 22, color: iconColor),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.label,
                            style: AppTextStyles.headingSm.copyWith(color: labelColor),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            module.desc,
                            style: AppTextStyles.bodyXs.copyWith(
                              color: AppColors.onSurfaceMuted,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Status + deadline row (only when progress exists)
                if (progress != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  const Divider(height: 1),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      _statusChip(status),
                      const Spacer(),
                      if (deadline != null) _DeadlineLabel(deadline: deadline, isOverdue: overdue),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // ── Overdue banner ─────────────────────────────────────────────
          if (overdue)
            Container(
              width:   double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.cardPadding, vertical: 9),
              color: AppColors.error,
              child: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      size: 14, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    '${_daysOverdue} ${_daysOverdue == 1 ? "day" : "days"} overdue — contact your manager',
                    style: const TextStyle(
                      color:      Colors.white,
                      fontSize:   12,
                      fontWeight: FontWeight.w600,
                      height:     1.2,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _statusChip(ModuleProgressStatus status) {
    final (label, variant) = switch (status) {
      ModuleProgressStatus.notStarted => ('Not Started', AppChipVariant.neutral),
      ModuleProgressStatus.inProgress => ('In Progress', AppChipVariant.warning),
      ModuleProgressStatus.completed  => ('Completed',   AppChipVariant.success),
    };
    return AppStatusChip(label: label, variant: variant, small: true);
  }
}

// ── Deadline label ────────────────────────────────────────────────────────────

class _DeadlineLabel extends StatelessWidget {
  const _DeadlineLabel({required this.deadline, required this.isOverdue});

  final DateTime deadline;
  final bool     isOverdue;

  static final _fmt = DateFormat('MMM d, y');

  @override
  Widget build(BuildContext context) {
    final color = isOverdue ? AppColors.error : AppColors.onSurfaceMuted;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isOverdue ? Icons.warning_rounded : Icons.event_rounded,
          size:  13,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          _fmt.format(deadline.toLocal()),
          style: AppTextStyles.bodyXs.copyWith(
            color:      color,
            fontWeight: isOverdue ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// ── Empty states ──────────────────────────────────────────────────────────────

class _NoOrgCard extends StatelessWidget {
  const _NoOrgCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(Icons.domain_disabled_rounded,
              size: 48, color: AppColors.onSurfaceSubtle),
          const SizedBox(height: AppSpacing.md),
          Text('No organization assigned', style: AppTextStyles.headingSm),
          const SizedBox(height: 4),
          Text(
            'Contact your administrator to be assigned to an organization.',
            style:     AppTextStyles.bodySm,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _NoModulesCard extends StatelessWidget {
  const _NoModulesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(Icons.extension_off_rounded,
              size: 48, color: AppColors.onSurfaceSubtle),
          const SizedBox(height: AppSpacing.md),
          Text('No modules assigned', style: AppTextStyles.headingSm),
          const SizedBox(height: 4),
          Text(
            'Your manager has not enabled any modules for you yet.',
            style:     AppTextStyles.bodySm,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Training history section ───────────────────────────────────────────────────

class _TrainingHistorySection extends StatelessWidget {
  const _TrainingHistorySection({
    required this.historyAsync,
    required this.passingPct,
  });

  final AsyncValue<List<TrainingSessionResult>> historyAsync;
  final int passingPct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width:  4,
              height: 18,
              decoration: BoxDecoration(
                color:        AppColors.training,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text('Smart Training History', style: AppTextStyles.headingSm),
            const Spacer(),
            historyAsync.when(
              data:    (h) => Text('${h.length} attempt${h.length == 1 ? "" : "s"}',
                  style: AppTextStyles.bodyXs),
              loading: () => const SizedBox.shrink(),
              error:   (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        historyAsync.when(
          data:    (history) => TrainingHistoryPanel(
            results:           history,
            passingPercentage: passingPct,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error:   (e, _) => Text('Error loading history: $e',
              style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
        ),
      ],
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────

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
