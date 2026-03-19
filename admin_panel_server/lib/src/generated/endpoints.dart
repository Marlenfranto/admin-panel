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
import '../endpoints/public_api_endpoint.dart' as _i4;
import '../endpoints/user_endpoint.dart' as _i5;
import 'package:admin_panel_server/src/generated/role.dart' as _i6;
import 'package:admin_panel_server/src/generated/supported_language.dart'
    as _i7;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i8;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i9;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i10;
import 'package:admin_panel_server/src/generated/asset.dart' as _i11;
import 'package:admin_panel_server/src/generated/module_progress_status.dart'
    as _i12;
import 'package:admin_panel_server/src/generated/training_criteria_score.dart'
    as _i13;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i14;

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
              type: _i1.getType<_i6.Role>(),
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
        'getAllUsers': _i1.MethodConnector(
          name: 'getAllUsers',
          params: {
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i6.Role?>(),
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
              type: _i1.getType<List<_i7.SupportedLanguage>>(),
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
              type: _i1.getType<_i8.TheoryChapter>(),
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
              type: _i1.getType<_i9.TrainingParameter>(),
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
              type: _i1.getType<_i10.AssessmentParameter>(),
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
              type: _i1.getType<_i11.Asset>(),
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
              type: _i1.getType<_i12.ModuleProgressStatus>(),
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
              type: _i1.getType<_i6.Role>(),
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
              type: _i1.getType<_i8.TheoryChapter>(),
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
              type: _i1.getType<_i9.TrainingParameter>(),
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
              type: _i1.getType<_i10.AssessmentParameter>(),
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
              type: _i1.getType<_i11.Asset>(),
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
              type: _i1.getType<_i12.ModuleProgressStatus>(),
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
                  (endpoints['publicApi'] as _i4.PublicApiEndpoint).login(
                    session,
                    params['email'],
                    params['password'],
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
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
                  (endpoints['publicApi'] as _i4.PublicApiEndpoint).getAssets(
                    session,
                    params['organizationId'],
                    params['apiKey'],
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
              type: _i1.getType<List<_i13.TrainingCriteriaScore>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i4.PublicApiEndpoint)
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
              ) async => (endpoints['user'] as _i5.UserEndpoint)
                  .getMyPermissions(session),
        ),
        'getMyOrgModuleConfig': _i1.MethodConnector(
          name: 'getMyOrgModuleConfig',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i5.UserEndpoint)
                  .getMyOrgModuleConfig(session),
        ),
        'getTheoryChapters': _i1.MethodConnector(
          name: 'getTheoryChapters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i5.UserEndpoint)
                  .getTheoryChapters(session),
        ),
        'getTrainingParameters': _i1.MethodConnector(
          name: 'getTrainingParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i5.UserEndpoint)
                  .getTrainingParameters(session),
        ),
        'getAssessmentParameters': _i1.MethodConnector(
          name: 'getAssessmentParameters',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i5.UserEndpoint)
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
              ) async => (endpoints['user'] as _i5.UserEndpoint).changePassword(
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
              ) async => (endpoints['user'] as _i5.UserEndpoint)
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
              type: _i1.getType<List<_i13.TrainingCriteriaScore>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i5.UserEndpoint).submitTrainingResult(
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
              ) async => (endpoints['user'] as _i5.UserEndpoint)
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
              type: _i1.getType<_i12.ModuleProgressStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i5.UserEndpoint).updateMyModuleStatus(
                    session,
                    params['moduleId'],
                    params['status'],
                  ),
        ),
      },
    );
    modules['serverpod_auth'] = _i14.Endpoints()..initializeEndpoints(server);
  }
}
