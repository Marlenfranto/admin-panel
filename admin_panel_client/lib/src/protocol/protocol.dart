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
import 'feedback_level.dart' as _i5;
import 'login_response.dart' as _i6;
import 'module_config.dart' as _i7;
import 'organization.dart' as _i8;
import 'organization_user_link.dart' as _i9;
import 'quiz_question.dart' as _i10;
import 'role.dart' as _i11;
import 'supported_language.dart' as _i12;
import 'theory_chapter.dart' as _i13;
import 'tools.dart' as _i14;
import 'training_parameter.dart' as _i15;
import 'video_metadata.dart' as _i16;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i17;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i18;
import 'package:admin_panel_client/src/protocol/supported_language.dart'
    as _i19;
import 'package:admin_panel_client/src/protocol/theory_chapter.dart' as _i20;
import 'package:admin_panel_client/src/protocol/training_parameter.dart'
    as _i21;
import 'package:admin_panel_client/src/protocol/assessment_parameter.dart'
    as _i22;
import 'package:admin_panel_client/src/protocol/asset.dart' as _i23;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i24;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'asset.dart';
export 'feedback_level.dart';
export 'login_response.dart';
export 'module_config.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'quiz_question.dart';
export 'role.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'tools.dart';
export 'training_parameter.dart';
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
    if (t == _i5.FeedbackLevel) {
      return _i5.FeedbackLevel.fromJson(data) as T;
    }
    if (t == _i6.LoginResponse) {
      return _i6.LoginResponse.fromJson(data) as T;
    }
    if (t == _i7.ModuleConfig) {
      return _i7.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i8.Organization) {
      return _i8.Organization.fromJson(data) as T;
    }
    if (t == _i9.OrganizationUserLink) {
      return _i9.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i10.QuizQuestion) {
      return _i10.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i11.Role) {
      return _i11.Role.fromJson(data) as T;
    }
    if (t == _i12.SupportedLanguage) {
      return _i12.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i13.TheoryChapter) {
      return _i13.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i14.Tools) {
      return _i14.Tools.fromJson(data) as T;
    }
    if (t == _i15.TrainingParameter) {
      return _i15.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i16.VideoMetadata) {
      return _i16.VideoMetadata.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.FeedbackLevel?>()) {
      return (data != null ? _i5.FeedbackLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.LoginResponse?>()) {
      return (data != null ? _i6.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ModuleConfig?>()) {
      return (data != null ? _i7.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Organization?>()) {
      return (data != null ? _i8.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrganizationUserLink?>()) {
      return (data != null ? _i9.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.QuizQuestion?>()) {
      return (data != null ? _i10.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Role?>()) {
      return (data != null ? _i11.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.SupportedLanguage?>()) {
      return (data != null ? _i12.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.TheoryChapter?>()) {
      return (data != null ? _i13.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Tools?>()) {
      return (data != null ? _i14.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.TrainingParameter?>()) {
      return (data != null ? _i15.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.VideoMetadata?>()) {
      return (data != null ? _i16.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i9.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i9.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i9.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i9.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i12.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i12.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i12.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i10.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i10.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i10.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i17.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i17.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i18.AppUser>) {
      return (data as List).map((e) => deserialize<_i18.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i19.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i19.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i20.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i21.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i22.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.Asset>) {
      return (data as List).map((e) => deserialize<_i23.Asset>(e)).toList()
          as T;
    }
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AppUser => 'AppUser',
      _i3.AssessmentParameter => 'AssessmentParameter',
      _i4.Asset => 'Asset',
      _i5.FeedbackLevel => 'FeedbackLevel',
      _i6.LoginResponse => 'LoginResponse',
      _i7.ModuleConfig => 'ModuleConfig',
      _i8.Organization => 'Organization',
      _i9.OrganizationUserLink => 'OrganizationUserLink',
      _i10.QuizQuestion => 'QuizQuestion',
      _i11.Role => 'Role',
      _i12.SupportedLanguage => 'SupportedLanguage',
      _i13.TheoryChapter => 'TheoryChapter',
      _i14.Tools => 'Tools',
      _i15.TrainingParameter => 'TrainingParameter',
      _i16.VideoMetadata => 'VideoMetadata',
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
      case _i5.FeedbackLevel():
        return 'FeedbackLevel';
      case _i6.LoginResponse():
        return 'LoginResponse';
      case _i7.ModuleConfig():
        return 'ModuleConfig';
      case _i8.Organization():
        return 'Organization';
      case _i9.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i10.QuizQuestion():
        return 'QuizQuestion';
      case _i11.Role():
        return 'Role';
      case _i12.SupportedLanguage():
        return 'SupportedLanguage';
      case _i13.TheoryChapter():
        return 'TheoryChapter';
      case _i14.Tools():
        return 'Tools';
      case _i15.TrainingParameter():
        return 'TrainingParameter';
      case _i16.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i24.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'FeedbackLevel') {
      return deserialize<_i5.FeedbackLevel>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i6.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i7.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i8.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i9.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i10.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i11.Role>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i12.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i13.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i14.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i15.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i16.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i24.Protocol().deserializeByClassName(data);
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
      return _i24.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
