import 'package:admin_panel_server/src/scopes.dart';
import 'package:serverpod/serverpod.dart';

import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;


import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints(),authenticationHandler: auth.authenticationHandler,);


  // Start the server.
  await pod.start();

  var session = await pod.createSession(enableLogging: false);
  try {
    await _createDefaultAdminIfNeeded(session);
  } finally {
    await session.close();
  }


}

Future<void> _createDefaultAdminIfNeeded(Session session) async {
  // Check if the admin user already exists.
  var adminUser = await auth.Users.findUserByEmail(session, 'admin@mako.com');

  if (adminUser == null) {
    print('Admin user not found. Creating default admin...');
    // Create the UserInfo record using the auth module.
    var userInfo = auth.UserInfo(
      userIdentifier: 'defaultadmin',
      email: 'admin@mako.com',
      userName: 'Default Admin',
      created: DateTime.now().toUtc(),
      scopeNames:[], 
      blocked: false,
    );

    // Use the auth module's createUser method, which handles password hashing.
    userInfo = (await auth.Emails.createUser(session, 'Default Admin', 'admin@mako.com','Mako@123'))!;

    if (userInfo!= null) {
      // Create our corresponding AppUser record.
      var appUser = AppUser(
        userInfoId: userInfo.id!,
        role: Role.Admin,
        tools: Tools(theory: true, ai: true, training: true), // Admins get all tools
      );
      await AppUser.db.insertRow(session, appUser);

      // Assign the 'admin' scope to the user.
      await auth.Users.updateUserScopes(session, userInfo.id!, {AppScopes.admin});
      print('Default admin user created successfully.');
    } else {
      print('Failed to create default admin user.');
    }
  }
}


