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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'app_user.dart' as _i4;
import 'assessment_parameter.dart' as _i5;
import 'assessment_parameter_localization.dart' as _i6;
import 'asset.dart' as _i7;
import 'asset_localization.dart' as _i8;
import 'certificate_response.dart' as _i9;
import 'content_bundle.dart' as _i10;
import 'locale_config.dart' as _i11;
import 'localized_ai_prompt.dart' as _i12;
import 'localized_parameter_content.dart' as _i13;
import 'localized_quiz_content.dart' as _i14;
import 'login_response.dart' as _i15;
import 'manager_notification.dart' as _i16;
import 'manager_notification_detail.dart' as _i17;
import 'module_config.dart' as _i18;
import 'module_config_public.dart' as _i19;
import 'module_progress_status.dart' as _i20;
import 'organization.dart' as _i21;
import 'organization_user_link.dart' as _i22;
import 'quiz_question.dart' as _i23;
import 'region.dart' as _i24;
import 'role.dart' as _i25;
import 'scoring_rule.dart' as _i26;
import 'subscription_modules.dart' as _i27;
import 'supported_language.dart' as _i28;
import 'theory_chapter.dart' as _i29;
import 'theory_chapter_localization.dart' as _i30;
import 'theory_chapter_with_progress.dart' as _i31;
import 'theory_section_response.dart' as _i32;
import 'tools.dart' as _i33;
import 'training_criteria_score.dart' as _i34;
import 'training_parameter.dart' as _i35;
import 'training_parameter_localization.dart' as _i36;
import 'training_session_result.dart' as _i37;
import 'training_session_result_page.dart' as _i38;
import 'training_user_summary.dart' as _i39;
import 'training_user_summary_page.dart' as _i40;
import 'user_module_progress.dart' as _i41;
import 'user_theory_progress.dart' as _i42;
import 'video_metadata.dart' as _i43;
import 'package:admin_panel_server/src/generated/organization.dart' as _i44;
import 'package:admin_panel_server/src/generated/app_user.dart' as _i45;
import 'package:admin_panel_server/src/generated/supported_language.dart'
    as _i46;
import 'package:admin_panel_server/src/generated/localized_ai_prompt.dart'
    as _i47;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i48;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i49;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i50;
import 'package:admin_panel_server/src/generated/asset.dart' as _i51;
import 'package:admin_panel_server/src/generated/region.dart' as _i52;
import 'package:admin_panel_server/src/generated/locale_config.dart' as _i53;
import 'package:admin_panel_server/src/generated/user_module_progress.dart'
    as _i54;
import 'package:admin_panel_server/src/generated/training_session_result.dart'
    as _i55;
import 'package:admin_panel_server/src/generated/theory_chapter_localization.dart'
    as _i56;
import 'package:admin_panel_server/src/generated/localized_quiz_content.dart'
    as _i57;
import 'package:admin_panel_server/src/generated/training_parameter_localization.dart'
    as _i58;
import 'package:admin_panel_server/src/generated/assessment_parameter_localization.dart'
    as _i59;
import 'package:admin_panel_server/src/generated/asset_localization.dart'
    as _i60;
import 'package:admin_panel_server/src/generated/manager_notification_detail.dart'
    as _i61;
import 'package:admin_panel_server/src/generated/training_criteria_score.dart'
    as _i62;
import 'package:admin_panel_server/src/generated/theory_chapter_with_progress.dart'
    as _i63;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'assessment_parameter_localization.dart';
