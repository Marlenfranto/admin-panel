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
import 'package:admin_panel_client/src/protocol/region.dart' as _i13;
import 'package:admin_panel_client/src/protocol/locale_config.dart' as _i14;
import 'package:admin_panel_client/src/protocol/user_module_progress.dart'
    as _i15;
import 'package:admin_panel_client/src/protocol/training_session_result_page.dart'
    as _i16;
import 'package:admin_panel_client/src/protocol/training_user_summary_page.dart'
    as _i17;
import 'package:admin_panel_client/src/protocol/training_session_result.dart'
    as _i18;
import 'package:admin_panel_client/src/protocol/module_progress_status.dart'
    as _i19;
import 'package:admin_panel_client/src/protocol/theory_chapter_localization.dart'
    as _i20;
import 'package:admin_panel_client/src/protocol/localized_quiz_content.dart'
    as _i21;
import 'package:admin_panel_client/src/protocol/training_parameter_localization.dart'
    as _i22;
import 'package:admin_panel_client/src/protocol/assessment_parameter_localization.dart'
    as _i23;
import 'package:admin_panel_client/src/protocol/asset_localization.dart'
    as _i24;
import 'package:admin_panel_client/src/protocol/manager_notification_detail.dart'
    as _i25;
import 'package:admin_panel_client/src/protocol/login_response.dart' as _i26;
import 'package:admin_panel_client/src/protocol/training_criteria_score.dart'
    as _i27;
import 'package:admin_panel_client/src/protocol/theory_chapter_with_progress.dart'
    as _i28;
import 'package:admin_panel_client/src/protocol/user_theory_progress.dart'
    as _i29;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i30;
