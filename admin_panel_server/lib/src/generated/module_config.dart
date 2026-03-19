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
import 'supported_language.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class ModuleConfig
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ModuleConfig._({
    this.id,
    this.organizationId,
    this.organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    this.supportedLanguages,
    this.aiChatPrompt,
    int? passingPercentage,
  }) : theoryModule = theoryModule ?? false,
       aiExpertModule = aiExpertModule ?? false,
       smartTrainingModule = smartTrainingModule ?? false,
       assessmentModule = assessmentModule ?? false,
       defaultLanguage = defaultLanguage ?? 'en',
       passingPercentage = passingPercentage ?? 60;

  factory ModuleConfig({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  }) = _ModuleConfigImpl;

  factory ModuleConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModuleConfig(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      theoryModule: jsonSerialization['theoryModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['theoryModule']),
      aiExpertModule: jsonSerialization['aiExpertModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['aiExpertModule']),
      smartTrainingModule: jsonSerialization['smartTrainingModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['smartTrainingModule'],
            ),
      assessmentModule: jsonSerialization['assessmentModule'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['assessmentModule'],
            ),
      defaultLanguage: jsonSerialization['defaultLanguage'] as String?,
      supportedLanguages: jsonSerialization['supportedLanguages'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.SupportedLanguage>>(
              jsonSerialization['supportedLanguages'],
            ),
      aiChatPrompt: jsonSerialization['aiChatPrompt'] as String?,
      passingPercentage: jsonSerialization['passingPercentage'] as int?,
    );
  }

  static final t = ModuleConfigTable();

  static const db = ModuleConfigRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  bool theoryModule;

  bool aiExpertModule;

  bool smartTrainingModule;

  bool assessmentModule;

  String defaultLanguage;

  List<_i3.SupportedLanguage>? supportedLanguages;

  String? aiChatPrompt;

  int passingPercentage;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ModuleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModuleConfig copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModuleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'defaultLanguage': defaultLanguage,
      if (supportedLanguages != null)
        'supportedLanguages': supportedLanguages?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
      'passingPercentage': passingPercentage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ModuleConfig',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
      'defaultLanguage': defaultLanguage,
      if (supportedLanguages != null)
        'supportedLanguages': supportedLanguages?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
      'passingPercentage': passingPercentage,
    };
  }

  static ModuleConfigInclude include({_i2.OrganizationInclude? organization}) {
    return ModuleConfigInclude._(organization: organization);
  }

  static ModuleConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<ModuleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleConfigTable>? orderByList,
    ModuleConfigInclude? include,
  }) {
    return ModuleConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModuleConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ModuleConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModuleConfigImpl extends ModuleConfig {
  _ModuleConfigImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    List<_i3.SupportedLanguage>? supportedLanguages,
    String? aiChatPrompt,
    int? passingPercentage,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         theoryModule: theoryModule,
         aiExpertModule: aiExpertModule,
         smartTrainingModule: smartTrainingModule,
         assessmentModule: assessmentModule,
         defaultLanguage: defaultLanguage,
         supportedLanguages: supportedLanguages,
         aiChatPrompt: aiChatPrompt,
         passingPercentage: passingPercentage,
       );

  /// Returns a shallow copy of this [ModuleConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModuleConfig copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
    String? defaultLanguage,
    Object? supportedLanguages = _Undefined,
    Object? aiChatPrompt = _Undefined,
    int? passingPercentage,
  }) {
    return ModuleConfig(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      theoryModule: theoryModule ?? this.theoryModule,
      aiExpertModule: aiExpertModule ?? this.aiExpertModule,
      smartTrainingModule: smartTrainingModule ?? this.smartTrainingModule,
      assessmentModule: assessmentModule ?? this.assessmentModule,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      supportedLanguages: supportedLanguages is List<_i3.SupportedLanguage>?
          ? supportedLanguages
          : this.supportedLanguages?.map((e0) => e0.copyWith()).toList(),
      aiChatPrompt: aiChatPrompt is String? ? aiChatPrompt : this.aiChatPrompt,
      passingPercentage: passingPercentage ?? this.passingPercentage,
    );
  }
}

