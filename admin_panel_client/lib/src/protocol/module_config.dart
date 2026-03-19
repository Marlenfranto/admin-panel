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
import 'organization.dart' as _i2;
import 'supported_language.dart' as _i3;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i4;

abstract class ModuleConfig implements _i1.SerializableModel {
  ModuleConfig._({
    this.id,
    this.organizationId,
    this.organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    this.supportedLanguages,
    this.aiChatPrompt,
    int? passingPercentage,
  }) : theoryModule = theoryModule ?? false,
       aiExpertModule = aiExpertModule ?? false,
       smartTrainingModule = smartTrainingModule ?? false,
       assessmentModule = assessmentModule ?? false,
       defaultLanguage = defaultLanguage ?? 'en',
       passingPercentage = passingPercentage ?? 60;

  factory ModuleConfig({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  }) = _ModuleConfigImpl;

  factory ModuleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModuleConfig(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      theoryModule: jsonSerialization['theoryModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['theoryModule']),
      aiExpertModule: jsonSerialization['aiExpertModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['aiExpertModule']),
      smartTrainingModule: jsonSerialization['smartTrainingModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['smartTrainingModule'],
            ),
      assessmentModule: jsonSerialization['assessmentModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['assessmentModule'],
            ),
      defaultLanguage: jsonSerialization['defaultLanguage'] as String?,
      supportedLanguages: jsonSerialization['supportedLanguages'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.SupportedLanguage>>(
              jsonSerialization['supportedLanguages'],
            ),
      aiChatPrompt: jsonSerialization['aiChatPrompt'] as String?,
      passingPercentage: jsonSerialization['passingPercentage'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  bool theoryModule;

  bool aiExpertModule;

  bool smartTrainingModule;

  bool assessmentModule;

  String defaultLanguage;

  List<_i3.SupportedLanguage>? supportedLanguages;

  String? aiChatPrompt;

  int passingPercentage;

  /// Returns a shallow copy of this [ModuleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModuleConfig copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModuleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'defaultLanguage': defaultLanguage,
      if (supportedLanguages != null)
        'supportedLanguages': supportedLanguages?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
      'passingPercentage': passingPercentage,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModuleConfigImpl extends ModuleConfig {
  _ModuleConfigImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         theoryModule: theoryModule,
         aiExpertModule: aiExpertModule,
         smartTrainingModule: smartTrainingModule,
         assessmentModule: assessmentModule,
         defaultLanguage: defaultLanguage,
         supportedLanguages: supportedLanguages,
         aiChatPrompt: aiChatPrompt,
         passingPercentage: passingPercentage,
       );

  /// Returns a shallow copy of this [ModuleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModuleConfig copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    Object? supportedLanguages = _Undefined,
    Object? aiChatPrompt = _Undefined,
    int? passingPercentage,
  }) {
    return ModuleConfig(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      theoryModule: theoryModule ?? this.theoryModule,
      aiExpertModule: aiExpertModule ?? this.aiExpertModule,
      smartTrainingModule: smartTrainingModule ?? this.smartTrainingModule,
      assessmentModule: assessmentModule ?? this.assessmentModule,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      supportedLanguages: supportedLanguages is List<_i3.SupportedLanguage>?
          ? supportedLanguages
          : this.supportedLanguages?.map((e0) => e0.copyWith()).toList(),
      aiChatPrompt: aiChatPrompt is String? ? aiChatPrompt : this.aiChatPrompt,
      passingPercentage: passingPercentage ?? this.passingPercentage,
    );
  }
}
