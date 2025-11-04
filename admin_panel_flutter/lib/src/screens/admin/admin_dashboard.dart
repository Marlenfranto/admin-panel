import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_panel_client/admin_panel_client.dart';
import '../../providers.dart';

// Provider to get all organizations
final allOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  return ref.watch(clientProvider).admin.getAllOrganizations();
});

// Provider to get all users
final allUsersProvider = FutureProvider<List<AppUser>>((ref) async {
  return ref.watch(clientProvider).admin.getAllUsers();
});

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(allOrganizationsProvider);
              ref.invalidate(allUsersProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _CreateOrganizationCard(),
            SizedBox(height: 16),
            _CreateUserCard(),
            SizedBox(height: 16),
            _AssignManagerCard(),
            // You can add lists of users and organizations here for viewing
          ],
        ),
      ),
    );
  }
}

class _CreateOrganizationCard extends ConsumerStatefulWidget {
  const _CreateOrganizationCard();

  @override
  ConsumerState<_CreateOrganizationCard> createState() =>
      __CreateOrganizationCardState();
}

class __CreateOrganizationCardState
    extends ConsumerState<_CreateOrganizationCard> {
  final _nameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createOrganization() async {
    if (_nameController.text.trim().isEmpty) return;
    setState(() => _isLoading = true);

    try {
      await ref
          .read(clientProvider)
          .admin
          .createOrganization(_nameController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Organization created successfully!'),
            backgroundColor: Colors.green),
      );
      _nameController.clear();
      ref.invalidate(allOrganizationsProvider);
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
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create Organization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Organization Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _createOrganization,
                      child: const Text('Create'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _CreateUserCard extends ConsumerStatefulWidget {
  const _CreateUserCard();

  @override
  ConsumerState<_CreateUserCard> createState() => __CreateUserCardState();
}

class __CreateUserCardState extends ConsumerState<_CreateUserCard> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Role _selectedRole = Role.User;
  int? _selectedOrgId;
  bool _isLoading = false;

  Future<void> _createUser() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        (_selectedRole != Role.Admin && _selectedOrgId == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and select an organization for non-admins.'),
            backgroundColor: Colors.orange),
      );
      return;
    }
    setState(() => _isLoading = true);

    try {
      await ref.read(clientProvider).admin.createUserAndAssignToOrg(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _selectedRole,
            _selectedOrgId!, // Can be null for admin
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User created successfully!'),
            backgroundColor: Colors.green),
      );
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      ref.invalidate(allUsersProvider);
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
  Widget build(BuildContext context) {
    final orgsAsync = ref.watch(allOrganizationsProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Create User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'User Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true),
            const SizedBox(height: 12),
            DropdownButtonFormField<Role>(
              value: _selectedRole,
              items: Role.values.map((role) => DropdownMenuItem(value: role, child: Text(role.name))).toList(),
              onChanged: (value) => setState(() => _selectedRole = value!),
              decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
            ),
            if (_selectedRole != Role.Admin) ...[
              const SizedBox(height: 12),
              orgsAsync.when(
                data: (orgs) => DropdownButtonFormField<int>(
                  value: _selectedOrgId,
                  hint: const Text('Select Organization'),
                  items: orgs.map((org) => DropdownMenuItem(value: org.id, child: Text(org.name))).toList(),
                  onChanged: (value) => setState(() => _selectedOrgId = value),
                  decoration: const InputDecoration(labelText: 'Organization', border: OutlineInputBorder()),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error loading orgs: $e'),
              ),
            ],
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _createUser,
                      child: const Text('Create User'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _AssignManagerCard extends ConsumerStatefulWidget {
  const _AssignManagerCard();

  @override
  ConsumerState<_AssignManagerCard> createState() => __AssignManagerCardState();
}

class __AssignManagerCardState extends ConsumerState<_AssignManagerCard> {
  int? _selectedManagerId;
  int? _selectedOrgId;
  bool _isLoading = false;

  Future<void> _assignManager() async {
    if (_selectedManagerId == null || _selectedOrgId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a manager and an organization.'),
            backgroundColor: Colors.orange),
      );
      return;
    }
    setState(() => _isLoading = true);

    try {
      final success = await ref
          .read(clientProvider)
          .admin
          .assignManagerToOrg(_selectedManagerId!, _selectedOrgId!);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Manager assigned successfully!'),
              backgroundColor: Colors.green),
        );
        ref.invalidate(allOrganizationsProvider); // Refresh data
      } else {
        throw Exception('Failed to assign manager.');
      }
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
  Widget build(BuildContext context) {
    final orgsAsync = ref.watch(allOrganizationsProvider);
    final usersAsync = ref.watch(allUsersProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Assign Manager to Organization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            usersAsync.when(
              data: (users) {
                // Filter for users who are managers
                final managers = users.where((u) => u.role == Role.Manager).toList();
                return DropdownButtonFormField<int>(
                  value: _selectedManagerId,
                  hint: const Text('Select Manager'),
                  items: managers.map((m) => DropdownMenuItem(value: m.id, child: Text(m.userInfo?.userName ?? ''))).toList(),
                  onChanged: (value) => setState(() => _selectedManagerId = value),
                  decoration: const InputDecoration(labelText: 'Manager', border: OutlineInputBorder()),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error: $e'),
            ),
            const SizedBox(height: 12),
            orgsAsync.when(
              data: (orgs) => DropdownButtonFormField<int>(
                value: _selectedOrgId,
                hint: const Text('Select Organization'),
                items: orgs.map((org) => DropdownMenuItem(value: org.id, child: Text(org.name))).toList(),
                onChanged: (value) => setState(() => _selectedOrgId = value),
                decoration: const InputDecoration(labelText: 'Organization', border: OutlineInputBorder()),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error: $e'),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: _assignManager,
                      child: const Text('Assign Manager'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}