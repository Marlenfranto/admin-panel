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
import 'module_progress_status.dart' as _i2;
import 'app_user.dart' as _i3;
import 'organization.dart' as _i4;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i5;

abstract class UserModuleProgress
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserModuleProgress._({
    this.id,
    required this.appUserId,
    this.appUser,
    required this.organizationId,
    this.organization,
    required this.moduleId,
    bool? isEnabled,
    this.deadline,
    _i2.ModuleProgressStatus? status,
    this.startedAt,
    this.completedAt,
  }) : isEnabled = isEnabled ?? true,
       status = status ?? _i2.ModuleProgressStatus.notStarted;

  factory UserModuleProgress({
    int? id,
    required int appUserId,
    _i3.AppUser? appUser,
    required int organizationId,
    _i4.Organization? organization,
    required String moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  }) = _UserModuleProgressImpl;

  factory UserModuleProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserModuleProgress(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AppUser>(
              jsonSerialization['appUser'],
            ),
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Organization>(
              jsonSerialization['organization'],
            ),
      moduleId: jsonSerialization['moduleId'] as String,
      isEnabled: jsonSerialization['isEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isEnabled']),
      deadline: jsonSerialization['deadline'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deadline']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.ModuleProgressStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = UserModuleProgressTable();

  static const db = UserModuleProgressRepository._();

  @override
  int? id;

  int appUserId;

  _i3.AppUser? appUser;

  int organizationId;

  _i4.Organization? organization;

  String moduleId;

  bool isEnabled;

  DateTime? deadline;

  _i2.ModuleProgressStatus status;

  DateTime? startedAt;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserModuleProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserModuleProgress copyWith({
    int? id,
    int? appUserId,
    _i3.AppUser? appUser,
    int? organizationId,
    _i4.Organization? organization,
    String? moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserModuleProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserModuleProgress',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJsonForProtocol(),
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'moduleId': moduleId,
      'isEnabled': isEnabled,
      if (deadline != null) 'deadline': deadline?.toJson(),
      'status': status.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static UserModuleProgressInclude include({
    _i3.AppUserInclude? appUser,
    _i4.OrganizationInclude? organization,
  }) {
    return UserModuleProgressInclude._(
      appUser: appUser,
      organization: organization,
    );
  }

  static UserModuleProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<UserModuleProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModuleProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModuleProgressTable>? orderByList,
    UserModuleProgressInclude? include,
  }) {
    return UserModuleProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserModuleProgress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserModuleProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserModuleProgressImpl extends UserModuleProgress {
  _UserModuleProgressImpl({
    int? id,
    required int appUserId,
    _i3.AppUser? appUser,
    required int organizationId,
    _i4.Organization? organization,
    required String moduleId,
    bool? isEnabled,
    DateTime? deadline,
    _i2.ModuleProgressStatus? status,
    DateTime? startedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         appUser: appUser,
         organizationId: organizationId,
         organization: organization,
         moduleId: moduleId,
         isEnabled: isEnabled,
         deadline: deadline,
         status: status,
         startedAt: startedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [UserModuleProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserModuleProgress copyWith({
    Object? id = _Undefined,
    int? appUserId,
    Object? appUser = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    String? moduleId,
    bool? isEnabled,
    Object? deadline = _Undefined,
    _i2.ModuleProgressStatus? status,
    Object? startedAt = _Undefined,
    Object? completedAt = _Undefined,
  }) {
    return UserModuleProgress(
      id: id is int? ? id : this.id,
      appUserId: appUserId ?? this.appUserId,
      appUser: appUser is _i3.AppUser? ? appUser : this.appUser?.copyWith(),
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i4.Organization?
          ? organization
          : this.organization?.copyWith(),
      moduleId: moduleId ?? this.moduleId,
      isEnabled: isEnabled ?? this.isEnabled,
      deadline: deadline is DateTime? ? deadline : this.deadline,
      status: status ?? this.status,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class UserModuleProgressUpdateTable
    extends _i1.UpdateTable<UserModuleProgressTable> {
  UserModuleProgressUpdateTable(super.table);

  _i1.ColumnValue<int, int> appUserId(int value) => _i1.ColumnValue(
    table.appUserId,
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

  _i1.ColumnValue<bool, bool> isEnabled(bool value) => _i1.ColumnValue(
    table.isEnabled,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> deadline(DateTime? value) =>
      _i1.ColumnValue(
        table.deadline,
        value,
      );

  _i1.ColumnValue<_i2.ModuleProgressStatus, _i2.ModuleProgressStatus> status(
    _i2.ModuleProgressStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.startedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class UserModuleProgressTable extends _i1.Table<int?> {
  UserModuleProgressTable({super.tableRelation})
    : super(tableName: 'user_module_progress') {
    updateTable = UserModuleProgressUpdateTable(this);
    appUserId = _i1.ColumnInt(
      'appUserId',
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
    isEnabled = _i1.ColumnBool(
      'isEnabled',
      this,
      hasDefault: true,
    );
    deadline = _i1.ColumnDateTime(
      'deadline',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    startedAt = _i1.ColumnDateTime(
      'startedAt',
      this,
    );
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final UserModuleProgressUpdateTable updateTable;

  late final _i1.ColumnInt appUserId;

  _i3.AppUserTable? _appUser;

  late final _i1.ColumnInt organizationId;

  _i4.OrganizationTable? _organization;

  late final _i1.ColumnString moduleId;

  late final _i1.ColumnBool isEnabled;

  late final _i1.ColumnDateTime deadline;

  late final _i1.ColumnEnum<_i2.ModuleProgressStatus> status;

  late final _i1.ColumnDateTime startedAt;

  late final _i1.ColumnDateTime completedAt;

  _i3.AppUserTable get appUser {
    if (_appUser != null) return _appUser!;
    _appUser = _i1.createRelationTable(
      relationFieldName: 'appUser',
      field: UserModuleProgress.t.appUserId,
      foreignField: _i3.AppUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserTable(tableRelation: foreignTableRelation),
    );
    return _appUser!;
  }

  _i4.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: UserModuleProgress.t.organizationId,
      foreignField: _i4.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    appUserId,
    organizationId,
    moduleId,
    isEnabled,
    deadline,
    status,
    startedAt,
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

class UserModuleProgressInclude extends _i1.IncludeObject {
  UserModuleProgressInclude._({
    _i3.AppUserInclude? appUser,
    _i4.OrganizationInclude? organization,
  }) {
    _appUser = appUser;
    _organization = organization;
  }

  _i3.AppUserInclude? _appUser;

  _i4.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {
    'appUser': _appUser,
    'organization': _organization,
  };

  @override
  _i1.Table<int?> get table => UserModuleProgress.t;
}

class UserModuleProgressIncludeList extends _i1.IncludeList {
  UserModuleProgressIncludeList._({
    _i1.WhereExpressionBuilder<UserModuleProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserModuleProgress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserModuleProgress.t;
}

class UserModuleProgressRepository {
  const UserModuleProgressRepository._();

  final attachRow = const UserModuleProgressAttachRowRepository._();

  /// Returns a list of [UserModuleProgress]s matching the given query parameters.
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
  Future<List<UserModuleProgress>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModuleProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModuleProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModuleProgressTable>? orderByList,
    _i1.Transaction? transaction,
    UserModuleProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserModuleProgress>(
      where: where?.call(UserModuleProgress.t),
      orderBy: orderBy?.call(UserModuleProgress.t),
      orderByList: orderByList?.call(UserModuleProgress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserModuleProgress] matching the given query parameters.
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
  Future<UserModuleProgress?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModuleProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserModuleProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModuleProgressTable>? orderByList,
    _i1.Transaction? transaction,
    UserModuleProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserModuleProgress>(
      where: where?.call(UserModuleProgress.t),
      orderBy: orderBy?.call(UserModuleProgress.t),
      orderByList: orderByList?.call(UserModuleProgress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserModuleProgress] by its [id] or null if no such row exists.
  Future<UserModuleProgress?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    UserModuleProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserModuleProgress>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserModuleProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [UserModuleProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserModuleProgress>> insert(
    _i1.DatabaseSession session,
    List<UserModuleProgress> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserModuleProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserModuleProgress] and returns the inserted row.
  ///
  /// The returned [UserModuleProgress] will have its `id` field set.
  Future<UserModuleProgress> insertRow(
    _i1.DatabaseSession session,
    UserModuleProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserModuleProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserModuleProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserModuleProgress>> update(
    _i1.DatabaseSession session,
    List<UserModuleProgress> rows, {
    _i1.ColumnSelections<UserModuleProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserModuleProgress>(
      rows,
      columns: columns?.call(UserModuleProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserModuleProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserModuleProgress> updateRow(
    _i1.DatabaseSession session,
    UserModuleProgress row, {
    _i1.ColumnSelections<UserModuleProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserModuleProgress>(
      row,
      columns: columns?.call(UserModuleProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserModuleProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserModuleProgress?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserModuleProgressUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserModuleProgress>(
      id,
      columnValues: columnValues(UserModuleProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserModuleProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserModuleProgress>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserModuleProgressUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<UserModuleProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModuleProgressTable>? orderBy,
    _i1.OrderByListBuilder<UserModuleProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserModuleProgress>(
      columnValues: columnValues(UserModuleProgress.t.updateTable),
      where: where(UserModuleProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserModuleProgress.t),
      orderByList: orderByList?.call(UserModuleProgress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserModuleProgress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserModuleProgress>> delete(
    _i1.DatabaseSession session,
    List<UserModuleProgress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserModuleProgress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserModuleProgress].
  Future<UserModuleProgress> deleteRow(
    _i1.DatabaseSession session,
    UserModuleProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserModuleProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserModuleProgress>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserModuleProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserModuleProgress>(
      where: where(UserModuleProgress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserModuleProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserModuleProgress>(
      where: where?.call(UserModuleProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserModuleProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserModuleProgressTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserModuleProgress>(
      where: where(UserModuleProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UserModuleProgressAttachRowRepository {
  const UserModuleProgressAttachRowRepository._();

  /// Creates a relation between the given [UserModuleProgress] and [AppUser]
  /// by setting the [UserModuleProgress]'s foreign key `appUserId` to refer to the [AppUser].
  Future<void> appUser(
    _i1.DatabaseSession session,
    UserModuleProgress userModuleProgress,
    _i3.AppUser appUser, {
    _i1.Transaction? transaction,
  }) async {
    if (userModuleProgress.id == null) {
      throw ArgumentError.notNull('userModuleProgress.id');
    }
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }

    var $userModuleProgress = userModuleProgress.copyWith(
      appUserId: appUser.id,
    );
    await session.db.updateRow<UserModuleProgress>(
      $userModuleProgress,
      columns: [UserModuleProgress.t.appUserId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [UserModuleProgress] and [Organization]
  /// by setting the [UserModuleProgress]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    UserModuleProgress userModuleProgress,
    _i4.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (userModuleProgress.id == null) {
      throw ArgumentError.notNull('userModuleProgress.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $userModuleProgress = userModuleProgress.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<UserModuleProgress>(
      $userModuleProgress,
      columns: [UserModuleProgress.t.organizationId],
      transaction: transaction,
    );
  }
}
