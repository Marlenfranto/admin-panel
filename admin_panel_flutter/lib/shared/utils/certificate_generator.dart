import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

/// Utility class for generating PNG and PDF versions of the certificate.
class CertificateGenerator {
  /// Captures a widget wrapped in a RepaintBoundary as a high-resolution image.
  static Future<Uint8List?> captureWidget(GlobalKey key) async {
    try {
      final boundary =
          key.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return null;

      // Capture at a high pixel ratio (e.g., 3.0) for print quality
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing certificate: $e');
      return null;
    }
  }

  /// Generates a PDF document containing the provided certificate image.
  static Future<Uint8List> generatePdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Image(image, fit: pw.BoxFit.cover),
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Saves the provided bytes to a temporary file and returns the path.
  static Future<String> saveTempFile(
      Uint8List bytes, String fileName, String extension) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName.$extension');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// Shares the certificate using the system's share sheet.
  static Future<void> shareCertificate(
    Uint8List bytes,
    String fileName,
    String extension, {
    String? subject,
    String? text,
  }) async {
    final path = await saveTempFile(bytes, fileName, extension);
    await Share.shareXFiles(
      [XFile(path)],
      subject: subject,
      text: text,
    );
  }

  /// Prints or saves the PDF using the system print dialog.
  static Future<void> printPdf(Uint8List pdfBytes, String name) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
      name: name,
    );
  }
}
