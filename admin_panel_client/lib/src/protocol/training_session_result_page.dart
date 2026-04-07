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
import 'training_session_result.dart' as _i2;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class TrainingSessionResultPage implements _i1.SerializableModel {
  TrainingSessionResultPage._({
    required this.results,
    required this.totalCount,
    required this.hasMore,
  });

  factory TrainingSessionResultPage({
    required List<_i2.TrainingSessionResult> results,
    required int totalCount,
    required bool hasMore,
  }) = _TrainingSessionResultPageImpl;

  factory TrainingSessionResultPage.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingSessionResultPage(
      results: _i3.Protocol().deserialize<List<_i2.TrainingSessionResult>>(
        jsonSerialization['results'],
      ),
      totalCount: jsonSerialization['totalCount'] as int,
      hasMore: _i1.BoolJsonExtension.fromJson(jsonSerialization['hasMore']),
    );
  }

  List<_i2.TrainingSessionResult> results;

  int totalCount;

  bool hasMore;

  /// Returns a shallow copy of this [TrainingSessionResultPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingSessionResultPage copyWith({
    List<_i2.TrainingSessionResult>? results,
    int? totalCount,
    bool? hasMore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingSessionResultPage',
      'results': results.toJson(valueToJson: (v) => v.toJson()),
      'totalCount': totalCount,
      'hasMore': hasMore,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TrainingSessionResultPageImpl extends TrainingSessionResultPage {
  _TrainingSessionResultPageImpl({
    required List<_i2.TrainingSessionResult> results,
    required int totalCount,
    required bool hasMore,
  }) : super._(
         results: results,
         totalCount: totalCount,
         hasMore: hasMore,
       );

  /// Returns a shallow copy of this [TrainingSessionResultPage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingSessionResultPage copyWith({
    List<_i2.TrainingSessionResult>? results,
    int? totalCount,
    bool? hasMore,
  }) {
    return TrainingSessionResultPage(
      results: results ?? this.results.map((e0) => e0.copyWith()).toList(),
      totalCount: totalCount ?? this.totalCount,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
