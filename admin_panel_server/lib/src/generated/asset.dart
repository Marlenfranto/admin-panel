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

abstract class Asset implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Asset._({
    this.id,
    this.organizationId,
    this.organization,
    required this.name,
    required this.version,
    required this.url,
    this.description,
    required this.module,
  });

  factory Asset({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String name,
    required String version,
    required String url,
    String? description,
    required String module,
  }) = _AssetImpl;

  factory Asset.fromJson(Map<String, dynamic> jsonSerialization) {
    return Asset(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      version: jsonSerialization['version'] as String,
      url: jsonSerialization['url'] as String,
      description: jsonSerialization['description'] as String?,
      module: jsonSerialization['module'] as String,
    );
  }

  static final t = AssetTable();

  static const db = AssetRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String name;

  String version;

  String url;

  String? description;

  String module;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Asset copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? name,
    String? version,
    String? url,
    String? description,
    String? module,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Asset',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'version': version,
      'url': url,
      if (description != null) 'description': description,
      'module': module,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Asset',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'version': version,
      'url': url,
      if (description != null) 'description': description,
      'module': module,
    };
  }

  static AssetInclude include({_i2.OrganizationInclude? organization}) {
    return AssetInclude._(organization: organization);
  }

  static AssetIncludeList includeList({
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    AssetInclude? include,
  }) {
    return AssetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Asset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Asset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetImpl extends Asset {
  _AssetImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String name,
    required String version,
    required String url,
    String? description,
    required String module,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         version: version,
         url: url,
         description: description,
         module: module,
       );

  /// Returns a shallow copy of this [Asset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Asset copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? name,
    String? version,
    String? url,
    Object? description = _Undefined,
    String? module,
  }) {
    return Asset(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      version: version ?? this.version,
      url: url ?? this.url,
      description: description is String? ? description : this.description,
      module: module ?? this.module,
    );
  }
}

class AssetUpdateTable extends _i1.UpdateTable<AssetTable> {
  AssetUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> version(String value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<String, String> url(String value) => _i1.ColumnValue(
    table.url,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> module(String value) => _i1.ColumnValue(
    table.module,
    value,
  );
}

class AssetTable extends _i1.Table<int?> {
  AssetTable({super.tableRelation}) : super(tableName: 'asset') {
    updateTable = AssetUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    version = _i1.ColumnString(
      'version',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    module = _i1.ColumnString(
      'module',
      this,
    );
  }

  late final AssetUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString name;

  late final _i1.ColumnString version;

  late final _i1.ColumnString url;

  late final _i1.ColumnString description;

  late final _i1.ColumnString module;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Asset.t.organizationId,
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
    name,
    version,
    url,
    description,
    module,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class AssetInclude extends _i1.IncludeObject {
  AssetInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => Asset.t;
}

class AssetIncludeList extends _i1.IncludeList {
  AssetIncludeList._({
    _i1.WhereExpressionBuilder<AssetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Asset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Asset.t;
}

class AssetRepository {
  const AssetRepository._();

  final attachRow = const AssetAttachRowRepository._();

  final detachRow = const AssetDetachRowRepository._();

  /// Returns a list of [Asset]s matching the given query parameters.
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
  Future<List<Asset>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Asset>(
      where: where?.call(Asset.t),
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Asset] matching the given query parameters.
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
  Future<Asset?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Asset>(
      where: where?.call(Asset.t),
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Asset] by its [id] or null if no such row exists.
  Future<Asset?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Asset>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Asset]s in the list and returns the inserted rows.
  ///
  /// The returned [Asset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Asset>> insert(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Asset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Asset] and returns the inserted row.
  ///
  /// The returned [Asset] will have its `id` field set.
  Future<Asset> insertRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Asset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Asset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Asset>> update(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.ColumnSelections<AssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Asset>(
      rows,
      columns: columns?.call(Asset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Asset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Asset> updateRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.ColumnSelections<AssetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Asset>(
      row,
      columns: columns?.call(Asset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Asset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Asset?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Asset>(
      id,
      columnValues: columnValues(Asset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Asset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Asset>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AssetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetTable>? orderBy,
    _i1.OrderByListBuilder<AssetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Asset>(
      columnValues: columnValues(Asset.t.updateTable),
      where: where(Asset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Asset.t),
      orderByList: orderByList?.call(Asset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Asset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Asset>> delete(
    _i1.DatabaseSession session,
    List<Asset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Asset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Asset].
  Future<Asset> deleteRow(
    _i1.DatabaseSession session,
    Asset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Asset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Asset>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Asset>(
      where: where(Asset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Asset>(
      where: where?.call(Asset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Asset] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Asset>(
      where: where(Asset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssetAttachRowRepository {
  const AssetAttachRowRepository._();

  /// Creates a relation between the given [Asset] and [Organization]
  /// by setting the [Asset]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Asset asset,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $asset = asset.copyWith(organizationId: organization.id);
    await session.db.updateRow<Asset>(
      $asset,
      columns: [Asset.t.organizationId],
      transaction: transaction,
    );
  }
}

class AssetDetachRowRepository {
  const AssetDetachRowRepository._();

  /// Detaches the relation between this [Asset] and the [Organization] set in `organization`
  /// by setting the [Asset]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    Asset asset, {
    _i1.Transaction? transaction,
  }) async {
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $asset = asset.copyWith(organizationId: null);
    await session.db.updateRow<Asset>(
      $asset,
      columns: [Asset.t.organizationId],
      transaction: transaction,
    );
  }
}
