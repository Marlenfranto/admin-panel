/// All named route paths used throughout the application.
/// Import this file instead of hard-coding path strings.
abstract final class AppRoutes {
  // ── Auth ──────────────────────────────────────────────────────────────────
  static const login = '/login';

  // ── Admin ─────────────────────────────────────────────────────────────────
  static const adminRoot          = '/admin';
  static const adminOrganizations = '/admin/organizations';
  static const adminTeams         = '/admin/teams';
  static const adminUsers         = '/admin/users';
  static const adminModules       = '/admin/modules';
  static const adminContent       = '/admin/content';
  static const adminTrainingHistory = '/admin/training-history';
  static const adminSettings      = '/admin/settings';

  // ── Organization Admin ──────────────────────────────────────────────────
  static const orgAdminRoot     = '/org-admin';
  static const orgAdminTeams    = '/org-admin/teams';
  static const orgAdminUsers    = '/org-admin/users';
  static const orgAdminModules  = '/org-admin/modules';
  static const orgAdminContent  = '/org-admin/content';
  static const orgAdminTrainingHistory = '/org-admin/training-history';
  static const orgAdminSettings = '/org-admin/settings';

  // ── Manager ───────────────────────────────────────────────────────────────
  static const managerRoot     = '/manager';
  static const managerOverview = '/manager/overview';
  static const managerTeam     = '/manager/team';
  static const managerModules  = '/manager/modules';
  static const managerContent  = '/manager/content';
  static const managerAssets   = '/manager/assets';
  static const managerTrainingHistory = '/manager/training-history';
  static const managerSettings = '/manager/settings';

  // ── User ──────────────────────────────────────────────────────────────────
  static const userRoot     = '/user';
  static const userModules  = '/user/modules';
  static const userSettings = '/user/settings';
}
