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
import 'module_progress_status.dart' as _i2;

abstract class UserTheoryProgress implements _i1.SerializableModel {
  UserTheoryProgress._({
    this.id,
    required this.appUserId,
    required this.organizationId,
    required this.chapterId,
    required this.score,
    required this.status,
    this.lastWatchedPosition,
    this.completedAt,
  });

  factory UserTheoryProgress({
    int? id,
    required int appUserId,
    required int organizationId,
    required int chapterId,
    required int score,
    required _i2.ModuleProgressStatus status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  }) = _UserTheoryProgressImpl;

  factory UserTheoryProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserTheoryProgress(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int,
      organizationId: jsonSerialization['organizationId'] as int,
      chapterId: jsonSerialization['chapterId'] as int,
      score: jsonSerialization['score'] as int,
      status: _i2.ModuleProgressStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      lastWatchedPosition: jsonSerialization['lastWatchedPosition'] as int?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int appUserId;

  int organizationId;

  int chapterId;

  int score;

  _i2.ModuleProgressStatus status;

  int? lastWatchedPosition;

  DateTime? completedAt;

  /// Returns a shallow copy of this [UserTheoryProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserTheoryProgress copyWith({
    int? id,
    int? appUserId,
    int? organizationId,
    int? chapterId,
    int? score,
    _i2.ModuleProgressStatus? status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserTheoryProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      'organizationId': organizationId,
      'chapterId': chapterId,
      'score': score,
      'status': status.toJson(),
      if (lastWatchedPosition != null)
        'lastWatchedPosition': lastWatchedPosition,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserTheoryProgressImpl extends UserTheoryProgress {
  _UserTheoryProgressImpl({
    int? id,
    required int appUserId,
    required int organizationId,
    required int chapterId,
    required int score,
    required _i2.ModuleProgressStatus status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         organizationId: organizationId,
         chapterId: chapterId,
         score: score,
         status: status,
         lastWatchedPosition: lastWatchedPosition,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [UserTheoryProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserTheoryProgress copyWith({
    Object? id = _Undefined,
    int? appUserId,
    int? organizationId,
    int? chapterId,
    int? score,
    _i2.ModuleProgressStatus? status,
    Object? lastWatchedPosition = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return UserTheoryProgress(
      id: id is int? ? id : this.id,
      appUserId: appUserId ?? this.appUserId,
      organizationId: organizationId ?? this.organizationId,
      chapterId: chapterId ?? this.chapterId,
      score: score ?? this.score,
      status: status ?? this.status,
      lastWatchedPosition: lastWatchedPosition is int?
          ? lastWatchedPosition
          : this.lastWatchedPosition,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
