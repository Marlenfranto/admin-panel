import 'dart:async';

import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/theme.dart';
import '../../features/training_history/providers/training_history_provider.dart';
import '../../features/admin/providers/admin_providers.dart';
import '../../src/providers.dart';
import 'responsive_helper.dart';
import 'training_history_panel.dart';
import 'app_gradient_button.dart';
import 'certificate_preview_dialog.dart';

/// Displays a scalable, paginated list of Smart Training history records
/// with support for role-based visibility, search, and advanced filtering.
class AllUsersTrainingHistoryPanel extends ConsumerStatefulWidget {
  const AllUsersTrainingHistoryPanel({
    super.key,
    this.passingPercentage = 60,
  });

  final int passingPercentage;

  @override
  ConsumerState<AllUsersTrainingHistoryPanel> createState() =>
      _AllUsersTrainingHistoryPanelState();
}

class _AllUsersTrainingHistoryPanelState
    extends ConsumerState<AllUsersTrainingHistoryPanel> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final auth = ref.read(authProvider);
      final role = auth.appUser?.role;
      if (role == Role.SuperAdmin ||
          role == Role.OrganizationAdmin ||
          role == Role.Manager) {
        ref.read(trainingUserSummariesProvider.notifier).fetchNextPage();
      } else {
        ref.read(trainingHistoryProvider.notifier).fetchNextPage();
      }
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final auth = ref.read(authProvider);
      final role = auth.appUser?.role;
      if (role == Role.SuperAdmin ||
          role == Role.OrganizationAdmin ||
          role == Role.Manager) {
        ref
            .read(trainingUserSummariesProvider.notifier)
            .updateSearch(value.isEmpty ? null : value);
      } else {
        ref
            .read(trainingHistoryProvider.notifier)
            .updateSearch(value.isEmpty ? null : value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final role = auth.appUser?.role;

    // Use the appropriate provider based on role
    final isSuperAdmin = role == Role.SuperAdmin;
    final isOrgAdmin = role == Role.OrganizationAdmin;
    final isManager = role == Role.Manager;
    final showGroupedView = isSuperAdmin || isOrgAdmin || isManager;

    final stateAsyncUserGrouped =
        showGroupedView ? ref.watch(trainingUserSummariesProvider) : null;
    final stateAsyncSessions =
        !showGroupedView ? ref.watch(trainingHistoryProvider) : null;

    final filter = showGroupedView
        ? stateAsyncUserGrouped?.value?.filter
        : stateAsyncSessions?.value?.filter;
    final totalCount = showGroupedView
        ? stateAsyncUserGrouped?.value?.totalCount
        : stateAsyncSessions?.value?.totalCount;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // ── Header & Filters ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: AppColors.training.withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: const Icon(
                          Icons.history_edu_rounded,
                          size: 22,
                          color: AppColors.training,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              showGroupedView
                                  ? 'Users Training Overview'
                                  : 'Smart Training History',
                              style: AppTextStyles.headingSm,
                            ),
                            if (totalCount != null)
                              Text(
                                showGroupedView
                                    ? '$totalCount users found'
                                    : '$totalCount records found',
                                style: AppTextStyles.bodyXs
                                    .copyWith(color: AppColors.onSurfaceMuted),
                              )
                            else
                              Text('Loading...', style: AppTextStyles.bodyXs),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _WebFilterBar(
                    filter: filter ?? TrainingHistoryFilter(),
                    searchController: _searchController,
                    isSuperAdmin: isSuperAdmin,
                    isOrgAdmin: isOrgAdmin,
                    isManager: isManager,
                    onSearchChanged: _onSearchChanged,
                    onFilterChanged: (newFilter) {
                      if (showGroupedView) {
                        ref
                            .read(trainingUserSummariesProvider.notifier)
                            .updateFilter(newFilter);
                      } else {
                        ref
                            .read(trainingHistoryProvider.notifier)
                            .updateFilter(newFilter);
                      }
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Results List ───────────────────────────────────────────────
            Expanded(
              child: showGroupedView
                  ? stateAsyncUserGrouped!.when(
                      data: (state) {
                        if (state.summaries.isEmpty) {
                          return _buildEmptyState(
                              state.filter.hasActiveFilters);
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount:
                              state.summaries.length + (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == state.summaries.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                ),
                              );
                            }

                            final summary = state.summaries[index];
                            return _UserTrainingCard(
                              summary: summary,
                              passingPercentage: widget.passingPercentage,
                              searchQuery: state.filter.search,
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, st) => _buildErrorState(
                          err,
                          () => ref
                              .read(trainingUserSummariesProvider.notifier)
                              .refresh()),
                    )
                  : stateAsyncSessions!.when(
                      data: (state) {
                        if (state.results.isEmpty) {
                          return _buildEmptyState(
                              state.filter.hasActiveFilters);
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount:
                              state.results.length + (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == state.results.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2.5),
                                ),
                              );
                            }

                            final result = state.results[index];
                            return _SessionRecordCard(
                              result: result,
                              passingPercentage: widget.passingPercentage,
                              role: role,
                              searchQuery: state.filter.search,
                            );
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, st) => _buildErrorState(
                          err,
                          () => ref
                              .read(trainingHistoryProvider.notifier)
                              .refresh()),
                    ),
              ),
            ],
          ),
        );
      }

  Widget _buildErrorState(Object err, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.error, size: 40),
            const SizedBox(height: 16),
            Text('Failed to load history', style: AppTextStyles.labelLg),
            const SizedBox(height: 8),
            Text(err.toString(),
                style: AppTextStyles.bodySm, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isFiltered) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFiltered ? Icons.search_off_rounded : Icons.history_rounded,
            size: 48,
            color: AppColors.onSurfaceSubtle,
          ),
          const SizedBox(height: 16),
          Text(
            isFiltered ? 'No matching records' : 'No history yet',
            style: AppTextStyles.headingSm,
          ),
          const SizedBox(height: 8),
          Text(
            isFiltered
                ? 'Try adjusting your search or filters'
                : 'Results will appear after users complete sessions',
            style: AppTextStyles.bodySm,
          ),
          if (isFiltered)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: TextButton(
                onPressed: () {
                  _searchController.clear();
                  final auth = ref.read(authProvider);
                  if (auth.appUser?.role == Role.SuperAdmin) {
                    ref
                        .read(trainingUserSummariesProvider.notifier)
                        .updateFilter(TrainingHistoryFilter());
                  } else {
                    ref
                        .read(trainingHistoryProvider.notifier)
                        .updateFilter(TrainingHistoryFilter());
                  }
                },
                child: const Text('Clear all filters'),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Private Classes / Widgets for Training History ────────────────────────────

class _WebFilterBar extends ConsumerWidget {
  const _WebFilterBar({
    required this.filter,
    required this.searchController,
    required this.isSuperAdmin,
    required this.isOrgAdmin,
    this.isManager = false,
    required this.onSearchChanged,
    required this.onFilterChanged,
  });

  final TrainingHistoryFilter filter;
  final TextEditingController searchController;
  final bool isSuperAdmin;
  final bool isOrgAdmin;
  final bool isManager;
  final Function(String) onSearchChanged;
  final Function(TrainingHistoryFilter) onFilterChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = context.isMobile;

    final searchField = TextField(
      controller: searchController,
      onChanged: onSearchChanged,
      decoration: InputDecoration(
        hintText: (isSuperAdmin || isOrgAdmin || isManager)
            ? 'Search users by name or email...'
            : 'Search records...',
        prefixIcon: const Icon(Icons.search_rounded, size: 18),
        isDense: true,
        filled: true,
        fillColor: AppColors.surfaceVariant.withValues(alpha: 0.3),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
      ),
    );

    final statusSegment = SegmentedButton<bool?>(
      segments: const [
        ButtonSegment(
            value: null,
            label: Text('All'),
            icon: Icon(Icons.all_inclusive_rounded, size: 14)),
        ButtonSegment(
            value: true,
            label: Text('Passed'),
            icon: Icon(Icons.check_circle_outline_rounded, size: 14)),
        ButtonSegment(
            value: false,
            label: Text('Failed'),
            icon: Icon(Icons.cancel_outlined, size: 14)),
      ],
      selected: {filter.passed},
      onSelectionChanged: (val) => onFilterChanged(filter.copyWith(
          passed: val.first, clearStatus: val.first == null)),
      showSelectedIcon: false,
      style: SegmentedButton.styleFrom(
        visualDensity: VisualDensity.compact,
        textStyle: AppTextStyles.bodyXs
            .copyWith(fontWeight: FontWeight.w600),
        selectedBackgroundColor:
            AppColors.primary.withValues(alpha: 0.1),
        selectedForegroundColor: AppColors.primary,
        side: BorderSide(
            color: AppColors.divider.withValues(alpha: 0.5)),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search + Status — stack on mobile, row on desktop
        if (isMobile) ...[
          searchField,
          const SizedBox(height: AppSpacing.sm),
          SizedBox(width: double.infinity, child: statusSegment),
        ] else
          Row(
            children: [
              Expanded(flex: 3, child: searchField),
              const SizedBox(width: 12),
              statusSegment,
            ],
          ),
        const SizedBox(height: 12),
        // Bottom Row: Advanced Filters
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Super Admin Organization Filter
              if (isSuperAdmin) ...[
                Consumer(builder: (context, ref, _) {
                  final orgsAsync = ref.watch(parentOrgsProvider);
                  return orgsAsync.when(
                    data: (orgs) => _DropdownFilter(
                      label: 'Organization',
                      value: filter.organizationId,
                      items: {
                        for (var o in orgs) o.id!: o.name,
                      },
                      onChanged: (id) => onFilterChanged(filter.copyWith(
                          organizationId: id,
                          clearOrganization: id == null,
                          clearTeam: true)),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  );
                }),
                const SizedBox(width: 8),
              ],

              // Team Filter (Contextual)
              if ((isSuperAdmin && filter.organizationId != null) || isOrgAdmin) ...[
                Consumer(builder: (context, ref, _) {
                  final parentId = isOrgAdmin 
                      ? ref.watch(authProvider).appUser?.organizations?.firstOrNull?.organizationId 
                      : filter.organizationId;
                      
                  if (parentId == null) return const SizedBox.shrink();
                  
                  final teamsAsync = ref.watch(teamsByParentProvider(parentId));
                  return teamsAsync.when(
                    data: (teams) => _DropdownFilter(
                      label: 'Team',
                      value: filter.teamId,
                      items: {
                        for (var t in teams) t.id!: t.name,
                      },
                      onChanged: (id) => onFilterChanged(
                          filter.copyWith(teamId: id, clearTeam: id == null)),
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  );
                }),
                const SizedBox(width: 8),
              ],

              // Clear All
              if (filter.hasActiveFilters)
                TextButton.icon(
                  onPressed: () {
                    searchController.clear();
                    onFilterChanged(TrainingHistoryFilter());
                  },
                  icon: const Icon(Icons.filter_alt_off_rounded, size: 14),
                  label: const Text('Clear All'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.onSurfaceMuted,
                    textStyle: AppTextStyles.bodyXs
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CompactFilterChip extends StatelessWidget {
  const _CompactFilterChip({
    required this.label,
    required this.icon,
    this.onTap,
    this.isActive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return _buildContent();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.divider.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 14,
              color: isActive ? AppColors.primary : AppColors.onSurfaceSubtle),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.bodyXs.copyWith(
              color: isActive ? AppColors.primary : AppColors.onSurfaceSubtle,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.arrow_drop_down_rounded,
              size: 16,
              color: isActive ? AppColors.primary : AppColors.onSurfaceMuted),
        ],
      ),
    );
  }
}

class _DropdownFilter extends StatelessWidget {
  const _DropdownFilter({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final Map<int, String> items;
  final Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    final selectedName = value != null ? items[value] : null;

    return PopupMenuButton<int?>(
      onSelected: onChanged,
      itemBuilder: (context) => [
        PopupMenuItem<int?>(
            value: null,
            child: Text('All ${label}s', style: AppTextStyles.labelMd)),
        const PopupMenuDivider(),
        ...items.entries.map((e) => PopupMenuItem<int?>(
              value: e.key,
              child: Text(e.value, style: AppTextStyles.bodySm),
            )),
      ],
      child: _CompactFilterChip(
        label: selectedName ?? label,
        icon: Icons.filter_list_rounded,
        isActive: value != null,
        onTap: null, // Allow PopupMenuButton to handle the tap
      ),
    );
  }
}

class _SessionRecordCard extends StatefulWidget {
  const _SessionRecordCard({
    required this.result,
    required this.passingPercentage,
    required this.role,
    this.searchQuery,
  });

  final TrainingSessionResult result;
  final int passingPercentage;
  final Role? role;
  final String? searchQuery;

  @override
  State<_SessionRecordCard> createState() => _SessionRecordCardState();
}

class _SessionRecordCardState extends State<_SessionRecordCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final passed = result.overallPercentage >= widget.passingPercentage;
    final color = passed ? AppColors.success : AppColors.error;
    final name = result.appUser?.userInfo?.userName ?? 'Unknown User';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isExpanded
            ? AppColors.surfaceVariant.withValues(alpha: 0.5)
            : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: _isExpanded ? AppColors.primary : Colors.transparent,
            width: 3,
          ),
          bottom: const BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.cardPadding, vertical: 12),
              child: Row(
                children: [
                  // User Avatar
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initial,
                        style: AppTextStyles.labelMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Main Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: AppTextStyles.labelLg),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.business_center_rounded,
                                size: 12, color: AppColors.onSurfaceMuted),
                            const SizedBox(width: 4),
                            Text(
                              widget.role == Role.SuperAdmin
                                  ? (result.organization?.name ?? 'Unknown Org')
                                  : (result.organization?.parentId != null
                                      ? (result.organization?.name ??
                                          'Team Access')
                                      : (result.organization?.name ??
                                          'Organization')),
                              style: AppTextStyles.bodyXs
                                  .copyWith(color: AppColors.onSurfaceMuted),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Result Score & Status Icon
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${result.overallPercentage}%',
                        style: AppTextStyles.labelMd.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Icon(
                        passed
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        size: 16,
                        color: color.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.25 : 0,
                    child: Icon(Icons.chevron_right_rounded,
                        color: AppColors.onSurfaceSubtle, size: 20),
                  ),
                ],
              ),
            ),
          ),

          // Expanded Details
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.cardPadding + 56, // Align with text
                0,
                AppSpacing.cardPadding,
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 24),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 14, color: AppColors.onSurfaceSubtle),
                      const SizedBox(width: 6),
                      Text(
                        'Completed on ${DateFormat('MMMM d, y • h:mm a').format(result.completedAt.toLocal())}',
                        style: AppTextStyles.bodyXs
                            .copyWith(color: AppColors.onSurfaceSubtle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('CRITERIA BREAKDOWN',
                      style: AppTextStyles.labelSm.copyWith(
                          letterSpacing: 0.5, color: AppColors.onSurfaceMuted)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: TrainingCriteriaBarChart(result: result),
                  ),
                  const SizedBox(height: 16),
                  if (passed)
                    _CertificateButton(
                      result: result,
                      recipientName: name,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _UserTrainingCard extends ConsumerStatefulWidget {
  const _UserTrainingCard({
    required this.summary,
    required this.passingPercentage,
    this.searchQuery,
  });

  final TrainingUserSummary summary;
  final int passingPercentage;
  final String? searchQuery;

  @override
  ConsumerState<_UserTrainingCard> createState() => _UserTrainingCardState();
}

class _UserTrainingCardState extends ConsumerState<_UserTrainingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.summary.user;
    final latest = widget.summary.latestResult;
    final name = user.userInfo?.userName ?? 'Unknown User';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    // Result styling
    final passed = (latest?.overallPercentage ?? 0) >= widget.passingPercentage;
    final scoreColor = passed ? AppColors.success : AppColors.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
        color: _isExpanded
            ? AppColors.surfaceVariant.withValues(alpha: 0.4)
            : Colors.transparent,
        border: Border(
          left: BorderSide(
            color: _isExpanded ? AppColors.primary : Colors.transparent,
            width: 3,
          ),
          bottom: const BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.cardPadding, vertical: 14),
              child: Row(
                children: [
                  // User Avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        initial,
                        style: AppTextStyles.labelLg.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Main User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHighlightedText(
                            name, widget.searchQuery, AppTextStyles.labelLg),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.business_rounded,
                                size: 12, color: AppColors.onSurfaceSubtle),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                widget.summary.parentOrg?.name ??
                                    (widget.summary.parentOrg == null
                                        ? widget.summary.team.name
                                        : 'Unknown Org'),
                                style: AppTextStyles.bodyXs
                                    .copyWith(color: AppColors.onSurfaceSubtle),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (widget.summary.parentOrg != null) ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Container(
                                    width: 3,
                                    height: 3,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.divider)),
                              ),
                              Icon(Icons.groups_rounded,
                                  size: 12, color: AppColors.onSurfaceSubtle),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  widget.summary.team.name,
                                  style: AppTextStyles.bodyXs.copyWith(
                                      color: AppColors.onSurfaceSubtle),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Latest Score Summary
                  if (latest != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${latest.overallPercentage}%',
                              style: AppTextStyles.labelLg.copyWith(
                                  color: scoreColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              passed
                                  ? Icons.check_circle_rounded
                                  : Icons.cancel_rounded,
                              size: 16,
                              color: scoreColor.withValues(alpha: 0.8),
                            ),
                          ],
                        ),
                        Text(
                          '${widget.summary.totalSessions} attempts',
                          style: AppTextStyles.bodyXs
                              .copyWith(color: AppColors.onSurfaceMuted),
                        ),
                      ],
                    )
                  else
                    Text('No data',
                        style: AppTextStyles.bodyXs
                            .copyWith(color: AppColors.onSurfaceMuted)),

                  const SizedBox(width: 16),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 200),
                    turns: _isExpanded ? 0.25 : 0,
                    child: Icon(Icons.chevron_right_rounded,
                        color: AppColors.onSurfaceMuted, size: 20),
                  ),
                ],
              ),
            ),
          ),

          // Expanded History View
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 24),
              child: Consumer(
                builder: (context, ref, child) {
                  final historyAsync =
                      ref.watch(userSpecificTrainingHistoryProvider(user.id!));

                  return historyAsync.when(
                    data: (results) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                              color: AppColors.divider.withValues(alpha: 0.5)),
                        ),
                        child: TrainingHistoryPanel(
                          results: results,
                          passingPercentage: widget.passingPercentage,
                          recipientName: name,
                        ),
                      ),
                    ),
                    loading: () => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    error: (err, __) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                          child: Text('Failed to load history',
                              style: AppTextStyles.bodyXs
                                  .copyWith(color: AppColors.error))),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildHighlightedText(String text, String? query, TextStyle style) {
  if (query == null ||
      query.isEmpty ||
      !text.toLowerCase().contains(query.toLowerCase())) {
    return Text(text, style: style);
  }

  final matches = query.toLowerCase().allMatches(text.toLowerCase()).toList();
  if (matches.isEmpty) return Text(text, style: style);

  final List<TextSpan> spans = [];
  int lastIndex = 0;

  for (final match in matches) {
    if (match.start > lastIndex) {
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
    }
    spans.add(TextSpan(
      text: text.substring(match.start, match.end),
      style: TextStyle(
        backgroundColor: AppColors.training.withValues(alpha: 0.2),
        fontWeight: FontWeight.bold,
      ),
    ));
    lastIndex = match.end;
  }

  if (lastIndex < text.length) {
    spans.add(TextSpan(text: text.substring(lastIndex)));
  }

  return Text.rich(
    TextSpan(children: spans),
    style: style,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

class _CertificateButton extends ConsumerWidget {
  const _CertificateButton({
    required this.result,
    required this.recipientName,
  });

  final TrainingSessionResult result;
  final String recipientName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppGradientButton(
      label: 'View Certificate',
      icon: Icons.workspace_premium_rounded,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => CertificatePreviewDialog(
            recipientName: recipientName,
            courseTitle: 'FireSafeX Training Completion',
            organizationName: result.organization?.name ?? 'Mako',
            date: result.completedAt,
            logoImage: 'assets/images/logo.png',
            overallPercentage: result.overallPercentage,
          ),
        );
      },
    );
  }
}
