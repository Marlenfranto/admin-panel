import 'package:flutter/material.dart';

import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/dashboard_shell.dart';

/// Shell for the Admin portal. Wraps [DashboardShell] with admin nav items.
class AdminShell extends StatelessWidget {
  const AdminShell({super.key, required this.child});

  final Widget child;

  static const _navItems = [
    NavItem(
      icon:       Icons.corporate_fare_outlined,
      activeIcon: Icons.corporate_fare_rounded,
      label:      'Organizations',
      route:      AppRoutes.adminOrganizations,
    ),
    NavItem(
      icon:       Icons.groups_outlined,
      activeIcon: Icons.groups_rounded,
      label:      'Teams',
      route:      AppRoutes.adminTeams,
    ),
    NavItem(
      icon:       Icons.people_outline_rounded,
      activeIcon: Icons.people_rounded,
      label:      'Users',
      route:      AppRoutes.adminUsers,
    ),
    NavItem(
      icon:       Icons.extension_outlined,
      activeIcon: Icons.extension_rounded,
      label:      'Modules',
      route:      AppRoutes.adminModules,
    ),
    NavItem(
      icon:       Icons.folder_outlined,
      activeIcon: Icons.folder_rounded,
      label:      'Content',
      route:      AppRoutes.adminContent,
    ),
    NavItem(
      icon:       Icons.language_outlined,
      activeIcon: Icons.language_rounded,
      label:      'Locales',
      route:      AppRoutes.adminLocales,
    ),
    NavItem(
      icon:       Icons.history_edu_outlined,
      activeIcon: Icons.history_edu_rounded,
      label:      'Training History',
      route:      AppRoutes.adminTrainingHistory,
    ),
    NavItem(
      icon:       Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label:      'Settings',
      route:      AppRoutes.adminSettings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DashboardShell(
      navItems:    _navItems,
      child:       child,
      portalTitle: 'Admin Portal',
    );
  }
}
