import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';

class PublicApiEndpoint extends Endpoint {
  // This endpoint does not require login for its methods.

  Future<LoginResponse> login(Session session, String email, String password) async {
    var authResult = await auth.Emails.authenticate(session, email, password);

    if (!authResult.success || authResult.userInfo == null) {
      return LoginResponse(success: false);
    }

    var appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authResult.userInfo!.id),
    );

    return LoginResponse(
      success: true,
      userInfo: authResult.userInfo,
      appUser: appUser,
      keyId: authResult.keyId,
      key: authResult.key,
    );
  }

  Future<Tools?> updateTools(Session session, int appUserId, String apiKey, Tools newTools) async {
    // API Key authentication
    final expectedApiKey =  session.passwords['serviceApiKey'];
    if (expectedApiKey == null || apiKey!= expectedApiKey) {
      throw Exception('Invalid API Key.');
    }

    var user = await AppUser.db.findById(session, appUserId);
    if (user == null) {
      return null;
    }

    user.tools = newTools;
    await AppUser.db.updateRow(session, user);
    return user.tools;
  }
}