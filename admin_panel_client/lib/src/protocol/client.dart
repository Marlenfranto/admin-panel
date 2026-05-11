/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i3;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i4;
import 'package:admin_panel_client/src/protocol/role.dart' as _i5;
import 'package:admin_panel_client/src/protocol/module_config.dart' as _i6;
import 'package:admin_panel_client/src/protocol/supported_language.dart' as _i7;
import 'package:admin_panel_client/src/protocol/localized_ai_prompt.dart'
    as _i8;
import 'package:admin_panel_client/src/protocol/theory_chapter.dart' as _i9;
import 'package:admin_panel_client/src/protocol/training_parameter.dart'
    as _i10;
import 'package:admin_panel_client/src/protocol/assessment_parameter.dart'
    as _i11;
import 'package:admin_panel_client/src/protocol/asset.dart' as _i12;
import 'package:admin_panel_client/src/protocol/user_module_progress.dart'
    as _i13;
import 'package:admin_panel_client/src/protocol/training_session_result_page.dart'
    as _i14;
import 'package:admin_panel_client/src/protocol/training_user_summary_page.dart'
    as _i15;
import 'package:admin_panel_client/src/protocol/training_session_result.dart'
    as _i16;
import 'package:admin_panel_client/src/protocol/module_progress_status.dart'
    as _i17;
import 'package:admin_panel_client/src/protocol/manager_notification_detail.dart'
    as _i18;
import 'package:admin_panel_client/src/protocol/login_response.dart' as _i19;
import 'package:admin_panel_client/src/protocol/training_criteria_score.dart'
    as _i20;
import 'package:admin_panel_client/src/protocol/theory_chapter_with_progress.dart'
    as _i21;
import 'package:admin_panel_client/src/protocol/user_theory_progress.dart'
    as _i22;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i23;
