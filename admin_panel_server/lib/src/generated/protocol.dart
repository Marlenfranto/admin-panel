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
import 'asset.dart' as _i6;
import 'certificate_response.dart' as _i7;
import 'content_bundle.dart' as _i8;
import 'languages_config.dart' as _i9;
import 'localized_quiz_content.dart' as _i10;
import 'login_response.dart' as _i11;
import 'manager_notification.dart' as _i12;
import 'manager_notification_detail.dart' as _i13;
import 'module_config.dart' as _i14;
import 'module_config_public.dart' as _i15;
import 'module_progress_status.dart' as _i16;
import 'organization.dart' as _i17;
import 'organization_user_link.dart' as _i18;
import 'quiz_question.dart' as _i19;
import 'role.dart' as _i20;
import 'scoring_rule.dart' as _i21;
import 'subscription_modules.dart' as _i22;
import 'supported_language.dart' as _i23;
import 'theory_chapter.dart' as _i24;
import 'theory_chapter_with_progress.dart' as _i25;
import 'theory_section_response.dart' as _i26;
import 'tools.dart' as _i27;
import 'training_criteria_score.dart' as _i28;
import 'training_parameter.dart' as _i29;
import 'training_session_result.dart' as _i30;
import 'training_session_result_page.dart' as _i31;
import 'training_user_summary.dart' as _i32;
import 'training_user_summary_page.dart' as _i33;
import 'user_module_progress.dart' as _i34;
import 'user_theory_progress.dart' as _i35;
import 'video_metadata.dart' as _i36;
import 'package:admin_panel_server/src/generated/organization.dart' as _i37;
import 'package:admin_panel_server/src/generated/app_user.dart' as _i38;
import 'package:admin_panel_server/src/generated/supported_language.dart'
    as _i39;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i40;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i41;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i42;
import 'package:admin_panel_server/src/generated/asset.dart' as _i43;
import 'package:admin_panel_server/src/generated/user_module_progress.dart'
    as _i44;
import 'package:admin_panel_server/src/generated/training_session_result.dart'
    as _i45;
import 'package:admin_panel_server/src/generated/manager_notification_detail.dart'
    as _i46;
import 'package:admin_panel_server/src/generated/training_criteria_score.dart'
    as _i47;
import 'package:admin_panel_server/src/generated/theory_chapter_with_progress.dart'
    as _i48;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'asset.dart';
