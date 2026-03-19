import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.admin};

  Future<Organization?> createOrganization(
    Session session,
    String  name,
    String? imageUrl,
  ) async {
    var org = Organization(name: name, imageUrl: imageUrl);
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
    var existingUser = await Users.findUserByEmail(session, email);
    if (existingUser != null) throw Exception('User with this email already exists.');

    var userInfo = (await Emails.createUser(session, userName, email, password))!;
    if (userInfo == null) return null;

    if (role == Role.Manager) {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.manager});
    } else {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.user});
    }

    var appUser = AppUser(userInfoId: userInfo.id!, role: role);
    appUser = await AppUser.db.insertRow(session, appUser);

    var organization = await Organization.db.findById(session, organizationId);
    if (organization == null) throw Exception('Organization not found.');

    var link = OrganizationUserLink(organizationId: organization.id!, appUserId: appUser.id!);
    await OrganizationUserLink.db.insertRow(session, link);

    return appUser;
  }

  Future<bool> assignManagerToOrg(Session session, int managerAppUserId, int organizationId) async {
    var org = await Organization.db.findById(session, organizationId);
    var manager = await AppUser.db.findById(session, managerAppUserId);

    if (org == null || manager == null || manager.role != Role.Manager) return false;

    org.managerId = manager.id;
    await Organization.db.updateRow(session, org);
    return true;
  }

  Future<List<Organization>> getAllOrganizations(Session session) async {
    return await Organization.db.find(
      session,
      include: Organization.include(
        manager: AppUser.include(userInfo: UserInfo.include()),
        users: OrganizationUserLink.includeList(
          include: OrganizationUserLink.include(appUser: AppUser.include(userInfo: UserInfo.include())),
        ),
      ),
    );
  }

  Future<List<AppUser>> getAllUsers(Session session, {Role? role}) async {
    return await AppUser.db.find(
      session,
      where: role != null ? (user) => user.role.equals(role) : null,
      include: AppUser.include(userInfo: UserInfo.include()),
    );
  }

  Future<ModuleConfig> setModuleConfig(
    Session session,
    int organizationId,
    bool theoryModule,
    bool aiExpertModule,
    bool smartTrainingModule,
    bool assessmentModule,
    String defaultLanguage,
    List<SupportedLanguage> supportedLanguages,
    String? aiChatPrompt,
    int passingPercentage,
  ) async {
    var existing = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );

    if (existing != null) {
      existing.theoryModule = theoryModule;
      existing.aiExpertModule = aiExpertModule;
      existing.smartTrainingModule = smartTrainingModule;
      existing.assessmentModule = assessmentModule;
      existing.defaultLanguage = defaultLanguage;
      existing.supportedLanguages = supportedLanguages;
      existing.aiChatPrompt = aiChatPrompt;
      existing.passingPercentage = passingPercentage;
      return await ModuleConfig.db.updateRow(session, existing);
    } else {
      var config = ModuleConfig(
        organizationId: organizationId,
        theoryModule: theoryModule,
        aiExpertModule: aiExpertModule,
        smartTrainingModule: smartTrainingModule,
        assessmentModule: assessmentModule,
        defaultLanguage: defaultLanguage,
        supportedLanguages: supportedLanguages,
        aiChatPrompt: aiChatPrompt,
        passingPercentage: passingPercentage,
      );
      return await ModuleConfig.db.insertRow(session, config);
    }
  }

  Future<ModuleConfig?> getModuleConfig(Session session, int organizationId) async {
    return await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
  }

  // Theory chapters

  Future<List<TheoryChapter>> getTheoryChapters(Session session, int organizationId) async {
    return await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(organizationId),
      orderBy: (c) => c.chapterOrder,
    );
  }

  Future<TheoryChapter> upsertTheoryChapter(Session session, TheoryChapter chapter) async {
    if (chapter.id != null) {
      return await TheoryChapter.db.updateRow(session, chapter);
    } else {
      return await TheoryChapter.db.insertRow(session, chapter);
    }
  }

  Future<bool> deleteTheoryChapter(Session session, int chapterId) async {
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null) return false;
    await TheoryChapter.db.deleteRow(session, chapter);
    return true;
  }

  // Training parameters

  Future<List<TrainingParameter>> getTrainingParameters(Session session, int organizationId) async {
    return await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
  }

  Future<TrainingParameter> upsertTrainingParameter(Session session, TrainingParameter param) async {
    if (param.id != null) {
      return await TrainingParameter.db.updateRow(session, param);
    } else {
      return await TrainingParameter.db.insertRow(session, param);
    }
  }

  Future<bool> deleteTrainingParameter(Session session, int paramId) async {
    final param = await TrainingParameter.db.findById(session, paramId);
    if (param == null) return false;
    await TrainingParameter.db.deleteRow(session, param);
    return true;
  }

  // Assessment parameters

  Future<List<AssessmentParameter>> getAssessmentParameters(Session session, int organizationId) async {
    return await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
  }

  Future<AssessmentParameter> upsertAssessmentParameter(Session session, AssessmentParameter param) async {
    if (param.id != null) {
      return await AssessmentParameter.db.updateRow(session, param);
    } else {
      return await AssessmentParameter.db.insertRow(session, param);
    }
  }

  Future<bool> deleteAssessmentParameter(Session session, int paramId) async {
    final param = await AssessmentParameter.db.findById(session, paramId);
    if (param == null) return false;
    await AssessmentParameter.db.deleteRow(session, param);
    return true;
  }

  // Assets

  Future<List<Asset>> getAssets(Session session, int organizationId) async {
    return await Asset.db.find(session, where: (a) => a.organizationId.equals(organizationId));
  }

  Future<Asset> upsertAsset(Session session, Asset asset) async {
    if (asset.id != null) {
      return await Asset.db.updateRow(session, asset);
    } else {
      return await Asset.db.insertRow(session, asset);
    }
  }

  Future<bool> deleteAsset(Session session, int assetId) async {
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null) return false;
    await Asset.db.deleteRow(session, asset);
    return true;
  }

  // ── User module progress ──────────────────────────────────────────────────

  Future<List<UserModuleProgress>> getUserModuleProgress(
    Session session,
    int appUserId,
    int organizationId,
  ) async {
    return await UserModuleProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(appUserId) &
          p.organizationId.equals(organizationId),
    );
  }

  Future<UserModuleProgress> setUserModuleProgress(
    Session session,
    int appUserId,
    int organizationId,
    String moduleId,
    bool isEnabled,
    DateTime? deadline,
  ) async {
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

  // ── Training session results ───────────────────────────────────────────────

  /// Returns all Smart Training results for [appUserId] across all orgs.
  Future<List<TrainingSessionResult>> getUserTrainingHistory(
    Session session,
    int appUserId,
  ) async {
    // Two separate queries to avoid any Serverpod OR behavior issues on
    // nullable columns. Records submitted before appUserId was resolved will
    // only match on externalUserId; newer records match on appUserId.
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
        .toList();
    results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
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
}
