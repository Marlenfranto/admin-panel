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
import 'role.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'tools.dart' as _i4;
import 'organization_user_link.dart' as _i5;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i6;

abstract class AppUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AppUser._({
    this.id,
    required this.userInfoId,
    this.userInfo,
    _i2.Role? role,
    required this.tools,
    this.organizations,
  }) : role = role ?? _i2.Role.User;

  factory AppUser({
    int? id,
    required int userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    required _i4.Tools tools,
    List<_i5.OrganizationUserLink>? organizations,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      userInfoId: jsonSerialization['userInfoId'] as int,
      userInfo: jsonSerialization['userInfo'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.UserInfo>(
              jsonSerialization['userInfo'],
            ),
      role: jsonSerialization['role'] == null
          ? null
          : _i2.Role.fromJson((jsonSerialization['role'] as String)),
      tools: _i6.Protocol().deserialize<_i4.Tools>(jsonSerialization['tools']),
      organizations: jsonSerialization['organizations'] == null
          ? null
          : _i6.Protocol().deserialize<List<_i5.OrganizationUserLink>>(
              jsonSerialization['organizations'],
            ),
    );
  }

  static final t = AppUserTable();

  static const db = AppUserRepository._();

  @override
  int? id;

  int userInfoId;

  _i3.UserInfo? userInfo;

  _i2.Role role;

  _i4.Tools tools;

  List<_i5.OrganizationUserLink>? organizations;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    int? id,
    int? userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    _i4.Tools? tools,
    List<_i5.OrganizationUserLink>? organizations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJson(),
      'role': role.toJson(),
      'tools': tools.toJson(),
      if (organizations != null)
        'organizations': organizations?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'userInfoId': userInfoId,
      if (userInfo != null) 'userInfo': userInfo?.toJsonForProtocol(),
      'role': role.toJson(),
      'tools': tools.toJsonForProtocol(),
      if (organizations != null)
        'organizations': organizations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static AppUserInclude include({
    _i3.UserInfoInclude? userInfo,
    _i5.OrganizationUserLinkIncludeList? organizations,
  }) {
    return AppUserInclude._(
      userInfo: userInfo,
      organizations: organizations,
    );
  }

  static AppUserIncludeList includeList({
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    AppUserInclude? include,
  }) {
    return AppUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AppUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    required int userInfoId,
    _i3.UserInfo? userInfo,
    _i2.Role? role,
    required _i4.Tools tools,
    List<_i5.OrganizationUserLink>? organizations,
  }) : super._(
         id: id,
         userInfoId: userInfoId,
         userInfo: userInfo,
         role: role,
         tools: tools,
         organizations: organizations,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    int? userInfoId,
    Object? userInfo = _Undefined,
    _i2.Role? role,
    _i4.Tools? tools,
    Object? organizations = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      userInfoId: userInfoId ?? this.userInfoId,
      userInfo: userInfo is _i3.UserInfo?
          ? userInfo
          : this.userInfo?.copyWith(),
      role: role ?? this.role,
      tools: tools ?? this.tools.copyWith(),
      organizations: organizations is List<_i5.OrganizationUserLink>?
          ? organizations
          : this.organizations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class AppUserUpdateTable extends _i1.UpdateTable<AppUserTable> {
  AppUserUpdateTable(super.table);

  _i1.ColumnValue<int, int> userInfoId(int value) => _i1.ColumnValue(
    table.userInfoId,
    value,
  );

  _i1.ColumnValue<_i2.Role, _i2.Role> role(_i2.Role value) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<_i4.Tools, _i4.Tools> tools(_i4.Tools value) =>
      _i1.ColumnValue(
        table.tools,
        value,
      );
}

class AppUserTable extends _i1.Table<int?> {
  AppUserTable({super.tableRelation}) : super(tableName: 'app_user') {
    updateTable = AppUserUpdateTable(this);
    userInfoId = _i1.ColumnInt(
      'userInfoId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
      hasDefault: true,
    );
    tools = _i1.ColumnSerializable<_i4.Tools>(
      'tools',
      this,
    );
  }

  late final AppUserUpdateTable updateTable;

  late final _i1.ColumnInt userInfoId;

  _i3.UserInfoTable? _userInfo;

  late final _i1.ColumnEnum<_i2.Role> role;

  late final _i1.ColumnSerializable<_i4.Tools> tools;

  _i5.OrganizationUserLinkTable? ___organizations;

  _i1.ManyRelation<_i5.OrganizationUserLinkTable>? _organizations;

  _i3.UserInfoTable get userInfo {
    if (_userInfo != null) return _userInfo!;
    _userInfo = _i1.createRelationTable(
      relationFieldName: 'userInfo',
      field: AppUser.t.userInfoId,
      foreignField: _i3.UserInfo.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.UserInfoTable(tableRelation: foreignTableRelation),
    );
    return _userInfo!;
  }

  _i5.OrganizationUserLinkTable get __organizations {
    if (___organizations != null) return ___organizations!;
    ___organizations = _i1.createRelationTable(
      relationFieldName: '__organizations',
      field: AppUser.t.id,
      foreignField: _i5.OrganizationUserLink.t.appUserId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.OrganizationUserLinkTable(tableRelation: foreignTableRelation),
    );
    return ___organizations!;
  }

  _i1.ManyRelation<_i5.OrganizationUserLinkTable> get organizations {
    if (_organizations != null) return _organizations!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'organizations',
      field: AppUser.t.id,
      foreignField: _i5.OrganizationUserLink.t.appUserId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.OrganizationUserLinkTable(tableRelation: foreignTableRelation),
    );
    _organizations = _i1.ManyRelation<_i5.OrganizationUserLinkTable>(
      tableWithRelations: relationTable,
      table: _i5.OrganizationUserLinkTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _organizations!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userInfoId,
    role,
    tools,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'userInfo') {
      return userInfo;
    }
    if (relationField == 'organizations') {
      return __organizations;
    }
    return null;
  }
}

