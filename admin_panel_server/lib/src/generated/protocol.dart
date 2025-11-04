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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'app_user.dart' as _i4;
import 'login_response.dart' as _i5;
import 'organization.dart' as _i6;
import 'organization_user_link.dart' as _i7;
import 'role.dart' as _i8;
import 'tools.dart' as _i9;
import 'package:admin_panel_server/src/generated/organization.dart' as _i10;
import 'package:admin_panel_server/src/generated/app_user.dart' as _i11;
export 'app_user.dart';
export 'login_response.dart';
export 'organization.dart';
export 'organization_user_link.dart';
export 'role.dart';
export 'tools.dart';

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
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_user_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
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
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'organization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
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
            )
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
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.AppUser) {
      return _i4.AppUser.fromJson(data) as T;
    }
    if (t == _i5.LoginResponse) {
      return _i5.LoginResponse.fromJson(data) as T;
    }
    if (t == _i6.Organization) {
      return _i6.Organization.fromJson(data) as T;
    }
    if (t == _i7.OrganizationUserLink) {
      return _i7.OrganizationUserLink.fromJson(data) as T;
    }
    if (t == _i8.Role) {
      return _i8.Role.fromJson(data) as T;
    }
    if (t == _i9.Tools) {
      return _i9.Tools.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.AppUser?>()) {
      return (data != null ? _i4.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.LoginResponse?>()) {
      return (data != null ? _i5.LoginResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Organization?>()) {
      return (data != null ? _i6.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.OrganizationUserLink?>()) {
      return (data != null ? _i7.OrganizationUserLink.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.Role?>()) {
      return (data != null ? _i8.Role.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Tools?>()) {
      return (data != null ? _i9.Tools.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i7.OrganizationUserLink>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.OrganizationUserLink>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.OrganizationUserLink>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.OrganizationUserLink>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i10.Organization>) {
      return (data as List)
          .map((e) => deserialize<_i10.Organization>(e))
          .toList() as T;
    }
    if (t == List<_i11.AppUser>) {
      return (data as List).map((e) => deserialize<_i11.AppUser>(e)).toList()
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

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.AppUser) {
      return 'AppUser';
    }
    if (data is _i5.LoginResponse) {
      return 'LoginResponse';
    }
    if (data is _i6.Organization) {
      return 'Organization';
    }
    if (data is _i7.OrganizationUserLink) {
      return 'OrganizationUserLink';
    }
    if (data is _i8.Role) {
      return 'Role';
    }
    if (data is _i9.Tools) {
      return 'Tools';
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
    if (dataClassName == 'LoginResponse') {
      return deserialize<_i5.LoginResponse>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i6.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationUserLink') {
      return deserialize<_i7.OrganizationUserLink>(data['data']);
    }
    if (dataClassName == 'Role') {
      return deserialize<_i8.Role>(data['data']);
    }
    if (dataClassName == 'Tools') {
      return deserialize<_i9.Tools>(data['data']);
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
      case _i6.Organization:
        return _i6.Organization.t;
      case _i7.OrganizationUserLink:
        return _i7.OrganizationUserLink.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'admin_panel';
}
