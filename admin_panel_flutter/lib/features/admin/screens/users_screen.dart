import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
import '../../../src/providers.dart';

class UsersScreen extends ConsumerWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(allUsersProvider);
    final orgsAsync  = ref.watch(allOrganizationsProvider);
    final users      = usersAsync.value ?? [];
    final managers   = users.where((u) => u.role == Role.Manager).length;
    final regulars   = users.where((u) => u.role == Role.User).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ───────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Users', style: AppTextStyles.headingLg),
                    const SizedBox(height: 4),
                    Text(
                      'Manage platform users and their roles.',
                      style: AppTextStyles.bodySm,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              AppGradientButton(
                label:     'Add User',
                icon:      Icons.person_add_rounded,
                onPressed: () => _showAddUserSheet(
                    context, ref, orgsAsync.value ?? []),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Stats row ─────────────────────────────────────────────────────
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _StatCard(
                icon:        Icons.people_rounded,
                accentColor: AppColors.primary,
                value:       '${users.length}',
                label:       'Total Users',
                isLoading:   usersAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.manage_accounts_rounded,
                accentColor: AppColors.info,
                value:       '$managers',
                label:       'Managers',
                isLoading:   usersAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.person_rounded,
                accentColor: AppColors.success,
                value:       '$regulars',
                label:       'Regular Users',
                isLoading:   usersAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Assign Manager card ───────────────────────────────────────────
          _AssignManagerCard(
            users: users,
            orgs:  orgsAsync.value ?? [],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Users table ───────────────────────────────────────────────────
          _UsersTable(
            usersAsync: usersAsync,
            orgs:       orgsAsync.value ?? [],
            onEdit:     (u) => _showEditUserSheet(context, ref, u),
            onDelete:   (u) => _confirmDeleteUser(context, ref, u),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── All users training history ─────────────────────────────────────
          AllUsersTrainingHistoryPanel(
            users: users.where((u) => u.role == Role.User).toList(),
            historyLoader: (userId) =>
                ref.read(clientProvider).admin.getUserTrainingHistory(userId),
          ),
        ],
      ),
    );
  }

  void _showEditUserSheet(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
  ) {
    final nameCtrl = TextEditingController(
        text: user.userInfo?.userName ?? '');
    final roleNotifier = ValueNotifier<Role>(user.role);

    AppSideSheet.show(
      context:   context,
      title:     'Edit User',
      saveLabel: 'Save Changes',
      body: _EditUserBody(
        nameCtrl:     nameCtrl,
        roleNotifier: roleNotifier,
        currentRole:  user.role,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Name is required.');
        }
        await ref.read(clientProvider).admin.updateUser(
              user.id!,
              nameCtrl.text.trim(),
              roleNotifier.value,
            );
        ref.invalidate(allUsersProvider);
      },
    );
  }

  Future<void> _confirmDeleteUser(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title:   const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete '
          '"${user.userInfo?.userName ?? 'this user'}"? '
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:     const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child:     const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(clientProvider).admin.deleteUser(user.id!);
      ref.invalidate(allUsersProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User deleted.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:         Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showAddUserSheet(
    BuildContext context,
    WidgetRef ref,
    List<Organization> orgs,
  ) {
    final nameCtrl  = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();
    final roleNotifier = ValueNotifier<Role>(Role.User);
    final orgNotifier  = ValueNotifier<int?>(null);

    AppSideSheet.show(
      context:   context,
      title:     'Add User',
      saveLabel: 'Create User',
      body: _AddUserBody(
        nameCtrl:     nameCtrl,
        emailCtrl:    emailCtrl,
        passCtrl:     passCtrl,
        roleNotifier: roleNotifier,
        orgNotifier:  orgNotifier,
        orgs:         orgs,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty ||
            emailCtrl.text.trim().isEmpty ||
            passCtrl.text.trim().isEmpty ||
            orgNotifier.value == null) {
          throw Exception('All fields are required.');
        }
        await ref.read(clientProvider).admin.createUserAndAssignToOrg(
              nameCtrl.text.trim(),
              emailCtrl.text.trim(),
              passCtrl.text.trim(),
              roleNotifier.value,
              orgNotifier.value!,
            );
        ref.invalidate(allUsersProvider);
      },
    );
  }
}

