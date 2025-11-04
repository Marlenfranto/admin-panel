import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';

class ManagerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.manager};

  // Helper to verify manager's authority over an organization
  Future<Organization> _getAndVerifyManagedOrganization(Session session, int organizationId) async {
    final authInfo = await session.authenticated;
    final managerUserInfoId = authInfo?.userId;

    if (managerUserInfoId == null) {
      throw Exception('Authentication failed.');
    }

    // Find the manager's AppUser record
    final managerAppUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(managerUserInfoId),
    );
    if (managerAppUser == null) {
      throw Exception('Manager profile not found.');
    }

    // Find the organization and verify the manager
    final org = await Organization.db.findById(session, organizationId);
    if (org == null || org.managerId!= managerAppUser.id) {
      throw Exception('Access denied. You do not manage this organization.');
    }
    return org;
  }

  Future<Organization?> getManagedOrganization(Session session) async {
    // This method finds the organization managed by the currently logged-in user.
    final authInfo = await session.authenticated;
    final managerUserInfoId = authInfo?.userId;
    if (managerUserInfoId == null) return null;

    final managerAppUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(managerUserInfoId),
    );
    if (managerAppUser == null) return null;

    return await Organization.db.findFirstRow(
      session,
      where: (o) => o.managerId.equals(managerAppUser.id),
      include: Organization.include(
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(
            appUser: AppUser.include(
              userInfo: UserInfo.include(),
            ),
          ),
        ),
      ),
    );
  }

  Future<AppUser?> createUserAndAssignToOrg(
    Session session,
    String userName,
    String email,
    String password,
    Role role,
    int organizationId,
  ) async {
    // 1. Create the core UserInfo using the auth module
    var userInfo = await Users.findUserByEmail(session, email);
    if (userInfo != null) {
      throw Exception('User with this email already exists.');
    }

    userInfo = UserInfo(
      userIdentifier: email,
      email: email,
      userName: userName,
      created: DateTime.now().toUtc(),
      scopeNames: [],
      blocked: false,
    );
    userInfo = (await Emails.createUser(session, userName, email, password))!;

    if (userInfo == null) return null;

    // 2. Assign the correct scope based on the role
    if (role == Role.Manager) {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.manager});
    } else {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.user});
    }

    // 3. Create our custom AppUser
    var appUser = AppUser(
      userInfoId: userInfo.id!,
      role: role,
      tools: Tools(), // Default tools
    );
    appUser = await AppUser.db.insertRow(session, appUser);

    // 4. Link the user to the organization
    var organization = await Organization.db.findById(session, organizationId);
    if (organization == null) {
      throw Exception('Organization not found.');
    }

    var link = OrganizationUserLink(
      organizationId: organization.id!,
      appUserId: appUser.id!,
    );
    await OrganizationUserLink.db.insertRow(session, link);

    return appUser;
  }

  Future<bool> removeUserFromOrganization(Session session, int appUserId, int organizationId) async {
    await _getAndVerifyManagedOrganization(session, organizationId); // Record-level security check

    await OrganizationUserLink.db.deleteWhere(
      session,
      where: (link) => link.appUserId.equals(appUserId) & link.organizationId.equals(organizationId),
    );
    return true;
  }
}