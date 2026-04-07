/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'module_progress_status.dart' as _i2;

abstract class UserTheoryProgress
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserTheoryProgress._({
    this.id,
    required this.appUserId,
    required this.organizationId,
    required this.chapterId,
    required this.score,
    required this.status,
    this.lastWatchedPosition,
    this.completedAt,
  });

  factory UserTheoryProgress({
    int? id,
    required int appUserId,
    required int organizationId,
    required int chapterId,
    required int score,
    required _i2.ModuleProgressStatus status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  }) = _UserTheoryProgressImpl;

  factory UserTheoryProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserTheoryProgress(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int,
      organizationId: jsonSerialization['organizationId'] as int,
      chapterId: jsonSerialization['chapterId'] as int,
      score: jsonSerialization['score'] as int,
      status: _i2.ModuleProgressStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      lastWatchedPosition: jsonSerialization['lastWatchedPosition'] as int?,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = UserTheoryProgressTable();

  static const db = UserTheoryProgressRepository._();

  @override
  int? id;

  int appUserId;

  int organizationId;

  int chapterId;

  int score;

  _i2.ModuleProgressStatus status;

  int? lastWatchedPosition;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserTheoryProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserTheoryProgress copyWith({
    int? id,
    int? appUserId,
    int? organizationId,
    int? chapterId,
    int? score,
    _i2.ModuleProgressStatus? status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserTheoryProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      'organizationId': organizationId,
      'chapterId': chapterId,
      'score': score,
      'status': status.toJson(),
      if (lastWatchedPosition != null)
        'lastWatchedPosition': lastWatchedPosition,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserTheoryProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      'organizationId': organizationId,
      'chapterId': chapterId,
      'score': score,
      'status': status.toJson(),
      if (lastWatchedPosition != null)
        'lastWatchedPosition': lastWatchedPosition,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static UserTheoryProgressInclude include() {
    return UserTheoryProgressInclude._();
  }

  static UserTheoryProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTheoryProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTheoryProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTheoryProgressTable>? orderByList,
    UserTheoryProgressInclude? include,
  }) {
    return UserTheoryProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserTheoryProgress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserTheoryProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserTheoryProgressImpl extends UserTheoryProgress {
  _UserTheoryProgressImpl({
    int? id,
    required int appUserId,
    required int organizationId,
    required int chapterId,
    required int score,
    required _i2.ModuleProgressStatus status,
    int? lastWatchedPosition,
    DateTime? completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         organizationId: organizationId,
         chapterId: chapterId,
         score: score,
         status: status,
         lastWatchedPosition: lastWatchedPosition,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [UserTheoryProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserTheoryProgress copyWith({
    Object? id = _Undefined,
    int? appUserId,
    int? organizationId,
    int? chapterId,
    int? score,
    _i2.ModuleProgressStatus? status,
    Object? lastWatchedPosition = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return UserTheoryProgress(
      id: id is int? ? id : this.id,
      appUserId: appUserId ?? this.appUserId,
      organizationId: organizationId ?? this.organizationId,
      chapterId: chapterId ?? this.chapterId,
      score: score ?? this.score,
      status: status ?? this.status,
      lastWatchedPosition: lastWatchedPosition is int?
          ? lastWatchedPosition
          : this.lastWatchedPosition,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class UserTheoryProgressUpdateTable
    extends _i1.UpdateTable<UserTheoryProgressTable> {
  UserTheoryProgressUpdateTable(super.table);

  _i1.ColumnValue<int, int> appUserId(int value) => _i1.ColumnValue(
    table.appUserId,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<int, int> chapterId(int value) => _i1.ColumnValue(
    table.chapterId,
    value,
  );

  _i1.ColumnValue<int, int> score(int value) => _i1.ColumnValue(
    table.score,
    value,
  );

  _i1.ColumnValue<_i2.ModuleProgressStatus, _i2.ModuleProgressStatus> status(
    _i2.ModuleProgressStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> lastWatchedPosition(int? value) => _i1.ColumnValue(
    table.lastWatchedPosition,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class UserTheoryProgressTable extends _i1.Table<int?> {
  UserTheoryProgressTable({super.tableRelation})
    : super(tableName: 'user_theory_progress') {
    updateTable = UserTheoryProgressUpdateTable(this);
    appUserId = _i1.ColumnInt(
      'appUserId',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    chapterId = _i1.ColumnInt(
      'chapterId',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    lastWatchedPosition = _i1.ColumnInt(
      'lastWatchedPosition',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final UserTheoryProgressUpdateTable updateTable;

  late final _i1.ColumnInt appUserId;

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnInt chapterId;

  late final _i1.ColumnInt score;

  late final _i1.ColumnEnum<_i2.ModuleProgressStatus> status;

  late final _i1.ColumnInt lastWatchedPosition;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    appUserId,
    organizationId,
    chapterId,
    score,
    status,
    lastWatchedPosition,
    completedAt,
  ];
}

class UserTheoryProgressInclude extends _i1.IncludeObject {
  UserTheoryProgressInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserTheoryProgress.t;
}

class UserTheoryProgressIncludeList extends _i1.IncludeList {
  UserTheoryProgressIncludeList._({
    _i1.WhereExpressionBuilder<UserTheoryProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserTheoryProgress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserTheoryProgress.t;
}

class UserTheoryProgressRepository {
  const UserTheoryProgressRepository._();

  /// Returns a list of [UserTheoryProgress]s matching the given query parameters.
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
  Future<List<UserTheoryProgress>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTheoryProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTheoryProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTheoryProgressTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserTheoryProgress>(
      where: where?.call(UserTheoryProgress.t),
      orderBy: orderBy?.call(UserTheoryProgress.t),
      orderByList: orderByList?.call(UserTheoryProgress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserTheoryProgress] matching the given query parameters.
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
  Future<UserTheoryProgress?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTheoryProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTheoryProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTheoryProgressTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserTheoryProgress>(
      where: where?.call(UserTheoryProgress.t),
      orderBy: orderBy?.call(UserTheoryProgress.t),
      orderByList: orderByList?.call(UserTheoryProgress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserTheoryProgress] by its [id] or null if no such row exists.
  Future<UserTheoryProgress?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserTheoryProgress>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserTheoryProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [UserTheoryProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserTheoryProgress>> insert(
    _i1.DatabaseSession session,
    List<UserTheoryProgress> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserTheoryProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserTheoryProgress] and returns the inserted row.
  ///
  /// The returned [UserTheoryProgress] will have its `id` field set.
  Future<UserTheoryProgress> insertRow(
    _i1.DatabaseSession session,
    UserTheoryProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserTheoryProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserTheoryProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserTheoryProgress>> update(
    _i1.DatabaseSession session,
    List<UserTheoryProgress> rows, {
    _i1.ColumnSelections<UserTheoryProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserTheoryProgress>(
      rows,
      columns: columns?.call(UserTheoryProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserTheoryProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserTheoryProgress> updateRow(
    _i1.DatabaseSession session,
    UserTheoryProgress row, {
    _i1.ColumnSelections<UserTheoryProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserTheoryProgress>(
      row,
      columns: columns?.call(UserTheoryProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserTheoryProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserTheoryProgress?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserTheoryProgressUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserTheoryProgress>(
      id,
      columnValues: columnValues(UserTheoryProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserTheoryProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserTheoryProgress>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserTheoryProgressUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<UserTheoryProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTheoryProgressTable>? orderBy,
    _i1.OrderByListBuilder<UserTheoryProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserTheoryProgress>(
      columnValues: columnValues(UserTheoryProgress.t.updateTable),
      where: where(UserTheoryProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserTheoryProgress.t),
      orderByList: orderByList?.call(UserTheoryProgress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserTheoryProgress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserTheoryProgress>> delete(
    _i1.DatabaseSession session,
    List<UserTheoryProgress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserTheoryProgress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserTheoryProgress].
  Future<UserTheoryProgress> deleteRow(
    _i1.DatabaseSession session,
    UserTheoryProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserTheoryProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserTheoryProgress>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTheoryProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserTheoryProgress>(
      where: where(UserTheoryProgress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserTheoryProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserTheoryProgress>(
      where: where?.call(UserTheoryProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserTheoryProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserTheoryProgressTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserTheoryProgress>(
      where: where(UserTheoryProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
