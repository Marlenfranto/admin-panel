/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Tools implements _i1.SerializableModel {
  Tools._({
    bool? theory,
    bool? ai,
    bool? training,
  })  : theory = theory ?? false,
        ai = ai ?? false,
        training = training ?? false;

  factory Tools({
    bool? theory,
    bool? ai,
    bool? training,
  }) = _ToolsImpl;

  factory Tools.fromJson(Map<String, dynamic> jsonSerialization) {
    return Tools(
      theory: jsonSerialization['theory'] as bool,
      ai: jsonSerialization['ai'] as bool,
      training: jsonSerialization['training'] as bool,
    );
  }

  bool theory;

  bool ai;

  bool training;

  /// Returns a shallow copy of this [Tools]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Tools copyWith({
    bool? theory,
    bool? ai,
    bool? training,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'theory': theory,
      'ai': ai,
      'training': training,
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
  }) : super._(
          theory: theory,
          ai: ai,
          training: training,
        );

  /// Returns a shallow copy of this [Tools]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Tools copyWith({
    bool? theory,
    bool? ai,
    bool? training,
  }) {
    return Tools(
      theory: theory ?? this.theory,
      ai: ai ?? this.ai,
      training: training ?? this.training,
    );
  }
}
