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
import 'asset.dart' as _i4;
import 'certificate_response.dart' as _i5;
import 'content_bundle.dart' as _i6;
import 'languages_config.dart' as _i7;
import 'login_response.dart' as _i8;
import 'manager_notification.dart' as _i9;
import 'manager_notification_detail.dart' as _i10;
import 'module_config.dart' as _i11;
import 'module_config_public.dart' as _i12;
import 'module_progress_status.dart' as _i13;
import 'organization.dart' as _i14;
import 'organization_user_link.dart' as _i15;
import 'quiz_question.dart' as _i16;
import 'role.dart' as _i17;
import 'scoring_rule.dart' as _i18;
import 'subscription_modules.dart' as _i19;
import 'supported_language.dart' as _i20;
import 'theory_chapter.dart' as _i21;
import 'theory_section_response.dart' as _i22;
import 'tools.dart' as _i23;
import 'training_criteria_score.dart' as _i24;
import 'training_parameter.dart' as _i25;
import 'training_session_result.dart' as _i26;
import 'user_module_progress.dart' as _i27;
import 'video_metadata.dart' as _i28;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i29;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i30;
import 'package:admin_panel_client/src/protocol/supported_language.dart'
    as _i31;
import 'package:admin_panel_client/src/protocol/theory_chapter.dart' as _i32;
import 'package:admin_panel_client/src/protocol/training_parameter.dart'
    as _i33;
import 'package:admin_panel_client/src/protocol/assessment_parameter.dart'
    as _i34;
import 'package:admin_panel_client/src/protocol/asset.dart' as _i35;
import 'package:admin_panel_client/src/protocol/user_module_progress.dart'
    as _i36;
import 'package:admin_panel_client/src/protocol/training_session_result.dart'
    as _i37;
import 'package:admin_panel_client/src/protocol/manager_notification_detail.dart'
    as _i38;
import 'package:admin_panel_client/src/protocol/training_criteria_score.dart'
    as _i39;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i40;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'asset.dart';
