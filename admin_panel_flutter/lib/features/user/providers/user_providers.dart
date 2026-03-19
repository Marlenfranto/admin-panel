import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../src/providers.dart';

final userModuleConfigProvider = FutureProvider<ModuleConfig?>((ref) async {
  return ref.watch(clientProvider).user.getMyOrgModuleConfig();
});

final userModuleProgressProvider =
    FutureProvider<List<UserModuleProgress>>((ref) async {
  return ref.watch(clientProvider).user.getMyModuleProgress();
});

final userTrainingHistoryProvider =
    FutureProvider<List<TrainingSessionResult>>((ref) async {
  return ref.watch(clientProvider).user.getMyTrainingHistory();
});
