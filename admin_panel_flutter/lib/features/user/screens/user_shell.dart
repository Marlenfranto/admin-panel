import 'package:flutter/material.dart';

import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/dashboard_shell.dart';

/// Shell for the User portal. Wraps [DashboardShell] with user nav items.
class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.child});

  final Widget child;

  static const _navItems = [
    NavItem(
      icon:       Icons.view_module_outlined,
      activeIcon: Icons.view_module_rounded,
      label:      'My Modules',
      route:      AppRoutes.userModules,
    ),
    NavItem(
      icon:       Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label:      'Settings',
      route:      AppRoutes.userSettings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardShell(
      navItems:    _navItems,
      child:       child,
      portalTitle: 'My Portal',
    );
  }
}