import 'protocol.dart' as _i24;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.Organization?> createOrganization(
    String name,
    String? imageUrl,
  ) => caller.callServerEndpoint<_i3.Organization?>(
    'admin',
    'createOrganization',
    {
      'name': name,
      'imageUrl': imageUrl,
    },
  );

  _i2.Future<_i4.AppUser?> createUserAndAssignToOrg(
    String userName,
    String email,
    String password,
    _i5.Role role,
    int organizationId,
  ) => caller.callServerEndpoint<_i4.AppUser?>(
    'admin',
    'createUserAndAssignToOrg',
    {
      'userName': userName,
      'email': email,
      'password': password,
      'role': role,
      'organizationId': organizationId,
    },
  );

  _i2.Future<bool> assignManagerToOrg(
    int managerAppUserId,
    int organizationId,
  ) => caller.callServerEndpoint<bool>(
    'admin',
    'assignManagerToOrg',
    {
      'managerAppUserId': managerAppUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i3.Organization?> updateOrganization(
    int id,
    String name,
    String? imageUrl,
  ) => caller.callServerEndpoint<_i3.Organization?>(
    'admin',
    'updateOrganization',
    {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    },
  );

  _i2.Future<bool> deleteOrganization(int id) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteOrganization',
        {'id': id},
      );

  _i2.Future<List<_i3.Organization>> getAllOrganizations() =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'admin',
        'getAllOrganizations',
        {},
      );

  _i2.Future<bool> updateUser(
    int appUserId,
    String userName,
    _i5.Role role,
  ) => caller.callServerEndpoint<bool>(
    'admin',
    'updateUser',
    {
      'appUserId': appUserId,
      'userName': userName,
      'role': role,
    },
  );

  _i2.Future<bool> updateOrgAdminUser(
    int appUserId,
    String userName,
    _i5.Role role,
  ) => caller.callServerEndpoint<bool>(
    'admin',
    'updateOrgAdminUser',
    {
      'appUserId': appUserId,
      'userName': userName,
      'role': role,
    },
  );

  _i2.Future<bool> adminResetUserPassword(
    int appUserId,
    String newPassword,
  ) => caller.callServerEndpoint<bool>(
    'admin',
    'adminResetUserPassword',
    {
      'appUserId': appUserId,
      'newPassword': newPassword,
    },
  );

  _i2.Future<bool> deleteUser(int appUserId) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteUser',
    {'appUserId': appUserId},
  );

  _i2.Future<List<_i4.AppUser>> getAllUsers({_i5.Role? role}) =>
      caller.callServerEndpoint<List<_i4.AppUser>>(
        'admin',
        'getAllUsers',
        {'role': role},
      );

  _i2.Future<_i6.ModuleConfig> setModuleConfig(
    int organizationId,
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String defaultLanguage,
    List<_i7.SupportedLanguage> supportedLanguages,
    String? aiChatPrompt,
    List<_i8.LocalizedAiPrompt>? aiChatPromptTranslations,
    int passingPercentage,
  ) => caller.callServerEndpoint<_i6.ModuleConfig>(
    'admin',
    'setModuleConfig',
    {
      'organizationId': organizationId,
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'defaultLanguage': defaultLanguage,
      'supportedLanguages': supportedLanguages,
      'aiChatPrompt': aiChatPrompt,
      'aiChatPromptTranslations': aiChatPromptTranslations,
      'passingPercentage': passingPercentage,
    },
  );

  _i2.Future<_i6.ModuleConfig?> getModuleConfig(int organizationId) =>
      caller.callServerEndpoint<_i6.ModuleConfig?>(
        'admin',
        'getModuleConfig',
        {'organizationId': organizationId},
      );

  _i2.Future<List<_i9.TheoryChapter>> getTheoryChapters(int organizationId) =>
      caller.callServerEndpoint<List<_i9.TheoryChapter>>(
        'admin',
        'getTheoryChapters',
        {'organizationId': organizationId},
      );

  _i2.Future<_i9.TheoryChapter> upsertTheoryChapter(
    _i9.TheoryChapter chapter,
  ) => caller.callServerEndpoint<_i9.TheoryChapter>(
    'admin',
    'upsertTheoryChapter',
    {'chapter': chapter},
  );

  _i2.Future<bool> deleteTheoryChapter(int chapterId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteTheoryChapter',
        {'chapterId': chapterId},
      );

  _i2.Future<List<_i10.TrainingParameter>> getTrainingParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'admin',
    'getTrainingParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i10.TrainingParameter> upsertTrainingParameter(
    _i10.TrainingParameter param,
  ) => caller.callServerEndpoint<_i10.TrainingParameter>(
    'admin',
    'upsertTrainingParameter',
    {'param': param},
  );

  _i2.Future<bool> deleteTrainingParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteTrainingParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i11.AssessmentParameter>> getAssessmentParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'admin',
    'getAssessmentParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i11.AssessmentParameter> upsertAssessmentParameter(
    _i11.AssessmentParameter param,
  ) => caller.callServerEndpoint<_i11.AssessmentParameter>(
    'admin',
    'upsertAssessmentParameter',
    {'param': param},
  );

  _i2.Future<bool> deleteAssessmentParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteAssessmentParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i12.Asset>> getAssets(int organizationId) =>
      caller.callServerEndpoint<List<_i12.Asset>>(
        'admin',
        'getAssets',
        {'organizationId': organizationId},
      );

  _i2.Future<_i12.Asset> upsertAsset(_i12.Asset asset) =>
      caller.callServerEndpoint<_i12.Asset>(
        'admin',
        'upsertAsset',
        {'asset': asset},
      );

  _i2.Future<bool> deleteAsset(int assetId) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteAsset',
    {'assetId': assetId},
  );

  _i2.Future<List<_i13.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i13.UserModuleProgress>>(
    'admin',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i13.UserModuleProgress> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress>(
    'admin',
    'setUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      'deadline': deadline,
    },
  );

  /// Returns paginated and filtered Smart Training results for Super Admins.
  _i2.Future<_i14.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i14.TrainingSessionResultPage>(
    'admin',
    'getTrainingHistory',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'organizationId': organizationId,
      'teamId': teamId,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  /// Returns paginated unique users who have smart training results, grouped by user.
  _i2.Future<_i15.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i15.TrainingUserSummaryPage>(
    'admin',
    'getTrainingUserSummaries',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'organizationId': organizationId,
      'teamId': teamId,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  /// Returns all Smart Training results for [appUserId] across all orgs.
  _i2.Future<List<_i16.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
  ) => caller.callServerEndpoint<List<_i16.TrainingSessionResult>>(
    'admin',
    'getUserTrainingHistory',
    {'appUserId': appUserId},
  );

  _i2.Future<_i13.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i17.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'admin',
    'updateUserModuleStatus',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'status': status,
      'startedAt': startedAt,
      'completedAt': completedAt,
    },
  );
}

