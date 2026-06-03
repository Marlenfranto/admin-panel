import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../src/providers.dart';

// ── Feature screens ──────────────────────────────────────────────────────────
// Admin
import '../../features/admin/screens/admin_shell.dart';
import '../../features/admin/screens/organizations_screen.dart';
import '../../features/admin/screens/admin_teams_screen.dart';
import '../../features/admin/screens/users_screen.dart';
import '../../features/admin/screens/admin_modules_screen.dart';
import '../../features/admin/screens/admin_content_screen.dart';
import '../../features/admin/screens/admin_locale_screen.dart';
import '../../features/admin/screens/admin_settings_screen.dart';

// Manager
import '../../features/manager/screens/manager_shell.dart';
import '../../features/manager/screens/manager_overview_screen.dart';
import '../../features/manager/screens/manager_team_screen.dart';
import '../../features/manager/screens/manager_modules_screen.dart';
import '../../features/manager/screens/manager_content_screen.dart';
import '../../features/manager/screens/manager_assets_screen.dart';
import '../../features/manager/screens/manager_settings_screen.dart';
import '../../features/org_admin/screens/org_admin_shell.dart';
import '../../features/org_admin/screens/org_dashboard_screen.dart';
import '../../features/org_admin/screens/org_teams_screen.dart';
import '../../features/org_admin/screens/org_users_screen.dart';
import '../../features/org_admin/screens/org_modules_screen.dart';
import '../../features/org_admin/screens/org_content_screen.dart';
import '../../features/org_admin/screens/org_settings_screen.dart';

// Training History
import '../../features/training_history/screens/training_history_screen.dart';

// User
import '../../features/user/screens/user_shell.dart';
import '../../features/user/screens/user_modules_screen.dart';
import '../../features/user/screens/user_settings_screen.dart';

// Auth
import '../../src/screens/login_screen.dart';

