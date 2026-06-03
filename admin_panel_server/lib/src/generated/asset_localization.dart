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
import 'asset.dart' as _i2;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i3;

abstract class AssetLocalization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssetLocalization._({
    this.id,
    required this.assetId,
    this.asset,
    required this.localeKey,
    required this.name,
    this.description,
    required this.url,
  });

  factory AssetLocalization({
    int? id,
    required int assetId,
    _i2.Asset? asset,
    required String localeKey,
    required String name,
    String? description,
    required String url,
  }) = _AssetLocalizationImpl;

  factory AssetLocalization.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssetLocalization(
      id: jsonSerialization['id'] as int?,
      assetId: jsonSerialization['assetId'] as int,
      asset: jsonSerialization['asset'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Asset>(jsonSerialization['asset']),
      localeKey: jsonSerialization['localeKey'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      url: jsonSerialization['url'] as String,
    );
  }

  static final t = AssetLocalizationTable();

  static const db = AssetLocalizationRepository._();

  @override
  int? id;

  int assetId;

  _i2.Asset? asset;

  String localeKey;

  String name;

  String? description;

  String url;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssetLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssetLocalization copyWith({
    int? id,
    int? assetId,
    _i2.Asset? asset,
    String? localeKey,
    String? name,
    String? description,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssetLocalization',
      if (id != null) 'id': id,
      'assetId': assetId,
      if (asset != null) 'asset': asset?.toJson(),
      'localeKey': localeKey,
      'name': name,
      if (description != null) 'description': description,
      'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssetLocalization',
      if (id != null) 'id': id,
      'assetId': assetId,
      if (asset != null) 'asset': asset?.toJsonForProtocol(),
      'localeKey': localeKey,
      'name': name,
      if (description != null) 'description': description,
      'url': url,
    };
  }

  static AssetLocalizationInclude include({_i2.AssetInclude? asset}) {
    return AssetLocalizationInclude._(asset: asset);
  }

  static AssetLocalizationIncludeList includeList({
    _i1.WhereExpressionBuilder<AssetLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLocalizationTable>? orderByList,
    AssetLocalizationInclude? include,
  }) {
    return AssetLocalizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssetLocalization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssetLocalization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssetLocalizationImpl extends AssetLocalization {
  _AssetLocalizationImpl({
    int? id,
    required int assetId,
    _i2.Asset? asset,
    required String localeKey,
    required String name,
    String? description,
    required String url,
  }) : super._(
         id: id,
         assetId: assetId,
         asset: asset,
         localeKey: localeKey,
         name: name,
         description: description,
         url: url,
       );

  /// Returns a shallow copy of this [AssetLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssetLocalization copyWith({
    Object? id = _Undefined,
    int? assetId,
    Object? asset = _Undefined,
    String? localeKey,
    String? name,
    Object? description = _Undefined,
    String? url,
  }) {
    return AssetLocalization(
      id: id is int? ? id : this.id,
      assetId: assetId ?? this.assetId,
      asset: asset is _i2.Asset? ? asset : this.asset?.copyWith(),
      localeKey: localeKey ?? this.localeKey,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      url: url ?? this.url,
    );
  }
}

