import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import 'training_history_panel.dart';

typedef UserHistoryLoader = Future<List<TrainingSessionResult>> Function(
    int userId);

/// Loads and displays Smart Training histories for every user in [users],
/// grouped by user with a collapsible section per user.
/// Histories are fetched in parallel via [historyLoader].
class AllUsersTrainingHistoryPanel extends StatefulWidget {
  const AllUsersTrainingHistoryPanel({
    super.key,
    required this.users,
    required this.historyLoader,
    this.passingPercentage = 60,
  });

  final List<AppUser>     users;
  final UserHistoryLoader historyLoader;
  final int               passingPercentage;

  @override
  State<AllUsersTrainingHistoryPanel> createState() =>
      _AllUsersTrainingHistoryPanelState();
}

class _AllUsersTrainingHistoryPanelState
    extends State<AllUsersTrainingHistoryPanel> {
  late Future<List<(AppUser, List<TrainingSessionResult>)>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(AllUsersTrainingHistoryPanel old) {
    super.didUpdateWidget(old);
    if (old.users != widget.users) _load();
  }

  void _load() {
    _future = Future.wait(
      widget.users.map((u) async {
        final results = await widget.historyLoader(u.id!);
        return (u, results);
      }),
    );
  }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(
            children: [
              Container(
                width:  38,
                height: 38,
                decoration: BoxDecoration(
                  color:        AppColors.training.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(
                  Icons.fitness_center_rounded,
                  size:  18,
                  color: AppColors.training,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Smart Training History',
                        style: AppTextStyles.headingSm),
                    Text('Training session results for all users',
                        style: AppTextStyles.bodyXs),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),

          // ── Body ────────────────────────────────────────────────────────
          FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Text(
                  'Error loading training history: ${snapshot.error}',
                  style: AppTextStyles.bodySm
                      .copyWith(color: AppColors.error),
                );
              }

              final withResults = (snapshot.data ?? [])
                  .where((e) => e.$2.isNotEmpty)
                  .toList()
                ..sort((a, b) =>
                    b.$2.first.completedAt.compareTo(a.$2.first.completedAt));

              if (withResults.isEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.fitness_center_rounded,
                            size: 36, color: AppColors.onSurfaceSubtle),
                        const SizedBox(height: AppSpacing.md),
                        Text('No training results yet',
                            style: AppTextStyles.headingSm),
                        const SizedBox(height: 4),
                        Text(
                          'Results will appear here after users complete training sessions.',
                          style:     AppTextStyles.bodySm,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < withResults.length; i++) ...[
                    if (i > 0) ...[
                      const SizedBox(height: AppSpacing.sm),
                      const Divider(height: 1),
                      const SizedBox(height: AppSpacing.sm),
                    ],
                    _UserHistorySection(
                      user:              withResults[i].$1,
                      results:           withResults[i].$2,
                      passingPercentage: widget.passingPercentage,
                      initiallyExpanded: i == 0,
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

// ── Per-user collapsible section ───────────────────────────────────────────────

class _UserHistorySection extends StatefulWidget {
  const _UserHistorySection({
    required this.user,
    required this.results,
    required this.passingPercentage,
    this.initiallyExpanded = false,
  });

  final AppUser                     user;
  final List<TrainingSessionResult> results;
  final int                         passingPercentage;
  final bool                        initiallyExpanded;

  @override
  State<_UserHistorySection> createState() => _UserHistorySectionState();
}

class _UserHistorySectionState extends State<_UserHistorySection> {
  late bool _expanded;

  static const _palette = [
    Color(0xFF2563EB), Color(0xFF7C3AED), Color(0xFFD97706),
    Color(0xFF16A34A), Color(0xFFDC2626), Color(0xFF0891B2),
  ];

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  int get _passedCount => widget.results
      .where((r) => r.overallPercentage >= widget.passingPercentage)
      .length;

  int get _bestScore => widget.results
      .map((r) => r.overallPercentage)
      .reduce((a, b) => a > b ? a : b);

  @override
  Widget build(BuildContext context) {
    final name    = widget.user.userInfo?.userName ?? '—';
    final email   = widget.user.userInfo?.email    ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final color   = _palette[name.codeUnitAt(0) % _palette.length];
    final total   = widget.results.length;
    final passed  = _passedCount;
    final best    = _bestScore;
    final bestPassed = best >= widget.passingPercentage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Clickable user header ──────────────────────────────────────────
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                // Avatar
                Container(
                  width:  36,
                  height: 36,
                  decoration: BoxDecoration(
                    color:        color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(36 * 0.3),
                  ),
                  child: Center(
                    child: Text(
                      initial,
                      style: TextStyle(
                        fontSize:   14,
                        fontWeight: FontWeight.w700,
                        color:      color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Name + email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppTextStyles.labelMd),
                      if (email.isNotEmpty)
                        Text(email,
                            style: AppTextStyles.bodyXs
                                .copyWith(color: AppColors.onSurfaceMuted)),
                    ],
                  ),
                ),

                // Best score chip
                _SummaryChip(
                  label: 'Best $best%',
                  color: bestPassed ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: AppSpacing.sm),

                // Pass rate chip
                _SummaryChip(
                  label: '$passed/$total passed',
                  color: passed > 0 ? AppColors.success : AppColors.onSurfaceMuted,
                ),
                const SizedBox(width: AppSpacing.sm),

                // Attempt count chip
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:        AppColors.training.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
                  ),
                  child: Text(
                    '$total attempt${total == 1 ? '' : 's'}',
                    style: AppTextStyles.labelSm
                        .copyWith(color: AppColors.training),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Expand chevron
                AnimatedRotation(
                  turns:    _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.expand_more_rounded,
                    size:  18,
                    color: AppColors.onSurfaceMuted,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Expandable attempts ──────────────────────────────────────────
        AnimatedCrossFade(
          duration:       const Duration(milliseconds: 220),
          crossFadeState: _expanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: TrainingHistoryPanel(
              results:           widget.results,
              passingPercentage: widget.passingPercentage,
            ),
          ),
          secondChild: const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ── Small summary chip ─────────────────────────────────────────────────────────

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.color});
  final String label;
  final Color  color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:        color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSm.copyWith(color: color),
      ),
    );
  }
}
