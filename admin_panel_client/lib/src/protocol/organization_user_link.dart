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
import 'organization.dart' as _i2;
import 'app_user.dart' as _i3;

abstract class OrganizationUserLink implements _i1.SerializableModel {
  OrganizationUserLink._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.appUserId,
    this.appUser,
  });

  factory OrganizationUserLink({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int appUserId,
    _i3.AppUser? appUser,
  }) = _OrganizationUserLinkImpl;

  factory OrganizationUserLink.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationUserLink(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i2.Organization.fromJson(
              (jsonSerialization['organization'] as Map<String, dynamic>)),
      appUserId: jsonSerialization['appUserId'] as int,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i3.AppUser.fromJson(
              (jsonSerialization['appUser'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int organizationId;

  _i2.Organization? organization;

  int appUserId;

  _i3.AppUser? appUser;

  /// Returns a shallow copy of this [OrganizationUserLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationUserLink copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? appUserId,
    _i3.AppUser? appUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationUserLinkImpl extends OrganizationUserLink {
  _OrganizationUserLinkImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int appUserId,
    _i3.AppUser? appUser,
  }) : super._(
          id: id,
          organizationId: organizationId,
          organization: organization,
          appUserId: appUserId,
          appUser: appUser,
        );

  /// Returns a shallow copy of this [OrganizationUserLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationUserLink copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? appUserId,
    Object? appUser = _Undefined,
  }) {
    return OrganizationUserLink(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      appUserId: appUserId ?? this.appUserId,
      appUser: appUser is _i3.AppUser? ? appUser : this.appUser?.copyWith(),
    );
  }
}
