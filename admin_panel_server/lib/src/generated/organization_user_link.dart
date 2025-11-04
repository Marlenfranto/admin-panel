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
import 'organization.dart' as _i2;
import 'app_user.dart' as _i3;

abstract class OrganizationUserLink
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  OrganizationUserLink._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.appUserId,
    this.appUser,
  });

  factory OrganizationUserLink({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int appUserId,
    _i3.AppUser? appUser,
  }) = _OrganizationUserLinkImpl;

  factory OrganizationUserLink.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return OrganizationUserLink(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i2.Organization.fromJson(
              (jsonSerialization['organization'] as Map<String, dynamic>)),
      appUserId: jsonSerialization['appUserId'] as int,
      appUser: jsonSerialization['appUser'] == null
          ? null
          : _i3.AppUser.fromJson(
              (jsonSerialization['appUser'] as Map<String, dynamic>)),
    );
  }

  static final t = OrganizationUserLinkTable();

  static const db = OrganizationUserLinkRepository._();

  @override
  int? id;

  int organizationId;

  _i2.Organization? organization;

  int appUserId;

  _i3.AppUser? appUser;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [OrganizationUserLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationUserLink copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? appUserId,
    _i3.AppUser? appUser,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'appUserId': appUserId,
      if (appUser != null) 'appUser': appUser?.toJsonForProtocol(),
    };
  }

  static OrganizationUserLinkInclude include({
    _i2.OrganizationInclude? organization,
    _i3.AppUserInclude? appUser,
  }) {
    return OrganizationUserLinkInclude._(
      organization: organization,
      appUser: appUser,
    );
  }

  static OrganizationUserLinkIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationUserLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationUserLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationUserLinkTable>? orderByList,
    OrganizationUserLinkInclude? include,
  }) {
    return OrganizationUserLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationUserLink.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrganizationUserLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationUserLinkImpl extends OrganizationUserLink {
  _OrganizationUserLinkImpl({
    int? id,
    required int organizationId,
    _i2.Organization? organization,
    required int appUserId,
    _i3.AppUser? appUser,
  }) : super._(
          id: id,
          organizationId: organizationId,
          organization: organization,
          appUserId: appUserId,
          appUser: appUser,
        );

  /// Returns a shallow copy of this [OrganizationUserLink]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationUserLink copyWith({
    Object? id = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? appUserId,
    Object? appUser = _Undefined,
  }) {
    return OrganizationUserLink(
      id: id is int? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      appUserId: appUserId ?? this.appUserId,
      appUser: appUser is _i3.AppUser? ? appUser : this.appUser?.copyWith(),
    );
  }
}

class OrganizationUserLinkTable extends _i1.Table<int?> {
  OrganizationUserLinkTable({super.tableRelation})
      : super(tableName: 'organization_user_link') {
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    appUserId = _i1.ColumnInt(
      'appUserId',
      this,
    );
  }

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnInt appUserId;

  _i3.AppUserTable? _appUser;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: OrganizationUserLink.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.AppUserTable get appUser {
    if (_appUser != null) return _appUser!;
    _appUser = _i1.createRelationTable(
      relationFieldName: 'appUser',
      field: OrganizationUserLink.t.appUserId,
      foreignField: _i3.AppUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AppUserTable(tableRelation: foreignTableRelation),
    );
    return _appUser!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        organizationId,
        appUserId,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'appUser') {
      return appUser;
    }
    return null;
  }
}

class OrganizationUserLinkInclude extends _i1.IncludeObject {
  OrganizationUserLinkInclude._({
    _i2.OrganizationInclude? organization,
    _i3.AppUserInclude? appUser,
  }) {
    _organization = organization;
    _appUser = appUser;
  }

  _i2.OrganizationInclude? _organization;

  _i3.AppUserInclude? _appUser;

  @override
  Map<String, _i1.Include?> get includes => {
        'organization': _organization,
        'appUser': _appUser,
      };

  @override
  _i1.Table<int?> get table => OrganizationUserLink.t;
}

class OrganizationUserLinkIncludeList extends _i1.IncludeList {
  OrganizationUserLinkIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationUserLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrganizationUserLink.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OrganizationUserLink.t;
}

