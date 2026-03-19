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

abstract class ManagerNotification implements _i1.SerializableModel {
  ManagerNotification._({
    this.id,
    required this.managerId,
    required this.overdueUserId,
    required this.organizationId,
    required this.moduleId,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory ManagerNotification({
    int? id,
    required int managerId,
    required int overdueUserId,
    required int organizationId,
    required String moduleId,
    bool? isRead,
    required DateTime createdAt,
  }) = _ManagerNotificationImpl;

  factory ManagerNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagerNotification(
      id: jsonSerialization['id'] as int?,
      managerId: jsonSerialization['managerId'] as int,
      overdueUserId: jsonSerialization['overdueUserId'] as int,
      organizationId: jsonSerialization['organizationId'] as int,
      moduleId: jsonSerialization['moduleId'] as String,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int managerId;

  int overdueUserId;

  int organizationId;

  String moduleId;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [ManagerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManagerNotification copyWith({
    int? id,
    int? managerId,
    int? overdueUserId,
    int? organizationId,
    String? moduleId,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagerNotification',
      if (id != null) 'id': id,
      'managerId': managerId,
      'overdueUserId': overdueUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagerNotificationImpl extends ManagerNotification {
  _ManagerNotificationImpl({
    int? id,
    required int managerId,
    required int overdueUserId,
    required int organizationId,
    required String moduleId,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         managerId: managerId,
         overdueUserId: overdueUserId,
         organizationId: organizationId,
         moduleId: moduleId,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ManagerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManagerNotification copyWith({
    Object? id = _Undefined,
    int? managerId,
    int? overdueUserId,
    int? organizationId,
    String? moduleId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return ManagerNotification(
      id: id is int? ? id : this.id,
      managerId: managerId ?? this.managerId,
      overdueUserId: overdueUserId ?? this.overdueUserId,
      organizationId: organizationId ?? this.organizationId,
      moduleId: moduleId ?? this.moduleId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