export 'certificate_response.dart';
export 'content_bundle.dart';
export 'languages_config.dart';
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
export 'role.dart';
export 'scoring_rule.dart';
export 'subscription_modules.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'theory_chapter_with_progress.dart';
export 'theory_section_response.dart';
export 'tools.dart';
export 'training_criteria_score.dart';
export 'training_parameter.dart';
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
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'url',
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
          name: 'defaultLanguage',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'en\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'supportedLanguages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:SupportedLanguage>?',
        ),
        _i2.ColumnDefinition(
          name: 'aiChatPrompt',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
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
    if (t == _i6.Asset) {
      return _i6.Asset.fromJson(data) as T;
    }
    if (t == _i7.CertificateResponse) {
      return _i7.CertificateResponse.fromJson(data) as T;
    }
    if (t == _i8.ContentBundle) {
      return _i8.ContentBundle.fromJson(data) as T;
    }
    if (t == _i9.LanguagesConfig) {
      return _i9.LanguagesConfig.fromJson(data) as T;
    }
    if (t == _i10.LocalizedQuizContent) {
      return _i10.LocalizedQuizContent.fromJson(data) as T;
    }
    if (t == _i11.LoginResponse) {
      return _i11.LoginResponse.fromJson(data) as T;
    }
    if (t == _i12.ManagerNotification) {
      return _i12.ManagerNotification.fromJson(data) as T;
    }
    if (t == _i13.ManagerNotificationDetail) {
      return _i13.ManagerNotificationDetail.fromJson(data) as T;
    }
    if (t == _i14.ModuleConfig) {
      return _i14.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i15.ModuleConfigPublic) {
      return _i15.ModuleConfigPublic.fromJson(data) as T;
    }
    if (t == _i16.ModuleProgressStatus) {
      return _i16.ModuleProgressStatus.fromJson(data) as T;
    }
    if (t == _i17.Organization) {
      return _i17.Organization.fromJson(data) as T;
    }
    if (t == _i18.OrganizationUserLink) {
      return _i18.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i19.QuizQuestion) {
      return _i19.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i20.Role) {
      return _i20.Role.fromJson(data) as T;
    }
    if (t == _i21.ScoringRule) {
      return _i21.ScoringRule.fromJson(data) as T;
    }
    if (t == _i22.SubscriptionModules) {
      return _i22.SubscriptionModules.fromJson(data) as T;
    }
    if (t == _i23.SupportedLanguage) {
      return _i23.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i24.TheoryChapter) {
      return _i24.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i25.TheoryChapterWithProgress) {
      return _i25.TheoryChapterWithProgress.fromJson(data) as T;
    }
    if (t == _i26.TheorySectionResponse) {
      return _i26.TheorySectionResponse.fromJson(data) as T;
    }
    if (t == _i27.Tools) {
      return _i27.Tools.fromJson(data) as T;
    }
    if (t == _i28.TrainingCriteriaScore) {
      return _i28.TrainingCriteriaScore.fromJson(data) as T;
    }
    if (t == _i29.TrainingParameter) {
      return _i29.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i30.TrainingSessionResult) {
      return _i30.TrainingSessionResult.fromJson(data) as T;
    }
    if (t == _i31.TrainingSessionResultPage) {
      return _i31.TrainingSessionResultPage.fromJson(data) as T;
    }
    if (t == _i32.TrainingUserSummary) {
      return _i32.TrainingUserSummary.fromJson(data) as T;
    }
    if (t == _i33.TrainingUserSummaryPage) {
      return _i33.TrainingUserSummaryPage.fromJson(data) as T;
    }
    if (t == _i34.UserModuleProgress) {
      return _i34.UserModuleProgress.fromJson(data) as T;
    }
    if (t == _i35.UserTheoryProgress) {
      return _i35.UserTheoryProgress.fromJson(data) as T;
    }
    if (t == _i36.VideoMetadata) {
      return _i36.VideoMetadata.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.AppUser?>()) {
      return (data != null ? _i4.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AssessmentParameter?>()) {
      return (data != null ? _i5.AssessmentParameter.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.Asset?>()) {
      return (data != null ? _i6.Asset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CertificateResponse?>()) {
      return (data != null ? _i7.CertificateResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.ContentBundle?>()) {
      return (data != null ? _i8.ContentBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.LanguagesConfig?>()) {
      return (data != null ? _i9.LanguagesConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.LocalizedQuizContent?>()) {
      return (data != null ? _i10.LocalizedQuizContent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.LoginResponse?>()) {
      return (data != null ? _i11.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ManagerNotification?>()) {
      return (data != null ? _i12.ManagerNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ManagerNotificationDetail?>()) {
      return (data != null
              ? _i13.ManagerNotificationDetail.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.ModuleConfig?>()) {
      return (data != null ? _i14.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ModuleConfigPublic?>()) {
      return (data != null ? _i15.ModuleConfigPublic.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.ModuleProgressStatus?>()) {
      return (data != null ? _i16.ModuleProgressStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Organization?>()) {
      return (data != null ? _i17.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.OrganizationUserLink?>()) {
      return (data != null ? _i18.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.QuizQuestion?>()) {
      return (data != null ? _i19.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Role?>()) {
      return (data != null ? _i20.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.ScoringRule?>()) {
      return (data != null ? _i21.ScoringRule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.SubscriptionModules?>()) {
      return (data != null ? _i22.SubscriptionModules.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i23.SupportedLanguage?>()) {
      return (data != null ? _i23.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.TheoryChapter?>()) {
      return (data != null ? _i24.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.TheoryChapterWithProgress?>()) {
      return (data != null
              ? _i25.TheoryChapterWithProgress.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i26.TheorySectionResponse?>()) {
      return (data != null ? _i26.TheorySectionResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.Tools?>()) {
      return (data != null ? _i27.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TrainingCriteriaScore?>()) {
      return (data != null ? _i28.TrainingCriteriaScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.TrainingParameter?>()) {
      return (data != null ? _i29.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.TrainingSessionResult?>()) {
      return (data != null ? _i30.TrainingSessionResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.TrainingSessionResultPage?>()) {
      return (data != null
              ? _i31.TrainingSessionResultPage.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.TrainingUserSummary?>()) {
      return (data != null ? _i32.TrainingUserSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.TrainingUserSummaryPage?>()) {
      return (data != null ? _i33.TrainingUserSummaryPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.UserModuleProgress?>()) {
      return (data != null ? _i34.UserModuleProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.UserTheoryProgress?>()) {
      return (data != null ? _i35.UserTheoryProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.VideoMetadata?>()) {
      return (data != null ? _i36.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i18.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i18.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i18.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i18.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i21.ScoringRule>) {
      return (data as List)
              .map((e) => deserialize<_i21.ScoringRule>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i29.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i5.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i5.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i23.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i23.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i23.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i17.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i17.Organization>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i17.Organization>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i17.Organization>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i10.LocalizedQuizContent>) {
      return (data as List)
              .map((e) => deserialize<_i10.LocalizedQuizContent>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i10.LocalizedQuizContent>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i10.LocalizedQuizContent>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i19.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i19.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i19.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i19.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i24.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i24.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i28.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i28.TrainingCriteriaScore>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i28.TrainingCriteriaScore>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i30.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i30.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.TrainingUserSummary>) {
      return (data as List)
              .map((e) => deserialize<_i32.TrainingUserSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i37.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i37.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i38.AppUser>) {
      return (data as List).map((e) => deserialize<_i38.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i39.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i39.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i40.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i40.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i41.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i41.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i42.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i43.Asset>) {
      return (data as List).map((e) => deserialize<_i43.Asset>(e)).toList()
          as T;
    }
    if (t == List<_i44.UserModuleProgress>) {
      return (data as List)
              .map((e) => deserialize<_i44.UserModuleProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i45.TrainingSessionResult>) {
      return (data as List)
              .map((e) => deserialize<_i45.TrainingSessionResult>(e))
              .toList()
          as T;
    }
    if (t == List<_i46.ManagerNotificationDetail>) {
      return (data as List)
              .map((e) => deserialize<_i46.ManagerNotificationDetail>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    if (t == List<Map<String, dynamic>>) {
      return (data as List)
              .map((e) => deserialize<Map<String, dynamic>>(e))
              .toList()
          as T;
    }
    if (t == List<_i47.TrainingCriteriaScore>) {
      return (data as List)
              .map((e) => deserialize<_i47.TrainingCriteriaScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.TheoryChapterWithProgress>) {
      return (data as List)
              .map((e) => deserialize<_i48.TheoryChapterWithProgress>(e))
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
      _i6.Asset => 'Asset',
      _i7.CertificateResponse => 'CertificateResponse',
      _i8.ContentBundle => 'ContentBundle',
      _i9.LanguagesConfig => 'LanguagesConfig',
      _i10.LocalizedQuizContent => 'LocalizedQuizContent',
      _i11.LoginResponse => 'LoginResponse',
      _i12.ManagerNotification => 'ManagerNotification',
      _i13.ManagerNotificationDetail => 'ManagerNotificationDetail',
      _i14.ModuleConfig => 'ModuleConfig',
      _i15.ModuleConfigPublic => 'ModuleConfigPublic',
      _i16.ModuleProgressStatus => 'ModuleProgressStatus',
      _i17.Organization => 'Organization',
      _i18.OrganizationUserLink => 'OrganizationUserLink',
      _i19.QuizQuestion => 'QuizQuestion',
      _i20.Role => 'Role',
      _i21.ScoringRule => 'ScoringRule',
      _i22.SubscriptionModules => 'SubscriptionModules',
      _i23.SupportedLanguage => 'SupportedLanguage',
      _i24.TheoryChapter => 'TheoryChapter',
      _i25.TheoryChapterWithProgress => 'TheoryChapterWithProgress',
      _i26.TheorySectionResponse => 'TheorySectionResponse',
      _i27.Tools => 'Tools',
      _i28.TrainingCriteriaScore => 'TrainingCriteriaScore',
      _i29.TrainingParameter => 'TrainingParameter',
      _i30.TrainingSessionResult => 'TrainingSessionResult',
      _i31.TrainingSessionResultPage => 'TrainingSessionResultPage',
      _i32.TrainingUserSummary => 'TrainingUserSummary',
      _i33.TrainingUserSummaryPage => 'TrainingUserSummaryPage',
      _i34.UserModuleProgress => 'UserModuleProgress',
      _i35.UserTheoryProgress => 'UserTheoryProgress',
      _i36.VideoMetadata => 'VideoMetadata',
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
      case _i6.Asset():
        return 'Asset';
      case _i7.CertificateResponse():
        return 'CertificateResponse';
      case _i8.ContentBundle():
        return 'ContentBundle';
      case _i9.LanguagesConfig():
        return 'LanguagesConfig';
      case _i10.LocalizedQuizContent():
        return 'LocalizedQuizContent';
      case _i11.LoginResponse():
        return 'LoginResponse';
      case _i12.ManagerNotification():
        return 'ManagerNotification';
      case _i13.ManagerNotificationDetail():
        return 'ManagerNotificationDetail';
      case _i14.ModuleConfig():
        return 'ModuleConfig';
      case _i15.ModuleConfigPublic():
        return 'ModuleConfigPublic';
      case _i16.ModuleProgressStatus():
        return 'ModuleProgressStatus';
      case _i17.Organization():
        return 'Organization';
      case _i18.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i19.QuizQuestion():
        return 'QuizQuestion';
      case _i20.Role():
        return 'Role';
      case _i21.ScoringRule():
        return 'ScoringRule';
      case _i22.SubscriptionModules():
        return 'SubscriptionModules';
      case _i23.SupportedLanguage():
        return 'SupportedLanguage';
      case _i24.TheoryChapter():
        return 'TheoryChapter';
      case _i25.TheoryChapterWithProgress():
        return 'TheoryChapterWithProgress';
      case _i26.TheorySectionResponse():
        return 'TheorySectionResponse';
      case _i27.Tools():
        return 'Tools';
      case _i28.TrainingCriteriaScore():
        return 'TrainingCriteriaScore';
      case _i29.TrainingParameter():
        return 'TrainingParameter';
      case _i30.TrainingSessionResult():
        return 'TrainingSessionResult';
      case _i31.TrainingSessionResultPage():
        return 'TrainingSessionResultPage';
      case _i32.TrainingUserSummary():
        return 'TrainingUserSummary';
      case _i33.TrainingUserSummaryPage():
        return 'TrainingUserSummaryPage';
      case _i34.UserModuleProgress():
        return 'UserModuleProgress';
      case _i35.UserTheoryProgress():
        return 'UserTheoryProgress';
      case _i36.VideoMetadata():
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
    if (dataClassName == 'Asset') {
      return deserialize<_i6.Asset>(data['data']);
    }
    if (dataClassName == 'CertificateResponse') {
      return deserialize<_i7.CertificateResponse>(data['data']);
    }
    if (dataClassName == 'ContentBundle') {
      return deserialize<_i8.ContentBundle>(data['data']);
    }
    if (dataClassName == 'LanguagesConfig') {
      return deserialize<_i9.LanguagesConfig>(data['data']);
    }
    if (dataClassName == 'LocalizedQuizContent') {
      return deserialize<_i10.LocalizedQuizContent>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i11.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ManagerNotification') {
      return deserialize<_i12.ManagerNotification>(data['data']);
    }
    if (dataClassName == 'ManagerNotificationDetail') {
      return deserialize<_i13.ManagerNotificationDetail>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i14.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'ModuleConfigPublic') {
      return deserialize<_i15.ModuleConfigPublic>(data['data']);
    }
    if (dataClassName == 'ModuleProgressStatus') {
      return deserialize<_i16.ModuleProgressStatus>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i17.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i18.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i19.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i20.Role>(data['data']);
    }
    if (dataClassName == 'ScoringRule') {
      return deserialize<_i21.ScoringRule>(data['data']);
    }
    if (dataClassName == 'SubscriptionModules') {
      return deserialize<_i22.SubscriptionModules>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i23.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i24.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'TheoryChapterWithProgress') {
      return deserialize<_i25.TheoryChapterWithProgress>(data['data']);
    }
    if (dataClassName == 'TheorySectionResponse') {
      return deserialize<_i26.TheorySectionResponse>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i27.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingCriteriaScore') {
      return deserialize<_i28.TrainingCriteriaScore>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i29.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResult') {
      return deserialize<_i30.TrainingSessionResult>(data['data']);
    }
    if (dataClassName == 'TrainingSessionResultPage') {
      return deserialize<_i31.TrainingSessionResultPage>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummary') {
      return deserialize<_i32.TrainingUserSummary>(data['data']);
    }
    if (dataClassName == 'TrainingUserSummaryPage') {
      return deserialize<_i33.TrainingUserSummaryPage>(data['data']);
    }
    if (dataClassName == 'UserModuleProgress') {
      return deserialize<_i34.UserModuleProgress>(data['data']);
    }
    if (dataClassName == 'UserTheoryProgress') {
      return deserialize<_i35.UserTheoryProgress>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i36.VideoMetadata>(data['data']);
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
      case _i6.Asset:
        return _i6.Asset.t;
      case _i12.ManagerNotification:
        return _i12.ManagerNotification.t;
      case _i14.ModuleConfig:
        return _i14.ModuleConfig.t;
      case _i17.Organization:
        return _i17.Organization.t;
      case _i18.OrganizationUserLink:
        return _i18.OrganizationUserLink.t;
      case _i24.TheoryChapter:
        return _i24.TheoryChapter.t;
      case _i29.TrainingParameter:
        return _i29.TrainingParameter.t;
      case _i30.TrainingSessionResult:
        return _i30.TrainingSessionResult.t;
      case _i34.UserModuleProgress:
        return _i34.UserModuleProgress.t;
      case _i35.UserTheoryProgress:
        return _i35.UserTheoryProgress.t;
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
