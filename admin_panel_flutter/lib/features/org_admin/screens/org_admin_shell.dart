import 'package:flutter/material.dart';
import '../../../core/router/app_routes.dart';
import '../../../shared/widgets/dashboard_shell.dart';

class OrgAdminShell extends StatelessWidget {
  const OrgAdminShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DashboardShell(
      portalTitle: 'Organization Admin',
      navItems: const [
        NavItem(
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard_rounded,
          label: 'Dashboard',
          route: AppRoutes.orgAdminRoot,
        ),
        NavItem(
          icon: Icons.groups_outlined,
          activeIcon: Icons.groups_rounded,
          label: 'Teams',
          route: AppRoutes.orgAdminTeams,
        ),
        NavItem(
          icon: Icons.people_outline_rounded,
          activeIcon: Icons.people_rounded,
          label: 'Users',
          route: AppRoutes.orgAdminUsers,
        ),
        NavItem(
          icon: Icons.tune_outlined,
          activeIcon: Icons.tune_rounded,
          label: 'Modules',
          route: AppRoutes.orgAdminModules,
        ),
        NavItem(
          icon: Icons.history_edu_outlined,
          activeIcon: Icons.history_edu_rounded,
          label: 'Training History',
          route: AppRoutes.orgAdminTrainingHistory,
        ),
        NavItem(
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings_rounded,
          label: 'Settings',
          route: AppRoutes.orgAdminSettings,
        ),
      ],
      child: child,
    );
  }
}
