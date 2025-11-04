/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'app_user.dart' as _i2;
import 'organization_user_link.dart' as _i3;

abstract class Organization implements _i1.SerializableModel {
  Organization._({
    this.id,
    required this.name,
    this.managerId,
    this.manager,
    this.users,
  });

  factory Organization({
    int? id,
    required String name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      managerId: jsonSerialization['managerId'] as int?,
      manager: jsonSerialization['manager'] == null
          ? null
          : _i2.AppUser.fromJson(
              (jsonSerialization['manager'] as Map<String, dynamic>)),
      users: (jsonSerialization['users'] as List?)
          ?.map((e) =>
              _i3.OrganizationUserLink.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  int? managerId;

  _i2.AppUser? manager;

  List<_i3.OrganizationUserLink>? users;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    int? id,
    String? name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (managerId != null) 'managerId': managerId,
      if (manager != null) 'manager': manager?.toJson(),
      if (users != null) 'users': users?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    int? id,
    required String name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  }) : super._(
          id: id,
          name: name,
          managerId: managerId,
          manager: manager,
          users: users,
        );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    String? name,
    Object? managerId = _Undefined,
    Object? manager = _Undefined,
    Object? users = _Undefined,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      managerId: managerId is int? ? managerId : this.managerId,
      manager: manager is _i2.AppUser? ? manager : this.manager?.copyWith(),
      users: users is List<_i3.OrganizationUserLink>?
          ? users
          : this.users?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
