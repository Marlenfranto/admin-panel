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
import 'assessment_parameter.dart' as _i2;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i3;

abstract class AssessmentParameterLocalization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssessmentParameterLocalization._({
    this.id,
    required this.parameterId,
    this.parameter,
    required this.localeKey,
    required this.name,
    required this.description,
    this.scoringFeedbacks,
  });

  factory AssessmentParameterLocalization({
    int? id,
    required int parameterId,
    _i2.AssessmentParameter? parameter,
    required String localeKey,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) = _AssessmentParameterLocalizationImpl;

  factory AssessmentParameterLocalization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AssessmentParameterLocalization(
      id: jsonSerialization['id'] as int?,
      parameterId: jsonSerialization['parameterId'] as int,
      parameter: jsonSerialization['parameter'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AssessmentParameter>(
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

  static final t = AssessmentParameterLocalizationTable();

  static const db = AssessmentParameterLocalizationRepository._();

  @override
  int? id;

  int parameterId;

  _i2.AssessmentParameter? parameter;

  String localeKey;

  String name;

  String description;

  List<String>? scoringFeedbacks;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssessmentParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssessmentParameterLocalization copyWith({
    int? id,
    int? parameterId,
    _i2.AssessmentParameter? parameter,
    String? localeKey,
    String? name,
    String? description,
    List<String>? scoringFeedbacks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssessmentParameterLocalization',
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
      '__className__': 'AssessmentParameterLocalization',
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

  static AssessmentParameterLocalizationInclude include({
    _i2.AssessmentParameterInclude? parameter,
  }) {
    return AssessmentParameterLocalizationInclude._(parameter: parameter);
  }

  static AssessmentParameterLocalizationIncludeList includeList({
    _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterLocalizationTable>? orderByList,
    AssessmentParameterLocalizationInclude? include,
  }) {
    return AssessmentParameterLocalizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentParameterLocalization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssessmentParameterLocalization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentParameterLocalizationImpl
    extends AssessmentParameterLocalization {
  _AssessmentParameterLocalizationImpl({
    int? id,
    required int parameterId,
    _i2.AssessmentParameter? parameter,
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

  /// Returns a shallow copy of this [AssessmentParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssessmentParameterLocalization copyWith({
    Object? id = _Undefined,
    int? parameterId,
    Object? parameter = _Undefined,
    String? localeKey,
    String? name,
    String? description,
    Object? scoringFeedbacks = _Undefined,
  }) {
    return AssessmentParameterLocalization(
      id: id is int? ? id : this.id,
      parameterId: parameterId ?? this.parameterId,
      parameter: parameter is _i2.AssessmentParameter?
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

class AssessmentParameterLocalizationUpdateTable
    extends _i1.UpdateTable<AssessmentParameterLocalizationTable> {
  AssessmentParameterLocalizationUpdateTable(super.table);

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

class AssessmentParameterLocalizationTable extends _i1.Table<int?> {
  AssessmentParameterLocalizationTable({super.tableRelation})
    : super(tableName: 'assessment_parameter_localization') {
    updateTable = AssessmentParameterLocalizationUpdateTable(this);
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

  late final AssessmentParameterLocalizationUpdateTable updateTable;

  late final _i1.ColumnInt parameterId;

  _i2.AssessmentParameterTable? _parameter;

  late final _i1.ColumnString localeKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnSerializable<List<String>> scoringFeedbacks;

  _i2.AssessmentParameterTable get parameter {
    if (_parameter != null) return _parameter!;
    _parameter = _i1.createRelationTable(
      relationFieldName: 'parameter',
      field: AssessmentParameterLocalization.t.parameterId,
      foreignField: _i2.AssessmentParameter.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AssessmentParameterTable(tableRelation: foreignTableRelation),
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

class AssessmentParameterLocalizationInclude extends _i1.IncludeObject {
  AssessmentParameterLocalizationInclude._({
    _i2.AssessmentParameterInclude? parameter,
  }) {
    _parameter = parameter;
  }

  _i2.AssessmentParameterInclude? _parameter;

  @override
  Map<String, _i1.Include?> get includes => {'parameter': _parameter};

  @override
  _i1.Table<int?> get table => AssessmentParameterLocalization.t;
}

class AssessmentParameterLocalizationIncludeList extends _i1.IncludeList {
  AssessmentParameterLocalizationIncludeList._({
    _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssessmentParameterLocalization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssessmentParameterLocalization.t;
}

class AssessmentParameterLocalizationRepository {
  const AssessmentParameterLocalizationRepository._();

  final attachRow =
      const AssessmentParameterLocalizationAttachRowRepository._();

  /// Returns a list of [AssessmentParameterLocalization]s matching the given query parameters.
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
  Future<List<AssessmentParameterLocalization>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssessmentParameterLocalization>(
      where: where?.call(AssessmentParameterLocalization.t),
      orderBy: orderBy?.call(AssessmentParameterLocalization.t),
      orderByList: orderByList?.call(AssessmentParameterLocalization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssessmentParameterLocalization] matching the given query parameters.
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
  Future<AssessmentParameterLocalization?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssessmentParameterLocalization>(
      where: where?.call(AssessmentParameterLocalization.t),
      orderBy: orderBy?.call(AssessmentParameterLocalization.t),
      orderByList: orderByList?.call(AssessmentParameterLocalization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssessmentParameterLocalization] by its [id] or null if no such row exists.
  Future<AssessmentParameterLocalization?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssessmentParameterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssessmentParameterLocalization>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssessmentParameterLocalization]s in the list and returns the inserted rows.
  ///
  /// The returned [AssessmentParameterLocalization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssessmentParameterLocalization>> insert(
    _i1.DatabaseSession session,
    List<AssessmentParameterLocalization> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssessmentParameterLocalization>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssessmentParameterLocalization] and returns the inserted row.
  ///
  /// The returned [AssessmentParameterLocalization] will have its `id` field set.
  Future<AssessmentParameterLocalization> insertRow(
    _i1.DatabaseSession session,
    AssessmentParameterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssessmentParameterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentParameterLocalization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssessmentParameterLocalization>> update(
    _i1.DatabaseSession session,
    List<AssessmentParameterLocalization> rows, {
    _i1.ColumnSelections<AssessmentParameterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssessmentParameterLocalization>(
      rows,
      columns: columns?.call(AssessmentParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentParameterLocalization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssessmentParameterLocalization> updateRow(
    _i1.DatabaseSession session,
    AssessmentParameterLocalization row, {
    _i1.ColumnSelections<AssessmentParameterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssessmentParameterLocalization>(
      row,
      columns: columns?.call(AssessmentParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentParameterLocalization] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssessmentParameterLocalization?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<
      AssessmentParameterLocalizationUpdateTable
    >
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssessmentParameterLocalization>(
      id,
      columnValues: columnValues(AssessmentParameterLocalization.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentParameterLocalization]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssessmentParameterLocalization>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<
      AssessmentParameterLocalizationUpdateTable
    >
    columnValues,
    required _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>
    where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterLocalizationTable>? orderBy,
    _i1.OrderByListBuilder<AssessmentParameterLocalizationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssessmentParameterLocalization>(
      columnValues: columnValues(AssessmentParameterLocalization.t.updateTable),
      where: where(AssessmentParameterLocalization.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentParameterLocalization.t),
      orderByList: orderByList?.call(AssessmentParameterLocalization.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssessmentParameterLocalization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssessmentParameterLocalization>> delete(
    _i1.DatabaseSession session,
    List<AssessmentParameterLocalization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssessmentParameterLocalization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssessmentParameterLocalization].
  Future<AssessmentParameterLocalization> deleteRow(
    _i1.DatabaseSession session,
    AssessmentParameterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssessmentParameterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssessmentParameterLocalization>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>
    where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssessmentParameterLocalization>(
      where: where(AssessmentParameterLocalization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssessmentParameterLocalization>(
      where: where?.call(AssessmentParameterLocalization.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssessmentParameterLocalization] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentParameterLocalizationTable>
    where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssessmentParameterLocalization>(
      where: where(AssessmentParameterLocalization.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssessmentParameterLocalizationAttachRowRepository {
  const AssessmentParameterLocalizationAttachRowRepository._();

  /// Creates a relation between the given [AssessmentParameterLocalization] and [AssessmentParameter]
  /// by setting the [AssessmentParameterLocalization]'s foreign key `parameterId` to refer to the [AssessmentParameter].
  Future<void> parameter(
    _i1.DatabaseSession session,
    AssessmentParameterLocalization assessmentParameterLocalization,
    _i2.AssessmentParameter parameter, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentParameterLocalization.id == null) {
      throw ArgumentError.notNull('assessmentParameterLocalization.id');
    }
    if (parameter.id == null) {
      throw ArgumentError.notNull('parameter.id');
    }

    var $assessmentParameterLocalization = assessmentParameterLocalization
        .copyWith(parameterId: parameter.id);
    await session.db.updateRow<AssessmentParameterLocalization>(
      $assessmentParameterLocalization,
      columns: [AssessmentParameterLocalization.t.parameterId],
      transaction: transaction,
    );
  }
}
