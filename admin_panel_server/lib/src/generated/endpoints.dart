/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/admin_endpoint.dart' as _i2;
import '../endpoints/manager_endpoint.dart' as _i3;
import '../endpoints/public_api_endpoint.dart' as _i4;
import '../endpoints/user_endpoint.dart' as _i5;
import 'package:admin_panel_server/src/generated/role.dart' as _i6;
import 'package:admin_panel_server/src/generated/tools.dart' as _i7;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i8;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'admin': _i2.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'manager': _i3.ManagerEndpoint()
        ..initialize(
          server,
          'manager',
          null,
        ),
      'publicApi': _i4.PublicApiEndpoint()
        ..initialize(
          server,
          'publicApi',
          null,
        ),
      'user': _i5.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'createOrganization': _i1.MethodConnector(
          name: 'createOrganization',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).createOrganization(
            session,
            params['name'],
          ),
        ),
        'createUserAndAssignToOrg': _i1.MethodConnector(
          name: 'createUserAndAssignToOrg',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i6.Role>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint)
                  .createUserAndAssignToOrg(
            session,
            params['userName'],
            params['email'],
            params['password'],
            params['role'],
            params['organizationId'],
          ),
        ),
        'assignManagerToOrg': _i1.MethodConnector(
          name: 'assignManagerToOrg',
          params: {
            'managerAppUserId': _i1.ParameterDescription(
              name: 'managerAppUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).assignManagerToOrg(
            session,
            params['managerAppUserId'],
            params['organizationId'],
          ),
        ),
        'getAllOrganizations': _i1.MethodConnector(
          name: 'getAllOrganizations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint)
                  .getAllOrganizations(session),
        ),
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i6.Role?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['admin'] as _i2.AdminEndpoint).getAllUsers(
            session,
            role: params['role'],
          ),
        ),
      },
    );
    connectors['manager'] = _i1.EndpointConnector(
      name: 'manager',
      endpoint: endpoints['manager']!,
      methodConnectors: {
        'getManagedOrganization': _i1.MethodConnector(
          name: 'getManagedOrganization',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedOrganization(session),
        ),
        'createUserAndAssignToOrg': _i1.MethodConnector(
          name: 'createUserAndAssignToOrg',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i6.Role>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['manager'] as _i3.ManagerEndpoint)
                  .createUserAndAssignToOrg(
            session,
            params['userName'],
            params['email'],
            params['password'],
            params['role'],
            params['organizationId'],
          ),
        ),
        'removeUserFromOrganization': _i1.MethodConnector(
          name: 'removeUserFromOrganization',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['manager'] as _i3.ManagerEndpoint)
                  .removeUserFromOrganization(
            session,
            params['appUserId'],
            params['organizationId'],
          ),
        ),
      },
    );
    connectors['publicApi'] = _i1.EndpointConnector(
      name: 'publicApi',
      endpoint: endpoints['publicApi']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['publicApi'] as _i4.PublicApiEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'updateTools': _i1.MethodConnector(
          name: 'updateTools',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newTools': _i1.ParameterDescription(
              name: 'newTools',
              type: _i1.getType<_i7.Tools>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['publicApi'] as _i4.PublicApiEndpoint).updateTools(
            session,
            params['appUserId'],
            params['apiKey'],
            params['newTools'],
          ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getMyPermissions': _i1.MethodConnector(
          name: 'getMyPermissions',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i5.UserEndpoint).getMyPermissions(session),
        )
      },
    );
    modules['serverpod_auth'] = _i8.Endpoints()..initializeEndpoints(server);
  }
}
