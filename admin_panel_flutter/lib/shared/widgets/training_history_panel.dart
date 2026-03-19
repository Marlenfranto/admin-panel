import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/theme.dart';

/// Displays a list of Smart Training session results.
///
/// Pass [results] sorted newest-first. [passingPercentage] determines the
/// pass/fail threshold (default 60).
class TrainingHistoryPanel extends StatelessWidget {
  const TrainingHistoryPanel({
    super.key,
    required this.results,
    this.passingPercentage = 60,
  });

  final List<TrainingSessionResult> results;
  final int passingPercentage;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.fitness_center_rounded,
                  size: 36, color: AppColors.onSurfaceSubtle),
              const SizedBox(height: AppSpacing.md),
              Text('No attempts yet', style: AppTextStyles.headingSm),
              const SizedBox(height: 4),
              Text(
                'Training results will appear here after each session.',
                style: AppTextStyles.bodySm,
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
        for (int i = 0; i < results.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          _AttemptCard(
            attempt:           results[i],
            attemptNumber:     results.length - i,
            passingPercentage: passingPercentage,
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _AttemptCard extends StatefulWidget {
  const _AttemptCard({
    required this.attempt,
    required this.attemptNumber,
    required this.passingPercentage,
  });

  final TrainingSessionResult attempt;
  final int                   attemptNumber;
  final int                   passingPercentage;

  @override
  State<_AttemptCard> createState() => _AttemptCardState();
}

class _AttemptCardState extends State<_AttemptCard> {
  bool _expanded = false;

  static final _dateFmt = DateFormat('MMM d, y • h:mm a');

  bool  get _passed     => widget.attempt.overallPercentage >= widget.passingPercentage;
  Color get _scoreColor => _passed ? AppColors.success : AppColors.error;

  @override
  Widget build(BuildContext context) {
    final criteria = widget.attempt.criteriaScores ?? [];

    return Container(
      decoration: BoxDecoration(
        color:        AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Compact header row (always visible) ─────────────────────────
          InkWell(
            onTap: criteria.isEmpty
                ? null
                : () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: 10),
              child: Row(
                children: [
                  // Attempt number badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:        AppColors.training.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      '#${widget.attemptNumber}',
                      style: AppTextStyles.labelSm
                          .copyWith(color: AppColors.training),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Date
                  Expanded(
                    child: Text(
                      _dateFmt.format(widget.attempt.completedAt.toLocal()),
                      style:    AppTextStyles.bodyXs,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  // Score
                  Text(
                    '${widget.attempt.overallPercentage}%',
                    style: AppTextStyles.labelLg.copyWith(color: _scoreColor),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Pass / Fail chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:        _scoreColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _passed
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          size:  11,
                          color: _scoreColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          _passed ? 'Pass' : 'Fail',
                          style: AppTextStyles.labelSm
                              .copyWith(color: _scoreColor),
                        ),
                      ],
                    ),
                  ),

                  // Expand chevron (only when criteria exist)
                  if (criteria.isNotEmpty) ...[
                    const SizedBox(width: AppSpacing.sm),
                    AnimatedRotation(
                      turns:    _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more_rounded,
                        size:  16,
                        color: AppColors.onSurfaceMuted,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // ── Criteria breakdown (expandable) ─────────────────────────────
          if (_expanded && criteria.isNotEmpty) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final c in criteria) ...[
                    _CriterionRow(criterion: c),
                    const SizedBox(height: 6),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CriterionRow extends StatelessWidget {
  const _CriterionRow({required this.criterion});
  final TrainingCriteriaScore criterion;

  static const _maxScore = 5;

  @override
  Widget build(BuildContext context) {
    final score    = criterion.score.clamp(0, _maxScore);
    final fraction = score / _maxScore;
    final barColor = fraction >= 0.8
        ? AppColors.success
        : fraction >= 0.5
            ? AppColors.warning
            : AppColors.error;

    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            criterion.parameter,
            style:    AppTextStyles.bodyXs,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value:            fraction,
              minHeight:        6,
              backgroundColor:  AppColors.divider,
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 32,
          child: Text(
            '$score/$_maxScore',
            style:     AppTextStyles.labelSm,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
