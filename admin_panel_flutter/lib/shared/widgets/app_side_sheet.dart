import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import 'app_gradient_button.dart';

/// Shows a right-side sheet that slides in with a 280 ms ease-in-out
/// transition. The background scrim is semi-transparent.
///
/// ```dart
/// AppSideSheet.show(
///   context: context,
///   title:   'Add Organisation',
///   body:    MyForm(),
///   onSave:  () async { await _save(); },
/// );
/// ```
class AppSideSheet {
  AppSideSheet._();

  static Future<T?> show<T>({
    required BuildContext context,
    required String       title,
    required Widget       body,
    required Future<void> Function()? onSave,
    String saveLabel   = 'Save',
    String cancelLabel = 'Cancel',
    bool   isLoading   = false,
  }) {
    return showGeneralDialog<T>(
      context:        context,
      barrierDismissible: true,
      barrierLabel:   'Close',
      barrierColor:   Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (ctx, anim, secAnim) => _SideSheetScaffold(
        title:       title,
        body:        body,
        onSave:      onSave,
        saveLabel:   saveLabel,
        cancelLabel: cancelLabel,
        isLoading:   isLoading,
      ),
      transitionBuilder: (ctx, anim, secAnim, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve:  Curves.easeInOut,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end:   Offset.zero,
          ).animate(curved),
          child: child,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Internal scaffold
// ─────────────────────────────────────────────────────────────────────────────

class _SideSheetScaffold extends StatefulWidget {
  const _SideSheetScaffold({
    required this.title,
    required this.body,
    required this.onSave,
    required this.saveLabel,
    required this.cancelLabel,
    required this.isLoading,
  });

  final String       title;
  final Widget       body;
  final Future<void> Function()? onSave;
  final String       saveLabel;
  final String       cancelLabel;
  final bool         isLoading;

  @override
  State<_SideSheetScaffold> createState() => _SideSheetScaffoldState();
}

class _SideSheetScaffoldState extends State<_SideSheetScaffold> {
  bool    _saving = false;
  String? _error;

  Future<void> _handleSave() async {
    if (widget.onSave == null) return;
    setState(() { _saving = true; _error = null; });
    try {
      await widget.onSave!();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        // Strip "Exception: " prefix for a cleaner message.
        final msg = e.toString().replaceFirst('Exception: ', '');
        setState(() => _error = msg);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color:     Colors.transparent,
        child: Container(
          width:  AppSpacing.sideSheetWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            border: const Border(
              left: BorderSide(color: AppColors.divider),
            ),
            boxShadow: [
              BoxShadow(
                color:      Colors.black.withValues(alpha: 0.4),
                blurRadius: 32,
                offset:     const Offset(-8, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: AppTextStyles.headingMd,
                      ),
                    ),
                    IconButton(
                      icon:    const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // ── Body ────────────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: widget.body,
                ),
              ),

              // ── Error banner ────────────────────────────────────────────
              if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  color: AppColors.errorSurface,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          size: 16, color: AppColors.error),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: AppTextStyles.bodySm
                              .copyWith(color: AppColors.error),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _error = null),
                        child: const Icon(Icons.close_rounded,
                            size: 14, color: AppColors.error),
                      ),
                    ],
                  ),
                ),

              // ── Footer ──────────────────────────────────────────────────
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _saving
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(widget.cancelLabel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppGradientButton(
                        label:     widget.saveLabel,
                        onPressed: widget.onSave != null ? _handleSave : null,
                        isLoading: _saving || widget.isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable form field helpers used inside side-sheet bodies
// ─────────────────────────────────────────────────────────────────────────────

/// Vertically stacked label + TextField — the standard form row inside a sheet.
class SheetField extends StatelessWidget {
  const SheetField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
    this.maxLines = 1,
    this.suffix,
    this.validator,
    this.enabled = true,
  });

  final String             label;
  final TextEditingController controller;
  final String?            hint;
  final TextInputType?     keyboardType;
  final int                maxLines;
  final Widget?            suffix;
  final String? Function(String?)? validator;
  final bool               enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        TextFormField(
          controller:   controller,
          keyboardType: keyboardType,
          maxLines:     maxLines,
          enabled:      enabled,
          decoration: InputDecoration(
            hintText:   hint,
            suffixIcon: suffix,
          ),
          validator: validator,
        ),
      ],
    );
  }
}

/// A section divider with a header label used inside side-sheet forms.
class SheetSection extends StatelessWidget {
  const SheetSection({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm, top: AppSpacing.md),
      child: Row(
        children: [
          Container(
            width:  3,
            height: 14,
            decoration: BoxDecoration(
              gradient:     AppColors.brandGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: AppTextStyles.headingXs),
        ],
      ),
    );
  }
}
