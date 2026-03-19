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

abstract class TrainingCriteriaScore
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TrainingCriteriaScore._({
    required this.parameter,
    required this.score,
  });

  factory TrainingCriteriaScore({
    required String parameter,
    required int score,
  }) = _TrainingCriteriaScoreImpl;

  factory TrainingCriteriaScore.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingCriteriaScore(
      parameter: jsonSerialization['parameter'] as String,
      score: jsonSerialization['score'] as int,
    );
  }

  String parameter;

  int score;

  /// Returns a shallow copy of this [TrainingCriteriaScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingCriteriaScore copyWith({
    String? parameter,
    int? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingCriteriaScore',
      'parameter': parameter,
      'score': score,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TrainingCriteriaScore',
      'parameter': parameter,
      'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TrainingCriteriaScoreImpl extends TrainingCriteriaScore {
  _TrainingCriteriaScoreImpl({
    required String parameter,
    required int score,
  }) : super._(
         parameter: parameter,
         score: score,
       );

  /// Returns a shallow copy of this [TrainingCriteriaScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingCriteriaScore copyWith({
    String? parameter,
    int? score,
  }) {
    return TrainingCriteriaScore(
      parameter: parameter ?? this.parameter,
      score: score ?? this.score,
    );
  }
}
