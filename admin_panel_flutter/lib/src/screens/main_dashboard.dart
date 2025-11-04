import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import 'admin/admin_dashboard.dart';
import 'manager/manager_dashboard.dart';
import 'user/user_dashboard.dart';

class MainDashboard extends ConsumerWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authProvider).appUser;

    // Show a loading indicator while the appUser data is being fetched.
    if (appUser == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // This is the core of role-based view rendering.
    // It returns the appropriate dashboard widget based on the user's role.
    switch (appUser.role) {
      case Role.Admin:
        return const AdminDashboard();
      case Role.Manager:
        return const ManagerDashboard();
      case Role.User:
        return const UserDashboard();
    }
  }
}