import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/app_notification_bell.dart';
import '../../../src/providers.dart';
import '../providers/manager_providers.dart';

// ── Module metadata helpers ───────────────────────────────────────────────────

String _moduleLabel(String id) => switch (id) {
      'theory'        => 'Theory',
      'aiExpert'      => 'AR Expert',
      'smartTraining' => 'Smart Training',
      'assessment'    => 'Assessment',
      _               => id,
    };

Color _moduleColor(String id) => switch (id) {
      'theory'        => AppColors.theory,
      'aiExpert'      => AppColors.aiExpert,
      'smartTraining' => AppColors.training,
      'assessment'    => AppColors.assess,
      _               => AppColors.primary,
    };

IconData _moduleIcon(String id) => switch (id) {
      'theory'        => Icons.menu_book_rounded,
      'aiExpert'      => Icons.smart_toy_rounded,
      'smartTraining' => Icons.fitness_center_rounded,
      'assessment'    => Icons.quiz_rounded,
      _               => Icons.extension_rounded,
    };

// ── Bell entry point ──────────────────────────────────────────────────────────

/// Notification bell for the manager top bar. Clicking it opens an overlay
/// panel listing overdue-user notifications with mark-read and delete actions.
class ManagerNotificationBell extends ConsumerStatefulWidget {
  const ManagerNotificationBell({super.key});

  @override
  ConsumerState<ManagerNotificationBell> createState() =>
      _ManagerNotificationBellState();
}

class _ManagerNotificationBellState
    extends ConsumerState<ManagerNotificationBell> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _toggle() => _isOpen ? _removeOverlay() : _showOverlay();

  void _showOverlay() {
    final overlay = Overlay.of(context);
    final container = ProviderScope.containerOf(context);

    _overlayEntry = OverlayEntry(
      builder: (ctx) => UncontrolledProviderScope(
        container: container,
        child: _NotificationOverlay(
          layerLink: _layerLink,
          onClose:   _removeOverlay,
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
    setState(() => _isOpen = true);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final unreadAsync = ref.watch(managerUnreadCountProvider);
    final unread     = unreadAsync.value ?? 0;

    return CompositedTransformTarget(
      link: _layerLink,
      child: AppNotificationBell(
        unreadCount: unread,
        onTap:       _toggle,
      ),
    );
  }
}

// ── Overlay (barrier + panel) ─────────────────────────────────────────────────

class _NotificationOverlay extends StatelessWidget {
  const _NotificationOverlay({
    required this.layerLink,
    required this.onClose,
  });

  final LayerLink  layerLink;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Transparent barrier — tapping outside closes the panel.
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap:    onClose,
          ),
        ),
        // Positioned panel below + right-aligned with the bell button.
        CompositedTransformFollower(
          link:             layerLink,
          showWhenUnlinked: false,
          // Bell is 36 px wide; panel is 400 px — shift left so they right-align.
          offset: const Offset(-364, 44),
          child:  _NotificationPanel(onClose: onClose),
        ),
      ],
    );
  }
}

// ── Panel ─────────────────────────────────────────────────────────────────────

class _NotificationPanel extends ConsumerStatefulWidget {
  const _NotificationPanel({required this.onClose});
  final VoidCallback onClose;

  @override
  ConsumerState<_NotificationPanel> createState() =>
      _NotificationPanelState();
}

class _NotificationPanelState extends ConsumerState<_NotificationPanel> {
  bool _actioning = false;

  Future<void> _markRead(int notifId) async {
    if (_actioning) return;
    setState(() => _actioning = true);
    try {
      await ref.read(clientProvider).manager.markNotificationRead(notifId);
      ref.invalidate(managerUnreadCountProvider);
      final orgId = ref.read(activeOrgIdProvider);
      if (orgId != null) ref.invalidate(managerNotificationsProvider(orgId));
    } finally {
      if (mounted) setState(() => _actioning = false);
    }
  }

  Future<void> _markAllRead(int orgId) async {
    if (_actioning) return;
    setState(() => _actioning = true);
    try {
      await ref
          .read(clientProvider)
          .manager
          .markAllNotificationsRead(orgId);
      ref.invalidate(managerUnreadCountProvider);
      ref.invalidate(managerNotificationsProvider(orgId));
    } finally {
      if (mounted) setState(() => _actioning = false);
    }
  }

