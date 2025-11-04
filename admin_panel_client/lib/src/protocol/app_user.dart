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
import 'role.dart' as _i2;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i3;
import 'tools.dart' as _i4;
import 'organization_user_link.dart' as _i5;

abstract class AppUser implements _i1.SerializableModel {
  AppUser._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    _i2.Role? role,
    required this.tools,
    this.organizations,
  }) : role = role ?? _i2.Role.User;

  factory AppUser({
    int? id,
    required int userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    required _i4.Tools tools,
    List<_i5.OrganizationUserLink>? organizations,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i3.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      role: _i2.Role.fromJson((jsonSerialization['role'] as String)),
      tools: _i4.Tools.fromJson(
          (jsonSerialization['tools'] as Map<String, dynamic>)),
      organizations: (jsonSerialization['organizations'] as List?)
          ?.map((e) =>
              _i5.OrganizationUserLink.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userInfoId;

  _i3.UserInfo? userInfo;

  _i2.Role role;

  _i4.Tools tools;

  List<_i5.OrganizationUserLink>? organizations;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    int? id,
    int? userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    _i4.Tools? tools,
    List<_i5.OrganizationUserLink>? organizations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'role': role.toJson(),
      'tools': tools.toJson(),
      if (organizations != null)
        'organizations': organizations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    required int userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    required _i4.Tools tools,
    List<_i5.OrganizationUserLink>? organizations,
  }) : super._(
          id: id,
          userInfoId: userInfoId,
          userInfo: userInfo,
          role: role,
          tools: tools,
          organizations: organizations,
        );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i2.Role? role,
    _i4.Tools? tools,
    Object? organizations = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo:
          userInfo is _i3.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      role: role ?? this.role,
      tools: tools ?? this.tools.copyWith(),
      organizations: organizations is List<_i5.OrganizationUserLink>?
          ? organizations
          : this.organizations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
