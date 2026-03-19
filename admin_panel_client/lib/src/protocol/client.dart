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
import 'package:admin_panel_client/src/protocol/theory_chapter.dart' as _i8;
import 'package:admin_panel_client/src/protocol/training_parameter.dart' as _i9;
import 'package:admin_panel_client/src/protocol/assessment_parameter.dart'
    as _i10;
import 'package:admin_panel_client/src/protocol/asset.dart' as _i11;
import 'package:admin_panel_client/src/protocol/user_module_progress.dart'
    as _i12;
import 'package:admin_panel_client/src/protocol/training_session_result.dart'
    as _i13;
import 'package:admin_panel_client/src/protocol/module_progress_status.dart'
    as _i14;
import 'package:admin_panel_client/src/protocol/manager_notification_detail.dart'
    as _i15;
import 'package:admin_panel_client/src/protocol/login_response.dart' as _i16;
import 'package:admin_panel_client/src/protocol/theory_section_response.dart'
    as _i17;
import 'package:admin_panel_client/src/protocol/module_config_public.dart'
    as _i18;
import 'package:admin_panel_client/src/protocol/languages_config.dart' as _i19;
import 'package:admin_panel_client/src/protocol/certificate_response.dart'
    as _i20;
import 'package:admin_panel_client/src/protocol/training_criteria_score.dart'
    as _i21;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i22;
