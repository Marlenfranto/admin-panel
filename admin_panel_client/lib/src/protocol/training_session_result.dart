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
import 'organization.dart' as _i3;
import 'training_criteria_score.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class TrainingSessionResult implements _i1.SerializableModel {
  TrainingSessionResult._({
    this.id,
    this.appUserId,
    this.appUser,
    required this.organizationId,
    this.organization,
    required this.externalUserId,
    required this.overallPercentage,
    this.criteriaScores,
    required this.completedAt,
  });

  factory TrainingSessionResult({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    required int organizationId,
    _i3.Organization? organization,
    required String externalUserId,
    required int overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    required DateTime completedAt,
  }) = _TrainingSessionResultImpl;

  factory TrainingSessionResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingSessionResult(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int?,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.AppUser>(
              jsonSerialization['appUser'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      externalUserId: jsonSerialization['externalUserId'] as String,
      overallPercentage: jsonSerialization['overallPercentage'] as int,
      criteriaScores: jsonSerialization['criteriaScores'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.TrainingCriteriaScore>>(
              jsonSerialization['criteriaScores'],
            ),
      completedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? appUserId;

  _i2.AppUser? appUser;

  int organizationId;

  _i3.Organization? organization;

  String externalUserId;

  int overallPercentage;

  List<_i4.TrainingCriteriaScore>? criteriaScores;

  DateTime completedAt;

  /// Returns a shallow copy of this [TrainingSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingSessionResult copyWith({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    int? organizationId,
    _i3.Organization? organization,
    String? externalUserId,
    int? overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingSessionResult',
      if (id != null) 'id': id,
      if (appUserId != null) 'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      if (criteriaScores != null)
        'criteriaScores': criteriaScores?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingSessionResultImpl extends TrainingSessionResult {
  _TrainingSessionResultImpl({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    required int organizationId,
    _i3.Organization? organization,
    required String externalUserId,
    required int overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    required DateTime completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         appUser: appUser,
         organizationId: organizationId,
         organization: organization,
         externalUserId: externalUserId,
         overallPercentage: overallPercentage,
         criteriaScores: criteriaScores,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [TrainingSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingSessionResult copyWith({
    Object? id = _Undefined,
    Object? appUserId = _Undefined,
    Object? appUser = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? externalUserId,
    int? overallPercentage,
    Object? criteriaScores = _Undefined,
    DateTime? completedAt,
  }) {
    return TrainingSessionResult(
      id: id is int? ? id : this.id,
      appUserId: appUserId is int? ? appUserId : this.appUserId,
      appUser: appUser is _i2.AppUser? ? appUser : this.appUser?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      externalUserId: externalUserId ?? this.externalUserId,
      overallPercentage: overallPercentage ?? this.overallPercentage,
      criteriaScores: criteriaScores is List<_i4.TrainingCriteriaScore>?
          ? criteriaScores
          : this.criteriaScores?.map((e0) => e0.copyWith()).toList(),
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
