import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';

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
    return link?.organizationId;
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

    return await TheoryChapter.db.find(
      session,
      where: (c) => c.organizationId.equals(orgId),
      orderBy: (c) => c.chapterOrder,
    );
  }

  Future<List<TrainingParameter>> getTrainingParameters(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    return await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
  }

  Future<List<AssessmentParameter>> getAssessmentParameters(Session session) async {
    final orgId = await _getMyOrganizationId(session);
    if (orgId == null) return [];

    return await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(orgId),
    );
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
}
