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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i2;
import 'organization.dart' as _i3;
import 'module_config_public.dart' as _i4;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i5;

abstract class LoginResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LoginResponse._({
    required this.success,
    this.userInfo,
    this.organization,
    this.moduleConfig,
    this.keyId,
    this.key,
  });

  factory LoginResponse({
    required bool success,
    _i2.UserInfo? userInfo,
    _i3.Organization? organization,
    _i4.ModuleConfigPublic? moduleConfig,
    int? keyId,
    String? key,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.UserInfo>(
              jsonSerialization['userInfo'],
            ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      moduleConfig: jsonSerialization['moduleConfig'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.ModuleConfigPublic>(
              jsonSerialization['moduleConfig'],
            ),
      keyId: jsonSerialization['keyId'] as int?,
      key: jsonSerialization['key'] as String?,
    );
  }

  bool success;

  _i2.UserInfo? userInfo;

  _i3.Organization? organization;

  _i4.ModuleConfigPublic? moduleConfig;

  int? keyId;

  String? key;

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LoginResponse copyWith({
    bool? success,
    _i2.UserInfo? userInfo,
    _i3.Organization? organization,
    _i4.ModuleConfigPublic? moduleConfig,
    int? keyId,
    String? key,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoginResponse',
      'success': success,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      if (moduleConfig != null) 'moduleConfig': moduleConfig?.toJson(),
      if (keyId != null) 'keyId': keyId,
      if (key != null) 'key': key,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LoginResponse',
      'success': success,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      if (moduleConfig != null)
        'moduleConfig': moduleConfig?.toJsonForProtocol(),
      if (keyId != null) 'keyId': keyId,
      if (key != null) 'key': key,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoginResponseImpl extends LoginResponse {
  _LoginResponseImpl({
    required bool success,
    _i2.UserInfo? userInfo,
    _i3.Organization? organization,
    _i4.ModuleConfigPublic? moduleConfig,
    int? keyId,
    String? key,
  }) : super._(
         success: success,
         userInfo: userInfo,
         organization: organization,
         moduleConfig: moduleConfig,
         keyId: keyId,
         key: key,
       );

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LoginResponse copyWith({
    bool? success,
    Object? userInfo = _Undefined,
    Object? organization = _Undefined,
    Object? moduleConfig = _Undefined,
    Object? keyId = _Undefined,
    Object? key = _Undefined,
  }) {
    return LoginResponse(
      success: success ?? this.success,
      userInfo: userInfo is _i2.UserInfo?
          ? userInfo
          : this.userInfo?.copyWith(),
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      moduleConfig: moduleConfig is _i4.ModuleConfigPublic?
          ? moduleConfig
          : this.moduleConfig?.copyWith(),
      keyId: keyId is int? ? keyId : this.keyId,
      key: key is String? ? key : this.key,
    );
  }
}
