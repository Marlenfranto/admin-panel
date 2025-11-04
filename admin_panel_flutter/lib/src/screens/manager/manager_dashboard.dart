import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_panel_client/admin_panel_client.dart';
import '../../providers.dart';

// Provider to fetch the organization managed by the current user.
final managedOrganizationProvider = FutureProvider<Organization?>((ref) async {
  // Assuming this client method exists on the server
  return ref.watch(clientProvider).manager.getManagedOrganization();
});

class ManagerDashboard extends ConsumerWidget {
  const ManagerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managedOrgAsync = ref.watch(managedOrganizationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(managedOrganizationProvider),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: managedOrgAsync.when(
        data: (org) {
          if (org == null) {
            return const Center(
                child:
                    Text('You are not assigned to manage any organization.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Managing Organization: ${org.name}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Users in Organization',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Show the dialog to add a new user
                        showDialog(
                          context: context,
                          barrierDismissible: false, // User must tap button!
                          builder: (BuildContext context) {
                            return _AddUserDialog(organization: org);
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add User'),
                    ),
                  ],
                ),
                const Divider(),
                _UserList(organization: org),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _UserList extends ConsumerWidget {
  const _UserList({required this.organization});
  final Organization organization;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Filter out any null AppUser objects that might result from the mapping.
    final users = organization.users
            ?.map((link) => link.appUser)
            .whereType<AppUser>()
            .toList() ??
        [];

    if (users.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('No users in this organization.')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user.userInfo?.userName ?? 'Unknown User'),
            subtitle: Text(user.userInfo?.email ?? 'No email'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              tooltip: 'Remove User',
              onPressed: () async {
                try {
                  // This server call removes the user from the organization
                  await ref
                      .read(clientProvider)
                      .manager
                      .removeUserFromOrganization(user.id!, organization.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('User removed.'),
                        backgroundColor: Colors.green),
                  );
                  ref.invalidate(
                      managedOrganizationProvider); // Refresh the data
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}

/// A dialog for adding a new user to the manager's organization.
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
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields.'),
            backgroundColor: Colors.orange),
      );
      return;
    }
    setState(() => _isLoading = true);

    try {
      // Assume an endpoint exists for managers to add users to their own org.
      // The role is implicitly 'User'.
      await ref.read(clientProvider).manager.createUserAndAssignToOrg(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
            Role.User,
            widget.organization.id!,
          );

      // Close the dialog on success
      if (mounted) Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User added successfully!'),
            backgroundColor: Colors.green),
      );

      ref.invalidate(managedOrganizationProvider); // Refresh the user list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              enabled: !_isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              enabled: !_isLoading,
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
            : ElevatedButton(
                onPressed: _addUser,
                child: const Text('Add User'),
              ),
      ],
    );
  }
}
