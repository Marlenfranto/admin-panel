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

abstract class LocalizedAiPrompt implements _i1.SerializableModel {
  LocalizedAiPrompt._({
    required this.languageCode,
    this.localeKey,
    required this.prompt,
  });

  factory LocalizedAiPrompt({
    required String languageCode,
    String? localeKey,
    required String prompt,
  }) = _LocalizedAiPromptImpl;

  factory LocalizedAiPrompt.fromJson(Map<String, dynamic> jsonSerialization) {
    return LocalizedAiPrompt(
      languageCode: jsonSerialization['languageCode'] as String,
      localeKey: jsonSerialization['localeKey'] as String?,
      prompt: jsonSerialization['prompt'] as String,
    );
  }

  /// DEPRECATED (future): legacy AI prompt translation editor keys on
  /// languageCode. localeKey is the canonical replacement.
  String languageCode;

  String? localeKey;

  String prompt;

  /// Returns a shallow copy of this [LocalizedAiPrompt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocalizedAiPrompt copyWith({
    String? languageCode,
    String? localeKey,
    String? prompt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalizedAiPrompt',
      'languageCode': languageCode,
      if (localeKey != null) 'localeKey': localeKey,
      'prompt': prompt,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LocalizedAiPromptImpl extends LocalizedAiPrompt {
  _LocalizedAiPromptImpl({
    required String languageCode,
    String? localeKey,
    required String prompt,
  }) : super._(
         languageCode: languageCode,
         localeKey: localeKey,
         prompt: prompt,
       );

  /// Returns a shallow copy of this [LocalizedAiPrompt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocalizedAiPrompt copyWith({
    String? languageCode,
    Object? localeKey = _Undefined,
    String? prompt,
  }) {
    return LocalizedAiPrompt(
      languageCode: languageCode ?? this.languageCode,
      localeKey: localeKey is String? ? localeKey : this.localeKey,
      prompt: prompt ?? this.prompt,
    );
  }
}
