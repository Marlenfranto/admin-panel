import 'package:admin_panel_server/src/scopes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
  );

  await pod.start();

  var session = await pod.createSession(enableLogging: false);
  try {
    await _createDefaultAdminIfNeeded(session);
  } finally {
    await session.close();
  }
}

Future<void> _createDefaultAdminIfNeeded(Session session) async {
  var adminUser = await auth.Users.findUserByEmail(session, 'admin@mako.com');

  if (adminUser == null) {
    print('Admin user not found. Creating default admin...');

    var userInfo = await auth.Emails.createUser(session, 'Default Admin', 'admin@mako.com', 'Mako@123');

    if (userInfo != null) {
      var appUser = AppUser(
        userInfoId: userInfo.id!,
        role: Role.SuperAdmin,
        tools: Tools(theory: true, ai: true, training: true, assessment: true),
      );
      await AppUser.db.insertRow(session, appUser);

      await auth.Users.updateUserScopes(session, userInfo.id!, {AppScopes.admin});
      print('Default SuperAdmin user created successfully.');
    } else {
      print('Failed to create default admin user.');
    }
  }
}
