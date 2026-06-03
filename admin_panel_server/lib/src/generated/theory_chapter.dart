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
import 'quiz_question.dart' as _i3;
import 'video_metadata.dart' as _i4;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i5;

abstract class TheoryChapter
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TheoryChapter._({
    this.id,
    this.organizationId,
    this.organization,
    required this.chapterOrder,
    this.questions,
    String? title,
    this.description,
    this.thumbnailUrl,
    this.videoUrl,
    this.videoMetadata,
  }) : title = title ?? '';

  factory TheoryChapter({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required int chapterOrder,
    List<_i3.QuizQuestion>? questions,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i4.VideoMetadata? videoMetadata,
  }) = _TheoryChapterImpl;

  factory TheoryChapter.fromJson(Map<String, dynamic> jsonSerialization) {
    return TheoryChapter(
      id: jsonSerialization['id'] as int?,
      organizationId: jsonSerialization['organizationId'] as int?,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      chapterOrder: jsonSerialization['chapterOrder'] as int,
      questions: jsonSerialization['questions'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.QuizQuestion>>(
              jsonSerialization['questions'],
            ),
      title: jsonSerialization['title'] as String?,
      description: jsonSerialization['description'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      videoMetadata: jsonSerialization['videoMetadata'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.VideoMetadata>(
              jsonSerialization['videoMetadata'],
            ),
    );
  }

  static final t = TheoryChapterTable();

  static const db = TheoryChapterRepository._();

  @override
  int? id;

  int? organizationId;

  _i2.Organization? organization;

  int chapterOrder;

  List<_i3.QuizQuestion>? questions;

  /// Content fields are Dart-only (non-persistent). Required + defaulted so
  /// legacy callers see a non-null value. The upsert endpoint mirrors them
  /// into the default-locale TheoryChapterLocalization row; reads populate
  /// them via the hydrate* helpers.
  String title;

  String? description;

  String? thumbnailUrl;

  String? videoUrl;

  _i4.VideoMetadata? videoMetadata;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TheoryChapter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TheoryChapter copyWith({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    int? chapterOrder,
    List<_i3.QuizQuestion>? questions,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i4.VideoMetadata? videoMetadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TheoryChapter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'chapterOrder': chapterOrder,
      if (questions != null)
        'questions': questions?.toJson(valueToJson: (v) => v.toJson()),
      'title': title,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (videoMetadata != null) 'videoMetadata': videoMetadata?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TheoryChapter',
      if (id != null) 'id': id,
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'chapterOrder': chapterOrder,
      if (questions != null)
        'questions': questions?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      'title': title,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (videoMetadata != null)
        'videoMetadata': videoMetadata?.toJsonForProtocol(),
    };
  }

  static TheoryChapterInclude include({_i2.OrganizationInclude? organization}) {
    return TheoryChapterInclude._(organization: organization);
  }

  static TheoryChapterIncludeList includeList({
    _i1.WhereExpressionBuilder<TheoryChapterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterTable>? orderByList,
    TheoryChapterInclude? include,
  }) {
    return TheoryChapterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TheoryChapter.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TheoryChapter.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TheoryChapterImpl extends TheoryChapter {
  _TheoryChapterImpl({
    int? id,
    int? organizationId,
    _i2.Organization? organization,
    required int chapterOrder,
    List<_i3.QuizQuestion>? questions,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i4.VideoMetadata? videoMetadata,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         chapterOrder: chapterOrder,
         questions: questions,
         title: title,
         description: description,
         thumbnailUrl: thumbnailUrl,
         videoUrl: videoUrl,
         videoMetadata: videoMetadata,
       );

  /// Returns a shallow copy of this [TheoryChapter]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TheoryChapter copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
    Object? organization = _Undefined,
    int? chapterOrder,
    Object? questions = _Undefined,
    String? title,
    Object? description = _Undefined,
    Object? thumbnailUrl = _Undefined,
    Object? videoUrl = _Undefined,
    Object? videoMetadata = _Undefined,
  }) {
    return TheoryChapter(
      id: id is int? ? id : this.id,
      organizationId: organizationId is int?
          ? organizationId
          : this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      chapterOrder: chapterOrder ?? this.chapterOrder,
      questions: questions is List<_i3.QuizQuestion>?
          ? questions
          : this.questions?.map((e0) => e0.copyWith()).toList(),
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      videoUrl: videoUrl is String? ? videoUrl : this.videoUrl,
      videoMetadata: videoMetadata is _i4.VideoMetadata?
          ? videoMetadata
          : this.videoMetadata?.copyWith(),
    );
  }
}

class TheoryChapterUpdateTable extends _i1.UpdateTable<TheoryChapterTable> {
  TheoryChapterUpdateTable(super.table);

  _i1.ColumnValue<int, int> organizationId(int? value) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<int, int> chapterOrder(int value) => _i1.ColumnValue(
    table.chapterOrder,
    value,
  );

  _i1.ColumnValue<List<_i3.QuizQuestion>, List<_i3.QuizQuestion>> questions(
    List<_i3.QuizQuestion>? value,
  ) => _i1.ColumnValue(
    table.questions,
    value,
  );
}

class TheoryChapterTable extends _i1.Table<int?> {
  TheoryChapterTable({super.tableRelation})
    : super(tableName: 'theory_chapter') {
    updateTable = TheoryChapterUpdateTable(this);
    organizationId = _i1.ColumnInt(
      'organizationId',
      this,
    );
    chapterOrder = _i1.ColumnInt(
      'chapterOrder',
      this,
    );
    questions = _i1.ColumnSerializable<List<_i3.QuizQuestion>>(
      'questions',
      this,
    );
  }

  late final TheoryChapterUpdateTable updateTable;

  late final _i1.ColumnInt organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnInt chapterOrder;

  late final _i1.ColumnSerializable<List<_i3.QuizQuestion>> questions;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: TheoryChapter.t.organizationId,
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
    chapterOrder,
    questions,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class TheoryChapterInclude extends _i1.IncludeObject {
  TheoryChapterInclude._({_i2.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i2.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<int?> get table => TheoryChapter.t;
}

class TheoryChapterIncludeList extends _i1.IncludeList {
  TheoryChapterIncludeList._({
    _i1.WhereExpressionBuilder<TheoryChapterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TheoryChapter.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TheoryChapter.t;
}

class TheoryChapterRepository {
  const TheoryChapterRepository._();

  final attachRow = const TheoryChapterAttachRowRepository._();

  final detachRow = const TheoryChapterDetachRowRepository._();

  /// Returns a list of [TheoryChapter]s matching the given query parameters.
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
  Future<List<TheoryChapter>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterTable>? orderByList,
    _i1.Transaction? transaction,
    TheoryChapterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TheoryChapter>(
      where: where?.call(TheoryChapter.t),
      orderBy: orderBy?.call(TheoryChapter.t),
      orderByList: orderByList?.call(TheoryChapter.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TheoryChapter] matching the given query parameters.
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
  Future<TheoryChapter?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterTable>? where,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterTable>? orderByList,
    _i1.Transaction? transaction,
    TheoryChapterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TheoryChapter>(
      where: where?.call(TheoryChapter.t),
      orderBy: orderBy?.call(TheoryChapter.t),
      orderByList: orderByList?.call(TheoryChapter.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TheoryChapter] by its [id] or null if no such row exists.
  Future<TheoryChapter?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TheoryChapterInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TheoryChapter>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TheoryChapter]s in the list and returns the inserted rows.
  ///
  /// The returned [TheoryChapter]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TheoryChapter>> insert(
    _i1.DatabaseSession session,
    List<TheoryChapter> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TheoryChapter>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TheoryChapter] and returns the inserted row.
  ///
  /// The returned [TheoryChapter] will have its `id` field set.
  Future<TheoryChapter> insertRow(
    _i1.DatabaseSession session,
    TheoryChapter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TheoryChapter>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TheoryChapter]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TheoryChapter>> update(
    _i1.DatabaseSession session,
    List<TheoryChapter> rows, {
    _i1.ColumnSelections<TheoryChapterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TheoryChapter>(
      rows,
      columns: columns?.call(TheoryChapter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TheoryChapter]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TheoryChapter> updateRow(
    _i1.DatabaseSession session,
    TheoryChapter row, {
    _i1.ColumnSelections<TheoryChapterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TheoryChapter>(
      row,
      columns: columns?.call(TheoryChapter.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TheoryChapter] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TheoryChapter?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TheoryChapterUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TheoryChapter>(
      id,
      columnValues: columnValues(TheoryChapter.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TheoryChapter]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TheoryChapter>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TheoryChapterUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TheoryChapterTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterTable>? orderBy,
    _i1.OrderByListBuilder<TheoryChapterTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TheoryChapter>(
      columnValues: columnValues(TheoryChapter.t.updateTable),
      where: where(TheoryChapter.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TheoryChapter.t),
      orderByList: orderByList?.call(TheoryChapter.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TheoryChapter]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TheoryChapter>> delete(
    _i1.DatabaseSession session,
    List<TheoryChapter> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TheoryChapter>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TheoryChapter].
  Future<TheoryChapter> deleteRow(
    _i1.DatabaseSession session,
    TheoryChapter row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TheoryChapter>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TheoryChapter>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TheoryChapterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TheoryChapter>(
      where: where(TheoryChapter.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TheoryChapter>(
      where: where?.call(TheoryChapter.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TheoryChapter] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TheoryChapterTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TheoryChapter>(
      where: where(TheoryChapter.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TheoryChapterAttachRowRepository {
  const TheoryChapterAttachRowRepository._();

  /// Creates a relation between the given [TheoryChapter] and [Organization]
  /// by setting the [TheoryChapter]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    TheoryChapter theoryChapter,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (theoryChapter.id == null) {
      throw ArgumentError.notNull('theoryChapter.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $theoryChapter = theoryChapter.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<TheoryChapter>(
      $theoryChapter,
      columns: [TheoryChapter.t.organizationId],
      transaction: transaction,
    );
  }
}

class TheoryChapterDetachRowRepository {
  const TheoryChapterDetachRowRepository._();

  /// Detaches the relation between this [TheoryChapter] and the [Organization] set in `organization`
  /// by setting the [TheoryChapter]'s foreign key `organizationId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> organization(
    _i1.DatabaseSession session,
    TheoryChapter theoryChapter, {
    _i1.Transaction? transaction,
  }) async {
    if (theoryChapter.id == null) {
      throw ArgumentError.notNull('theoryChapter.id');
    }

    var $theoryChapter = theoryChapter.copyWith(organizationId: null);
    await session.db.updateRow<TheoryChapter>(
      $theoryChapter,
      columns: [TheoryChapter.t.organizationId],
      transaction: transaction,
    );
  }
}
