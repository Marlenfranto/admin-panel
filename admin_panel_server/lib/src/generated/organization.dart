/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'app_user.dart' as _i2;
import 'organization_user_link.dart' as _i3;

abstract class Organization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Organization._({
    this.id,
    required this.name,
    this.managerId,
    this.manager,
    this.users,
  });

  factory Organization({
    int? id,
    required String name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  }) = _OrganizationImpl;

  factory Organization.fromJson(Map<String, dynamic> jsonSerialization) {
    return Organization(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      managerId: jsonSerialization['managerId'] as int?,
      manager: jsonSerialization['manager'] == null
          ? null
          : _i2.AppUser.fromJson(
              (jsonSerialization['manager'] as Map<String, dynamic>)),
      users: (jsonSerialization['users'] as List?)
          ?.map((e) =>
              _i3.OrganizationUserLink.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  static final t = OrganizationTable();

  static const db = OrganizationRepository._();

  @override
  int? id;

  String name;

  int? managerId;

  _i2.AppUser? manager;

  List<_i3.OrganizationUserLink>? users;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Organization copyWith({
    int? id,
    String? name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (managerId != null) 'managerId': managerId,
      if (manager != null) 'manager': manager?.toJson(),
      if (users != null) 'users': users?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (managerId != null) 'managerId': managerId,
      if (manager != null) 'manager': manager?.toJsonForProtocol(),
      if (users != null)
        'users': users?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static OrganizationInclude include({
    _i2.AppUserInclude? manager,
    _i3.OrganizationUserLinkIncludeList? users,
  }) {
    return OrganizationInclude._(
      manager: manager,
      users: users,
    );
  }

  static OrganizationIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    OrganizationInclude? include,
  }) {
    return OrganizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Organization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Organization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationImpl extends Organization {
  _OrganizationImpl({
    int? id,
    required String name,
    int? managerId,
    _i2.AppUser? manager,
    List<_i3.OrganizationUserLink>? users,
  }) : super._(
          id: id,
          name: name,
          managerId: managerId,
          manager: manager,
          users: users,
        );

  /// Returns a shallow copy of this [Organization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Organization copyWith({
    Object? id = _Undefined,
    String? name,
    Object? managerId = _Undefined,
    Object? manager = _Undefined,
    Object? users = _Undefined,
  }) {
    return Organization(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      managerId: managerId is int? ? managerId : this.managerId,
      manager: manager is _i2.AppUser? ? manager : this.manager?.copyWith(),
      users: users is List<_i3.OrganizationUserLink>?
          ? users
          : this.users?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class OrganizationTable extends _i1.Table<int?> {
  OrganizationTable({super.tableRelation}) : super(tableName: 'organization') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    managerId = _i1.ColumnInt(
      'managerId',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt managerId;

  _i2.AppUserTable? _manager;

  _i3.OrganizationUserLinkTable? ___users;

  _i1.ManyRelation<_i3.OrganizationUserLinkTable>? _users;

  _i2.AppUserTable get manager {
    if (_manager != null) return _manager!;
    _manager = _i1.createRelationTable(
      relationFieldName: 'manager',
      field: Organization.t.managerId,
      foreignField: _i2.AppUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AppUserTable(tableRelation: foreignTableRelation),
    );
    return _manager!;
  }

  _i3.OrganizationUserLinkTable get __users {
    if (___users != null) return ___users!;
    ___users = _i1.createRelationTable(
      relationFieldName: '__users',
      field: Organization.t.id,
      foreignField: _i3.OrganizationUserLink.t.organizationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationUserLinkTable(tableRelation: foreignTableRelation),
    );
    return ___users!;
  }

  _i1.ManyRelation<_i3.OrganizationUserLinkTable> get users {
    if (_users != null) return _users!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'users',
      field: Organization.t.id,
      foreignField: _i3.OrganizationUserLink.t.organizationId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationUserLinkTable(tableRelation: foreignTableRelation),
    );
    _users = _i1.ManyRelation<_i3.OrganizationUserLinkTable>(
      tableWithRelations: relationTable,
      table: _i3.OrganizationUserLinkTable(
          tableRelation: relationTable.tableRelation!.lastRelation),
    );
    return _users!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        managerId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'manager') {
      return manager;
    }
    if (relationField == 'users') {
      return __users;
    }
    return null;
  }
}

class OrganizationInclude extends _i1.IncludeObject {
  OrganizationInclude._({
    _i2.AppUserInclude? manager,
    _i3.OrganizationUserLinkIncludeList? users,
  }) {
    _manager = manager;
    _users = users;
  }

  _i2.AppUserInclude? _manager;

  _i3.OrganizationUserLinkIncludeList? _users;

  @override
  Map<String, _i1.Include?> get includes => {
        'manager': _manager,
        'users': _users,
      };

  @override
  _i1.Table<int?> get table => Organization.t;
}

class OrganizationIncludeList extends _i1.IncludeList {
  OrganizationIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Organization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Organization.t;
}

class OrganizationRepository {
  const OrganizationRepository._();

  final attach = const OrganizationAttachRepository._();

  final attachRow = const OrganizationAttachRowRepository._();

  final detach = const OrganizationDetachRepository._();

  final detachRow = const OrganizationDetachRowRepository._();

  /// Returns a list of [Organization]s matching the given query parameters.
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
  Future<List<Organization>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationInclude? include,
  }) async {
    return session.db.find<Organization>(
      where: where?.call(Organization.t),
      orderBy: orderBy?.call(Organization.t),
      orderByList: orderByList?.call(Organization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [Organization] matching the given query parameters.
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
  Future<Organization?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationInclude? include,
  }) async {
    return session.db.findFirstRow<Organization>(
      where: where?.call(Organization.t),
      orderBy: orderBy?.call(Organization.t),
      orderByList: orderByList?.call(Organization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [Organization] by its [id] or null if no such row exists.
  Future<Organization?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    OrganizationInclude? include,
  }) async {
    return session.db.findById<Organization>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [Organization]s in the list and returns the inserted rows.
  ///
  /// The returned [Organization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Organization>> insert(
    _i1.Session session,
    List<Organization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Organization>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Organization] and returns the inserted row.
  ///
  /// The returned [Organization] will have its `id` field set.
  Future<Organization> insertRow(
    _i1.Session session,
    Organization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Organization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Organization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Organization>> update(
    _i1.Session session,
    List<Organization> rows, {
    _i1.ColumnSelections<OrganizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Organization>(
      rows,
      columns: columns?.call(Organization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Organization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Organization> updateRow(
    _i1.Session session,
    Organization row, {
    _i1.ColumnSelections<OrganizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Organization>(
      row,
      columns: columns?.call(Organization.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Organization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Organization>> delete(
    _i1.Session session,
    List<Organization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Organization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Organization].
  Future<Organization> deleteRow(
    _i1.Session session,
    Organization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Organization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Organization>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Organization>(
      where: where(Organization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Organization>(
      where: where?.call(Organization.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class OrganizationAttachRepository {
  const OrganizationAttachRepository._();

  /// Creates a relation between this [Organization] and the given [OrganizationUserLink]s
  /// by setting each [OrganizationUserLink]'s foreign key `organizationId` to refer to this [Organization].
  Future<void> users(
    _i1.Session session,
    Organization organization,
    List<_i3.OrganizationUserLink> organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $organizationUserLink = organizationUserLink
        .map((e) => e.copyWith(organizationId: organization.id))
        .toList();
    await session.db.update<_i3.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i3.OrganizationUserLink.t.organizationId],
      transaction: transaction,
    );
  }
}

class OrganizationAttachRowRepository {
  const OrganizationAttachRowRepository._();

  /// Creates a relation between the given [Organization] and [AppUser]
  /// by setting the [Organization]'s foreign key `managerId` to refer to the [AppUser].
  Future<void> manager(
    _i1.Session session,
    Organization organization,
    _i2.AppUser manager, {
    _i1.Transaction? transaction,
  }) async {
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }
    if (manager.id == null) {
      throw ArgumentError.notNull('manager.id');
    }

    var $organization = organization.copyWith(managerId: manager.id);
    await session.db.updateRow<Organization>(
      $organization,
      columns: [Organization.t.managerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Organization] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `organizationId` to refer to this [Organization].
  Future<void> users(
    _i1.Session session,
    Organization organization,
    _i3.OrganizationUserLink organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.id == null) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $organizationUserLink =
        organizationUserLink.copyWith(organizationId: organization.id);
    await session.db.updateRow<_i3.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i3.OrganizationUserLink.t.organizationId],
      transaction: transaction,
    );
  }
}

class OrganizationDetachRepository {
  const OrganizationDetachRepository._();

  /// Detaches the relation between this [Organization] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> users(
    _i1.Session session,
    List<_i3.OrganizationUserLink> organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.any((e) => e.id == null)) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }

    var $organizationUserLink = organizationUserLink
        .map((e) => e.copyWith(organizationId: null))
        .toList();
    await session.db.update<_i3.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i3.OrganizationUserLink.t.organizationId],
      transaction: transaction,
    );
  }
}

class OrganizationDetachRowRepository {
  const OrganizationDetachRowRepository._();

  /// Detaches the relation between this [Organization] and the [AppUser] set in `manager`
  /// by setting the [Organization]'s foreign key `managerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> manager(
    _i1.Session session,
    Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $organization = organization.copyWith(managerId: null);
    await session.db.updateRow<Organization>(
      $organization,
      columns: [Organization.t.managerId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Organization] and the given [OrganizationUserLink]
  /// by setting the [OrganizationUserLink]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> users(
    _i1.Session session,
    _i3.OrganizationUserLink organizationUserLink, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.id == null) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }

    var $organizationUserLink =
        organizationUserLink.copyWith(organizationId: null);
    await session.db.updateRow<_i3.OrganizationUserLink>(
      $organizationUserLink,
      columns: [_i3.OrganizationUserLink.t.organizationId],
      transaction: transaction,
    );
  }
}
