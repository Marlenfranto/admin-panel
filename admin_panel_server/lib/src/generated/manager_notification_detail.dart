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
import 'package:serverpod/serverpod.dart' as _i1;
import 'manager_notification.dart' as _i2;
import 'module_progress_status.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class ManagerNotificationDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ManagerNotificationDetail._({
    required this.notification,
    required this.overdueUserName,
    required this.overdueUserEmail,
    required this.organizationName,
    this.deadline,
    required this.progressStatus,
  });

  factory ManagerNotificationDetail({
    required _i2.ManagerNotification notification,
    required String overdueUserName,
    required String overdueUserEmail,
    required String organizationName,
    DateTime? deadline,
    required _i3.ModuleProgressStatus progressStatus,
  }) = _ManagerNotificationDetailImpl;

  factory ManagerNotificationDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ManagerNotificationDetail(
      notification: _i4.Protocol().deserialize<_i2.ManagerNotification>(
        jsonSerialization['notification'],
      ),
      overdueUserName: jsonSerialization['overdueUserName'] as String,
      overdueUserEmail: jsonSerialization['overdueUserEmail'] as String,
      organizationName: jsonSerialization['organizationName'] as String,
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      progressStatus: _i3.ModuleProgressStatus.fromJson(
        (jsonSerialization['progressStatus'] as String),
      ),
    );
  }

  _i2.ManagerNotification notification;

  String overdueUserName;

  String overdueUserEmail;

  String organizationName;

  DateTime? deadline;

  _i3.ModuleProgressStatus progressStatus;

  /// Returns a shallow copy of this [ManagerNotificationDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManagerNotificationDetail copyWith({
    _i2.ManagerNotification? notification,
    String? overdueUserName,
    String? overdueUserEmail,
    String? organizationName,
    DateTime? deadline,
    _i3.ModuleProgressStatus? progressStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagerNotificationDetail',
      'notification': notification.toJson(),
      'overdueUserName': overdueUserName,
      'overdueUserEmail': overdueUserEmail,
      'organizationName': organizationName,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'progressStatus': progressStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManagerNotificationDetail',
      'notification': notification.toJsonForProtocol(),
      'overdueUserName': overdueUserName,
      'overdueUserEmail': overdueUserEmail,
      'organizationName': organizationName,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'progressStatus': progressStatus.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagerNotificationDetailImpl extends ManagerNotificationDetail {
  _ManagerNotificationDetailImpl({
    required _i2.ManagerNotification notification,
    required String overdueUserName,
    required String overdueUserEmail,
    required String organizationName,
    DateTime? deadline,
    required _i3.ModuleProgressStatus progressStatus,
  }) : super._(
         notification: notification,
         overdueUserName: overdueUserName,
         overdueUserEmail: overdueUserEmail,
         organizationName: organizationName,
         deadline: deadline,
         progressStatus: progressStatus,
       );

  /// Returns a shallow copy of this [ManagerNotificationDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManagerNotificationDetail copyWith({
    _i2.ManagerNotification? notification,
    String? overdueUserName,
    String? overdueUserEmail,
    String? organizationName,
    Object? deadline = _Undefined,
    _i3.ModuleProgressStatus? progressStatus,
  }) {
    return ManagerNotificationDetail(
      notification: notification ?? this.notification.copyWith(),
      overdueUserName: overdueUserName ?? this.overdueUserName,
      overdueUserEmail: overdueUserEmail ?? this.overdueUserEmail,
      organizationName: organizationName ?? this.organizationName,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      progressStatus: progressStatus ?? this.progressStatus,
    );
  }
}
