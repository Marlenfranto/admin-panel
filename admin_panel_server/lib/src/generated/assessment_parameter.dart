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
import 'feedback_level.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class AssessmentParameter
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AssessmentParameter._({
    this.id,
    this.organizationId,
    this.organization,
    required this.paramId,
    required this.name,
    required this.description,
    required this.maxScore,
    required this.logic,
    required this.feedbackLow,
    required this.feedbackMedium,
    required this.feedbackHigh,
  });

  factory AssessmentParameter({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required String name,
    required String description,
    required int maxScore,
    required String logic,
    required _i3.FeedbackLevel feedbackLow,
    required _i3.FeedbackLevel feedbackMedium,
    required _i3.FeedbackLevel feedbackHigh,
  }) = _AssessmentParameterImpl;

  factory AssessmentParameter.fromJson(Map<String, dynamic> jsonSerialization) {
    return AssessmentParameter(
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
      logic: jsonSerialization['logic'] as String,
      feedbackLow: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackLow'],
      ),
      feedbackMedium: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackMedium'],
      ),
      feedbackHigh: _i4.Protocol().deserialize<_i3.FeedbackLevel>(
        jsonSerialization['feedbackHigh'],
      ),
    );
  }

  static final t = AssessmentParameterTable();

  static const db = AssessmentParameterRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  String paramId;

  String name;

  String description;

  int maxScore;

  String logic;

  _i3.FeedbackLevel feedbackLow;

  _i3.FeedbackLevel feedbackMedium;

  _i3.FeedbackLevel feedbackHigh;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AssessmentParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AssessmentParameter copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    String? paramId,
    String? name,
    String? description,
    int? maxScore,
    String? logic,
    _i3.FeedbackLevel? feedbackLow,
    _i3.FeedbackLevel? feedbackMedium,
    _i3.FeedbackLevel? feedbackHigh,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AssessmentParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'paramId': paramId,
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'logic': logic,
      'feedbackLow': feedbackLow.toJson(),
      'feedbackMedium': feedbackMedium.toJson(),
      'feedbackHigh': feedbackHigh.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AssessmentParameter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'paramId': paramId,
      'name': name,
      'description': description,
      'maxScore': maxScore,
      'logic': logic,
      'feedbackLow': feedbackLow.toJsonForProtocol(),
      'feedbackMedium': feedbackMedium.toJsonForProtocol(),
      'feedbackHigh': feedbackHigh.toJsonForProtocol(),
    };
  }

  static AssessmentParameterInclude include({
    _i2.OrganizationInclude? organization,
  }) {
    return AssessmentParameterInclude._(organization: organization);
  }

  static AssessmentParameterIncludeList includeList({
    _i1.WhereExpressionBuilder<AssessmentParameterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterTable>? orderByList,
    AssessmentParameterInclude? include,
  }) {
    return AssessmentParameterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentParameter.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AssessmentParameter.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AssessmentParameterImpl extends AssessmentParameter {
  _AssessmentParameterImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required String paramId,
    required String name,
    required String description,
    required int maxScore,
    required String logic,
    required _i3.FeedbackLevel feedbackLow,
    required _i3.FeedbackLevel feedbackMedium,
    required _i3.FeedbackLevel feedbackHigh,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         paramId: paramId,
         name: name,
         description: description,
         maxScore: maxScore,
         logic: logic,
         feedbackLow: feedbackLow,
         feedbackMedium: feedbackMedium,
         feedbackHigh: feedbackHigh,
       );

  /// Returns a shallow copy of this [AssessmentParameter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AssessmentParameter copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    String? paramId,
    String? name,
    String? description,
    int? maxScore,
    String? logic,
    _i3.FeedbackLevel? feedbackLow,
    _i3.FeedbackLevel? feedbackMedium,
    _i3.FeedbackLevel? feedbackHigh,
  }) {
    return AssessmentParameter(
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
      logic: logic ?? this.logic,
      feedbackLow: feedbackLow ?? this.feedbackLow.copyWith(),
      feedbackMedium: feedbackMedium ?? this.feedbackMedium.copyWith(),
      feedbackHigh: feedbackHigh ?? this.feedbackHigh.copyWith(),
    );
  }
}

class AssessmentParameterUpdateTable
    extends _i1.UpdateTable<AssessmentParameterTable> {
  AssessmentParameterUpdateTable(super.table);

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

  _i1.ColumnValue<String, String> logic(String value) => _i1.ColumnValue(
    table.logic,
    value,
  );

  _i1.ColumnValue<_i3.FeedbackLevel, _i3.FeedbackLevel> feedbackLow(
    _i3.FeedbackLevel value,
  ) => _i1.ColumnValue(
    table.feedbackLow,
    value,
  );

  _i1.ColumnValue<_i3.FeedbackLevel, _i3.FeedbackLevel> feedbackMedium(
    _i3.FeedbackLevel value,
  ) => _i1.ColumnValue(
    table.feedbackMedium,
    value,
  );

  _i1.ColumnValue<_i3.FeedbackLevel, _i3.FeedbackLevel> feedbackHigh(
    _i3.FeedbackLevel value,
  ) => _i1.ColumnValue(
    table.feedbackHigh,
    value,
  );
}

class AssessmentParameterTable extends _i1.Table<int?> {
  AssessmentParameterTable({super.tableRelation})
    : super(tableName: 'assessment_parameter') {
    updateTable = AssessmentParameterUpdateTable(this);
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
    logic = _i1.ColumnString(
      'logic',
      this,
    );
    feedbackLow = _i1.ColumnSerializable<_i3.FeedbackLevel>(
      'feedbackLow',
      this,
    );
    feedbackMedium = _i1.ColumnSerializable<_i3.FeedbackLevel>(
      'feedbackMedium',
      this,
    );
    feedbackHigh = _i1.ColumnSerializable<_i3.FeedbackLevel>(
      'feedbackHigh',
      this,
    );
  }

