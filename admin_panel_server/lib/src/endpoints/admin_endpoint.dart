import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../scopes.dart';
import '../util/default_locale_writer.dart';
import '../util/locale_resolver.dart';
import '../util/locale_validator.dart';
import '../util/version_util.dart';

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
    
    if (role == Role.OrganizationAdmin) {
      await Users.updateUserScopes(session, userInfo.id!, {AppScopes.organizationAdmin});
    } else if (role == Role.Manager) {
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

    // Org Admins are the designated manager of their organization.
    if (role == Role.OrganizationAdmin && organization.managerId == null) {
      organization.managerId = appUser.id;
      await Organization.db.updateRow(session, organization);
    }

    return appUser;
  }

  Future<bool> assignManagerToOrg(Session session, int managerAppUserId, int organizationId) async {
    var org = await Organization.db.findById(session, organizationId);
    var manager = await AppUser.db.findById(session, managerAppUserId);

    if (org == null || manager == null ||
        (manager.role != Role.Manager && manager.role != Role.OrganizationAdmin)) {
      return false;
    }

    org.managerId = manager.id;
    await Organization.db.updateRow(session, org);
    return true;
  }

  Future<Organization?> updateOrganization(
    Session session,
    int    id,
    String name,
    String? imageUrl,
  ) async {
    final org = await Organization.db.findById(session, id);
    if (org == null) return null;
    org.name     = name;
    org.imageUrl = imageUrl;
    return await Organization.db.updateRow(session, org);
  }

  Future<bool> deleteOrganization(Session session, int id) async {
    await OrganizationUserLink.db.deleteWhere(
        session, where: (l) => l.organizationId.equals(id));
    await ModuleConfig.db.deleteWhere(
        session, where: (c) => c.organizationId.equals(id));
    await TheoryChapter.db.deleteWhere(
        session, where: (c) => c.organizationId.equals(id));
    await TrainingParameter.db.deleteWhere(
        session, where: (p) => p.organizationId.equals(id));
    await AssessmentParameter.db.deleteWhere(
        session, where: (p) => p.organizationId.equals(id));
    await Asset.db.deleteWhere(
        session, where: (a) => a.organizationId.equals(id));
    await UserModuleProgress.db.deleteWhere(
        session, where: (p) => p.organizationId.equals(id));
    await ManagerNotification.db.deleteWhere(
        session, where: (n) => n.organizationId.equals(id));
    final org = await Organization.db.findById(session, id);
    if (org == null) return false;
    await Organization.db.deleteRow(session, org);
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

  Future<bool> updateUser(
    Session session,
    int    appUserId,
    String userName,
    Role   role,
  ) async {
    if (role == Role.SuperAdmin || role == Role.OrganizationAdmin) {
      throw Exception('Cannot assign SuperAdmin or OrganizationAdmin role via this endpoint.');
    }
    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;
    if (appUser.role == Role.SuperAdmin || appUser.role == Role.OrganizationAdmin) {
      throw Exception('Cannot modify SuperAdmin or OrganizationAdmin users.');
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

  Future<bool> updateOrgAdminUser(
    Session session,
    int    appUserId,
    String userName,
    Role   role,
  ) async {
    if (role == Role.SuperAdmin) {
      throw Exception('Cannot assign SuperAdmin role.');
    }
    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;
    if (appUser.role != Role.OrganizationAdmin) {
      throw Exception('Use updateUser for Manager/User accounts.');
    }

    if (appUser.role != role) {
      appUser.role = role;
      await AppUser.db.updateRow(session, appUser);
      final scope = switch (role) {
        Role.OrganizationAdmin => AppScopes.organizationAdmin,
        Role.Manager           => AppScopes.manager,
        _                      => AppScopes.user,
      };
      await Users.updateUserScopes(session, appUser.userInfoId, {scope});
    }

    final userInfo = await UserInfo.db.findById(session, appUser.userInfoId);
    if (userInfo != null && userInfo.userName != userName) {
      userInfo.userName = userName;
      await UserInfo.db.updateRow(session, userInfo);
    }

    return true;
  }

  Future<bool> adminResetUserPassword(
    Session session,
    int    appUserId,
    String newPassword,
  ) async {
    if (newPassword.trim().isEmpty) {
      throw Exception('New password cannot be empty.');
    }
    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;

    final emailAuth = await EmailAuth.db.findFirstRow(
      session,
      where: (e) => e.userId.equals(appUser.userInfoId),
    );
    if (emailAuth == null) return false;

    emailAuth.hash = await Emails.generatePasswordHash(newPassword);
    await EmailAuth.db.updateRow(session, emailAuth);
    return true;
  }

  Future<bool> deleteUser(Session session, int appUserId) async {
    final appUser = await AppUser.db.findById(session, appUserId);
    if (appUser == null) return false;
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
    if (userInfo != null) {
      await UserInfo.db.deleteRow(session, userInfo);
    }
    return true;
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
    List<LocalizedAiPrompt>? aiChatPromptTranslations,
    int passingPercentage,
  ) async {
    var existing = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );

    ModuleConfig result;
    if (existing != null) {
      existing.theoryModule = theoryModule;
      existing.aiExpertModule = aiExpertModule;
      existing.smartTrainingModule = smartTrainingModule;
      existing.assessmentModule = assessmentModule;
      existing.defaultLanguage = defaultLanguage;
      existing.supportedLanguages = supportedLanguages;
      existing.aiChatPrompt = aiChatPrompt;
      existing.aiChatPromptTranslations = aiChatPromptTranslations;
      existing.passingPercentage = passingPercentage;
      result = await ModuleConfig.db.updateRow(session, existing);
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
        aiChatPromptTranslations: aiChatPromptTranslations,
        passingPercentage: passingPercentage,
      );
      result = await ModuleConfig.db.insertRow(session, config);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<ModuleConfig?> getModuleConfig(Session session, int organizationId) async {
    return await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
  }

  // Theory chapters

  Future<List<TheoryChapter>> getTheoryChapters(Session session, int organizationId) async {
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(organizationId),
      orderBy: (c) => c.chapterOrder,
    );
    await hydrateTheoryChapters(session, chapters);
    return chapters;
  }

  Future<TheoryChapter> upsertTheoryChapter(Session session, TheoryChapter chapter) async {
    final TheoryChapter result;
    if (chapter.id != null) {
      result = await TheoryChapter.db.updateRow(session, chapter);
    } else {
      result = await TheoryChapter.db.insertRow(session, chapter);
    }
    final orgId = result.organizationId;
    final resultId = result.id;
    if (orgId != null && resultId != null) {
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
      await bumpOrgContentVersion(session, orgId);
    }
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
    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    await hydrateTrainingParameters(session, params);
    return params;
  }

  Future<TrainingParameter> upsertTrainingParameter(Session session, TrainingParameter param) async {
    final TrainingParameter result;
    if (param.id != null) {
      result = await TrainingParameter.db.updateRow(session, param);
    } else {
      result = await TrainingParameter.db.insertRow(session, param);
    }
    final orgId = result.organizationId;
    final resultId = result.id;
    if (orgId != null && resultId != null) {
      await writeTrainingParameterDefaultContent(
        session,
        resultId,
        orgId,
        name: param.name,
        description: param.description,
      );
      await bumpOrgContentVersion(session, orgId);
    }
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
    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    await hydrateAssessmentParameters(session, params);
    return params;
  }

  Future<AssessmentParameter> upsertAssessmentParameter(Session session, AssessmentParameter param) async {
    final AssessmentParameter result;
    if (param.id != null) {
      result = await AssessmentParameter.db.updateRow(session, param);
    } else {
      result = await AssessmentParameter.db.insertRow(session, param);
    }
    final orgId = result.organizationId;
    final resultId = result.id;
    if (orgId != null && resultId != null) {
      await writeAssessmentParameterDefaultContent(
        session,
        resultId,
        orgId,
        name: param.name,
        description: param.description,
      );
      await bumpOrgContentVersion(session, orgId);
    }
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
    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
    await hydrateAssets(session, assets);
    return assets;
  }

  Future<Asset> upsertAsset(Session session, Asset asset) async {
    final Asset result;
    if (asset.id != null) {
      result = await Asset.db.updateRow(session, asset);
    } else {
      result = await Asset.db.insertRow(session, asset);
    }
    final orgId = result.organizationId;
    final resultId = result.id;
    if (orgId != null && resultId != null) {
      await writeAssetDefaultContent(
        session,
        resultId,
        orgId,
        name: asset.name,
        description: asset.description,
        url: asset.url,
      );
      await bumpOrgContentVersion(session, orgId);
    }
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

  // ── Regions & Locales ─────────────────────────────────────────────────────

  Future<List<Region>> listRegions(Session session, int organizationId) async {
    return await Region.db.find(
      session,
      where: (r) => r.organizationId.equals(organizationId),
      orderBy: (r) => r.code,
    );
  }

  Future<Region> upsertRegion(
    Session session,
    int organizationId,
    Region region,
  ) async {
    region.organizationId = organizationId;
    final Region result;
    if (region.id != null) {
      result = await Region.db.updateRow(session, region);
    } else {
      result = await Region.db.insertRow(session, region);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteRegion(Session session, int regionId) async {
    final region = await Region.db.findById(session, regionId);
    if (region == null) return false;
    final inUse = await LocaleConfig.db.findFirstRow(
      session,
      where: (l) =>
          l.organizationId.equals(region.organizationId) &
          l.regionCode.equals(region.code),
    );
    if (inUse != null) {
      throw Exception(
        'Cannot delete region "${region.code}": locale '
        '"${inUse.localeKey}" is still using it.',
      );
    }
    await Region.db.deleteRow(session, region);
    if (region.organizationId != null) {
      await bumpOrgContentVersion(session, region.organizationId!);
    }
    return true;
  }

  Future<List<LocaleConfig>> listLocaleConfigs(
    Session session,
    int organizationId,
  ) async {
    return await LocaleConfig.db.find(
      session,
      where: (l) => l.organizationId.equals(organizationId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<LocaleConfig> upsertLocaleConfig(
    Session session,
    int organizationId,
    LocaleConfig locale,
  ) async {
    validateLocaleKeyComposition(
      locale.localeKey,
      locale.regionCode,
      locale.languageCode,
    );
    await ensureRegionExists(session, organizationId, locale.regionCode);
    locale.organizationId = organizationId;

    final LocaleConfig result;
    if (locale.id != null) {
      result = await LocaleConfig.db.updateRow(session, locale);
    } else {
      result = await LocaleConfig.db.insertRow(session, locale);
    }
    await bumpOrgContentVersion(session, organizationId);
    return result;
  }

  Future<bool> deleteLocaleConfig(Session session, int localeConfigId) async {
    final locale = await LocaleConfig.db.findById(session, localeConfigId);
    if (locale == null) return false;
    if (locale.isDefault) {
      throw Exception(
        'Cannot delete the default locale "${locale.localeKey}". '
        'Set another locale as default first.',
      );
    }
    await LocaleConfig.db.deleteRow(session, locale);
    if (locale.organizationId != null) {
      await bumpOrgContentVersion(session, locale.organizationId!);
    }
    return true;
  }

  /// Marks [localeKey] as the default locale for [organizationId], clears the
  /// flag on all other locales, and syncs `ModuleConfig.defaultLocaleKey`.
  Future<LocaleConfig?> setDefaultLocale(
    Session session,
    int organizationId,
    String localeKey,
  ) async {
    validateLocaleKeyFormat(localeKey);

    final target = await LocaleConfig.db.findFirstRow(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) &
          l.localeKey.equals(localeKey),
    );
    if (target == null) {
      throw Exception(
        'Locale "$localeKey" is not configured for this organization.',
      );
    }

    final others = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) &
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
      where: (c) => c.organizationId.equals(organizationId),
    );
    if (cfg != null) {
      cfg.defaultLocaleKey = localeKey;
      await ModuleConfig.db.updateRow(session, cfg);
    }

    await bumpOrgContentVersion(session, organizationId);
    return updated;
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

  /// Returns paginated and filtered Smart Training results for Super Admins.
  Future<TrainingSessionResultPage> getTrainingHistory(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) async {
    final offset = (page - 1) * limit;

    // Use Expression type for complex query building.
    Expression where = (TrainingSessionResult.t.id.notEquals(null));

    if (teamId != null) {
      where = where & TrainingSessionResult.t.organizationId.equals(teamId);
    } else if (organizationId != null) {
      // Find all sub-orgs (teams) for this organization.
      final teams = await Organization.db.find(
        session,
        where: (o) => o.parentId.equals(organizationId),
      );
      final orgIds = {organizationId, ...teams.map((t) => t.id!)};
      where = where & TrainingSessionResult.t.organizationId.inSet(orgIds);
    }

    if (start != null) {
      where = where & (TrainingSessionResult.t.completedAt >= start);
    }
    if (end != null) {
      where = where & (TrainingSessionResult.t.completedAt <= end);
    }
    if (passed != null) {
      final passingPercentage = 60; // Default or fetch from config
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

  /// Returns paginated unique users who have smart training results, grouped by user.
  Future<TrainingUserSummaryPage> getTrainingUserSummaries(
    Session session, {
    int page = 1,
    int limit = 20,
    String? search,
    int? organizationId,
    int? teamId,
    DateTime? start,
    DateTime? end,
    bool? passed,
  }) async {
    final offset = (page - 1) * limit;

    // Build the filtering expression similar to getTrainingHistory.
    Expression where = (TrainingSessionResult.t.appUserId.notEquals(null));

    // 1. Resolve Organization/Team filter to a set of AppUser IDs.
    Set<int>? targetUserIds;
    if (organizationId != null || teamId != null) {
      Set<int> orgIds;
      if (teamId != null) {
        orgIds = {teamId};
      } else {
        final teams = await Organization.db.find(
          session,
          where: (o) => o.parentId.equals(organizationId),
          limit: 1000,
        );
        orgIds = {organizationId!, ...teams.map((t) => t.id!)};
      }

      final links = await OrganizationUserLink.db.find(
        session,
        where: (l) => l.organizationId.inSet(orgIds),
      );
      targetUserIds = links.map((l) => l.appUserId).toSet();
      
      if (targetUserIds.isEmpty) {
        return TrainingUserSummaryPage(summaries: [], totalCount: 0, hasMore: false);
      }
      where = where & TrainingSessionResult.t.appUserId.inSet(targetUserIds);
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

    if (search != null && search.trim().isNotEmpty) {
      final query = search.trim().toLowerCase();
      where = where & (TrainingSessionResult.t.appUser.userInfo.userName.ilike('%$query%') | 
               TrainingSessionResult.t.appUser.userInfo.email.ilike('%$query%'));
    }

    // Step 1: Find unique User IDs who have training results matching the filter.
    // Order by completedAt to ensure we can pick the latest for each user.
    // We fetch a larger batch of results to ensure we have enough to group and paginate,
    // but with a hard cap to avoid memory issues.
    final results = await TrainingSessionResult.db.find(
      session,
      where: (_) => where,
      orderBy: (r) => r.completedAt,
      orderDescending: true,
      limit: 5000, // Hard cap for safety
      include: TrainingSessionResult.include(
        appUser: AppUser.include(userInfo: UserInfo.include()),
        organization: Organization.include(),
      ),
    );

    // Grouping by User ID
    final List<TrainingSessionResult> uniqueUserResults = [];
    final seenUids = <int>{};
    for (final res in results) {
      if (seenUids.add(res.appUserId!)) {
        uniqueUserResults.add(res);
      }
    }

    // Step 2: Fetch all OrganizationUserLink for these users to get their official Org/Team.
    final uids = uniqueUserResults.map((r) => r.appUserId!).toSet();
    final allLinks = await OrganizationUserLink.db.find(
      session,
      where: (l) => l.appUserId.inSet(uids),
      include: OrganizationUserLink.include(organization: Organization.include()),
    );
    
    // Group links by User ID
    final userLinksMap = <int, List<OrganizationUserLink>>{};
    for (final link in allLinks) {
       (userLinksMap[link.appUserId] ??= []).add(link);
    }

    // Step 3: Identify parent organizations for hierarchy resolution.
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

    // Step 4: Create summaries with resolved parents and teams.
    final allSummaries = uniqueUserResults.map((res) {
      final uid = res.appUserId!;
      final userLinks = userLinksMap[uid] ?? [];
      
      // Resolve Team (membership with a parent) and Parent Org
      Organization? userTeam;
      Organization? userParent;
      
      for (final link in userLinks) {
        final org = link.organization;
        if (org == null) continue;
        
        if (org.parentId != null) {
          // This is a sub-team
          userTeam = org;
          userParent = parentMap[org.parentId];
          break; // Found primary team
        }
      }
      
      // Fallback: If no sub-team, just use the first available organization
      if (userTeam == null && userLinks.isNotEmpty) {
        userTeam = userLinks.first.organization;
      }
      
      // Final Fallback: Use the result's organization if memberships are missing
      userTeam ??= res.organization;

      // Count total sessions for this user (within the filter)
      final userTotal = results.where((r) => r.appUserId == uid).length;

      return TrainingUserSummary(
        user: res.appUser!,
        parentOrg: userParent,
        team: userTeam!,
        latestResult: res,
        totalSessions: userTotal,
      );
    }).toList();
    
    // Pagination (Client-side grouping means we have to paginate the resulting list)
    final pagedSummaries = allSummaries.length > offset 
        ? allSummaries.sublist(offset, (offset + limit).clamp(0, allSummaries.length))
        : <TrainingUserSummary>[];

    return TrainingUserSummaryPage(
      summaries: pagedSummaries,
      totalCount: allSummaries.length,
      hasMore: offset + pagedSummaries.length < allSummaries.length,
    );
  }

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

  // ── Localization CRUD (theory) ────────────────────────────────────────────

  Future<List<TheoryChapterLocalization>> listTheoryChapterLocalizations(
    Session session,
    int chapterId,
  ) async {
    return await TheoryChapterLocalization.db.find(
      session,
      where: (l) => l.chapterId.equals(chapterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<TheoryChapterLocalization> upsertTheoryChapterLocalization(
    Session session,
    int chapterId,
    TheoryChapterLocalization loc,
  ) async {
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null) throw Exception('Theory chapter not found.');
    final orgId = chapter.organizationId;
    if (orgId != null) {
      await ensureLocaleConfigured(session, orgId, loc.localeKey);
    } else {
      validateLocaleKeyFormat(loc.localeKey);
    }
    loc.chapterId = chapterId;

    final TheoryChapterLocalization result;
    if (loc.id != null) {
      result = await TheoryChapterLocalization.db.updateRow(session, loc);
    } else {
      result = await TheoryChapterLocalization.db.insertRow(session, loc);
    }
    if (orgId != null) await bumpOrgContentVersion(session, orgId);
    return result;
  }

  /// Sets the per-question quiz translations on [chapterId] for [localeKey].
  /// Each entry in [questionTranslations] maps to the question at the same
  /// index. Empty question text removes that locale's translation for that
  /// question.
  Future<void> setTheoryChapterQuizTranslations(
    Session session,
    int chapterId,
    String localeKey,
    List<LocalizedQuizContent> questionTranslations,
  ) async {
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null) throw Exception('Theory chapter not found.');
    final orgId = chapter.organizationId;
    if (orgId != null) {
      await ensureLocaleConfigured(session, orgId, localeKey);
    } else {
      validateLocaleKeyFormat(localeKey);
    }
    await writeTheoryChapterQuizTranslations(
      session,
      chapterId,
      localeKey,
      questionTranslations,
    );
    if (orgId != null) await bumpOrgContentVersion(session, orgId);
  }

  Future<bool> deleteTheoryChapterLocalization(
    Session session,
    int localizationId,
  ) async {
    final loc =
        await TheoryChapterLocalization.db.findById(session, localizationId);
    if (loc == null) return false;
    await TheoryChapterLocalization.db.deleteRow(session, loc);
    final chapter = await TheoryChapter.db.findById(session, loc.chapterId);
    if (chapter?.organizationId != null) {
      await bumpOrgContentVersion(session, chapter!.organizationId!);
    }
    return true;
  }

  // ── Localization CRUD (training) ──────────────────────────────────────────

  Future<List<TrainingParameterLocalization>>
      listTrainingParameterLocalizations(
    Session session,
    int parameterId,
  ) async {
    return await TrainingParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.equals(parameterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<TrainingParameterLocalization> upsertTrainingParameterLocalization(
    Session session,
    int parameterId,
    TrainingParameterLocalization loc,
  ) async {
    final param =
        await TrainingParameter.db.findById(session, parameterId);
    if (param == null) throw Exception('Training parameter not found.');
    final orgId = param.organizationId;
    if (orgId != null) {
      await ensureLocaleConfigured(session, orgId, loc.localeKey);
    } else {
      validateLocaleKeyFormat(loc.localeKey);
    }
    loc.parameterId = parameterId;

    final TrainingParameterLocalization result;
    if (loc.id != null) {
      result =
          await TrainingParameterLocalization.db.updateRow(session, loc);
    } else {
      result =
          await TrainingParameterLocalization.db.insertRow(session, loc);
    }
    if (orgId != null) await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteTrainingParameterLocalization(
    Session session,
    int localizationId,
  ) async {
    final loc = await TrainingParameterLocalization.db
        .findById(session, localizationId);
    if (loc == null) return false;
    await TrainingParameterLocalization.db.deleteRow(session, loc);
    final param =
        await TrainingParameter.db.findById(session, loc.parameterId);
    if (param?.organizationId != null) {
      await bumpOrgContentVersion(session, param!.organizationId!);
    }
    return true;
  }

  // ── Localization CRUD (assessment) ────────────────────────────────────────

  Future<List<AssessmentParameterLocalization>>
      listAssessmentParameterLocalizations(
    Session session,
    int parameterId,
  ) async {
    return await AssessmentParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.equals(parameterId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<AssessmentParameterLocalization>
      upsertAssessmentParameterLocalization(
    Session session,
    int parameterId,
    AssessmentParameterLocalization loc,
  ) async {
    final param =
        await AssessmentParameter.db.findById(session, parameterId);
    if (param == null) throw Exception('Assessment parameter not found.');
    final orgId = param.organizationId;
    if (orgId != null) {
      await ensureLocaleConfigured(session, orgId, loc.localeKey);
    } else {
      validateLocaleKeyFormat(loc.localeKey);
    }
    loc.parameterId = parameterId;

    final AssessmentParameterLocalization result;
    if (loc.id != null) {
      result =
          await AssessmentParameterLocalization.db.updateRow(session, loc);
    } else {
      result =
          await AssessmentParameterLocalization.db.insertRow(session, loc);
    }
    if (orgId != null) await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteAssessmentParameterLocalization(
    Session session,
    int localizationId,
  ) async {
    final loc = await AssessmentParameterLocalization.db
        .findById(session, localizationId);
    if (loc == null) return false;
    await AssessmentParameterLocalization.db.deleteRow(session, loc);
    final param =
        await AssessmentParameter.db.findById(session, loc.parameterId);
    if (param?.organizationId != null) {
      await bumpOrgContentVersion(session, param!.organizationId!);
    }
    return true;
  }

  // ── Localization CRUD (asset) ─────────────────────────────────────────────

  Future<List<AssetLocalization>> listAssetLocalizations(
    Session session,
    int assetId,
  ) async {
    return await AssetLocalization.db.find(
      session,
      where: (l) => l.assetId.equals(assetId),
      orderBy: (l) => l.localeKey,
    );
  }

  Future<AssetLocalization> upsertAssetLocalization(
    Session session,
    int assetId,
    AssetLocalization loc,
  ) async {
    final asset = await Asset.db.findById(session, assetId);
    if (asset == null) throw Exception('Asset not found.');
    final orgId = asset.organizationId;
    if (orgId != null) {
      await ensureLocaleConfigured(session, orgId, loc.localeKey);
    } else {
      validateLocaleKeyFormat(loc.localeKey);
    }
    loc.assetId = assetId;

    final AssetLocalization result;
    if (loc.id != null) {
      result = await AssetLocalization.db.updateRow(session, loc);
    } else {
      result = await AssetLocalization.db.insertRow(session, loc);
    }
    if (orgId != null) await bumpOrgContentVersion(session, orgId);
    return result;
  }

  Future<bool> deleteAssetLocalization(
    Session session,
    int localizationId,
  ) async {
    final loc = await AssetLocalization.db.findById(session, localizationId);
    if (loc == null) return false;
    await AssetLocalization.db.deleteRow(session, loc);
    final asset = await Asset.db.findById(session, loc.assetId);
    if (asset?.organizationId != null) {
      await bumpOrgContentVersion(session, asset!.organizationId!);
    }
    return true;
  }

  // ── Locale-aware reads (resolve through fallback chain) ───────────────────

  Future<List<TheoryChapter>> getTheoryChaptersLocalized(
    Session session,
    int organizationId,
    String localeKey,
  ) async {
    validateLocaleKeyFormat(localeKey);
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(organizationId),
      orderBy: (c) => c.chapterOrder,
    );
    final chain =
        await LocaleResolver.resolveChain(session, organizationId, localeKey);
    final result = <TheoryChapter>[];
    for (final c in chapters) {
      final id = c.id;
      if (id == null) {
        result.add(c);
        continue;
      }
      final loc =
          await LocaleResolver.theoryChapter(session, id, chain);
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

  Future<List<TrainingParameter>> getTrainingParametersLocalized(
    Session session,
    int organizationId,
    String localeKey,
  ) async {
    validateLocaleKeyFormat(localeKey);
    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, organizationId, localeKey);
    final result = <TrainingParameter>[];
    for (final p in params) {
      final id = p.id;
      if (id == null) {
        result.add(p);
        continue;
      }
      final loc =
          await LocaleResolver.trainingParameter(session, id, chain);
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

  Future<List<AssessmentParameter>> getAssessmentParametersLocalized(
    Session session,
    int organizationId,
    String localeKey,
  ) async {
    validateLocaleKeyFormat(localeKey);
    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, organizationId, localeKey);
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

  Future<List<Asset>> getAssetsLocalized(
    Session session,
    int organizationId,
    String localeKey,
  ) async {
    validateLocaleKeyFormat(localeKey);
    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
    final chain =
        await LocaleResolver.resolveChain(session, organizationId, localeKey);
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
