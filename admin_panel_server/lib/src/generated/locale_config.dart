/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'organization.dart' as _i2;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i3;

abstract class LocaleConfig
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  LocaleConfig._({
    this.id,
    this.organizationId,
    this.organization,
    required this.regionCode,
    required this.languageCode,
    required this.localeKey,
    required this.displayName,
    bool? enabled,
    bool? isDefault,
    this.fallbackLocaleKey,
  }) : enabled = enabled ?? true,
       isDefault = isDefault ?? false;

  factory LocaleConfig({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String regionCode,
    required String languageCode,
    required String localeKey,
    required String displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  }) = _LocaleConfigImpl;

  factory LocaleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocaleConfig(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      regionCode: jsonSerialization['regionCode'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      localeKey: jsonSerialization['localeKey'] as String,
      displayName: jsonSerialization['displayName'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      fallbackLocaleKey: jsonSerialization['fallbackLocaleKey'] as String?,
    );
  }

  static final t = LocaleConfigTable();

  static const db = LocaleConfigRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String regionCode;

  String languageCode;

  String localeKey;

  String displayName;

  bool enabled;

  bool isDefault;

  String? fallbackLocaleKey;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [LocaleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocaleConfig copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? regionCode,
    String? languageCode,
    String? localeKey,
    String? displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocaleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'regionCode': regionCode,
      'languageCode': languageCode,
      'localeKey': localeKey,
      'displayName': displayName,
      'enabled': enabled,
      'isDefault': isDefault,
      if (fallbackLocaleKey != null) 'fallbackLocaleKey': fallbackLocaleKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocaleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'regionCode': regionCode,
      'languageCode': languageCode,
      'localeKey': localeKey,
      'displayName': displayName,
      'enabled': enabled,
      'isDefault': isDefault,
      if (fallbackLocaleKey != null) 'fallbackLocaleKey': fallbackLocaleKey,
    };
  }

  static LocaleConfigInclude include({_i2.OrganizationInclude? organization}) {
    return LocaleConfigInclude._(organization: organization);
  }

  static LocaleConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<LocaleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocaleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocaleConfigTable>? orderByList,
    LocaleConfigInclude? include,
  }) {
    return LocaleConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocaleConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LocaleConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocaleConfigImpl extends LocaleConfig {
  _LocaleConfigImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String regionCode,
    required String languageCode,
    required String localeKey,
    required String displayName,
    bool? enabled,
    bool? isDefault,
    String? fallbackLocaleKey,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         regionCode: regionCode,
         languageCode: languageCode,
         localeKey: localeKey,
         displayName: displayName,
         enabled: enabled,
         isDefault: isDefault,
         fallbackLocaleKey: fallbackLocaleKey,
       );

  /// Returns a shallow copy of this [LocaleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocaleConfig copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? regionCode,
    String? languageCode,
    String? localeKey,
    String? displayName,
    bool? enabled,
    bool? isDefault,
    Object? fallbackLocaleKey = _Undefined,
  }) {
    return LocaleConfig(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      regionCode: regionCode ?? this.regionCode,
      languageCode: languageCode ?? this.languageCode,
      localeKey: localeKey ?? this.localeKey,
      displayName: displayName ?? this.displayName,
      enabled: enabled ?? this.enabled,
      isDefault: isDefault ?? this.isDefault,
      fallbackLocaleKey: fallbackLocaleKey is String?
          ? fallbackLocaleKey
          : this.fallbackLocaleKey,
    );
  }
}

class LocaleConfigUpdateTable extends _i1.UpdateTable<LocaleConfigTable> {
  LocaleConfigUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> regionCode(String value) => _i1.ColumnValue(
    table.regionCode,
    value,
  );

  _i1.ColumnValue<String, String> languageCode(String value) => _i1.ColumnValue(
    table.languageCode,
    value,
  );

  _i1.ColumnValue<String, String> localeKey(String value) => _i1.ColumnValue(
    table.localeKey,
    value,
  );

  _i1.ColumnValue<String, String> displayName(String value) => _i1.ColumnValue(
    table.displayName,
    value,
  );

  _i1.ColumnValue<bool, bool> enabled(bool value) => _i1.ColumnValue(
    table.enabled,
    value,
  );

  _i1.ColumnValue<bool, bool> isDefault(bool value) => _i1.ColumnValue(
    table.isDefault,
    value,
  );

  _i1.ColumnValue<String, String> fallbackLocaleKey(String? value) =>
      _i1.ColumnValue(
        table.fallbackLocaleKey,
        value,
      );
}

class LocaleConfigTable extends _i1.Table<int?> {
  LocaleConfigTable({super.tableRelation}) : super(tableName: 'locale_config') {
    updateTable = LocaleConfigUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    regionCode = _i1.ColumnString(
      'regionCode',
      this,
    );
    languageCode = _i1.ColumnString(
      'languageCode',
      this,
    );
    localeKey = _i1.ColumnString(
      'localeKey',
      this,
    );
    displayName = _i1.ColumnString(
      'displayName',
      this,
    );
    enabled = _i1.ColumnBool(
      'enabled',
      this,
      hasDefault: true,
    );
    isDefault = _i1.ColumnBool(
      'isDefault',
      this,
      hasDefault: true,
    );
    fallbackLocaleKey = _i1.ColumnString(
      'fallbackLocaleKey',
      this,
    );
  }

