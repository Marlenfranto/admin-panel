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
import 'theory_chapter.dart' as _i2;
import 'video_metadata.dart' as _i3;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i4;

abstract class TheoryChapterLocalization implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int chapterId;

  _i2.TheoryChapter? chapter;

  String localeKey;

  String title;

  String? description;

  String? thumbnailUrl;

  String? videoUrl;

  _i3.VideoMetadata? videoMetadata;

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
