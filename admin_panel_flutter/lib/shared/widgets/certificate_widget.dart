import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/theme/theme.dart';

/// A premium, landscape-oriented certificate widget.
/// Designed for high-resolution capture and elegant presentation.
class CertificateWidget extends StatelessWidget {
  const CertificateWidget({
    super.key,
    required this.recipientName,
    required this.courseTitle,
    required this.organizationName,
    required this.date,
    this.certificateId,
    this.verificationUrl,
    this.signatureImage,
    this.logoImage,
    this.overallPercentage = 100,
  });

  final String recipientName;
  final String courseTitle;
  final String organizationName;
  final DateTime date;
  final String? certificateId;
  final String? verificationUrl;
  final String? signatureImage;
  final String? logoImage;
  final int overallPercentage;

  @override
  Widget build(BuildContext context) {
    // FittedBox inside scales the fixed-size certificate layout to fit
    // any screen width while preserving the A4 landscape aspect ratio.
    return AspectRatio(
      aspectRatio: 1.414, // A4 Landscape ratio
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDF5),
          border: Border.all(color: const Color(0xFFD4AF37), width: 6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _CertificateBackgroundPainter(),
              ),
            ),
                // FittedBox ensures the content scales down uniformly
                // when the AspectRatio container is too small for the
                // intrinsic height of the certificate text.
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        // Provide a fixed logical size so the Column can
                        // use Spacer widgets. FittedBox then scales the
                        // whole thing to fit the available space.
                        width: 700,
                        height: 700 / 1.414, // match aspect ratio
                        child: Column(
                          children: [
                            // Top section: Logo & Title
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDecorativeBadge(
                                    overallPercentage, 1),
                                Flexible(
                                  child: Column(
                                    children: [
                                      if (logoImage != null)
                                        logoImage!.startsWith('http')
                                            ? Image.network(logoImage!,
                                                height: 60)
                                            : Image.asset(logoImage!,
                                                height: 60)
                                      else
                                        Image.asset(
                                            'assets/images/logo.png',
                                            height: 60,
                                            errorBuilder:
                                                (ctx, _, __) =>
                                                    const Icon(
                                                        Icons
                                                            .security_rounded,
                                                        size: 50,
                                                        color: Color(
                                                            0xFFD4AF37))),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Certificate of Achievement',
                                        style: GoogleFonts
                                            .playfairDisplay(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              const Color(0xFF4A3728),
                                          letterSpacing: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 80),
                              ],
                            ),

                            const Spacer(flex: 1),

                            Text(
                              'THIS IS TO CERTIFY THAT',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3,
                                color: const Color(0xFF8A7662),
                              ),
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            Text(
                              recipientName,
                              style: GoogleFonts.greatVibes(
                                fontSize: 64,
                                color: const Color(0xFF2C1E12),
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            Container(
                              width: 400,
                              height: 1,
                              color: const Color(0xFFD4AF37)
                                  .withValues(alpha: 0.5),
                            ),

                            const SizedBox(height: AppSpacing.lg),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xl),
                              child: Text(
                                'HAS SUCCESSFULLY COMPLETED THE',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2,
                                  color: const Color(0xFF8A7662),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            Text(
                              courseTitle,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4A3728),
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const Spacer(flex: 2),

                            // Bottom Section
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                _buildBottomInfo(
                                    'DATE', _formatDate(date), 1),
                                _buildSignature(1),
                                if (verificationUrl != null)
                                  _buildQrCode(verificationUrl!, 1)
                                else if (certificateId != null)
                                  _buildBottomInfo('CERTIFICATE ID',
                                      certificateId!, 1)
                                else
                                  const SizedBox(width: 80),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildDecorativeBadge(int percentage, [double _ = 1]) {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFF9E498), Color(0xFFD4AF37)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.military_tech_rounded,
              size: 48, color: Colors.white.withValues(alpha: 0.8)),
          Text(
            '$percentage%',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A3728),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo(String label, String value, [double _ = 1]) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C1E12),
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 120, height: 1, color: const Color(0xFFD4AF37)),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: const Color(0xFF8A7662),
          ),
        ),
      ],
    );
  }

  Widget _buildSignature([double _ = 1]) {
    return Column(
      children: [
        if (signatureImage != null)
          Image.network(signatureImage!, height: 40)
        else
          Text(
            organizationName,
            style: GoogleFonts.greatVibes(
                fontSize: 24, color: const Color(0xFF2C1E12)),
          ),
        const SizedBox(height: 4),
        Container(width: 150, height: 1, color: const Color(0xFFD4AF37)),
        const SizedBox(height: 4),
        Text(
          'AUTHORIZED SIGNATURE',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: const Color(0xFF8A7662),
          ),
        ),
      ],
    );
  }

  Widget _buildQrCode(String url, [double _ = 1]) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: QrImageView(
            data: url,
            version: QrVersions.auto,
            size: 50,
            gapless: false,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: Color(0xFF4A3728),
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: Color(0xFF4A3728),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'VERIFY',
          style: GoogleFonts.inter(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF8A7662),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

class _CertificateBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw center circular highlight
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFF9E498).withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 3));

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 3,
        highlightPaint);

    // Draw some subtle geometric patterns
    final patternPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (var i = 0; i < 5; i++) {
      canvas.drawCircle(Offset(0, 0), 100.0 + (i * 30), patternPaint);
      canvas.drawCircle(
          Offset(size.width, size.height), 100.0 + (i * 30), patternPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
