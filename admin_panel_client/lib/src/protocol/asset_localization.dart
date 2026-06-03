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
import 'asset.dart' as _i2;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class AssetLocalization implements _i1.SerializableModel {
  AssetLocalization._({
    this.id,
    required this.assetId,
    this.asset,
    required this.localeKey,
    required this.name,
    this.description,
    required this.url,
  });

  factory AssetLocalization({
    int? id,
    required int assetId,
    _i2.Asset? asset,
    required String localeKey,
    required String name,
    String? description,
    required String url,
  }) = _AssetLocalizationImpl;

  factory AssetLocalization.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetLocalization(
      id: jsonSerialization['id'] as int?,
      assetId: jsonSerialization['assetId'] as int,
      asset: jsonSerialization['asset'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Asset>(jsonSerialization['asset']),
      localeKey: jsonSerialization['localeKey'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      url: jsonSerialization['url'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int assetId;

  _i2.Asset? asset;

  String localeKey;

  String name;

  String? description;

  String url;

  /// Returns a shallow copy of this [AssetLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetLocalization copyWith({
    int? id,
    int? assetId,
    _i2.Asset? asset,
    String? localeKey,
    String? name,
    String? description,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetLocalization',
      if (id != null) 'id': id,
      'assetId': assetId,
      if (asset != null) 'asset': asset?.toJson(),
      'localeKey': localeKey,
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

class _AssetLocalizationImpl extends AssetLocalization {
  _AssetLocalizationImpl({
    int? id,
    required int assetId,
    _i2.Asset? asset,
    required String localeKey,
    required String name,
    String? description,
    required String url,
  }) : super._(
         id: id,
         assetId: assetId,
         asset: asset,
         localeKey: localeKey,
         name: name,
         description: description,
         url: url,
       );

  /// Returns a shallow copy of this [AssetLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetLocalization copyWith({
    Object? id = _Undefined,
    int? assetId,
    Object? asset = _Undefined,
    String? localeKey,
    String? name,
    Object? description = _Undefined,
    String? url,
  }) {
    return AssetLocalization(
      id: id is int? ? id : this.id,
      assetId: assetId ?? this.assetId,
      asset: asset is _i2.Asset? ? asset : this.asset?.copyWith(),
      localeKey: localeKey ?? this.localeKey,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      url: url ?? this.url,
    );
  }
}
