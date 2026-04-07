import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/providers.dart';

// ── Organization ──────────────────────────────────────────────────────────────

/// All organizations and teams from the server (unfiltered).
final allOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  return ref.watch(clientProvider).admin.getAllOrganizations();
});

/// Only top-level organizations (parentId == null).
final parentOrgsProvider = FutureProvider<List<Organization>>((ref) async {
  final orgs = await ref.watch(allOrganizationsProvider.future);
  return orgs.where((o) => o.parentId == null).toList();
});

/// Teams for a specific organization.
final teamsByParentProvider = FutureProvider.family<List<Organization>, int>((ref, parentId) async {
  final orgs = await ref.watch(allOrganizationsProvider.future);
  return orgs.where((o) => o.parentId == parentId).toList();
});

/// Only teams (child organizations where parentId != null).
final allTeamsProvider = FutureProvider<List<Organization>>((ref) async {
  final orgs = await ref.watch(allOrganizationsProvider.future);
  return orgs.where((o) => o.parentId != null).toList();
});

// ── Users ─────────────────────────────────────────────────────────────────────
final allUsersProvider = FutureProvider<List<AppUser>>((ref) async {
  return ref.watch(clientProvider).admin.getAllUsers();
});

// ── Module config (per org) ───────────────────────────────────────────────────
final moduleConfigProvider =
    FutureProvider.family<ModuleConfig?, int>((ref, orgId) async {
  return ref.watch(clientProvider).admin.getModuleConfig(orgId);
});

// ── User module progress (per org + user) ────────────────────────────────────
final adminUserModuleProgressProvider =
    FutureProvider.family<List<UserModuleProgress>, (int orgId, int userId)>(
        (ref, args) async {
  final (orgId, userId) = args;
  return ref.watch(clientProvider).admin.getUserModuleProgress(userId, orgId);
});

// ── Training history (per user) ───────────────────────────────────────────────
final adminTrainingHistoryProvider =
    FutureProvider.family<List<TrainingSessionResult>, int>((ref, appUserId) async {
  return ref.watch(clientProvider).admin.getUserTrainingHistory(appUserId);
});

// ── Content providers (per org) ───────────────────────────────────────────────
final adminTheoryProvider =
    FutureProvider.family<List<TheoryChapter>, int>((ref, orgId) =>
        ref.watch(clientProvider).admin.getTheoryChapters(orgId));

final adminTrainingProvider =
    FutureProvider.family<List<TrainingParameter>, int>((ref, orgId) =>
        ref.watch(clientProvider).admin.getTrainingParameters(orgId));

final adminAssessmentProvider =
    FutureProvider.family<List<AssessmentParameter>, int>((ref, orgId) =>
        ref.watch(clientProvider).admin.getAssessmentParameters(orgId));

final adminAssetsProvider =
    FutureProvider.family<List<Asset>, int>((ref, orgId) =>
        ref.watch(clientProvider).admin.getAssets(orgId));
