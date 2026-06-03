import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../util/default_locale_writer.dart';
import '../util/locale_resolver.dart';
import '../util/locale_validator.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<AppUser?> getMyPermissions(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    return await AppUser.db.findFirstRow(
      session,
      where: (user) => user.userInfoId.equals(authInfo.userId),
    );
  }

  Future<int?> _getMyOrganizationId(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return null;

    final link = await OrganizationUserLink.db.findFirstRow(
      session,
      where: (l) => l.appUserId.equals(appUser.id),
    );
    if (link == null) return null;

    // Users are linked to teams (child orgs). Module config and progress records
    // are stored at the parent org level, so resolve up to the parent org ID.
    final org = await Organization.db.findById(session, link.organizationId);
    if (org == null) return null;
    return org.parentId ?? org.id;
  }

  Future<ModuleConfig?> getMyOrgModuleConfig(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return null;

    return await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(orgId),
    );
  }

  Future<List<TheoryChapter>> getTheoryChapters(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
    await hydrateTheoryChapters(session, chapters);
    return chapters;
  }

  Future<List<TrainingParameter>> getTrainingParameters(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
    await hydrateTrainingParameters(session, params);
    return params;
  }

  Future<List<AssessmentParameter>> getAssessmentParameters(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
    await hydrateAssessmentParameters(session, params);
    return params;
  }

  // ── Locale-aware reads ────────────────────────────────────────────────────

  Future<List<TheoryChapter>> getLocalizedTheoryChapters(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];
    validateLocaleKeyFormat(localeKey);
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
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

  Future<List<TrainingParameter>> getLocalizedTrainingParameters(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];
    validateLocaleKeyFormat(localeKey);
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
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

  Future<List<AssessmentParameter>> getLocalizedAssessmentParameters(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];
    validateLocaleKeyFormat(localeKey);
    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
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

  /// Changes the authenticated user's password after verifying [currentPassword].
  /// Returns true on success, false if [currentPassword] is wrong or user not found.
  Future<bool> changePassword(
      Session session, String currentPassword, String newPassword) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return false;

    final userInfo = await Users.findUserByUserId(session, authInfo.userId);
    if (userInfo?.email == null) return false;

    return await Emails.changePassword(
      session,
      userInfo!.id!,
      currentPassword,
      newPassword,
    );
  }

  // ── Locale preference ─────────────────────────────────────────────────────

  /// Returns the enabled LocaleConfig list for the user's org so the client
  /// can populate a locale picker.
  Future<List<LocaleConfig>> getMyLocales(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];
    return await LocaleConfig.db.find(
      session,
      where: (l) => l.organizationId.equals(orgId) & l.enabled.equals(true),
      orderBy: (l) => l.localeKey,
    );
  }

  /// Persists [localeKey] on the caller's AppUser row. Validates the key is
  /// well-formed and configured on the user's org.
  Future<AppUser?> setPreferredLocale(
    Session session,
    String localeKey,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) {
      throw Exception('No organization found for user.');
    }
    await ensureLocaleConfigured(session, orgId, localeKey);

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return null;
    appUser.preferredLocaleKey = localeKey;
    return await AppUser.db.updateRow(session, appUser);
  }

  // ── Module progress ───────────────────────────────────────────────────────

  Future<List<UserModuleProgress>> getMyModuleProgress(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return [];

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return [];

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    return await UserModuleProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) & p.organizationId.equals(orgId),
    );
  }

  // ── Training session results ───────────────────────────────────────────────

  /// Records a completed Smart Training attempt for the authenticated user.
  Future<TrainingSessionResult?> submitTrainingResult(
    Session session,
    String externalUserId,
    int overallPercentage,
    List<TrainingCriteriaScore> criteriaScores,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return null;

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return null;

    final result = TrainingSessionResult(
      appUserId: appUser.id!,
      organizationId: orgId,
      externalUserId: externalUserId,
      overallPercentage: overallPercentage,
      criteriaScores: criteriaScores,
      completedAt: DateTime.now().toUtc(),
    );
    return await TrainingSessionResult.db.insertRow(session, result);
  }

  /// Returns all Smart Training attempts for the authenticated user, newest first.
  Future<List<TrainingSessionResult>> getMyTrainingHistory(
      Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return [];

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return [];

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    // Match by appUserId (authenticated submissions) OR by externalUserId
    // (submissions from the external training app via the public API, which
    // store appUserId as null but send the AppUser.id as a string userId).
    final results = await TrainingSessionResult.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(orgId) &
          (r.appUserId.equals(appUser.id) |
              r.externalUserId.equals(appUser.id.toString())),
    );
    results.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return results;
  }

  /// Allows a user to update their own module status. Automatically sets
  /// [startedAt] on first inProgress transition, [completedAt] on completion.
  Future<UserModuleProgress?> updateMyModuleStatus(
    Session session,
    String moduleId,
    ModuleProgressStatus status,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return null;

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return null;

    var existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) &
          p.organizationId.equals(orgId) &
          p.moduleId.equals(moduleId),
    );
    if (existing == null) return null;

    existing.status = status;
    if (status == ModuleProgressStatus.inProgress &&
        existing.startedAt == null) {
      existing.startedAt = DateTime.now().toUtc();
    } else if (status == ModuleProgressStatus.completed &&
        existing.completedAt == null) {
      existing.completedAt = DateTime.now().toUtc();
    }
    return await UserModuleProgress.db.updateRow(session, existing);
  }

  // ── Theory Progress ──────────────────────────────────────────────────────────

  /// Locale-aware variant of [getTheoryChaptersWithProgress]. Each chapter's
  /// content fields (title, thumbnail, video, metadata) are resolved through
  /// the LocaleResolver fallback chain for [localeKey].
  Future<List<TheoryChapterWithProgress>>
      getLocalizedTheoryChaptersWithProgress(
    Session session,
    String localeKey,
  ) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];
    validateLocaleKeyFormat(localeKey);

    final authInfo = await session.authenticated;
    if (authInfo == null) return [];

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return [];

    final chain =
        await LocaleResolver.resolveChain(session, orgId, localeKey);
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
    final progressList = await UserTheoryProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) & p.organizationId.equals(orgId),
    );
    final progressMap = {for (final p in progressList) p.chapterId: p};

    final result = <TheoryChapterWithProgress>[];
    for (final c in chapters) {
      final id = c.id;
      final localized = id == null
          ? c
          : await () async {
              final loc =
                  await LocaleResolver.theoryChapter(session, id, chain);
              return TheoryChapter(
                id: c.id,
                organizationId: c.organizationId,
                chapterOrder: c.chapterOrder,
                title: loc?.title ?? c.title,
                thumbnailUrl: loc?.thumbnailUrl ?? c.thumbnailUrl,
                videoUrl: loc?.videoUrl ?? c.videoUrl,
                videoMetadata: loc?.videoMetadata ?? c.videoMetadata,
                questions: c.questions,
              );
            }();
      result.add(TheoryChapterWithProgress(
        chapter: localized,
        progress: progressMap[c.id],
      ));
    }
    return result;
  }

  /// Fetches all theory chapters for the authenticated user's organization,
  /// including the user's specific progress/score for each.
  Future<List<TheoryChapterWithProgress>> getTheoryChaptersWithProgress(
      Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    final authInfo = await session.authenticated;
    if (authInfo == null) return [];

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return [];

    // 1. Fetch all chapters for the org
    final chapters = await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
    await hydrateTheoryChapters(session, chapters);

    // 2. Fetch user performance record for these chapters
    final progressList = await UserTheoryProgress.db.find(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) & p.organizationId.equals(orgId),
    );

    final progressMap = {
      for (final p in progressList) p.chapterId: p,
    };

    return chapters.map((c) {
      return TheoryChapterWithProgress(
        chapter: c,
        progress: progressMap[c.id],
      );
    }).toList();
  }

  /// Validates a quiz submission and saves the user's result.
  /// Throws if authorization fails or chapter is not found.
  Future<UserTheoryProgress?> submitTheoryQuiz(
    Session session,
    int chapterId,
    int score,
  ) async {
    final authInfo = await session.authenticated;
    if (authInfo == null) return null;

    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authInfo.userId),
    );
    if (appUser == null) return null;

    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return null;

    // Validate chapter existence and ownership
    final chapter = await TheoryChapter.db.findById(session, chapterId);
    if (chapter == null || chapter.organizationId != orgId) {
      throw Exception('Forbidden: Chapter not found or access denied.');
    }

    final now = DateTime.now().toUtc();

    var existing = await UserTheoryProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) &
          p.organizationId.equals(orgId) &
          p.chapterId.equals(chapterId),
    );

    // Check if the score meets the organization's passing threshold
    final config = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(orgId),
    );
    final passingPercentage = config?.passingPercentage ?? 60;

    final status = score >= passingPercentage
        ? ModuleProgressStatus.completed 
        : ModuleProgressStatus.inProgress;

    if (existing != null) {
      existing.score = score;
      existing.status = status;
      existing.completedAt = now;
      return await UserTheoryProgress.db.updateRow(session, existing);
    } else {
      return await UserTheoryProgress.db.insertRow(
        session,
        UserTheoryProgress(
          appUserId: appUser.id!,
          organizationId: orgId,
          chapterId: chapterId,
          score: score,
          status: status,
          completedAt: now,
        ),
      );
    }
  }
}