/// {@category Endpoint}
class EndpointManager extends _i1.EndpointRef {
  EndpointManager(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'manager';

  _i2.Future<_i3.Organization?> getManagedOrganization() =>
      caller.callServerEndpoint<_i3.Organization?>(
        'manager',
        'getManagedOrganization',
        {},
      );

  _i2.Future<List<_i3.Organization>> getManagedOrganizations() =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'manager',
        'getManagedOrganizations',
        {},
      );

  _i2.Future<_i4.AppUser?> createUserAndAssignToOrg(
    String userName,
    String email,
    String password,
    _i5.Role role,
    int organizationId,
  ) => caller.callServerEndpoint<_i4.AppUser?>(
    'manager',
    'createUserAndAssignToOrg',
    {
      'userName': userName,
      'email': email,
      'password': password,
      'role': role,
      'organizationId': organizationId,
    },
  );

  /// Returns all teams (child organizations) for a managed parent organization,
  /// including each team's users with their info.
  _i2.Future<List<_i3.Organization>> getTeams(int organizationId) =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'manager',
        'getTeams',
        {'organizationId': organizationId},
      );

  _i2.Future<bool> removeUserFromOrganization(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'removeUserFromOrganization',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i6.ModuleConfig?> getMyModuleConfig(int organizationId) =>
      caller.callServerEndpoint<_i6.ModuleConfig?>(
        'manager',
        'getMyModuleConfig',
        {'organizationId': organizationId},
      );

  _i2.Future<_i6.ModuleConfig?> updateMyModuleConfig(
    int organizationId,
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String? aiChatPrompt,
    int passingPercentage,
  ) => caller.callServerEndpoint<_i6.ModuleConfig?>(
    'manager',
    'updateMyModuleConfig',
    {
      'organizationId': organizationId,
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'aiChatPrompt': aiChatPrompt,
      'passingPercentage': passingPercentage,
    },
  );

  _i2.Future<List<_i9.TheoryChapter>> getTheoryChapters(int organizationId) =>
      caller.callServerEndpoint<List<_i9.TheoryChapter>>(
        'manager',
        'getTheoryChapters',
        {'organizationId': organizationId},
      );

  _i2.Future<_i9.TheoryChapter> upsertTheoryChapter(
    int organizationId,
    _i9.TheoryChapter chapter,
  ) => caller.callServerEndpoint<_i9.TheoryChapter>(
    'manager',
    'upsertTheoryChapter',
    {
      'organizationId': organizationId,
      'chapter': chapter,
    },
  );

  _i2.Future<bool> deleteTheoryChapter(int chapterId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'deleteTheoryChapter',
        {'chapterId': chapterId},
      );

  _i2.Future<List<_i10.TrainingParameter>> getTrainingParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'manager',
    'getTrainingParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i10.TrainingParameter> upsertTrainingParameter(
    int organizationId,
    _i10.TrainingParameter param,
  ) => caller.callServerEndpoint<_i10.TrainingParameter>(
    'manager',
    'upsertTrainingParameter',
    {
      'organizationId': organizationId,
      'param': param,
    },
  );

  _i2.Future<bool> deleteTrainingParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'deleteTrainingParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i11.AssessmentParameter>> getAssessmentParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'manager',
    'getAssessmentParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i11.AssessmentParameter> upsertAssessmentParameter(
    int organizationId,
    _i11.AssessmentParameter param,
  ) => caller.callServerEndpoint<_i11.AssessmentParameter>(
    'manager',
    'upsertAssessmentParameter',
    {
      'organizationId': organizationId,
      'param': param,
    },
  );

  _i2.Future<bool> deleteAssessmentParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'deleteAssessmentParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i12.Asset>> getAssets(int organizationId) =>
      caller.callServerEndpoint<List<_i12.Asset>>(
        'manager',
        'getAssets',
        {'organizationId': organizationId},
      );

  _i2.Future<_i12.Asset> upsertAsset(
    int organizationId,
    _i12.Asset asset,
  ) => caller.callServerEndpoint<_i12.Asset>(
    'manager',
    'upsertAsset',
    {
      'organizationId': organizationId,
      'asset': asset,
    },
  );

  _i2.Future<bool> deleteAsset(int assetId) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteAsset',
    {'assetId': assetId},
  );

  _i2.Future<List<_i13.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i13.UserModuleProgress>>(
    'manager',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i13.UserModuleProgress?> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'manager',
    'setUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      'deadline': deadline,
    },
  );

  _i2.Future<_i13.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i17.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'manager',
    'updateUserModuleStatus',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'status': status,
      'startedAt': startedAt,
      'completedAt': completedAt,
    },
  );

  /// Returns paginated and filtered Smart Training results for Managers.
  /// Returns paginated and filtered Smart Training results for Managers.
  _i2.Future<_i14.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i14.TrainingSessionResultPage>(
    'manager',
    'getTrainingHistory',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'organizationId': organizationId,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  /// Returns all Smart Training results for [appUserId] within this manager's org.
  _i2.Future<List<_i16.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i16.TrainingSessionResult>>(
    'manager',
    'getUserTrainingHistory',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  /// Returns paginated unique users who have smart training results, grouped by user,
  /// scoped to the teams managed by this manager.
  _i2.Future<_i15.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i15.TrainingUserSummaryPage>(
    'manager',
    'getTrainingUserSummaries',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  /// Returns notification details for [organizationId], auto-creating records
  /// for any overdue (deadline passed, not completed) progress entries.
  _i2.Future<List<_i18.ManagerNotificationDetail>> getNotifications(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i18.ManagerNotificationDetail>>(
    'manager',
    'getNotifications',
    {'organizationId': organizationId},
  );

  /// Returns the total number of unread notifications across all managed orgs.
  _i2.Future<int> getUnreadNotificationCount() =>
      caller.callServerEndpoint<int>(
        'manager',
        'getUnreadNotificationCount',
        {},
      );

  _i2.Future<bool> markNotificationRead(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'markNotificationRead',
        {'notificationId': notificationId},
      );

  _i2.Future<bool> markAllNotificationsRead(int organizationId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'markAllNotificationsRead',
        {'organizationId': organizationId},
      );

  _i2.Future<bool> deleteNotification(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'deleteNotification',
        {'notificationId': notificationId},
      );
}

/// {@category Endpoint}
class EndpointOrganizationAdmin extends _i1.EndpointRef {
  EndpointOrganizationAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organizationAdmin';

  /// Returns the top-level organization managed by the caller.
  _i2.Future<_i3.Organization?> getMyOrganization() =>
      caller.callServerEndpoint<_i3.Organization?>(
        'organizationAdmin',
        'getMyOrganization',
        {},
      );

  /// Creates a new Team (child organization) within the specified parent organization.
  _i2.Future<_i3.Organization?> createTeam(
    String name,
    int parentOrgId,
    String? imageUrl,
  ) => caller.callServerEndpoint<_i3.Organization?>(
    'organizationAdmin',
    'createTeam',
    {
      'name': name,
      'parentOrgId': parentOrgId,
      'imageUrl': imageUrl,
    },
  );

  /// Returns all teams (child organizations) for a given parent organization.
  _i2.Future<List<_i3.Organization>> getTeams(int parentOrgId) =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'organizationAdmin',
        'getTeams',
        {'parentOrgId': parentOrgId},
      );

  /// Assigns a manager to a team.
  _i2.Future<bool> assignManagerToTeam(
    int managerAppUserId,
    int teamId,
  ) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'assignManagerToTeam',
    {
      'managerAppUserId': managerAppUserId,
      'teamId': teamId,
    },
  );

  /// Deletes a team and all its user links.
  _i2.Future<bool> deleteTeam(int teamId) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'deleteTeam',
    {'teamId': teamId},
  );

  /// Updates the name of a team.
  _i2.Future<bool> updateTeam(
    int teamId,
    String name,
  ) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'updateTeam',
    {
      'teamId': teamId,
      'name': name,
    },
  );

  /// Creates a new user (Manager or User) and assigns them to a team.
  _i2.Future<_i4.AppUser?> createUserInTeam(
    String userName,
    String email,
    String password,
    _i5.Role role,
    int teamId,
  ) => caller.callServerEndpoint<_i4.AppUser?>(
    'organizationAdmin',
    'createUserInTeam',
    {
      'userName': userName,
      'email': email,
      'password': password,
      'role': role,
      'teamId': teamId,
    },
  );

  /// Updates the name and role of a Manager/User within the caller's org.
  _i2.Future<bool> updateOrgUser(
    int appUserId,
    String userName,
    _i5.Role role,
  ) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'updateOrgUser',
    {
      'appUserId': appUserId,
      'userName': userName,
      'role': role,
    },
  );

  /// Deletes a Manager/User from the caller's org entirely.
  _i2.Future<bool> deleteOrgUser(int appUserId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteOrgUser',
        {'appUserId': appUserId},
      );

  /// Resets the password of a user within the caller's org.
  _i2.Future<bool> resetOrgUserPassword(
    int appUserId,
    String newPassword,
  ) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'resetOrgUserPassword',
    {
      'appUserId': appUserId,
      'newPassword': newPassword,
    },
  );

  _i2.Future<_i6.ModuleConfig?> getModuleConfig() =>
      caller.callServerEndpoint<_i6.ModuleConfig?>(
        'organizationAdmin',
        'getModuleConfig',
        {},
      );

  _i2.Future<_i6.ModuleConfig?> setModuleConfig(
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String defaultLanguage,
    List<_i7.SupportedLanguage> supportedLanguages,
    String? aiChatPrompt,
    List<_i8.LocalizedAiPrompt>? aiChatPromptTranslations,
    int passingPercentage,
  ) => caller.callServerEndpoint<_i6.ModuleConfig?>(
    'organizationAdmin',
    'setModuleConfig',
    {
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'defaultLanguage': defaultLanguage,
      'supportedLanguages': supportedLanguages,
      'aiChatPrompt': aiChatPrompt,
      'aiChatPromptTranslations': aiChatPromptTranslations,
      'passingPercentage': passingPercentage,
    },
  );

  _i2.Future<List<_i13.UserModuleProgress>> getOrgUserModuleProgress(
    int userId,
  ) => caller.callServerEndpoint<List<_i13.UserModuleProgress>>(
    'organizationAdmin',
    'getOrgUserModuleProgress',
    {'userId': userId},
  );

  _i2.Future<_i13.UserModuleProgress?> setOrgUserModuleProgress(
    int userId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'organizationAdmin',
    'setOrgUserModuleProgress',
    {
      'userId': userId,
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      'deadline': deadline,
    },
  );

  _i2.Future<_i13.UserModuleProgress?> updateOrgUserModuleStatus(
    int userId,
    String moduleId,
    _i17.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'organizationAdmin',
    'updateOrgUserModuleStatus',
    {
      'userId': userId,
      'moduleId': moduleId,
      'status': status,
      'startedAt': startedAt,
      'completedAt': completedAt,
    },
  );

  _i2.Future<List<_i9.TheoryChapter>> getOrgTheoryChapters() =>
      caller.callServerEndpoint<List<_i9.TheoryChapter>>(
        'organizationAdmin',
        'getOrgTheoryChapters',
        {},
      );

  _i2.Future<_i9.TheoryChapter> upsertOrgTheoryChapter(
    _i9.TheoryChapter chapter,
  ) => caller.callServerEndpoint<_i9.TheoryChapter>(
    'organizationAdmin',
    'upsertOrgTheoryChapter',
    {'chapter': chapter},
  );

  _i2.Future<bool> deleteOrgTheoryChapter(int chapterId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteOrgTheoryChapter',
        {'chapterId': chapterId},
      );

  _i2.Future<List<_i10.TrainingParameter>> getOrgTrainingParameters() =>
      caller.callServerEndpoint<List<_i10.TrainingParameter>>(
        'organizationAdmin',
        'getOrgTrainingParameters',
        {},
      );

  _i2.Future<_i10.TrainingParameter> upsertOrgTrainingParameter(
    _i10.TrainingParameter param,
  ) => caller.callServerEndpoint<_i10.TrainingParameter>(
    'organizationAdmin',
    'upsertOrgTrainingParameter',
    {'param': param},
  );

  _i2.Future<bool> deleteOrgTrainingParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteOrgTrainingParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i11.AssessmentParameter>> getOrgAssessmentParameters() =>
      caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
        'organizationAdmin',
        'getOrgAssessmentParameters',
        {},
      );

  _i2.Future<_i11.AssessmentParameter> upsertOrgAssessmentParameter(
    _i11.AssessmentParameter param,
  ) => caller.callServerEndpoint<_i11.AssessmentParameter>(
    'organizationAdmin',
    'upsertOrgAssessmentParameter',
    {'param': param},
  );

  _i2.Future<bool> deleteOrgAssessmentParameter(int paramId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteOrgAssessmentParameter',
        {'paramId': paramId},
      );

  _i2.Future<List<_i12.Asset>> getOrgAssets() =>
      caller.callServerEndpoint<List<_i12.Asset>>(
        'organizationAdmin',
        'getOrgAssets',
        {},
      );

  _i2.Future<_i12.Asset> upsertOrgAsset(_i12.Asset asset) =>
      caller.callServerEndpoint<_i12.Asset>(
        'organizationAdmin',
        'upsertOrgAsset',
        {'asset': asset},
      );

  _i2.Future<bool> deleteOrgAsset(int assetId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteOrgAsset',
        {'assetId': assetId},
      );

  /// Returns paginated and filtered Smart Training results for Org Admins.
  _i2.Future<_i14.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i14.TrainingSessionResultPage>(
    'organizationAdmin',
    'getTrainingHistory',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'teamId': teamId,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  _i2.Future<List<_i16.TrainingSessionResult>> getOrgUserTrainingHistory(
    int userId,
  ) => caller.callServerEndpoint<List<_i16.TrainingSessionResult>>(
    'organizationAdmin',
    'getOrgUserTrainingHistory',
    {'userId': userId},
  );

  /// Returns a grouped overview of training results per user, scoped to the caller's organization.
  _i2.Future<_i15.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i15.TrainingUserSummaryPage>(
    'organizationAdmin',
    'getTrainingUserSummaries',
    {
      'page': page,
      'limit': limit,
      'search': search,
      'teamId': teamId,
      'start': start,
      'end': end,
      'passed': passed,
    },
  );

  /// Returns all Smart Training results for [appUserId] scoped to the caller's organization.
  _i2.Future<List<_i16.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
  ) => caller.callServerEndpoint<List<_i16.TrainingSessionResult>>(
    'organizationAdmin',
    'getUserTrainingHistory',
    {'appUserId': appUserId},
  );
}

