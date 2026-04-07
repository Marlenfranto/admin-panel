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
import 'training_session_result.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class TrainingUserSummary implements _i1.SerializableModel {
  TrainingUserSummary._({
    required this.user,
    this.parentOrg,
    required this.team,
    this.latestResult,
    required this.totalSessions,
  });

  factory TrainingUserSummary({
    required _i2.AppUser user,
    _i3.Organization? parentOrg,
    required _i3.Organization team,
    _i4.TrainingSessionResult? latestResult,
    required int totalSessions,
  }) = _TrainingUserSummaryImpl;

  factory TrainingUserSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingUserSummary(
      user: _i5.Protocol().deserialize<_i2.AppUser>(jsonSerialization['user']),
      parentOrg: jsonSerialization['parentOrg'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['parentOrg'],
            ),
      team: _i5.Protocol().deserialize<_i3.Organization>(
        jsonSerialization['team'],
      ),
      latestResult: jsonSerialization['latestResult'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.TrainingSessionResult>(
              jsonSerialization['latestResult'],
            ),
      totalSessions: jsonSerialization['totalSessions'] as int,
    );
  }

  _i2.AppUser user;

  _i3.Organization? parentOrg;

  _i3.Organization team;

  _i4.TrainingSessionResult? latestResult;

  int totalSessions;

  /// Returns a shallow copy of this [TrainingUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingUserSummary copyWith({
    _i2.AppUser? user,
    _i3.Organization? parentOrg,
    _i3.Organization? team,
    _i4.TrainingSessionResult? latestResult,
    int? totalSessions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingUserSummary',
      'user': user.toJson(),
      if (parentOrg != null) 'parentOrg': parentOrg?.toJson(),
      'team': team.toJson(),
      if (latestResult != null) 'latestResult': latestResult?.toJson(),
      'totalSessions': totalSessions,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingUserSummaryImpl extends TrainingUserSummary {
  _TrainingUserSummaryImpl({
    required _i2.AppUser user,
    _i3.Organization? parentOrg,
    required _i3.Organization team,
    _i4.TrainingSessionResult? latestResult,
    required int totalSessions,
  }) : super._(
         user: user,
         parentOrg: parentOrg,
         team: team,
         latestResult: latestResult,
         totalSessions: totalSessions,
       );

  /// Returns a shallow copy of this [TrainingUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingUserSummary copyWith({
    _i2.AppUser? user,
    Object? parentOrg = _Undefined,
    _i3.Organization? team,
    Object? latestResult = _Undefined,
    int? totalSessions,
  }) {
    return TrainingUserSummary(
      user: user ?? this.user.copyWith(),
      parentOrg: parentOrg is _i3.Organization?
          ? parentOrg
          : this.parentOrg?.copyWith(),
      team: team ?? this.team.copyWith(),
      latestResult: latestResult is _i4.TrainingSessionResult?
          ? latestResult
          : this.latestResult?.copyWith(),
      totalSessions: totalSessions ?? this.totalSessions,
    );
  }
}
