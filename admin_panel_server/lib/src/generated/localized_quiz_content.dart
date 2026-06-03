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
import 'package:admin_panel_server/src/generated/protocol.dart' as _i2;

abstract class LocalizedQuizContent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LocalizedQuizContent._({
    required this.languageCode,
    this.localeKey,
    required this.question,
    required this.answers,
  });

  factory LocalizedQuizContent({
    required String languageCode,
    String? localeKey,
    required String question,
    required List<String> answers,
  }) = _LocalizedQuizContentImpl;

  factory LocalizedQuizContent.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LocalizedQuizContent(
      languageCode: jsonSerialization['languageCode'] as String,
      localeKey: jsonSerialization['localeKey'] as String?,
      question: jsonSerialization['question'] as String,
      answers: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['answers'],
      ),
    );
  }

  /// DEPRECATED (future): legacy quiz translation editor keys on languageCode.
  /// localeKey is the canonical replacement.
  String languageCode;

  String? localeKey;

  String question;

  List<String> answers;

  /// Returns a shallow copy of this [LocalizedQuizContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocalizedQuizContent copyWith({
    String? languageCode,
    String? localeKey,
    String? question,
    List<String>? answers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalizedQuizContent',
      'languageCode': languageCode,
      if (localeKey != null) 'localeKey': localeKey,
      'question': question,
      'answers': answers.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalizedQuizContent',
      'languageCode': languageCode,
      if (localeKey != null) 'localeKey': localeKey,
      'question': question,
      'answers': answers.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalizedQuizContentImpl extends LocalizedQuizContent {
  _LocalizedQuizContentImpl({
    required String languageCode,
    String? localeKey,
    required String question,
    required List<String> answers,
  }) : super._(
         languageCode: languageCode,
         localeKey: localeKey,
         question: question,
         answers: answers,
       );

  /// Returns a shallow copy of this [LocalizedQuizContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocalizedQuizContent copyWith({
    String? languageCode,
    Object? localeKey = _Undefined,
    String? question,
    List<String>? answers,
  }) {
    return LocalizedQuizContent(
      languageCode: languageCode ?? this.languageCode,
      localeKey: localeKey is String? ? localeKey : this.localeKey,
      question: question ?? this.question,
      answers: answers ?? this.answers.map((e0) => e0).toList(),
    );
  }
}
