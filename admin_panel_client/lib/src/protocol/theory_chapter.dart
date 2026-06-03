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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'organization.dart' as _i2;
import 'quiz_question.dart' as _i3;
import 'video_metadata.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class TheoryChapter implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
