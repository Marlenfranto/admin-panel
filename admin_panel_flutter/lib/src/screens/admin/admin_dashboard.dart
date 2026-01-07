import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin_panel_client/admin_panel_client.dart';
import '../../providers.dart';

// === Providers ===
final allOrganizationsProvider = FutureProvider<List<Organization>>((ref) async {
  return ref.watch(clientProvider).admin.getAllOrganizations();
});

final allUsersProvider = FutureProvider<List<AppUser>>((ref) async {
  return ref.watch(clientProvider).admin.getAllUsers();
});

class AdminDashboard extends ConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.admin_panel_settings_rounded, size: 28),
            const SizedBox(width: 8),
            const Text('Admin Dashboard'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh Data',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.invalidate(allOrganizationsProvider);
              ref.invalidate(allUsersProvider);
            },
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
          // Responsive layout adjustments
          final isWide = constraints.maxWidth > 900;
          final crossAxisCount = isWide ? 2 : 1;
          final padding = isWide ? 24.0 : 16.0;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Management Tools",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- Responsive grid layout for cards ---
                    GridView.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        _CreateOrganizationCard(),
                        _CreateUserCard(),
                        _AssignManagerCard(),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // --- Optional future section for listing orgs/users ---
                    Text(
                      "Overview",
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Add visual analytics here later (charts, lists, KPIs, etc.)",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
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

// === Create Organization Card ===
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
          backgroundColor: Colors.green,
        ),
      );
      _nameController.clear();
      ref.invalidate(allOrganizationsProvider);
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

    return _ModernCard(
      title: "Create Organization",
      icon: Icons.business_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  child: FilledButton.icon(
                    onPressed: _createOrganization,
                    icon: const Icon(Icons.add_business_rounded),
                    label: const Text('Create'),
                  ),
                ),
        ],
      ),
    );
  }
}

// === Create User Card ===
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
          content: Text('Please fill all fields and select an organization.'),
          backgroundColor: Colors.orange,
        ),
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
            _selectedOrgId!,
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User created successfully!'),
          backgroundColor: Colors.green,
        ),
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
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final orgsAsync = ref.watch(allOrganizationsProvider);

    return _ModernCard(
      title: "Create User",
      icon: Icons.person_add_alt_1_rounded,
      child: Column(
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
          const SizedBox(height: 12),
          DropdownButtonFormField<Role>(
            value: _selectedRole,
            decoration: const InputDecoration(
              labelText: 'Role',
              border: OutlineInputBorder(),
            ),
            items: Role.values
                .map((role) => DropdownMenuItem(
                      value: role,
                      child: Text(role.name),
                    ))
                .toList(),
            onChanged: (value) => setState(() => _selectedRole = value!),
          ),
          if (_selectedRole != Role.Admin) ...[
            const SizedBox(height: 12),
            orgsAsync.when(
              data: (orgs) => DropdownButtonFormField<int>(
                value: _selectedOrgId,
                decoration: const InputDecoration(
                  labelText: 'Organization',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Select Organization'),
                items: orgs
                    .map((org) => DropdownMenuItem(
                          value: org.id,
                          child: Text(org.name),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedOrgId = value),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Text('Error loading organizations: $e'),
            ),
          ],
          const SizedBox(height: 16),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _createUser,
                    icon: const Icon(Icons.person_add_rounded),
                    label: const Text('Create User'),
                  ),
                ),
        ],
      ),
    );
  }
}

// === Assign Manager Card ===
class _AssignManagerCard extends ConsumerStatefulWidget {
  const _AssignManagerCard();

  @override
  ConsumerState<_AssignManagerCard> createState() =>
      __AssignManagerCardState();
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
          backgroundColor: Colors.orange,
        ),
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
            backgroundColor: Colors.green,
          ),
        );
        ref.invalidate(allOrganizationsProvider);
      } else {
        throw Exception('Failed to assign manager.');
      }
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
    final orgsAsync = ref.watch(allOrganizationsProvider);
    final usersAsync = ref.watch(allUsersProvider);

    return _ModernCard(
      title: "Assign Manager",
      icon: Icons.assignment_ind_rounded,
      child: Column(
        children: [
          usersAsync.when(
            data: (users) {
              final managers =
                  users.where((u) => u.role == Role.Manager).toList();
              return DropdownButtonFormField<int>(
                value: _selectedManagerId,
                decoration: const InputDecoration(
                  labelText: 'Select Manager',
                  border: OutlineInputBorder(),
                ),
                items: managers
                    .map((m) => DropdownMenuItem(
                          value: m.id,
                          child: Text(m.userInfo?.userName ?? 'Unknown'),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedManagerId = value),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 12),
          orgsAsync.when(
            data: (orgs) => DropdownButtonFormField<int>(
              value: _selectedOrgId,
              decoration: const InputDecoration(
                labelText: 'Select Organization',
                border: OutlineInputBorder(),
              ),
              items: orgs
                  .map((org) => DropdownMenuItem(
                        value: org.id,
                        child: Text(org.name),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedOrgId = value),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: _assignManager,
                    icon: const Icon(Icons.assignment_turned_in_rounded),
                    label: const Text('Assign Manager'),
                  ),
                ),
        ],
      ),
    );
  }
}

// === Shared Modern Card Widget ===
class _ModernCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _ModernCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary, size: 28),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            child,
          ],
        ),
      ),
    );
  }
}
