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
import 'theory_section_response.dart' as _i2;
import 'training_parameter.dart' as _i3;
import 'assessment_parameter.dart' as _i4;
import 'package:admin_panel_server/src/generated/protocol.dart' as _i5;

abstract class ContentBundle
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ContentBundle._({
    required this.theorySection,
    required this.trainingParameters,
    required this.assessmentParameters,
  });

  factory ContentBundle({
    required _i2.TheorySectionResponse theorySection,
    required List<_i3.TrainingParameter> trainingParameters,
    required List<_i4.AssessmentParameter> assessmentParameters,
  }) = _ContentBundleImpl;

  factory ContentBundle.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContentBundle(
      theorySection: _i5.Protocol().deserialize<_i2.TheorySectionResponse>(
        jsonSerialization['theorySection'],
      ),
      trainingParameters: _i5.Protocol()
          .deserialize<List<_i3.TrainingParameter>>(
            jsonSerialization['trainingParameters'],
          ),
      assessmentParameters: _i5.Protocol()
          .deserialize<List<_i4.AssessmentParameter>>(
            jsonSerialization['assessmentParameters'],
          ),
    );
  }

  _i2.TheorySectionResponse theorySection;

  List<_i3.TrainingParameter> trainingParameters;

  List<_i4.AssessmentParameter> assessmentParameters;

  /// Returns a shallow copy of this [ContentBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ContentBundle copyWith({
    _i2.TheorySectionResponse? theorySection,
    List<_i3.TrainingParameter>? trainingParameters,
    List<_i4.AssessmentParameter>? assessmentParameters,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContentBundle',
      'theorySection': theorySection.toJson(),
      'trainingParameters': trainingParameters.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'assessmentParameters': assessmentParameters.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContentBundle',
      'theorySection': theorySection.toJsonForProtocol(),
      'trainingParameters': trainingParameters.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'assessmentParameters': assessmentParameters.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ContentBundleImpl extends ContentBundle {
  _ContentBundleImpl({
    required _i2.TheorySectionResponse theorySection,
    required List<_i3.TrainingParameter> trainingParameters,
    required List<_i4.AssessmentParameter> assessmentParameters,
  }) : super._(
         theorySection: theorySection,
         trainingParameters: trainingParameters,
         assessmentParameters: assessmentParameters,
       );

  /// Returns a shallow copy of this [ContentBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ContentBundle copyWith({
    _i2.TheorySectionResponse? theorySection,
    List<_i3.TrainingParameter>? trainingParameters,
    List<_i4.AssessmentParameter>? assessmentParameters,
  }) {
    return ContentBundle(
      theorySection: theorySection ?? this.theorySection.copyWith(),
      trainingParameters:
          trainingParameters ??
          this.trainingParameters.map((e0) => e0.copyWith()).toList(),
      assessmentParameters:
          assessmentParameters ??
          this.assessmentParameters.map((e0) => e0.copyWith()).toList(),
    );
  }
}