// ── Compact stat card ─────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.accentColor,
    required this.value,
    required this.label,
    required this.isLoading,
  });

  final IconData icon;
  final Color    accentColor;
  final String   value;
  final String   label;
  final bool     isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppSkeletonBox(
          width: 200, height: 72, radius: AppSpacing.radiusLg);
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 180),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardPadding, vertical: AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width:  40,
            height: 40,
            decoration: BoxDecoration(
              color:        accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(icon, size: 18, color: accentColor),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value, style: AppTextStyles.headingMd),
              Text(label, style: AppTextStyles.bodyXs),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Users table ───────────────────────────────────────────────────────────────

class _UsersTable extends StatelessWidget {
  const _UsersTable({
    required this.usersAsync,
    required this.orgs,
    required this.onEdit,
    required this.onDelete,
  });
  final AsyncValue<List<AppUser>> usersAsync;
  final List<Organization>        orgs;
  final void Function(AppUser)    onEdit;
  final void Function(AppUser)    onDelete;

  /// Builds a map of appUserId → organization name from the already-loaded orgs.
  Map<int, String> _buildOrgMap() {
    final map = <int, String>{};
    for (final org in orgs) {
      for (final link in org.users ?? []) {
        final userId = link.appUserId;
        map[userId] = org.name;
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final orgMap = _buildOrgMap();
    return Container(
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Row(
              children: [
                Text('All Users', style: AppTextStyles.headingSm),
                const Spacer(),
                if (usersAsync.value != null)
                  Text(
                    '${usersAsync.value!.length} total',
                    style: AppTextStyles.bodyXs,
                  ),
              ],
            ),
          ),
          AppDataTable<AppUser>(
            isLoading:  usersAsync.isLoading,
            rows:       usersAsync.value ?? [],
            searchable: true,
            columns: [
              // ── User (name + email) ────────────────────────────────────────
              AppTableColumn(
                label:       'User',
                flex:        4,
                sortKey:     'name',
                comparator:  (a, b) =>
                    (a.userInfo?.userName ?? '')
                        .compareTo(b.userInfo?.userName ?? ''),
                searchValue: (u) =>
                    '${u.userInfo?.userName ?? ''} ${u.userInfo?.email ?? ''}',
                cellBuilder: (u) => Row(
                  children: [
                    _UserAvatar(
                        name: u.userInfo?.userName ?? '?', role: u.role),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            u.userInfo?.userName ?? '—',
                            style:    AppTextStyles.labelLg,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            u.userInfo?.email ?? '',
                            style:    AppTextStyles.bodyXs,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Organization ───────────────────────────────────────────────
              AppTableColumn(
                label:       'Organization',
                flex:        3,
                searchValue: (u) => u.id != null ? (orgMap[u.id!] ?? '') : '',
                cellBuilder: (u) {
                  final showOrg = u.role == Role.Manager ||
                      u.role == Role.User;
                  final orgName = showOrg && u.id != null
                      ? orgMap[u.id!]
                      : null;
                  if (orgName == null) {
                    return Text('—',
                        style: AppTextStyles.bodyXs.copyWith(
                            color: AppColors.onSurfaceSubtle));
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width:  22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: const Icon(
                          Icons.corporate_fare_rounded,
                          size:  12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          orgName,
                          style:    AppTextStyles.labelMd,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),

              // ── Role ───────────────────────────────────────────────────────
              AppTableColumn(
                label:       'Role',
                flex:        2,
                cellBuilder: (u) => _RoleChip(role: u.role),
              ),

              // ── Actions ────────────────────────────────────────────────────
              AppTableColumn(
                label:     'Actions',
                flex:       2,
                alignment: Alignment.center,
                cellBuilder: (u) {
                  final isProtected = u.role == Role.SuperAdmin ||
                      u.role == Role.Admin;
                  if (isProtected) return const SizedBox.shrink();
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon:      const Icon(Icons.edit_rounded, size: 17),
                        tooltip:   'Edit',
                        onPressed: () => onEdit(u),
                      ),
                      IconButton(
                        icon:  Icon(Icons.delete_rounded,
                            size: 17, color: AppColors.error),
                        tooltip:   'Delete',
                        onPressed: () => onDelete(u),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── User avatar ───────────────────────────────────────────────────────────────

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.name, required this.role});
  final String name;
  final Role   role;

  Color get _color => switch (role) {
    Role.SuperAdmin || Role.Admin => AppColors.aiExpert,
    Role.Manager                  => AppColors.info,
    Role.User                     => AppColors.success,
  };

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width:  34,
      height: 34,
      decoration: BoxDecoration(
        color:        _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize:   13,
            fontWeight: FontWeight.w700,
            color:      _color,
          ),
        ),
      ),
    );
  }
}

// ── Role chip ─────────────────────────────────────────────────────────────────

class _RoleChip extends StatelessWidget {
  const _RoleChip({required this.role});
  final Role role;

  @override
  Widget build(BuildContext context) {
    return AppStatusChip(
      label: switch (role) {
        Role.SuperAdmin => 'Super Admin',
        Role.Admin      => 'Admin',
        Role.Manager    => 'Manager',
        Role.User       => 'User',
      },
      variant: switch (role) {
        Role.SuperAdmin || Role.Admin => AppChipVariant.primary,
        Role.Manager                  => AppChipVariant.info,
        Role.User                     => AppChipVariant.success,
      },
    );
  }
}

// ── Assign Manager card ───────────────────────────────────────────────────────

class _AssignManagerCard extends ConsumerStatefulWidget {
  const _AssignManagerCard({required this.users, required this.orgs});
  final List<AppUser>      users;
  final List<Organization> orgs;

  @override
  ConsumerState<_AssignManagerCard> createState() =>
      _AssignManagerCardState();
}

class _AssignManagerCardState extends ConsumerState<_AssignManagerCard> {
  int? _selectedManagerId;
  int? _selectedOrgId;
  bool _loading = false;

  Future<void> _assign() async {
    if (_selectedManagerId == null || _selectedOrgId == null) return;
    setState(() => _loading = true);
    try {
      await ref
          .read(clientProvider)
          .admin
          .assignManagerToOrg(_selectedManagerId!, _selectedOrgId!);
      ref.invalidate(allOrganizationsProvider);
      if (mounted) {
        setState(() {
          _selectedManagerId = null;
          _selectedOrgId     = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Manager assigned successfully.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:         Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final managers = widget.users
        .where((u) => u.role == Role.Manager || u.role == Role.Admin)
        .toList();
    final canAssign =
        _selectedManagerId != null && _selectedOrgId != null;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card header ─────────────────────────────────────────────────
          Row(
            children: [
              Container(
                width:  36,
                height: 36,
                decoration: BoxDecoration(
                  color:        AppColors.info.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(
                  Icons.link_rounded,
                  size:  18,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Assign Manager',
                      style: AppTextStyles.headingSm),
                  Text(
                    'Link a manager to an organization',
                    style: AppTextStyles.bodyXs,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),

          // ── Controls row ────────────────────────────────────────────────
          LayoutBuilder(builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 600;
            final dropdowns = [
              Expanded(
                child: _StyledDropdown<int>(
                  label:       'Manager',
                  hint:        'Select a manager',
                  value:       _selectedManagerId,
                  icon:        Icons.manage_accounts_rounded,
                  items: managers
                      .map((u) => DropdownMenuItem(
                            value: u.id,
                            child: Text(
                                u.userInfo?.userName ?? '—'),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _selectedManagerId = v),
                ),
              ),
              SizedBox(
                  width: isNarrow ? 0 : AppSpacing.md,
                  height: isNarrow ? AppSpacing.sm : 0),
              Expanded(
                child: _StyledDropdown<int>(
                  label:       'Organization',
                  hint:        'Select an organization',
                  value:       _selectedOrgId,
                  icon:        Icons.corporate_fare_rounded,
                  items: widget.orgs
                      .map((o) => DropdownMenuItem(
                            value: o.id,
                            child: Text(o.name),
                          ))
                      .toList(),
                  onChanged: (v) =>
                      setState(() => _selectedOrgId = v),
                ),
              ),
            ];

            return isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ...dropdowns,
                      const SizedBox(height: AppSpacing.md),
                      AppGradientButton(
                        label:     'Assign',
                        icon:      Icons.check_rounded,
                        isLoading: _loading,
                        onPressed: canAssign ? _assign : null,
                        width:     double.infinity,
                      ),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...dropdowns,
                      const SizedBox(width: AppSpacing.md),
                      AppGradientButton(
                        label:     'Assign',
                        icon:      Icons.check_rounded,
                        isLoading: _loading,
                        onPressed: canAssign ? _assign : null,
                      ),
                    ],
                  );
          }),
        ],
      ),
    );
  }
}

// ── Styled dropdown helper ────────────────────────────────────────────────────

class _StyledDropdown<T> extends StatelessWidget {
  const _StyledDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.icon,
    required this.items,
    required this.onChanged,
  });

  final String                          label;
  final String                          hint;
  final T?                              value;
  final IconData                        icon;
  final List<DropdownMenuItem<T>>       items;
  final ValueChanged<T?>                onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: AppColors.onSurfaceMuted),
            const SizedBox(width: 5),
            Text(label, style: AppTextStyles.labelMd),
          ],
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value:       value,
          hint:        Text(hint),
          isExpanded:  true,
          decoration:  const InputDecoration(),
          items:       items,
          onChanged:   onChanged,
        ),
      ],
    );
  }
}

// ── Edit User form body ───────────────────────────────────────────────────────

class _EditUserBody extends StatefulWidget {
  const _EditUserBody({
    required this.nameCtrl,
    required this.roleNotifier,
    required this.currentRole,
  });

  final TextEditingController nameCtrl;
  final ValueNotifier<Role>   roleNotifier;
  final Role                  currentRole;

  @override
  State<_EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<_EditUserBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Account Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Full Name',
          controller: widget.nameCtrl,
          hint:       'John Smith',
        ),
        const SizedBox(height: AppSpacing.lg),

        const SheetSection(title: 'Role'),
        const SizedBox(height: AppSpacing.sm),

        Text('Role', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        ValueListenableBuilder<Role>(
          valueListenable: widget.roleNotifier,
          builder: (_, role, __) => DropdownButtonFormField<Role>(
            value:      role,
            decoration: const InputDecoration(hintText: 'Select role'),
            items: [Role.Manager, Role.User]
                .map((r) => DropdownMenuItem(
                      value: r,
                      child: Text(r.name),
                    ))
                .toList(),
            onChanged: (v) => widget.roleNotifier.value = v!,
          ),
        ),
      ],
    );
  }
}

