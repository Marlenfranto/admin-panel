import 'dart:async';
import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../src/providers.dart';

class TrainingHistoryFilter {
  final int? organizationId;
  final int? teamId;
  final String? search;
  final DateTime? start;
  final DateTime? end;
  final bool? passed;

  TrainingHistoryFilter({
    this.organizationId,
    this.teamId,
    this.search,
    this.start,
    this.end,
    this.passed,
  });

  TrainingHistoryFilter copyWith({
    int? organizationId,
    int? teamId,
    String? search,
    DateTime? start,
    DateTime? end,
    bool? passed,
    bool clearOrganization = false,
    bool clearTeam = false,
    bool clearSearch = false,
    bool clearDates = false,
    bool clearStatus = false,
  }) {
    return TrainingHistoryFilter(
      organizationId: clearOrganization ? null : (organizationId ?? this.organizationId),
      teamId: clearTeam ? null : (teamId ?? this.teamId),
      search: clearSearch ? null : (search ?? this.search),
      start: clearDates ? null : (start ?? this.start),
      end: clearDates ? null : (end ?? this.end),
      passed: clearStatus ? null : (passed ?? this.passed),
    );
  }

  bool get hasActiveFilters => search != null || organizationId != null || teamId != null || start != null || end != null || passed != null;
}

class TrainingHistoryState {
  final List<TrainingSessionResult> results;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final TrainingHistoryFilter filter;
  final int totalCount;

  TrainingHistoryState({
    required this.results,
    required this.page,
    required this.hasMore,
    required this.isLoadingMore,
    required this.filter,
    required this.totalCount,
  });

