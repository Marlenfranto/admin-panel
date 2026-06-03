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
import 'package:admin_panel_server/src/generated/protocol.dart' as _i2;

/// DEPRECATED (future): superseded by TrainingParameterLocalization /
/// AssessmentParameterLocalization. Lives inside the !persist `translations`
/// field on TrainingParameter / AssessmentParameter, so storage is unaffected.
abstract class LocalizedParameterContent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LocalizedParameterContent._({
    required this.languageCode,
    required this.name,
    required this.description,
    this.scoringFeedbacks,
  });

  factory LocalizedParameterContent({
    required String languageCode,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) = _LocalizedParameterContentImpl;

  factory LocalizedParameterContent.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LocalizedParameterContent(
      languageCode: jsonSerialization['languageCode'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
      scoringFeedbacks: jsonSerialization['scoringFeedbacks'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['scoringFeedbacks'],
            ),
    );
  }

  String languageCode;

  String name;

  String description;

  List<String>? scoringFeedbacks;

  /// Returns a shallow copy of this [LocalizedParameterContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LocalizedParameterContent copyWith({
    String? languageCode,
    String? name,
    String? description,
    List<String>? scoringFeedbacks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LocalizedParameterContent',
      'languageCode': languageCode,
      'name': name,
      'description': description,
      if (scoringFeedbacks != null)
        'scoringFeedbacks': scoringFeedbacks?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LocalizedParameterContent',
      'languageCode': languageCode,
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

class _LocalizedParameterContentImpl extends LocalizedParameterContent {
  _LocalizedParameterContentImpl({
    required String languageCode,
    required String name,
    required String description,
    List<String>? scoringFeedbacks,
  }) : super._(
         languageCode: languageCode,
         name: name,
         description: description,
         scoringFeedbacks: scoringFeedbacks,
       );

  /// Returns a shallow copy of this [LocalizedParameterContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LocalizedParameterContent copyWith({
    String? languageCode,
    String? name,
    String? description,
    Object? scoringFeedbacks = _Undefined,
  }) {
    return LocalizedParameterContent(
      languageCode: languageCode ?? this.languageCode,
      name: name ?? this.name,
      description: description ?? this.description,
      scoringFeedbacks: scoringFeedbacks is List<String>?
          ? scoringFeedbacks
          : this.scoringFeedbacks?.map((e0) => e0).toList(),
    );
  }
}
