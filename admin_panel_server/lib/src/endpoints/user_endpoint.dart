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
}
