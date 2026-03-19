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

abstract class ManagerNotification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ManagerNotification._({
    this.id,
    required this.managerId,
    required this.overdueUserId,
    required this.organizationId,
    required this.moduleId,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory ManagerNotification({
    int? id,
    required int managerId,
    required int overdueUserId,
    required int organizationId,
    required String moduleId,
    bool? isRead,
    required DateTime createdAt,
  }) = _ManagerNotificationImpl;

  factory ManagerNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagerNotification(
      id: jsonSerialization['id'] as int?,
      managerId: jsonSerialization['managerId'] as int,
      overdueUserId: jsonSerialization['overdueUserId'] as int,
      organizationId: jsonSerialization['organizationId'] as int,
      moduleId: jsonSerialization['moduleId'] as String,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = ManagerNotificationTable();

  static const db = ManagerNotificationRepository._();

  @override
  int? id;

  int managerId;

  int overdueUserId;

  int organizationId;

  String moduleId;

  bool isRead;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ManagerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManagerNotification copyWith({
    int? id,
    int? managerId,
    int? overdueUserId,
    int? organizationId,
    String? moduleId,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagerNotification',
      if (id != null) 'id': id,
      'managerId': managerId,
      'overdueUserId': overdueUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ManagerNotification',
      if (id != null) 'id': id,
      'managerId': managerId,
      'overdueUserId': overdueUserId,
      'organizationId': organizationId,
      'moduleId': moduleId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  static ManagerNotificationInclude include() {
    return ManagerNotificationInclude._();
  }

  static ManagerNotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<ManagerNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ManagerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ManagerNotificationTable>? orderByList,
    ManagerNotificationInclude? include,
  }) {
    return ManagerNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagerNotification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ManagerNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ManagerNotificationImpl extends ManagerNotification {
  _ManagerNotificationImpl({
    int? id,
    required int managerId,
    required int overdueUserId,
    required int organizationId,
    required String moduleId,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         managerId: managerId,
         overdueUserId: overdueUserId,
         organizationId: organizationId,
         moduleId: moduleId,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ManagerNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManagerNotification copyWith({
    Object? id = _Undefined,
    int? managerId,
    int? overdueUserId,
    int? organizationId,
    String? moduleId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return ManagerNotification(
      id: id is int? ? id : this.id,
      managerId: managerId ?? this.managerId,
      overdueUserId: overdueUserId ?? this.overdueUserId,
      organizationId: organizationId ?? this.organizationId,
      moduleId: moduleId ?? this.moduleId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ManagerNotificationUpdateTable
    extends _i1.UpdateTable<ManagerNotificationTable> {
  ManagerNotificationUpdateTable(super.table);

  _i1.ColumnValue<int, int> managerId(int value) => _i1.ColumnValue(
    table.managerId,
    value,
  );

  _i1.ColumnValue<int, int> overdueUserId(int value) => _i1.ColumnValue(
    table.overdueUserId,
    value,
  );

  _i1.ColumnValue<int, int> organizationId(int value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<String, String> moduleId(String value) => _i1.ColumnValue(
    table.moduleId,
    value,
  );

  _i1.ColumnValue<bool, bool> isRead(bool value) => _i1.ColumnValue(
    table.isRead,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ManagerNotificationTable extends _i1.Table<int?> {
  ManagerNotificationTable({super.tableRelation})
    : super(tableName: 'manager_notification') {
    updateTable = ManagerNotificationUpdateTable(this);
    managerId = _i1.ColumnInt(
      'managerId',
      this,
    );
    overdueUserId = _i1.ColumnInt(
      'overdueUserId',
      this,
    );
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    moduleId = _i1.ColumnString(
      'moduleId',
      this,
    );
    isRead = _i1.ColumnBool(
      'isRead',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ManagerNotificationUpdateTable updateTable;

  late final _i1.ColumnInt managerId;

  late final _i1.ColumnInt overdueUserId;

  late final _i1.ColumnInt organizationId;

  late final _i1.ColumnString moduleId;

  late final _i1.ColumnBool isRead;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    managerId,
    overdueUserId,
    organizationId,
    moduleId,
    isRead,
    createdAt,
  ];
}

class ManagerNotificationInclude extends _i1.IncludeObject {
  ManagerNotificationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ManagerNotification.t;
}

class ManagerNotificationIncludeList extends _i1.IncludeList {
  ManagerNotificationIncludeList._({
    _i1.WhereExpressionBuilder<ManagerNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ManagerNotification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ManagerNotification.t;
}

class ManagerNotificationRepository {
  const ManagerNotificationRepository._();

  /// Returns a list of [ManagerNotification]s matching the given query parameters.
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
  Future<List<ManagerNotification>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ManagerNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ManagerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ManagerNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ManagerNotification>(
      where: where?.call(ManagerNotification.t),
      orderBy: orderBy?.call(ManagerNotification.t),
      orderByList: orderByList?.call(ManagerNotification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ManagerNotification] matching the given query parameters.
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
  Future<ManagerNotification?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ManagerNotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<ManagerNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ManagerNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ManagerNotification>(
      where: where?.call(ManagerNotification.t),
      orderBy: orderBy?.call(ManagerNotification.t),
      orderByList: orderByList?.call(ManagerNotification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ManagerNotification] by its [id] or null if no such row exists.
  Future<ManagerNotification?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ManagerNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ManagerNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [ManagerNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ManagerNotification>> insert(
    _i1.DatabaseSession session,
    List<ManagerNotification> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ManagerNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ManagerNotification] and returns the inserted row.
  ///
  /// The returned [ManagerNotification] will have its `id` field set.
  Future<ManagerNotification> insertRow(
    _i1.DatabaseSession session,
    ManagerNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ManagerNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ManagerNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ManagerNotification>> update(
    _i1.DatabaseSession session,
    List<ManagerNotification> rows, {
    _i1.ColumnSelections<ManagerNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ManagerNotification>(
      rows,
      columns: columns?.call(ManagerNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ManagerNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ManagerNotification> updateRow(
    _i1.DatabaseSession session,
    ManagerNotification row, {
    _i1.ColumnSelections<ManagerNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ManagerNotification>(
      row,
      columns: columns?.call(ManagerNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ManagerNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ManagerNotification?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ManagerNotificationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ManagerNotification>(
      id,
      columnValues: columnValues(ManagerNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ManagerNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ManagerNotification>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ManagerNotificationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ManagerNotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ManagerNotificationTable>? orderBy,
    _i1.OrderByListBuilder<ManagerNotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ManagerNotification>(
      columnValues: columnValues(ManagerNotification.t.updateTable),
      where: where(ManagerNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ManagerNotification.t),
      orderByList: orderByList?.call(ManagerNotification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ManagerNotification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ManagerNotification>> delete(
    _i1.DatabaseSession session,
    List<ManagerNotification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ManagerNotification>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ManagerNotification].
  Future<ManagerNotification> deleteRow(
    _i1.DatabaseSession session,
    ManagerNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ManagerNotification>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ManagerNotification>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ManagerNotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ManagerNotification>(
      where: where(ManagerNotification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ManagerNotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ManagerNotification>(
      where: where?.call(ManagerNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ManagerNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ManagerNotificationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ManagerNotification>(
      where: where(ManagerNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
