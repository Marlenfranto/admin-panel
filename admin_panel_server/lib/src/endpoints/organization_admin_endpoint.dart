import 'package:admin_panel_server/src/util/default_locale_writer.dart';
import 'package:admin_panel_server/src/util/locale_resolver.dart';
import 'package:admin_panel_server/src/util/locale_validator.dart';
import 'package:admin_panel_server/src/util/version_util.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';

class OrganizationAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {};

  Future<void> _checkBasePermission(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) throw Exception('Not logged in.');
    if (!authInfo.scopes.contains(AppScopes.admin) &&
        !authInfo.scopes.contains(AppScopes.organizationAdmin)) {
      throw Exception('Forbidden: Insufficient permissions.');
    }
  }

  Future<AppUser?> _getCallerAppUser(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;
    return await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
  }

  /// Returns the top-level organization managed by the caller.
  Future<Organization?> getMyOrganization(Session session) async {
    await _checkBasePermission(session);
    final caller = await _getCallerAppUser(session);
    if (caller == null) return null;

    // Primary lookup: org where the caller is the designated manager.
    var org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.managerId.equals(caller.id) & o.parentId.equals(null),
      include: Organization.include(
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(
            appUser: AppUser.include(userInfo: UserInfo.include()),
          ),
        ),
      ),
    );
    if (org != null) return org;

    // Fallback: find a parent org the caller is linked to via OrganizationUserLink.
    final link = await OrganizationUserLink.db.findFirstRow(
      session,
      where: (l) => l.appUserId.equals(caller.id),
    );
    if (link == null) return null;

    final candidate = await Organization.db.findById(session, link.organizationId);
    if (candidate == null) return null;

    // If this is a team (has a parent), look up the parent org instead.
    final parentId = candidate.parentId ?? candidate.id!;
    return await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(parentId),
      include: Organization.include(
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(
            appUser: AppUser.include(userInfo: UserInfo.include()),
          ),
        ),
      ),
    );
  }

  /// Creates a new Team (child organization) within the specified parent organization.
  Future<Organization?> createTeam(
    Session session,
    String name,
    int parentOrgId,
    String? imageUrl,
  ) async {
    await _checkBasePermission(session);
    final caller = await _getCallerAppUser(session);
    if (caller == null) return null;

    // Check if caller has permission for this parent org.
    // SuperAdmin can do anything. OrgAdmin must own parentOrgId.
    final authInfo = await session.authenticated;
    if (authInfo != null && !authInfo.scopes.contains(AppScopes.admin)) {
      final callerOrg = await _getCallerOrg(session);
      if (callerOrg == null || callerOrg.id != parentOrgId) {
        throw Exception('Unauthorized: You can only create teams within your own organization.');
      }
    }

    var team = Organization(
      name: name,
      imageUrl: imageUrl,
      parentId: parentOrgId,
    );
    team = await Organization.db.insertRow(session, team);
    return team;
  }

  /// Returns all teams (child organizations) for a given parent organization.
  Future<List<Organization>> getTeams(Session session, int parentOrgId) async {
    await _checkBasePermission(session);
    return await Organization.db.find(
      session,
      where: (o) => o.parentId.equals(parentOrgId),
      include: Organization.include(
        manager: AppUser.include(userInfo: UserInfo.include()),
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(
            appUser: AppUser.include(userInfo: UserInfo.include()),
          ),
        ),
      ),
    );
  }

  /// Assigns a manager to a team.
  Future<bool> assignManagerToTeam(
    Session session,
    int managerAppUserId,
    int teamId,
  ) async {
    await _checkBasePermission(session);
    final caller = await _getCallerAppUser(session);
    if (caller == null) return false;

    final team = await Organization.db.findById(session, teamId);
    if (team == null || team.parentId == null) return false;

    // Permission check
    final authInfo = await session.authenticated;
    if (authInfo != null && !authInfo.scopes.contains(AppScopes.admin)) {
      final callerOrg = await _getCallerOrg(session);
      if (callerOrg == null || callerOrg.id != team.parentId) {
        throw Exception('Unauthorized: You can only manage teams within your own organization.');
      }
    }

    final manager = await AppUser.db.findById(session, managerAppUserId);
    if (manager == null || manager.role != Role.Manager) {
      throw Exception('User must have the Manager role.');
    }

    team.managerId = manager.id;
    await Organization.db.updateRow(session, team);

    // Also ensure the manager is linked to the team organization.
    final existingLink = await OrganizationUserLink.db.findFirstRow(
      session,
      where: (l) => l.organizationId.equals(teamId) & l.appUserId.equals(managerAppUserId),
    );
    if (existingLink == null) {
      await OrganizationUserLink.db.insertRow(
        session,
        OrganizationUserLink(organizationId: teamId, appUserId: managerAppUserId),
      );
    }

    return true;
  }

  /// Deletes a team and all its user links.
  Future<bool> deleteTeam(Session session, int teamId) async {
    await _checkBasePermission(session);
    final caller = await _getCallerAppUser(session);
    if (caller == null) return false;

    final team = await Organization.db.findById(session, teamId);
    if (team == null || team.parentId == null) return false;

    final authInfo = await session.authenticated;
    if (authInfo != null && !authInfo.scopes.contains(AppScopes.admin)) {
      final callerOrg = await _getCallerOrg(session);
      if (callerOrg == null || callerOrg.id != team.parentId) {
        throw Exception('Unauthorized: You can only delete teams within your organization.');
      }
    }

    await OrganizationUserLink.db.deleteWhere(
      session,
      where: (l) => l.organizationId.equals(teamId),
    );
    await Organization.db.deleteRow(session, team);
    return true;
  }

  /// Updates the name of a team.
  Future<bool> updateTeam(Session session, int teamId, String name) async {
    await _checkBasePermission(session);
    final team = await Organization.db.findById(session, teamId);
    if (team == null || team.parentId == null) return false;

    final authInfo = await session.authenticated;
    if (authInfo != null && !authInfo.scopes.contains(AppScopes.admin)) {
      final callerOrg = await _getCallerOrg(session);
      if (callerOrg == null || callerOrg.id != team.parentId) {
        throw Exception('Unauthorized: You can only edit teams within your organization.');
      }
    }

    team.name = name.trim();
    await Organization.db.updateRow(session, team);
    return true;
  }

  /// Creates a new user (Manager or User) and assigns them to a team.
  Future<AppUser?> createUserInTeam(
    Session session,
    String userName,
    String email,
    String password,
    Role role,
    int teamId,
  ) async {
    await _checkBasePermission(session);
    if (role == Role.SuperAdmin || role == Role.OrganizationAdmin) {
      throw Exception('Cannot create highly privileged roles via this endpoint.');
    }

    final team = await Organization.db.findById(session, teamId);
    if (team == null || team.parentId == null) throw Exception('Team not found.');

    // Authentication/Permission check (caller must manage the parent organization)
    final caller = await _getCallerAppUser(session);
    if (caller == null) throw Exception('Authentication failed.');

    final authInfo = await session.authenticated;
    if (authInfo != null && !authInfo.scopes.contains(AppScopes.admin)) {
      final callerOrg = await _getCallerOrg(session);
      if (callerOrg == null || callerOrg.id != team.parentId) {
        throw Exception('Unauthorized.');
      }
    }

    var existingUser = await Users.findUserByEmail(session, email);
    if (existingUser != null) throw Exception('User with this email already exists.');

    var userInfo = (await Emails.createUser(session, userName, email, password))!;
    if (role == Role.Manager) {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.manager});
    } else {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.user});
    }

    var appUser = AppUser(userInfoId: userInfo.id!, role: role);
    appUser = await AppUser.db.insertRow(session, appUser);

    var link = OrganizationUserLink(organizationId: teamId, appUserId: appUser.id!);
    await OrganizationUserLink.db.insertRow(session, link);

    if (role == Role.Manager && team.managerId == null) {
      team.managerId = appUser.id;
      await Organization.db.updateRow(session, team);
    }

    return appUser;
  }

  // ── User management ───────────────────────────────────────────────────────

  /// Updates the name and role of a Manager/User within the caller's org.
  Future<bool> updateOrgUser(
    Session session,
    int    appUserId,
    String userName,
    Role   role,
  ) async {
    await _checkBasePermission(session);
    if (role == Role.SuperAdmin || role == Role.OrganizationAdmin) {
      throw Exception('Cannot assign SuperAdmin or OrganizationAdmin role.');
    }

    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');

    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;
    if (appUser.role == Role.SuperAdmin || appUser.role == Role.OrganizationAdmin) {
      throw Exception('Cannot modify privileged users.');
    }

    if (!await _isUserInOrg(session, appUserId, org!.id!)) {
      throw Exception('User does not belong to your organization.');
    }

    if (appUser.role != role) {
      appUser.role = role;
      await AppUser.db.updateRow(session, appUser);
      final scope = role == Role.Manager ? AppScopes.manager : AppScopes.user;
      await Users.updateUserScopes(session, appUser.userInfoId, {scope});
    }

    final userInfo = await UserInfo.db.findById(session, appUser.userInfoId);
    if (userInfo != null && userInfo.userName != userName) {
      userInfo.userName = userName;
      await UserInfo.db.updateRow(session, userInfo);
    }

    return true;
  }

  /// Deletes a Manager/User from the caller's org entirely.
  Future<bool> deleteOrgUser(Session session, int appUserId) async {
    await _checkBasePermission(session);

    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');

    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;
    if (appUser.role == Role.SuperAdmin || appUser.role == Role.OrganizationAdmin) {
      throw Exception('Cannot delete privileged users.');
    }

    if (!await _isUserInOrg(session, appUserId, org!.id!)) {
      throw Exception('User does not belong to your organization.');
    }

    final userInfoId = appUser.userInfoId;

    await UserModuleProgress.db.deleteWhere(
        session, where: (p) => p.appUserId.equals(appUserId));
    await OrganizationUserLink.db.deleteWhere(
        session, where: (l) => l.appUserId.equals(appUserId));
    await ManagerNotification.db.deleteWhere(
        session, where: (n) => n.overdueUserId.equals(appUserId));
    await ManagerNotification.db.deleteWhere(
        session, where: (n) => n.managerId.equals(appUserId));
    await AppUser.db.deleteRow(session, appUser);

    final userInfo = await UserInfo.db.findById(session, userInfoId);
    if (userInfo != null) await UserInfo.db.deleteRow(session, userInfo);

    return true;
  }

  /// Resets the password of a user within the caller's org.
  Future<bool> resetOrgUserPassword(
    Session session,
    int    appUserId,
    String newPassword,
  ) async {
    await _checkBasePermission(session);
    if (newPassword.trim().isEmpty) {
      throw Exception('New password cannot be empty.');
    }

    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');

    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;

    if (!await _isUserInOrg(session, appUserId, org!.id!)) {
      throw Exception('User does not belong to your organization.');
    }

    final emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(appUser.userInfoId),
    );
    if (emailAuth == null) return false;

    emailAuth.hash = await Emails.generatePasswordHash(newPassword);
    await EmailAuth.db.updateRow(session, emailAuth);
    return true;
  }

  // ── Internal helper ───────────────────────────────────────────────────────

  /// Returns the top-level org managed by the caller (without user includes).
  /// Falls back to OrganizationUserLink if no org has the caller as managerId.
  Future<Organization?> _getCallerOrg(Session session) async {
    final caller = await _getCallerAppUser(session);
    if (caller == null) return null;

    final byManager = await Organization.db.findFirstRow(
      session,
      where: (o) => o.managerId.equals(caller.id) & o.parentId.equals(null),
    );
    if (byManager != null) return byManager;

    // Fallback for accounts not yet set as managerId on the org.
    final link = await OrganizationUserLink.db.findFirstRow(
      session,
      where: (l) => l.appUserId.equals(caller.id),
    );
    if (link == null) return null;

    final candidate = await Organization.db.findById(session, link.organizationId);
    if (candidate == null) return null;

    // If the linked org is a team, return its parent instead.
    final parentId = candidate.parentId ?? candidate.id!;
    return await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(parentId),
    );
  }

  /// Returns true if [appUserId] is a member of [orgId] or any of its teams.
  Future<bool> _isUserInOrg(
      Session session, int appUserId, int orgId) async {
    final direct = await OrganizationUserLink.db.findFirstRow(
      session,
      where: (l) =>
          l.appUserId.equals(appUserId) & l.organizationId.equals(orgId),
    );
    if (direct != null) return true;

    final teams = await Organization.db.find(
      session,
      where: (o) => o.parentId.equals(orgId),
    );
    for (final team in teams) {
      if (team.id == null) continue;
      final teamLink = await OrganizationUserLink.db.findFirstRow(
        session,
        where: (l) =>
            l.appUserId.equals(appUserId) &
            l.organizationId.equals(team.id!),
      );
      if (teamLink != null) return true;
    }
    return false;
  }

  // ── Module config ─────────────────────────────────────────────────────────

  Future<ModuleConfig?> getModuleConfig(Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return null;
    return await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(org!.id),
    );
  }

  Future<ModuleConfig?> setModuleConfig(
    Session session,
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String defaultLanguage,
    List<SupportedLanguage> supportedLanguages,
    String? aiChatPrompt,
    List<LocalizedAiPrompt>? aiChatPromptTranslations,
    int passingPercentage,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return null;
    final orgId = org!.id!;

    var existing = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(orgId),
    );

    ModuleConfig? result;
    if (existing != null) {
      existing.theoryModule        = theoryModule;
      existing.aiExpertModule      = aiExpertModule;
      existing.smartTrainingModule = smartTrainingModule;
      existing.assessmentModule    = assessmentModule;
      existing.defaultLanguage     = defaultLanguage;
      existing.supportedLanguages  = supportedLanguages;
      existing.aiChatPrompt        = aiChatPrompt;
      existing.aiChatPromptTranslations = aiChatPromptTranslations;
      existing.passingPercentage   = passingPercentage;
      result = await ModuleConfig.db.updateRow(session, existing);
    } else {
      result = await ModuleConfig.db.insertRow(
        session,
        ModuleConfig(
          organizationId:      orgId,
          theoryModule:        theoryModule,
          aiExpertModule:      aiExpertModule,
          smartTrainingModule: smartTrainingModule,
          assessmentModule:    assessmentModule,
          defaultLanguage:     defaultLanguage,
          supportedLanguages:  supportedLanguages,
          aiChatPrompt:        aiChatPrompt,
          aiChatPromptTranslations: aiChatPromptTranslations,
          passingPercentage:   passingPercentage,
        ),
      );
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<List<UserModuleProgress>> getOrgUserModuleProgress(
    Session session,
    int userId,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    return await UserModuleProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(userId) & p.organizationId.equals(org!.id),
    );
  }

  Future<UserModuleProgress?> setOrgUserModuleProgress(
    Session session,
    int    userId,
    String moduleId,
    bool   isEnabled,
    DateTime? deadline,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return null;
    final orgId = org!.id!;

    var existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(userId) &
          p.organizationId.equals(orgId) &
          p.moduleId.equals(moduleId),
    );

    if (existing != null) {
      existing.isEnabled = isEnabled;
      existing.deadline  = deadline;
      return await UserModuleProgress.db.updateRow(session, existing);
    }

    return await UserModuleProgress.db.insertRow(
      session,
      UserModuleProgress(
        appUserId:      userId,
        organizationId: orgId,
        moduleId:       moduleId,
        isEnabled:      isEnabled,
        deadline:       deadline,
        status:         ModuleProgressStatus.notStarted,
      ),
    );
  }

  Future<UserModuleProgress?> updateOrgUserModuleStatus(
    Session session,
    int    userId,
    String moduleId,
    ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return null;

    var existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(userId) &
          p.organizationId.equals(org!.id) &
          p.moduleId.equals(moduleId),
    );
    if (existing == null) return null;

    existing.status      = status;
    existing.startedAt   = startedAt;
    existing.completedAt = completedAt;
    return await UserModuleProgress.db.updateRow(session, existing);
  }

  // ── Theory chapters ───────────────────────────────────────────────────────

  Future<List<TheoryChapter>> getOrgTheoryChapters(Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(org!.id),
      orderBy: (c) => c.chapterOrder,
    );
    await hydrateTheoryChapters(session, chapters);
    return chapters;
  }

  Future<TheoryChapter> upsertOrgTheoryChapter(
      Session session, TheoryChapter chapter) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;
    chapter.organizationId = orgId;

    final TheoryChapter result;
    if (chapter.id != null) {
      result = await TheoryChapter.db.updateRow(session, chapter);
    } else {
      result = await TheoryChapter.db.insertRow(session, chapter);
    }
    final resultId = result.id;
    if (resultId != null) {
      await writeTheoryChapterDefaultContent(
        session,
        resultId,
        orgId,
        title: chapter.title,
        description: chapter.description,
        thumbnailUrl: chapter.thumbnailUrl,
        videoUrl: chapter.videoUrl,
        videoMetadata: chapter.videoMetadata,
      );
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteOrgTheoryChapter(Session session, int chapterId) async {
    await _checkBasePermission(session);
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null) return false;
    await TheoryChapter.db.deleteRow(session, chapter);
    if (chapter.organizationId != null) {
      await bumpOrgContentVersion(session, chapter.organizationId!);
    }
    return true;
  }

  // ── Training parameters ───────────────────────────────────────────────────

  Future<List<TrainingParameter>> getOrgTrainingParameters(
      Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(org!.id),
    );
    await hydrateTrainingParameters(session, params);
    return params;
  }

  Future<TrainingParameter> upsertOrgTrainingParameter(
      Session session, TrainingParameter param) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;
    param.organizationId = orgId;

    final TrainingParameter result;
    if (param.id != null) {
      result = await TrainingParameter.db.updateRow(session, param);
    } else {
      result = await TrainingParameter.db.insertRow(session, param);
    }
    final resultId = result.id;
    if (resultId != null) {
      await writeTrainingParameterDefaultContent(
        session,
        resultId,
        orgId,
        name: param.name,
        description: param.description,
      );
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteOrgTrainingParameter(
      Session session, int paramId) async {
    await _checkBasePermission(session);
    final param = await TrainingParameter.db.findById(session, paramId);
    if (param == null) return false;
    await TrainingParameter.db.deleteRow(session, param);
    if (param.organizationId != null) {
      await bumpOrgContentVersion(session, param.organizationId!);
    }
    return true;
  }

  // ── Assessment parameters ─────────────────────────────────────────────────

  Future<List<AssessmentParameter>> getOrgAssessmentParameters(
      Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(org!.id),
    );
    await hydrateAssessmentParameters(session, params);
    return params;
  }

  Future<AssessmentParameter> upsertOrgAssessmentParameter(
      Session session, AssessmentParameter param) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;
    param.organizationId = orgId;

    final AssessmentParameter result;
    if (param.id != null) {
      result = await AssessmentParameter.db.updateRow(session, param);
    } else {
      result = await AssessmentParameter.db.insertRow(session, param);
    }
    final resultId = result.id;
    if (resultId != null) {
      await writeAssessmentParameterDefaultContent(
        session,
        resultId,
        orgId,
        name: param.name,
        description: param.description,
      );
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteOrgAssessmentParameter(
      Session session, int paramId) async {
    await _checkBasePermission(session);
    final param = await AssessmentParameter.db.findById(session, paramId);
    if (param == null) return false;
    await AssessmentParameter.db.deleteRow(session, param);
    if (param.organizationId != null) {
      await bumpOrgContentVersion(session, param.organizationId!);
    }
    return true;
  }

  // ── Assets ────────────────────────────────────────────────────────────────

  Future<List<Asset>> getOrgAssets(Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(org!.id),
    );
    await hydrateAssets(session, assets);
    return assets;
  }

  Future<Asset> upsertOrgAsset(Session session, Asset asset) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;
    asset.organizationId = orgId;

    final Asset result;
    if (asset.id != null) {
      result = await Asset.db.updateRow(session, asset);
    } else {
      result = await Asset.db.insertRow(session, asset);
    }
    final resultId = result.id;
    if (resultId != null) {
      await writeAssetDefaultContent(
        session,
        resultId,
        orgId,
        name: asset.name,
        description: asset.description,
        url: asset.url,
      );
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteOrgAsset(Session session, int assetId) async {
    await _checkBasePermission(session);
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null) return false;
    await Asset.db.deleteRow(session, asset);
    if (asset.organizationId != null) {
      await bumpOrgContentVersion(session, asset.organizationId!);
    }
    return true;
  }

  // ── Training history ──────────────────────────────────────────────────────

  /// Returns paginated and filtered Smart Training results for Org Admins.
  Future<TrainingSessionResultPage> getTrainingHistory(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;

    final offset = (page - 1) * limit;

    // Use Expression type for complex query building.
    Expression where;
    if (teamId != null) {
      // Security check: is teamId a child of orgId?
      final team = await Organization.db.findById(session, teamId);
      if (team?.parentId != orgId) throw Exception('Unauthorized access to team.');
      where = TrainingSessionResult.t.organizationId.equals(teamId);
    } else {
      // Find all sub-orgs (teams) for this organization.
      final teams = await Organization.db.find(
        session,
        where: (o) => o.parentId.equals(orgId),
      );
      final orgIds = {orgId, ...teams.map((t) => t.id!)};
      where = TrainingSessionResult.t.organizationId.inSet(orgIds);
    }

    if (start != null) {
      where = where & (TrainingSessionResult.t.completedAt >= start);
    }
    if (end != null) {
      where = where & (TrainingSessionResult.t.completedAt <= end);
    }
    if (passed != null) {
      final passingPercentage = 60; 
      if (passed) {
        where = where & (TrainingSessionResult.t.overallPercentage >= passingPercentage);
      } else {
        where = where & (TrainingSessionResult.t.overallPercentage < passingPercentage);
      }
    }

    if (search != null && search.trim().isNotEmpty) {
      final query = search.trim().toLowerCase();
      where = where & (TrainingSessionResult.t.appUser.userInfo.userName.ilike('%$query%') | 
               TrainingSessionResult.t.appUser.userInfo.email.ilike('%$query%'));
    }

    final results = await TrainingSessionResult.db.find(
      session,
      where: (_) => where,
      limit: limit,
      offset: offset,
      orderBy: (r) => r.completedAt,
      orderDescending: true,
      include: TrainingSessionResult.include(
        appUser: AppUser.include(userInfo: UserInfo.include()),
        organization: Organization.include(),
      ),
    );

    final totalCount = await TrainingSessionResult.db.count(
      session,
      where: (_) => where,
    );

    return TrainingSessionResultPage(
      results: results,
      totalCount: totalCount,
      hasMore: offset + results.length < totalCount,
    );
  }

  Future<List<TrainingSessionResult>> getOrgUserTrainingHistory(
    Session session,
    int userId,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) return [];
    final orgId = org!.id!;

    final byAppUser = await TrainingSessionResult.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(orgId) & r.appUserId.equals(userId),
    );
    final byExternal = await TrainingSessionResult.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(orgId) &
          r.externalUserId.equals(userId.toString()),
    );
    final seen    = <int>{};
    final results = [...byAppUser, ...byExternal]
        .where((r) => r.id != null && seen.add(r.id!))
        .toList()
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  // ── Training summaries (Grouped by User) ──────────────────────────────────
  
  /// Returns a grouped overview of training results per user, scoped to the caller's organization.
  Future<TrainingUserSummaryPage> getTrainingUserSummaries(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    final orgId = org!.id!;

    final offset = (page - 1) * limit;

    // 1. Resolve organization filters scoped to this org.
    Set<int> targetOrgIds;
    if (teamId != null) {
      // Security check: is teamId a child of orgId?
      final team = await Organization.db.findById(session, teamId);
      if (team?.parentId != orgId) throw Exception('Unauthorized access to team.');
      targetOrgIds = {teamId};
    } else {
      // Find all sub-orgs (teams) for this organization.
      final teams = await Organization.db.find(
        session,
        where: (o) => o.parentId.equals(orgId),
        limit: 1000,
      );
      targetOrgIds = {orgId, ...teams.map((t) => t.id!)};
    }

    // 2. Identify the AppUser IDs belonging to these organizations.
    final links = await OrganizationUserLink.db.find(
      session,
      where: (l) => l.organizationId.inSet(targetOrgIds),
    );
    final targetUserIds = links.map((l) => l.appUserId).toSet();
    
    if (targetUserIds.isEmpty) {
      return TrainingUserSummaryPage(summaries: [], totalCount: 0, hasMore: false);
    }

    // 3. Build the core filter (Users in org + optional search).
    Expression where = TrainingSessionResult.t.appUserId.inSet(targetUserIds);

    if (search != null && search.trim().isNotEmpty) {
      final query = search.trim().toLowerCase();
      where = where & (TrainingSessionResult.t.appUser.userInfo.userName.ilike('%$query%') | 
               TrainingSessionResult.t.appUser.userInfo.email.ilike('%$query%'));
    }

    if (start != null) {
      where = where & (TrainingSessionResult.t.completedAt >= start);
    }
    if (end != null) {
      where = where & (TrainingSessionResult.t.completedAt <= end);
    }
    if (passed != null) {
      const passingPercentage = 60;
      if (passed) {
        where = where & (TrainingSessionResult.t.overallPercentage >= passingPercentage);
      } else {
        where = where & (TrainingSessionResult.t.overallPercentage < passingPercentage);
      }
    }

    // 4. Fetch results and group them.
    final results = await TrainingSessionResult.db.find(
      session,
      where: (_) => where,
      orderBy: (r) => r.completedAt,
      orderDescending: true,
      limit: 5000,
      include: TrainingSessionResult.include(
        appUser: AppUser.include(userInfo: UserInfo.include()),
        organization: Organization.include(),
      ),
    );

    final List<TrainingSessionResult> uniqueUserResults = [];
    final seenUids = <int>{};
    for (final res in results) {
      if (seenUids.add(res.appUserId!)) {
        uniqueUserResults.add(res);
      }
    }

    // 5. Hierarchy Resolution (Identical to AdminEndpoint logic).
    final uids = uniqueUserResults.map((r) => r.appUserId!).toSet();
    final allLinks = await OrganizationUserLink.db.find(
      session,
      where: (l) => l.appUserId.inSet(uids),
      include: OrganizationUserLink.include(organization: Organization.include()),
    );
    
    final userLinksMap = <int, List<OrganizationUserLink>>{};
    for (final link in allLinks) {
       (userLinksMap[link.appUserId] ??= []).add(link);
    }

    final parentIds = allLinks
        .map((l) => l.organization?.parentId)
        .where((id) => id != null)
        .cast<int>()
        .toSet();
    
    final Map<int, Organization> parentMap = {};
    if (parentIds.isNotEmpty) {
      final parents = await Organization.db.find(
        session,
        where: (o) => o.id.inSet(parentIds),
      );
      for (final p in parents) {
        if (p.id != null) parentMap[p.id!] = p;
      }
    }

    final allSummaries = uniqueUserResults.map((res) {
      final uid = res.appUserId!;
      final userLinks = userLinksMap[uid] ?? [];
      
      Organization? userTeam;
      Organization? userParent;
      
      for (final link in userLinks) {
        final o = link.organization;
        if (o == null) continue;
        if (o.parentId != null) {
          userTeam = o;
          userParent = parentMap[o.parentId];
          break;
        }
      }
      
      if (userTeam == null && userLinks.isNotEmpty) {
        userTeam = userLinks.first.organization;
      }
      userTeam ??= res.organization;

      final userTotal = results.where((r) => r.appUserId == uid).length;

      return TrainingUserSummary(
        user: res.appUser!,
        parentOrg: userParent,
        team: userTeam!,
        latestResult: res,
        totalSessions: userTotal,
      );
    }).toList();
    
    final pagedSummaries = allSummaries.length > offset 
        ? allSummaries.sublist(offset, (offset + limit).clamp(0, allSummaries.length))
        : <TrainingUserSummary>[];

    return TrainingUserSummaryPage(
      summaries: pagedSummaries,
      totalCount: allSummaries.length,
      hasMore: offset + pagedSummaries.length < allSummaries.length,
    );
  }

  /// Returns all Smart Training results for [appUserId] scoped to the caller's organization.
  Future<List<TrainingSessionResult>> getUserTrainingHistory(
    Session session,
    int appUserId,
  ) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org?.id == null) throw Exception('Organization not found.');
    
    // Security check: is the user in the org?
    if (!await _isUserInOrg(session, appUserId, org!.id!)) {
      throw Exception('User does not belong to your organization.');
    }

    final byAppUser = await TrainingSessionResult.db.find(
      session,
      where: (r) => r.appUserId.equals(appUserId),
    );
    final byExternal = await TrainingSessionResult.db.find(
      session,
      where: (r) => r.externalUserId.equals(appUserId.toString()),
    );
    final seen = <int>{};
    final results = [...byAppUser, ...byExternal]
        .where((r) => r.id != null && seen.add(r.id!))
        .toList()
      ..sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  // ── Regions & Locales (scoped to caller's org) ────────────────────────────

  Future<int> _requireOwnedOrgId(Session session) async {
    await _checkBasePermission(session);
    final org = await _getCallerOrg(session);
    if (org == null || org.id == null) {
      throw Exception('No organization found for caller.');
    }
    return org.id!;
  }

  Future<List<Region>> listMyRegions(Session session) async {
    final orgId = await _requireOwnedOrgId(session);
    return await Region.db.find(
      session,
      where: (r) => r.organizationId.equals(orgId),
      orderBy: (r) => r.code,
    );
  }

  Future<Region> upsertMyRegion(Session session, Region region) async {
    final orgId = await _requireOwnedOrgId(session);
    region.organizationId = orgId;
    final Region result;
    if (region.id != null) {
      result = await Region.db.updateRow(session, region);
    } else {
      result = await Region.db.insertRow(session, region);
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteMyRegion(Session session, int regionId) async {
    final orgId = await _requireOwnedOrgId(session);
    final region = await Region.db.findById(session, regionId);
    if (region == null || region.organizationId != orgId) return false;
    final inUse = await LocaleConfig.db.findFirstRow(
      session,
      where: (l) =>
          l.organizationId.equals(orgId) & l.regionCode.equals(region.code),
    );
    if (inUse != null) {
      throw Exception(
        'Cannot delete region "${region.code}": locale '
        '"${inUse.localeKey}" is still using it.',
      );
    }
    await Region.db.deleteRow(session, region);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  Future<List<LocaleConfig>> listMyLocaleConfigs(Session session) async {
    final orgId = await _requireOwnedOrgId(session);
    return await LocaleConfig.db.find(
      session,
      where: (l) => l.organizationId.equals(orgId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<LocaleConfig> upsertMyLocaleConfig(
    Session session,
    LocaleConfig locale,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyComposition(
      locale.localeKey,
      locale.regionCode,
      locale.languageCode,
    );
    await ensureRegionExists(session, orgId, locale.regionCode);
    locale.organizationId = orgId;

    final LocaleConfig result;
    if (locale.id != null) {
      result = await LocaleConfig.db.updateRow(session, locale);
    } else {
      result = await LocaleConfig.db.insertRow(session, locale);
    }
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteMyLocaleConfig(Session session, int localeConfigId) async {
    final orgId = await _requireOwnedOrgId(session);
    final locale = await LocaleConfig.db.findById(session, localeConfigId);
    if (locale == null || locale.organizationId != orgId) return false;
    if (locale.isDefault) {
      throw Exception(
        'Cannot delete the default locale "${locale.localeKey}". '
        'Set another locale as default first.',
      );
    }
    await LocaleConfig.db.deleteRow(session, locale);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  Future<LocaleConfig?> setMyDefaultLocale(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyFormat(localeKey);

    final target = await LocaleConfig.db.findFirstRow(
      session,
      where: (l) =>
          l.organizationId.equals(orgId) & l.localeKey.equals(localeKey),
    );
    if (target == null) {
      throw Exception(
        'Locale "$localeKey" is not configured for this organization.',
      );
    }

    final others = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(orgId) &
          l.isDefault.equals(true) &
          l.id.notEquals(target.id),
    );
    for (final o in others) {
      o.isDefault = false;
      await LocaleConfig.db.updateRow(session, o);
    }
    target.isDefault = true;
    final updated = await LocaleConfig.db.updateRow(session, target);

    final cfg = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(orgId),
    );
    if (cfg != null) {
      cfg.defaultLocaleKey = localeKey;
      await ModuleConfig.db.updateRow(session, cfg);
    }
    await bumpOrgContentVersion(session, orgId);
    return updated;
  }

  // ── Localization CRUD (own org) ───────────────────────────────────────────

  Future<List<TheoryChapterLocalization>> listMyTheoryChapterLocalizations(
    Session session,
    int chapterId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null || chapter.organizationId != orgId) return [];
    return await TheoryChapterLocalization.db.find(
      session,
      where: (l) => l.chapterId.equals(chapterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<TheoryChapterLocalization> upsertMyTheoryChapterLocalization(
    Session session,
    int chapterId,
    TheoryChapterLocalization loc,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null || chapter.organizationId != orgId) {
      throw Exception('Theory chapter not found in your organization.');
    }
    await ensureLocaleConfigured(session, orgId, loc.localeKey);
    loc.chapterId = chapterId;
    final result = loc.id != null
        ? await TheoryChapterLocalization.db.updateRow(session, loc)
        : await TheoryChapterLocalization.db.insertRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<void> setMyTheoryChapterQuizTranslations(
    Session session,
    int chapterId,
    String localeKey,
    List<LocalizedQuizContent> questionTranslations,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null || chapter.organizationId != orgId) {
      throw Exception('Theory chapter not found in your organization.');
    }
    await ensureLocaleConfigured(session, orgId, localeKey);
    await writeTheoryChapterQuizTranslations(
      session,
      chapterId,
      localeKey,
      questionTranslations,
    );
    await bumpOrgContentVersion(session, orgId);
  }

  Future<bool> deleteMyTheoryChapterLocalization(
    Session session,
    int localizationId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final loc =
        await TheoryChapterLocalization.db.findById(session, localizationId);
    if (loc == null) return false;
    final chapter = await TheoryChapter.db.findById(session, loc.chapterId);
    if (chapter == null || chapter.organizationId != orgId) return false;
    await TheoryChapterLocalization.db.deleteRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  Future<List<TrainingParameterLocalization>>
      listMyTrainingParameterLocalizations(
    Session session,
    int parameterId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final param =
        await TrainingParameter.db.findById(session, parameterId);
    if (param == null || param.organizationId != orgId) return [];
    return await TrainingParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.equals(parameterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<TrainingParameterLocalization> upsertMyTrainingParameterLocalization(
    Session session,
    int parameterId,
    TrainingParameterLocalization loc,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final param =
        await TrainingParameter.db.findById(session, parameterId);
    if (param == null || param.organizationId != orgId) {
      throw Exception('Training parameter not found in your organization.');
    }
    await ensureLocaleConfigured(session, orgId, loc.localeKey);
    loc.parameterId = parameterId;
    final result = loc.id != null
        ? await TrainingParameterLocalization.db.updateRow(session, loc)
        : await TrainingParameterLocalization.db.insertRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteMyTrainingParameterLocalization(
    Session session,
    int localizationId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final loc = await TrainingParameterLocalization.db
        .findById(session, localizationId);
    if (loc == null) return false;
    final param =
        await TrainingParameter.db.findById(session, loc.parameterId);
    if (param == null || param.organizationId != orgId) return false;
    await TrainingParameterLocalization.db.deleteRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  Future<List<AssessmentParameterLocalization>>
      listMyAssessmentParameterLocalizations(
    Session session,
    int parameterId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final param =
        await AssessmentParameter.db.findById(session, parameterId);
    if (param == null || param.organizationId != orgId) return [];
    return await AssessmentParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.equals(parameterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<AssessmentParameterLocalization>
      upsertMyAssessmentParameterLocalization(
    Session session,
    int parameterId,
    AssessmentParameterLocalization loc,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final param =
        await AssessmentParameter.db.findById(session, parameterId);
    if (param == null || param.organizationId != orgId) {
      throw Exception(
          'Assessment parameter not found in your organization.');
    }
    await ensureLocaleConfigured(session, orgId, loc.localeKey);
    loc.parameterId = parameterId;
    final result = loc.id != null
        ? await AssessmentParameterLocalization.db.updateRow(session, loc)
        : await AssessmentParameterLocalization.db.insertRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteMyAssessmentParameterLocalization(
    Session session,
    int localizationId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final loc = await AssessmentParameterLocalization.db
        .findById(session, localizationId);
    if (loc == null) return false;
    final param =
        await AssessmentParameter.db.findById(session, loc.parameterId);
    if (param == null || param.organizationId != orgId) return false;
    await AssessmentParameterLocalization.db.deleteRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  Future<List<AssetLocalization>> listMyAssetLocalizations(
    Session session,
    int assetId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null || asset.organizationId != orgId) return [];
    return await AssetLocalization.db.find(
      session,
      where: (l) => l.assetId.equals(assetId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<AssetLocalization> upsertMyAssetLocalization(
    Session session,
    int assetId,
    AssetLocalization loc,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null || asset.organizationId != orgId) {
      throw Exception('Asset not found in your organization.');
    }
    await ensureLocaleConfigured(session, orgId, loc.localeKey);
    loc.assetId = assetId;
    final result = loc.id != null
        ? await AssetLocalization.db.updateRow(session, loc)
        : await AssetLocalization.db.insertRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteMyAssetLocalization(
    Session session,
    int localizationId,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    final loc = await AssetLocalization.db.findById(session, localizationId);
    if (loc == null) return false;
    final asset = await Asset.db.findById(session, loc.assetId);
    if (asset == null || asset.organizationId != orgId) return false;
    await AssetLocalization.db.deleteRow(session, loc);
    await bumpOrgContentVersion(session, orgId);
    return true;
  }

  // ── Locale-aware reads (own org) ──────────────────────────────────────────

  Future<List<TheoryChapter>> getMyTheoryChaptersLocalized(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyFormat(localeKey);
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final result = <TheoryChapter>[];
    for (final c in chapters) {
      final id = c.id;
      if (id == null) {
        result.add(c);
        continue;
      }
      final loc = await LocaleResolver.theoryChapter(session, id, chain);
      result.add(TheoryChapter(
        id: c.id,
        organizationId: c.organizationId,
        chapterOrder: c.chapterOrder,
        title: loc?.title ?? c.title,
        thumbnailUrl: loc?.thumbnailUrl ?? c.thumbnailUrl,
        videoUrl: loc?.videoUrl ?? c.videoUrl,
        videoMetadata: loc?.videoMetadata ?? c.videoMetadata,
        questions: c.questions,
      ));
    }
    return result;
  }

  Future<List<TrainingParameter>> getMyTrainingParametersLocalized(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyFormat(localeKey);
    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final result = <TrainingParameter>[];
    for (final p in params) {
      final id = p.id;
      if (id == null) {
        result.add(p);
        continue;
      }
      final loc = await LocaleResolver.trainingParameter(session, id, chain);
      result.add(TrainingParameter(
        id: p.id,
        organizationId: p.organizationId,
        paramId: p.paramId,
        name: loc?.name ?? p.name,
        description: loc?.description ?? p.description,
        maxScore: p.maxScore,
        scoringRules: p.scoringRules,
        translations: p.translations,
      ));
    }
    return result;
  }

  Future<List<AssessmentParameter>> getMyAssessmentParametersLocalized(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyFormat(localeKey);
    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final result = <AssessmentParameter>[];
    for (final p in params) {
      final id = p.id;
      if (id == null) {
        result.add(p);
        continue;
      }
      final loc =
          await LocaleResolver.assessmentParameter(session, id, chain);
      result.add(AssessmentParameter(
        id: p.id,
        organizationId: p.organizationId,
        paramId: p.paramId,
        name: loc?.name ?? p.name,
        description: loc?.description ?? p.description,
        maxScore: p.maxScore,
        scoringRules: p.scoringRules,
        translations: p.translations,
      ));
    }
    return result;
  }

  Future<List<Asset>> getMyAssetsLocalized(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _requireOwnedOrgId(session);
    validateLocaleKeyFormat(localeKey);
    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(orgId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final result = <Asset>[];
    for (final a in assets) {
      final id = a.id;
      if (id == null) {
        result.add(a);
        continue;
      }
      final loc = await LocaleResolver.asset(session, id, chain);
      result.add(Asset(
        id: a.id,
        organizationId: a.organizationId,
        name: loc?.name ?? a.name,
        version: a.version,
        url: loc?.url ?? a.url,
        description: loc?.description ?? a.description,
        module: a.module,
      ));
    }
    return result;
  }
}
