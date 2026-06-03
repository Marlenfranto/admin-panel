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
import 'scoring_rule.dart' as _i3;
import 'localized_parameter_content.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class TrainingParameter implements _i1.SerializableModel {
  TrainingParameter._({
    this.id,
    this.organizationId,
    this.organization,
    required this.paramId,
    required this.maxScore,
    required this.scoringRules,
    String? name,
    String? description,
    this.translations,
  }) : name = name ?? '',
       description = description ?? '';

  factory TrainingParameter({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required int maxScore,
    required List<_i3.ScoringRule> scoringRules,
    String? name,
    String? description,
    List<_i4.LocalizedParameterContent>? translations,
  }) = _TrainingParameterImpl;

  factory TrainingParameter.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingParameter(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      paramId: jsonSerialization['paramId'] as String,
      maxScore: jsonSerialization['maxScore'] as int,
      scoringRules: _i5.Protocol().deserialize<List<_i3.ScoringRule>>(
        jsonSerialization['scoringRules'],
      ),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      translations: jsonSerialization['translations'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.LocalizedParameterContent>>(
              jsonSerialization['translations'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String paramId;

  int maxScore;

  List<_i3.ScoringRule> scoringRules;

  /// Non-persistent — populated by hydrateTrainingParameters from the
  /// default-locale TrainingParameterLocalization row. Defaulted to '' so
  /// legacy callers see a non-null value.
  String name;

  String description;

  /// DEPRECATED (future): kept non-persistent until legacy editor's
  /// translation editor is removed.
  List<_i4.LocalizedParameterContent>? translations;

  /// Returns a shallow copy of this [TrainingParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingParameter copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? paramId,
    int? maxScore,
    List<_i3.ScoringRule>? scoringRules,
    String? name,
    String? description,
    List<_i4.LocalizedParameterContent>? translations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'paramId': paramId,
      'maxScore': maxScore,
      'scoringRules': scoringRules.toJson(valueToJson: (v) => v.toJson()),
      'name': name,
      'description': description,
      if (translations != null)
        'translations': translations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingParameterImpl extends TrainingParameter {
  _TrainingParameterImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required int maxScore,
    required List<_i3.ScoringRule> scoringRules,
    String? name,
    String? description,
    List<_i4.LocalizedParameterContent>? translations,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         paramId: paramId,
         maxScore: maxScore,
         scoringRules: scoringRules,
         name: name,
         description: description,
         translations: translations,
       );

  /// Returns a shallow copy of this [TrainingParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingParameter copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? paramId,
    int? maxScore,
    List<_i3.ScoringRule>? scoringRules,
    String? name,
    String? description,
    Object? translations = _Undefined,
  }) {
    return TrainingParameter(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      paramId: paramId ?? this.paramId,
      maxScore: maxScore ?? this.maxScore,
      scoringRules:
          scoringRules ?? this.scoringRules.map((e0) => e0.copyWith()).toList(),
      name: name ?? this.name,
      description: description ?? this.description,
      translations: translations is List<_i4.LocalizedParameterContent>?
          ? translations
          : this.translations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