class ModuleConfigUpdateTable extends _i1.UpdateTable<ModuleConfigTable> {
  ModuleConfigUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<bool, bool> theoryModule(bool value) => _i1.ColumnValue(
    table.theoryModule,
    value,
  );

  _i1.ColumnValue<bool, bool> aiExpertModule(bool value) => _i1.ColumnValue(
    table.aiExpertModule,
    value,
  );

  _i1.ColumnValue<bool, bool> smartTrainingModule(bool value) =>
      _i1.ColumnValue(
        table.smartTrainingModule,
        value,
      );

  _i1.ColumnValue<bool, bool> assessmentModule(bool value) => _i1.ColumnValue(
    table.assessmentModule,
    value,
  );

  _i1.ColumnValue<String, String> defaultLanguage(String value) =>
      _i1.ColumnValue(
        table.defaultLanguage,
        value,
      );

  _i1.ColumnValue<List<_i3.SupportedLanguage>, List<_i3.SupportedLanguage>>
  supportedLanguages(List<_i3.SupportedLanguage>? value) => _i1.ColumnValue(
    table.supportedLanguages,
    value,
  );

  _i1.ColumnValue<String, String> aiChatPrompt(String? value) =>
      _i1.ColumnValue(
        table.aiChatPrompt,
        value,
      );

  _i1.ColumnValue<int, int> passingPercentage(int value) => _i1.ColumnValue(
    table.passingPercentage,
    value,
  );
}

class ModuleConfigTable extends _i1.Table<int?> {
  ModuleConfigTable({super.tableRelation}) : super(tableName: 'module_config') {
    updateTable = ModuleConfigUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    theoryModule = _i1.ColumnBool(
      'theoryModule',
      this,
      hasDefault: true,
    );
    aiExpertModule = _i1.ColumnBool(
      'aiExpertModule',
      this,
      hasDefault: true,
    );
    smartTrainingModule = _i1.ColumnBool(
      'smartTrainingModule',
      this,
      hasDefault: true,
    );
    assessmentModule = _i1.ColumnBool(
      'assessmentModule',
      this,
      hasDefault: true,
    );
    defaultLanguage = _i1.ColumnString(
      'defaultLanguage',
      this,
      hasDefault: true,
    );
    supportedLanguages = _i1.ColumnSerializable<List<_i3.SupportedLanguage>>(
      'supportedLanguages',
      this,
    );
    aiChatPrompt = _i1.ColumnString(
      'aiChatPrompt',
      this,
    );
    passingPercentage = _i1.ColumnInt(
      'passingPercentage',
      this,
      hasDefault: true,
    );
  }

  late final ModuleConfigUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnBool theoryModule;

  late final _i1.ColumnBool aiExpertModule;

  late final _i1.ColumnBool smartTrainingModule;

  late final _i1.ColumnBool assessmentModule;

  late final _i1.ColumnString defaultLanguage;

  late final _i1.ColumnSerializable<List<_i3.SupportedLanguage>>
  supportedLanguages;

  late final _i1.ColumnString aiChatPrompt;

