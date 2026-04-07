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
import 'user_theory_progress.dart' as _i3;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i4;

abstract class TheoryChapterWithProgress implements _i1.SerializableModel {
  TheoryChapterWithProgress._({
    required this.chapter,
    this.progress,
  });

  factory TheoryChapterWithProgress({
    required _i2.TheoryChapter chapter,
    _i3.UserTheoryProgress? progress,
  }) = _TheoryChapterWithProgressImpl;

  factory TheoryChapterWithProgress.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TheoryChapterWithProgress(
      chapter: _i4.Protocol().deserialize<_i2.TheoryChapter>(
        jsonSerialization['chapter'],
      ),
      progress: jsonSerialization['progress'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.UserTheoryProgress>(
              jsonSerialization['progress'],
            ),
    );
  }

  _i2.TheoryChapter chapter;

  _i3.UserTheoryProgress? progress;

  /// Returns a shallow copy of this [TheoryChapterWithProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TheoryChapterWithProgress copyWith({
    _i2.TheoryChapter? chapter,
    _i3.UserTheoryProgress? progress,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TheoryChapterWithProgress',
      'chapter': chapter.toJson(),
      if (progress != null) 'progress': progress?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TheoryChapterWithProgressImpl extends TheoryChapterWithProgress {
  _TheoryChapterWithProgressImpl({
    required _i2.TheoryChapter chapter,
    _i3.UserTheoryProgress? progress,
  }) : super._(
         chapter: chapter,
         progress: progress,
       );

  /// Returns a shallow copy of this [TheoryChapterWithProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TheoryChapterWithProgress copyWith({
    _i2.TheoryChapter? chapter,
    Object? progress = _Undefined,
  }) {
    return TheoryChapterWithProgress(
      chapter: chapter ?? this.chapter.copyWith(),
      progress: progress is _i3.UserTheoryProgress?
          ? progress
          : this.progress?.copyWith(),
    );
  }
}
