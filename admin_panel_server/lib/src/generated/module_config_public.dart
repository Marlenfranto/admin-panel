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
import 'subscription_modules.dart' as _i2;
import 'languages_config.dart' as _i3;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i4;

abstract class ModuleConfigPublic
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ModuleConfigPublic._({
    required this.configId,
    required this.lastUpdated,
    required this.subscriptionModules,
    required this.languages,
    required this.passingPercentage,
    this.aiChatPrompt,
  });

  factory ModuleConfigPublic({
    required String configId,
    required String lastUpdated,
    required _i2.SubscriptionModules subscriptionModules,
    required _i3.LanguagesConfig languages,
    required int passingPercentage,
    String? aiChatPrompt,
  }) = _ModuleConfigPublicImpl;

  factory ModuleConfigPublic.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModuleConfigPublic(
      configId: jsonSerialization['configId'] as String,
      lastUpdated: jsonSerialization['lastUpdated'] as String,
      subscriptionModules: _i4.Protocol().deserialize<_i2.SubscriptionModules>(
        jsonSerialization['subscriptionModules'],
      ),
      languages: _i4.Protocol().deserialize<_i3.LanguagesConfig>(
        jsonSerialization['languages'],
      ),
      passingPercentage: jsonSerialization['passingPercentage'] as int,
      aiChatPrompt: jsonSerialization['aiChatPrompt'] as String?,
    );
  }

  String configId;

  String lastUpdated;

  _i2.SubscriptionModules subscriptionModules;

  _i3.LanguagesConfig languages;

  int passingPercentage;

  String? aiChatPrompt;

  /// Returns a shallow copy of this [ModuleConfigPublic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModuleConfigPublic copyWith({
    String? configId,
    String? lastUpdated,
    _i2.SubscriptionModules? subscriptionModules,
    _i3.LanguagesConfig? languages,
    int? passingPercentage,
    String? aiChatPrompt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModuleConfigPublic',
      'configId': configId,
      'lastUpdated': lastUpdated,
      'subscriptionModules': subscriptionModules.toJson(),
      'languages': languages.toJson(),
      'passingPercentage': passingPercentage,
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ModuleConfigPublic',
      'configId': configId,
      'lastUpdated': lastUpdated,
      'subscriptionModules': subscriptionModules.toJsonForProtocol(),
      'languages': languages.toJsonForProtocol(),
      'passingPercentage': passingPercentage,
      if (aiChatPrompt != null) 'aiChatPrompt': aiChatPrompt,
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
    required _i2.SubscriptionModules subscriptionModules,
    required _i3.LanguagesConfig languages,
    required int passingPercentage,
    String? aiChatPrompt,
  }) : super._(
         configId: configId,
         lastUpdated: lastUpdated,
         subscriptionModules: subscriptionModules,
         languages: languages,
         passingPercentage: passingPercentage,
         aiChatPrompt: aiChatPrompt,
       );

  /// Returns a shallow copy of this [ModuleConfigPublic]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModuleConfigPublic copyWith({
    String? configId,
    String? lastUpdated,
    _i2.SubscriptionModules? subscriptionModules,
    _i3.LanguagesConfig? languages,
    int? passingPercentage,
    Object? aiChatPrompt = _Undefined,
  }) {
    return ModuleConfigPublic(
      configId: configId ?? this.configId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      subscriptionModules:
          subscriptionModules ?? this.subscriptionModules.copyWith(),
      languages: languages ?? this.languages.copyWith(),
      passingPercentage: passingPercentage ?? this.passingPercentage,
      aiChatPrompt: aiChatPrompt is String? ? aiChatPrompt : this.aiChatPrompt,
    );
  }
}
