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
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i2;

abstract class QuizQuestion implements _i1.SerializableModel {
  QuizQuestion._({
    required this.question,
    required this.answers,
    required this.correctAnswer,
  });

  factory QuizQuestion({
    required String question,
    required List<String> answers,
    required int correctAnswer,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      question: jsonSerialization['question'] as String,
      answers: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['answers'],
      ),
      correctAnswer: jsonSerialization['correctAnswer'] as int,
    );
  }

  String question;

  List<String> answers;

  int correctAnswer;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuizQuestion copyWith({
    String? question,
    List<String>? answers,
    int? correctAnswer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      'question': question,
      'answers': answers.toJson(),
      'correctAnswer': correctAnswer,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    required String question,
    required List<String> answers,
    required int correctAnswer,
  }) : super._(
         question: question,
         answers: answers,
         correctAnswer: correctAnswer,
       );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuizQuestion copyWith({
    String? question,
    List<String>? answers,
    int? correctAnswer,
  }) {
    return QuizQuestion(
      question: question ?? this.question,
      answers: answers ?? this.answers.map((e0) => e0).toList(),
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }
}