export 'asset.dart';
export 'asset_localization.dart';
export 'certificate_response.dart';
export 'content_bundle.dart';
export 'locale_config.dart';
export 'localized_ai_prompt.dart';
export 'localized_parameter_content.dart';
export 'localized_quiz_content.dart';
export 'login_response.dart';
export 'manager_notification.dart';
export 'manager_notification_detail.dart';
export 'module_config.dart';
export 'module_config_public.dart';
export 'module_progress_status.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'quiz_question.dart';
export 'region.dart';
export 'role.dart';
export 'scoring_rule.dart';
export 'subscription_modules.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'theory_chapter_localization.dart';
export 'theory_chapter_with_progress.dart';
export 'theory_section_response.dart';
export 'tools.dart';
export 'training_criteria_score.dart';
export 'training_parameter.dart';
export 'training_parameter_localization.dart';
export 'training_session_result.dart';
export 'training_session_result_page.dart';
export 'training_user_summary.dart';
export 'training_user_summary_page.dart';
export 'user_module_progress.dart';
export 'user_theory_progress.dart';
export 'video_metadata.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'app_user',
      dartName: 'AppUser',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_user_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userInfoId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Role',
          columnDefault: '\'User\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'preferredLocaleKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'app_user_fk_0',
          columns: ['userInfoId'],
          referenceTable: 'serverpod_user_info',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assessment_parameter',
      dartName: 'AssessmentParameter',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'assessment_parameter_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'paramId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'maxScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scoringRules',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:ScoringRule>',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_parameter_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assessment_parameter_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'assessment_parameter_localization',
      dartName: 'AssessmentParameterLocalization',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'assessment_parameter_localization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parameterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'localeKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scoringFeedbacks',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'assessment_parameter_localization_fk_0',
          columns: ['parameterId'],
          referenceTable: 'assessment_parameter',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'assessment_parameter_localization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'assessment_param_loc_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parameterId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'assessment_param_loc_locale_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'asset',
      dartName: 'Asset',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'asset_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'module',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'asset_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'asset_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'asset_localization',
      dartName: 'AssetLocalization',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'asset_localization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'assetId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'localeKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'url',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'asset_localization_fk_0',
          columns: ['assetId'],
          referenceTable: 'asset',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'asset_localization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'asset_loc_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'assetId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'asset_loc_locale_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'locale_config',
      dartName: 'LocaleConfig',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'locale_config_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'regionCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'languageCode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'localeKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'isDefault',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'fallbackLocaleKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'locale_config_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'locale_config_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'locale_config_org_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'locale_config_org_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'locale_config_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'manager_notification',
      dartName: 'ManagerNotification',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'manager_notification_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'managerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'overdueUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'moduleId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'manager_notification_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'manager_notification_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'managerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'overdueUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'moduleId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'module_config',
      dartName: 'ModuleConfig',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'module_config_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'theoryModule',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'aiExpertModule',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'smartTrainingModule',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'assessmentModule',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'defaultLocaleKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'US-en\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'aiChatPrompt',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'aiChatPromptTranslations',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:LocalizedAiPrompt>?',
        ),
        _i2.ColumnDefinition(
          name: 'passingPercentage',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '60',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'module_config_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'module_config_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'module_config_organization_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'organization',
      dartName: 'Organization',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'organization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'contentVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '1',
        ),
        _i2.ColumnDefinition(
          name: 'managerId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'parentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'organization_fk_0',
          columns: ['managerId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'organization_fk_1',
          columns: ['parentId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'organization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'organization_user_link',
      dartName: 'OrganizationUserLink',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'organization_user_link_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'appUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'organization_user_link_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'organization_user_link_fk_1',
          columns: ['appUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'organization_user_link_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'organization_user_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'appUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'region',
      dartName: 'Region',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'region_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'enabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'region_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'region_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'region_org_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'region_org_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'theory_chapter',
      dartName: 'TheoryChapter',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'theory_chapter_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'chapterOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'questions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:QuizQuestion>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'theory_chapter_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'theory_chapter_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'theory_chapter_localization',
      dartName: 'TheoryChapterLocalization',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'theory_chapter_localization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'chapterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'localeKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'thumbnailUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'videoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'videoMetadata',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:VideoMetadata?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'theory_chapter_localization_fk_0',
          columns: ['chapterId'],
          referenceTable: 'theory_chapter',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'theory_chapter_localization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'theory_chapter_loc_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chapterId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'theory_chapter_loc_locale_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_parameter',
      dartName: 'TrainingParameter',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'training_parameter_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'paramId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'maxScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'scoringRules',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:ScoringRule>',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_parameter_fk_0',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_parameter_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_parameter_localization',
      dartName: 'TrainingParameterLocalization',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'training_parameter_localization_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parameterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'localeKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'scoringFeedbacks',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_parameter_localization_fk_0',
          columns: ['parameterId'],
          referenceTable: 'training_parameter',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_parameter_localization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'training_param_loc_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parameterId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'training_param_loc_locale_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'localeKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'training_session_result',
      dartName: 'TrainingSessionResult',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'training_session_result_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'appUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'externalUserId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'overallPercentage',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'criteriaScores',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:TrainingCriteriaScore>?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'training_session_result_fk_0',
          columns: ['appUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'training_session_result_fk_1',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'training_session_result_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'training_session_result_org_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_module_progress',
      dartName: 'UserModuleProgress',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_module_progress_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'appUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'moduleId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _i2.ColumnDefinition(
          name: 'deadline',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ModuleProgressStatus',
          columnDefault: '\'notStarted\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'startedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'user_module_progress_fk_0',
          columns: ['appUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'user_module_progress_fk_1',
          columns: ['organizationId'],
          referenceTable: 'organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_module_progress_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_module_progress_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'appUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'moduleId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_theory_progress',
      dartName: 'UserTheoryProgress',
      schema: 'public',
      module: 'admin_panel',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_theory_progress_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'appUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'chapterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ModuleProgressStatus',
        ),
        _i2.ColumnDefinition(
          name: 'lastWatchedPosition',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_theory_progress_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i4.AppUser) {
      return _i4.AppUser.fromJson(data) as T;
    }
    if (t == _i5.AssessmentParameter) {
      return _i5.AssessmentParameter.fromJson(data) as T;
    }
    if (t == _i6.AssessmentParameterLocalization) {
      return _i6.AssessmentParameterLocalization.fromJson(data) as T;
    }
    if (t == _i7.Asset) {
      return _i7.Asset.fromJson(data) as T;
    }
    if (t == _i8.AssetLocalization) {
      return _i8.AssetLocalization.fromJson(data) as T;
    }
    if (t == _i9.CertificateResponse) {
      return _i9.CertificateResponse.fromJson(data) as T;
    }
    if (t == _i10.ContentBundle) {
      return _i10.ContentBundle.fromJson(data) as T;
    }
    if (t == _i11.LocaleConfig) {
      return _i11.LocaleConfig.fromJson(data) as T;
    }
    if (t == _i12.LocalizedAiPrompt) {
      return _i12.LocalizedAiPrompt.fromJson(data) as T;
    }
    if (t == _i13.LocalizedParameterContent) {
      return _i13.LocalizedParameterContent.fromJson(data) as T;
    }
    if (t == _i14.LocalizedQuizContent) {
      return _i14.LocalizedQuizContent.fromJson(data) as T;
    }
    if (t == _i15.LoginResponse) {
      return _i15.LoginResponse.fromJson(data) as T;
    }
    if (t == _i16.ManagerNotification) {
      return _i16.ManagerNotification.fromJson(data) as T;
    }
    if (t == _i17.ManagerNotificationDetail) {
      return _i17.ManagerNotificationDetail.fromJson(data) as T;
    }
    if (t == _i18.ModuleConfig) {
      return _i18.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i19.ModuleConfigPublic) {
      return _i19.ModuleConfigPublic.fromJson(data) as T;
    }
    if (t == _i20.ModuleProgressStatus) {
      return _i20.ModuleProgressStatus.fromJson(data) as T;
    }
    if (t == _i21.Organization) {
      return _i21.Organization.fromJson(data) as T;
    }
    if (t == _i22.OrganizationUserLink) {
      return _i22.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i23.QuizQuestion) {
      return _i23.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i24.Region) {
      return _i24.Region.fromJson(data) as T;
    }
    if (t == _i25.Role) {
      return _i25.Role.fromJson(data) as T;
    }
    if (t == _i26.ScoringRule) {
      return _i26.ScoringRule.fromJson(data) as T;
    }
    if (t == _i27.SubscriptionModules) {
      return _i27.SubscriptionModules.fromJson(data) as T;
    }
    if (t == _i28.SupportedLanguage) {
      return _i28.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i29.TheoryChapter) {
      return _i29.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i30.TheoryChapterLocalization) {
      return _i30.TheoryChapterLocalization.fromJson(data) as T;
    }
    if (t == _i31.TheoryChapterWithProgress) {
      return _i31.TheoryChapterWithProgress.fromJson(data) as T;
    }
    if (t == _i32.TheorySectionResponse) {
      return _i32.TheorySectionResponse.fromJson(data) as T;
    }
    if (t == _i33.Tools) {
      return _i33.Tools.fromJson(data) as T;
    }
    if (t == _i34.TrainingCriteriaScore) {
      return _i34.TrainingCriteriaScore.fromJson(data) as T;
    }
    if (t == _i35.TrainingParameter) {
      return _i35.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i36.TrainingParameterLocalization) {
      return _i36.TrainingParameterLocalization.fromJson(data) as T;
    }
    if (t == _i37.TrainingSessionResult) {
      return _i37.TrainingSessionResult.fromJson(data) as T;
    }
    if (t == _i38.TrainingSessionResultPage) {
      return _i38.TrainingSessionResultPage.fromJson(data) as T;
    }
    if (t == _i39.TrainingUserSummary) {
      return _i39.TrainingUserSummary.fromJson(data) as T;
    }
    if (t == _i40.TrainingUserSummaryPage) {
      return _i40.TrainingUserSummaryPage.fromJson(data) as T;
    }
    if (t == _i41.UserModuleProgress) {
      return _i41.UserModuleProgress.fromJson(data) as T;
    }
    if (t == _i42.UserTheoryProgress) {
      return _i42.UserTheoryProgress.fromJson(data) as T;
    }
    if (t == _i43.VideoMetadata) {
      return _i43.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.AppUser?>()) {
      return (data != null ? _i4.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AssessmentParameter?>()) {
      return (data != null ? _i5.AssessmentParameter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.AssessmentParameterLocalization?>()) {
      return (data != null
              ? _i6.AssessmentParameterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.Asset?>()) {
      return (data != null ? _i7.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AssetLocalization?>()) {
      return (data != null ? _i8.AssetLocalization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CertificateResponse?>()) {
      return (data != null ? _i9.CertificateResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ContentBundle?>()) {
      return (data != null ? _i10.ContentBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.LocaleConfig?>()) {
      return (data != null ? _i11.LocaleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.LocalizedAiPrompt?>()) {
      return (data != null ? _i12.LocalizedAiPrompt.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.LocalizedParameterContent?>()) {
      return (data != null
              ? _i13.LocalizedParameterContent.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.LocalizedQuizContent?>()) {
      return (data != null ? _i14.LocalizedQuizContent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.LoginResponse?>()) {
      return (data != null ? _i15.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ManagerNotification?>()) {
      return (data != null ? _i16.ManagerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.ManagerNotificationDetail?>()) {
      return (data != null
              ? _i17.ManagerNotificationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.ModuleConfig?>()) {
      return (data != null ? _i18.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ModuleConfigPublic?>()) {
      return (data != null ? _i19.ModuleConfigPublic.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i20.ModuleProgressStatus?>()) {
      return (data != null ? _i20.ModuleProgressStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.Organization?>()) {
      return (data != null ? _i21.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.OrganizationUserLink?>()) {
      return (data != null ? _i22.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.QuizQuestion?>()) {
      return (data != null ? _i23.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Region?>()) {
      return (data != null ? _i24.Region.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Role?>()) {
      return (data != null ? _i25.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.ScoringRule?>()) {
      return (data != null ? _i26.ScoringRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SubscriptionModules?>()) {
      return (data != null ? _i27.SubscriptionModules.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.SupportedLanguage?>()) {
      return (data != null ? _i28.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.TheoryChapter?>()) {
      return (data != null ? _i29.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.TheoryChapterLocalization?>()) {
      return (data != null
              ? _i30.TheoryChapterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i31.TheoryChapterWithProgress?>()) {
      return (data != null
              ? _i31.TheoryChapterWithProgress.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.TheorySectionResponse?>()) {
      return (data != null ? _i32.TheorySectionResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.Tools?>()) {
      return (data != null ? _i33.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.TrainingCriteriaScore?>()) {
      return (data != null ? _i34.TrainingCriteriaScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.TrainingParameter?>()) {
      return (data != null ? _i35.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.TrainingParameterLocalization?>()) {
      return (data != null
              ? _i36.TrainingParameterLocalization.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i37.TrainingSessionResult?>()) {
      return (data != null ? _i37.TrainingSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.TrainingSessionResultPage?>()) {
      return (data != null
              ? _i38.TrainingSessionResultPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i39.TrainingUserSummary?>()) {
      return (data != null ? _i39.TrainingUserSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.TrainingUserSummaryPage?>()) {
      return (data != null ? _i40.TrainingUserSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.UserModuleProgress?>()) {
      return (data != null ? _i41.UserModuleProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.UserTheoryProgress?>()) {
      return (data != null ? _i42.UserTheoryProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.VideoMetadata?>()) {
      return (data != null ? _i43.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i22.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i22.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i22.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i22.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i26.ScoringRule>) {
      return (data as List)
              .map((e) => deserialize<_i26.ScoringRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.LocalizedParameterContent>) {
      return (data as List)
              .map((e) => deserialize<_i13.LocalizedParameterContent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i13.LocalizedParameterContent>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i13.LocalizedParameterContent>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i35.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i35.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i5.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i28.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i28.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i12.LocalizedAiPrompt>) {
      return (data as List)
              .map((e) => deserialize<_i12.LocalizedAiPrompt>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i12.LocalizedAiPrompt>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12.LocalizedAiPrompt>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i11.LocaleConfig>) {
      return (data as List)
              .map((e) => deserialize<_i11.LocaleConfig>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.LocaleConfig>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.LocaleConfig>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i21.Organization>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i21.Organization>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i21.Organization>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i14.LocalizedQuizContent>) {
      return (data as List)
              .map((e) => deserialize<_i14.LocalizedQuizContent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i14.LocalizedQuizContent>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i14.LocalizedQuizContent>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i23.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i23.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i23.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i23.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i29.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i29.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i34.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i34.TrainingCriteriaScore>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i34.TrainingCriteriaScore>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i37.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i37.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.TrainingUserSummary>) {
      return (data as List)
              .map((e) => deserialize<_i39.TrainingUserSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i44.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i44.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.AppUser>) {
      return (data as List).map((e) => deserialize<_i45.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i46.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i46.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.LocalizedAiPrompt>) {
      return (data as List)
              .map((e) => deserialize<_i47.LocalizedAiPrompt>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i47.LocalizedAiPrompt>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i47.LocalizedAiPrompt>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i48.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i48.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i49.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i49.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i50.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.Asset>) {
      return (data as List).map((e) => deserialize<_i51.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i52.Region>) {
      return (data as List).map((e) => deserialize<_i52.Region>(e)).toList()
          as T;
    }
    if (t == List<_i53.LocaleConfig>) {
      return (data as List)
              .map((e) => deserialize<_i53.LocaleConfig>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.UserModuleProgress>) {
      return (data as List)
              .map((e) => deserialize<_i54.UserModuleProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i55.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i55.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i56.TheoryChapterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i56.TheoryChapterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i57.LocalizedQuizContent>) {
      return (data as List)
              .map((e) => deserialize<_i57.LocalizedQuizContent>(e))
              .toList()
          as T;
    }
    if (t == List<_i58.TrainingParameterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i58.TrainingParameterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i59.AssessmentParameterLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i59.AssessmentParameterLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i60.AssetLocalization>) {
      return (data as List)
              .map((e) => deserialize<_i60.AssetLocalization>(e))
              .toList()
          as T;
    }
    if (t == List<_i61.ManagerNotificationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i61.ManagerNotificationDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<_i62.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i62.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i63.TheoryChapterWithProgress>) {
      return (data as List)
              .map((e) => deserialize<_i63.TheoryChapterWithProgress>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i4.AppUser => 'AppUser',
      _i5.AssessmentParameter => 'AssessmentParameter',
      _i6.AssessmentParameterLocalization => 'AssessmentParameterLocalization',
      _i7.Asset => 'Asset',
      _i8.AssetLocalization => 'AssetLocalization',
      _i9.CertificateResponse => 'CertificateResponse',
      _i10.ContentBundle => 'ContentBundle',
      _i11.LocaleConfig => 'LocaleConfig',
      _i12.LocalizedAiPrompt => 'LocalizedAiPrompt',
      _i13.LocalizedParameterContent => 'LocalizedParameterContent',
      _i14.LocalizedQuizContent => 'LocalizedQuizContent',
      _i15.LoginResponse => 'LoginResponse',
      _i16.ManagerNotification => 'ManagerNotification',
      _i17.ManagerNotificationDetail => 'ManagerNotificationDetail',
      _i18.ModuleConfig => 'ModuleConfig',
      _i19.ModuleConfigPublic => 'ModuleConfigPublic',
      _i20.ModuleProgressStatus => 'ModuleProgressStatus',
      _i21.Organization => 'Organization',
      _i22.OrganizationUserLink => 'OrganizationUserLink',
      _i23.QuizQuestion => 'QuizQuestion',
      _i24.Region => 'Region',
      _i25.Role => 'Role',
      _i26.ScoringRule => 'ScoringRule',
      _i27.SubscriptionModules => 'SubscriptionModules',
      _i28.SupportedLanguage => 'SupportedLanguage',
      _i29.TheoryChapter => 'TheoryChapter',
      _i30.TheoryChapterLocalization => 'TheoryChapterLocalization',
      _i31.TheoryChapterWithProgress => 'TheoryChapterWithProgress',
      _i32.TheorySectionResponse => 'TheorySectionResponse',
      _i33.Tools => 'Tools',
      _i34.TrainingCriteriaScore => 'TrainingCriteriaScore',
      _i35.TrainingParameter => 'TrainingParameter',
      _i36.TrainingParameterLocalization => 'TrainingParameterLocalization',
      _i37.TrainingSessionResult => 'TrainingSessionResult',
      _i38.TrainingSessionResultPage => 'TrainingSessionResultPage',
      _i39.TrainingUserSummary => 'TrainingUserSummary',
      _i40.TrainingUserSummaryPage => 'TrainingUserSummaryPage',
      _i41.UserModuleProgress => 'UserModuleProgress',
      _i42.UserTheoryProgress => 'UserTheoryProgress',
      _i43.VideoMetadata => 'VideoMetadata',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('admin_panel.', '');
    }

    switch (data) {
      case _i4.AppUser():
        return 'AppUser';
      case _i5.AssessmentParameter():
        return 'AssessmentParameter';
      case _i6.AssessmentParameterLocalization():
        return 'AssessmentParameterLocalization';
      case _i7.Asset():
        return 'Asset';
      case _i8.AssetLocalization():
        return 'AssetLocalization';
      case _i9.CertificateResponse():
        return 'CertificateResponse';
      case _i10.ContentBundle():
        return 'ContentBundle';
      case _i11.LocaleConfig():
        return 'LocaleConfig';
      case _i12.LocalizedAiPrompt():
        return 'LocalizedAiPrompt';
      case _i13.LocalizedParameterContent():
        return 'LocalizedParameterContent';
      case _i14.LocalizedQuizContent():
        return 'LocalizedQuizContent';
      case _i15.LoginResponse():
        return 'LoginResponse';
      case _i16.ManagerNotification():
        return 'ManagerNotification';
      case _i17.ManagerNotificationDetail():
        return 'ManagerNotificationDetail';
      case _i18.ModuleConfig():
        return 'ModuleConfig';
      case _i19.ModuleConfigPublic():
        return 'ModuleConfigPublic';
      case _i20.ModuleProgressStatus():
        return 'ModuleProgressStatus';
      case _i21.Organization():
        return 'Organization';
      case _i22.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i23.QuizQuestion():
        return 'QuizQuestion';
      case _i24.Region():
        return 'Region';
      case _i25.Role():
        return 'Role';
      case _i26.ScoringRule():
        return 'ScoringRule';
      case _i27.SubscriptionModules():
        return 'SubscriptionModules';
      case _i28.SupportedLanguage():
        return 'SupportedLanguage';
      case _i29.TheoryChapter():
        return 'TheoryChapter';
      case _i30.TheoryChapterLocalization():
        return 'TheoryChapterLocalization';
      case _i31.TheoryChapterWithProgress():
        return 'TheoryChapterWithProgress';
      case _i32.TheorySectionResponse():
        return 'TheorySectionResponse';
      case _i33.Tools():
        return 'Tools';
      case _i34.TrainingCriteriaScore():
        return 'TrainingCriteriaScore';
      case _i35.TrainingParameter():
        return 'TrainingParameter';
      case _i36.TrainingParameterLocalization():
        return 'TrainingParameterLocalization';
      case _i37.TrainingSessionResult():
        return 'TrainingSessionResult';
      case _i38.TrainingSessionResultPage():
        return 'TrainingSessionResultPage';
      case _i39.TrainingUserSummary():
        return 'TrainingUserSummary';
      case _i40.TrainingUserSummaryPage():
        return 'TrainingUserSummaryPage';
      case _i41.UserModuleProgress():
        return 'UserModuleProgress';
      case _i42.UserTheoryProgress():
        return 'UserTheoryProgress';
      case _i43.VideoMetadata():
        return 'VideoMetadata';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
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
      return deserialize<_i4.AppUser>(data['data']);
    }
    if (dataClassName == 'AssessmentParameter') {
      return deserialize<_i5.AssessmentParameter>(data['data']);
    }
    if (dataClassName == 'AssessmentParameterLocalization') {
      return deserialize<_i6.AssessmentParameterLocalization>(data['data']);
    }
    if (dataClassName == 'Asset') {
      return deserialize<_i7.Asset>(data['data']);
    }
    if (dataClassName == 'AssetLocalization') {
      return deserialize<_i8.AssetLocalization>(data['data']);
    }
    if (dataClassName == 'CertificateResponse') {
      return deserialize<_i9.CertificateResponse>(data['data']);
    }
    if (dataClassName == 'ContentBundle') {
      return deserialize<_i10.ContentBundle>(data['data']);
    }
    if (dataClassName == 'LocaleConfig') {
      return deserialize<_i11.LocaleConfig>(data['data']);
    }
    if (dataClassName == 'LocalizedAiPrompt') {
      return deserialize<_i12.LocalizedAiPrompt>(data['data']);
    }
    if (dataClassName == 'LocalizedParameterContent') {
      return deserialize<_i13.LocalizedParameterContent>(data['data']);
    }
    if (dataClassName == 'LocalizedQuizContent') {
      return deserialize<_i14.LocalizedQuizContent>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i15.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ManagerNotification') {
      return deserialize<_i16.ManagerNotification>(data['data']);
    }
    if (dataClassName == 'ManagerNotificationDetail') {
      return deserialize<_i17.ManagerNotificationDetail>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i18.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'ModuleConfigPublic') {
      return deserialize<_i19.ModuleConfigPublic>(data['data']);
    }
    if (dataClassName == 'ModuleProgressStatus') {
      return deserialize<_i20.ModuleProgressStatus>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i21.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i22.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i23.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Region') {
      return deserialize<_i24.Region>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i25.Role>(data['data']);
    }
    if (dataClassName == 'ScoringRule') {
      return deserialize<_i26.ScoringRule>(data['data']);
    }
    if (dataClassName == 'SubscriptionModules') {
      return deserialize<_i27.SubscriptionModules>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i28.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i29.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'TheoryChapterLocalization') {
      return deserialize<_i30.TheoryChapterLocalization>(data['data']);
    }
    if (dataClassName == 'TheoryChapterWithProgress') {
      return deserialize<_i31.TheoryChapterWithProgress>(data['data']);
    }
    if (dataClassName == 'TheorySectionResponse') {
      return deserialize<_i32.TheorySectionResponse>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i33.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingCriteriaScore') {
      return deserialize<_i34.TrainingCriteriaScore>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i35.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'TrainingParameterLocalization') {
      return deserialize<_i36.TrainingParameterLocalization>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResult') {
      return deserialize<_i37.TrainingSessionResult>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResultPage') {
      return deserialize<_i38.TrainingSessionResultPage>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummary') {
      return deserialize<_i39.TrainingUserSummary>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummaryPage') {
      return deserialize<_i40.TrainingUserSummaryPage>(data['data']);
    }
    if (dataClassName == 'UserModuleProgress') {
      return deserialize<_i41.UserModuleProgress>(data['data']);
    }
    if (dataClassName == 'UserTheoryProgress') {
      return deserialize<_i42.UserTheoryProgress>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i43.VideoMetadata>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i4.AppUser:
        return _i4.AppUser.t;
      case _i5.AssessmentParameter:
        return _i5.AssessmentParameter.t;
      case _i6.AssessmentParameterLocalization:
        return _i6.AssessmentParameterLocalization.t;
      case _i7.Asset:
        return _i7.Asset.t;
      case _i8.AssetLocalization:
        return _i8.AssetLocalization.t;
      case _i11.LocaleConfig:
        return _i11.LocaleConfig.t;
      case _i16.ManagerNotification:
        return _i16.ManagerNotification.t;
      case _i18.ModuleConfig:
        return _i18.ModuleConfig.t;
      case _i21.Organization:
        return _i21.Organization.t;
      case _i22.OrganizationUserLink:
        return _i22.OrganizationUserLink.t;
      case _i24.Region:
        return _i24.Region.t;
      case _i29.TheoryChapter:
        return _i29.TheoryChapter.t;
      case _i30.TheoryChapterLocalization:
        return _i30.TheoryChapterLocalization.t;
      case _i35.TrainingParameter:
        return _i35.TrainingParameter.t;
      case _i36.TrainingParameterLocalization:
        return _i36.TrainingParameterLocalization.t;
      case _i37.TrainingSessionResult:
        return _i37.TrainingSessionResult.t;
      case _i41.UserModuleProgress:
        return _i41.UserModuleProgress.t;
      case _i42.UserTheoryProgress:
        return _i42.UserTheoryProgress.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'admin_panel';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
