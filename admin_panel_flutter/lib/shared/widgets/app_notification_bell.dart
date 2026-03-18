import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Bell icon button with an animated unread-count badge.
///
/// ```dart
/// AppNotificationBell(unreadCount: 3, onTap: _openNotifications)
/// ```
class AppNotificationBell extends StatefulWidget {
  const AppNotificationBell({
    super.key,
    this.unreadCount = 0,
    this.onTap,
  });

  final int          unreadCount;
  final VoidCallback? onTap;

  @override
  State<AppNotificationBell> createState() => _AppNotificationBellState();
}

class _AppNotificationBellState extends State<AppNotificationBell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          width:  36,
          height: 36,
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.surfaceVariant
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications_outlined,
                size:  20,
                color: _hovered
                    ? AppColors.onSurface
                    : AppColors.onSurfaceMuted,
              ),
              if (widget.unreadCount > 0)
                Positioned(
                  top:   2,
                  right: 2,
                  child: _Badge(count: widget.unreadCount),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final label = count > 99 ? '99+' : '$count';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      decoration: BoxDecoration(
        gradient:     AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        border:       Border.all(color: AppColors.surface, width: 1.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize:   9,
          fontWeight: FontWeight.w700,
          color:      Colors.white,
          height:     1.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
