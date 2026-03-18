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

abstract class Tools implements _i1.SerializableModel {
  Tools._({
    bool? theory,
    bool? ai,
    bool? training,
    bool? assessment,
  }) : theory = theory ?? false,
       ai = ai ?? false,
       training = training ?? false,
       assessment = assessment ?? false;

  factory Tools({
    bool? theory,
    bool? ai,
    bool? training,
    bool? assessment,
  }) = _ToolsImpl;

  factory Tools.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tools(
      theory: jsonSerialization['theory'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['theory']),
      ai: jsonSerialization['ai'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['ai']),
      training: jsonSerialization['training'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['training']),
      assessment: jsonSerialization['assessment'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['assessment']),
    );
  }

  bool theory;

  bool ai;

  bool training;

  bool assessment;

  /// Returns a shallow copy of this [Tools]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tools copyWith({
    bool? theory,
    bool? ai,
    bool? training,
    bool? assessment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Tools',
      'theory': theory,
      'ai': ai,
      'training': training,
      'assessment': assessment,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ToolsImpl extends Tools {
  _ToolsImpl({
    bool? theory,
    bool? ai,
    bool? training,
    bool? assessment,
  }) : super._(
         theory: theory,
         ai: ai,
         training: training,
         assessment: assessment,
       );

  /// Returns a shallow copy of this [Tools]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tools copyWith({
    bool? theory,
    bool? ai,
    bool? training,
    bool? assessment,
  }) {
    return Tools(
      theory: theory ?? this.theory,
      ai: ai ?? this.ai,
      training: training ?? this.training,
      assessment: assessment ?? this.assessment,
    );
  }
}
