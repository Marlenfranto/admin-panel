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
import 'supported_language.dart' as _i2;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class LanguagesConfig implements _i1.SerializableModel {
  LanguagesConfig._({
    required this.defaultLanguage,
    this.supported,
  });

  factory LanguagesConfig({
    required String defaultLanguage,
    List<_i2.SupportedLanguage>? supported,
  }) = _LanguagesConfigImpl;

  factory LanguagesConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return LanguagesConfig(
      defaultLanguage: jsonSerialization['defaultLanguage'] as String,
      supported: jsonSerialization['supported'] == null
          ? null
          : _i3.Protocol().deserialize<List<_i2.SupportedLanguage>>(
              jsonSerialization['supported'],
            ),
    );
  }

  String defaultLanguage;

  List<_i2.SupportedLanguage>? supported;

  /// Returns a shallow copy of this [LanguagesConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LanguagesConfig copyWith({
    String? defaultLanguage,
    List<_i2.SupportedLanguage>? supported,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LanguagesConfig',
      'defaultLanguage': defaultLanguage,
      if (supported != null)
        'supported': supported?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LanguagesConfigImpl extends LanguagesConfig {
  _LanguagesConfigImpl({
    required String defaultLanguage,
    List<_i2.SupportedLanguage>? supported,
  }) : super._(
         defaultLanguage: defaultLanguage,
         supported: supported,
       );

  /// Returns a shallow copy of this [LanguagesConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LanguagesConfig copyWith({
    String? defaultLanguage,
    Object? supported = _Undefined,
  }) {
    return LanguagesConfig(
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      supported: supported is List<_i2.SupportedLanguage>?
          ? supported
          : this.supported?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
