import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_panel_client/admin_panel_client.dart';
import '../../providers.dart';

// Provider to fetch the organization managed by the current user.
final managedOrganizationProvider = FutureProvider<Organization?>((ref) async {
  return ref.watch(clientProvider).manager.getManagedOrganization();
});

class ManagerDashboard extends ConsumerWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managedOrgAsync = ref.watch(managedOrganizationProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(0.2),
      appBar: AppBar(
        elevation: 2,
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(managedOrganizationProvider),
          ),
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

          return managedOrgAsync.when(
            data: (org) {
              if (org == null) {
                return const Center(
                  child: Text(
                    'You are not assigned to manage any organization.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Header Section ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              org.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            FilledButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return _AddUserDialog(organization: org);
                                  },
                                );
                              },
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Add User'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Manage your organization’s team members below",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),

                        // --- Users Section ---
                        _UserList(organization: org, isWide: isWide),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(
              child: Text('Error loading organization: $e'),
            ),
          );
        },
      ),
    );
  }
}

// --- USER LIST SECTION ---
class _UserList extends ConsumerWidget {
  const _UserList({required this.organization, required this.isWide});
  final Organization organization;
  final bool isWide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final users = organization.users
            ?.map((link) => link.appUser)
            .whereType<AppUser>()
            .toList() ??
        [];

    if (users.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('No users in this organization yet.')),
      );
    }

    if (isWide) {
      // --- Grid layout for larger screens ---
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final user = users[index];
          return _UserCard(user: user, organization: organization);
        },
      );
    } else {
      // --- List layout for mobile screens ---
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return _UserCard(user: user, organization: organization);
        },
      );
    }
  }
}

// --- INDIVIDUAL USER CARD ---
class _UserCard extends ConsumerWidget {
  const _UserCard({required this.user, required this.organization});
  final AppUser user;
  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          child: Icon(Icons.person, color: theme.colorScheme.primary),
        ),
        title: Text(
          user.userInfo?.userName ?? 'Unknown User',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(user.userInfo?.email ?? 'No email'),
        trailing: IconButton(
          tooltip: 'Remove User',
          icon: const Icon(Icons.delete_outline_rounded, color: Colors.red),
          onPressed: () async {
            try {
              await ref.read(clientProvider).manager.removeUserFromOrganization(
                    user.id!,
                    organization.id!,
                  );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User removed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              ref.invalidate(managedOrganizationProvider);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// --- ADD USER DIALOG ---
class _AddUserDialog extends ConsumerStatefulWidget {
  const _AddUserDialog({required this.organization});
  final Organization organization;

  @override
  ConsumerState<_AddUserDialog> createState() => __AddUserDialogState();
}

class __AddUserDialogState extends ConsumerState<_AddUserDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _addUser() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await ref.read(clientProvider).manager.createUserAndAssignToOrg(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
            Role.User,
            widget.organization.id!,
          );

      if (mounted) Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      ref.invalidate(managedOrganizationProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Add New User'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        _isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CircularProgressIndicator(),
              )
            : FilledButton.icon(
                onPressed: _addUser,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add'),
                style: FilledButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                ),
              ),
      ],
    );
  }
}