import 'protocol.dart' as _i31;

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

  _i2.Future<List<_i13.Region>> listRegions(int organizationId) =>
      caller.callServerEndpoint<List<_i13.Region>>(
        'admin',
        'listRegions',
        {'organizationId': organizationId},
      );

  _i2.Future<_i13.Region> upsertRegion(
    int organizationId,
    _i13.Region region,
  ) => caller.callServerEndpoint<_i13.Region>(
    'admin',
    'upsertRegion',
    {
      'organizationId': organizationId,
      'region': region,
    },
  );

  _i2.Future<bool> deleteRegion(int regionId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteRegion',
        {'regionId': regionId},
      );

  _i2.Future<List<_i14.LocaleConfig>> listLocaleConfigs(int organizationId) =>
      caller.callServerEndpoint<List<_i14.LocaleConfig>>(
        'admin',
        'listLocaleConfigs',
        {'organizationId': organizationId},
      );

  _i2.Future<_i14.LocaleConfig> upsertLocaleConfig(
    int organizationId,
    _i14.LocaleConfig locale,
  ) => caller.callServerEndpoint<_i14.LocaleConfig>(
    'admin',
    'upsertLocaleConfig',
    {
      'organizationId': organizationId,
      'locale': locale,
    },
  );

  _i2.Future<bool> deleteLocaleConfig(int localeConfigId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteLocaleConfig',
        {'localeConfigId': localeConfigId},
      );

  /// Marks [localeKey] as the default locale for [organizationId], clears the
  /// flag on all other locales, and syncs `ModuleConfig.defaultLocaleKey`.
  _i2.Future<_i14.LocaleConfig?> setDefaultLocale(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<_i14.LocaleConfig?>(
    'admin',
    'setDefaultLocale',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i15.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i15.UserModuleProgress>>(
    'admin',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i15.UserModuleProgress> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress>(
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
  _i2.Future<_i16.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i16.TrainingSessionResultPage>(
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
  _i2.Future<_i17.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i17.TrainingUserSummaryPage>(
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
  _i2.Future<List<_i18.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
  ) => caller.callServerEndpoint<List<_i18.TrainingSessionResult>>(
    'admin',
    'getUserTrainingHistory',
    {'appUserId': appUserId},
  );

  _i2.Future<_i15.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i19.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
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

  _i2.Future<List<_i20.TheoryChapterLocalization>>
  listTheoryChapterLocalizations(int chapterId) =>
      caller.callServerEndpoint<List<_i20.TheoryChapterLocalization>>(
        'admin',
        'listTheoryChapterLocalizations',
        {'chapterId': chapterId},
      );

  _i2.Future<_i20.TheoryChapterLocalization> upsertTheoryChapterLocalization(
    int chapterId,
    _i20.TheoryChapterLocalization loc,
  ) => caller.callServerEndpoint<_i20.TheoryChapterLocalization>(
    'admin',
    'upsertTheoryChapterLocalization',
    {
      'chapterId': chapterId,
      'loc': loc,
    },
  );

  /// Sets the per-question quiz translations on [chapterId] for [localeKey].
  /// Each entry in [questionTranslations] maps to the question at the same
  /// index. Empty question text removes that locale's translation for that
  /// question.
  _i2.Future<void> setTheoryChapterQuizTranslations(
    int chapterId,
    String localeKey,
    List<_i21.LocalizedQuizContent> questionTranslations,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'setTheoryChapterQuizTranslations',
    {
      'chapterId': chapterId,
      'localeKey': localeKey,
      'questionTranslations': questionTranslations,
    },
  );

  _i2.Future<bool> deleteTheoryChapterLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteTheoryChapterLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i22.TrainingParameterLocalization>>
  listTrainingParameterLocalizations(int parameterId) =>
      caller.callServerEndpoint<List<_i22.TrainingParameterLocalization>>(
        'admin',
        'listTrainingParameterLocalizations',
        {'parameterId': parameterId},
      );

  _i2.Future<_i22.TrainingParameterLocalization>
  upsertTrainingParameterLocalization(
    int parameterId,
    _i22.TrainingParameterLocalization loc,
  ) => caller.callServerEndpoint<_i22.TrainingParameterLocalization>(
    'admin',
    'upsertTrainingParameterLocalization',
    {
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteTrainingParameterLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteTrainingParameterLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i23.AssessmentParameterLocalization>>
  listAssessmentParameterLocalizations(int parameterId) =>
      caller.callServerEndpoint<List<_i23.AssessmentParameterLocalization>>(
        'admin',
        'listAssessmentParameterLocalizations',
        {'parameterId': parameterId},
      );

  _i2.Future<_i23.AssessmentParameterLocalization>
  upsertAssessmentParameterLocalization(
    int parameterId,
    _i23.AssessmentParameterLocalization loc,
  ) => caller.callServerEndpoint<_i23.AssessmentParameterLocalization>(
    'admin',
    'upsertAssessmentParameterLocalization',
    {
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteAssessmentParameterLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteAssessmentParameterLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i24.AssetLocalization>> listAssetLocalizations(
    int assetId,
  ) => caller.callServerEndpoint<List<_i24.AssetLocalization>>(
    'admin',
    'listAssetLocalizations',
    {'assetId': assetId},
  );

  _i2.Future<_i24.AssetLocalization> upsertAssetLocalization(
    int assetId,
    _i24.AssetLocalization loc,
  ) => caller.callServerEndpoint<_i24.AssetLocalization>(
    'admin',
    'upsertAssetLocalization',
    {
      'assetId': assetId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteAssetLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'deleteAssetLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i9.TheoryChapter>> getTheoryChaptersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i9.TheoryChapter>>(
    'admin',
    'getTheoryChaptersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i10.TrainingParameter>> getTrainingParametersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'admin',
    'getTrainingParametersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i11.AssessmentParameter>> getAssessmentParametersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'admin',
    'getAssessmentParametersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i12.Asset>> getAssetsLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i12.Asset>>(
    'admin',
    'getAssetsLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
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

  _i2.Future<List<_i15.UserModuleProgress>> getUserModuleProgress(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i15.UserModuleProgress>>(
    'manager',
    'getUserModuleProgress',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  _i2.Future<_i15.UserModuleProgress?> setUserModuleProgress(
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
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

  _i2.Future<_i15.UserModuleProgress?> updateUserModuleStatus(
    int appUserId,
    int organizationId,
    String moduleId,
    _i19.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
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
  _i2.Future<_i16.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? organizationId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i16.TrainingSessionResultPage>(
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
  _i2.Future<List<_i18.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
    int organizationId,
  ) => caller.callServerEndpoint<List<_i18.TrainingSessionResult>>(
    'manager',
    'getUserTrainingHistory',
    {
      'appUserId': appUserId,
      'organizationId': organizationId,
    },
  );

  /// Returns paginated unique users who have smart training results, grouped by user,
  /// scoped to the teams managed by this manager.
  _i2.Future<_i17.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i17.TrainingUserSummaryPage>(
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
  _i2.Future<List<_i25.ManagerNotificationDetail>> getNotifications(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i25.ManagerNotificationDetail>>(
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

  _i2.Future<List<_i13.Region>> listManagedRegions(int organizationId) =>
      caller.callServerEndpoint<List<_i13.Region>>(
        'manager',
        'listManagedRegions',
        {'organizationId': organizationId},
      );

  _i2.Future<_i13.Region> upsertManagedRegion(
    int organizationId,
    _i13.Region region,
  ) => caller.callServerEndpoint<_i13.Region>(
    'manager',
    'upsertManagedRegion',
    {
      'organizationId': organizationId,
      'region': region,
    },
  );

  _i2.Future<bool> deleteManagedRegion(
    int organizationId,
    int regionId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedRegion',
    {
      'organizationId': organizationId,
      'regionId': regionId,
    },
  );

  _i2.Future<List<_i14.LocaleConfig>> listManagedLocaleConfigs(
    int organizationId,
  ) => caller.callServerEndpoint<List<_i14.LocaleConfig>>(
    'manager',
    'listManagedLocaleConfigs',
    {'organizationId': organizationId},
  );

  _i2.Future<_i14.LocaleConfig> upsertManagedLocaleConfig(
    int organizationId,
    _i14.LocaleConfig locale,
  ) => caller.callServerEndpoint<_i14.LocaleConfig>(
    'manager',
    'upsertManagedLocaleConfig',
    {
      'organizationId': organizationId,
      'locale': locale,
    },
  );

  _i2.Future<bool> deleteManagedLocaleConfig(
    int organizationId,
    int localeConfigId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedLocaleConfig',
    {
      'organizationId': organizationId,
      'localeConfigId': localeConfigId,
    },
  );

  _i2.Future<_i14.LocaleConfig?> setManagedDefaultLocale(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<_i14.LocaleConfig?>(
    'manager',
    'setManagedDefaultLocale',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i20.TheoryChapterLocalization>>
  listManagedTheoryChapterLocalizations(
    int organizationId,
    int chapterId,
  ) => caller.callServerEndpoint<List<_i20.TheoryChapterLocalization>>(
    'manager',
    'listManagedTheoryChapterLocalizations',
    {
      'organizationId': organizationId,
      'chapterId': chapterId,
    },
  );

  _i2.Future<_i20.TheoryChapterLocalization>
  upsertManagedTheoryChapterLocalization(
    int organizationId,
    int chapterId,
    _i20.TheoryChapterLocalization loc,
  ) => caller.callServerEndpoint<_i20.TheoryChapterLocalization>(
    'manager',
    'upsertManagedTheoryChapterLocalization',
    {
      'organizationId': organizationId,
      'chapterId': chapterId,
      'loc': loc,
    },
  );

  _i2.Future<void> setManagedTheoryChapterQuizTranslations(
    int organizationId,
    int chapterId,
    String localeKey,
    List<_i21.LocalizedQuizContent> questionTranslations,
  ) => caller.callServerEndpoint<void>(
    'manager',
    'setManagedTheoryChapterQuizTranslations',
    {
      'organizationId': organizationId,
      'chapterId': chapterId,
      'localeKey': localeKey,
      'questionTranslations': questionTranslations,
    },
  );

  _i2.Future<bool> deleteManagedTheoryChapterLocalization(
    int organizationId,
    int localizationId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedTheoryChapterLocalization',
    {
      'organizationId': organizationId,
      'localizationId': localizationId,
    },
  );

  _i2.Future<List<_i22.TrainingParameterLocalization>>
  listManagedTrainingParameterLocalizations(
    int organizationId,
    int parameterId,
  ) => caller.callServerEndpoint<List<_i22.TrainingParameterLocalization>>(
    'manager',
    'listManagedTrainingParameterLocalizations',
    {
      'organizationId': organizationId,
      'parameterId': parameterId,
    },
  );

  _i2.Future<_i22.TrainingParameterLocalization>
  upsertManagedTrainingParameterLocalization(
    int organizationId,
    int parameterId,
    _i22.TrainingParameterLocalization loc,
  ) => caller.callServerEndpoint<_i22.TrainingParameterLocalization>(
    'manager',
    'upsertManagedTrainingParameterLocalization',
    {
      'organizationId': organizationId,
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteManagedTrainingParameterLocalization(
    int organizationId,
    int localizationId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedTrainingParameterLocalization',
    {
      'organizationId': organizationId,
      'localizationId': localizationId,
    },
  );

  _i2.Future<List<_i23.AssessmentParameterLocalization>>
  listManagedAssessmentParameterLocalizations(
    int organizationId,
    int parameterId,
  ) => caller.callServerEndpoint<List<_i23.AssessmentParameterLocalization>>(
    'manager',
    'listManagedAssessmentParameterLocalizations',
    {
      'organizationId': organizationId,
      'parameterId': parameterId,
    },
  );

  _i2.Future<_i23.AssessmentParameterLocalization>
  upsertManagedAssessmentParameterLocalization(
    int organizationId,
    int parameterId,
    _i23.AssessmentParameterLocalization loc,
  ) => caller.callServerEndpoint<_i23.AssessmentParameterLocalization>(
    'manager',
    'upsertManagedAssessmentParameterLocalization',
    {
      'organizationId': organizationId,
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteManagedAssessmentParameterLocalization(
    int organizationId,
    int localizationId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedAssessmentParameterLocalization',
    {
      'organizationId': organizationId,
      'localizationId': localizationId,
    },
  );

  _i2.Future<List<_i24.AssetLocalization>> listManagedAssetLocalizations(
    int organizationId,
    int assetId,
  ) => caller.callServerEndpoint<List<_i24.AssetLocalization>>(
    'manager',
    'listManagedAssetLocalizations',
    {
      'organizationId': organizationId,
      'assetId': assetId,
    },
  );

  _i2.Future<_i24.AssetLocalization> upsertManagedAssetLocalization(
    int organizationId,
    int assetId,
    _i24.AssetLocalization loc,
  ) => caller.callServerEndpoint<_i24.AssetLocalization>(
    'manager',
    'upsertManagedAssetLocalization',
    {
      'organizationId': organizationId,
      'assetId': assetId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteManagedAssetLocalization(
    int organizationId,
    int localizationId,
  ) => caller.callServerEndpoint<bool>(
    'manager',
    'deleteManagedAssetLocalization',
    {
      'organizationId': organizationId,
      'localizationId': localizationId,
    },
  );

  _i2.Future<List<_i9.TheoryChapter>> getManagedTheoryChaptersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i9.TheoryChapter>>(
    'manager',
    'getManagedTheoryChaptersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i10.TrainingParameter>>
  getManagedTrainingParametersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'manager',
    'getManagedTrainingParametersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i11.AssessmentParameter>>
  getManagedAssessmentParametersLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'manager',
    'getManagedAssessmentParametersLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
  );

  _i2.Future<List<_i12.Asset>> getManagedAssetsLocalized(
    int organizationId,
    String localeKey,
  ) => caller.callServerEndpoint<List<_i12.Asset>>(
    'manager',
    'getManagedAssetsLocalized',
    {
      'organizationId': organizationId,
      'localeKey': localeKey,
    },
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

  _i2.Future<List<_i15.UserModuleProgress>> getOrgUserModuleProgress(
    int userId,
  ) => caller.callServerEndpoint<List<_i15.UserModuleProgress>>(
    'organizationAdmin',
    'getOrgUserModuleProgress',
    {'userId': userId},
  );

  _i2.Future<_i15.UserModuleProgress?> setOrgUserModuleProgress(
    int userId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
    'organizationAdmin',
    'setOrgUserModuleProgress',
    {
      'userId': userId,
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      'deadline': deadline,
    },
  );

  _i2.Future<_i15.UserModuleProgress?> updateOrgUserModuleStatus(
    int userId,
    String moduleId,
    _i19.ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
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
  _i2.Future<_i16.TrainingSessionResultPage> getTrainingHistory({
    required int page,
    required int limit,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i16.TrainingSessionResultPage>(
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

  _i2.Future<List<_i18.TrainingSessionResult>> getOrgUserTrainingHistory(
    int userId,
  ) => caller.callServerEndpoint<List<_i18.TrainingSessionResult>>(
    'organizationAdmin',
    'getOrgUserTrainingHistory',
    {'userId': userId},
  );

  /// Returns a grouped overview of training results per user, scoped to the caller's organization.
  _i2.Future<_i17.TrainingUserSummaryPage> getTrainingUserSummaries({
    required int page,
    required int limit,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) => caller.callServerEndpoint<_i17.TrainingUserSummaryPage>(
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
  _i2.Future<List<_i18.TrainingSessionResult>> getUserTrainingHistory(
    int appUserId,
  ) => caller.callServerEndpoint<List<_i18.TrainingSessionResult>>(
    'organizationAdmin',
    'getUserTrainingHistory',
    {'appUserId': appUserId},
  );

  _i2.Future<List<_i13.Region>> listMyRegions() =>
      caller.callServerEndpoint<List<_i13.Region>>(
        'organizationAdmin',
        'listMyRegions',
        {},
      );

  _i2.Future<_i13.Region> upsertMyRegion(_i13.Region region) =>
      caller.callServerEndpoint<_i13.Region>(
        'organizationAdmin',
        'upsertMyRegion',
        {'region': region},
      );

  _i2.Future<bool> deleteMyRegion(int regionId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteMyRegion',
        {'regionId': regionId},
      );

  _i2.Future<List<_i14.LocaleConfig>> listMyLocaleConfigs() =>
      caller.callServerEndpoint<List<_i14.LocaleConfig>>(
        'organizationAdmin',
        'listMyLocaleConfigs',
        {},
      );

  _i2.Future<_i14.LocaleConfig> upsertMyLocaleConfig(
    _i14.LocaleConfig locale,
  ) => caller.callServerEndpoint<_i14.LocaleConfig>(
    'organizationAdmin',
    'upsertMyLocaleConfig',
    {'locale': locale},
  );

  _i2.Future<bool> deleteMyLocaleConfig(int localeConfigId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteMyLocaleConfig',
        {'localeConfigId': localeConfigId},
      );

  _i2.Future<_i14.LocaleConfig?> setMyDefaultLocale(String localeKey) =>
      caller.callServerEndpoint<_i14.LocaleConfig?>(
        'organizationAdmin',
        'setMyDefaultLocale',
        {'localeKey': localeKey},
      );

  _i2.Future<List<_i20.TheoryChapterLocalization>>
  listMyTheoryChapterLocalizations(int chapterId) =>
      caller.callServerEndpoint<List<_i20.TheoryChapterLocalization>>(
        'organizationAdmin',
        'listMyTheoryChapterLocalizations',
        {'chapterId': chapterId},
      );

  _i2.Future<_i20.TheoryChapterLocalization> upsertMyTheoryChapterLocalization(
    int chapterId,
    _i20.TheoryChapterLocalization loc,
  ) => caller.callServerEndpoint<_i20.TheoryChapterLocalization>(
    'organizationAdmin',
    'upsertMyTheoryChapterLocalization',
    {
      'chapterId': chapterId,
      'loc': loc,
    },
  );

  _i2.Future<void> setMyTheoryChapterQuizTranslations(
    int chapterId,
    String localeKey,
    List<_i21.LocalizedQuizContent> questionTranslations,
  ) => caller.callServerEndpoint<void>(
    'organizationAdmin',
    'setMyTheoryChapterQuizTranslations',
    {
      'chapterId': chapterId,
      'localeKey': localeKey,
      'questionTranslations': questionTranslations,
    },
  );

  _i2.Future<bool> deleteMyTheoryChapterLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteMyTheoryChapterLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i22.TrainingParameterLocalization>>
  listMyTrainingParameterLocalizations(int parameterId) =>
      caller.callServerEndpoint<List<_i22.TrainingParameterLocalization>>(
        'organizationAdmin',
        'listMyTrainingParameterLocalizations',
        {'parameterId': parameterId},
      );

  _i2.Future<_i22.TrainingParameterLocalization>
  upsertMyTrainingParameterLocalization(
    int parameterId,
    _i22.TrainingParameterLocalization loc,
  ) => caller.callServerEndpoint<_i22.TrainingParameterLocalization>(
    'organizationAdmin',
    'upsertMyTrainingParameterLocalization',
    {
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteMyTrainingParameterLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteMyTrainingParameterLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i23.AssessmentParameterLocalization>>
  listMyAssessmentParameterLocalizations(int parameterId) =>
      caller.callServerEndpoint<List<_i23.AssessmentParameterLocalization>>(
        'organizationAdmin',
        'listMyAssessmentParameterLocalizations',
        {'parameterId': parameterId},
      );

  _i2.Future<_i23.AssessmentParameterLocalization>
  upsertMyAssessmentParameterLocalization(
    int parameterId,
    _i23.AssessmentParameterLocalization loc,
  ) => caller.callServerEndpoint<_i23.AssessmentParameterLocalization>(
    'organizationAdmin',
    'upsertMyAssessmentParameterLocalization',
    {
      'parameterId': parameterId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteMyAssessmentParameterLocalization(
    int localizationId,
  ) => caller.callServerEndpoint<bool>(
    'organizationAdmin',
    'deleteMyAssessmentParameterLocalization',
    {'localizationId': localizationId},
  );

  _i2.Future<List<_i24.AssetLocalization>> listMyAssetLocalizations(
    int assetId,
  ) => caller.callServerEndpoint<List<_i24.AssetLocalization>>(
    'organizationAdmin',
    'listMyAssetLocalizations',
    {'assetId': assetId},
  );

  _i2.Future<_i24.AssetLocalization> upsertMyAssetLocalization(
    int assetId,
    _i24.AssetLocalization loc,
  ) => caller.callServerEndpoint<_i24.AssetLocalization>(
    'organizationAdmin',
    'upsertMyAssetLocalization',
    {
      'assetId': assetId,
      'loc': loc,
    },
  );

  _i2.Future<bool> deleteMyAssetLocalization(int localizationId) =>
      caller.callServerEndpoint<bool>(
        'organizationAdmin',
        'deleteMyAssetLocalization',
        {'localizationId': localizationId},
      );

  _i2.Future<List<_i9.TheoryChapter>> getMyTheoryChaptersLocalized(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i9.TheoryChapter>>(
    'organizationAdmin',
    'getMyTheoryChaptersLocalized',
    {'localeKey': localeKey},
  );

  _i2.Future<List<_i10.TrainingParameter>> getMyTrainingParametersLocalized(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'organizationAdmin',
    'getMyTrainingParametersLocalized',
    {'localeKey': localeKey},
  );

  _i2.Future<List<_i11.AssessmentParameter>> getMyAssessmentParametersLocalized(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'organizationAdmin',
    'getMyAssessmentParametersLocalized',
    {'localeKey': localeKey},
  );

  _i2.Future<List<_i12.Asset>> getMyAssetsLocalized(String localeKey) =>
      caller.callServerEndpoint<List<_i12.Asset>>(
        'organizationAdmin',
        'getMyAssetsLocalized',
        {'localeKey': localeKey},
      );
}

/// {@category Endpoint}
class EndpointPublicApi extends _i1.EndpointRef {
  EndpointPublicApi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'publicApi';

  _i2.Future<_i26.LoginResponse> login(
    String email,
    String password,
  ) => caller.callServerEndpoint<_i26.LoginResponse>(
    'publicApi',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Returns theory, training parameters, and assessment parameters for
  /// [organizationId] in a single call. Top-level fields include the org's
  /// region/locale catalog (`defaultLocaleKey`, `regions`, `supportedLocales`).
  ///
  /// Each theory chapter exposes its per-locale content via the
  /// `chapterDetails` array (one entry per `TheoryChapterLocalization` row).
  /// Each quiz question carries the default-locale text at the top with
  /// `languageCode` set, and a `theoryTranslations` array containing only the
  /// non-default-language variants.
  ///
  /// Each training/assessment parameter's top-level fields hold the
  /// default-locale content (with `languageCode` set). The `translations`
  /// array contains only the non-default-locale rows, each tagged with its
  /// `languageCode`.
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

  /// Returns the theory chapters for [organizationId] populated with the
  /// org's default-locale content. The envelope includes the region/locale
  /// catalog so the caller can immediately offer a locale picker without a
  /// second round trip.
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

  /// Returns training parameters for [organizationId] populated with the
  /// org's default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog. Pre-existing callers that expected a bare list
  /// must read `parameters` from the envelope.
  _i2.Future<Map<String, dynamic>> getTrainingParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getTrainingParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns assessment parameters for [organizationId] populated with the
  /// org's default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog.
  _i2.Future<Map<String, dynamic>> getAssessmentParameters(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getAssessmentParameters',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Returns the public module configuration for [organizationId], augmented
  /// with the per-user `moduleStatuses` map when [userId] resolves to an
  /// `AppUser`. The response also exposes the org's `regions` list alongside
  /// the existing `defaultLocaleKey` and `supportedLocales` already on
  /// `ModuleConfigPublic`.
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

  /// **DEPRECATED.** Returns the legacy `{defaultLanguage, supported}` envelope
  /// for external apps that have not migrated to the regional locale model.
  /// New integrations should call [getLocales] and [getRegions] instead.
  ///
  /// The response now also carries `defaultLocaleKey`, `supportedLocales`,
  /// and `regions` so a client can perform a one-shot migration if needed.
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

  /// Returns assets for [organizationId] populated with the org's
  /// default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog.
  _i2.Future<Map<String, dynamic>> getAssets(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
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
    _i19.ModuleProgressStatus status,
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
    List<_i27.TrainingCriteriaScore> criteriaValidation,
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

  /// Lists the enabled `LocaleConfig` entries for [organizationId]. Use this to
  /// populate a locale picker on the external client before calling any of the
  /// `*Localized` reads below. Wrapped in an envelope that also includes
  /// `defaultLocaleKey` and `regions` so a single call powers a region+locale
  /// picker.
  _i2.Future<Map<String, dynamic>> getLocales(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getLocales',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  /// Lists the enabled `Region` entries for [organizationId]. Returned in the
  /// same envelope shape as [getLocales] so a client can build a region
  /// selector and then filter `supportedLocales` by the chosen region code.
  _i2.Future<Map<String, dynamic>> getRegions(
    int organizationId,
    String apiKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getRegions',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getTheorySectionLocalized(
    int organizationId,
    String apiKey,
    String localeKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getTheorySectionLocalized',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'localeKey': localeKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getTrainingParametersLocalized(
    int organizationId,
    String apiKey,
    String localeKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getTrainingParametersLocalized',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'localeKey': localeKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getAssessmentParametersLocalized(
    int organizationId,
    String apiKey,
    String localeKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getAssessmentParametersLocalized',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'localeKey': localeKey,
    },
  );

  _i2.Future<Map<String, dynamic>> getAssetsLocalized(
    int organizationId,
    String apiKey,
    String localeKey,
  ) => caller.callServerEndpoint<Map<String, dynamic>>(
    'publicApi',
    'getAssetsLocalized',
    {
      'organizationId': organizationId,
      'apiKey': apiKey,
      'localeKey': localeKey,
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

  _i2.Future<List<_i9.TheoryChapter>> getLocalizedTheoryChapters(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i9.TheoryChapter>>(
    'user',
    'getLocalizedTheoryChapters',
    {'localeKey': localeKey},
  );

  _i2.Future<List<_i10.TrainingParameter>> getLocalizedTrainingParameters(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i10.TrainingParameter>>(
    'user',
    'getLocalizedTrainingParameters',
    {'localeKey': localeKey},
  );

  _i2.Future<List<_i11.AssessmentParameter>> getLocalizedAssessmentParameters(
    String localeKey,
  ) => caller.callServerEndpoint<List<_i11.AssessmentParameter>>(
    'user',
    'getLocalizedAssessmentParameters',
    {'localeKey': localeKey},
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

  /// Returns the enabled LocaleConfig list for the user's org so the client
  /// can populate a locale picker.
  _i2.Future<List<_i14.LocaleConfig>> getMyLocales() =>
      caller.callServerEndpoint<List<_i14.LocaleConfig>>(
        'user',
        'getMyLocales',
        {},
      );

  /// Persists [localeKey] on the caller's AppUser row. Validates the key is
  /// well-formed and configured on the user's org.
  _i2.Future<_i4.AppUser?> setPreferredLocale(String localeKey) =>
      caller.callServerEndpoint<_i4.AppUser?>(
        'user',
        'setPreferredLocale',
        {'localeKey': localeKey},
      );

  _i2.Future<List<_i15.UserModuleProgress>> getMyModuleProgress() =>
      caller.callServerEndpoint<List<_i15.UserModuleProgress>>(
        'user',
        'getMyModuleProgress',
        {},
      );

  /// Records a completed Smart Training attempt for the authenticated user.
  _i2.Future<_i18.TrainingSessionResult?> submitTrainingResult(
    String externalUserId,
    int overallPercentage,
    List<_i27.TrainingCriteriaScore> criteriaScores,
  ) => caller.callServerEndpoint<_i18.TrainingSessionResult?>(
    'user',
    'submitTrainingResult',
    {
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      'criteriaScores': criteriaScores,
    },
  );

  /// Returns all Smart Training attempts for the authenticated user, newest first.
  _i2.Future<List<_i18.TrainingSessionResult>> getMyTrainingHistory() =>
      caller.callServerEndpoint<List<_i18.TrainingSessionResult>>(
        'user',
        'getMyTrainingHistory',
        {},
      );

  /// Allows a user to update their own module status. Automatically sets
  /// [startedAt] on first inProgress transition, [completedAt] on completion.
  _i2.Future<_i15.UserModuleProgress?> updateMyModuleStatus(
    String moduleId,
    _i19.ModuleProgressStatus status,
  ) => caller.callServerEndpoint<_i15.UserModuleProgress?>(
    'user',
    'updateMyModuleStatus',
    {
      'moduleId': moduleId,
      'status': status,
    },
  );

  /// Locale-aware variant of [getTheoryChaptersWithProgress]. Each chapter's
  /// content fields (title, thumbnail, video, metadata) are resolved through
  /// the LocaleResolver fallback chain for [localeKey].
  _i2.Future<List<_i28.TheoryChapterWithProgress>>
  getLocalizedTheoryChaptersWithProgress(String localeKey) =>
      caller.callServerEndpoint<List<_i28.TheoryChapterWithProgress>>(
        'user',
        'getLocalizedTheoryChaptersWithProgress',
        {'localeKey': localeKey},
      );

  /// Fetches all theory chapters for the authenticated user's organization,
  /// including the user's specific progress/score for each.
  _i2.Future<List<_i28.TheoryChapterWithProgress>>
  getTheoryChaptersWithProgress() =>
      caller.callServerEndpoint<List<_i28.TheoryChapterWithProgress>>(
        'user',
        'getTheoryChaptersWithProgress',
        {},
      );

  /// Validates a quiz submission and saves the user's result.
  /// Throws if authorization fails or chapter is not found.
  _i2.Future<_i29.UserTheoryProgress?> submitTheoryQuiz(
    int chapterId,
    int score,
  ) => caller.callServerEndpoint<_i29.UserTheoryProgress?>(
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
    auth = _i30.Caller(client);
  }

  late final _i30.Caller auth;
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
         _i31.Protocol(),
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
