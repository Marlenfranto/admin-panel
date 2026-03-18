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
import 'feedback_level.dart' as _i7;
import 'login_response.dart' as _i8;
import 'module_config.dart' as _i9;
import 'organization.dart' as _i10;
import 'organization_user_link.dart' as _i11;
import 'quiz_question.dart' as _i12;
import 'role.dart' as _i13;
import 'supported_language.dart' as _i14;
import 'theory_chapter.dart' as _i15;
import 'tools.dart' as _i16;
import 'training_parameter.dart' as _i17;
import 'video_metadata.dart' as _i18;
import 'package:admin_panel_server/src/generated/organization.dart' as _i19;
import 'package:admin_panel_server/src/generated/app_user.dart' as _i20;
import 'package:admin_panel_server/src/generated/supported_language.dart'
    as _i21;
import 'package:admin_panel_server/src/generated/theory_chapter.dart' as _i22;
import 'package:admin_panel_server/src/generated/training_parameter.dart'
    as _i23;
import 'package:admin_panel_server/src/generated/assessment_parameter.dart'
    as _i24;
import 'package:admin_panel_server/src/generated/asset.dart' as _i25;
export 'app_user.dart';
export 'assessment_parameter.dart';
export 'asset.dart';
export 'feedback_level.dart';
export 'login_response.dart';
export 'module_config.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'quiz_question.dart';
export 'role.dart';
export 'supported_language.dart';
export 'theory_chapter.dart';
export 'tools.dart';
export 'training_parameter.dart';
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
          name: 'tools',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:Tools',
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
          name: 'logic',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackLow',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackMedium',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackHigh',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
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
          name: 'managerId',
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
          name: 'logic',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'hint',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackLow',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackMedium',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
        ),
        _i2.ColumnDefinition(
          name: 'feedbackHigh',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeedbackLevel',
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
    if (t == _i7.FeedbackLevel) {
      return _i7.FeedbackLevel.fromJson(data) as T;
    }
    if (t == _i8.LoginResponse) {
      return _i8.LoginResponse.fromJson(data) as T;
    }
    if (t == _i9.ModuleConfig) {
      return _i9.ModuleConfig.fromJson(data) as T;
    }
    if (t == _i10.Organization) {
      return _i10.Organization.fromJson(data) as T;
    }
    if (t == _i11.OrganizationUserLink) {
      return _i11.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i12.QuizQuestion) {
      return _i12.QuizQuestion.fromJson(data) as T;
    }
    if (t == _i13.Role) {
      return _i13.Role.fromJson(data) as T;
    }
    if (t == _i14.SupportedLanguage) {
      return _i14.SupportedLanguage.fromJson(data) as T;
    }
    if (t == _i15.TheoryChapter) {
      return _i15.TheoryChapter.fromJson(data) as T;
    }
    if (t == _i16.Tools) {
      return _i16.Tools.fromJson(data) as T;
    }
    if (t == _i17.TrainingParameter) {
      return _i17.TrainingParameter.fromJson(data) as T;
    }
    if (t == _i18.VideoMetadata) {
      return _i18.VideoMetadata.fromJson(data) as T;
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
    if (t == _i1.getType<_i7.FeedbackLevel?>()) {
      return (data != null ? _i7.FeedbackLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LoginResponse?>()) {
      return (data != null ? _i8.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ModuleConfig?>()) {
      return (data != null ? _i9.ModuleConfig.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Organization?>()) {
      return (data != null ? _i10.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrganizationUserLink?>()) {
      return (data != null ? _i11.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.QuizQuestion?>()) {
      return (data != null ? _i12.QuizQuestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Role?>()) {
      return (data != null ? _i13.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SupportedLanguage?>()) {
      return (data != null ? _i14.SupportedLanguage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.TheoryChapter?>()) {
      return (data != null ? _i15.TheoryChapter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Tools?>()) {
      return (data != null ? _i16.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.TrainingParameter?>()) {
      return (data != null ? _i17.TrainingParameter.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.VideoMetadata?>()) {
      return (data != null ? _i18.VideoMetadata.fromJson(data) : null) as T;
    }
    if (t == List<_i11.OrganizationUserLink>) {
      return (data as List)
              .map((e) => deserialize<_i11.OrganizationUserLink>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i11.OrganizationUserLink>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i11.OrganizationUserLink>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i14.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i14.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i14.SupportedLanguage>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i14.SupportedLanguage>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i12.QuizQuestion>) {
      return (data as List)
              .map((e) => deserialize<_i12.QuizQuestion>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i12.QuizQuestion>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i12.QuizQuestion>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i19.Organization>) {
      return (data as List)
              .map((e) => deserialize<_i19.Organization>(e))
              .toList()
          as T;
    }
    if (t == List<_i20.AppUser>) {
      return (data as List).map((e) => deserialize<_i20.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i21.SupportedLanguage>) {
      return (data as List)
              .map((e) => deserialize<_i21.SupportedLanguage>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.TheoryChapter>) {
      return (data as List)
              .map((e) => deserialize<_i22.TheoryChapter>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.TrainingParameter>) {
      return (data as List)
              .map((e) => deserialize<_i23.TrainingParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i24.AssessmentParameter>) {
      return (data as List)
              .map((e) => deserialize<_i24.AssessmentParameter>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.Asset>) {
      return (data as List).map((e) => deserialize<_i25.Asset>(e)).toList()
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
      _i7.FeedbackLevel => 'FeedbackLevel',
      _i8.LoginResponse => 'LoginResponse',
      _i9.ModuleConfig => 'ModuleConfig',
      _i10.Organization => 'Organization',
      _i11.OrganizationUserLink => 'OrganizationUserLink',
      _i12.QuizQuestion => 'QuizQuestion',
      _i13.Role => 'Role',
      _i14.SupportedLanguage => 'SupportedLanguage',
      _i15.TheoryChapter => 'TheoryChapter',
      _i16.Tools => 'Tools',
      _i17.TrainingParameter => 'TrainingParameter',
      _i18.VideoMetadata => 'VideoMetadata',
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
      case _i7.FeedbackLevel():
        return 'FeedbackLevel';
      case _i8.LoginResponse():
        return 'LoginResponse';
      case _i9.ModuleConfig():
        return 'ModuleConfig';
      case _i10.Organization():
        return 'Organization';
      case _i11.OrganizationUserLink():
        return 'OrganizationUserLink';
      case _i12.QuizQuestion():
        return 'QuizQuestion';
      case _i13.Role():
        return 'Role';
      case _i14.SupportedLanguage():
        return 'SupportedLanguage';
      case _i15.TheoryChapter():
        return 'TheoryChapter';
      case _i16.Tools():
        return 'Tools';
      case _i17.TrainingParameter():
        return 'TrainingParameter';
      case _i18.VideoMetadata():
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
    if (dataClassName == 'FeedbackLevel') {
      return deserialize<_i7.FeedbackLevel>(data['data']);
    }
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i8.LoginResponse>(data['data']);
    }
    if (dataClassName == 'ModuleConfig') {
      return deserialize<_i9.ModuleConfig>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i10.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i11.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'QuizQuestion') {
      return deserialize<_i12.QuizQuestion>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i13.Role>(data['data']);
    }
    if (dataClassName == 'SupportedLanguage') {
      return deserialize<_i14.SupportedLanguage>(data['data']);
    }
    if (dataClassName == 'TheoryChapter') {
      return deserialize<_i15.TheoryChapter>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i16.Tools>(data['data']);
    }
    if (dataClassName == 'TrainingParameter') {
      return deserialize<_i17.TrainingParameter>(data['data']);
    }
    if (dataClassName == 'VideoMetadata') {
      return deserialize<_i18.VideoMetadata>(data['data']);
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
      case _i9.ModuleConfig:
        return _i9.ModuleConfig.t;
      case _i10.Organization:
        return _i10.Organization.t;
      case _i11.OrganizationUserLink:
        return _i11.OrganizationUserLink.t;
      case _i15.TheoryChapter:
        return _i15.TheoryChapter.t;
      case _i17.TrainingParameter:
        return _i17.TrainingParameter.t;
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
