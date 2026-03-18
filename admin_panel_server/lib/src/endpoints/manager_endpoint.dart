import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';

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

    var appUser = AppUser(userInfoId: userInfo.id!, role: Role.User, tools: Tools());
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

    if (existing != null) {
      existing.theoryModule = theoryModule;
      existing.aiExpertModule = aiExpertModule;
      existing.smartTrainingModule = smartTrainingModule;
      existing.assessmentModule = assessmentModule;
      existing.aiChatPrompt = aiChatPrompt;
      return await ModuleConfig.db.updateRow(session, existing);
    } else {
      var config = ModuleConfig(
        organizationId: org.id,
        theoryModule: theoryModule,
        aiExpertModule: aiExpertModule,
        smartTrainingModule: smartTrainingModule,
        assessmentModule: assessmentModule,
        aiChatPrompt: aiChatPrompt,
      );
      return await ModuleConfig.db.insertRow(session, config);
    }
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
}
