import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.admin};

  Future<Organization?> createOrganization(Session session, String name) async {
    var org = Organization(name: name);
    await Organization.db.insertRow(session, org);
    return org;
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

  Future<bool> assignManagerToOrg(
      Session session, int managerAppUserId, int organizationId) async {
    var org = await Organization.db.findById(session, organizationId);
    var manager = await AppUser.db.findById(session, managerAppUserId);

    if (org == null || manager == null || manager.role != Role.Manager) {
      return false;
    }

    org.managerId = manager.id;
    await Organization.db.updateRow(session, org);
    return true;
  }

  Future<List<Organization>> getAllOrganizations(Session session) async {
    return await Organization.db.find(
      session,
      include: Organization.include(
        manager: AppUser.include(
          userInfo: UserInfo.include(),
        ),
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

  Future<List<AppUser>> getAllUsers(Session session, {Role? role}) async {
    return await AppUser.db.find(
      session,
      where: role != null ? (user) => user.role.equals(role) : null,
      include: AppUser.include(
        userInfo: UserInfo.include(),
      ),
    );
  }
}
