import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/theme.dart';

/// Displays a graphical visualization of Smart Training session results.
///
/// Features a Line Chart for performance trends and an interactive Bar Chart
/// for specific session criteria breakdowns.
class TrainingHistoryPanel extends StatefulWidget {
  const TrainingHistoryPanel({
    super.key,
    required this.results,
    this.passingPercentage = 60,
  });

  final List<TrainingSessionResult> results;
  final int passingPercentage;

  @override
  State<TrainingHistoryPanel> createState() => _TrainingHistoryPanelState();
}

class _TrainingHistoryPanelState extends State<TrainingHistoryPanel> {
  int? _selectedResultId;

  @override
  void initState() {
    super.initState();
    // Default to the most recent result if available
    if (widget.results.isNotEmpty) {
      _selectedResultId = widget.results.first.id;
    }
  }

  @override
  void didUpdateWidget(TrainingHistoryPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.results.isNotEmpty &&
        (oldWidget.results.isEmpty ||
            widget.results.first.id != _selectedResultId)) {
      if (_selectedResultId == null ||
          !widget.results.any((r) => r.id == _selectedResultId)) {
        _selectedResultId = widget.results.first.id;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_graph_rounded,
                  size: 36, color: AppColors.onSurfaceSubtle),
              const SizedBox(height: AppSpacing.md),
              Text('No performance data', style: AppTextStyles.headingSm),
              const SizedBox(height: 4),
              Text(
                'Visualizations will appear after your first training session.',
                style: AppTextStyles.bodySm,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final selectedResult = widget.results.firstWhere(
      (r) => r.id == _selectedResultId,
      orElse: () => widget.results.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Trend Chart ──────────────────────────────────────────────────────
        Text('Performance Trend', style: AppTextStyles.labelLg),
        const SizedBox(height: AppSpacing.md),
        _PerformanceTrendChart(
          results: widget.results,
          passingPercentage: widget.passingPercentage,
          selectedId: _selectedResultId,
          onSelected: (id) => setState(() => _selectedResultId = id),
        ),

        const SizedBox(height: AppSpacing.xl),

        // ── Criteria Breakdown ───────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Criteria Breakdown', style: AppTextStyles.labelLg),
                  Text(
                    'Session on ${DateFormat('MMM d, h:mm a').format(selectedResult.completedAt.toLocal())}',
                    style: AppTextStyles.bodyXs.copyWith(color: AppColors.onSurfaceMuted),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (selectedResult.overallPercentage >= widget.passingPercentage
                        ? AppColors.success
                        : AppColors.error)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Text(
                'Score: ${selectedResult.overallPercentage}%',
                style: AppTextStyles.labelSm.copyWith(
                  color: selectedResult.overallPercentage >= widget.passingPercentage
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _CriteriaBarChart(result: selectedResult),

        const SizedBox(height: AppSpacing.xl),

        // ── Simple History List ──────────────────────────────────────────────
        Text('Attempt History', style: AppTextStyles.labelLg),
        const SizedBox(height: AppSpacing.sm),
        ...widget.results.map((r) => _HistoryRow(
              result: r,
              isSelected: r.id == _selectedResultId,
              passingPercentage: widget.passingPercentage,
              onTap: () => setState(() => _selectedResultId = r.id),
            )),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PerformanceTrendChart extends StatelessWidget {
  const _PerformanceTrendChart({
    required this.results,
    required this.passingPercentage,
    required this.selectedId,
    required this.onSelected,
  });

  final List<TrainingSessionResult> results;
  final int passingPercentage;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    // Sort oldest first for the chart
    final chronological = results.reversed.toList();

    return Container(
      height: 200,
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.divider,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 25,
                reservedSize: 35,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}%',
                  style: AppTextStyles.labelXs.copyWith(color: AppColors.onSurfaceSubtle),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= chronological.length) return const SizedBox();
                  if (chronological.length > 5 && index % (chronological.length ~/ 3) != 0) {
                    return const SizedBox();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '#${results.length - (chronological.length - 1 - index)}',
                      style: AppTextStyles.labelXs.copyWith(color: AppColors.onSurfaceSubtle),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (chronological.length - 1).toDouble(),
          minY: 0,
          maxY: 100,
          lineBarsData: [
            // Passing Threshold Line
            LineChartBarData(
              spots: [
                FlSpot(0, passingPercentage.toDouble()),
                FlSpot((chronological.length - 1).toDouble(), passingPercentage.toDouble()),
              ],
              isCurved: false,
              color: AppColors.error.withValues(alpha: 0.3),
              barWidth: 1,
              dotData: const FlDotData(show: false),
              dashArray: [5, 5],
            ),
            // Performance Line
            LineChartBarData(
              spots: chronological.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.overallPercentage.toDouble());
              }).toList(),
              isCurved: true,
              curveSmoothness: 0.3,
              color: AppColors.primary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  final isSelected = chronological[index].id == selectedId;
                  return FlDotCirclePainter(
                    radius: isSelected ? 6 : 4,
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    strokeWidth: 2,
                    strokeColor: AppColors.primary,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.primary.withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchCallback: (event, response) {
              if (response != null && response.lineBarSpots != null && event is FlTapUpEvent) {
                final index = response.lineBarSpots!.first.spotIndex;
                onSelected(chronological[index].id);
              }
            },
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => AppColors.onSurface,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final result = chronological[spot.spotIndex];
                  return LineTooltipItem(
                    '${result.overallPercentage}%\n${DateFormat('MMM d').format(result.completedAt.toLocal())}',
                    AppTextStyles.labelSm.copyWith(color: AppColors.surface),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _CriteriaBarChart extends StatelessWidget {
  const _CriteriaBarChart({required this.result});
  final TrainingSessionResult result;

  @override
  Widget build(BuildContext context) {
    final criteria = result.criteriaScores ?? [];
    if (criteria.isEmpty) return const SizedBox();

    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 5,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => AppColors.onSurface,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${criteria[groupIndex].parameter}\nScore: ${rod.toY.toInt()}/5',
                  AppTextStyles.labelSm.copyWith(color: AppColors.surface),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= criteria.length) return const SizedBox();
                  final label = criteria[index].parameter;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      label.length > 8 ? '${label.substring(0, 6)}..' : label,
                      style: AppTextStyles.labelXs.copyWith(color: AppColors.onSurfaceMuted),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                interval: 1,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: AppTextStyles.labelXs.copyWith(color: AppColors.onSurfaceSubtle),
                ),
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: criteria.asMap().entries.map((e) {
            final score = e.value.score.toDouble();
            final color = score >= 4
                ? AppColors.success
                : score >= 2.5
                    ? AppColors.warning
                    : AppColors.error;

            return BarChartGroupData(
              x: e.key,
              barRods: [
                BarChartRodData(
                  toY: score,
                  color: color,
                  width: 16,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 5,
                    color: AppColors.divider,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({
    required this.result,
    required this.isSelected,
    required this.passingPercentage,
    required this.onTap,
  });

  final TrainingSessionResult result;
  final bool isSelected;
  final int passingPercentage;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final passed = result.overallPercentage >= passingPercentage;
    final color = passed ? AppColors.success : AppColors.error;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: isSelected ? AppColors.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM d, y • h:mm a').format(result.completedAt.toLocal()),
                      style: AppTextStyles.bodyXs.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : null,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${result.overallPercentage}%',
                style: AppTextStyles.labelSm.copyWith(color: color),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(
                passed ? Icons.check_circle_rounded : Icons.cancel_rounded,
                size: 14,
                color: color.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