  late final LocaleConfigUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString regionCode;

  late final _i1.ColumnString languageCode;

  late final _i1.ColumnString localeKey;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnBool enabled;

  late final _i1.ColumnBool isDefault;

  late final _i1.ColumnString fallbackLocaleKey;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: LocaleConfig.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    regionCode,
    languageCode,
    localeKey,
    displayName,
    enabled,
    isDefault,
    fallbackLocaleKey,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class LocaleConfigInclude extends _i1.IncludeObject {
  LocaleConfigInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => LocaleConfig.t;
}

class LocaleConfigIncludeList extends _i1.IncludeList {
  LocaleConfigIncludeList._({
    _i1.WhereExpressionBuilder<LocaleConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LocaleConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LocaleConfig.t;
}

class LocaleConfigRepository {
  const LocaleConfigRepository._();

  final attachRow = const LocaleConfigAttachRowRepository._();

  final detachRow = const LocaleConfigDetachRowRepository._();

  /// Returns a list of [LocaleConfig]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<LocaleConfig>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LocaleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocaleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocaleConfigTable>? orderByList,
    _i1.Transaction? transaction,
    LocaleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<LocaleConfig>(
      where: where?.call(LocaleConfig.t),
      orderBy: orderBy?.call(LocaleConfig.t),
      orderByList: orderByList?.call(LocaleConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [LocaleConfig] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<LocaleConfig?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LocaleConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<LocaleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LocaleConfigTable>? orderByList,
    _i1.Transaction? transaction,
    LocaleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<LocaleConfig>(
      where: where?.call(LocaleConfig.t),
      orderBy: orderBy?.call(LocaleConfig.t),
      orderByList: orderByList?.call(LocaleConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [LocaleConfig] by its [id] or null if no such row exists.
  Future<LocaleConfig?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    LocaleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<LocaleConfig>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [LocaleConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [LocaleConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<LocaleConfig>> insert(
    _i1.DatabaseSession session,
    List<LocaleConfig> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<LocaleConfig>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [LocaleConfig] and returns the inserted row.
  ///
  /// The returned [LocaleConfig] will have its `id` field set.
  Future<LocaleConfig> insertRow(
    _i1.DatabaseSession session,
    LocaleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LocaleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LocaleConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LocaleConfig>> update(
    _i1.DatabaseSession session,
    List<LocaleConfig> rows, {
    _i1.ColumnSelections<LocaleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LocaleConfig>(
      rows,
      columns: columns?.call(LocaleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocaleConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LocaleConfig> updateRow(
    _i1.DatabaseSession session,
    LocaleConfig row, {
    _i1.ColumnSelections<LocaleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LocaleConfig>(
      row,
      columns: columns?.call(LocaleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LocaleConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LocaleConfig?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<LocaleConfigUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LocaleConfig>(
      id,
      columnValues: columnValues(LocaleConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LocaleConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LocaleConfig>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LocaleConfigUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LocaleConfigTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LocaleConfigTable>? orderBy,
    _i1.OrderByListBuilder<LocaleConfigTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LocaleConfig>(
      columnValues: columnValues(LocaleConfig.t.updateTable),
      where: where(LocaleConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LocaleConfig.t),
      orderByList: orderByList?.call(LocaleConfig.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LocaleConfig]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LocaleConfig>> delete(
    _i1.DatabaseSession session,
    List<LocaleConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LocaleConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LocaleConfig].
  Future<LocaleConfig> deleteRow(
    _i1.DatabaseSession session,
    LocaleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LocaleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LocaleConfig>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LocaleConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LocaleConfig>(
      where: where(LocaleConfig.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LocaleConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LocaleConfig>(
      where: where?.call(LocaleConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [LocaleConfig] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LocaleConfigTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<LocaleConfig>(
      where: where(LocaleConfig.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LocaleConfigAttachRowRepository {
  const LocaleConfigAttachRowRepository._();

  /// Creates a relation between the given [LocaleConfig] and [Organization]
  /// by setting the [LocaleConfig]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    LocaleConfig localeConfig,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (localeConfig.id == null) {
      throw ArgumentError.notNull('localeConfig.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $localeConfig = localeConfig.copyWith(organizationId: organization.id);
    await session.db.updateRow<LocaleConfig>(
      $localeConfig,
      columns: [LocaleConfig.t.organizationId],
      transaction: transaction,
    );
  }
}

class LocaleConfigDetachRowRepository {
  const LocaleConfigDetachRowRepository._();

  /// Detaches the relation between this [LocaleConfig] and the [Organization] set in `organization`
  /// by setting the [LocaleConfig]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    LocaleConfig localeConfig, {
    _i1.Transaction? transaction,
  }) async {
    if (localeConfig.id == null) {
      throw ArgumentError.notNull('localeConfig.id');
    }

    var $localeConfig = localeConfig.copyWith(organizationId: null);
    await session.db.updateRow<LocaleConfig>(
      $localeConfig,
      columns: [LocaleConfig.t.organizationId],
      transaction: transaction,
    );
  }
}
