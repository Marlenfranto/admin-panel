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

abstract class LocaleConfig implements _i1.SerializableModel {
  LocaleConfig._({
    this.id,
    this.organizationId,
    this.organization,
    required this.regionCode,
    required this.languageCode,
    required this.localeKey,
    required this.displayName,
    bool? enabled,
    bool? isDefault,
    this.fallbackLocaleKey,
  }) : enabled = enabled ?? true,
       isDefault = isDefault ?? false;

  factory LocaleConfig({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String regionCode,
    required String languageCode,
    required String localeKey,
    required String displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  }) = _LocaleConfigImpl;

  factory LocaleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocaleConfig(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      regionCode: jsonSerialization['regionCode'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      localeKey: jsonSerialization['localeKey'] as String,
      displayName: jsonSerialization['displayName'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      fallbackLocaleKey: jsonSerialization['fallbackLocaleKey'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String regionCode;

  String languageCode;

  String localeKey;

  String displayName;

  bool enabled;

  bool isDefault;

  String? fallbackLocaleKey;

  /// Returns a shallow copy of this [LocaleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocaleConfig copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? regionCode,
    String? languageCode,
    String? localeKey,
    String? displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocaleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'regionCode': regionCode,
      'languageCode': languageCode,
      'localeKey': localeKey,
      'displayName': displayName,
      'enabled': enabled,
      'isDefault': isDefault,
      if (fallbackLocaleKey != null) 'fallbackLocaleKey': fallbackLocaleKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocaleConfigImpl extends LocaleConfig {
  _LocaleConfigImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String regionCode,
    required String languageCode,
    required String localeKey,
    required String displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         regionCode: regionCode,
         languageCode: languageCode,
         localeKey: localeKey,
         displayName: displayName,
         enabled: enabled,
         isDefault: isDefault,
         fallbackLocaleKey: fallbackLocaleKey,
       );

  /// Returns a shallow copy of this [LocaleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocaleConfig copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? regionCode,
    String? languageCode,
    String? localeKey,
    String? displayName,
    bool? enabled,
    bool? isDefault,
    Object? fallbackLocaleKey = _Undefined,
  }) {
    return LocaleConfig(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      regionCode: regionCode ?? this.regionCode,
      languageCode: languageCode ?? this.languageCode,
      localeKey: localeKey ?? this.localeKey,
      displayName: displayName ?? this.displayName,
      enabled: enabled ?? this.enabled,
      isDefault: isDefault ?? this.isDefault,
      fallbackLocaleKey: fallbackLocaleKey is String?
          ? fallbackLocaleKey
          : this.fallbackLocaleKey,
    );
  }
}