class AppUserInclude extends _i1.IncludeObject {
  AppUserInclude._({
    _i3.UserInfoInclude? userInfo,
    _i5.OrganizationUserLinkIncludeList? organizations,
  }) {
    _userInfo = userInfo;
    _organizations = organizations;
  }

  _i3.UserInfoInclude? _userInfo;

  _i5.OrganizationUserLinkIncludeList? _organizations;

  @override
  Map<String, _i1.Include?> get includes => {
    'userInfo': _userInfo,
    'organizations': _organizations,
  };

  @override
  _i1.Table<int?> get table => AppUser.t;
}

class AppUserIncludeList extends _i1.IncludeList {
  AppUserIncludeList._({
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AppUser.t;
}

class AppUserRepository {
  const AppUserRepository._();

  final attach = const AppUserAttachRepository._();

  final attachRow = const AppUserAttachRowRepository._();

  final detach = const AppUserDetachRepository._();

  final detachRow = const AppUserDetachRowRepository._();

  /// Returns a list of [AppUser]s matching the given query parameters.
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
  Future<List<AppUser>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    _i1.Transaction? transaction,
    AppUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppUser] matching the given query parameters.
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
  Future<AppUser?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    _i1.Transaction? transaction,
    AppUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppUser>(
      where: where?.call(AppUser.t),
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppUser] by its [id] or null if no such row exists.
  Future<AppUser?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AppUserInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppUser>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppUser]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AppUser>> insert(
    _i1.DatabaseSession session,
    List<AppUser> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AppUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AppUser] and returns the inserted row.
  ///
  /// The returned [AppUser] will have its `id` field set.
  Future<AppUser> insertRow(
    _i1.DatabaseSession session,
    AppUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AppUser>> update(
    _i1.DatabaseSession session,
    List<AppUser> rows, {
    _i1.ColumnSelections<AppUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AppUser>(
      rows,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUser> updateRow(
    _i1.DatabaseSession session,
    AppUser row, {
    _i1.ColumnSelections<AppUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUser>(
      row,
      columns: columns?.call(AppUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppUser?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AppUser>(
      id,
      columnValues: columnValues(AppUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AppUser>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AppUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<AppUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppUserTable>? orderBy,
    _i1.OrderByListBuilder<AppUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AppUser>(
      columnValues: columnValues(AppUser.t.updateTable),
      where: where(AppUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUser.t),
      orderByList: orderByList?.call(AppUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AppUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AppUser>> delete(
    _i1.DatabaseSession session,
    List<AppUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AppUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AppUser].
  Future<AppUser> deleteRow(
    _i1.DatabaseSession session,
    AppUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AppUser>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AppUser>(
      where: where(AppUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AppUser>(
      where: where?.call(AppUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppUser] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppUserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppUser>(
      where: where(AppUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AppUserAttachRepository {
  const AppUserAttachRepository._();

  /// Creates a relation between this [AppUser] and the given [OrganizationUserLink]s
  /// by setting each [OrganizationUserLink]'s foreign key `appUserId` to refer to this [AppUser].
  Future<void> organizations(
    _i1.DatabaseSession session,
    AppUser appUser,
    List<_i5.OrganizationUserLink> organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }

    var $organizationUserLink = organizationUserLink
        .map((e) => e.copyWith(appUserId: appUser.id))
        .toList();
    await session.db.update<_i5.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i5.OrganizationUserLink.t.appUserId],
      transaction: transaction,
    );
  }
}

class AppUserAttachRowRepository {
  const AppUserAttachRowRepository._();

  /// Creates a relation between the given [AppUser] and [UserInfo]
  /// by setting the [AppUser]'s foreign key `userInfoId` to refer to the [UserInfo].
  Future<void> userInfo(
    _i1.DatabaseSession session,
    AppUser appUser,
    _i3.UserInfo userInfo, {
    _i1.Transaction? transaction,
  }) async {
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }
    if (userInfo.id == null) {
      throw ArgumentError.notNull('userInfo.id');
    }

    var $appUser = appUser.copyWith(userInfoId: userInfo.id);
    await session.db.updateRow<AppUser>(
      $appUser,
      columns: [AppUser.t.userInfoId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [AppUser] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `appUserId` to refer to this [AppUser].
  Future<void> organizations(
    _i1.DatabaseSession session,
    AppUser appUser,
    _i5.OrganizationUserLink organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.id == null) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }

    var $organizationUserLink = organizationUserLink.copyWith(
      appUserId: appUser.id,
    );
    await session.db.updateRow<_i5.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i5.OrganizationUserLink.t.appUserId],
      transaction: transaction,
    );
  }
}

class AppUserDetachRepository {
  const AppUserDetachRepository._();

  /// Detaches the relation between this [AppUser] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `appUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organizations(
    _i1.DatabaseSession session,
    List<_i5.OrganizationUserLink> organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }

    var $organizationUserLink = organizationUserLink
        .map((e) => e.copyWith(appUserId: null))
        .toList();
    await session.db.update<_i5.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i5.OrganizationUserLink.t.appUserId],
      transaction: transaction,
    );
  }
}

class AppUserDetachRowRepository {
  const AppUserDetachRowRepository._();

  /// Detaches the relation between this [AppUser] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `appUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organizations(
    _i1.DatabaseSession session,
    _i5.OrganizationUserLink organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.id == null) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }

    var $organizationUserLink = organizationUserLink.copyWith(appUserId: null);
    await session.db.updateRow<_i5.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i5.OrganizationUserLink.t.appUserId],
      transaction: transaction,
    );
  }
}
