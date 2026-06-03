import 'package:flutter/material.dart';

import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/dashboard_shell.dart';

/// Shell for the User portal. Wraps [DashboardShell] with user nav items.
class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final navItems = <NavItem>[
      NavItem(
        icon:       Icons.view_module_outlined,
        activeIcon: Icons.view_module_rounded,
        label:      t.navMyModules,
        route:      AppRoutes.userModules,
      ),
      NavItem(
        icon:       Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label:      t.navSettings,
        route:      AppRoutes.userSettings,
      ),
    ];

    return DashboardShell(
      navItems:    navItems,
      child:       child,
      portalTitle: t.shellPortalTitle,
    );
  }
}
