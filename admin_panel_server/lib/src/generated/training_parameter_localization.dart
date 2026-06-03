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
import 'training_parameter.dart' as _i2;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i3;

abstract class TrainingParameterLocalization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingParameterLocalization._({
    this.id,
    required this.parameterId,
    this.parameter,
    required this.localeKey,
    required this.name,
    required this.description,
    this.scoringFeedbacks,
  });

  factory TrainingParameterLocalization({
    int? id,
    required int parameterId,
    _i2.TrainingParameter? parameter,
    required String localeKey,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) = _TrainingParameterLocalizationImpl;

  factory TrainingParameterLocalization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingParameterLocalization(
      id: jsonSerialization['id'] as int?,
      parameterId: jsonSerialization['parameterId'] as int,
      parameter: jsonSerialization['parameter'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.TrainingParameter>(
              jsonSerialization['parameter'],
            ),
      localeKey: jsonSerialization['localeKey'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      scoringFeedbacks: jsonSerialization['scoringFeedbacks'] == null
          ? null
          : _i3.Protocol().deserialize<List<String>>(
              jsonSerialization['scoringFeedbacks'],
            ),
    );
  }

  static final t = TrainingParameterLocalizationTable();

  static const db = TrainingParameterLocalizationRepository._();

  @override
  int? id;

  int parameterId;

  _i2.TrainingParameter? parameter;

  String localeKey;

  String name;

  String description;

  List<String>? scoringFeedbacks;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingParameterLocalization copyWith({
    int? id,
    int? parameterId,
    _i2.TrainingParameter? parameter,
    String? localeKey,
    String? name,
    String? description,
    List<String>? scoringFeedbacks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingParameterLocalization',
      if (id != null) 'id': id,
      'parameterId': parameterId,
      if (parameter != null) 'parameter': parameter?.toJson(),
      'localeKey': localeKey,
      'name': name,
      'description': description,
      if (scoringFeedbacks != null)
        'scoringFeedbacks': scoringFeedbacks?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingParameterLocalization',
      if (id != null) 'id': id,
      'parameterId': parameterId,
      if (parameter != null) 'parameter': parameter?.toJsonForProtocol(),
      'localeKey': localeKey,
      'name': name,
      'description': description,
      if (scoringFeedbacks != null)
        'scoringFeedbacks': scoringFeedbacks?.toJson(),
    };
  }

  static TrainingParameterLocalizationInclude include({
    _i2.TrainingParameterInclude? parameter,
  }) {
    return TrainingParameterLocalizationInclude._(parameter: parameter);
  }

  static TrainingParameterLocalizationIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterLocalizationTable>? orderByList,
    TrainingParameterLocalizationInclude? include,
  }) {
    return TrainingParameterLocalizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingParameterLocalization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingParameterLocalization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingParameterLocalizationImpl extends TrainingParameterLocalization {
  _TrainingParameterLocalizationImpl({
    int? id,
    required int parameterId,
    _i2.TrainingParameter? parameter,
    required String localeKey,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) : super._(
         id: id,
         parameterId: parameterId,
         parameter: parameter,
         localeKey: localeKey,
         name: name,
         description: description,
         scoringFeedbacks: scoringFeedbacks,
       );

  /// Returns a shallow copy of this [TrainingParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingParameterLocalization copyWith({
    Object? id = _Undefined,
    int? parameterId,
    Object? parameter = _Undefined,
    String? localeKey,
    String? name,
    String? description,
    Object? scoringFeedbacks = _Undefined,
  }) {
    return TrainingParameterLocalization(
      id: id is int? ? id : this.id,
      parameterId: parameterId ?? this.parameterId,
      parameter: parameter is _i2.TrainingParameter?
          ? parameter
          : this.parameter?.copyWith(),
      localeKey: localeKey ?? this.localeKey,
      name: name ?? this.name,
      description: description ?? this.description,
      scoringFeedbacks: scoringFeedbacks is List<String>?
          ? scoringFeedbacks
          : this.scoringFeedbacks?.map((e0) => e0).toList(),
    );
  }
}