// ── Add User form body ────────────────────────────────────────────────────────

class _AddUserBody extends StatefulWidget {
  const _AddUserBody({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.roleNotifier,
    required this.orgNotifier,
    required this.orgs,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final ValueNotifier<Role>   roleNotifier;
  final ValueNotifier<int?>   orgNotifier;
  final List<Organization>    orgs;

  @override
  State<_AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<_AddUserBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Account Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Full Name',
          controller: widget.nameCtrl,
          hint:       'John Smith',
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:        'Email',
          controller:   widget.emailCtrl,
          hint:         'john@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:      'Password',
          controller: widget.passCtrl,
          hint:       '••••••••',
        ),
        const SizedBox(height: AppSpacing.lg),

        const SheetSection(title: 'Role & Organization'),
        const SizedBox(height: AppSpacing.sm),

        Text('Role', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        ValueListenableBuilder<Role>(
          valueListenable: widget.roleNotifier,
          builder: (_, role, __) => DropdownButtonFormField<Role>(
            value:      role,
            decoration: const InputDecoration(hintText: 'Select role'),
            items: [Role.Manager, Role.User]
                .map((r) => DropdownMenuItem(
                      value: r,
                      child: Text(r.name),
                    ))
                .toList(),
            onChanged: (v) => widget.roleNotifier.value = v!,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        Text('Organization', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        ValueListenableBuilder<int?>(
          valueListenable: widget.orgNotifier,
          builder: (_, orgId, __) => DropdownButtonFormField<int>(
            value:      orgId,
            decoration:
                const InputDecoration(hintText: 'Select organization'),
            items: widget.orgs
                .map((o) => DropdownMenuItem(
                      value: o.id,
                      child: Text(o.name),
                    ))
                .toList(),
            onChanged: (v) => widget.orgNotifier.value = v,
          ),
        ),
      ],
    );
  }
}
