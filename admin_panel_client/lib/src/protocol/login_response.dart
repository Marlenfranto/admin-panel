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
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i2;
import 'app_user.dart' as _i3;

abstract class LoginResponse implements _i1.SerializableModel {
  LoginResponse._({
    required this.success,
    this.userInfo,
    this.appUser,
    this.keyId,
    this.key,
  });

  factory LoginResponse({
    required bool success,
    _i2.UserInfo? userInfo,
    _i3.AppUser? appUser,
    int? keyId,
    String? key,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      success: jsonSerialization['success'] as bool,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i2.UserInfo.fromJson(
              (jsonSerialization['userInfo'] as Map<String, dynamic>)),
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i3.AppUser.fromJson(
              (jsonSerialization['appUser'] as Map<String, dynamic>)),
      keyId: jsonSerialization['keyId'] as int?,
      key: jsonSerialization['key'] as String?,
    );
  }

  bool success;

  _i2.UserInfo? userInfo;

  _i3.AppUser? appUser;

  int? keyId;

  String? key;

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LoginResponse copyWith({
    bool? success,
    _i2.UserInfo? userInfo,
    _i3.AppUser? appUser,
    int? keyId,
    String? key,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      if (appUser != null) 'appUser': appUser?.toJson(),
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
    _i3.AppUser? appUser,
    int? keyId,
    String? key,
  }) : super._(
          success: success,
          userInfo: userInfo,
          appUser: appUser,
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
    Object? appUser = _Undefined,
    Object? keyId = _Undefined,
    Object? key = _Undefined,
  }) {
    return LoginResponse(
      success: success ?? this.success,
      userInfo:
          userInfo is _i2.UserInfo? ? userInfo : this.userInfo?.copyWith(),
      appUser: appUser is _i3.AppUser? ? appUser : this.appUser?.copyWith(),
      keyId: keyId is int? ? keyId : this.keyId,
      key: key is String? ? key : this.key,
    );
  }
}
