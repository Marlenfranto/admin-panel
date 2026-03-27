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
import 'scoring_rule.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class TrainingParameter
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingParameter._({
    this.id,
    this.organizationId,
    this.organization,
    required this.paramId,
    required this.name,
    required this.description,
    required this.maxScore,
    required this.scoringRules,
  });

  factory TrainingParameter({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required String name,
    required String description,
    required int maxScore,
    required List<_i3.ScoringRule> scoringRules,
  }) = _TrainingParameterImpl;

  factory TrainingParameter.fromJson(Map<String, dynamic> jsonSerialization) {
    return TrainingParameter(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      paramId: jsonSerialization['paramId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      maxScore: jsonSerialization['maxScore'] as int,
      scoringRules: _i4.Protocol().deserialize<List<_i3.ScoringRule>>(
        jsonSerialization['scoringRules'],
      ),
    );
  }

  static final t = TrainingParameterTable();

  static const db = TrainingParameterRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String paramId;

  String name;

  String description;

  int maxScore;

  List<_i3.ScoringRule> scoringRules;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingParameter copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? paramId,
    String? name,
    String? description,
    int? maxScore,
    List<_i3.ScoringRule>? scoringRules,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'paramId': paramId,
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'scoringRules': scoringRules.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'paramId': paramId,
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'scoringRules': scoringRules.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  static TrainingParameterInclude include({
    _i2.OrganizationInclude? organization,
  }) {
    return TrainingParameterInclude._(organization: organization);
  }

  static TrainingParameterIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingParameterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterTable>? orderByList,
    TrainingParameterInclude? include,
  }) {
    return TrainingParameterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingParameter.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingParameter.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingParameterImpl extends TrainingParameter {
  _TrainingParameterImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required String name,
    required String description,
    required int maxScore,
    required List<_i3.ScoringRule> scoringRules,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         paramId: paramId,
         name: name,
         description: description,
         maxScore: maxScore,
         scoringRules: scoringRules,
       );

  /// Returns a shallow copy of this [TrainingParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingParameter copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? paramId,
    String? name,
    String? description,
    int? maxScore,
    List<_i3.ScoringRule>? scoringRules,
  }) {
    return TrainingParameter(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      paramId: paramId ?? this.paramId,
      name: name ?? this.name,
      description: description ?? this.description,
      maxScore: maxScore ?? this.maxScore,
      scoringRules:
          scoringRules ?? this.scoringRules.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class TrainingParameterUpdateTable
    extends _i1.UpdateTable<TrainingParameterTable> {
  TrainingParameterUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> paramId(String value) => _i1.ColumnValue(
    table.paramId,
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

  _i1.ColumnValue<int, int> maxScore(int value) => _i1.ColumnValue(
    table.maxScore,
    value,
  );

  _i1.ColumnValue<List<_i3.ScoringRule>, List<_i3.ScoringRule>> scoringRules(
    List<_i3.ScoringRule> value,
  ) => _i1.ColumnValue(
    table.scoringRules,
    value,
  );
}

class TrainingParameterTable extends _i1.Table<int?> {
  TrainingParameterTable({super.tableRelation})
    : super(tableName: 'training_parameter') {
    updateTable = TrainingParameterUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    paramId = _i1.ColumnString(
      'paramId',
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
    maxScore = _i1.ColumnInt(
      'maxScore',
      this,
    );
    scoringRules = _i1.ColumnSerializable<List<_i3.ScoringRule>>(
      'scoringRules',
      this,
    );
  }

  late final TrainingParameterUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString paramId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt maxScore;

  late final _i1.ColumnSerializable<List<_i3.ScoringRule>> scoringRules;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: TrainingParameter.t.organizationId,
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
    paramId,
    name,
    description,
    maxScore,
    scoringRules,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class TrainingParameterInclude extends _i1.IncludeObject {
  TrainingParameterInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => TrainingParameter.t;
}

class TrainingParameterIncludeList extends _i1.IncludeList {
  TrainingParameterIncludeList._({
    _i1.WhereExpressionBuilder<TrainingParameterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingParameter.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingParameter.t;
}

class TrainingParameterRepository {
  const TrainingParameterRepository._();

  final attachRow = const TrainingParameterAttachRowRepository._();

  final detachRow = const TrainingParameterDetachRowRepository._();

  /// Returns a list of [TrainingParameter]s matching the given query parameters.
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
  Future<List<TrainingParameter>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingParameter>(
      where: where?.call(TrainingParameter.t),
      orderBy: orderBy?.call(TrainingParameter.t),
      orderByList: orderByList?.call(TrainingParameter.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingParameter] matching the given query parameters.
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
  Future<TrainingParameter?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingParameterTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingParameter>(
      where: where?.call(TrainingParameter.t),
      orderBy: orderBy?.call(TrainingParameter.t),
      orderByList: orderByList?.call(TrainingParameter.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingParameter] by its [id] or null if no such row exists.
  Future<TrainingParameter?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingParameter>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingParameter]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingParameter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingParameter>> insert(
    _i1.DatabaseSession session,
    List<TrainingParameter> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingParameter>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingParameter] and returns the inserted row.
  ///
  /// The returned [TrainingParameter] will have its `id` field set.
  Future<TrainingParameter> insertRow(
    _i1.DatabaseSession session,
    TrainingParameter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingParameter>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingParameter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingParameter>> update(
    _i1.DatabaseSession session,
    List<TrainingParameter> rows, {
    _i1.ColumnSelections<TrainingParameterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingParameter>(
      rows,
      columns: columns?.call(TrainingParameter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingParameter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingParameter> updateRow(
    _i1.DatabaseSession session,
    TrainingParameter row, {
    _i1.ColumnSelections<TrainingParameterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingParameter>(
      row,
      columns: columns?.call(TrainingParameter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingParameter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingParameter?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingParameterUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingParameter>(
      id,
      columnValues: columnValues(TrainingParameter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingParameter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingParameter>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingParameterUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingParameterTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingParameterTable>? orderBy,
    _i1.OrderByListBuilder<TrainingParameterTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingParameter>(
      columnValues: columnValues(TrainingParameter.t.updateTable),
      where: where(TrainingParameter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingParameter.t),
      orderByList: orderByList?.call(TrainingParameter.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingParameter]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingParameter>> delete(
    _i1.DatabaseSession session,
    List<TrainingParameter> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingParameter>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingParameter].
  Future<TrainingParameter> deleteRow(
    _i1.DatabaseSession session,
    TrainingParameter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingParameter>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingParameter>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingParameterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingParameter>(
      where: where(TrainingParameter.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingParameterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingParameter>(
      where: where?.call(TrainingParameter.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingParameter] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingParameterTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingParameter>(
      where: where(TrainingParameter.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingParameterAttachRowRepository {
  const TrainingParameterAttachRowRepository._();

  /// Creates a relation between the given [TrainingParameter] and [Organization]
  /// by setting the [TrainingParameter]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    TrainingParameter trainingParameter,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingParameter.id == null) {
      throw ArgumentError.notNull('trainingParameter.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $trainingParameter = trainingParameter.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<TrainingParameter>(
      $trainingParameter,
      columns: [TrainingParameter.t.organizationId],
      transaction: transaction,
    );
  }
}

class TrainingParameterDetachRowRepository {
  const TrainingParameterDetachRowRepository._();

  /// Detaches the relation between this [TrainingParameter] and the [Organization] set in `organization`
  /// by setting the [TrainingParameter]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    TrainingParameter trainingParameter, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingParameter.id == null) {
      throw ArgumentError.notNull('trainingParameter.id');
    }

    var $trainingParameter = trainingParameter.copyWith(organizationId: null);
    await session.db.updateRow<TrainingParameter>(
      $trainingParameter,
      columns: [TrainingParameter.t.organizationId],
      transaction: transaction,
    );
  }
}
