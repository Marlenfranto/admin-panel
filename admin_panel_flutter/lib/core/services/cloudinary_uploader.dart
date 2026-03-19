import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../config/cloudinary_config.dart';

/// Uploads images to Cloudinary using the unsigned upload API.
class CloudinaryUploader {
  CloudinaryUploader._();

  /// Uploads [bytes] to Cloudinary and returns the secure download URL.
  ///
  /// [fileName] is used to derive the file extension.
  /// [folder]   is the destination folder inside your Cloudinary media library.
  static Future<String> uploadImage(
    Uint8List bytes, {
    required String fileName,
    String folder = 'uploads',
  }) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload',
    );

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = CloudinaryConfig.uploadPreset
      ..fields['folder']        = folder
      ..files.add(
        http.MultipartFile.fromBytes('file', bytes, filename: fileName),
      );

    final streamed = await request.send();
    final body     = await streamed.stream.bytesToString();
    final json     = jsonDecode(body) as Map<String, dynamic>;

    if (streamed.statusCode != 200) {
      final message = (json['error'] as Map?)?['message'] ?? 'Unknown error';
      throw Exception('Cloudinary upload failed: $message');
    }

    return json['secure_url'] as String;
  }
}
