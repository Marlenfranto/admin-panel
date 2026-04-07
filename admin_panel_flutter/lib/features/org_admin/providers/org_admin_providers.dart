import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../src/providers.dart';

/// The top-level organization managed by the current Org Admin.
final myOrganizationProvider = FutureProvider<Organization?>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getMyOrganization();
});

/// All teams (child organizations) within the Org Admin's organization.
final orgTeamsProvider = FutureProvider<List<Organization>>((ref) async {
  final myOrg = await ref.watch(myOrganizationProvider.future);
  if (myOrg == null || myOrg.id == null) return [];
  return ref.watch(clientProvider).organizationAdmin.getTeams(myOrg.id!);
});

/// Selection for the active team being viewed/edited.
final selectedTeamIdProvider = StateProvider<int?>((ref) => null);

/// The resolved active Team object.
final activeTeamProvider = Provider<Organization?>((ref) {
  final teamId = ref.watch(selectedTeamIdProvider);
  if (teamId == null) return null;
  final teams = ref.watch(orgTeamsProvider).value ?? [];
  try {
    return teams.firstWhere((t) => t.id == teamId);
  } catch (_) {
    return teams.isNotEmpty ? teams.first : null;
  }
});

/// All users across the org admin's organization and its teams, deduplicated.
final orgUsersProvider = FutureProvider<List<AppUser>>((ref) async {
  final myOrg = await ref.watch(myOrganizationProvider.future);
  final teams = await ref.watch(orgTeamsProvider.future);

  final seen  = <int>{};
  final users = <AppUser>[];

  for (final link in myOrg?.users ?? []) {
    final u = link.appUser;
    if (u?.id != null && seen.add(u!.id!)) users.add(u);
  }

  for (final team in teams) {
    for (final link in team.users ?? []) {
      final u = link.appUser;
      if (u?.id != null && seen.add(u!.id!)) users.add(u);
    }
  }

  return users;
});

/// Managers within this org (derived from orgUsersProvider — no admin call needed).
final orgManagersProvider = Provider<List<AppUser>>((ref) {
  return (ref.watch(orgUsersProvider).value ?? [])
      .where((u) => u.role == Role.Manager)
      .toList();
});

// ── Module config ─────────────────────────────────────────────────────────────

final orgModuleConfigProvider = FutureProvider<ModuleConfig?>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getModuleConfig();
});

// ── Content providers ─────────────────────────────────────────────────────────

final orgTheoryProvider = FutureProvider<List<TheoryChapter>>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getOrgTheoryChapters();
});

final orgTrainingProvider = FutureProvider<List<TrainingParameter>>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getOrgTrainingParameters();
});

final orgAssessmentProvider =
    FutureProvider<List<AssessmentParameter>>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getOrgAssessmentParameters();
});

final orgAssetsProvider = FutureProvider<List<Asset>>((ref) async {
  return ref.watch(clientProvider).organizationAdmin.getOrgAssets();
});
