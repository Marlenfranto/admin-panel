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
import 'package:admin_panel_server/src/generated/localized_ai_prompt.dart'
    as _i9;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i10;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i11;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i12;
import 'package:admin_panel_server/src/generated/asset.dart' as _i13;
import 'package:admin_panel_server/src/generated/region.dart' as _i14;
import 'package:admin_panel_server/src/generated/locale_config.dart' as _i15;
import 'package:admin_panel_server/src/generated/module_progress_status.dart'
    as _i16;
import 'package:admin_panel_server/src/generated/theory_chapter_localization.dart'
    as _i17;
import 'package:admin_panel_server/src/generated/localized_quiz_content.dart'
    as _i18;
import 'package:admin_panel_server/src/generated/training_parameter_localization.dart'
    as _i19;
import 'package:admin_panel_server/src/generated/assessment_parameter_localization.dart'
    as _i20;
import 'package:admin_panel_server/src/generated/asset_localization.dart'
    as _i21;
import 'package:admin_panel_server/src/generated/training_criteria_score.dart'
    as _i22;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i23;

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
            'aiChatPromptTranslations': _i1.ParameterDescription(
              name: 'aiChatPromptTranslations',
              type: _i1.getType<List<_i9.LocalizedAiPrompt>?>(),
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
                    params['aiChatPromptTranslations'],
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
              type: _i1.getType<_i10.TheoryChapter>(),
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
              type: _i1.getType<_i11.TrainingParameter>(),
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
              type: _i1.getType<_i12.AssessmentParameter>(),
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
              type: _i1.getType<_i13.Asset>(),
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
        'listRegions': _i1.MethodConnector(
          name: 'listRegions',
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
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).listRegions(
                session,
                params['organizationId'],
              ),
        ),
        'upsertRegion': _i1.MethodConnector(
          name: 'upsertRegion',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'region': _i1.ParameterDescription(
              name: 'region',
              type: _i1.getType<_i14.Region>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).upsertRegion(
                session,
                params['organizationId'],
                params['region'],
              ),
        ),
        'deleteRegion': _i1.MethodConnector(
          name: 'deleteRegion',
          params: {
            'regionId': _i1.ParameterDescription(
              name: 'regionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint).deleteRegion(
                session,
                params['regionId'],
              ),
        ),
        'listLocaleConfigs': _i1.MethodConnector(
          name: 'listLocaleConfigs',
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
                  (endpoints['admin'] as _i2.AdminEndpoint).listLocaleConfigs(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertLocaleConfig': _i1.MethodConnector(
          name: 'upsertLocaleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'locale': _i1.ParameterDescription(
              name: 'locale',
              type: _i1.getType<_i15.LocaleConfig>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).upsertLocaleConfig(
                    session,
                    params['organizationId'],
                    params['locale'],
                  ),
        ),
        'deleteLocaleConfig': _i1.MethodConnector(
          name: 'deleteLocaleConfig',
          params: {
            'localeConfigId': _i1.ParameterDescription(
              name: 'localeConfigId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).deleteLocaleConfig(
                    session,
                    params['localeConfigId'],
                  ),
        ),
        'setDefaultLocale': _i1.MethodConnector(
          name: 'setDefaultLocale',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).setDefaultLocale(
                    session,
                    params['organizationId'],
                    params['localeKey'],
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
              type: _i1.getType<_i16.ModuleProgressStatus>(),
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
        'listTheoryChapterLocalizations': _i1.MethodConnector(
          name: 'listTheoryChapterLocalizations',
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
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .listTheoryChapterLocalizations(
                    session,
                    params['chapterId'],
                  ),
        ),
        'upsertTheoryChapterLocalization': _i1.MethodConnector(
          name: 'upsertTheoryChapterLocalization',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i17.TheoryChapterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertTheoryChapterLocalization(
                    session,
                    params['chapterId'],
                    params['loc'],
                  ),
        ),
        'setTheoryChapterQuizTranslations': _i1.MethodConnector(
          name: 'setTheoryChapterQuizTranslations',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'questionTranslations': _i1.ParameterDescription(
              name: 'questionTranslations',
              type: _i1.getType<List<_i18.LocalizedQuizContent>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .setTheoryChapterQuizTranslations(
                    session,
                    params['chapterId'],
                    params['localeKey'],
                    params['questionTranslations'],
                  ),
        ),
        'deleteTheoryChapterLocalization': _i1.MethodConnector(
          name: 'deleteTheoryChapterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteTheoryChapterLocalization(
                    session,
                    params['localizationId'],
                  ),
        ),
        'listTrainingParameterLocalizations': _i1.MethodConnector(
          name: 'listTrainingParameterLocalizations',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .listTrainingParameterLocalizations(
                    session,
                    params['parameterId'],
                  ),
        ),
        'upsertTrainingParameterLocalization': _i1.MethodConnector(
          name: 'upsertTrainingParameterLocalization',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i19.TrainingParameterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertTrainingParameterLocalization(
                    session,
                    params['parameterId'],
                    params['loc'],
                  ),
        ),
        'deleteTrainingParameterLocalization': _i1.MethodConnector(
          name: 'deleteTrainingParameterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteTrainingParameterLocalization(
                    session,
                    params['localizationId'],
                  ),
        ),
        'listAssessmentParameterLocalizations': _i1.MethodConnector(
          name: 'listAssessmentParameterLocalizations',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .listAssessmentParameterLocalizations(
                    session,
                    params['parameterId'],
                  ),
        ),
        'upsertAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'upsertAssessmentParameterLocalization',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i20.AssessmentParameterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertAssessmentParameterLocalization(
                    session,
                    params['parameterId'],
                    params['loc'],
                  ),
        ),
        'deleteAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'deleteAssessmentParameterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteAssessmentParameterLocalization(
                    session,
                    params['localizationId'],
                  ),
        ),
        'listAssetLocalizations': _i1.MethodConnector(
          name: 'listAssetLocalizations',
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
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .listAssetLocalizations(
                    session,
                    params['assetId'],
                  ),
        ),
        'upsertAssetLocalization': _i1.MethodConnector(
          name: 'upsertAssetLocalization',
          params: {
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i21.AssetLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .upsertAssetLocalization(
                    session,
                    params['assetId'],
                    params['loc'],
                  ),
        ),
        'deleteAssetLocalization': _i1.MethodConnector(
          name: 'deleteAssetLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .deleteAssetLocalization(
                    session,
                    params['localizationId'],
                  ),
        ),
        'getTheoryChaptersLocalized': _i1.MethodConnector(
          name: 'getTheoryChaptersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getTheoryChaptersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getTrainingParametersLocalized': _i1.MethodConnector(
          name: 'getTrainingParametersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getTrainingParametersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getAssessmentParametersLocalized': _i1.MethodConnector(
          name: 'getAssessmentParametersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _i2.AdminEndpoint)
                  .getAssessmentParametersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getAssetsLocalized': _i1.MethodConnector(
          name: 'getAssetsLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _i2.AdminEndpoint).getAssetsLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
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
              type: _i1.getType<_i10.TheoryChapter>(),
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
              type: _i1.getType<_i11.TrainingParameter>(),
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
              type: _i1.getType<_i12.AssessmentParameter>(),
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
              type: _i1.getType<_i13.Asset>(),
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
              type: _i1.getType<_i16.ModuleProgressStatus>(),
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
        'listManagedRegions': _i1.MethodConnector(
          name: 'listManagedRegions',
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
                  .listManagedRegions(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertManagedRegion': _i1.MethodConnector(
          name: 'upsertManagedRegion',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'region': _i1.ParameterDescription(
              name: 'region',
              type: _i1.getType<_i14.Region>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedRegion(
                    session,
                    params['organizationId'],
                    params['region'],
                  ),
        ),
        'deleteManagedRegion': _i1.MethodConnector(
          name: 'deleteManagedRegion',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'regionId': _i1.ParameterDescription(
              name: 'regionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedRegion(
                    session,
                    params['organizationId'],
                    params['regionId'],
                  ),
        ),
        'listManagedLocaleConfigs': _i1.MethodConnector(
          name: 'listManagedLocaleConfigs',
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
                  .listManagedLocaleConfigs(
                    session,
                    params['organizationId'],
                  ),
        ),
        'upsertManagedLocaleConfig': _i1.MethodConnector(
          name: 'upsertManagedLocaleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'locale': _i1.ParameterDescription(
              name: 'locale',
              type: _i1.getType<_i15.LocaleConfig>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedLocaleConfig(
                    session,
                    params['organizationId'],
                    params['locale'],
                  ),
        ),
        'deleteManagedLocaleConfig': _i1.MethodConnector(
          name: 'deleteManagedLocaleConfig',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeConfigId': _i1.ParameterDescription(
              name: 'localeConfigId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedLocaleConfig(
                    session,
                    params['organizationId'],
                    params['localeConfigId'],
                  ),
        ),
        'setManagedDefaultLocale': _i1.MethodConnector(
          name: 'setManagedDefaultLocale',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .setManagedDefaultLocale(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'listManagedTheoryChapterLocalizations': _i1.MethodConnector(
          name: 'listManagedTheoryChapterLocalizations',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
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
                  .listManagedTheoryChapterLocalizations(
                    session,
                    params['organizationId'],
                    params['chapterId'],
                  ),
        ),
        'upsertManagedTheoryChapterLocalization': _i1.MethodConnector(
          name: 'upsertManagedTheoryChapterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i17.TheoryChapterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedTheoryChapterLocalization(
                    session,
                    params['organizationId'],
                    params['chapterId'],
                    params['loc'],
                  ),
        ),
        'setManagedTheoryChapterQuizTranslations': _i1.MethodConnector(
          name: 'setManagedTheoryChapterQuizTranslations',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'questionTranslations': _i1.ParameterDescription(
              name: 'questionTranslations',
              type: _i1.getType<List<_i18.LocalizedQuizContent>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .setManagedTheoryChapterQuizTranslations(
                    session,
                    params['organizationId'],
                    params['chapterId'],
                    params['localeKey'],
                    params['questionTranslations'],
                  ),
        ),
        'deleteManagedTheoryChapterLocalization': _i1.MethodConnector(
          name: 'deleteManagedTheoryChapterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedTheoryChapterLocalization(
                    session,
                    params['organizationId'],
                    params['localizationId'],
                  ),
        ),
        'listManagedTrainingParameterLocalizations': _i1.MethodConnector(
          name: 'listManagedTrainingParameterLocalizations',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .listManagedTrainingParameterLocalizations(
                    session,
                    params['organizationId'],
                    params['parameterId'],
                  ),
        ),
        'upsertManagedTrainingParameterLocalization': _i1.MethodConnector(
          name: 'upsertManagedTrainingParameterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i19.TrainingParameterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedTrainingParameterLocalization(
                    session,
                    params['organizationId'],
                    params['parameterId'],
                    params['loc'],
                  ),
        ),
        'deleteManagedTrainingParameterLocalization': _i1.MethodConnector(
          name: 'deleteManagedTrainingParameterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedTrainingParameterLocalization(
                    session,
                    params['organizationId'],
                    params['localizationId'],
                  ),
        ),
        'listManagedAssessmentParameterLocalizations': _i1.MethodConnector(
          name: 'listManagedAssessmentParameterLocalizations',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .listManagedAssessmentParameterLocalizations(
                    session,
                    params['organizationId'],
                    params['parameterId'],
                  ),
        ),
        'upsertManagedAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'upsertManagedAssessmentParameterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i20.AssessmentParameterLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedAssessmentParameterLocalization(
                    session,
                    params['organizationId'],
                    params['parameterId'],
                    params['loc'],
                  ),
        ),
        'deleteManagedAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'deleteManagedAssessmentParameterLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedAssessmentParameterLocalization(
                    session,
                    params['organizationId'],
                    params['localizationId'],
                  ),
        ),
        'listManagedAssetLocalizations': _i1.MethodConnector(
          name: 'listManagedAssetLocalizations',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
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
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .listManagedAssetLocalizations(
                    session,
                    params['organizationId'],
                    params['assetId'],
                  ),
        ),
        'upsertManagedAssetLocalization': _i1.MethodConnector(
          name: 'upsertManagedAssetLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i21.AssetLocalization>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .upsertManagedAssetLocalization(
                    session,
                    params['organizationId'],
                    params['assetId'],
                    params['loc'],
                  ),
        ),
        'deleteManagedAssetLocalization': _i1.MethodConnector(
          name: 'deleteManagedAssetLocalization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .deleteManagedAssetLocalization(
                    session,
                    params['organizationId'],
                    params['localizationId'],
                  ),
        ),
        'getManagedTheoryChaptersLocalized': _i1.MethodConnector(
          name: 'getManagedTheoryChaptersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedTheoryChaptersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getManagedTrainingParametersLocalized': _i1.MethodConnector(
          name: 'getManagedTrainingParametersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedTrainingParametersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getManagedAssessmentParametersLocalized': _i1.MethodConnector(
          name: 'getManagedAssessmentParametersLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedAssessmentParametersLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
                  ),
        ),
        'getManagedAssetsLocalized': _i1.MethodConnector(
          name: 'getManagedAssetsLocalized',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['manager'] as _i3.ManagerEndpoint)
                  .getManagedAssetsLocalized(
                    session,
                    params['organizationId'],
                    params['localeKey'],
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
            'aiChatPromptTranslations': _i1.ParameterDescription(
              name: 'aiChatPromptTranslations',
              type: _i1.getType<List<_i9.LocalizedAiPrompt>?>(),
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
                        params['aiChatPromptTranslations'],
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
              type: _i1.getType<_i16.ModuleProgressStatus>(),
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
              type: _i1.getType<_i10.TheoryChapter>(),
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
              type: _i1.getType<_i11.TrainingParameter>(),
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
              type: _i1.getType<_i12.AssessmentParameter>(),
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
              type: _i1.getType<_i13.Asset>(),
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
        'listMyRegions': _i1.MethodConnector(
          name: 'listMyRegions',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .listMyRegions(session),
        ),
        'upsertMyRegion': _i1.MethodConnector(
          name: 'upsertMyRegion',
          params: {
            'region': _i1.ParameterDescription(
              name: 'region',
              type: _i1.getType<_i14.Region>(),
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
                      .upsertMyRegion(
                        session,
                        params['region'],
                      ),
        ),
        'deleteMyRegion': _i1.MethodConnector(
          name: 'deleteMyRegion',
          params: {
            'regionId': _i1.ParameterDescription(
              name: 'regionId',
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
                      .deleteMyRegion(
                        session,
                        params['regionId'],
                      ),
        ),
        'listMyLocaleConfigs': _i1.MethodConnector(
          name: 'listMyLocaleConfigs',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['organizationAdmin']
                          as _i4.OrganizationAdminEndpoint)
                      .listMyLocaleConfigs(session),
        ),
        'upsertMyLocaleConfig': _i1.MethodConnector(
          name: 'upsertMyLocaleConfig',
          params: {
            'locale': _i1.ParameterDescription(
              name: 'locale',
              type: _i1.getType<_i15.LocaleConfig>(),
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
                      .upsertMyLocaleConfig(
                        session,
                        params['locale'],
                      ),
        ),
        'deleteMyLocaleConfig': _i1.MethodConnector(
          name: 'deleteMyLocaleConfig',
          params: {
            'localeConfigId': _i1.ParameterDescription(
              name: 'localeConfigId',
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
                      .deleteMyLocaleConfig(
                        session,
                        params['localeConfigId'],
                      ),
        ),
        'setMyDefaultLocale': _i1.MethodConnector(
          name: 'setMyDefaultLocale',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
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
                      .setMyDefaultLocale(
                        session,
                        params['localeKey'],
                      ),
        ),
        'listMyTheoryChapterLocalizations': _i1.MethodConnector(
          name: 'listMyTheoryChapterLocalizations',
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
                      .listMyTheoryChapterLocalizations(
                        session,
                        params['chapterId'],
                      ),
        ),
        'upsertMyTheoryChapterLocalization': _i1.MethodConnector(
          name: 'upsertMyTheoryChapterLocalization',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i17.TheoryChapterLocalization>(),
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
                      .upsertMyTheoryChapterLocalization(
                        session,
                        params['chapterId'],
                        params['loc'],
                      ),
        ),
        'setMyTheoryChapterQuizTranslations': _i1.MethodConnector(
          name: 'setMyTheoryChapterQuizTranslations',
          params: {
            'chapterId': _i1.ParameterDescription(
              name: 'chapterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'questionTranslations': _i1.ParameterDescription(
              name: 'questionTranslations',
              type: _i1.getType<List<_i18.LocalizedQuizContent>>(),
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
                      .setMyTheoryChapterQuizTranslations(
                        session,
                        params['chapterId'],
                        params['localeKey'],
                        params['questionTranslations'],
                      ),
        ),
        'deleteMyTheoryChapterLocalization': _i1.MethodConnector(
          name: 'deleteMyTheoryChapterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
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
                      .deleteMyTheoryChapterLocalization(
                        session,
                        params['localizationId'],
                      ),
        ),
        'listMyTrainingParameterLocalizations': _i1.MethodConnector(
          name: 'listMyTrainingParameterLocalizations',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
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
                      .listMyTrainingParameterLocalizations(
                        session,
                        params['parameterId'],
                      ),
        ),
        'upsertMyTrainingParameterLocalization': _i1.MethodConnector(
          name: 'upsertMyTrainingParameterLocalization',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i19.TrainingParameterLocalization>(),
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
                      .upsertMyTrainingParameterLocalization(
                        session,
                        params['parameterId'],
                        params['loc'],
                      ),
        ),
        'deleteMyTrainingParameterLocalization': _i1.MethodConnector(
          name: 'deleteMyTrainingParameterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
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
                      .deleteMyTrainingParameterLocalization(
                        session,
                        params['localizationId'],
                      ),
        ),
        'listMyAssessmentParameterLocalizations': _i1.MethodConnector(
          name: 'listMyAssessmentParameterLocalizations',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
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
                      .listMyAssessmentParameterLocalizations(
                        session,
                        params['parameterId'],
                      ),
        ),
        'upsertMyAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'upsertMyAssessmentParameterLocalization',
          params: {
            'parameterId': _i1.ParameterDescription(
              name: 'parameterId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i20.AssessmentParameterLocalization>(),
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
                      .upsertMyAssessmentParameterLocalization(
                        session,
                        params['parameterId'],
                        params['loc'],
                      ),
        ),
        'deleteMyAssessmentParameterLocalization': _i1.MethodConnector(
          name: 'deleteMyAssessmentParameterLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
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
                      .deleteMyAssessmentParameterLocalization(
                        session,
                        params['localizationId'],
                      ),
        ),
        'listMyAssetLocalizations': _i1.MethodConnector(
          name: 'listMyAssetLocalizations',
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
                      .listMyAssetLocalizations(
                        session,
                        params['assetId'],
                      ),
        ),
        'upsertMyAssetLocalization': _i1.MethodConnector(
          name: 'upsertMyAssetLocalization',
          params: {
            'assetId': _i1.ParameterDescription(
              name: 'assetId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'loc': _i1.ParameterDescription(
              name: 'loc',
              type: _i1.getType<_i21.AssetLocalization>(),
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
                      .upsertMyAssetLocalization(
                        session,
                        params['assetId'],
                        params['loc'],
                      ),
        ),
        'deleteMyAssetLocalization': _i1.MethodConnector(
          name: 'deleteMyAssetLocalization',
          params: {
            'localizationId': _i1.ParameterDescription(
              name: 'localizationId',
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
                      .deleteMyAssetLocalization(
                        session,
                        params['localizationId'],
                      ),
        ),
        'getMyTheoryChaptersLocalized': _i1.MethodConnector(
          name: 'getMyTheoryChaptersLocalized',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
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
                      .getMyTheoryChaptersLocalized(
                        session,
                        params['localeKey'],
                      ),
        ),
        'getMyTrainingParametersLocalized': _i1.MethodConnector(
          name: 'getMyTrainingParametersLocalized',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
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
                      .getMyTrainingParametersLocalized(
                        session,
                        params['localeKey'],
                      ),
        ),
        'getMyAssessmentParametersLocalized': _i1.MethodConnector(
          name: 'getMyAssessmentParametersLocalized',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
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
                      .getMyAssessmentParametersLocalized(
                        session,
                        params['localeKey'],
                      ),
        ),
        'getMyAssetsLocalized': _i1.MethodConnector(
          name: 'getMyAssetsLocalized',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
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
                      .getMyAssetsLocalized(
                        session,
                        params['localeKey'],
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
              type: _i1.getType<_i16.ModuleProgressStatus>(),
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
              type: _i1.getType<List<_i22.TrainingCriteriaScore>>(),
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
        'getLocales': _i1.MethodConnector(
          name: 'getLocales',
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
                  (endpoints['publicApi'] as _i5.PublicApiEndpoint).getLocales(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getRegions': _i1.MethodConnector(
          name: 'getRegions',
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
                  (endpoints['publicApi'] as _i5.PublicApiEndpoint).getRegions(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                  ),
        ),
        'getTheorySectionLocalized': _i1.MethodConnector(
          name: 'getTheorySectionLocalized',
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
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getTheorySectionLocalized(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['localeKey'],
                  ),
        ),
        'getTrainingParametersLocalized': _i1.MethodConnector(
          name: 'getTrainingParametersLocalized',
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
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getTrainingParametersLocalized(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['localeKey'],
                  ),
        ),
        'getAssessmentParametersLocalized': _i1.MethodConnector(
          name: 'getAssessmentParametersLocalized',
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
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getAssessmentParametersLocalized(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['localeKey'],
                  ),
        ),
        'getAssetsLocalized': _i1.MethodConnector(
          name: 'getAssetsLocalized',
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
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['publicApi'] as _i5.PublicApiEndpoint)
                  .getAssetsLocalized(
                    session,
                    params['organizationId'],
                    params['apiKey'],
                    params['localeKey'],
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
        'getLocalizedTheoryChapters': _i1.MethodConnector(
          name: 'getLocalizedTheoryChapters',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getLocalizedTheoryChapters(
                    session,
                    params['localeKey'],
                  ),
        ),
        'getLocalizedTrainingParameters': _i1.MethodConnector(
          name: 'getLocalizedTrainingParameters',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getLocalizedTrainingParameters(
                    session,
                    params['localeKey'],
                  ),
        ),
        'getLocalizedAssessmentParameters': _i1.MethodConnector(
          name: 'getLocalizedAssessmentParameters',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getLocalizedAssessmentParameters(
                    session,
                    params['localeKey'],
                  ),
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
        'getMyLocales': _i1.MethodConnector(
          name: 'getMyLocales',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i6.UserEndpoint).getMyLocales(session),
        ),
        'setPreferredLocale': _i1.MethodConnector(
          name: 'setPreferredLocale',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i6.UserEndpoint).setPreferredLocale(
                    session,
                    params['localeKey'],
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
              type: _i1.getType<List<_i22.TrainingCriteriaScore>>(),
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
              type: _i1.getType<_i16.ModuleProgressStatus>(),
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
        'getLocalizedTheoryChaptersWithProgress': _i1.MethodConnector(
          name: 'getLocalizedTheoryChaptersWithProgress',
          params: {
            'localeKey': _i1.ParameterDescription(
              name: 'localeKey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['user'] as _i6.UserEndpoint)
                  .getLocalizedTheoryChaptersWithProgress(
                    session,
                    params['localeKey'],
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
    modules['serverpod_auth'] = _i23.Endpoints()..initializeEndpoints(server);
  }
}
