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
import 'organization_user_link.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class Organization implements _i1.SerializableModel {
  Organization._({
    this.id,
    required this.name,
    this.imageUrl,
    int? contentVersion,
    this.managerId,
    this.manager,
    this.parentId,
    this.parent,
    this.children,
    this.users,
  }) : contentVersion = contentVersion ?? 1;

  factory Organization({
    int? id,
    required String name,
    String? imageUrl,
    int? contentVersion,
    int? managerId,
    _i2.AppUser? manager,
    int? parentId,
    _i3.Organization? parent,
    List<_i3.Organization>? children,
    List<_i4.OrganizationUserLink>? users,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      contentVersion: jsonSerialization['contentVersion'] as int?,
      managerId: jsonSerialization['managerId'] as int?,
      manager: jsonSerialization['manager'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.AppUser>(
              jsonSerialization['manager'],
            ),
      parentId: jsonSerialization['parentId'] as int?,
      parent: jsonSerialization['parent'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['parent'],
            ),
      children: jsonSerialization['children'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.Organization>>(
              jsonSerialization['children'],
            ),
      users: jsonSerialization['users'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.OrganizationUserLink>>(
              jsonSerialization['users'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String? imageUrl;

  int contentVersion;

  int? managerId;

  _i2.AppUser? manager;

  int? parentId;

  _i3.Organization? parent;

  List<_i3.Organization>? children;

  List<_i4.OrganizationUserLink>? users;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? contentVersion,
    int? managerId,
    _i2.AppUser? manager,
    int? parentId,
    _i3.Organization? parent,
    List<_i3.Organization>? children,
    List<_i4.OrganizationUserLink>? users,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Organization',
      if (id != null) 'id': id,
      'name': name,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'contentVersion': contentVersion,
      if (managerId != null) 'managerId': managerId,
      if (manager != null) 'manager': manager?.toJson(),
      if (parentId != null) 'parentId': parentId,
      if (parent != null) 'parent': parent?.toJson(),
      if (children != null)
        'children': children?.toJson(valueToJson: (v) => v.toJson()),
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
    String? imageUrl,
    int? contentVersion,
    int? managerId,
    _i2.AppUser? manager,
    int? parentId,
    _i3.Organization? parent,
    List<_i3.Organization>? children,
    List<_i4.OrganizationUserLink>? users,
  }) : super._(
         id: id,
         name: name,
         imageUrl: imageUrl,
         contentVersion: contentVersion,
         managerId: managerId,
         manager: manager,
         parentId: parentId,
         parent: parent,
         children: children,
         users: users,
       );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    String? name,
    Object? imageUrl = _Undefined,
    int? contentVersion,
    Object? managerId = _Undefined,
    Object? manager = _Undefined,
    Object? parentId = _Undefined,
    Object? parent = _Undefined,
    Object? children = _Undefined,
    Object? users = _Undefined,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      contentVersion: contentVersion ?? this.contentVersion,
      managerId: managerId is int? ? managerId : this.managerId,
      manager: manager is _i2.AppUser? ? manager : this.manager?.copyWith(),
      parentId: parentId is int? ? parentId : this.parentId,
      parent: parent is _i3.Organization? ? parent : this.parent?.copyWith(),
      children: children is List<_i3.Organization>?
          ? children
          : this.children?.map((e0) => e0.copyWith()).toList(),
      users: users is List<_i4.OrganizationUserLink>?
          ? users
          : this.users?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
