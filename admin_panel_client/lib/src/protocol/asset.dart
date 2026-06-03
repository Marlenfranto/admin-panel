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
    required this.version,
    required this.module,
    String? name,
    this.description,
    String? url,
  }) : name = name ?? '',
       url = url ?? '';

  factory Asset({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String version,
    required String module,
    String? name,
    String? description,
    String? url,
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
      version: jsonSerialization['version'] as String,
      module: jsonSerialization['module'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      url: jsonSerialization['url'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String version;

  String module;

  String name;

  String? description;

  String url;

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Asset copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? version,
    String? module,
    String? name,
    String? description,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Asset',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'version': version,
      'module': module,
      'name': name,
      if (description != null) 'description': description,
      'url': url,
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
    required String version,
    required String module,
    String? name,
    String? description,
    String? url,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         version: version,
         module: module,
         name: name,
         description: description,
         url: url,
       );

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Asset copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? version,
    String? module,
    String? name,
    Object? description = _Undefined,
    String? url,
  }) {
    return Asset(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      version: version ?? this.version,
      module: module ?? this.module,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      url: url ?? this.url,
    );
  }
}
