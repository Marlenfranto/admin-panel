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

abstract class Region implements _i1.SerializableModel {
  Region._({
    this.id,
    this.organizationId,
    this.organization,
    required this.code,
    required this.displayName,
    bool? enabled,
  }) : enabled = enabled ?? true;

  factory Region({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String code,
    required String displayName,
    bool? enabled,
  }) = _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      code: jsonSerialization['code'] as String,
      displayName: jsonSerialization['displayName'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String code;

  String displayName;

  bool enabled;

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Region copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? code,
    String? displayName,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Region',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'code': code,
      'displayName': displayName,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String code,
    required String displayName,
    bool? enabled,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         code: code,
         displayName: displayName,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Region copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? code,
    String? displayName,
    bool? enabled,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      code: code ?? this.code,
      displayName: displayName ?? this.displayName,
      enabled: enabled ?? this.enabled,
    );
  }
}
