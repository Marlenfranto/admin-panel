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

abstract class CertificateResponse implements _i1.SerializableModel {
  CertificateResponse._({
    required this.success,
    this.resultId,
    this.message,
  });

  factory CertificateResponse({
    required bool success,
    int? resultId,
    String? message,
  }) = _CertificateResponseImpl;

  factory CertificateResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return CertificateResponse(
      success: _i1.BoolJsonExtension.fromJson(jsonSerialization['success']),
      resultId: jsonSerialization['resultId'] as int?,
      message: jsonSerialization['message'] as String?,
    );
  }

  bool success;

  int? resultId;

  String? message;

  /// Returns a shallow copy of this [CertificateResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CertificateResponse copyWith({
    bool? success,
    int? resultId,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CertificateResponse',
      'success': success,
      if (resultId != null) 'resultId': resultId,
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CertificateResponseImpl extends CertificateResponse {
  _CertificateResponseImpl({
    required bool success,
    int? resultId,
    String? message,
  }) : super._(
         success: success,
         resultId: resultId,
         message: message,
       );

  /// Returns a shallow copy of this [CertificateResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CertificateResponse copyWith({
    bool? success,
    Object? resultId = _Undefined,
    Object? message = _Undefined,
  }) {
    return CertificateResponse(
      success: success ?? this.success,
      resultId: resultId is int? ? resultId : this.resultId,
      message: message is String? ? message : this.message,
    );
  }
}
