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
import 'app_user.dart' as _i2;
import 'assessment_parameter.dart' as _i3;
import 'assessment_parameter_localization.dart' as _i4;
import 'asset.dart' as _i5;
import 'asset_localization.dart' as _i6;
import 'certificate_response.dart' as _i7;
import 'content_bundle.dart' as _i8;
import 'locale_config.dart' as _i9;
import 'localized_ai_prompt.dart' as _i10;
import 'localized_parameter_content.dart' as _i11;
import 'localized_quiz_content.dart' as _i12;
import 'login_response.dart' as _i13;
import 'manager_notification.dart' as _i14;
import 'manager_notification_detail.dart' as _i15;
import 'module_config.dart' as _i16;
import 'module_config_public.dart' as _i17;
import 'module_progress_status.dart' as _i18;
import 'organization.dart' as _i19;
import 'organization_user_link.dart' as _i20;
import 'quiz_question.dart' as _i21;
import 'region.dart' as _i22;
import 'role.dart' as _i23;
import 'scoring_rule.dart' as _i24;
import 'subscription_modules.dart' as _i25;
import 'supported_language.dart' as _i26;
import 'theory_chapter.dart' as _i27;
import 'theory_chapter_localization.dart' as _i28;
import 'theory_chapter_with_progress.dart' as _i29;
import 'theory_section_response.dart' as _i30;
import 'tools.dart' as _i31;
import 'training_criteria_score.dart' as _i32;
import 'training_parameter.dart' as _i33;
import 'training_parameter_localization.dart' as _i34;
import 'training_session_result.dart' as _i35;
import 'training_session_result_page.dart' as _i36;
import 'training_user_summary.dart' as _i37;
import 'training_user_summary_page.dart' as _i38;
import 'user_module_progress.dart' as _i39;
import 'user_theory_progress.dart' as _i40;
import 'video_metadata.dart' as _i41;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i42;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i43;
import 'package:admin_panel_client/src/protocol/supported_language.dart'
    as _i44;
import 'package:admin_panel_client/src/protocol/localized_ai_prompt.dart'
    as _i45;
import 'package:admin_panel_client/src/protocol/theory_chapter.dart' as _i46;
import 'package:admin_panel_client/src/protocol/training_parameter.dart'
    as _i47;
import 'package:admin_panel_client/src/protocol/assessment_parameter.dart'
    as _i48;
import 'package:admin_panel_client/src/protocol/asset.dart' as _i49;
import 'package:admin_panel_client/src/protocol/region.dart' as _i50;
import 'package:admin_panel_client/src/protocol/locale_config.dart' as _i51;
import 'package:admin_panel_client/src/protocol/user_module_progress.dart'
    as _i52;
import 'package:admin_panel_client/src/protocol/training_session_result.dart'
    as _i53;
import 'package:admin_panel_client/src/protocol/theory_chapter_localization.dart'
    as _i54;
import 'package:admin_panel_client/src/protocol/localized_quiz_content.dart'
    as _i55;
import 'package:admin_panel_client/src/protocol/training_parameter_localization.dart'
    as _i56;
import 'package:admin_panel_client/src/protocol/assessment_parameter_localization.dart'
    as _i57;
import 'package:admin_panel_client/src/protocol/asset_localization.dart'
    as _i58;
import 'package:admin_panel_client/src/protocol/manager_notification_detail.dart'
    as _i59;
import 'package:admin_panel_client/src/protocol/training_criteria_score.dart'
    as _i60;
import 'package:admin_panel_client/src/protocol/theory_chapter_with_progress.dart'
    as _i61;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i62;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'assessment_parameter_localization.dart';
