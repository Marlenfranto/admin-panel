import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authProvider).appUser;
    final userInfo = ref.watch(authProvider).userInfo;

    // A fallback for when user data is not yet available.
    if (appUser == null) {
      return const Scaffold(body: Center(child: Text("User data not found.")));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${userInfo?.userName ?? 'User'}!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Email: ${userInfo?.email ?? 'No email provided'}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Divider(height: 32),
                    Text(
                      'Your Permissions & Tools:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _ToolStatusTile(
                      title: 'Theory Access',
                      icon: Icons.book,
                      value: appUser.tools.theory,
                    ),
                    _ToolStatusTile(
                      title: 'AI Tool Access',
                      icon: Icons.memory,
                      value: appUser.tools.ai,
                    ),
                    _ToolStatusTile(
                      title: 'Training Module Access',
                      icon: Icons.model_training,
                      value: appUser.tools.training,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolStatusTile extends StatelessWidget {
  const _ToolStatusTile({
    required this.title,
    required this.icon,
    required this.value,
  });

  final String title;
  final IconData icon;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: value ? Colors.green : Colors.grey),
      title: Text(title),
      trailing: Text(
        value ? 'Enabled' : 'Disabled',
        style: TextStyle(
          color: value ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}