class AssetLocalizationUpdateTable
    extends _i1.UpdateTable<AssetLocalizationTable> {
  AssetLocalizationUpdateTable(super.table);

  _i1.ColumnValue<int, int> assetId(int value) => _i1.ColumnValue(
    table.assetId,
    value,
  );

  _i1.ColumnValue<String, String> localeKey(String value) => _i1.ColumnValue(
    table.localeKey,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> url(String value) => _i1.ColumnValue(
    table.url,
    value,
  );
}

class AssetLocalizationTable extends _i1.Table<int?> {
  AssetLocalizationTable({super.tableRelation})
    : super(tableName: 'asset_localization') {
    updateTable = AssetLocalizationUpdateTable(this);
    assetId = _i1.ColumnInt(
      'assetId',
      this,
    );
    localeKey = _i1.ColumnString(
      'localeKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
  }

  late final AssetLocalizationUpdateTable updateTable;

  late final _i1.ColumnInt assetId;

  _i2.AssetTable? _asset;

  late final _i1.ColumnString localeKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString url;

  _i2.AssetTable get asset {
    if (_asset != null) return _asset!;
    _asset = _i1.createRelationTable(
      relationFieldName: 'asset',
      field: AssetLocalization.t.assetId,
      foreignField: _i2.Asset.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AssetTable(tableRelation: foreignTableRelation),
    );
    return _asset!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    assetId,
    localeKey,
    name,
    description,
    url,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'asset') {
      return asset;
    }
    return null;
  }
}

class AssetLocalizationInclude extends _i1.IncludeObject {
  AssetLocalizationInclude._({_i2.AssetInclude? asset}) {
    _asset = asset;
  }

  _i2.AssetInclude? _asset;

  @override
  Map<String, _i1.Include?> get includes => {'asset': _asset};

  @override
  _i1.Table<int?> get table => AssetLocalization.t;
}

class AssetLocalizationIncludeList extends _i1.IncludeList {
  AssetLocalizationIncludeList._({
    _i1.WhereExpressionBuilder<AssetLocalizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssetLocalization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssetLocalization.t;
}

class AssetLocalizationRepository {
  const AssetLocalizationRepository._();

  final attachRow = const AssetLocalizationAttachRowRepository._();

  /// Returns a list of [AssetLocalization]s matching the given query parameters.
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
  Future<List<AssetLocalization>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    AssetLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssetLocalization>(
      where: where?.call(AssetLocalization.t),
      orderBy: orderBy?.call(AssetLocalization.t),
      orderByList: orderByList?.call(AssetLocalization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssetLocalization] matching the given query parameters.
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
  Future<AssetLocalization?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLocalizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssetLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssetLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    AssetLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssetLocalization>(
      where: where?.call(AssetLocalization.t),
      orderBy: orderBy?.call(AssetLocalization.t),
      orderByList: orderByList?.call(AssetLocalization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssetLocalization] by its [id] or null if no such row exists.
  Future<AssetLocalization?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssetLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssetLocalization>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssetLocalization]s in the list and returns the inserted rows.
  ///
  /// The returned [AssetLocalization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssetLocalization>> insert(
    _i1.DatabaseSession session,
    List<AssetLocalization> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssetLocalization>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssetLocalization] and returns the inserted row.
  ///
  /// The returned [AssetLocalization] will have its `id` field set.
  Future<AssetLocalization> insertRow(
    _i1.DatabaseSession session,
    AssetLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssetLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssetLocalization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssetLocalization>> update(
    _i1.DatabaseSession session,
    List<AssetLocalization> rows, {
    _i1.ColumnSelections<AssetLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssetLocalization>(
      rows,
      columns: columns?.call(AssetLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssetLocalization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssetLocalization> updateRow(
    _i1.DatabaseSession session,
    AssetLocalization row, {
    _i1.ColumnSelections<AssetLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssetLocalization>(
      row,
      columns: columns?.call(AssetLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssetLocalization] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssetLocalization?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssetLocalizationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssetLocalization>(
      id,
      columnValues: columnValues(AssetLocalization.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssetLocalization]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssetLocalization>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssetLocalizationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AssetLocalizationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssetLocalizationTable>? orderBy,
    _i1.OrderByListBuilder<AssetLocalizationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssetLocalization>(
      columnValues: columnValues(AssetLocalization.t.updateTable),
      where: where(AssetLocalization.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssetLocalization.t),
      orderByList: orderByList?.call(AssetLocalization.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssetLocalization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssetLocalization>> delete(
    _i1.DatabaseSession session,
    List<AssetLocalization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssetLocalization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssetLocalization].
  Future<AssetLocalization> deleteRow(
    _i1.DatabaseSession session,
    AssetLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssetLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssetLocalization>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetLocalizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssetLocalization>(
      where: where(AssetLocalization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssetLocalizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssetLocalization>(
      where: where?.call(AssetLocalization.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssetLocalization] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssetLocalizationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssetLocalization>(
      where: where(AssetLocalization.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssetLocalizationAttachRowRepository {
  const AssetLocalizationAttachRowRepository._();

  /// Creates a relation between the given [AssetLocalization] and [Asset]
  /// by setting the [AssetLocalization]'s foreign key `assetId` to refer to the [Asset].
  Future<void> asset(
    _i1.DatabaseSession session,
    AssetLocalization assetLocalization,
    _i2.Asset asset, {
    _i1.Transaction? transaction,
  }) async {
    if (assetLocalization.id == null) {
      throw ArgumentError.notNull('assetLocalization.id');
    }
    if (asset.id == null) {
      throw ArgumentError.notNull('asset.id');
    }

    var $assetLocalization = assetLocalization.copyWith(assetId: asset.id);
    await session.db.updateRow<AssetLocalization>(
      $assetLocalization,
      columns: [AssetLocalization.t.assetId],
      transaction: transaction,
    );
  }
}
