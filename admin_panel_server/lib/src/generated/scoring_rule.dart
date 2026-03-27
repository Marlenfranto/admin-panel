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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ScoringRule
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ScoringRule._({
    required this.threshold,
    required this.score,
    required this.feedback,
  });

  factory ScoringRule({
    required int threshold,
    required int score,
    required String feedback,
  }) = _ScoringRuleImpl;

  factory ScoringRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScoringRule(
      threshold: jsonSerialization['threshold'] as int,
      score: jsonSerialization['score'] as int,
      feedback: jsonSerialization['feedback'] as String,
    );
  }

  int threshold;

  int score;

  String feedback;

  /// Returns a shallow copy of this [ScoringRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScoringRule copyWith({
    int? threshold,
    int? score,
    String? feedback,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScoringRule',
      'threshold': threshold,
      'score': score,
      'feedback': feedback,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScoringRule',
      'threshold': threshold,
      'score': score,
      'feedback': feedback,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ScoringRuleImpl extends ScoringRule {
  _ScoringRuleImpl({
    required int threshold,
    required int score,
    required String feedback,
  }) : super._(
         threshold: threshold,
         score: score,
         feedback: feedback,
       );

  /// Returns a shallow copy of this [ScoringRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScoringRule copyWith({
    int? threshold,
    int? score,
    String? feedback,
  }) {
    return ScoringRule(
      threshold: threshold ?? this.threshold,
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
    );
  }
}
