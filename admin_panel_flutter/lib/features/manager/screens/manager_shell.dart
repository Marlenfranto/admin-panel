import 'package:flutter/material.dart';

import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/dashboard_shell.dart';
import '../widgets/manager_notification_bell.dart';

/// Shell for the Manager portal. Wraps [DashboardShell] with manager nav items.
class ManagerShell extends StatelessWidget {
  const ManagerShell({super.key, required this.child});

  final Widget child;

  static const _navItems = [
    NavItem(
      icon:       Icons.dashboard_outlined,
      activeIcon: Icons.dashboard_rounded,
      label:      'Overview',
      route:      AppRoutes.managerOverview,
    ),
    NavItem(
      icon:       Icons.group_outlined,
      activeIcon: Icons.group_rounded,
      label:      'Team',
      route:      AppRoutes.managerTeam,
    ),
    NavItem(
      icon:       Icons.extension_outlined,
      activeIcon: Icons.extension_rounded,
      label:      'Modules',
      route:      AppRoutes.managerModules,
    ),
    NavItem(
      icon:       Icons.folder_outlined,
      activeIcon: Icons.folder_rounded,
      label:      'Content',
      route:      AppRoutes.managerContent,
    ),
    NavItem(
      icon:       Icons.perm_media_outlined,
      activeIcon: Icons.perm_media_rounded,
      label:      'Assets',
      route:      AppRoutes.managerAssets,
    ),
    NavItem(
      icon:       Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label:      'Settings',
      route:      AppRoutes.managerSettings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardShell(
      navItems:       _navItems,
      child:          child,
      portalTitle:    'Manager Portal',
      topBarActions:  const [ManagerNotificationBell()],
    );
  }
}
