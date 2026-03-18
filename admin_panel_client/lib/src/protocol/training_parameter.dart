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
import 'feedback_level.dart' as _i3;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i4;

abstract class TrainingParameter implements _i1.SerializableModel {
  TrainingParameter._({
    this.id,
    this.organizationId,
    this.organization,
    required this.paramId,
    required this.name,
    required this.description,
    required this.maxScore,
    required this.logic,
    this.hint,
    required this.feedbackLow,
    required this.feedbackMedium,
    required this.feedbackHigh,
  });

  factory TrainingParameter({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required String name,
    required String description,
    required int maxScore,
    required String logic,
    String? hint,
    required _i3.FeedbackLevel feedbackLow,
    required _i3.FeedbackLevel feedbackMedium,
    required _i3.FeedbackLevel feedbackHigh,
  }) = _TrainingParameterImpl;

  factory TrainingParameter.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingParameter(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      paramId: jsonSerialization['paramId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      maxScore: jsonSerialization['maxScore'] as int,
      logic: jsonSerialization['logic'] as String,
      hint: jsonSerialization['hint'] as String?,
      feedbackLow: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackLow'],
      ),
      feedbackMedium: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackMedium'],
      ),
      feedbackHigh: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackHigh'],
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

  String name;

  String description;

  int maxScore;

  String logic;

  String? hint;

  _i3.FeedbackLevel feedbackLow;

  _i3.FeedbackLevel feedbackMedium;

  _i3.FeedbackLevel feedbackHigh;

  /// Returns a shallow copy of this [TrainingParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingParameter copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? paramId,
    String? name,
    String? description,
    int? maxScore,
    String? logic,
    String? hint,
    _i3.FeedbackLevel? feedbackLow,
    _i3.FeedbackLevel? feedbackMedium,
    _i3.FeedbackLevel? feedbackHigh,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'paramId': paramId,
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'logic': logic,
      if (hint != null) 'hint': hint,
      'feedbackLow': feedbackLow.toJson(),
      'feedbackMedium': feedbackMedium.toJson(),
      'feedbackHigh': feedbackHigh.toJson(),
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
    required String name,
    required String description,
    required int maxScore,
    required String logic,
    String? hint,
    required _i3.FeedbackLevel feedbackLow,
    required _i3.FeedbackLevel feedbackMedium,
    required _i3.FeedbackLevel feedbackHigh,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         paramId: paramId,
         name: name,
         description: description,
         maxScore: maxScore,
         logic: logic,
         hint: hint,
         feedbackLow: feedbackLow,
         feedbackMedium: feedbackMedium,
         feedbackHigh: feedbackHigh,
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
    String? name,
    String? description,
    int? maxScore,
    String? logic,
    Object? hint = _Undefined,
    _i3.FeedbackLevel? feedbackLow,
    _i3.FeedbackLevel? feedbackMedium,
    _i3.FeedbackLevel? feedbackHigh,
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
      name: name ?? this.name,
      description: description ?? this.description,
      maxScore: maxScore ?? this.maxScore,
      logic: logic ?? this.logic,
      hint: hint is String? ? hint : this.hint,
      feedbackLow: feedbackLow ?? this.feedbackLow.copyWith(),
      feedbackMedium: feedbackMedium ?? this.feedbackMedium.copyWith(),
      feedbackHigh: feedbackHigh ?? this.feedbackHigh.copyWith(),
    );
  }
}
