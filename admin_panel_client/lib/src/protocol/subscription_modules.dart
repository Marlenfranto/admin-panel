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

abstract class SubscriptionModules implements _i1.SerializableModel {
  SubscriptionModules._({
    required this.theoryModule,
    required this.aiExpertModule,
    required this.smartTrainingModule,
    required this.assessmentModule,
  });

  factory SubscriptionModules({
    required bool theoryModule,
    required bool aiExpertModule,
    required bool smartTrainingModule,
    required bool assessmentModule,
  }) = _SubscriptionModulesImpl;

  factory SubscriptionModules.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubscriptionModules(
      theoryModule: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['theoryModule'],
      ),
      aiExpertModule: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['aiExpertModule'],
      ),
      smartTrainingModule: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['smartTrainingModule'],
      ),
      assessmentModule: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['assessmentModule'],
      ),
    );
  }

  bool theoryModule;

  bool aiExpertModule;

  bool smartTrainingModule;

  bool assessmentModule;

  /// Returns a shallow copy of this [SubscriptionModules]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubscriptionModules copyWith({
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubscriptionModules',
      'theoryModule': theoryModule,
      'aiExpertModule': aiExpertModule,
      'smartTrainingModule': smartTrainingModule,
      'assessmentModule': assessmentModule,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubscriptionModulesImpl extends SubscriptionModules {
  _SubscriptionModulesImpl({
    required bool theoryModule,
    required bool aiExpertModule,
    required bool smartTrainingModule,
    required bool assessmentModule,
  }) : super._(
         theoryModule: theoryModule,
         aiExpertModule: aiExpertModule,
         smartTrainingModule: smartTrainingModule,
         assessmentModule: assessmentModule,
       );

  /// Returns a shallow copy of this [SubscriptionModules]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubscriptionModules copyWith({
    bool? theoryModule,
    bool? aiExpertModule,
    bool? smartTrainingModule,
    bool? assessmentModule,
  }) {
    return SubscriptionModules(
      theoryModule: theoryModule ?? this.theoryModule,
      aiExpertModule: aiExpertModule ?? this.aiExpertModule,
      smartTrainingModule: smartTrainingModule ?? this.smartTrainingModule,
      assessmentModule: assessmentModule ?? this.assessmentModule,
    );
  }
}
