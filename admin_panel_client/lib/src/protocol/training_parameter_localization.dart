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
import 'training_parameter.dart' as _i2;
import 'package:admin_panel_client/src/protocol/protocol.dart' as _i3;

abstract class TrainingParameterLocalization implements _i1.SerializableModel {
  TrainingParameterLocalization._({
    this.id,
    required this.parameterId,
    this.parameter,
    required this.localeKey,
    required this.name,
    required this.description,
    this.scoringFeedbacks,
  });

  factory TrainingParameterLocalization({
    int? id,
    required int parameterId,
    _i2.TrainingParameter? parameter,
    required String localeKey,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) = _TrainingParameterLocalizationImpl;

  factory TrainingParameterLocalization.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrainingParameterLocalization(
      id: jsonSerialization['id'] as int?,
      parameterId: jsonSerialization['parameterId'] as int,
      parameter: jsonSerialization['parameter'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.TrainingParameter>(
              jsonSerialization['parameter'],
            ),
      localeKey: jsonSerialization['localeKey'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      scoringFeedbacks: jsonSerialization['scoringFeedbacks'] == null
          ? null
          : _i3.Protocol().deserialize<List<String>>(
              jsonSerialization['scoringFeedbacks'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int parameterId;

  _i2.TrainingParameter? parameter;

  String localeKey;

  String name;

  String description;

  List<String>? scoringFeedbacks;

  /// Returns a shallow copy of this [TrainingParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrainingParameterLocalization copyWith({
    int? id,
    int? parameterId,
    _i2.TrainingParameter? parameter,
    String? localeKey,
    String? name,
    String? description,
    List<String>? scoringFeedbacks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrainingParameterLocalization',
      if (id != null) 'id': id,
      'parameterId': parameterId,
      if (parameter != null) 'parameter': parameter?.toJson(),
      'localeKey': localeKey,
      'name': name,
      'description': description,
      if (scoringFeedbacks != null)
        'scoringFeedbacks': scoringFeedbacks?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrainingParameterLocalizationImpl extends TrainingParameterLocalization {
  _TrainingParameterLocalizationImpl({
    int? id,
    required int parameterId,
    _i2.TrainingParameter? parameter,
    required String localeKey,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) : super._(
         id: id,
         parameterId: parameterId,
         parameter: parameter,
         localeKey: localeKey,
         name: name,
         description: description,
         scoringFeedbacks: scoringFeedbacks,
       );

  /// Returns a shallow copy of this [TrainingParameterLocalization]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrainingParameterLocalization copyWith({
    Object? id = _Undefined,
    int? parameterId,
    Object? parameter = _Undefined,
    String? localeKey,
    String? name,
    String? description,
    Object? scoringFeedbacks = _Undefined,
  }) {
    return TrainingParameterLocalization(
      id: id is int? ? id : this.id,
      parameterId: parameterId ?? this.parameterId,
      parameter: parameter is _i2.TrainingParameter?
          ? parameter
          : this.parameter?.copyWith(),
      localeKey: localeKey ?? this.localeKey,
      name: name ?? this.name,
      description: description ?? this.description,
      scoringFeedbacks: scoringFeedbacks is List<String>?
          ? scoringFeedbacks
          : this.scoringFeedbacks?.map((e0) => e0).toList(),
    );
  }
}