export 'certificate_response.dart';
export 'content_bundle.dart';
export 'languages_config.dart';
export 'login_response.dart';
export 'manager_notification.dart';
export 'manager_notification_detail.dart';
export 'module_config.dart';
export 'module_config_public.dart';
export 'module_progress_status.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'quiz_question.dart';
export 'role.dart';
export 'scoring_rule.dart';
export 'subscription_modules.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'theory_section_response.dart';
export 'tools.dart';
export 'training_criteria_score.dart';
export 'training_parameter.dart';
export 'training_session_result.dart';
export 'user_module_progress.dart';
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
    if (t == _i4.Asset) {
      return _i4.Asset.fromJson(data) as T;
    }
    if (t == _i5.CertificateResponse) {
      return _i5.CertificateResponse.fromJson(data) as T;
    }
    if (t == _i6.ContentBundle) {
      return _i6.ContentBundle.fromJson(data) as T;
    }
    if (t == _i7.LanguagesConfig) {
      return _i7.LanguagesConfig.fromJson(data) as T;
    }
    if (t == _i8.LoginResponse) {
      return _i8.LoginResponse.fromJson(data) as T;
    }
    if (t == _i9.ManagerNotification) {
      return _i9.ManagerNotification.fromJson(data) as T;
    }
    if (t == _i10.ManagerNotificationDetail) {
      return _i10.ManagerNotificationDetail.fromJson(data) as T;
    }
    if (t == _i11.ModuleConfig) {
      return _i11.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i12.ModuleConfigPublic) {
      return _i12.ModuleConfigPublic.fromJson(data) as T;
    }
    if (t == _i13.ModuleProgressStatus) {
      return _i13.ModuleProgressStatus.fromJson(data) as T;
    }
    if (t == _i14.Organization) {
      return _i14.Organization.fromJson(data) as T;
    }
    if (t == _i15.OrganizationUserLink) {
      return _i15.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i16.QuizQuestion) {
      return _i16.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i17.Role) {
      return _i17.Role.fromJson(data) as T;
    }
    if (t == _i18.ScoringRule) {
      return _i18.ScoringRule.fromJson(data) as T;
    }
    if (t == _i19.SubscriptionModules) {
      return _i19.SubscriptionModules.fromJson(data) as T;
    }
    if (t == _i20.SupportedLanguage) {
      return _i20.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i21.TheoryChapter) {
      return _i21.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i22.TheorySectionResponse) {
      return _i22.TheorySectionResponse.fromJson(data) as T;
    }
    if (t == _i23.Tools) {
      return _i23.Tools.fromJson(data) as T;
    }
    if (t == _i24.TrainingCriteriaScore) {
      return _i24.TrainingCriteriaScore.fromJson(data) as T;
    }
    if (t == _i25.TrainingParameter) {
      return _i25.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i26.TrainingSessionResult) {
      return _i26.TrainingSessionResult.fromJson(data) as T;
    }
    if (t == _i27.UserModuleProgress) {
      return _i27.UserModuleProgress.fromJson(data) as T;
    }
    if (t == _i28.VideoMetadata) {
      return _i28.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AppUser?>()) {
      return (data != null ? _i2.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AssessmentParameter?>()) {
      return (data != null ? _i3.AssessmentParameter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.Asset?>()) {
      return (data != null ? _i4.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CertificateResponse?>()) {
      return (data != null ? _i5.CertificateResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.ContentBundle?>()) {
      return (data != null ? _i6.ContentBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.LanguagesConfig?>()) {
      return (data != null ? _i7.LanguagesConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LoginResponse?>()) {
      return (data != null ? _i8.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ManagerNotification?>()) {
      return (data != null ? _i9.ManagerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ManagerNotificationDetail?>()) {
      return (data != null
              ? _i10.ManagerNotificationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.ModuleConfig?>()) {
      return (data != null ? _i11.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ModuleConfigPublic?>()) {
      return (data != null ? _i12.ModuleConfigPublic.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ModuleProgressStatus?>()) {
      return (data != null ? _i13.ModuleProgressStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.Organization?>()) {
      return (data != null ? _i14.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.OrganizationUserLink?>()) {
      return (data != null ? _i15.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.QuizQuestion?>()) {
      return (data != null ? _i16.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Role?>()) {
      return (data != null ? _i17.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ScoringRule?>()) {
      return (data != null ? _i18.ScoringRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.SubscriptionModules?>()) {
      return (data != null ? _i19.SubscriptionModules.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.SupportedLanguage?>()) {
      return (data != null ? _i20.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.TheoryChapter?>()) {
      return (data != null ? _i21.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.TheorySectionResponse?>()) {
      return (data != null ? _i22.TheorySectionResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.Tools?>()) {
      return (data != null ? _i23.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TrainingCriteriaScore?>()) {
      return (data != null ? _i24.TrainingCriteriaScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.TrainingParameter?>()) {
      return (data != null ? _i25.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.TrainingSessionResult?>()) {
      return (data != null ? _i26.TrainingSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.UserModuleProgress?>()) {
      return (data != null ? _i27.UserModuleProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.VideoMetadata?>()) {
      return (data != null ? _i28.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i15.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i15.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i15.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i15.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i18.ScoringRule>) {
      return (data as List)
              .map((e) => deserialize<_i18.ScoringRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i25.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i3.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i3.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i20.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i20.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i20.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i16.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i16.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i16.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i16.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i21.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i24.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i24.TrainingCriteriaScore>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i24.TrainingCriteriaScore>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i29.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i29.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.AppUser>) {
      return (data as List).map((e) => deserialize<_i30.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i31.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i31.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i32.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i33.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i34.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.Asset>) {
      return (data as List).map((e) => deserialize<_i35.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i36.UserModuleProgress>) {
      return (data as List)
              .map((e) => deserialize<_i36.UserModuleProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i37.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.ManagerNotificationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i38.ManagerNotificationDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i39.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    try {
      return _i40.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AppUser => 'AppUser',
      _i3.AssessmentParameter => 'AssessmentParameter',
      _i4.Asset => 'Asset',
      _i5.CertificateResponse => 'CertificateResponse',
      _i6.ContentBundle => 'ContentBundle',
      _i7.LanguagesConfig => 'LanguagesConfig',
      _i8.LoginResponse => 'LoginResponse',
      _i9.ManagerNotification => 'ManagerNotification',
      _i10.ManagerNotificationDetail => 'ManagerNotificationDetail',
      _i11.ModuleConfig => 'ModuleConfig',
      _i12.ModuleConfigPublic => 'ModuleConfigPublic',
      _i13.ModuleProgressStatus => 'ModuleProgressStatus',
      _i14.Organization => 'Organization',
      _i15.OrganizationUserLink => 'OrganizationUserLink',
      _i16.QuizQuestion => 'QuizQuestion',
      _i17.Role => 'Role',
      _i18.ScoringRule => 'ScoringRule',
      _i19.SubscriptionModules => 'SubscriptionModules',
      _i20.SupportedLanguage => 'SupportedLanguage',
      _i21.TheoryChapter => 'TheoryChapter',
      _i22.TheorySectionResponse => 'TheorySectionResponse',
      _i23.Tools => 'Tools',
      _i24.TrainingCriteriaScore => 'TrainingCriteriaScore',
      _i25.TrainingParameter => 'TrainingParameter',
      _i26.TrainingSessionResult => 'TrainingSessionResult',
      _i27.UserModuleProgress => 'UserModuleProgress',
      _i28.VideoMetadata => 'VideoMetadata',
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
      case _i4.Asset():
        return 'Asset';
      case _i5.CertificateResponse():
        return 'CertificateResponse';
      case _i6.ContentBundle():
        return 'ContentBundle';
      case _i7.LanguagesConfig():
        return 'LanguagesConfig';
      case _i8.LoginResponse():
        return 'LoginResponse';
      case _i9.ManagerNotification():
        return 'ManagerNotification';
      case _i10.ManagerNotificationDetail():
        return 'ManagerNotificationDetail';
      case _i11.ModuleConfig():
        return 'ModuleConfig';
      case _i12.ModuleConfigPublic():
        return 'ModuleConfigPublic';
      case _i13.ModuleProgressStatus():
        return 'ModuleProgressStatus';
      case _i14.Organization():
        return 'Organization';
      case _i15.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i16.QuizQuestion():
        return 'QuizQuestion';
      case _i17.Role():
        return 'Role';
      case _i18.ScoringRule():
        return 'ScoringRule';
      case _i19.SubscriptionModules():
        return 'SubscriptionModules';
      case _i20.SupportedLanguage():
        return 'SupportedLanguage';
      case _i21.TheoryChapter():
        return 'TheoryChapter';
      case _i22.TheorySectionResponse():
        return 'TheorySectionResponse';
      case _i23.Tools():
        return 'Tools';
      case _i24.TrainingCriteriaScore():
        return 'TrainingCriteriaScore';
      case _i25.TrainingParameter():
        return 'TrainingParameter';
      case _i26.TrainingSessionResult():
        return 'TrainingSessionResult';
      case _i27.UserModuleProgress():
        return 'UserModuleProgress';
      case _i28.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i40.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'Asset') {
      return deserialize<_i4.Asset>(data['data']);
    }
    if (dataClassName == 'CertificateResponse') {
      return deserialize<_i5.CertificateResponse>(data['data']);
    }
    if (dataClassName == 'ContentBundle') {
      return deserialize<_i6.ContentBundle>(data['data']);
    }
    if (dataClassName == 'LanguagesConfig') {
      return deserialize<_i7.LanguagesConfig>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i8.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ManagerNotification') {
      return deserialize<_i9.ManagerNotification>(data['data']);
    }
    if (dataClassName == 'ManagerNotificationDetail') {
      return deserialize<_i10.ManagerNotificationDetail>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i11.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'ModuleConfigPublic') {
      return deserialize<_i12.ModuleConfigPublic>(data['data']);
    }
    if (dataClassName == 'ModuleProgressStatus') {
      return deserialize<_i13.ModuleProgressStatus>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i14.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i15.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i16.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i17.Role>(data['data']);
    }
    if (dataClassName == 'ScoringRule') {
      return deserialize<_i18.ScoringRule>(data['data']);
    }
    if (dataClassName == 'SubscriptionModules') {
      return deserialize<_i19.SubscriptionModules>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i20.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i21.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'TheorySectionResponse') {
      return deserialize<_i22.TheorySectionResponse>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i23.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingCriteriaScore') {
      return deserialize<_i24.TrainingCriteriaScore>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i25.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResult') {
      return deserialize<_i26.TrainingSessionResult>(data['data']);
    }
    if (dataClassName == 'UserModuleProgress') {
      return deserialize<_i27.UserModuleProgress>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i28.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i40.Protocol().deserializeByClassName(data);
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
      return _i40.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