import 'app_routes.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Auth refresh notifier
//
// Wraps auth state changes so GoRouter's [refreshListenable] can react
// to sign-in / sign-out without reaching into Riverpod internals.
// ─────────────────────────────────────────────────────────────────────────────
class _AuthRefreshNotifier extends ChangeNotifier {
  _AuthRefreshNotifier(Ref ref) {
    // Whenever AuthState changes, tell GoRouter to re-evaluate redirects.
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final _authRefreshProvider = Provider<_AuthRefreshNotifier>((ref) {
  return _AuthRefreshNotifier(ref);
});

// ─────────────────────────────────────────────────────────────────────────────
// Router provider
// ─────────────────────────────────────────────────────────────────────────────
final routerProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(_authRefreshProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: false,
    refreshListenable: refreshNotifier,

    // ── Global redirect ─────────────────────────────────────────────────────
    redirect: (context, state) {
      final auth     = ref.read(authProvider);
      final location = state.matchedLocation;
      final isLogin  = location == AppRoutes.login;

      // Still loading the stored session → don't redirect anywhere yet.
      if (auth.isLoading) return null;

      // Not signed in → always send to login
      if (!auth.isSignedIn) {
        return isLogin ? null : AppRoutes.login;
      }

      // Signed in but appUser not yet loaded → wait (return null = no redirect)
      final appUser = auth.appUser;
      if (appUser == null) return null;

      final role = appUser.role;

      // On login page after sign-in → redirect to role home
      if (isLogin || location == AppRoutes.adminRoot ||
          location == AppRoutes.managerRoot ||
          location == AppRoutes.userRoot) {
        return _homeForRole(role);
      }

      // Guard wrong-role access
      if (location.startsWith('/admin') && !_isSuperAdmin(role)) {
        return _homeForRole(role);
      }
      if (location.startsWith('/org-admin') && !_isOrgAdmin(role)) {
        return _homeForRole(role);
      }
      if (location.startsWith('/manager') && role != Role.Manager) {
        return _homeForRole(role);
      }
      if (location.startsWith('/user') && role != Role.User) {
        return _homeForRole(role);
      }

      return null; // no redirect needed
    },

    // ── Routes ──────────────────────────────────────────────────────────────
    routes: [
      // Auth
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => _fadePage(
          state,
          const LoginScreen(),
        ),
      ),

      // ── Admin shell ──────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => AdminShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.adminOrganizations,
            name: 'admin-organizations',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrganizationsScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminTeams,
            name: 'admin-teams',
            pageBuilder: (context, state) =>
                _fadePage(state, const AdminTeamsScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminUsers,
            name: 'admin-users',
            pageBuilder: (context, state) =>
                _fadePage(state, const UsersScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminModules,
            name: 'admin-modules',
            pageBuilder: (context, state) =>
                _fadePage(state, const AdminModulesScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminContent,
            name: 'admin-content',
            pageBuilder: (context, state) =>
                _fadePage(state, const AdminContentScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminLocales,
            name: 'admin-locales',
            pageBuilder: (context, state) =>
                _fadePage(state, const AdminLocaleScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminTrainingHistory,
            name: 'admin-training-history',
            pageBuilder: (context, state) =>
                _fadePage(state, const TrainingHistoryScreen()),
          ),
          GoRoute(
            path: AppRoutes.adminSettings,
            name: 'admin-settings',
            pageBuilder: (context, state) =>
                _fadePage(state, const AdminSettingsScreen()),
          ),
        ],
      ),

      // ── Manager shell ────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => ManagerShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.managerOverview,
            name: 'manager-overview',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerOverviewScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerTeam,
            name: 'manager-team',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerTeamScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerModules,
            name: 'manager-modules',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerModulesScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerContent,
            name: 'manager-content',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerContentScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerAssets,
            name: 'manager-assets',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerAssetsScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerTrainingHistory,
            name: 'manager-training-history',
            pageBuilder: (context, state) =>
                _fadePage(state, const TrainingHistoryScreen()),
          ),
          GoRoute(
            path: AppRoutes.managerSettings,
            name: 'manager-settings',
            pageBuilder: (context, state) =>
                _fadePage(state, const ManagerSettingsScreen()),
          ),
        ],
      ),

      // ── Organization Admin shell ───────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => OrgAdminShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.orgAdminRoot,
            name: 'org-admin-dashboard',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgDashboardScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminTeams,
            name: 'org-admin-teams',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgTeamsScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminUsers,
            name: 'org-admin-users',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgUsersScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminModules,
            name: 'org-admin-modules',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgModulesScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminContent,
            name: 'org-admin-content',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgContentScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminTrainingHistory,
            name: 'org-admin-training-history',
            pageBuilder: (context, state) =>
                _fadePage(state, const TrainingHistoryScreen()),
          ),
          GoRoute(
            path: AppRoutes.orgAdminSettings,
            name: 'org-admin-settings',
            pageBuilder: (context, state) =>
                _fadePage(state, const OrgSettingsScreen()),
          ),
        ],
      ),

      // ── User shell ───────────────────────────────────────────────────────
      ShellRoute(
        builder: (context, state, child) => UserShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.userModules,
            name: 'user-modules',
            pageBuilder: (context, state) =>
                _fadePage(state, const UserModulesScreen()),
          ),
          GoRoute(
            path: AppRoutes.userSettings,
            name: 'user-settings',
            pageBuilder: (context, state) =>
                _fadePage(state, const UserSettingsScreen()),
          ),
        ],
      ),
    ],
  );
});

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

/// 150 ms fade transition used for all page navigations.
CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 150),
    reverseTransitionDuration: const Duration(milliseconds: 100),
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child,
      );
    },
  );
}

bool _isSuperAdmin(Role role) => role == Role.SuperAdmin;
bool _isOrgAdmin(Role role) => role == Role.OrganizationAdmin;

String _homeForRole(Role role) => switch (role) {
  Role.SuperAdmin         => AppRoutes.adminOrganizations,
  Role.OrganizationAdmin  => AppRoutes.orgAdminRoot,
  Role.Manager            => AppRoutes.managerOverview,
  Role.User               => AppRoutes.userModules,
};