  late final _i1.ColumnInt passingPercentage;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: ModuleConfig.t.organizationId,
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
    theoryModule,
    aiExpertModule,
    smartTrainingModule,
    assessmentModule,
    defaultLanguage,
    supportedLanguages,
    aiChatPrompt,
    passingPercentage,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class ModuleConfigInclude extends _i1.IncludeObject {
  ModuleConfigInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => ModuleConfig.t;
}

class ModuleConfigIncludeList extends _i1.IncludeList {
  ModuleConfigIncludeList._({
    _i1.WhereExpressionBuilder<ModuleConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ModuleConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ModuleConfig.t;
}

class ModuleConfigRepository {
  const ModuleConfigRepository._();

  final attachRow = const ModuleConfigAttachRowRepository._();

  final detachRow = const ModuleConfigDetachRowRepository._();

  /// Returns a list of [ModuleConfig]s matching the given query parameters.
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
  Future<List<ModuleConfig>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModuleConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleConfigTable>? orderByList,
    _i1.Transaction? transaction,
    ModuleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ModuleConfig>(
      where: where?.call(ModuleConfig.t),
      orderBy: orderBy?.call(ModuleConfig.t),
      orderByList: orderByList?.call(ModuleConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ModuleConfig] matching the given query parameters.
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
  Future<ModuleConfig?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModuleConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<ModuleConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ModuleConfigTable>? orderByList,
    _i1.Transaction? transaction,
    ModuleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ModuleConfig>(
      where: where?.call(ModuleConfig.t),
      orderBy: orderBy?.call(ModuleConfig.t),
      orderByList: orderByList?.call(ModuleConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ModuleConfig] by its [id] or null if no such row exists.
  Future<ModuleConfig?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    ModuleConfigInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ModuleConfig>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ModuleConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [ModuleConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ModuleConfig>> insert(
    _i1.DatabaseSession session,
    List<ModuleConfig> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ModuleConfig>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ModuleConfig] and returns the inserted row.
  ///
  /// The returned [ModuleConfig] will have its `id` field set.
  Future<ModuleConfig> insertRow(
    _i1.DatabaseSession session,
    ModuleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ModuleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ModuleConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ModuleConfig>> update(
    _i1.DatabaseSession session,
    List<ModuleConfig> rows, {
    _i1.ColumnSelections<ModuleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ModuleConfig>(
      rows,
      columns: columns?.call(ModuleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModuleConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ModuleConfig> updateRow(
    _i1.DatabaseSession session,
    ModuleConfig row, {
    _i1.ColumnSelections<ModuleConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ModuleConfig>(
      row,
      columns: columns?.call(ModuleConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ModuleConfig] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ModuleConfig?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ModuleConfigUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ModuleConfig>(
      id,
      columnValues: columnValues(ModuleConfig.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ModuleConfig]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ModuleConfig>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ModuleConfigUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ModuleConfigTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ModuleConfigTable>? orderBy,
    _i1.OrderByListBuilder<ModuleConfigTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ModuleConfig>(
      columnValues: columnValues(ModuleConfig.t.updateTable),
      where: where(ModuleConfig.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ModuleConfig.t),
      orderByList: orderByList?.call(ModuleConfig.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ModuleConfig]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ModuleConfig>> delete(
    _i1.DatabaseSession session,
    List<ModuleConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ModuleConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ModuleConfig].
  Future<ModuleConfig> deleteRow(
    _i1.DatabaseSession session,
    ModuleConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ModuleConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ModuleConfig>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModuleConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ModuleConfig>(
      where: where(ModuleConfig.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ModuleConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ModuleConfig>(
      where: where?.call(ModuleConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ModuleConfig] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ModuleConfigTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ModuleConfig>(
      where: where(ModuleConfig.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ModuleConfigAttachRowRepository {
  const ModuleConfigAttachRowRepository._();

  /// Creates a relation between the given [ModuleConfig] and [Organization]
  /// by setting the [ModuleConfig]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    ModuleConfig moduleConfig,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (moduleConfig.id == null) {
      throw ArgumentError.notNull('moduleConfig.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $moduleConfig = moduleConfig.copyWith(organizationId: organization.id);
    await session.db.updateRow<ModuleConfig>(
      $moduleConfig,
      columns: [ModuleConfig.t.organizationId],
      transaction: transaction,
    );
  }
}

class ModuleConfigDetachRowRepository {
  const ModuleConfigDetachRowRepository._();

  /// Detaches the relation between this [ModuleConfig] and the [Organization] set in `organization`
  /// by setting the [ModuleConfig]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    ModuleConfig moduleConfig, {
    _i1.Transaction? transaction,
  }) async {
    if (moduleConfig.id == null) {
      throw ArgumentError.notNull('moduleConfig.id');
    }

    var $moduleConfig = moduleConfig.copyWith(organizationId: null);
    await session.db.updateRow<ModuleConfig>(
      $moduleConfig,
      columns: [ModuleConfig.t.organizationId],
      transaction: transaction,
    );
  }
}
