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

abstract class FeedbackLevel implements _i1.SerializableModel {
  FeedbackLevel._({
    required this.scoreRange,
    required this.criteria,
    required this.comment,
  });

  factory FeedbackLevel({
    required String scoreRange,
    required String criteria,
    required String comment,
  }) = _FeedbackLevelImpl;

  factory FeedbackLevel.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedbackLevel(
      scoreRange: jsonSerialization['scoreRange'] as String,
      criteria: jsonSerialization['criteria'] as String,
      comment: jsonSerialization['comment'] as String,
    );
  }

  String scoreRange;

  String criteria;

  String comment;

  /// Returns a shallow copy of this [FeedbackLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeedbackLevel copyWith({
    String? scoreRange,
    String? criteria,
    String? comment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedbackLevel',
      'scoreRange': scoreRange,
      'criteria': criteria,
      'comment': comment,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FeedbackLevelImpl extends FeedbackLevel {
  _FeedbackLevelImpl({
    required String scoreRange,
    required String criteria,
    required String comment,
  }) : super._(
         scoreRange: scoreRange,
         criteria: criteria,
         comment: comment,
       );

  /// Returns a shallow copy of this [FeedbackLevel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeedbackLevel copyWith({
    String? scoreRange,
    String? criteria,
    String? comment,
  }) {
    return FeedbackLevel(
      scoreRange: scoreRange ?? this.scoreRange,
      criteria: criteria ?? this.criteria,
      comment: comment ?? this.comment,
    );
  }
}