/// {@category Endpoint}
class EndpointPublicApi extends _i1.EndpointRef {
  EndpointPublicApi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'publicApi';

  _i2.Future<_i19.LoginResponse> login(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i19.LoginResponse>(
    'publicApi',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Returns theory, training parameters, and assessment parameters for
  /// [organizationId] in a single call.
  _i2.Future<Map<String, dynamic>> getContentBundle(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getContentBundle',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getTheorySection(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getTheorySection',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<List<Map<String, dynamic>>> getTrainingParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'publicApi',
    'getTrainingParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<List<Map<String, dynamic>>> getAssessmentParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'publicApi',
    'getAssessmentParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getModuleConfig(
    int organizationId,
    String apiKey,
    String userId,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getModuleConfig',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'userId': userId,
    },
  );

  _i2.Future<Map<String, dynamic>> getLanguages(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getLanguages',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<List<Map<String, dynamic>>> getAssets(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<Map<String, dynamic>>>(
    'publicApi',
    'getAssets',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<bool> updateModuleStatus(
    int organizationId,
    String apiKey,
    String userId,
    String moduleId,
    _i17.ModuleProgressStatus status,
  ) => caller.callServerEndpoint<bool>(
    'publicApi',
    'updateModuleStatus',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'userId': userId,
      'moduleId': moduleId,
      'status': status,
    },
  );

  _i2.Future<Map<String, dynamic>> submitTrainingCertificate(
    int organizationId,
    String apiKey,
    String userId,
    int overallPercentage,
    List<_i20.TrainingCriteriaScore> criteriaValidation,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'submitTrainingCertificate',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'userId': userId,
      'overallPercentage': overallPercentage,
      'criteriaValidation': criteriaValidation,
    },
  );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i4.AppUser?> getMyPermissions() =>
      caller.callServerEndpoint<_i4.AppUser?>(
        'user',
        'getMyPermissions',
        {},
      );

