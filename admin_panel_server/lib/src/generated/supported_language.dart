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

/// DEPRECATED (future): superseded by LocaleConfig. Kept while the legacy
/// "Supported Languages" config editor in admin_modules_screen still uses it.
/// Non-persistent (lives inside ModuleConfig.supportedLanguages which is also
/// !persist) so storage is unaffected.
abstract class SupportedLanguage
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SupportedLanguage._({
    required this.code,
    required this.name,
    this.contentUrl,
  });

  factory SupportedLanguage({
    required String code,
    required String name,
    String? contentUrl,
  }) = _SupportedLanguageImpl;

  factory SupportedLanguage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SupportedLanguage(
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      contentUrl: jsonSerialization['contentUrl'] as String?,
    );
  }

  String code;

  String name;

  String? contentUrl;

  /// Returns a shallow copy of this [SupportedLanguage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SupportedLanguage copyWith({
    String? code,
    String? name,
    String? contentUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SupportedLanguage',
      'code': code,
      'name': name,
      if (contentUrl != null) 'contentUrl': contentUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SupportedLanguage',
      'code': code,
      'name': name,
      if (contentUrl != null) 'contentUrl': contentUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SupportedLanguageImpl extends SupportedLanguage {
  _SupportedLanguageImpl({
    required String code,
    required String name,
    String? contentUrl,
  }) : super._(
         code: code,
         name: name,
         contentUrl: contentUrl,
       );

  /// Returns a shallow copy of this [SupportedLanguage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SupportedLanguage copyWith({
    String? code,
    String? name,
    Object? contentUrl = _Undefined,
  }) {
    return SupportedLanguage(
      code: code ?? this.code,
      name: name ?? this.name,
      contentUrl: contentUrl is String? ? contentUrl : this.contentUrl,
    );
  }
}
