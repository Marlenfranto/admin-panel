import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// A primary action button rendered with the brand orange→red gradient.
/// Replaces [FilledButton] for all primary CTA surfaces.
///
/// ```dart
/// AppGradientButton(
///   label: 'Save',
///   icon: Icons.save_rounded,
///   onPressed: _handleSave,
/// )
/// ```
class AppGradientButton extends StatefulWidget {
  const AppGradientButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 42,
    this.padding,
  });

  final String      label;
  final IconData?   icon;
  final VoidCallback? onPressed;
  final bool        isLoading;
  final double?     width;
  final double      height;
  final EdgeInsets? padding;

  @override
  State<AppGradientButton> createState() => _AppGradientButtonState();
}

class _AppGradientButtonState extends State<AppGradientButton> {
  bool _hovered  = false;
  bool _pressed  = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onPressed == null || widget.isLoading;

    return MouseRegion(
      cursor: disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter:  (_) => setState(() => _hovered = true),
      onExit:   (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown:   (_) => setState(() => _pressed = true),
        onTapUp:     (_) => setState(() => _pressed = false),
        onTapCancel: ()  => setState(() => _pressed = false),
        onTap: disabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width:  widget.width,
          height: widget.height,
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: disabled
                ? null
                : AppColors.brandGradient,
            color: disabled ? AppColors.surfaceVariant : null,
            borderRadius:
                BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: (!disabled && _hovered && !_pressed)
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: _buildChild(disabled),
        ),
      ),
    );
  }

  Widget _buildChild(bool disabled) {
    if (widget.isLoading) {
      return const Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
      );
    }

    final labelColor = disabled
        ? AppColors.onSurfaceSubtle
        : Colors.white;

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 16, color: labelColor),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: AppTextStyles.labelLg.copyWith(color: labelColor),
          ),
        ],
      );
    }

    return Center(
      child: Text(
        widget.label,
        style: AppTextStyles.labelLg.copyWith(color: labelColor),
      ),
    );
  }
}