export 'asset.dart';
export 'asset_localization.dart';
export 'certificate_response.dart';
export 'content_bundle.dart';
export 'locale_config.dart';
export 'localized_ai_prompt.dart';
export 'localized_parameter_content.dart';
export 'localized_quiz_content.dart';
export 'login_response.dart';
export 'manager_notification.dart';
export 'manager_notification_detail.dart';
export 'module_config.dart';
export 'module_config_public.dart';
export 'module_progress_status.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'quiz_question.dart';
export 'region.dart';
export 'role.dart';
export 'scoring_rule.dart';
export 'subscription_modules.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'theory_chapter_localization.dart';
export 'theory_chapter_with_progress.dart';
export 'theory_section_response.dart';
export 'tools.dart';
export 'training_criteria_score.dart';
export 'training_parameter.dart';
export 'training_parameter_localization.dart';
export 'training_session_result.dart';
export 'training_session_result_page.dart';
export 'training_user_summary.dart';
export 'training_user_summary_page.dart';
export 'user_module_progress.dart';
export 'user_theory_progress.dart';
export 'video_metadata.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AppUser) {
      return _i2.AppUser.fromJson(data) as T;
    }
    if (t == _i3.AssessmentParameter) {
      return _i3.AssessmentParameter.fromJson(data) as T;
    }
    if (t == _i4.AssessmentParameterLocalization) {
      return _i4.AssessmentParameterLocalization.fromJson(data) as T;
    }
    if (t == _i5.Asset) {
      return _i5.Asset.fromJson(data) as T;
    }
    if (t == _i6.AssetLocalization) {
      return _i6.AssetLocalization.fromJson(data) as T;
    }
    if (t == _i7.CertificateResponse) {
      return _i7.CertificateResponse.fromJson(data) as T;
    }
    if (t == _i8.ContentBundle) {
      return _i8.ContentBundle.fromJson(data) as T;
    }
    if (t == _i9.LocaleConfig) {
      return _i9.LocaleConfig.fromJson(data) as T;
    }
    if (t == _i10.LocalizedAiPrompt) {
      return _i10.LocalizedAiPrompt.fromJson(data) as T;
    }
    if (t == _i11.LocalizedParameterContent) {
      return _i11.LocalizedParameterContent.fromJson(data) as T;
    }
    if (t == _i12.LocalizedQuizContent) {
      return _i12.LocalizedQuizContent.fromJson(data) as T;
    }
    if (t == _i13.LoginResponse) {
      return _i13.LoginResponse.fromJson(data) as T;
    }
    if (t == _i14.ManagerNotification) {
      return _i14.ManagerNotification.fromJson(data) as T;
    }
    if (t == _i15.ManagerNotificationDetail) {
      return _i15.ManagerNotificationDetail.fromJson(data) as T;
    }
    if (t == _i16.ModuleConfig) {
      return _i16.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i17.ModuleConfigPublic) {
      return _i17.ModuleConfigPublic.fromJson(data) as T;
    }
    if (t == _i18.ModuleProgressStatus) {
      return _i18.ModuleProgressStatus.fromJson(data) as T;
    }
    if (t == _i19.Organization) {
      return _i19.Organization.fromJson(data) as T;
    }
    if (t == _i20.OrganizationUserLink) {
      return _i20.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i21.QuizQuestion) {
      return _i21.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i22.Region) {
      return _i22.Region.fromJson(data) as T;
    }
    if (t == _i23.Role) {
      return _i23.Role.fromJson(data) as T;
    }
    if (t == _i24.ScoringRule) {
      return _i24.ScoringRule.fromJson(data) as T;
    }
    if (t == _i25.SubscriptionModules) {
      return _i25.SubscriptionModules.fromJson(data) as T;
    }
    if (t == _i26.SupportedLanguage) {
      return _i26.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i27.TheoryChapter) {
      return _i27.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i28.TheoryChapterLocalization) {
      return _i28.TheoryChapterLocalization.fromJson(data) as T;
    }
    if (t == _i29.TheoryChapterWithProgress) {
      return _i29.TheoryChapterWithProgress.fromJson(data) as T;
    }
    if (t == _i30.TheorySectionResponse) {
      return _i30.TheorySectionResponse.fromJson(data) as T;
    }
    if (t == _i31.Tools) {
      return _i31.Tools.fromJson(data) as T;
    }
    if (t == _i32.TrainingCriteriaScore) {
      return _i32.TrainingCriteriaScore.fromJson(data) as T;
    }
    if (t == _i33.TrainingParameter) {
      return _i33.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i34.TrainingParameterLocalization) {
      return _i34.TrainingParameterLocalization.fromJson(data) as T;
    }
    if (t == _i35.TrainingSessionResult) {
      return _i35.TrainingSessionResult.fromJson(data) as T;
    }
    if (t == _i36.TrainingSessionResultPage) {
      return _i36.TrainingSessionResultPage.fromJson(data) as T;
    }
    if (t == _i37.TrainingUserSummary) {
      return _i37.TrainingUserSummary.fromJson(data) as T;
    }
    if (t == _i38.TrainingUserSummaryPage) {
      return _i38.TrainingUserSummaryPage.fromJson(data) as T;
    }
    if (t == _i39.UserModuleProgress) {
      return _i39.UserModuleProgress.fromJson(data) as T;
    }
    if (t == _i40.UserTheoryProgress) {
      return _i40.UserTheoryProgress.fromJson(data) as T;
    }
    if (t == _i41.VideoMetadata) {
      return _i41.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AppUser?>()) {
      return (data != null ? _i2.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AssessmentParameter?>()) {
      return (data != null ? _i3.AssessmentParameter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.AssessmentParameterLocalization?>()) {
      return (data != null
              ? _i4.AssessmentParameterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i5.Asset?>()) {
      return (data != null ? _i5.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AssetLocalization?>()) {
      return (data != null ? _i6.AssetLocalization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CertificateResponse?>()) {
      return (data != null ? _i7.CertificateResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.ContentBundle?>()) {
      return (data != null ? _i8.ContentBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LocaleConfig?>()) {
      return (data != null ? _i9.LocaleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.LocalizedAiPrompt?>()) {
      return (data != null ? _i10.LocalizedAiPrompt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.LocalizedParameterContent?>()) {
      return (data != null
              ? _i11.LocalizedParameterContent.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.LocalizedQuizContent?>()) {
      return (data != null ? _i12.LocalizedQuizContent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.LoginResponse?>()) {
      return (data != null ? _i13.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.ManagerNotification?>()) {
      return (data != null ? _i14.ManagerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ManagerNotificationDetail?>()) {
      return (data != null
              ? _i15.ManagerNotificationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.ModuleConfig?>()) {
      return (data != null ? _i16.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ModuleConfigPublic?>()) {
      return (data != null ? _i17.ModuleConfigPublic.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i18.ModuleProgressStatus?>()) {
      return (data != null ? _i18.ModuleProgressStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.Organization?>()) {
      return (data != null ? _i19.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.OrganizationUserLink?>()) {
      return (data != null ? _i20.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.QuizQuestion?>()) {
      return (data != null ? _i21.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Region?>()) {
      return (data != null ? _i22.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Role?>()) {
      return (data != null ? _i23.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.ScoringRule?>()) {
      return (data != null ? _i24.ScoringRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SubscriptionModules?>()) {
      return (data != null ? _i25.SubscriptionModules.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.SupportedLanguage?>()) {
      return (data != null ? _i26.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.TheoryChapter?>()) {
      return (data != null ? _i27.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TheoryChapterLocalization?>()) {
      return (data != null
              ? _i28.TheoryChapterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.TheoryChapterWithProgress?>()) {
      return (data != null
              ? _i29.TheoryChapterWithProgress.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.TheorySectionResponse?>()) {
      return (data != null ? _i30.TheorySectionResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.Tools?>()) {
      return (data != null ? _i31.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.TrainingCriteriaScore?>()) {
      return (data != null ? _i32.TrainingCriteriaScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.TrainingParameter?>()) {
      return (data != null ? _i33.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.TrainingParameterLocalization?>()) {
      return (data != null
              ? _i34.TrainingParameterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.TrainingSessionResult?>()) {
      return (data != null ? _i35.TrainingSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.TrainingSessionResultPage?>()) {
      return (data != null
              ? _i36.TrainingSessionResultPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i37.TrainingUserSummary?>()) {
      return (data != null ? _i37.TrainingUserSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.TrainingUserSummaryPage?>()) {
      return (data != null ? _i38.TrainingUserSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.UserModuleProgress?>()) {
      return (data != null ? _i39.UserModuleProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.UserTheoryProgress?>()) {
      return (data != null ? _i40.UserTheoryProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.VideoMetadata?>()) {
      return (data != null ? _i41.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i20.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i20.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i20.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i20.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i24.ScoringRule>) {
      return (data as List)
              .map((e) => deserialize<_i24.ScoringRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.LocalizedParameterContent>) {
      return (data as List)
              .map((e) => deserialize<_i11.LocalizedParameterContent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.LocalizedParameterContent>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.LocalizedParameterContent>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i33.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i33.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i3.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i3.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i26.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i26.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i26.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i10.LocalizedAiPrompt>) {
      return (data as List)
              .map((e) => deserialize<_i10.LocalizedAiPrompt>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i10.LocalizedAiPrompt>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10.LocalizedAiPrompt>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i9.LocaleConfig>) {
      return (data as List)
              .map((e) => deserialize<_i9.LocaleConfig>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.LocaleConfig>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i9.LocaleConfig>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i19.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i19.Organization>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i19.Organization>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i19.Organization>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i12.LocalizedQuizContent>) {
      return (data as List)
              .map((e) => deserialize<_i12.LocalizedQuizContent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i12.LocalizedQuizContent>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12.LocalizedQuizContent>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i21.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i21.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i21.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i27.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i27.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i32.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i32.TrainingCriteriaScore>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i32.TrainingCriteriaScore>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i35.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i35.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.TrainingUserSummary>) {
      return (data as List)
              .map((e) => deserialize<_i37.TrainingUserSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i42.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.AppUser>) {
      return (data as List).map((e) => deserialize<_i43.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i44.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i44.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.LocalizedAiPrompt>) {
      return (data as List)
              .map((e) => deserialize<_i45.LocalizedAiPrompt>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i45.LocalizedAiPrompt>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i45.LocalizedAiPrompt>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i46.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i46.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i47.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i48.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.Asset>) {
      return (data as List).map((e) => deserialize<_i49.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i50.Region>) {
      return (data as List).map((e) => deserialize<_i50.Region>(e)).toList()
          as T;
    }
    if (t == List<_i51.LocaleConfig>) {
      return (data as List)
              .map((e) => deserialize<_i51.LocaleConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i52.UserModuleProgress>) {
      return (data as List)
              .map((e) => deserialize<_i52.UserModuleProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i53.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.TheoryChapterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i54.TheoryChapterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.LocalizedQuizContent>) {
      return (data as List)
              .map((e) => deserialize<_i55.LocalizedQuizContent>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.TrainingParameterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i56.TrainingParameterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.AssessmentParameterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i57.AssessmentParameterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.AssetLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i58.AssetLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.ManagerNotificationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i59.ManagerNotificationDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i60.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i60.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.TheoryChapterWithProgress>) {
      return (data as List)
              .map((e) => deserialize<_i61.TheoryChapterWithProgress>(e))
              .toList()
          as T;
    }
    try {
      return _i62.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AppUser => 'AppUser',
      _i3.AssessmentParameter => 'AssessmentParameter',
      _i4.AssessmentParameterLocalization => 'AssessmentParameterLocalization',
      _i5.Asset => 'Asset',
      _i6.AssetLocalization => 'AssetLocalization',
      _i7.CertificateResponse => 'CertificateResponse',
      _i8.ContentBundle => 'ContentBundle',
      _i9.LocaleConfig => 'LocaleConfig',
      _i10.LocalizedAiPrompt => 'LocalizedAiPrompt',
      _i11.LocalizedParameterContent => 'LocalizedParameterContent',
      _i12.LocalizedQuizContent => 'LocalizedQuizContent',
      _i13.LoginResponse => 'LoginResponse',
      _i14.ManagerNotification => 'ManagerNotification',
      _i15.ManagerNotificationDetail => 'ManagerNotificationDetail',
      _i16.ModuleConfig => 'ModuleConfig',
      _i17.ModuleConfigPublic => 'ModuleConfigPublic',
      _i18.ModuleProgressStatus => 'ModuleProgressStatus',
      _i19.Organization => 'Organization',
      _i20.OrganizationUserLink => 'OrganizationUserLink',
      _i21.QuizQuestion => 'QuizQuestion',
      _i22.Region => 'Region',
      _i23.Role => 'Role',
      _i24.ScoringRule => 'ScoringRule',
      _i25.SubscriptionModules => 'SubscriptionModules',
      _i26.SupportedLanguage => 'SupportedLanguage',
      _i27.TheoryChapter => 'TheoryChapter',
      _i28.TheoryChapterLocalization => 'TheoryChapterLocalization',
      _i29.TheoryChapterWithProgress => 'TheoryChapterWithProgress',
      _i30.TheorySectionResponse => 'TheorySectionResponse',
      _i31.Tools => 'Tools',
      _i32.TrainingCriteriaScore => 'TrainingCriteriaScore',
      _i33.TrainingParameter => 'TrainingParameter',
      _i34.TrainingParameterLocalization => 'TrainingParameterLocalization',
      _i35.TrainingSessionResult => 'TrainingSessionResult',
      _i36.TrainingSessionResultPage => 'TrainingSessionResultPage',
      _i37.TrainingUserSummary => 'TrainingUserSummary',
      _i38.TrainingUserSummaryPage => 'TrainingUserSummaryPage',
      _i39.UserModuleProgress => 'UserModuleProgress',
      _i40.UserTheoryProgress => 'UserTheoryProgress',
      _i41.VideoMetadata => 'VideoMetadata',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('admin_panel.', '');
    }

    switch (data) {
      case _i2.AppUser():
        return 'AppUser';
      case _i3.AssessmentParameter():
        return 'AssessmentParameter';
      case _i4.AssessmentParameterLocalization():
        return 'AssessmentParameterLocalization';
      case _i5.Asset():
        return 'Asset';
      case _i6.AssetLocalization():
        return 'AssetLocalization';
      case _i7.CertificateResponse():
        return 'CertificateResponse';
      case _i8.ContentBundle():
        return 'ContentBundle';
      case _i9.LocaleConfig():
        return 'LocaleConfig';
      case _i10.LocalizedAiPrompt():
        return 'LocalizedAiPrompt';
      case _i11.LocalizedParameterContent():
        return 'LocalizedParameterContent';
      case _i12.LocalizedQuizContent():
        return 'LocalizedQuizContent';
      case _i13.LoginResponse():
        return 'LoginResponse';
      case _i14.ManagerNotification():
        return 'ManagerNotification';
      case _i15.ManagerNotificationDetail():
        return 'ManagerNotificationDetail';
      case _i16.ModuleConfig():
        return 'ModuleConfig';
      case _i17.ModuleConfigPublic():
        return 'ModuleConfigPublic';
      case _i18.ModuleProgressStatus():
        return 'ModuleProgressStatus';
      case _i19.Organization():
        return 'Organization';
      case _i20.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i21.QuizQuestion():
        return 'QuizQuestion';
      case _i22.Region():
        return 'Region';
      case _i23.Role():
        return 'Role';
      case _i24.ScoringRule():
        return 'ScoringRule';
      case _i25.SubscriptionModules():
        return 'SubscriptionModules';
      case _i26.SupportedLanguage():
        return 'SupportedLanguage';
      case _i27.TheoryChapter():
        return 'TheoryChapter';
      case _i28.TheoryChapterLocalization():
        return 'TheoryChapterLocalization';
      case _i29.TheoryChapterWithProgress():
        return 'TheoryChapterWithProgress';
      case _i30.TheorySectionResponse():
        return 'TheorySectionResponse';
      case _i31.Tools():
        return 'Tools';
      case _i32.TrainingCriteriaScore():
        return 'TrainingCriteriaScore';
      case _i33.TrainingParameter():
        return 'TrainingParameter';
      case _i34.TrainingParameterLocalization():
        return 'TrainingParameterLocalization';
      case _i35.TrainingSessionResult():
        return 'TrainingSessionResult';
      case _i36.TrainingSessionResultPage():
        return 'TrainingSessionResultPage';
      case _i37.TrainingUserSummary():
        return 'TrainingUserSummary';
      case _i38.TrainingUserSummaryPage():
        return 'TrainingUserSummaryPage';
      case _i39.UserModuleProgress():
        return 'UserModuleProgress';
      case _i40.UserTheoryProgress():
        return 'UserTheoryProgress';
      case _i41.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i62.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i2.AppUser>(data['data']);
    }
    if (dataClassName == 'AssessmentParameter') {
      return deserialize<_i3.AssessmentParameter>(data['data']);
    }
    if (dataClassName == 'AssessmentParameterLocalization') {
      return deserialize<_i4.AssessmentParameterLocalization>(data['data']);
    }
    if (dataClassName == 'Asset') {
      return deserialize<_i5.Asset>(data['data']);
    }
    if (dataClassName == 'AssetLocalization') {
      return deserialize<_i6.AssetLocalization>(data['data']);
    }
    if (dataClassName == 'CertificateResponse') {
      return deserialize<_i7.CertificateResponse>(data['data']);
    }
    if (dataClassName == 'ContentBundle') {
      return deserialize<_i8.ContentBundle>(data['data']);
    }
    if (dataClassName == 'LocaleConfig') {
      return deserialize<_i9.LocaleConfig>(data['data']);
    }
    if (dataClassName == 'LocalizedAiPrompt') {
      return deserialize<_i10.LocalizedAiPrompt>(data['data']);
    }
    if (dataClassName == 'LocalizedParameterContent') {
      return deserialize<_i11.LocalizedParameterContent>(data['data']);
    }
    if (dataClassName == 'LocalizedQuizContent') {
      return deserialize<_i12.LocalizedQuizContent>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i13.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ManagerNotification') {
      return deserialize<_i14.ManagerNotification>(data['data']);
    }
    if (dataClassName == 'ManagerNotificationDetail') {
      return deserialize<_i15.ManagerNotificationDetail>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i16.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'ModuleConfigPublic') {
      return deserialize<_i17.ModuleConfigPublic>(data['data']);
    }
    if (dataClassName == 'ModuleProgressStatus') {
      return deserialize<_i18.ModuleProgressStatus>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i19.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i20.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i21.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i22.Region>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i23.Role>(data['data']);
    }
    if (dataClassName == 'ScoringRule') {
      return deserialize<_i24.ScoringRule>(data['data']);
    }
    if (dataClassName == 'SubscriptionModules') {
      return deserialize<_i25.SubscriptionModules>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i26.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i27.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'TheoryChapterLocalization') {
      return deserialize<_i28.TheoryChapterLocalization>(data['data']);
    }
    if (dataClassName == 'TheoryChapterWithProgress') {
      return deserialize<_i29.TheoryChapterWithProgress>(data['data']);
    }
    if (dataClassName == 'TheorySectionResponse') {
      return deserialize<_i30.TheorySectionResponse>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i31.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingCriteriaScore') {
      return deserialize<_i32.TrainingCriteriaScore>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i33.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'TrainingParameterLocalization') {
      return deserialize<_i34.TrainingParameterLocalization>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResult') {
      return deserialize<_i35.TrainingSessionResult>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResultPage') {
      return deserialize<_i36.TrainingSessionResultPage>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummary') {
      return deserialize<_i37.TrainingUserSummary>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummaryPage') {
      return deserialize<_i38.TrainingUserSummaryPage>(data['data']);
    }
    if (dataClassName == 'UserModuleProgress') {
      return deserialize<_i39.UserModuleProgress>(data['data']);
    }
    if (dataClassName == 'UserTheoryProgress') {
      return deserialize<_i40.UserTheoryProgress>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i41.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i62.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i62.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
