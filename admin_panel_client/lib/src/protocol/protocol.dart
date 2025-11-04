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
import 'app_user.dart' as _i2;
import 'login_response.dart' as _i3;
import 'organization.dart' as _i4;
import 'organization_user_link.dart' as _i5;
import 'role.dart' as _i6;
import 'tools.dart' as _i7;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i8;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i9;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i10;
export 'app_user.dart';
export 'login_response.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'role.dart';
export 'tools.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.AppUser) {
      return _i2.AppUser.fromJson(data) as T;
    }
    if (t == _i3.LoginResponse) {
      return _i3.LoginResponse.fromJson(data) as T;
    }
    if (t == _i4.Organization) {
      return _i4.Organization.fromJson(data) as T;
    }
    if (t == _i5.OrganizationUserLink) {
      return _i5.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i6.Role) {
      return _i6.Role.fromJson(data) as T;
    }
    if (t == _i7.Tools) {
      return _i7.Tools.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AppUser?>()) {
      return (data != null ? _i2.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.LoginResponse?>()) {
      return (data != null ? _i3.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Organization?>()) {
      return (data != null ? _i4.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.OrganizationUserLink?>()) {
      return (data != null ? _i5.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Role?>()) {
      return (data != null ? _i6.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.Tools?>()) {
      return (data != null ? _i7.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i5.OrganizationUserLink>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.OrganizationUserLink>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.OrganizationUserLink>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.OrganizationUserLink>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i8.Organization>) {
      return (data as List)
          .map((e) => deserialize<_i8.Organization>(e))
          .toList() as T;
    }
    if (t == List<_i9.AppUser>) {
      return (data as List).map((e) => deserialize<_i9.AppUser>(e)).toList()
          as T;
    }
    try {
      return _i10.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.AppUser) {
      return 'AppUser';
    }
    if (data is _i3.LoginResponse) {
      return 'LoginResponse';
    }
    if (data is _i4.Organization) {
      return 'Organization';
    }
    if (data is _i5.OrganizationUserLink) {
      return 'OrganizationUserLink';
    }
    if (data is _i6.Role) {
      return 'Role';
    }
    if (data is _i7.Tools) {
      return 'Tools';
    }
    className = _i10.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i2.AppUser>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i3.LoginResponse>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i4.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i5.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i6.Role>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i7.Tools>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i10.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
