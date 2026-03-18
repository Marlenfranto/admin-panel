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
import 'organization.dart' as _i2;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class Asset implements _i1.SerializableModel {
  Asset._({
    this.id,
    this.organizationId,
    this.organization,
    required this.name,
    required this.version,
    required this.url,
    this.description,
    required this.module,
  });

  factory Asset({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String name,
    required String version,
    required String url,
    String? description,
    required String module,
  }) = _AssetImpl;

  factory Asset.fromJson(Map<String, dynamic> jsonSerialization) {
    return Asset(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as String,
      url: jsonSerialization['url'] as String,
      description: jsonSerialization['description'] as String?,
      module: jsonSerialization['module'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String name;

  String version;

  String url;

  String? description;

  String module;

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Asset copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? version,
    String? url,
    String? description,
    String? module,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Asset',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'version': version,
      'url': url,
      if (description != null) 'description': description,
      'module': module,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetImpl extends Asset {
  _AssetImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String name,
    required String version,
    required String url,
    String? description,
    required String module,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         version: version,
         url: url,
         description: description,
         module: module,
       );

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Asset copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? name,
    String? version,
    String? url,
    Object? description = _Undefined,
    String? module,
  }) {
    return Asset(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      version: version ?? this.version,
      url: url ?? this.url,
      description: description is String? ? description : this.description,
      module: module ?? this.module,
    );
  }
}
