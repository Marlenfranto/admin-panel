import 'package:serverpod/serverpod.dart';
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
}