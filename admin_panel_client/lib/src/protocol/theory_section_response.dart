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
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class TheorySectionResponse implements _i1.SerializableModel {
  TheorySectionResponse._({
    required this.moduleTitle,
    required this.chapters,
  });

  factory TheorySectionResponse({
    required String moduleTitle,
    required List<_i2.TheoryChapter> chapters,
  }) = _TheorySectionResponseImpl;

  factory TheorySectionResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TheorySectionResponse(
      moduleTitle: jsonSerialization['moduleTitle'] as String,
      chapters: _i3.Protocol().deserialize<List<_i2.TheoryChapter>>(
        jsonSerialization['chapters'],
      ),
    );
  }

  String moduleTitle;

  List<_i2.TheoryChapter> chapters;

  /// Returns a shallow copy of this [TheorySectionResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TheorySectionResponse copyWith({
    String? moduleTitle,
    List<_i2.TheoryChapter>? chapters,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TheorySectionResponse',
      'moduleTitle': moduleTitle,
      'chapters': chapters.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TheorySectionResponseImpl extends TheorySectionResponse {
  _TheorySectionResponseImpl({
    required String moduleTitle,
    required List<_i2.TheoryChapter> chapters,
  }) : super._(
         moduleTitle: moduleTitle,
         chapters: chapters,
       );

  /// Returns a shallow copy of this [TheorySectionResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TheorySectionResponse copyWith({
    String? moduleTitle,
    List<_i2.TheoryChapter>? chapters,
  }) {
    return TheorySectionResponse(
      moduleTitle: moduleTitle ?? this.moduleTitle,
      chapters: chapters ?? this.chapters.map((e0) => e0.copyWith()).toList(),
    );
  }
}
