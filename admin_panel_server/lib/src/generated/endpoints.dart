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
import '../endpoints/admin_endpoint.dart' as _i2;
import '../endpoints/manager_endpoint.dart' as _i3;
import '../endpoints/organization_admin_endpoint.dart' as _i4;
import '../endpoints/public_api_endpoint.dart' as _i5;
import '../endpoints/user_endpoint.dart' as _i6;
import 'package:admin_panel_server/src/generated/role.dart' as _i7;
import 'package:admin_panel_server/src/generated/supported_language.dart'
    as _i8;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i9;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i10;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i11;
import 'package:admin_panel_server/src/generated/asset.dart' as _i12;
import 'package:admin_panel_server/src/generated/module_progress_status.dart'
    as _i13;
import 'package:admin_panel_server/src/generated/training_criteria_score.dart'
    as _i14;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i15;

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
      'organizationAdmin': _i4.OrganizationAdminEndpoint()
        ..initialize(
          server,
          'organizationAdmin',
          null,
        ),
      'publicApi': _i5.PublicApiEndpoint()
        ..initialize(
          server,
          'publicApi',
          null,
        ),
      'user': _i6.UserEndpoint()
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
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).createOrganization(
                    session,
                    params['name'],
                    params['imageUrl'],
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
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).assignManagerToOrg(
                    session,
                    params['managerAppUserId'],
                    params['organizationId'],
                  ),
        ),
        'updateOrganization': _i1.MethodConnector(
          name: 'updateOrganization',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).updateOrganization(
                    session,
                    params['id'],
                    params['name'],
                    params['imageUrl'],
                  ),
        ),
        'deleteOrganization': _i1.MethodConnector(
          name: 'deleteOrganization',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).deleteOrganization(
                    session,
                    params['id'],
                  ),
        ),
        'getAllOrganizations': _i1.MethodConnector(
          name: 'getAllOrganizations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getAllOrganizations(session),
        ),
        'updateUser': _i1.MethodConnector(
          name: 'updateUser',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).updateUser(
                session,
                params['appUserId'],
                params['userName'],
                params['role'],
              ),
        ),
        'updateOrgAdminUser': _i1.MethodConnector(
          name: 'updateOrgAdminUser',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).updateOrgAdminUser(
                    session,
                    params['appUserId'],
                    params['userName'],
                    params['role'],
                  ),
        ),
        'adminResetUserPassword': _i1.MethodConnector(
          name: 'adminResetUserPassword',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .adminResetUserPassword(
                    session,
                    params['appUserId'],
                    params['newPassword'],
                  ),
        ),
        'deleteUser': _i1.MethodConnector(
          name: 'deleteUser',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).deleteUser(
                session,
                params['appUserId'],
              ),
        ),
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i7.Role?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).getAllUsers(
                session,
                role: params['role'],
              ),
        ),
        'setModuleConfig': _i1.MethodConnector(
          name: 'setModuleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'theoryModule': _i1.ParameterDescription(
              name: 'theoryModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'aiExpertModule': _i1.ParameterDescription(
              name: 'aiExpertModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'smartTrainingModule': _i1.ParameterDescription(
              name: 'smartTrainingModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'assessmentModule': _i1.ParameterDescription(
              name: 'assessmentModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'defaultLanguage': _i1.ParameterDescription(
              name: 'defaultLanguage',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'supportedLanguages': _i1.ParameterDescription(
              name: 'supportedLanguages',
              type: _i1.getType<List<_i8.SupportedLanguage>>(),
              nullable: false,
            ),
            'aiChatPrompt': _i1.ParameterDescription(
              name: 'aiChatPrompt',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'passingPercentage': _i1.ParameterDescription(
              name: 'passingPercentage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).setModuleConfig(
                    session,
                    params['organizationId'],
                    params['theoryModule'],
                    params['aiExpertModule'],
                    params['smartTrainingModule'],
                    params['assessmentModule'],
                    params['defaultLanguage'],
                    params['supportedLanguages'],
                    params['aiChatPrompt'],
                    params['passingPercentage'],
                  ),
        ),
        'getModuleConfig': _i1.MethodConnector(
          name: 'getModuleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).getModuleConfig(
                    session,
                    params['organizationId'],
                  ),
        ),
        'getTheoryChapters': _i1.MethodConnector(
          name: 'getTheoryChapters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).getTheoryChapters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertTheoryChapter': _i1.MethodConnector(
          name: 'upsertTheoryChapter',
          params: {
            'chapter': _i1.ParameterDescription(
              name: 'chapter',
              type: _i1.getType<_i9.TheoryChapter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).upsertTheoryChapter(
                    session,
                    params['chapter'],
                  ),
        ),
        'deleteTheoryChapter': _i1.MethodConnector(
          name: 'deleteTheoryChapter',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).deleteTheoryChapter(
                    session,
                    params['chapterId'],
                  ),
        ),
        'getTrainingParameters': _i1.MethodConnector(
          name: 'getTrainingParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getTrainingParameters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertTrainingParameter': _i1.MethodConnector(
          name: 'upsertTrainingParameter',
          params: {
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i10.TrainingParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertTrainingParameter(
                    session,
                    params['param'],
                  ),
        ),
        'deleteTrainingParameter': _i1.MethodConnector(
          name: 'deleteTrainingParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteTrainingParameter(
                    session,
                    params['paramId'],
                  ),
        ),
        'getAssessmentParameters': _i1.MethodConnector(
          name: 'getAssessmentParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getAssessmentParameters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertAssessmentParameter': _i1.MethodConnector(
          name: 'upsertAssessmentParameter',
          params: {
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i11.AssessmentParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertAssessmentParameter(
                    session,
                    params['param'],
                  ),
        ),
        'deleteAssessmentParameter': _i1.MethodConnector(
          name: 'deleteAssessmentParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteAssessmentParameter(
                    session,
                    params['paramId'],
                  ),
        ),
        'getAssets': _i1.MethodConnector(
          name: 'getAssets',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).getAssets(
                session,
                params['organizationId'],
              ),
        ),
        'upsertAsset': _i1.MethodConnector(
          name: 'upsertAsset',
          params: {
            'asset': _i1.ParameterDescription(
              name: 'asset',
              type: _i1.getType<_i12.Asset>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).upsertAsset(
                session,
                params['asset'],
              ),
        ),
        'deleteAsset': _i1.MethodConnector(
          name: 'deleteAsset',
          params: {
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).deleteAsset(
                session,
                params['assetId'],
              ),
        ),
        'getUserModuleProgress': _i1.MethodConnector(
          name: 'getUserModuleProgress',
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getUserModuleProgress(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                  ),
        ),
        'setUserModuleProgress': _i1.MethodConnector(
          name: 'setUserModuleProgress',
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
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isEnabled': _i1.ParameterDescription(
              name: 'isEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .setUserModuleProgress(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                    params['moduleId'],
                    params['isEnabled'],
                    params['deadline'],
                  ),
        ),
        'getTrainingHistory': _i1.MethodConnector(
          name: 'getTrainingHistory',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).getTrainingHistory(
                    session,
                    page: params['page'],
                    limit: params['limit'],
                    search: params['search'],
                    organizationId: params['organizationId'],
                    teamId: params['teamId'],
                    start: params['start'],
                    end: params['end'],
                    passed: params['passed'],
                  ),
        ),
        'getTrainingUserSummaries': _i1.MethodConnector(
          name: 'getTrainingUserSummaries',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getTrainingUserSummaries(
                    session,
                    page: params['page'],
                    limit: params['limit'],
                    search: params['search'],
                    organizationId: params['organizationId'],
                    teamId: params['teamId'],
                    start: params['start'],
                    end: params['end'],
                    passed: params['passed'],
                  ),
        ),
        'getUserTrainingHistory': _i1.MethodConnector(
          name: 'getUserTrainingHistory',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getUserTrainingHistory(
                    session,
                    params['appUserId'],
                  ),
        ),
        'updateUserModuleStatus': _i1.MethodConnector(
          name: 'updateUserModuleStatus',
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
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.ModuleProgressStatus>(),
              nullable: false,
            ),
            'startedAt': _i1.ParameterDescription(
              name: 'startedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'completedAt': _i1.ParameterDescription(
              name: 'completedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .updateUserModuleStatus(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                    params['moduleId'],
                    params['status'],
                    params['startedAt'],
                    params['completedAt'],
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedOrganization(session),
        ),
        'getManagedOrganizations': _i1.MethodConnector(
          name: 'getManagedOrganizations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedOrganizations(session),
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
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .createUserAndAssignToOrg(
                    session,
                    params['userName'],
                    params['email'],
                    params['password'],
                    params['role'],
                    params['organizationId'],
                  ),
        ),
        'getTeams': _i1.MethodConnector(
          name: 'getTeams',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint).getTeams(
                session,
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .removeUserFromOrganization(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                  ),
        ),
        'getMyModuleConfig': _i1.MethodConnector(
          name: 'getMyModuleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getMyModuleConfig(
                    session,
                    params['organizationId'],
                  ),
        ),
        'updateMyModuleConfig': _i1.MethodConnector(
          name: 'updateMyModuleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'theoryModule': _i1.ParameterDescription(
              name: 'theoryModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'aiExpertModule': _i1.ParameterDescription(
              name: 'aiExpertModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'smartTrainingModule': _i1.ParameterDescription(
              name: 'smartTrainingModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'assessmentModule': _i1.ParameterDescription(
              name: 'assessmentModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'aiChatPrompt': _i1.ParameterDescription(
              name: 'aiChatPrompt',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'passingPercentage': _i1.ParameterDescription(
              name: 'passingPercentage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .updateMyModuleConfig(
                    session,
                    params['organizationId'],
                    params['theoryModule'],
                    params['aiExpertModule'],
                    params['smartTrainingModule'],
                    params['assessmentModule'],
                    params['aiChatPrompt'],
                    params['passingPercentage'],
                  ),
        ),
        'getTheoryChapters': _i1.MethodConnector(
          name: 'getTheoryChapters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getTheoryChapters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertTheoryChapter': _i1.MethodConnector(
          name: 'upsertTheoryChapter',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'chapter': _i1.ParameterDescription(
              name: 'chapter',
              type: _i1.getType<_i9.TheoryChapter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertTheoryChapter(
                    session,
                    params['organizationId'],
                    params['chapter'],
                  ),
        ),
        'deleteTheoryChapter': _i1.MethodConnector(
          name: 'deleteTheoryChapter',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteTheoryChapter(
                    session,
                    params['chapterId'],
                  ),
        ),
        'getTrainingParameters': _i1.MethodConnector(
          name: 'getTrainingParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getTrainingParameters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertTrainingParameter': _i1.MethodConnector(
          name: 'upsertTrainingParameter',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i10.TrainingParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertTrainingParameter(
                    session,
                    params['organizationId'],
                    params['param'],
                  ),
        ),
        'deleteTrainingParameter': _i1.MethodConnector(
          name: 'deleteTrainingParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteTrainingParameter(
                    session,
                    params['paramId'],
                  ),
        ),
        'getAssessmentParameters': _i1.MethodConnector(
          name: 'getAssessmentParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getAssessmentParameters(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertAssessmentParameter': _i1.MethodConnector(
          name: 'upsertAssessmentParameter',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i11.AssessmentParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertAssessmentParameter(
                    session,
                    params['organizationId'],
                    params['param'],
                  ),
        ),
        'deleteAssessmentParameter': _i1.MethodConnector(
          name: 'deleteAssessmentParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteAssessmentParameter(
                    session,
                    params['paramId'],
                  ),
        ),
        'getAssets': _i1.MethodConnector(
          name: 'getAssets',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['manager'] as _i3.ManagerEndpoint).getAssets(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertAsset': _i1.MethodConnector(
          name: 'upsertAsset',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'asset': _i1.ParameterDescription(
              name: 'asset',
              type: _i1.getType<_i12.Asset>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['manager'] as _i3.ManagerEndpoint).upsertAsset(
                    session,
                    params['organizationId'],
                    params['asset'],
                  ),
        ),
        'deleteAsset': _i1.MethodConnector(
          name: 'deleteAsset',
          params: {
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['manager'] as _i3.ManagerEndpoint).deleteAsset(
                    session,
                    params['assetId'],
                  ),
        ),
        'getUserModuleProgress': _i1.MethodConnector(
          name: 'getUserModuleProgress',
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getUserModuleProgress(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                  ),
        ),
        'setUserModuleProgress': _i1.MethodConnector(
          name: 'setUserModuleProgress',
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
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isEnabled': _i1.ParameterDescription(
              name: 'isEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .setUserModuleProgress(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                    params['moduleId'],
                    params['isEnabled'],
                    params['deadline'],
                  ),
        ),
        'updateUserModuleStatus': _i1.MethodConnector(
          name: 'updateUserModuleStatus',
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
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.ModuleProgressStatus>(),
              nullable: false,
            ),
            'startedAt': _i1.ParameterDescription(
              name: 'startedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'completedAt': _i1.ParameterDescription(
              name: 'completedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .updateUserModuleStatus(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                    params['moduleId'],
                    params['status'],
                    params['startedAt'],
                    params['completedAt'],
                  ),
        ),
        'getTrainingHistory': _i1.MethodConnector(
          name: 'getTrainingHistory',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getTrainingHistory(
                    session,
                    page: params['page'],
                    limit: params['limit'],
                    search: params['search'],
                    organizationId: params['organizationId'],
                    start: params['start'],
                    end: params['end'],
                    passed: params['passed'],
                  ),
        ),
        'getUserTrainingHistory': _i1.MethodConnector(
          name: 'getUserTrainingHistory',
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getUserTrainingHistory(
                    session,
                    params['appUserId'],
                    params['organizationId'],
                  ),
        ),
        'getTrainingUserSummaries': _i1.MethodConnector(
          name: 'getTrainingUserSummaries',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getTrainingUserSummaries(
                    session,
                    page: params['page'],
                    limit: params['limit'],
                    search: params['search'],
                    start: params['start'],
                    end: params['end'],
                    passed: params['passed'],
                  ),
        ),
        'getNotifications': _i1.MethodConnector(
          name: 'getNotifications',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getNotifications(
                    session,
                    params['organizationId'],
                  ),
        ),
        'getUnreadNotificationCount': _i1.MethodConnector(
          name: 'getUnreadNotificationCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getUnreadNotificationCount(session),
        ),
        'markNotificationRead': _i1.MethodConnector(
          name: 'markNotificationRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .markNotificationRead(
                    session,
                    params['notificationId'],
                  ),
        ),
        'markAllNotificationsRead': _i1.MethodConnector(
          name: 'markAllNotificationsRead',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .markAllNotificationsRead(
                    session,
                    params['organizationId'],
                  ),
        ),
        'deleteNotification': _i1.MethodConnector(
          name: 'deleteNotification',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteNotification(
                    session,
                    params['notificationId'],
                  ),
        ),
      },
    );
    connectors['organizationAdmin'] = _i1.EndpointConnector(
      name: 'organizationAdmin',
      endpoint: endpoints['organizationAdmin']!,
      methodConnectors: {
        'getMyOrganization': _i1.MethodConnector(
          name: 'getMyOrganization',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getMyOrganization(session),
        ),
        'createTeam': _i1.MethodConnector(
          name: 'createTeam',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentOrgId': _i1.ParameterDescription(
              name: 'parentOrgId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .createTeam(
                        session,
                        params['name'],
                        params['parentOrgId'],
                        params['imageUrl'],
                      ),
        ),
        'getTeams': _i1.MethodConnector(
          name: 'getTeams',
          params: {
            'parentOrgId': _i1.ParameterDescription(
              name: 'parentOrgId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getTeams(
                        session,
                        params['parentOrgId'],
                      ),
        ),
        'assignManagerToTeam': _i1.MethodConnector(
          name: 'assignManagerToTeam',
          params: {
            'managerAppUserId': _i1.ParameterDescription(
              name: 'managerAppUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .assignManagerToTeam(
                        session,
                        params['managerAppUserId'],
                        params['teamId'],
                      ),
        ),
        'deleteTeam': _i1.MethodConnector(
          name: 'deleteTeam',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteTeam(
                        session,
                        params['teamId'],
                      ),
        ),
        'updateTeam': _i1.MethodConnector(
          name: 'updateTeam',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .updateTeam(
                        session,
                        params['teamId'],
                        params['name'],
                      ),
        ),
        'createUserInTeam': _i1.MethodConnector(
          name: 'createUserInTeam',
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
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .createUserInTeam(
                        session,
                        params['userName'],
                        params['email'],
                        params['password'],
                        params['role'],
                        params['teamId'],
                      ),
        ),
        'updateOrgUser': _i1.MethodConnector(
          name: 'updateOrgUser',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i7.Role>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .updateOrgUser(
                        session,
                        params['appUserId'],
                        params['userName'],
                        params['role'],
                      ),
        ),
        'deleteOrgUser': _i1.MethodConnector(
          name: 'deleteOrgUser',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteOrgUser(
                        session,
                        params['appUserId'],
                      ),
        ),
        'resetOrgUserPassword': _i1.MethodConnector(
          name: 'resetOrgUserPassword',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .resetOrgUserPassword(
                        session,
                        params['appUserId'],
                        params['newPassword'],
                      ),
        ),
        'getModuleConfig': _i1.MethodConnector(
          name: 'getModuleConfig',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getModuleConfig(session),
        ),
        'setModuleConfig': _i1.MethodConnector(
          name: 'setModuleConfig',
          params: {
            'theoryModule': _i1.ParameterDescription(
              name: 'theoryModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'aiExpertModule': _i1.ParameterDescription(
              name: 'aiExpertModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'smartTrainingModule': _i1.ParameterDescription(
              name: 'smartTrainingModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'assessmentModule': _i1.ParameterDescription(
              name: 'assessmentModule',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'defaultLanguage': _i1.ParameterDescription(
              name: 'defaultLanguage',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'supportedLanguages': _i1.ParameterDescription(
              name: 'supportedLanguages',
              type: _i1.getType<List<_i8.SupportedLanguage>>(),
              nullable: false,
            ),
            'aiChatPrompt': _i1.ParameterDescription(
              name: 'aiChatPrompt',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'passingPercentage': _i1.ParameterDescription(
              name: 'passingPercentage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .setModuleConfig(
                        session,
                        params['theoryModule'],
                        params['aiExpertModule'],
                        params['smartTrainingModule'],
                        params['assessmentModule'],
                        params['defaultLanguage'],
                        params['supportedLanguages'],
                        params['aiChatPrompt'],
                        params['passingPercentage'],
                      ),
        ),
        'getOrgUserModuleProgress': _i1.MethodConnector(
          name: 'getOrgUserModuleProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgUserModuleProgress(
                        session,
                        params['userId'],
                      ),
        ),
        'setOrgUserModuleProgress': _i1.MethodConnector(
          name: 'setOrgUserModuleProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isEnabled': _i1.ParameterDescription(
              name: 'isEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .setOrgUserModuleProgress(
                        session,
                        params['userId'],
                        params['moduleId'],
                        params['isEnabled'],
                        params['deadline'],
                      ),
        ),
        'updateOrgUserModuleStatus': _i1.MethodConnector(
          name: 'updateOrgUserModuleStatus',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.ModuleProgressStatus>(),
              nullable: false,
            ),
            'startedAt': _i1.ParameterDescription(
              name: 'startedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'completedAt': _i1.ParameterDescription(
              name: 'completedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .updateOrgUserModuleStatus(
                        session,
                        params['userId'],
                        params['moduleId'],
                        params['status'],
                        params['startedAt'],
                        params['completedAt'],
                      ),
        ),
        'getOrgTheoryChapters': _i1.MethodConnector(
          name: 'getOrgTheoryChapters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgTheoryChapters(session),
        ),
        'upsertOrgTheoryChapter': _i1.MethodConnector(
          name: 'upsertOrgTheoryChapter',
          params: {
            'chapter': _i1.ParameterDescription(
              name: 'chapter',
              type: _i1.getType<_i9.TheoryChapter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .upsertOrgTheoryChapter(
                        session,
                        params['chapter'],
                      ),
        ),
        'deleteOrgTheoryChapter': _i1.MethodConnector(
          name: 'deleteOrgTheoryChapter',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteOrgTheoryChapter(
                        session,
                        params['chapterId'],
                      ),
        ),
        'getOrgTrainingParameters': _i1.MethodConnector(
          name: 'getOrgTrainingParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgTrainingParameters(session),
        ),
        'upsertOrgTrainingParameter': _i1.MethodConnector(
          name: 'upsertOrgTrainingParameter',
          params: {
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i10.TrainingParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .upsertOrgTrainingParameter(
                        session,
                        params['param'],
                      ),
        ),
        'deleteOrgTrainingParameter': _i1.MethodConnector(
          name: 'deleteOrgTrainingParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteOrgTrainingParameter(
                        session,
                        params['paramId'],
                      ),
        ),
        'getOrgAssessmentParameters': _i1.MethodConnector(
          name: 'getOrgAssessmentParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgAssessmentParameters(session),
        ),
        'upsertOrgAssessmentParameter': _i1.MethodConnector(
          name: 'upsertOrgAssessmentParameter',
          params: {
            'param': _i1.ParameterDescription(
              name: 'param',
              type: _i1.getType<_i11.AssessmentParameter>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .upsertOrgAssessmentParameter(
                        session,
                        params['param'],
                      ),
        ),
        'deleteOrgAssessmentParameter': _i1.MethodConnector(
          name: 'deleteOrgAssessmentParameter',
          params: {
            'paramId': _i1.ParameterDescription(
              name: 'paramId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteOrgAssessmentParameter(
                        session,
                        params['paramId'],
                      ),
        ),
        'getOrgAssets': _i1.MethodConnector(
          name: 'getOrgAssets',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgAssets(session),
        ),
        'upsertOrgAsset': _i1.MethodConnector(
          name: 'upsertOrgAsset',
          params: {
            'asset': _i1.ParameterDescription(
              name: 'asset',
              type: _i1.getType<_i12.Asset>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .upsertOrgAsset(
                        session,
                        params['asset'],
                      ),
        ),
        'deleteOrgAsset': _i1.MethodConnector(
          name: 'deleteOrgAsset',
          params: {
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .deleteOrgAsset(
                        session,
                        params['assetId'],
                      ),
        ),
        'getTrainingHistory': _i1.MethodConnector(
          name: 'getTrainingHistory',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getTrainingHistory(
                        session,
                        page: params['page'],
                        limit: params['limit'],
                        search: params['search'],
                        teamId: params['teamId'],
                        start: params['start'],
                        end: params['end'],
                        passed: params['passed'],
                      ),
        ),
        'getOrgUserTrainingHistory': _i1.MethodConnector(
          name: 'getOrgUserTrainingHistory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getOrgUserTrainingHistory(
                        session,
                        params['userId'],
                      ),
        ),
        'getTrainingUserSummaries': _i1.MethodConnector(
          name: 'getTrainingUserSummaries',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'search': _i1.ParameterDescription(
              name: 'search',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'start': _i1.ParameterDescription(
              name: 'start',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'end': _i1.ParameterDescription(
              name: 'end',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'passed': _i1.ParameterDescription(
              name: 'passed',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getTrainingUserSummaries(
                        session,
                        page: params['page'],
                        limit: params['limit'],
                        search: params['search'],
                        teamId: params['teamId'],
                        start: params['start'],
                        end: params['end'],
                        passed: params['passed'],
                      ),
        ),
        'getUserTrainingHistory': _i1.MethodConnector(
          name: 'getUserTrainingHistory',
          params: {
            'appUserId': _i1.ParameterDescription(
              name: 'appUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .getUserTrainingHistory(
                        session,
                        params['appUserId'],
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['publicApi'] as _i5.PublicApiEndpoint).login(
                    session,
                    params['email'],
                    params['password'],
                  ),
        ),
        'getContentBundle': _i1.MethodConnector(
          name: 'getContentBundle',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getContentBundle(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getTheorySection': _i1.MethodConnector(
          name: 'getTheorySection',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getTheorySection(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getTrainingParameters': _i1.MethodConnector(
          name: 'getTrainingParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getTrainingParameters(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getAssessmentParameters': _i1.MethodConnector(
          name: 'getAssessmentParameters',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getAssessmentParameters(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getModuleConfig': _i1.MethodConnector(
          name: 'getModuleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getModuleConfig(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['userId'],
                  ),
        ),
        'getLanguages': _i1.MethodConnector(
          name: 'getLanguages',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getLanguages(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getAssets': _i1.MethodConnector(
          name: 'getAssets',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['publicApi'] as _i5.PublicApiEndpoint).getAssets(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'updateModuleStatus': _i1.MethodConnector(
          name: 'updateModuleStatus',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.ModuleProgressStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .updateModuleStatus(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['userId'],
                    params['moduleId'],
                    params['status'],
                  ),
        ),
        'submitTrainingCertificate': _i1.MethodConnector(
          name: 'submitTrainingCertificate',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'apiKey': _i1.ParameterDescription(
              name: 'apiKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'overallPercentage': _i1.ParameterDescription(
              name: 'overallPercentage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'criteriaValidation': _i1.ParameterDescription(
              name: 'criteriaValidation',
              type: _i1.getType<List<_i14.TrainingCriteriaScore>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .submitTrainingCertificate(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['userId'],
                    params['overallPercentage'],
                    params['criteriaValidation'],
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
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getMyPermissions(session),
        ),
        'getMyOrgModuleConfig': _i1.MethodConnector(
          name: 'getMyOrgModuleConfig',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getMyOrgModuleConfig(session),
        ),
        'getTheoryChapters': _i1.MethodConnector(
          name: 'getTheoryChapters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getTheoryChapters(session),
        ),
        'getTrainingParameters': _i1.MethodConnector(
          name: 'getTrainingParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getTrainingParameters(session),
        ),
        'getAssessmentParameters': _i1.MethodConnector(
          name: 'getAssessmentParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getAssessmentParameters(session),
        ),
        'changePassword': _i1.MethodConnector(
          name: 'changePassword',
          params: {
            'currentPassword': _i1.ParameterDescription(
              name: 'currentPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint).changePassword(
                session,
                params['currentPassword'],
                params['newPassword'],
              ),
        ),
        'getMyModuleProgress': _i1.MethodConnector(
          name: 'getMyModuleProgress',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getMyModuleProgress(session),
        ),
        'submitTrainingResult': _i1.MethodConnector(
          name: 'submitTrainingResult',
          params: {
            'externalUserId': _i1.ParameterDescription(
              name: 'externalUserId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'overallPercentage': _i1.ParameterDescription(
              name: 'overallPercentage',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'criteriaScores': _i1.ParameterDescription(
              name: 'criteriaScores',
              type: _i1.getType<List<_i14.TrainingCriteriaScore>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i6.UserEndpoint).submitTrainingResult(
                    session,
                    params['externalUserId'],
                    params['overallPercentage'],
                    params['criteriaScores'],
                  ),
        ),
        'getMyTrainingHistory': _i1.MethodConnector(
          name: 'getMyTrainingHistory',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getMyTrainingHistory(session),
        ),
        'updateMyModuleStatus': _i1.MethodConnector(
          name: 'updateMyModuleStatus',
          params: {
            'moduleId': _i1.ParameterDescription(
              name: 'moduleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i13.ModuleProgressStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i6.UserEndpoint).updateMyModuleStatus(
                    session,
                    params['moduleId'],
                    params['status'],
                  ),
        ),
        'getTheoryChaptersWithProgress': _i1.MethodConnector(
          name: 'getTheoryChaptersWithProgress',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getTheoryChaptersWithProgress(session),
        ),
        'submitTheoryQuiz': _i1.MethodConnector(
          name: 'submitTheoryQuiz',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i6.UserEndpoint).submitTheoryQuiz(
                    session,
                    params['chapterId'],
                    params['score'],
                  ),
        ),
      },
    );
    modules['serverpod_auth'] = _i15.Endpoints()..initializeEndpoints(server);
  }
}
