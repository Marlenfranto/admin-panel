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
import 'app_user.dart' as _i2;
import 'organization.dart' as _i3;
import 'training_criteria_score.dart' as _i4;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i5;

abstract class TrainingSessionResult
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TrainingSessionResult._({
    this.id,
    this.appUserId,
    this.appUser,
    required this.organizationId,
    this.organization,
    required this.externalUserId,
    required this.overallPercentage,
    this.criteriaScores,
    required this.completedAt,
  });

  factory TrainingSessionResult({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    required int organizationId,
    _i3.Organization? organization,
    required String externalUserId,
    required int overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    required DateTime completedAt,
  }) = _TrainingSessionResultImpl;

  factory TrainingSessionResult.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingSessionResult(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int?,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.AppUser>(
              jsonSerialization['appUser'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      externalUserId: jsonSerialization['externalUserId'] as String,
      overallPercentage: jsonSerialization['overallPercentage'] as int,
      criteriaScores: jsonSerialization['criteriaScores'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.TrainingCriteriaScore>>(
              jsonSerialization['criteriaScores'],
            ),
      completedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
    );
  }

  static final t = TrainingSessionResultTable();

  static const db = TrainingSessionResultRepository._();

  @override
  int? id;

  int? appUserId;

  _i2.AppUser? appUser;

  int organizationId;

  _i3.Organization? organization;

  String externalUserId;

  int overallPercentage;

  List<_i4.TrainingCriteriaScore>? criteriaScores;

  DateTime completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TrainingSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingSessionResult copyWith({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    int? organizationId,
    _i3.Organization? organization,
    String? externalUserId,
    int? overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingSessionResult',
      if (id != null) 'id': id,
      if (appUserId != null) 'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      if (criteriaScores != null)
        'criteriaScores': criteriaScores?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingSessionResult',
      if (id != null) 'id': id,
      if (appUserId != null) 'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJsonForProtocol(),
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'externalUserId': externalUserId,
      'overallPercentage': overallPercentage,
      if (criteriaScores != null)
        'criteriaScores': criteriaScores?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'completedAt': completedAt.toJson(),
    };
  }

  static TrainingSessionResultInclude include({
    _i2.AppUserInclude? appUser,
    _i3.OrganizationInclude? organization,
  }) {
    return TrainingSessionResultInclude._(
      appUser: appUser,
      organization: organization,
    );
  }

  static TrainingSessionResultIncludeList includeList({
    _i1.WhereExpressionBuilder<TrainingSessionResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingSessionResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingSessionResultTable>? orderByList,
    TrainingSessionResultInclude? include,
  }) {
    return TrainingSessionResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingSessionResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrainingSessionResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingSessionResultImpl extends TrainingSessionResult {
  _TrainingSessionResultImpl({
    int? id,
    int? appUserId,
    _i2.AppUser? appUser,
    required int organizationId,
    _i3.Organization? organization,
    required String externalUserId,
    required int overallPercentage,
    List<_i4.TrainingCriteriaScore>? criteriaScores,
    required DateTime completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         appUser: appUser,
         organizationId: organizationId,
         organization: organization,
         externalUserId: externalUserId,
         overallPercentage: overallPercentage,
         criteriaScores: criteriaScores,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [TrainingSessionResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingSessionResult copyWith({
    Object? id = _Undefined,
    Object? appUserId = _Undefined,
    Object? appUser = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? externalUserId,
    int? overallPercentage,
    Object? criteriaScores = _Undefined,
    DateTime? completedAt,
  }) {
    return TrainingSessionResult(
      id: id is int? ? id : this.id,
      appUserId: appUserId is int? ? appUserId : this.appUserId,
      appUser: appUser is _i2.AppUser? ? appUser : this.appUser?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      externalUserId: externalUserId ?? this.externalUserId,
      overallPercentage: overallPercentage ?? this.overallPercentage,
      criteriaScores: criteriaScores is List<_i4.TrainingCriteriaScore>?
          ? criteriaScores
          : this.criteriaScores?.map((e0) => e0.copyWith()).toList(),
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

class TrainingSessionResultUpdateTable
    extends _i1.UpdateTable<TrainingSessionResultTable> {
  TrainingSessionResultUpdateTable(super.table);

  _i1.ColumnValue<int, int> appUserId(int? value) => _i1.ColumnValue(
    table.appUserId,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> externalUserId(String value) =>
      _i1.ColumnValue(
        table.externalUserId,
        value,
      );

  _i1.ColumnValue<int, int> overallPercentage(int value) => _i1.ColumnValue(
    table.overallPercentage,
    value,
  );

  _i1.ColumnValue<
    List<_i4.TrainingCriteriaScore>,
    List<_i4.TrainingCriteriaScore>
  >
  criteriaScores(List<_i4.TrainingCriteriaScore>? value) => _i1.ColumnValue(
    table.criteriaScores,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class TrainingSessionResultTable extends _i1.Table<int?> {
  TrainingSessionResultTable({super.tableRelation})
    : super(tableName: 'training_session_result') {
    updateTable = TrainingSessionResultUpdateTable(this);
    appUserId = _i1.ColumnInt(
      'appUserId',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    externalUserId = _i1.ColumnString(
      'externalUserId',
      this,
    );
    overallPercentage = _i1.ColumnInt(
      'overallPercentage',
      this,
    );
    criteriaScores = _i1.ColumnSerializable<List<_i4.TrainingCriteriaScore>>(
      'criteriaScores',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final TrainingSessionResultUpdateTable updateTable;

  late final _i1.ColumnInt appUserId;

  _i2.AppUserTable? _appUser;

  late final _i1.ColumnInt organizationId;

  _i3.OrganizationTable? _organization;

  late final _i1.ColumnString externalUserId;

  late final _i1.ColumnInt overallPercentage;

  late final _i1.ColumnSerializable<List<_i4.TrainingCriteriaScore>>
  criteriaScores;

  late final _i1.ColumnDateTime completedAt;

  _i2.AppUserTable get appUser {
    if (_appUser != null) return _appUser!;
    _appUser = _i1.createRelationTable(
      relationFieldName: 'appUser',
      field: TrainingSessionResult.t.appUserId,
      foreignField: _i2.AppUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserTable(tableRelation: foreignTableRelation),
    );
    return _appUser!;
  }

  _i3.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: TrainingSessionResult.t.organizationId,
      foreignField: _i3.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    appUserId,
    organizationId,
    externalUserId,
    overallPercentage,
    criteriaScores,
    completedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'appUser') {
      return appUser;
    }
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class TrainingSessionResultInclude extends _i1.IncludeObject {
  TrainingSessionResultInclude._({
    _i2.AppUserInclude? appUser,
    _i3.OrganizationInclude? organization,
  }) {
    _appUser = appUser;
    _organization = organization;
  }

  _i2.AppUserInclude? _appUser;

  _i3.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {
    'appUser': _appUser,
    'organization': _organization,
  };

  @override
  _i1.Table<int?> get table => TrainingSessionResult.t;
}

class TrainingSessionResultIncludeList extends _i1.IncludeList {
  TrainingSessionResultIncludeList._({
    _i1.WhereExpressionBuilder<TrainingSessionResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrainingSessionResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrainingSessionResult.t;
}

class TrainingSessionResultRepository {
  const TrainingSessionResultRepository._();

  final attachRow = const TrainingSessionResultAttachRowRepository._();

  final detachRow = const TrainingSessionResultDetachRowRepository._();

  /// Returns a list of [TrainingSessionResult]s matching the given query parameters.
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
  Future<List<TrainingSessionResult>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingSessionResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingSessionResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingSessionResultTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingSessionResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrainingSessionResult>(
      where: where?.call(TrainingSessionResult.t),
      orderBy: orderBy?.call(TrainingSessionResult.t),
      orderByList: orderByList?.call(TrainingSessionResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrainingSessionResult] matching the given query parameters.
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
  Future<TrainingSessionResult?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingSessionResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrainingSessionResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrainingSessionResultTable>? orderByList,
    _i1.Transaction? transaction,
    TrainingSessionResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrainingSessionResult>(
      where: where?.call(TrainingSessionResult.t),
      orderBy: orderBy?.call(TrainingSessionResult.t),
      orderByList: orderByList?.call(TrainingSessionResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrainingSessionResult] by its [id] or null if no such row exists.
  Future<TrainingSessionResult?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TrainingSessionResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrainingSessionResult>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrainingSessionResult]s in the list and returns the inserted rows.
  ///
  /// The returned [TrainingSessionResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrainingSessionResult>> insert(
    _i1.DatabaseSession session,
    List<TrainingSessionResult> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrainingSessionResult>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrainingSessionResult] and returns the inserted row.
  ///
  /// The returned [TrainingSessionResult] will have its `id` field set.
  Future<TrainingSessionResult> insertRow(
    _i1.DatabaseSession session,
    TrainingSessionResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrainingSessionResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrainingSessionResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrainingSessionResult>> update(
    _i1.DatabaseSession session,
    List<TrainingSessionResult> rows, {
    _i1.ColumnSelections<TrainingSessionResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrainingSessionResult>(
      rows,
      columns: columns?.call(TrainingSessionResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingSessionResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrainingSessionResult> updateRow(
    _i1.DatabaseSession session,
    TrainingSessionResult row, {
    _i1.ColumnSelections<TrainingSessionResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrainingSessionResult>(
      row,
      columns: columns?.call(TrainingSessionResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrainingSessionResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrainingSessionResult?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrainingSessionResultUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrainingSessionResult>(
      id,
      columnValues: columnValues(TrainingSessionResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrainingSessionResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrainingSessionResult>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrainingSessionResultUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrainingSessionResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrainingSessionResultTable>? orderBy,
    _i1.OrderByListBuilder<TrainingSessionResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrainingSessionResult>(
      columnValues: columnValues(TrainingSessionResult.t.updateTable),
      where: where(TrainingSessionResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrainingSessionResult.t),
      orderByList: orderByList?.call(TrainingSessionResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrainingSessionResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrainingSessionResult>> delete(
    _i1.DatabaseSession session,
    List<TrainingSessionResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrainingSessionResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrainingSessionResult].
  Future<TrainingSessionResult> deleteRow(
    _i1.DatabaseSession session,
    TrainingSessionResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrainingSessionResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrainingSessionResult>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingSessionResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrainingSessionResult>(
      where: where(TrainingSessionResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrainingSessionResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrainingSessionResult>(
      where: where?.call(TrainingSessionResult.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrainingSessionResult] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrainingSessionResultTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrainingSessionResult>(
      where: where(TrainingSessionResult.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TrainingSessionResultAttachRowRepository {
  const TrainingSessionResultAttachRowRepository._();

  /// Creates a relation between the given [TrainingSessionResult] and [AppUser]
  /// by setting the [TrainingSessionResult]'s foreign key `appUserId` to refer to the [AppUser].
  Future<void> appUser(
    _i1.DatabaseSession session,
    TrainingSessionResult trainingSessionResult,
    _i2.AppUser appUser, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingSessionResult.id == null) {
      throw ArgumentError.notNull('trainingSessionResult.id');
    }
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }

    var $trainingSessionResult = trainingSessionResult.copyWith(
      appUserId: appUser.id,
    );
    await session.db.updateRow<TrainingSessionResult>(
      $trainingSessionResult,
      columns: [TrainingSessionResult.t.appUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TrainingSessionResult] and [Organization]
  /// by setting the [TrainingSessionResult]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    TrainingSessionResult trainingSessionResult,
    _i3.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingSessionResult.id == null) {
      throw ArgumentError.notNull('trainingSessionResult.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $trainingSessionResult = trainingSessionResult.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<TrainingSessionResult>(
      $trainingSessionResult,
      columns: [TrainingSessionResult.t.organizationId],
      transaction: transaction,
    );
  }
}

class TrainingSessionResultDetachRowRepository {
  const TrainingSessionResultDetachRowRepository._();

  /// Detaches the relation between this [TrainingSessionResult] and the [AppUser] set in `appUser`
  /// by setting the [TrainingSessionResult]'s foreign key `appUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> appUser(
    _i1.DatabaseSession session,
    TrainingSessionResult trainingSessionResult, {
    _i1.Transaction? transaction,
  }) async {
    if (trainingSessionResult.id == null) {
      throw ArgumentError.notNull('trainingSessionResult.id');
    }

    var $trainingSessionResult = trainingSessionResult.copyWith(
      appUserId: null,
    );
    await session.db.updateRow<TrainingSessionResult>(
      $trainingSessionResult,
      columns: [TrainingSessionResult.t.appUserId],
      transaction: transaction,
    );
  }
}
