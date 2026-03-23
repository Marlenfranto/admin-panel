import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';
import '../util/version_util.dart';

class ManagerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.manager};

  Future<AppUser?> _getManagerAppUser(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;
    return await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
  }

  Future<Organization?> getManagedOrganization(Session session) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return null;

    return await Organization.db.findFirstRow(
      session,
      where: (o) => o.managerId.equals(managerAppUser.id),
      include: Organization.include(
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(appUser: AppUser.include(userInfo: UserInfo.include())),
        ),
      ),
    );
  }

  Future<List<Organization>> getManagedOrganizations(Session session) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];
    return await Organization.db.find(
      session,
      where: (o) => o.managerId.equals(managerAppUser.id),
      include: Organization.include(
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(
            appUser: AppUser.include(userInfo: UserInfo.include()),
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
    var existingUser = await Users.findUserByEmail(session, email);
    if (existingUser != null) throw Exception('User with this email already exists.');

    var userInfo = (await Emails.createUser(session, userName, email, password))!;
    if (userInfo == null) return null;

    await Users.updateUserScopes(session, userInfo.id!, {AppScopes.user});

    var appUser = AppUser(userInfoId: userInfo.id!, role: Role.User);
    appUser = await AppUser.db.insertRow(session, appUser);

    var organization = await Organization.db.findById(session, organizationId);
    if (organization == null) throw Exception('Organization not found.');

    var link = OrganizationUserLink(organizationId: organization.id!, appUserId: appUser.id!);
    await OrganizationUserLink.db.insertRow(session, link);

    return appUser;
  }

  Future<bool> removeUserFromOrganization(Session session, int appUserId, int organizationId) async {
    await OrganizationUserLink.db.deleteWhere(
      session,
      where: (link) => link.appUserId.equals(appUserId) & link.organizationId.equals(organizationId),
    );
    return true;
  }

  // Module config

  Future<ModuleConfig?> getMyModuleConfig(Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return null;

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return null;

    return await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(org.id),
    );
  }

  Future<ModuleConfig?> updateMyModuleConfig(
    Session session,
    int organizationId,
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String? aiChatPrompt,
    int passingPercentage,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return null;

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return null;

    var existing = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(org.id),
    );

    ModuleConfig? result;
    if (existing != null) {
      existing.theoryModule = theoryModule;
      existing.aiExpertModule = aiExpertModule;
      existing.smartTrainingModule = smartTrainingModule;
      existing.assessmentModule = assessmentModule;
      existing.aiChatPrompt = aiChatPrompt;
      existing.passingPercentage = passingPercentage;
      result = await ModuleConfig.db.updateRow(session, existing);
    } else {
      var config = ModuleConfig(
        organizationId: org.id,
        theoryModule: theoryModule,
        aiExpertModule: aiExpertModule,
        smartTrainingModule: smartTrainingModule,
        assessmentModule: assessmentModule,
        aiChatPrompt: aiChatPrompt,
        passingPercentage: passingPercentage,
      );
      result = await ModuleConfig.db.insertRow(session, config);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  // Theory chapters

  Future<List<TheoryChapter>> getTheoryChapters(Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    return await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(org.id),
      orderBy: (c) => c.chapterOrder,
    );
  }

  Future<TheoryChapter> upsertTheoryChapter(Session session, int organizationId, TheoryChapter chapter) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) throw Exception('Authentication failed.');

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) throw Exception('No managed organization found.');

    chapter.organizationId = organizationId;

    final TheoryChapter result;
    if (chapter.id != null) {
      result = await TheoryChapter.db.updateRow(session, chapter);
    } else {
      result = await TheoryChapter.db.insertRow(session, chapter);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteTheoryChapter(Session session, int chapterId) async {
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null) return false;
    await TheoryChapter.db.deleteRow(session, chapter);
    if (chapter.organizationId != null) {
      await bumpOrgContentVersion(session, chapter.organizationId!);
    }
    return true;
  }

  // Training parameters

  Future<List<TrainingParameter>> getTrainingParameters(Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    return await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(org.id),
    );
  }

  Future<TrainingParameter> upsertTrainingParameter(Session session, int organizationId, TrainingParameter param) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) throw Exception('Authentication failed.');

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) throw Exception('No managed organization found.');

    param.organizationId = organizationId;

    final TrainingParameter result;
    if (param.id != null) {
      result = await TrainingParameter.db.updateRow(session, param);
    } else {
      result = await TrainingParameter.db.insertRow(session, param);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteTrainingParameter(Session session, int paramId) async {
    final param = await TrainingParameter.db.findById(session, paramId);
    if (param == null) return false;
    await TrainingParameter.db.deleteRow(session, param);
    if (param.organizationId != null) {
      await bumpOrgContentVersion(session, param.organizationId!);
    }
    return true;
  }

  // Assessment parameters

  Future<List<AssessmentParameter>> getAssessmentParameters(Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    return await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(org.id),
    );
  }

  Future<AssessmentParameter> upsertAssessmentParameter(Session session, int organizationId, AssessmentParameter param) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) throw Exception('Authentication failed.');

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) throw Exception('No managed organization found.');

    param.organizationId = organizationId;

    final AssessmentParameter result;
    if (param.id != null) {
      result = await AssessmentParameter.db.updateRow(session, param);
    } else {
      result = await AssessmentParameter.db.insertRow(session, param);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteAssessmentParameter(Session session, int paramId) async {
    final param = await AssessmentParameter.db.findById(session, paramId);
    if (param == null) return false;
    await AssessmentParameter.db.deleteRow(session, param);
    if (param.organizationId != null) {
      await bumpOrgContentVersion(session, param.organizationId!);
    }
    return true;
  }

  // Assets

  Future<List<Asset>> getAssets(Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    return await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(org.id),
    );
  }

  Future<Asset> upsertAsset(Session session, int organizationId, Asset asset) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) throw Exception('Authentication failed.');

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) => o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) throw Exception('No managed organization found.');

    asset.organizationId = organizationId;

    final Asset result;
    if (asset.id != null) {
      result = await Asset.db.updateRow(session, asset);
    } else {
      result = await Asset.db.insertRow(session, asset);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteAsset(Session session, int assetId) async {
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null) return false;
    await Asset.db.deleteRow(session, asset);
    if (asset.organizationId != null) {
      await bumpOrgContentVersion(session, asset.organizationId!);
    }
    return true;
  }

  // ── User module progress ──────────────────────────────────────────────────

  Future<List<UserModuleProgress>> getUserModuleProgress(
    Session session,
    int appUserId,
    int organizationId,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) =>
          o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    return await UserModuleProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(appUserId) &
          p.organizationId.equals(organizationId),
    );
  }

  Future<UserModuleProgress?> setUserModuleProgress(
    Session session,
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return null;

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) =>
          o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return null;

    var existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(appUserId) &
          p.organizationId.equals(organizationId) &
          p.moduleId.equals(moduleId),
    );

    if (existing != null) {
      existing.isEnabled = isEnabled;
      existing.deadline = deadline;
      return await UserModuleProgress.db.updateRow(session, existing);
    }

    final progress = UserModuleProgress(
      appUserId: appUserId,
      organizationId: organizationId,
      moduleId: moduleId,
      isEnabled: isEnabled,
      deadline: deadline,
      status: ModuleProgressStatus.notStarted,
    );
    return await UserModuleProgress.db.insertRow(session, progress);
  }

  Future<UserModuleProgress?> updateUserModuleStatus(
    Session session,
    int appUserId,
    int organizationId,
    String moduleId,
    ModuleProgressStatus status,
    DateTime? startedAt,
    DateTime? completedAt,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return null;

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) =>
          o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return null;

    var existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(appUserId) &
          p.organizationId.equals(organizationId) &
          p.moduleId.equals(moduleId),
    );
    if (existing == null) return null;

    existing.status = status;
    existing.startedAt = startedAt;
    existing.completedAt = completedAt;
    return await UserModuleProgress.db.updateRow(session, existing);
  }

  // ── Training session results ───────────────────────────────────────────────

  /// Returns all Smart Training results for [appUserId] within this manager's org.
  Future<List<TrainingSessionResult>> getUserTrainingHistory(
    Session session,
    int appUserId,
    int organizationId,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) =>
          o.id.equals(organizationId) & o.managerId.equals(managerAppUser.id),
    );
    if (org == null) return [];

    // Two separate queries to avoid any Serverpod OR behavior issues on
    // nullable columns. Records submitted before appUserId was resolved will
    // only match on externalUserId; newer records match on appUserId.
    final byAppUser = await TrainingSessionResult.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(organizationId) &
          r.appUserId.equals(appUserId),
    );
    final byExternal = await TrainingSessionResult.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(organizationId) &
          r.externalUserId.equals(appUserId.toString()),
    );
    final seen = <int>{};
    final results = [...byAppUser, ...byExternal]
        .where((r) => r.id != null && seen.add(r.id!))
        .toList();
    results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  // ── Notifications ─────────────────────────────────────────────────────────

  /// Returns notification details for [organizationId], auto-creating records
  /// for any overdue (deadline passed, not completed) progress entries.
  Future<List<ManagerNotificationDetail>> getNotifications(
    Session session,
    int organizationId,
  ) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return [];
    final managerId = managerAppUser.id!;

    final org = await Organization.db.findFirstRow(
      session,
      where: (o) =>
          o.id.equals(organizationId) & o.managerId.equals(managerId),
    );
    if (org == null) return [];

    final now = DateTime.now().toUtc();

    // Find all progress records for this org and detect overdue ones in Dart.
    final allProgress = await UserModuleProgress.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    final overdueProgress = allProgress
        .where((p) =>
            p.deadline != null &&
            p.deadline!.isBefore(now) &&
            p.status != ModuleProgressStatus.completed)
        .toList();

    // Upsert a notification for each overdue progress record.
    for (final progress in overdueProgress) {
      final existing = await ManagerNotification.db.findFirstRow(
        session,
        where: (n) =>
            n.managerId.equals(managerId) &
            n.overdueUserId.equals(progress.appUserId!) &
            n.moduleId.equals(progress.moduleId),
      );
      if (existing == null) {
        await ManagerNotification.db.insertRow(
          session,
          ManagerNotification(
            managerId:      managerId,
            overdueUserId:  progress.appUserId!,
            organizationId: organizationId,
            moduleId:       progress.moduleId,
            isRead:         false,
            createdAt:      now,
          ),
        );
      }
    }

    // Fetch all notifications for this manager/org (most recent first).
    final notifications = await ManagerNotification.db.find(
      session,
      where: (n) =>
          n.managerId.equals(managerId) &
          n.organizationId.equals(organizationId),
    );
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Build enriched detail objects.
    final details = <ManagerNotificationDetail>[];
    for (final notif in notifications) {
      final overdueUser = await AppUser.db.findFirstRow(
        session,
        where: (u) => u.id.equals(notif.overdueUserId),
        include: AppUser.include(userInfo: UserInfo.include()),
      );
      if (overdueUser == null) continue;

      final progress = overdueProgress.firstWhere(
        (p) =>
            p.appUserId == notif.overdueUserId &&
            p.moduleId == notif.moduleId,
        orElse: () => UserModuleProgress(
          appUserId:      notif.overdueUserId,
          organizationId: organizationId,
          moduleId:       notif.moduleId,
          isEnabled:      true,
          status:         ModuleProgressStatus.notStarted,
        ),
      );

      details.add(ManagerNotificationDetail(
        notification:     notif,
        overdueUserName:  overdueUser.userInfo?.userName ?? '—',
        overdueUserEmail: overdueUser.userInfo?.email ?? '—',
        organizationName: org.name,
        deadline:         progress.deadline,
        progressStatus:   progress.status,
      ));
    }

    return details;
  }

  /// Returns the total number of unread notifications across all managed orgs.
  Future<int> getUnreadNotificationCount(Session session) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return 0;
    final managerId = managerAppUser.id!;

    final unread = await ManagerNotification.db.find(
      session,
      where: (n) =>
          n.managerId.equals(managerId) & n.isRead.equals(false),
    );
    return unread.length;
  }

  Future<bool> markNotificationRead(
      Session session, int notificationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return false;

    final notif =
        await ManagerNotification.db.findById(session, notificationId);
    if (notif == null || notif.managerId != managerAppUser.id) return false;

    notif.isRead = true;
    await ManagerNotification.db.updateRow(session, notif);
    return true;
  }

  Future<bool> markAllNotificationsRead(
      Session session, int organizationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return false;
    final managerId = managerAppUser.id!;

    final unread = await ManagerNotification.db.find(
      session,
      where: (n) =>
          n.managerId.equals(managerId) &
          n.organizationId.equals(organizationId) &
          n.isRead.equals(false),
    );
    for (final notif in unread) {
      notif.isRead = true;
      await ManagerNotification.db.updateRow(session, notif);
    }
    return true;
  }

  Future<bool> deleteNotification(Session session, int notificationId) async {
    final managerAppUser = await _getManagerAppUser(session);
    if (managerAppUser == null) return false;

    final notif =
        await ManagerNotification.db.findById(session, notificationId);
    if (notif == null || notif.managerId != managerAppUser.id) return false;

    await ManagerNotification.db.deleteRow(session, notif);
    return true;
  }
}
