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
import 'theory_chapter.dart' as _i2;
import 'video_metadata.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class TheoryChapterLocalization
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  TheoryChapterLocalization._({
    this.id,
    required this.chapterId,
    this.chapter,
    required this.localeKey,
    required this.title,
    this.description,
    this.thumbnailUrl,
    this.videoUrl,
    this.videoMetadata,
  });

  factory TheoryChapterLocalization({
    int? id,
    required int chapterId,
    _i2.TheoryChapter? chapter,
    required String localeKey,
    required String title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i3.VideoMetadata? videoMetadata,
  }) = _TheoryChapterLocalizationImpl;

  factory TheoryChapterLocalization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TheoryChapterLocalization(
      id: jsonSerialization['id'] as int?,
      chapterId: jsonSerialization['chapterId'] as int,
      chapter: jsonSerialization['chapter'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.TheoryChapter>(
              jsonSerialization['chapter'],
            ),
      localeKey: jsonSerialization['localeKey'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      videoUrl: jsonSerialization['videoUrl'] as String?,
      videoMetadata: jsonSerialization['videoMetadata'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.VideoMetadata>(
              jsonSerialization['videoMetadata'],
            ),
    );
  }

  static final t = TheoryChapterLocalizationTable();

  static const db = TheoryChapterLocalizationRepository._();

  @override
  int? id;

  int chapterId;

  _i2.TheoryChapter? chapter;

  String localeKey;

  String title;

  String? description;

  String? thumbnailUrl;

  String? videoUrl;

  _i3.VideoMetadata? videoMetadata;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [TheoryChapterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TheoryChapterLocalization copyWith({
    int? id,
    int? chapterId,
    _i2.TheoryChapter? chapter,
    String? localeKey,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i3.VideoMetadata? videoMetadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TheoryChapterLocalization',
      if (id != null) 'id': id,
      'chapterId': chapterId,
      if (chapter != null) 'chapter': chapter?.toJson(),
      'localeKey': localeKey,
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
      '__className__': 'TheoryChapterLocalization',
      if (id != null) 'id': id,
      'chapterId': chapterId,
      if (chapter != null) 'chapter': chapter?.toJsonForProtocol(),
      'localeKey': localeKey,
      'title': title,
      if (description != null) 'description': description,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (videoMetadata != null)
        'videoMetadata': videoMetadata?.toJsonForProtocol(),
    };
  }

  static TheoryChapterLocalizationInclude include({
    _i2.TheoryChapterInclude? chapter,
  }) {
    return TheoryChapterLocalizationInclude._(chapter: chapter);
  }

  static TheoryChapterLocalizationIncludeList includeList({
    _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterLocalizationTable>? orderByList,
    TheoryChapterLocalizationInclude? include,
  }) {
    return TheoryChapterLocalizationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TheoryChapterLocalization.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TheoryChapterLocalization.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TheoryChapterLocalizationImpl extends TheoryChapterLocalization {
  _TheoryChapterLocalizationImpl({
    int? id,
    required int chapterId,
    _i2.TheoryChapter? chapter,
    required String localeKey,
    required String title,
    String? description,
    String? thumbnailUrl,
    String? videoUrl,
    _i3.VideoMetadata? videoMetadata,
  }) : super._(
         id: id,
         chapterId: chapterId,
         chapter: chapter,
         localeKey: localeKey,
         title: title,
         description: description,
         thumbnailUrl: thumbnailUrl,
         videoUrl: videoUrl,
         videoMetadata: videoMetadata,
       );

  /// Returns a shallow copy of this [TheoryChapterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TheoryChapterLocalization copyWith({
    Object? id = _Undefined,
    int? chapterId,
    Object? chapter = _Undefined,
    String? localeKey,
    String? title,
    Object? description = _Undefined,
    Object? thumbnailUrl = _Undefined,
    Object? videoUrl = _Undefined,
    Object? videoMetadata = _Undefined,
  }) {
    return TheoryChapterLocalization(
      id: id is int? ? id : this.id,
      chapterId: chapterId ?? this.chapterId,
      chapter: chapter is _i2.TheoryChapter?
          ? chapter
          : this.chapter?.copyWith(),
      localeKey: localeKey ?? this.localeKey,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      videoUrl: videoUrl is String? ? videoUrl : this.videoUrl,
      videoMetadata: videoMetadata is _i3.VideoMetadata?
          ? videoMetadata
          : this.videoMetadata?.copyWith(),
    );
  }
}

class TheoryChapterLocalizationUpdateTable
    extends _i1.UpdateTable<TheoryChapterLocalizationTable> {
  TheoryChapterLocalizationUpdateTable(super.table);

  _i1.ColumnValue<int, int> chapterId(int value) => _i1.ColumnValue(
    table.chapterId,
    value,
  );

  _i1.ColumnValue<String, String> localeKey(String value) => _i1.ColumnValue(
    table.localeKey,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> thumbnailUrl(String? value) =>
      _i1.ColumnValue(
        table.thumbnailUrl,
        value,
      );

  _i1.ColumnValue<String, String> videoUrl(String? value) => _i1.ColumnValue(
    table.videoUrl,
    value,
  );

  _i1.ColumnValue<_i3.VideoMetadata, _i3.VideoMetadata> videoMetadata(
    _i3.VideoMetadata? value,
  ) => _i1.ColumnValue(
    table.videoMetadata,
    value,
  );
}

class TheoryChapterLocalizationTable extends _i1.Table<int?> {
  TheoryChapterLocalizationTable({super.tableRelation})
    : super(tableName: 'theory_chapter_localization') {
    updateTable = TheoryChapterLocalizationUpdateTable(this);
    chapterId = _i1.ColumnInt(
      'chapterId',
      this,
    );
    localeKey = _i1.ColumnString(
      'localeKey',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
    videoUrl = _i1.ColumnString(
      'videoUrl',
      this,
    );
    videoMetadata = _i1.ColumnSerializable<_i3.VideoMetadata>(
      'videoMetadata',
      this,
    );
  }

  late final TheoryChapterLocalizationUpdateTable updateTable;

  late final _i1.ColumnInt chapterId;

  _i2.TheoryChapterTable? _chapter;

  late final _i1.ColumnString localeKey;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString thumbnailUrl;

  late final _i1.ColumnString videoUrl;

  late final _i1.ColumnSerializable<_i3.VideoMetadata> videoMetadata;

  _i2.TheoryChapterTable get chapter {
    if (_chapter != null) return _chapter!;
    _chapter = _i1.createRelationTable(
      relationFieldName: 'chapter',
      field: TheoryChapterLocalization.t.chapterId,
      foreignField: _i2.TheoryChapter.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.TheoryChapterTable(tableRelation: foreignTableRelation),
    );
    return _chapter!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    chapterId,
    localeKey,
    title,
    description,
    thumbnailUrl,
    videoUrl,
    videoMetadata,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'chapter') {
      return chapter;
    }
    return null;
  }
}

class TheoryChapterLocalizationInclude extends _i1.IncludeObject {
  TheoryChapterLocalizationInclude._({_i2.TheoryChapterInclude? chapter}) {
    _chapter = chapter;
  }

  _i2.TheoryChapterInclude? _chapter;

  @override
  Map<String, _i1.Include?> get includes => {'chapter': _chapter};

  @override
  _i1.Table<int?> get table => TheoryChapterLocalization.t;
}

class TheoryChapterLocalizationIncludeList extends _i1.IncludeList {
  TheoryChapterLocalizationIncludeList._({
    _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TheoryChapterLocalization.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TheoryChapterLocalization.t;
}

class TheoryChapterLocalizationRepository {
  const TheoryChapterLocalizationRepository._();

  final attachRow = const TheoryChapterLocalizationAttachRowRepository._();

  /// Returns a list of [TheoryChapterLocalization]s matching the given query parameters.
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
  Future<List<TheoryChapterLocalization>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    TheoryChapterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TheoryChapterLocalization>(
      where: where?.call(TheoryChapterLocalization.t),
      orderBy: orderBy?.call(TheoryChapterLocalization.t),
      orderByList: orderByList?.call(TheoryChapterLocalization.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TheoryChapterLocalization] matching the given query parameters.
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
  Future<TheoryChapterLocalization?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable>? where,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterLocalizationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TheoryChapterLocalizationTable>? orderByList,
    _i1.Transaction? transaction,
    TheoryChapterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TheoryChapterLocalization>(
      where: where?.call(TheoryChapterLocalization.t),
      orderBy: orderBy?.call(TheoryChapterLocalization.t),
      orderByList: orderByList?.call(TheoryChapterLocalization.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TheoryChapterLocalization] by its [id] or null if no such row exists.
  Future<TheoryChapterLocalization?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    TheoryChapterLocalizationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TheoryChapterLocalization>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TheoryChapterLocalization]s in the list and returns the inserted rows.
  ///
  /// The returned [TheoryChapterLocalization]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TheoryChapterLocalization>> insert(
    _i1.DatabaseSession session,
    List<TheoryChapterLocalization> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TheoryChapterLocalization>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TheoryChapterLocalization] and returns the inserted row.
  ///
  /// The returned [TheoryChapterLocalization] will have its `id` field set.
  Future<TheoryChapterLocalization> insertRow(
    _i1.DatabaseSession session,
    TheoryChapterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TheoryChapterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TheoryChapterLocalization]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TheoryChapterLocalization>> update(
    _i1.DatabaseSession session,
    List<TheoryChapterLocalization> rows, {
    _i1.ColumnSelections<TheoryChapterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TheoryChapterLocalization>(
      rows,
      columns: columns?.call(TheoryChapterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TheoryChapterLocalization]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TheoryChapterLocalization> updateRow(
    _i1.DatabaseSession session,
    TheoryChapterLocalization row, {
    _i1.ColumnSelections<TheoryChapterLocalizationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TheoryChapterLocalization>(
      row,
      columns: columns?.call(TheoryChapterLocalization.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TheoryChapterLocalization] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TheoryChapterLocalization?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TheoryChapterLocalizationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TheoryChapterLocalization>(
      id,
      columnValues: columnValues(TheoryChapterLocalization.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TheoryChapterLocalization]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TheoryChapterLocalization>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TheoryChapterLocalizationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TheoryChapterLocalizationTable>? orderBy,
    _i1.OrderByListBuilder<TheoryChapterLocalizationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TheoryChapterLocalization>(
      columnValues: columnValues(TheoryChapterLocalization.t.updateTable),
      where: where(TheoryChapterLocalization.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TheoryChapterLocalization.t),
      orderByList: orderByList?.call(TheoryChapterLocalization.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TheoryChapterLocalization]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TheoryChapterLocalization>> delete(
    _i1.DatabaseSession session,
    List<TheoryChapterLocalization> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TheoryChapterLocalization>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TheoryChapterLocalization].
  Future<TheoryChapterLocalization> deleteRow(
    _i1.DatabaseSession session,
    TheoryChapterLocalization row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TheoryChapterLocalization>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TheoryChapterLocalization>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TheoryChapterLocalization>(
      where: where(TheoryChapterLocalization.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TheoryChapterLocalization>(
      where: where?.call(TheoryChapterLocalization.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TheoryChapterLocalization] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TheoryChapterLocalizationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TheoryChapterLocalization>(
      where: where(TheoryChapterLocalization.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TheoryChapterLocalizationAttachRowRepository {
  const TheoryChapterLocalizationAttachRowRepository._();

  /// Creates a relation between the given [TheoryChapterLocalization] and [TheoryChapter]
  /// by setting the [TheoryChapterLocalization]'s foreign key `chapterId` to refer to the [TheoryChapter].
  Future<void> chapter(
    _i1.DatabaseSession session,
    TheoryChapterLocalization theoryChapterLocalization,
    _i2.TheoryChapter chapter, {
    _i1.Transaction? transaction,
  }) async {
    if (theoryChapterLocalization.id == null) {
      throw ArgumentError.notNull('theoryChapterLocalization.id');
    }
    if (chapter.id == null) {
      throw ArgumentError.notNull('chapter.id');
    }

    var $theoryChapterLocalization = theoryChapterLocalization.copyWith(
      chapterId: chapter.id,
    );
    await session.db.updateRow<TheoryChapterLocalization>(
      $theoryChapterLocalization,
      columns: [TheoryChapterLocalization.t.chapterId],
      transaction: transaction,
    );
  }
}
