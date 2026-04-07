import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../utils/certificate_generator.dart';
import 'certificate_widget.dart';
import 'responsive_helper.dart';

/// A dialog that previews the certificate and provides export options.
class CertificatePreviewDialog extends ConsumerStatefulWidget {
  const CertificatePreviewDialog({
    super.key,
    required this.recipientName,
    required this.courseTitle,
    required this.organizationName,
    required this.date,
    this.logoImage,
    this.overallPercentage = 100,
  });

  final String recipientName;
  final String courseTitle;
  final String organizationName;
  final DateTime date;
  final String? logoImage;
  final int overallPercentage;

  @override
  ConsumerState<CertificatePreviewDialog> createState() =>
      _CertificatePreviewDialogState();
}

class _CertificatePreviewDialogState
    extends ConsumerState<CertificatePreviewDialog> {
  final GlobalKey _boundaryKey = GlobalKey();
  bool _isGenerating = false;

  Future<void> _exportPng() async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await CertificateGenerator.captureWidget(_boundaryKey);
      if (bytes != null) {
        await CertificateGenerator.shareCertificate(
          bytes,
          'Certificate_${widget.recipientName.replaceAll(" ", "_")}',
          'png',
          subject: 'Training Certificate',
          text: 'Check out my certificate for ${widget.courseTitle}!',
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _exportPdf() async {
    setState(() => _isGenerating = true);
    try {
      final bytes = await CertificateGenerator.captureWidget(_boundaryKey);
      if (bytes != null) {
        final pdfBytes = await CertificateGenerator.generatePdf(bytes);
        await CertificateGenerator.printPdf(
          pdfBytes,
          'Certificate_${widget.recipientName.replaceAll(" ", "_")}',
        );
      }
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? AppSpacing.sm : AppSpacing.lg),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 900,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Certificate Preview',
                        style: AppTextStyles.headingSm),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Preview Area ────────────────────────────────────────────────
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                    isMobile ? AppSpacing.sm : AppSpacing.lg),
                child: Center(
                  child: RepaintBoundary(
                    key: _boundaryKey,
                    child: CertificateWidget(
                      recipientName: widget.recipientName,
                      courseTitle: widget.courseTitle,
                      organizationName: widget.organizationName,
                      date: widget.date,
                      logoImage: widget.logoImage,
                      overallPercentage: widget.overallPercentage,
                      certificateId:
                          'FX-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
                      verificationUrl: 'https://admin-panel-c169e.web.app/',
                    ),
                  ),
                ),
              ),
            ),

            const Divider(height: 1),

            // ── Actions — wrap on mobile ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_isGenerating)
                          const Padding(
                            padding:
                                EdgeInsets.only(bottom: AppSpacing.sm),
                            child: Center(
                                child: CircularProgressIndicator(
                                    strokeWidth: 2)),
                          ),
                        ElevatedButton.icon(
                          onPressed: _isGenerating ? null : _exportPdf,
                          icon: const Icon(
                              Icons.picture_as_pdf_rounded, size: 18),
                          label: const Text('Download PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        if (!kIsWeb) ...[
                          const SizedBox(height: AppSpacing.sm),
                          OutlinedButton.icon(
                            onPressed: _isGenerating ? null : _exportPng,
                            icon:
                                const Icon(Icons.image_rounded, size: 18),
                            label: const Text('Export PNG'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_isGenerating)
                          const Padding(
                            padding:
                                EdgeInsets.only(right: AppSpacing.md),
                            child: CircularProgressIndicator(
                                strokeWidth: 2),
                          ),
                        if (!kIsWeb)
                          OutlinedButton.icon(
                            onPressed: _isGenerating ? null : _exportPng,
                            icon:
                                const Icon(Icons.image_rounded, size: 18),
                            label: const Text('Export PNG'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.onSurface,
                            ),
                          ),
                        const SizedBox(width: AppSpacing.sm),
                        ElevatedButton.icon(
                          onPressed: _isGenerating ? null : _exportPdf,
                          icon: const Icon(
                              Icons.picture_as_pdf_rounded, size: 18),
                          label: const Text('Download PDF'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