  late final AssessmentParameterUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnString paramId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt maxScore;

  late final _i1.ColumnString logic;

  late final _i1.ColumnSerializable<_i3.FeedbackLevel> feedbackLow;

  late final _i1.ColumnSerializable<_i3.FeedbackLevel> feedbackMedium;

  late final _i1.ColumnSerializable<_i3.FeedbackLevel> feedbackHigh;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: AssessmentParameter.t.organizationId,
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
    logic,
    feedbackLow,
    feedbackMedium,
    feedbackHigh,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class AssessmentParameterInclude extends _i1.IncludeObject {
  AssessmentParameterInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => AssessmentParameter.t;
}

class AssessmentParameterIncludeList extends _i1.IncludeList {
  AssessmentParameterIncludeList._({
    _i1.WhereExpressionBuilder<AssessmentParameterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AssessmentParameter.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AssessmentParameter.t;
}

class AssessmentParameterRepository {
  const AssessmentParameterRepository._();

  final attachRow = const AssessmentParameterAttachRowRepository._();

  final detachRow = const AssessmentParameterDetachRowRepository._();

  /// Returns a list of [AssessmentParameter]s matching the given query parameters.
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
  Future<List<AssessmentParameter>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AssessmentParameter>(
      where: where?.call(AssessmentParameter.t),
      orderBy: orderBy?.call(AssessmentParameter.t),
      orderByList: orderByList?.call(AssessmentParameter.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AssessmentParameter] matching the given query parameters.
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
  Future<AssessmentParameter?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterTable>? where,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AssessmentParameterTable>? orderByList,
    _i1.Transaction? transaction,
    AssessmentParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AssessmentParameter>(
      where: where?.call(AssessmentParameter.t),
      orderBy: orderBy?.call(AssessmentParameter.t),
      orderByList: orderByList?.call(AssessmentParameter.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AssessmentParameter] by its [id] or null if no such row exists.
  Future<AssessmentParameter?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    AssessmentParameterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AssessmentParameter>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AssessmentParameter]s in the list and returns the inserted rows.
  ///
  /// The returned [AssessmentParameter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AssessmentParameter>> insert(
    _i1.DatabaseSession session,
    List<AssessmentParameter> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AssessmentParameter>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AssessmentParameter] and returns the inserted row.
  ///
  /// The returned [AssessmentParameter] will have its `id` field set.
  Future<AssessmentParameter> insertRow(
    _i1.DatabaseSession session,
    AssessmentParameter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AssessmentParameter>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentParameter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AssessmentParameter>> update(
    _i1.DatabaseSession session,
    List<AssessmentParameter> rows, {
    _i1.ColumnSelections<AssessmentParameterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AssessmentParameter>(
      rows,
      columns: columns?.call(AssessmentParameter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentParameter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AssessmentParameter> updateRow(
    _i1.DatabaseSession session,
    AssessmentParameter row, {
    _i1.ColumnSelections<AssessmentParameterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AssessmentParameter>(
      row,
      columns: columns?.call(AssessmentParameter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AssessmentParameter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AssessmentParameter?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AssessmentParameterUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AssessmentParameter>(
      id,
      columnValues: columnValues(AssessmentParameter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AssessmentParameter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AssessmentParameter>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AssessmentParameterUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AssessmentParameterTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AssessmentParameterTable>? orderBy,
    _i1.OrderByListBuilder<AssessmentParameterTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AssessmentParameter>(
      columnValues: columnValues(AssessmentParameter.t.updateTable),
      where: where(AssessmentParameter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AssessmentParameter.t),
      orderByList: orderByList?.call(AssessmentParameter.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AssessmentParameter]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AssessmentParameter>> delete(
    _i1.DatabaseSession session,
    List<AssessmentParameter> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AssessmentParameter>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [AssessmentParameter].
  Future<AssessmentParameter> deleteRow(
    _i1.DatabaseSession session,
    AssessmentParameter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AssessmentParameter>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AssessmentParameter>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentParameterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AssessmentParameter>(
      where: where(AssessmentParameter.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AssessmentParameterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AssessmentParameter>(
      where: where?.call(AssessmentParameter.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AssessmentParameter] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AssessmentParameterTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AssessmentParameter>(
      where: where(AssessmentParameter.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class AssessmentParameterAttachRowRepository {
  const AssessmentParameterAttachRowRepository._();

  /// Creates a relation between the given [AssessmentParameter] and [Organization]
  /// by setting the [AssessmentParameter]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    AssessmentParameter assessmentParameter,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentParameter.id == null) {
      throw ArgumentError.notNull('assessmentParameter.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $assessmentParameter = assessmentParameter.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<AssessmentParameter>(
      $assessmentParameter,
      columns: [AssessmentParameter.t.organizationId],
      transaction: transaction,
    );
  }
}

class AssessmentParameterDetachRowRepository {
  const AssessmentParameterDetachRowRepository._();

  /// Detaches the relation between this [AssessmentParameter] and the [Organization] set in `organization`
  /// by setting the [AssessmentParameter]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    AssessmentParameter assessmentParameter, {
    _i1.Transaction? transaction,
  }) async {
    if (assessmentParameter.id == null) {
      throw ArgumentError.notNull('assessmentParameter.id');
    }

    var $assessmentParameter = assessmentParameter.copyWith(
      organizationId: null,
    );
    await session.db.updateRow<AssessmentParameter>(
      $assessmentParameter,
      columns: [AssessmentParameter.t.organizationId],
      transaction: transaction,
    );
  }
}
