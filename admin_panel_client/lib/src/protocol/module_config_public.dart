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
import 'subscription_modules.dart' as _i2;
import 'locale_config.dart' as _i3;
import 'localized_ai_prompt.dart' as _i4;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i5;

abstract class ModuleConfigPublic implements _i1.SerializableModel {
  ModuleConfigPublic._({
    required this.configId,
    required this.lastUpdated,
    required this.contentVersion,
    required this.subscriptionModules,
    required this.defaultLocaleKey,
    this.supportedLocales,
    required this.passingPercentage,
    this.aiChatPrompt,
    this.aiChatPromptTranslations,
  });

  factory ModuleConfigPublic({
    required String configId,
    required String lastUpdated,
    required int contentVersion,
    required _i2.SubscriptionModules subscriptionModules,
    required String defaultLocaleKey,
    List<_i3.LocaleConfig>? supportedLocales,
    required int passingPercentage,
    String? aiChatPrompt,
    List<_i4.LocalizedAiPrompt>? aiChatPromptTranslations,
  }) = _ModuleConfigPublicImpl;

  factory ModuleConfigPublic.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModuleConfigPublic(
      configId: jsonSerialization['configId'] as String,
      lastUpdated: jsonSerialization['lastUpdated'] as String,
      contentVersion: jsonSerialization['contentVersion'] as int,
      subscriptionModules: _i5.Protocol().deserialize<_i2.SubscriptionModules>(
        jsonSerialization['subscriptionModules'],
      ),
      defaultLocaleKey: jsonSerialization['defaultLocaleKey'] as String,
      supportedLocales: jsonSerialization['supportedLocales'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i3.LocaleConfig>>(
              jsonSerialization['supportedLocales'],
            ),
      passingPercentage: jsonSerialization['passingPercentage'] as int,
      aiChatPrompt: jsonSerialization['aiChatPrompt'] as String?,
      aiChatPromptTranslations:
          jsonSerialization['aiChatPromptTranslations'] == null
          ? null
          : _i5.Protocol().deserialize<List<_i4.LocalizedAiPrompt>>(
              jsonSerialization['aiChatPromptTranslations'],
            ),
    );
  }

  String configId;

  String lastUpdated;

  int contentVersion;

  _i2.SubscriptionModules subscriptionModules;

  String defaultLocaleKey;

  List<_i3.LocaleConfig>? supportedLocales;

  int passingPercentage;

  String? aiChatPrompt;

  List<_i4.LocalizedAiPrompt>? aiChatPromptTranslations;

  /// Returns a shallow copy of this [ModuleConfigPublic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModuleConfigPublic copyWith({
    String? configId,
    String? lastUpdated,
    int? contentVersion,
    _i2.SubscriptionModules? subscriptionModules,
    String? defaultLocaleKey,
    List<_i3.LocaleConfig>? supportedLocales,
    int? passingPercentage,
    String? aiChatPrompt,
    List<_i4.LocalizedAiPrompt>? aiChatPromptTranslations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModuleConfigPublic',
      'configId': configId,
      'lastUpdated': lastUpdated,
      'contentVersion': contentVersion,
      'subscriptionModules': subscriptionModules.toJson(),
      'defaultLocaleKey': defaultLocaleKey,
      if (supportedLocales != null)
        'supportedLocales': supportedLocales?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      'passingPercentage': passingPercentage,
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
      if (aiChatPromptTranslations != null)
        'aiChatPromptTranslations': aiChatPromptTranslations?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModuleConfigPublicImpl extends ModuleConfigPublic {
  _ModuleConfigPublicImpl({
    required String configId,
    required String lastUpdated,
    required int contentVersion,
    required _i2.SubscriptionModules subscriptionModules,
    required String defaultLocaleKey,
    List<_i3.LocaleConfig>? supportedLocales,
    required int passingPercentage,
    String? aiChatPrompt,
    List<_i4.LocalizedAiPrompt>? aiChatPromptTranslations,
  }) : super._(
         configId: configId,
         lastUpdated: lastUpdated,
         contentVersion: contentVersion,
         subscriptionModules: subscriptionModules,
         defaultLocaleKey: defaultLocaleKey,
         supportedLocales: supportedLocales,
         passingPercentage: passingPercentage,
         aiChatPrompt: aiChatPrompt,
         aiChatPromptTranslations: aiChatPromptTranslations,
       );

  /// Returns a shallow copy of this [ModuleConfigPublic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModuleConfigPublic copyWith({
    String? configId,
    String? lastUpdated,
    int? contentVersion,
    _i2.SubscriptionModules? subscriptionModules,
    String? defaultLocaleKey,
    Object? supportedLocales = _Undefined,
    int? passingPercentage,
    Object? aiChatPrompt = _Undefined,
    Object? aiChatPromptTranslations = _Undefined,
  }) {
    return ModuleConfigPublic(
      configId: configId ?? this.configId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      contentVersion: contentVersion ?? this.contentVersion,
      subscriptionModules:
          subscriptionModules ?? this.subscriptionModules.copyWith(),
      defaultLocaleKey: defaultLocaleKey ?? this.defaultLocaleKey,
      supportedLocales: supportedLocales is List<_i3.LocaleConfig>?
          ? supportedLocales
          : this.supportedLocales?.map((e0) => e0.copyWith()).toList(),
      passingPercentage: passingPercentage ?? this.passingPercentage,
      aiChatPrompt: aiChatPrompt is String? ? aiChatPrompt : this.aiChatPrompt,
      aiChatPromptTranslations:
          aiChatPromptTranslations is List<_i4.LocalizedAiPrompt>?
          ? aiChatPromptTranslations
          : this.aiChatPromptTranslations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
