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

abstract class Region implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Region._({
    this.id,
    this.organizationId,
    this.organization,
    required this.code,
    required this.displayName,
    bool? enabled,
  }) : enabled = enabled ?? true;

  factory Region({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String code,
    required String displayName,
    bool? enabled,
  }) = _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      code: jsonSerialization['code'] as String,
      displayName: jsonSerialization['displayName'] as String,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
    );
  }

  static final t = RegionTable();

  static const db = RegionRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String code;

  String displayName;

  bool enabled;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Region copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? code,
    String? displayName,
    bool? enabled,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Region',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'code': code,
      'displayName': displayName,
      'enabled': enabled,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Region',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'code': code,
      'displayName': displayName,
      'enabled': enabled,
    };
  }

  static RegionInclude include({_i2.OrganizationInclude? organization}) {
    return RegionInclude._(organization: organization);
  }

  static RegionIncludeList includeList({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    RegionInclude? include,
  }) {
    return RegionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Region.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String code,
    required String displayName,
    bool? enabled,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         code: code,
         displayName: displayName,
         enabled: enabled,
       );

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Region copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? code,
    String? displayName,
    bool? enabled,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      code: code ?? this.code,
      displayName: displayName ?? this.displayName,
      enabled: enabled ?? this.enabled,
    );
  }
}

class RegionUpdateTable extends _i1.UpdateTable<RegionTable> {
  RegionUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
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
}

class RegionTable extends _i1.Table<int?> {
  RegionTable({super.tableRelation}) : super(tableName: 'region') {
    updateTable = RegionUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    code = _i1.ColumnString(
      'code',
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
  }

  late final RegionUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString code;

  late final _i1.ColumnString displayName;

  late final _i1.ColumnBool enabled;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Region.t.organizationId,
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
    code,
    displayName,
    enabled,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class RegionInclude extends _i1.IncludeObject {
  RegionInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Region.t;
}

class RegionIncludeList extends _i1.IncludeList {
  RegionIncludeList._({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Region.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Region.t;
}

class RegionRepository {
  const RegionRepository._();

  final attachRow = const RegionAttachRowRepository._();

  final detachRow = const RegionDetachRowRepository._();

  /// Returns a list of [Region]s matching the given query parameters.
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
  Future<List<Region>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
    RegionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Region] matching the given query parameters.
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
  Future<Region?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
    RegionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Region] by its [id] or null if no such row exists.
  Future<Region?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    RegionInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Region>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Region]s in the list and returns the inserted rows.
  ///
  /// The returned [Region]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Region>> insert(
    _i1.DatabaseSession session,
    List<Region> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Region>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Region] and returns the inserted row.
  ///
  /// The returned [Region] will have its `id` field set.
  Future<Region> insertRow(
    _i1.DatabaseSession session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Region>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Region]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Region>> update(
    _i1.DatabaseSession session,
    List<Region> rows, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Region>(
      rows,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Region]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Region> updateRow(
    _i1.DatabaseSession session,
    Region row, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Region>(
      row,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Region] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Region?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RegionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Region>(
      id,
      columnValues: columnValues(Region.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Region]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Region>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RegionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RegionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Region>(
      columnValues: columnValues(Region.t.updateTable),
      where: where(Region.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Region]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Region>> delete(
    _i1.DatabaseSession session,
    List<Region> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Region>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Region].
  Future<Region> deleteRow(
    _i1.DatabaseSession session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Region>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Region>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RegionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Region>(
      where: where(Region.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Region>(
      where: where?.call(Region.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Region] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RegionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Region>(
      where: where(Region.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class RegionAttachRowRepository {
  const RegionAttachRowRepository._();

  /// Creates a relation between the given [Region] and [Organization]
  /// by setting the [Region]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Region region,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (region.id == null) {
      throw ArgumentError.notNull('region.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $region = region.copyWith(organizationId: organization.id);
    await session.db.updateRow<Region>(
      $region,
      columns: [Region.t.organizationId],
      transaction: transaction,
    );
  }
}

class RegionDetachRowRepository {
  const RegionDetachRowRepository._();

  /// Detaches the relation between this [Region] and the [Organization] set in `organization`
  /// by setting the [Region]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    Region region, {
    _i1.Transaction? transaction,
  }) async {
    if (region.id == null) {
      throw ArgumentError.notNull('region.id');
    }

    var $region = region.copyWith(organizationId: null);
    await session.db.updateRow<Region>(
      $region,
      columns: [Region.t.organizationId],
      transaction: transaction,
    );
  }
}