  Future<void> _delete(int notifId) async {
    if (_actioning) return;
    setState(() => _actioning = true);
    try {
      await ref.read(clientProvider).manager.deleteNotification(notifId);
      ref.invalidate(managerUnreadCountProvider);
      final orgId = ref.read(activeOrgIdProvider);
      if (orgId != null) ref.invalidate(managerNotificationsProvider(orgId));
    } finally {
      if (mounted) setState(() => _actioning = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orgId          = ref.watch(activeOrgIdProvider);
    final notifAsync     = orgId != null
        ? ref.watch(managerNotificationsProvider(orgId))
        : const AsyncValue<List<ManagerNotificationDetail>>.data([]);
    final hasUnread      = notifAsync.value?.any((d) => !d.notification.isRead) ?? false;

    final screenWidth = MediaQuery.sizeOf(context).width;

    return Material(
      color:        Colors.transparent,
      child: Container(
        width: screenWidth < 440 ? screenWidth - 32 : 400,
        constraints: const BoxConstraints(maxHeight: 520),
        decoration: BoxDecoration(
          color:        AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border:       Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color:   Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset:  const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.md, AppSpacing.sm, AppSpacing.md),
              child: Row(
                children: [
                  Text('Notifications', style: AppTextStyles.headingSm),
                  const Spacer(),
                  if (hasUnread && orgId != null)
                    TextButton(
                      onPressed: _actioning ? null : () => _markAllRead(orgId),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Mark all read',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Body ────────────────────────────────────────────────────
            Flexible(
              child: notifAsync.when(
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (e, _) => Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'Error: $e',
                    style: AppTextStyles.bodySm
                        .copyWith(color: AppColors.error),
                  ),
                ),
                data: (notifications) {
                  if (notifications.isEmpty) {
                    return const _EmptyState();
                  }
                  return ListView.separated(
                    shrinkWrap:   true,
                    padding:      EdgeInsets.zero,
                    itemCount:    notifications.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (ctx, i) {
                      final detail = notifications[i];
                      return _NotificationItem(
                        detail:     detail,
                        onMarkRead: detail.notification.isRead
                            ? null
                            : () =>
                                _markRead(detail.notification.id!),
                        onDelete: () =>
                            _delete(detail.notification.id!),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size:  40,
            color: AppColors.onSurfaceSubtle,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'All caught up!',
            style: AppTextStyles.labelLg,
          ),
          const SizedBox(height: 4),
          Text(
            'No overdue modules at the moment.',
            style: AppTextStyles.bodyXs,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Notification item ─────────────────────────────────────────────────────────

class _NotificationItem extends StatefulWidget {
  const _NotificationItem({
    required this.detail,
    required this.onMarkRead,
    required this.onDelete,
  });

  final ManagerNotificationDetail detail;
  final VoidCallback?              onMarkRead;
  final VoidCallback               onDelete;

  @override
  State<_NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<_NotificationItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final notif    = widget.detail.notification;
    final isUnread = !notif.isRead;
    final color    = _moduleColor(notif.moduleId);
    final now      = DateTime.now();
    final deadline = widget.detail.deadline;
    final daysOverdue = deadline != null
        ? now.difference(deadline).inDays
        : 0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: isUnread
              ? AppColors.primary.withValues(alpha: _hovered ? 0.07 : 0.04)
              : _hovered
                  ? AppColors.surfaceVariant
                  : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isUnread ? color : AppColors.divider,
              width: 4,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: avatar + summary text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Module icon badge
                        Container(
                          width:  32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd),
                          ),
                          child: Icon(
                            _moduleIcon(notif.moduleId),
                            size:  16,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodySm.copyWith(
                                    color: isUnread
                                        ? AppColors.onSurface
                                        : AppColors.onSurfaceMuted,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: widget.detail.overdueUserName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                        text:
                                            "'s ${_moduleLabel(notif.moduleId)} is overdue"),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _overdueSubtitle(
                                    daysOverdue, deadline,
                                    widget.detail.organizationName),
                                style: AppTextStyles.bodyXs,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Action buttons
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        if (widget.onMarkRead != null)
                          _ActionButton(
                            icon:    Icons.done_rounded,
                            tooltip: 'Mark as read',
                            color:   AppColors.success,
                            onTap:   widget.onMarkRead!,
                          ),
                        _ActionButton(
                          icon:    Icons.delete_outline_rounded,
                          tooltip: 'Delete',
                          color:   AppColors.error,
                          onTap:   widget.onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
        ),
      ),
    );
  }

  String _overdueSubtitle(int days, DateTime? deadline, String orgName) {
    final parts = <String>[];
    if (days > 0) {
      parts.add('$days ${days == 1 ? "day" : "days"} overdue');
    } else {
      parts.add('due today');
    }
    if (deadline != null) {
      parts.add('due ${DateFormat.MMMd().format(deadline)}');
    }
    parts.add(orgName);
    return parts.join(' • ');
  }
}

// ── Small action icon button ──────────────────────────────────────────────────

class _ActionButton extends StatefulWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData     icon;
  final String       tooltip;
  final Color        color;
  final VoidCallback onTap;

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor:  SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width:  28,
            height: 28,
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius:
                  BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              widget.icon,
              size:  15,
              color: _hovered
                  ? widget.color
                  : AppColors.onSurfaceSubtle,
            ),
          ),
        ),
      ),
    );
  }
}
