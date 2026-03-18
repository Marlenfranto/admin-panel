import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme.dart';

/// A single crumb entry.
class BreadcrumbItem {
  const BreadcrumbItem({required this.label, this.route});

  /// Display text.
  final String  label;

  /// If provided, the crumb is tappable and navigates to this route.
  /// The last crumb typically omits [route] (current page).
  final String? route;
}

/// Horizontal breadcrumb trail rendered in the top app bar.
///
/// ```dart
/// AppBreadcrumb(
///   items: [
///     BreadcrumbItem(label: 'Admin',         route: AppRoutes.adminOrganizations),
///     BreadcrumbItem(label: 'Organisations'),
///   ],
/// )
/// ```
class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({super.key, required this.items});

  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          _Crumb(item: items[i], isCurrent: i == items.length - 1),
          if (i < items.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: AppColors.onSurfaceSubtle,
              ),
            ),
        ],
      ],
    );
  }
}

class _Crumb extends StatefulWidget {
  const _Crumb({required this.item, required this.isCurrent});
  final BreadcrumbItem item;
  final bool           isCurrent;

  @override
  State<_Crumb> createState() => _CrumbState();
}

class _CrumbState extends State<_Crumb> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isLink = widget.item.route != null && !widget.isCurrent;

    final style = widget.isCurrent
        ? AppTextStyles.labelLg.copyWith(color: AppColors.onSurface)
        : _hovered && isLink
            ? AppTextStyles.labelLg.copyWith(color: AppColors.primary)
            : AppTextStyles.labelLg.copyWith(color: AppColors.onSurfaceMuted);

    if (!isLink) {
      return Text(widget.item.label, style: style);
    }

    return MouseRegion(
      cursor:   SystemMouseCursors.click,
      onEnter:  (_) => setState(() => _hovered = true),
      onExit:   (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.route!),
        child: AnimatedDefaultTextStyle(
          style:    style,
          duration: const Duration(milliseconds: 120),
          child:    Text(widget.item.label),
        ),
      ),
    );
  }
}