class TrainingParameterLocalizationUpdateTable
    extends _i1.UpdateTable<TrainingParameterLocalizationTable> {
  TrainingParameterLocalizationUpdateTable(super.table);

  _i1.ColumnValue<int, int> parameterId(int value) => _i1.ColumnValue(
    table.parameterId,
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

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<List<String>, List<String>> scoringFeedbacks(
    List<String>? value,
  ) => _i1.ColumnValue(
    table.scoringFeedbacks,
    value,
  );
}

class TrainingParameterLocalizationTable extends _i1.Table<int?> {
  TrainingParameterLocalizationTable({super.tableRelation})
    : super(tableName: 'training_parameter_localization') {
    updateTable = TrainingParameterLocalizationUpdateTable(this);
    parameterId = _i1.ColumnInt(
      'parameterId',
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
    scoringFeedbacks = _i1.ColumnSerializable<List<String>>(
      'scoringFeedbacks',
      this,
    );
  }

  late final TrainingParameterLocalizationUpdateTable updateTable;

  late final _i1.ColumnInt parameterId;

  _i2.TrainingParameterTable? _parameter;

  late final _i1.ColumnString localeKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable<List<String>> scoringFeedbacks;

  _i2.TrainingParameterTable get parameter {
    if (_parameter != null) return _parameter!;
    _parameter = _i1.createRelationTable(
      relationFieldName: 'parameter',
      field: TrainingParameterLocalization.t.parameterId,
      foreignField: _i2.TrainingParameter.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TrainingParameterTable(tableRelation: foreignTableRelation),
    );
    return _parameter!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    parameterId,
    localeKey,
    name,
    description,
    scoringFeedbacks,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'parameter') {
      return parameter;
    }
    return null;
  }
}

class TrainingParameterLocalizationInclude extends _i1.IncludeObject {
  TrainingParameterLocalizationInclude._({
    _i2.TrainingParameterInclude? parameter,
  }) {
    _parameter = parameter;
  }

  _i2.TrainingParameterInclude? _parameter;

  @override
  Map<String, _i1.Include?> get includes => {'parameter': _parameter};

  @override
  _i1.Table<int?> get table => TrainingParameterLocalization.t;
}

class TrainingParameterLocalizationIncludeList extends _i1.IncludeList {
  TrainingParameterLocalizationIncludeList._({
    _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingParameterLocalization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingParameterLocalization.t;
}

class TrainingParameterLocalizationRepository {
  const TrainingParameterLocalizationRepository._();

  final attachRow = const TrainingParameterLocalizationAttachRowRepository._();

  /// Returns a list of [TrainingParameterLocalization]s matching the given query parameters.
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
  Future<List<TrainingParameterLocalization>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingParameterLocalization>(
      where: where?.call(TrainingParameterLocalization.t),
      orderBy: orderBy?.call(TrainingParameterLocalization.t),
      orderByList: orderByList?.call(TrainingParameterLocalization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingParameterLocalization] matching the given query parameters.
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
  Future<TrainingParameterLocalization?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingParameterLocalization>(
      where: where?.call(TrainingParameterLocalization.t),
      orderBy: orderBy?.call(TrainingParameterLocalization.t),
      orderByList: orderByList?.call(TrainingParameterLocalization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingParameterLocalization] by its [id] or null if no such row exists.
  Future<TrainingParameterLocalization?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingParameterLocalization>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingParameterLocalization]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingParameterLocalization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingParameterLocalization>> insert(
    _i1.DatabaseSession session,
    List<TrainingParameterLocalization> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingParameterLocalization>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingParameterLocalization] and returns the inserted row.
  ///
  /// The returned [TrainingParameterLocalization] will have its `id` field set.
  Future<TrainingParameterLocalization> insertRow(
    _i1.DatabaseSession session,
    TrainingParameterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingParameterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingParameterLocalization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingParameterLocalization>> update(
    _i1.DatabaseSession session,
    List<TrainingParameterLocalization> rows, {
    _i1.ColumnSelections<TrainingParameterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingParameterLocalization>(
      rows,
      columns: columns?.call(TrainingParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingParameterLocalization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingParameterLocalization> updateRow(
    _i1.DatabaseSession session,
    TrainingParameterLocalization row, {
    _i1.ColumnSelections<TrainingParameterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingParameterLocalization>(
      row,
      columns: columns?.call(TrainingParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingParameterLocalization] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingParameterLocalization?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<
      TrainingParameterLocalizationUpdateTable
    >
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingParameterLocalization>(
      id,
      columnValues: columnValues(TrainingParameterLocalization.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingParameterLocalization]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingParameterLocalization>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<
      TrainingParameterLocalizationUpdateTable
    >
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>
    where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterLocalizationTable>? orderBy,
    _i1.OrderByListBuilder<TrainingParameterLocalizationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingParameterLocalization>(
      columnValues: columnValues(TrainingParameterLocalization.t.updateTable),
      where: where(TrainingParameterLocalization.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingParameterLocalization.t),
      orderByList: orderByList?.call(TrainingParameterLocalization.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingParameterLocalization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingParameterLocalization>> delete(
    _i1.DatabaseSession session,
    List<TrainingParameterLocalization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingParameterLocalization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingParameterLocalization].
  Future<TrainingParameterLocalization> deleteRow(
    _i1.DatabaseSession session,
    TrainingParameterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingParameterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingParameterLocalization>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>
    where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingParameterLocalization>(
      where: where(TrainingParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingParameterLocalization>(
      where: where?.call(TrainingParameterLocalization.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingParameterLocalization] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingParameterLocalizationTable>
    where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingParameterLocalization>(
      where: where(TrainingParameterLocalization.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingParameterLocalizationAttachRowRepository {
  const TrainingParameterLocalizationAttachRowRepository._();

  /// Creates a relation between the given [TrainingParameterLocalization] and [TrainingParameter]
  /// by setting the [TrainingParameterLocalization]'s foreign key `parameterId` to refer to the [TrainingParameter].
  Future<void> parameter(
    _i1.DatabaseSession session,
    TrainingParameterLocalization trainingParameterLocalization,
    _i2.TrainingParameter parameter, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingParameterLocalization.id == null) {
      throw ArgumentError.notNull('trainingParameterLocalization.id');
    }
    if (parameter.id == null) {
      throw ArgumentError.notNull('parameter.id');
    }

    var $trainingParameterLocalization = trainingParameterLocalization.copyWith(
      parameterId: parameter.id,
    );
    await session.db.updateRow<TrainingParameterLocalization>(
      $trainingParameterLocalization,
      columns: [TrainingParameterLocalization.t.parameterId],
      transaction: transaction,
    );
  }
}