class OrganizationUserLinkRepository {
  const OrganizationUserLinkRepository._();

  final attachRow = const OrganizationUserLinkAttachRowRepository._();

  /// Returns a list of [OrganizationUserLink]s matching the given query parameters.
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
  Future<List<OrganizationUserLink>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationUserLinkTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationUserLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationUserLinkTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationUserLinkInclude? include,
  }) async {
    return session.db.find<OrganizationUserLink>(
      where: where?.call(OrganizationUserLink.t),
      orderBy: orderBy?.call(OrganizationUserLink.t),
      orderByList: orderByList?.call(OrganizationUserLink.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [OrganizationUserLink] matching the given query parameters.
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
  Future<OrganizationUserLink?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationUserLinkTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationUserLinkTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationUserLinkTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationUserLinkInclude? include,
  }) async {
    return session.db.findFirstRow<OrganizationUserLink>(
      where: where?.call(OrganizationUserLink.t),
      orderBy: orderBy?.call(OrganizationUserLink.t),
      orderByList: orderByList?.call(OrganizationUserLink.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [OrganizationUserLink] by its [id] or null if no such row exists.
  Future<OrganizationUserLink?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    OrganizationUserLinkInclude? include,
  }) async {
    return session.db.findById<OrganizationUserLink>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [OrganizationUserLink]s in the list and returns the inserted rows.
  ///
  /// The returned [OrganizationUserLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<OrganizationUserLink>> insert(
    _i1.Session session,
    List<OrganizationUserLink> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<OrganizationUserLink>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [OrganizationUserLink] and returns the inserted row.
  ///
  /// The returned [OrganizationUserLink] will have its `id` field set.
  Future<OrganizationUserLink> insertRow(
    _i1.Session session,
    OrganizationUserLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrganizationUserLink>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationUserLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrganizationUserLink>> update(
    _i1.Session session,
    List<OrganizationUserLink> rows, {
    _i1.ColumnSelections<OrganizationUserLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrganizationUserLink>(
      rows,
      columns: columns?.call(OrganizationUserLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationUserLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrganizationUserLink> updateRow(
    _i1.Session session,
    OrganizationUserLink row, {
    _i1.ColumnSelections<OrganizationUserLinkTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrganizationUserLink>(
      row,
      columns: columns?.call(OrganizationUserLink.t),
      transaction: transaction,
    );
  }

  /// Deletes all [OrganizationUserLink]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrganizationUserLink>> delete(
    _i1.Session session,
    List<OrganizationUserLink> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrganizationUserLink>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrganizationUserLink].
  Future<OrganizationUserLink> deleteRow(
    _i1.Session session,
    OrganizationUserLink row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrganizationUserLink>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrganizationUserLink>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<OrganizationUserLinkTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrganizationUserLink>(
      where: where(OrganizationUserLink.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<OrganizationUserLinkTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrganizationUserLink>(
      where: where?.call(OrganizationUserLink.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class OrganizationUserLinkAttachRowRepository {
  const OrganizationUserLinkAttachRowRepository._();

  /// Creates a relation between the given [OrganizationUserLink] and [Organization]
  /// by setting the [OrganizationUserLink]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    OrganizationUserLink organizationUserLink,
    _i2.Organization organization, {
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
    await session.db.updateRow<OrganizationUserLink>(
      $organizationUserLink,
      columns: [OrganizationUserLink.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [OrganizationUserLink] and [AppUser]
  /// by setting the [OrganizationUserLink]'s foreign key `appUserId` to refer to the [AppUser].
  Future<void> appUser(
    _i1.Session session,
    OrganizationUserLink organizationUserLink,
    _i3.AppUser appUser, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationUserLink.id == null) {
      throw ArgumentError.notNull('organizationUserLink.id');
    }
    if (appUser.id == null) {
      throw ArgumentError.notNull('appUser.id');
    }

    var $organizationUserLink =
        organizationUserLink.copyWith(appUserId: appUser.id);
    await session.db.updateRow<OrganizationUserLink>(
      $organizationUserLink,
      columns: [OrganizationUserLink.t.appUserId],
      transaction: transaction,
    );
  }
}