  TrainingHistoryState copyWith({
    List<TrainingSessionResult>? results,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    TrainingHistoryFilter? filter,
    int? totalCount,
  }) {
    return TrainingHistoryState(
      results: results ?? this.results,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      filter: filter ?? this.filter,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class TrainingUserSummaryState {
  final List<TrainingUserSummary> summaries;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final TrainingHistoryFilter filter;
  final int totalCount;

  TrainingUserSummaryState({
    required this.summaries,
    required this.page,
    required this.hasMore,
    required this.isLoadingMore,
    required this.filter,
    required this.totalCount,
  });

  TrainingUserSummaryState copyWith({
    List<TrainingUserSummary>? summaries,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    TrainingHistoryFilter? filter,
    int? totalCount,
  }) {
    return TrainingUserSummaryState(
      summaries: summaries ?? this.summaries,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      filter: filter ?? this.filter,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class TrainingHistoryNotifier extends StateNotifier<AsyncValue<TrainingHistoryState>> {
  final Ref ref;
  
  TrainingHistoryNotifier(this.ref) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, TrainingHistoryFilter()));
    if (mounted) state = value;
  }

  Future<TrainingHistoryState> _fetchPage(int page, TrainingHistoryFilter filter) async {
    final client = ref.read(clientProvider);
    final auth = ref.read(authProvider);
    final role = auth.appUser?.role;

    TrainingSessionResultPage resultPage;

    if (role == Role.SuperAdmin) {
      resultPage = await client.admin.getTrainingHistory(
        page: page,
        limit: 20,
        search: filter.search,
        organizationId: filter.organizationId,
        teamId: filter.teamId,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else if (role == Role.OrganizationAdmin) {
      resultPage = await client.organizationAdmin.getTrainingHistory(
        page: page,
        limit: 20,
        search: filter.search,
        teamId: filter.teamId,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else if (role == Role.Manager) {
      resultPage = await client.manager.getTrainingHistory(
        page: page,
        limit: 20,
        search: filter.search,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else {
      throw Exception('Unauthorized access.');
    }

    return TrainingHistoryState(
      results: resultPage.results,
      page: page,
      hasMore: resultPage.hasMore,
      isLoadingMore: false,
      filter: filter,
      totalCount: resultPage.totalCount,
    );
  }

  Future<void> fetchNextPage() async {
    final currentVal = state.value;
    if (currentVal == null || !currentVal.hasMore || currentVal.isLoadingMore) return;

    state = AsyncValue.data(currentVal.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentVal.page + 1;
      final nextState = await _fetchPage(nextPage, currentVal.filter);
      
      if (mounted) {
        state = AsyncValue.data(currentVal.copyWith(
          results: [...currentVal.results, ...nextState.results],
          page: nextPage,
          hasMore: nextState.hasMore,
          isLoadingMore: false,
        ));
      }
    } catch (e, st) {
      if (mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSearch(String? search) async {
    final currentState = state.value;
    if (currentState == null) return;
    
    final newFilter = currentState.filter.copyWith(search: search, clearSearch: search == null);
    updateFilter(newFilter);
  }

  Future<void> updateFilter(TrainingHistoryFilter newFilter) async {
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, newFilter));
    if (mounted) state = value;
  }

  Future<void> refresh() async {
    final currentState = state.value;
    if (currentState == null) return;
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, currentState.filter));
    if (mounted) state = value;
  }
}

final trainingHistoryProvider = StateNotifierProvider.autoDispose<TrainingHistoryNotifier, AsyncValue<TrainingHistoryState>>((ref) {
  return TrainingHistoryNotifier(ref);
});

class TrainingUserSummaryNotifier extends StateNotifier<AsyncValue<TrainingUserSummaryState>> {
  final Ref ref;

  TrainingUserSummaryNotifier(this.ref) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, TrainingHistoryFilter()));
    if (mounted) state = value;
  }

  Future<TrainingUserSummaryState> _fetchPage(int page, TrainingHistoryFilter filter) async {
    final client = ref.read(clientProvider);
    final auth = ref.read(authProvider);
    final role = auth.appUser?.role;

    final TrainingUserSummaryPage resultPage;
    if (role == Role.SuperAdmin) {
      resultPage = await client.admin.getTrainingUserSummaries(
        page: page,
        limit: 20,
        search: filter.search,
        organizationId: filter.organizationId,
        teamId: filter.teamId,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else if (role == Role.OrganizationAdmin) {
      resultPage = await client.organizationAdmin.getTrainingUserSummaries(
        page: page,
        limit: 20,
        search: filter.search,
        teamId: filter.teamId,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else if (role == Role.Manager) {
      resultPage = await client.manager.getTrainingUserSummaries(
        page: page,
        limit: 20,
        search: filter.search,
        start: filter.start,
        end: filter.end,
        passed: filter.passed,
      );
    } else {
      throw Exception('Grouping by user is not available for your role.');
    }

    return TrainingUserSummaryState(
      summaries: resultPage.summaries,
      page: page,
      hasMore: resultPage.hasMore,
      isLoadingMore: false,
      filter: filter,
      totalCount: resultPage.totalCount,
    );
  }

  Future<void> fetchNextPage() async {
    final currentVal = state.value;
    if (currentVal == null || !currentVal.hasMore || currentVal.isLoadingMore) return;

    state = AsyncValue.data(currentVal.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentVal.page + 1;
      final nextState = await _fetchPage(nextPage, currentVal.filter);

      if (mounted) {
        state = AsyncValue.data(currentVal.copyWith(
          summaries: [...currentVal.summaries, ...nextState.summaries],
          page: nextPage,
          hasMore: nextState.hasMore,
          isLoadingMore: false,
        ));
      }
    } catch (e, st) {
      if (mounted) state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSearch(String? search) async {
    final currentState = state.value;
    if (currentState == null) return;
    final newFilter = currentState.filter.copyWith(search: search, clearSearch: search == null);
    updateFilter(newFilter);
  }

  Future<void> updateFilter(TrainingHistoryFilter newFilter) async {
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, newFilter));
    if (mounted) state = value;
  }

  Future<void> refresh() async {
    final currentState = state.value;
    if (currentState == null) return;
    state = const AsyncValue.loading();
    final value = await AsyncValue.guard(() => _fetchPage(1, currentState.filter));
    if (mounted) state = value;
  }
}

final trainingUserSummariesProvider = StateNotifierProvider.autoDispose<TrainingUserSummaryNotifier, AsyncValue<TrainingUserSummaryState>>((ref) {
  return TrainingUserSummaryNotifier(ref);
});

/// A specific user's training results provider.
final userSpecificTrainingHistoryProvider = FutureProvider.family<List<TrainingSessionResult>, int>((ref, userId) async {
  final client = ref.read(clientProvider);
  final auth = ref.read(authProvider);
  final role = auth.appUser?.role;

  if (role == Role.SuperAdmin) {
    return await client.admin.getUserTrainingHistory(userId);
  } else if (role == Role.OrganizationAdmin) {
    return await client.organizationAdmin.getUserTrainingHistory(userId);
  } else {
    // For Managers, we need an organizationId. 
    // We'll try to find an organization they manage.
    final managedOrgs = await client.manager.getManagedOrganizations();
    if (managedOrgs.isEmpty) return [];
    
    // Use the first managed org as a default for fetching history.
    return await client.manager.getUserTrainingHistory(userId, managedOrgs.first.id!);
  }
});