import 'protocol.dart' as _i23;

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

  _i2.Future<List<_i3.Organization>> getAllOrganizations() =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'admin',
        'getAllOrganizations',
        {},
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
      'passingPercentage': passingPercentage,
    },
  );

  _i2.Future<_i6.ModuleConfig?> getModuleConfig(int organizationId) =>
      caller.callServerEndpoint<_i6.ModuleConfig?>(
        'admin',
        'getModuleConfig',
        {'organizationId': organizationId},
      );

  _i2.Future<List<_i8.TheoryChapter>> getTheoryChapters(int organizationId) =>
      caller.callServerEndpoint<List<_i8.TheoryChapter>>(
        'admin',
        'getTheoryChapters',
        {'organizationId': organizationId},
      );

  _i2.Future<_i8.TheoryChapter> upsertTheoryChapter(
    _i8.TheoryChapter chapter,
  ) => caller.callServerEndpoint<_i8.TheoryChapter>(
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

  _i2.Future<List<_i9.TrainingParameter>> getTrainingParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i9.TrainingParameter>>(
    'admin',
    'getTrainingParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i9.TrainingParameter> upsertTrainingParameter(
    _i9.TrainingParameter param,
  ) => caller.callServerEndpoint<_i9.TrainingParameter>(
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

  _i2.Future<List<_i10.AssessmentParameter>> getAssessmentParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i10.AssessmentParameter>>(
    'admin',
    'getAssessmentParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i10.AssessmentParameter> upsertAssessmentParameter(
    _i10.AssessmentParameter param,
  ) => caller.callServerEndpoint<_i10.AssessmentParameter>(
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

  _i2.Future<List<_i11.Asset>> getAssets(int organizationId) =>
      caller.callServerEndpoint<List<_i11.Asset>>(
        'admin',
        'getAssets',
        {'organizationId': organizationId},
      );

  _i2.Future<_i11.Asset> upsertAsset(_i11.Asset asset) =>
      caller.callServerEndpoint<_i11.Asset>(
        'admin',
        'upsertAsset',
        {'asset': asset},
      );

  _i2.Future<bool> deleteAsset(int assetId) => caller.callServerEndpoint<bool>(
    'admin',
    'deleteAsset',
    {'assetId': assetId},
  );

  _i2.Future<List<_i12.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i12.UserModuleProgress>>(
    'admin',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i12.UserModuleProgress> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i12.UserModuleProgress>(
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

  /// Returns all Smart Training results for [appUserId] across all orgs.
  _i2.Future<List<_i13.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
  ) => caller.callServerEndpoint<List<_i13.TrainingSessionResult>>(
    'admin',
    'getUserTrainingHistory',
    {'appUserId': appUserId},
  );

  _i2.Future<_i12.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i14.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i12.UserModuleProgress?>(
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

  _i2.Future<List<_i8.TheoryChapter>> getTheoryChapters(int organizationId) =>
      caller.callServerEndpoint<List<_i8.TheoryChapter>>(
        'manager',
        'getTheoryChapters',
        {'organizationId': organizationId},
      );

  _i2.Future<_i8.TheoryChapter> upsertTheoryChapter(
    int organizationId,
    _i8.TheoryChapter chapter,
  ) => caller.callServerEndpoint<_i8.TheoryChapter>(
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

  _i2.Future<List<_i9.TrainingParameter>> getTrainingParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i9.TrainingParameter>>(
    'manager',
    'getTrainingParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i9.TrainingParameter> upsertTrainingParameter(
    int organizationId,
    _i9.TrainingParameter param,
  ) => caller.callServerEndpoint<_i9.TrainingParameter>(
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

  _i2.Future<List<_i10.AssessmentParameter>> getAssessmentParameters(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i10.AssessmentParameter>>(
    'manager',
    'getAssessmentParameters',
    {'organizationId': organizationId},
  );

  _i2.Future<_i10.AssessmentParameter> upsertAssessmentParameter(
    int organizationId,
    _i10.AssessmentParameter param,
  ) => caller.callServerEndpoint<_i10.AssessmentParameter>(
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

  _i2.Future<List<_i11.Asset>> getAssets(int organizationId) =>
      caller.callServerEndpoint<List<_i11.Asset>>(
        'manager',
        'getAssets',
        {'organizationId': organizationId},
      );

  _i2.Future<_i11.Asset> upsertAsset(
    int organizationId,
    _i11.Asset asset,
  ) => caller.callServerEndpoint<_i11.Asset>(
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

  _i2.Future<List<_i12.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i12.UserModuleProgress>>(
    'manager',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i12.UserModuleProgress?> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i12.UserModuleProgress?>(
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

  _i2.Future<_i12.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i14.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i12.UserModuleProgress?>(
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

  /// Returns all Smart Training results for [appUserId] within this manager's org.
  _i2.Future<List<_i13.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i13.TrainingSessionResult>>(
    'manager',
    'getUserTrainingHistory',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  /// Returns notification details for [organizationId], auto-creating records
  /// for any overdue (deadline passed, not completed) progress entries.
  _i2.Future<List<_i15.ManagerNotificationDetail>> getNotifications(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i15.ManagerNotificationDetail>>(
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
class EndpointPublicApi extends _i1.EndpointRef {
  EndpointPublicApi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'publicApi';

  _i2.Future<_i16.LoginResponse> login(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i16.LoginResponse>(
    'publicApi',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Returns the full theory section for [organizationId]: module title + all
  /// chapters with their video metadata and quiz questions, ordered by chapter.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "moduleTitle": "Fire Safety Training",
  ///   "chapters": [ { "chapterId": 1, "title": "Fire", ... } ]
  /// }
  /// ```
  _i2.Future<_i17.TheorySectionResponse> getTheorySection(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<_i17.TheorySectionResponse>(
    'publicApi',
    'getTheorySection',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns all training parameters for [organizationId], including per-level
  /// feedback and scoring logic.
  ///
  /// JSON shape:
  /// ```json
  /// [
  ///   {
  ///     "paramId": "duration",
  ///     "name": "Duration",
  ///     "maxScore": 5,
  ///     "feedbackLow": { "scoreRange": "0/5", ... },
  ///     ...
  ///   }
  /// ]
  /// ```
  _i2.Future<List<_i9.TrainingParameter>> getTrainingParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<_i9.TrainingParameter>>(
    'publicApi',
    'getTrainingParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns all assessment parameters for [organizationId].
  ///
  /// JSON shape mirrors training parameters but without the hint field.
  _i2.Future<List<_i10.AssessmentParameter>> getAssessmentParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<_i10.AssessmentParameter>>(
    'publicApi',
    'getAssessmentParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns the public module configuration for [organizationId], with
  /// subscription modules resolved to the effective per-user state.
  ///
  /// [userId] is the AppUser.id as a string (same convention as
  /// [submitTrainingCertificate]). When provided and matched, each module's
  /// enabled flag reflects the user's individual override from
  /// [UserModuleProgress]; otherwise the org-level default is used.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "configId": "ORG1_v1.0.0",
  ///   "lastUpdated": "2026-03-19",
  ///   "subscriptionModules": { "theoryModule": true, ... },
  ///   "languages": { "defaultLanguage": "en", "supported": [...] },
  ///   "passingPercentage": 60,
  ///   "aiChatPrompt": "You are a fire safety expert..."
  /// }
  /// ```
  _i2.Future<_i18.ModuleConfigPublic> getModuleConfig(
    int organizationId,
    String apiKey,
    String userId,
  ) => caller.callServerEndpoint<_i18.ModuleConfigPublic>(
    'publicApi',
    'getModuleConfig',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'userId': userId,
    },
  );

  /// Returns the language configuration for [organizationId]: default language
  /// code and the list of supported languages with optional content URLs.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "defaultLanguage": "en",
  ///   "supported": [
  ///     { "code": "en", "name": "English", "contentUrl": "..." },
  ///     ...
  ///   ]
  /// }
  /// ```
  _i2.Future<_i19.LanguagesConfig> getLanguages(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<_i19.LanguagesConfig>(
    'publicApi',
    'getLanguages',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns all assets for [organizationId]. Assets can be filtered on the
  /// client side by the [Asset.module] field (e.g. "theory", "smartTraining").
  ///
  /// JSON shape:
  /// ```json
  /// [
  ///   {
  ///     "name": "Fire Extinguisher Model",
  ///     "version": "1.0",
  ///     "url": "https://...",
  ///     "module": "smartTraining"
  ///   }
  /// ]
  /// ```
  _i2.Future<List<_i11.Asset>> getAssets(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<List<_i11.Asset>>(
    'publicApi',
    'getAssets',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Records a completed Smart Training session submitted by the external
  /// training application. Stores the result and returns a confirmation.
  ///
  /// Request body:
  /// ```json
  /// {
  ///   "organizationId": 1,
  ///   "apiKey": "...",
  ///   "userId": "S1244",
  ///   "overallPercentage": 85,
  ///   "criteriaValidation": [
  ///     { "parameter": "Duration", "score": 4 },
  ///     ...
  ///   ]
  /// }
  /// ```
  ///
  /// Response:
  /// ```json
  /// { "success": true, "resultId": 42, "message": "Training result recorded." }
  /// ```
  _i2.Future<_i20.CertificateResponse> submitTrainingCertificate(
    int organizationId,
    String apiKey,
    String userId,
    int overallPercentage,
    List<_i21.TrainingCriteriaScore> criteriaValidation,
  ) => caller.callServerEndpoint<_i20.CertificateResponse>(
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

  _i2.Future<List<_i8.TheoryChapter>> getTheoryChapters() =>
      caller.callServerEndpoint<List<_i8.TheoryChapter>>(
        'user',
        'getTheoryChapters',
        {},
      );

  _i2.Future<List<_i9.TrainingParameter>> getTrainingParameters() =>
      caller.callServerEndpoint<List<_i9.TrainingParameter>>(
        'user',
        'getTrainingParameters',
        {},
      );

  _i2.Future<List<_i10.AssessmentParameter>> getAssessmentParameters() =>
      caller.callServerEndpoint<List<_i10.AssessmentParameter>>(
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

  _i2.Future<List<_i12.UserModuleProgress>> getMyModuleProgress() =>
      caller.callServerEndpoint<List<_i12.UserModuleProgress>>(
        'user',
        'getMyModuleProgress',
        {},
      );

  /// Records a completed Smart Training attempt for the authenticated user.
  _i2.Future<_i13.TrainingSessionResult?> submitTrainingResult(
    String externalUserId,
    int overallPercentage,
    List<_i21.TrainingCriteriaScore> criteriaScores,
  ) => caller.callServerEndpoint<_i13.TrainingSessionResult?>(
    'user',
    'submitTrainingResult',
    {
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      'criteriaScores': criteriaScores,
    },
  );

  /// Returns all Smart Training attempts for the authenticated user, newest first.
  _i2.Future<List<_i13.TrainingSessionResult>> getMyTrainingHistory() =>
      caller.callServerEndpoint<List<_i13.TrainingSessionResult>>(
        'user',
        'getMyTrainingHistory',
        {},
      );

  /// Allows a user to update their own module status. Automatically sets
  /// [startedAt] on first inProgress transition, [completedAt] on completion.
  _i2.Future<_i12.UserModuleProgress?> updateMyModuleStatus(
    String moduleId,
    _i14.ModuleProgressStatus status,
  ) => caller.callServerEndpoint<_i12.UserModuleProgress?>(
    'user',
    'updateMyModuleStatus',
    {
      'moduleId': moduleId,
      'status': status,
    },
  );
}

class Modules {
  Modules(Client client) {
    auth = _i22.Caller(client);
  }

  late final _i22.Caller auth;
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
         _i23.Protocol(),
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
    publicApi = EndpointPublicApi(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointManager manager;

  late final EndpointPublicApi publicApi;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'manager': manager,
    'publicApi': publicApi,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
