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
import 'app_user.dart' as _i3;
import 'organization.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class UserModuleProgress implements _i1.SerializableModel {
  UserModuleProgress._({
    this.id,
    required this.appUserId,
    this.appUser,
    required this.organizationId,
    this.organization,
    required this.moduleId,
    bool? isEnabled,
    this.deadline,
    _i2.ModuleProgressStatus? status,
    this.startedAt,
    this.completedAt,
  }) : isEnabled = isEnabled ?? true,
       status = status ?? _i2.ModuleProgressStatus.notStarted;

  factory UserModuleProgress({
    int? id,
    required int appUserId,
    _i3.AppUser? appUser,
    required int organizationId,
    _i4.Organization? organization,
    required String moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _UserModuleProgressImpl;

  factory UserModuleProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserModuleProgress(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUser>(
              jsonSerialization['appUser'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Organization>(
              jsonSerialization['organization'],
            ),
      moduleId: jsonSerialization['moduleId'] as String,
      isEnabled: jsonSerialization['isEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.ModuleProgressStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
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

  _i3.AppUser? appUser;

  int organizationId;

  _i4.Organization? organization;

  String moduleId;

  bool isEnabled;

  DateTime? deadline;

  _i2.ModuleProgressStatus status;

  DateTime? startedAt;

  DateTime? completedAt;

  /// Returns a shallow copy of this [UserModuleProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserModuleProgress copyWith({
    int? id,
    int? appUserId,
    _i3.AppUser? appUser,
    int? organizationId,
    _i4.Organization? organization,
    String? moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserModuleProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserModuleProgressImpl extends UserModuleProgress {
  _UserModuleProgressImpl({
    int? id,
    required int appUserId,
    _i3.AppUser? appUser,
    required int organizationId,
    _i4.Organization? organization,
    required String moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         appUser: appUser,
         organizationId: organizationId,
         organization: organization,
         moduleId: moduleId,
         isEnabled: isEnabled,
         deadline: deadline,
         status: status,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [UserModuleProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserModuleProgress copyWith({
    Object? id = _Undefined,
    int? appUserId,
    Object? appUser = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? moduleId,
    bool? isEnabled,
    Object? deadline = _Undefined,
    _i2.ModuleProgressStatus? status,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return UserModuleProgress(
      id: id is int? ? id : this.id,
      appUserId: appUserId ?? this.appUserId,
      appUser: appUser is _i3.AppUser? ? appUser : this.appUser?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i4.Organization?
          ? organization
          : this.organization?.copyWith(),
      moduleId: moduleId ?? this.moduleId,
      isEnabled: isEnabled ?? this.isEnabled,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}
