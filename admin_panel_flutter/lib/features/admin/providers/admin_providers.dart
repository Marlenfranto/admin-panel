import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/providers.dart';

// ── Organization ──────────────────────────────────────────────────────────────
final allOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  return ref.watch(clientProvider).admin.getAllOrganizations();
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
