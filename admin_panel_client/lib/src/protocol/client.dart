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
import 'dart:async' as _i2;
import 'package:admin_panel_client/src/protocol/organization.dart' as _i3;
import 'package:admin_panel_client/src/protocol/app_user.dart' as _i4;
import 'package:admin_panel_client/src/protocol/role.dart' as _i5;
import 'package:admin_panel_client/src/protocol/login_response.dart' as _i6;
import 'package:admin_panel_client/src/protocol/tools.dart' as _i7;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i8;
import 'protocol.dart' as _i9;

/// {@category Endpoint}
class EndpointAdmin extends _i1.EndpointRef {
  EndpointAdmin(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  _i2.Future<_i3.Organization?> createOrganization(String name) =>
      caller.callServerEndpoint<_i3.Organization?>(
        'admin',
        'createOrganization',
        {'name': name},
      );

  _i2.Future<_i4.AppUser?> createUserAndAssignToOrg(
    String userName,
    String email,
    String password,
    _i5.Role role,
    int organizationId,
  ) =>
      caller.callServerEndpoint<_i4.AppUser?>(
        'admin',
        'createUserAndAssignToOrg',
        {
          'userName': userName,
          'email': email,
          'password': password,
          'role': role,
          'organizationId': organizationId,
        },
      );

  _i2.Future<bool> assignManagerToOrg(
    int managerAppUserId,
    int organizationId,
  ) =>
      caller.callServerEndpoint<bool>(
        'admin',
        'assignManagerToOrg',
        {
          'managerAppUserId': managerAppUserId,
          'organizationId': organizationId,
        },
      );

  _i2.Future<List<_i3.Organization>> getAllOrganizations() =>
      caller.callServerEndpoint<List<_i3.Organization>>(
        'admin',
        'getAllOrganizations',
        {},
      );

  _i2.Future<List<_i4.AppUser>> getAllUsers({_i5.Role? role}) =>
      caller.callServerEndpoint<List<_i4.AppUser>>(
        'admin',
        'getAllUsers',
        {'role': role},
      );
}

/// {@category Endpoint}
class EndpointManager extends _i1.EndpointRef {
  EndpointManager(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'manager';

  _i2.Future<_i3.Organization?> getManagedOrganization() =>
      caller.callServerEndpoint<_i3.Organization?>(
        'manager',
        'getManagedOrganization',
        {},
      );

  _i2.Future<_i4.AppUser?> createUserAndAssignToOrg(
    String userName,
    String email,
    String password,
    _i5.Role role,
    int organizationId,
  ) =>
      caller.callServerEndpoint<_i4.AppUser?>(
        'manager',
        'createUserAndAssignToOrg',
        {
          'userName': userName,
          'email': email,
          'password': password,
          'role': role,
          'organizationId': organizationId,
        },
      );

  _i2.Future<bool> removeUserFromOrganization(
    int appUserId,
    int organizationId,
  ) =>
      caller.callServerEndpoint<bool>(
        'manager',
        'removeUserFromOrganization',
        {
          'appUserId': appUserId,
          'organizationId': organizationId,
        },
      );
}

/// {@category Endpoint}
class EndpointPublicApi extends _i1.EndpointRef {
  EndpointPublicApi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'publicApi';

  _i2.Future<_i6.LoginResponse> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<_i6.LoginResponse>(
        'publicApi',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  _i2.Future<_i7.Tools?> updateTools(
    int appUserId,
    String apiKey,
    _i7.Tools newTools,
  ) =>
      caller.callServerEndpoint<_i7.Tools?>(
        'publicApi',
        'updateTools',
        {
          'appUserId': appUserId,
          'apiKey': apiKey,
          'newTools': newTools,
        },
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i4.AppUser?> getMyPermissions() =>
      caller.callServerEndpoint<_i4.AppUser?>(
        'user',
        'getMyPermissions',
        {},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i8.Caller(client);
  }

  late final _i8.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i9.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    admin = EndpointAdmin(this);
    manager = EndpointManager(this);
    publicApi = EndpointPublicApi(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointManager manager;

  late final EndpointPublicApi publicApi;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'admin': admin,
        'manager': manager,
        'publicApi': publicApi,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
