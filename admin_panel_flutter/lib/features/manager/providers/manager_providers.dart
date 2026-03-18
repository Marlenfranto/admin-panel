import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../src/providers.dart';

/// All organizations this manager manages.
final managedOrganizationsProvider =
    FutureProvider<List<Organization>>((ref) async {
  return ref.watch(clientProvider).manager.getManagedOrganizations();
});

/// The org ID the manager has explicitly selected. Null = auto (use first).
final selectedOrgIdProvider = StateProvider<int?>((ref) => null);

/// The resolved active org ID — selected or first from list.
final activeOrgIdProvider = Provider<int?>((ref) {
  final selected = ref.watch(selectedOrgIdProvider);
  if (selected != null) return selected;
  final orgs = ref.watch(managedOrganizationsProvider).value;
  return orgs?.isNotEmpty == true ? orgs!.first.id : null;
});

/// The resolved active Organization object (with users loaded).
final activeOrgProvider = Provider<Organization?>((ref) {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return null;
  final orgs = ref.watch(managedOrganizationsProvider).value ?? [];
  try {
    return orgs.firstWhere((o) => o.id == orgId);
  } catch (_) {
    return orgs.isNotEmpty ? orgs.first : null;
  }
});

/// Backwards-compat alias used by manager_team_screen.
final managedOrganizationProvider = FutureProvider<Organization?>((ref) async {
  final orgs = await ref.watch(managedOrganizationsProvider.future);
  if (orgs.isEmpty) return null;
  final selectedId = ref.watch(selectedOrgIdProvider);
  if (selectedId != null) {
    try {
      return orgs.firstWhere((o) => o.id == selectedId);
    } catch (_) {}
  }
  return orgs.first;
});

final managerModuleConfigProvider = FutureProvider<ModuleConfig?>((ref) async {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return null;
  return ref.watch(clientProvider).manager.getMyModuleConfig(orgId);
});

final managerTheoryProvider = FutureProvider<List<TheoryChapter>>((ref) async {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return [];
  return ref.watch(clientProvider).manager.getTheoryChapters(orgId);
});

final managerTrainingProvider =
    FutureProvider<List<TrainingParameter>>((ref) async {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return [];
  return ref.watch(clientProvider).manager.getTrainingParameters(orgId);
});

final managerAssessmentProvider =
    FutureProvider<List<AssessmentParameter>>((ref) async {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return [];
  return ref.watch(clientProvider).manager.getAssessmentParameters(orgId);
});

final managerAssetsProvider = FutureProvider<List<Asset>>((ref) async {
  final orgId = ref.watch(activeOrgIdProvider);
  if (orgId == null) return [];
  return ref.watch(clientProvider).manager.getAssets(orgId);
});
