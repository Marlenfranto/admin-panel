/// All named route paths used throughout the application.
/// Import this file instead of hard-coding path strings.
abstract final class AppRoutes {
  // ── Auth ──────────────────────────────────────────────────────────────────
  static const login = '/login';

  // ── Admin ─────────────────────────────────────────────────────────────────
  static const adminRoot          = '/admin';
  static const adminOrganizations = '/admin/organizations';
  static const adminUsers         = '/admin/users';
  static const adminModules       = '/admin/modules';
  static const adminContent       = '/admin/content';
  static const adminSettings      = '/admin/settings';

  // ── Manager ───────────────────────────────────────────────────────────────
  static const managerRoot     = '/manager';
  static const managerOverview = '/manager/overview';
  static const managerTeam     = '/manager/team';
  static const managerModules  = '/manager/modules';
  static const managerContent  = '/manager/content';
  static const managerAssets   = '/manager/assets';
  static const managerSettings = '/manager/settings';

  // ── User ──────────────────────────────────────────────────────────────────
  static const userRoot     = '/user';
  static const userModules  = '/user/modules';
  static const userSettings = '/user/settings';
}