  _i2.Future<_i6.ModuleConfig?> getMyOrgModuleConfig() =>
      caller.callServerEndpoint<_i6.ModuleConfig?>(
        'user',
        'getMyOrgModuleConfig',
        {},
      );

  _i2.Future<List<_i9.TheoryChapter>> getTheoryChapters() =>
      caller.callServerEndpoint<List<_i9.TheoryChapter>>(
        'user',
        'getTheoryChapters',
        {},
      );

  _i2.Future<List<_i10.TrainingParameter>> getTrainingParameters() =>
      caller.callServerEndpoint<List<_i10.TrainingParameter>>(
        'user',
        'getTrainingParameters',
        {},
      );

  _i2.Future<List<_i11.AssessmentParameter>> getAssessmentParameters() =>
      caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
        'user',
        'getAssessmentParameters',
        {},
      );

  /// Changes the authenticated user's password after verifying [currentPassword].
  /// Returns true on success, false if [currentPassword] is wrong or user not found.
  _i2.Future<bool> changePassword(
    String currentPassword,
    String newPassword,
  ) => caller.callServerEndpoint<bool>(
    'user',
    'changePassword',
    {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    },
  );

  _i2.Future<List<_i13.UserModuleProgress>> getMyModuleProgress() =>
      caller.callServerEndpoint<List<_i13.UserModuleProgress>>(
        'user',
        'getMyModuleProgress',
        {},
      );

  /// Records a completed Smart Training attempt for the authenticated user.
  _i2.Future<_i16.TrainingSessionResult?> submitTrainingResult(
    String externalUserId,
    int overallPercentage,
    List<_i20.TrainingCriteriaScore> criteriaScores,
  ) => caller.callServerEndpoint<_i16.TrainingSessionResult?>(
    'user',
    'submitTrainingResult',
    {
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      'criteriaScores': criteriaScores,
    },
  );

  /// Returns all Smart Training attempts for the authenticated user, newest first.
  _i2.Future<List<_i16.TrainingSessionResult>> getMyTrainingHistory() =>
      caller.callServerEndpoint<List<_i16.TrainingSessionResult>>(
        'user',
        'getMyTrainingHistory',
        {},
      );

  /// Allows a user to update their own module status. Automatically sets
  /// [startedAt] on first inProgress transition, [completedAt] on completion.
  _i2.Future<_i13.UserModuleProgress?> updateMyModuleStatus(
    String moduleId,
    _i17.ModuleProgressStatus status,
  ) => caller.callServerEndpoint<_i13.UserModuleProgress?>(
    'user',
    'updateMyModuleStatus',
    {
      'moduleId': moduleId,
      'status': status,
    },
  );

  /// Fetches all theory chapters for the authenticated user's organization,
  /// including the user's specific progress/score for each.
  _i2.Future<List<_i21.TheoryChapterWithProgress>>
  getTheoryChaptersWithProgress() =>
      caller.callServerEndpoint<List<_i21.TheoryChapterWithProgress>>(
        'user',
        'getTheoryChaptersWithProgress',
        {},
      );

  /// Validates a quiz submission and saves the user's result.
  /// Throws if authorization fails or chapter is not found.
  _i2.Future<_i22.UserTheoryProgress?> submitTheoryQuiz(
    int chapterId,
    int score,
  ) => caller.callServerEndpoint<_i22.UserTheoryProgress?>(
    'user',
    'submitTheoryQuiz',
    {
      'chapterId': chapterId,
      'score': score,
    },
  );
}

class Modules {
  Modules(Client client) {
    auth = _i23.Caller(client);
  }

  late final _i23.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i24.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    admin = EndpointAdmin(this);
    manager = EndpointManager(this);
    organizationAdmin = EndpointOrganizationAdmin(this);
    publicApi = EndpointPublicApi(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointManager manager;

  late final EndpointOrganizationAdmin organizationAdmin;

  late final EndpointPublicApi publicApi;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'manager': manager,
    'organizationAdmin': organizationAdmin,
    'publicApi': publicApi,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
