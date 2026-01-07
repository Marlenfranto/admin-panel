import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class UserDashboard extends ConsumerWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(authProvider).appUser;
    final userInfo = ref.watch(authProvider).userInfo;

    if (appUser == null) {
      return const Scaffold(
        body: Center(child: Text("User data not found.")),
      );
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment:
                      isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                  children: [
                    // === Header Section ===
                    Row(
                      mainAxisAlignment: isWide
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: isWide
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome back, ${userInfo?.userName ?? 'User'} 👋',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                userInfo?.email ?? 'No email provided',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                                textAlign: isWide
                                    ? TextAlign.start
                                    : TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        if (isWide)
                          CircleAvatar(
                            radius: 28,
                            backgroundColor:
                                theme.colorScheme.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.person_rounded,
                              color: theme.colorScheme.primary,
                              size: 32,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 32),
                    Text(
                      "Your Tools & Permissions",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // === Responsive Card Layout ===
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        _ToolCard(
                          title: "Theory Access",
                          icon: Icons.book_rounded,
                          enabled: appUser.tools.theory,
                          color: Colors.blue,
                        ),
                        _ToolCard(
                          title: "AI Tools",
                          icon: Icons.memory_rounded,
                          enabled: appUser.tools.ai,
                          color: Colors.deepPurple,
                        ),
                        _ToolCard(
                          title: "Training Module",
                          icon: Icons.school_rounded,
                          enabled: appUser.tools.training,
                          color: Colors.green,
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // === User Info Card ===
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: isWide
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: isWide
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Account Information',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Role: ${appUser.role.name}',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  'User ID: ${appUser.id}',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                            if (isWide)
                              Icon(
                                Icons.account_circle_rounded,
                                color: theme.colorScheme.primary,
                                size: 64,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// === Modern Tool Card ===
class _ToolCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool enabled;
  final Color color;

  const _ToolCard({
    required this.title,
    required this.icon,
    required this.enabled,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: enabled
              ? [color.withOpacity(0.9), color.withOpacity(0.6)]
              : [Colors.grey.shade300, Colors.grey.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: enabled
                ? color.withOpacity(0.2)
                : Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 40,
            color: enabled ? Colors.white : Colors.grey.shade700,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              color: enabled ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            enabled ? 'Enabled' : 'Disabled',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: enabled ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
