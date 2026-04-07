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
    final usersAsync      = ref.watch(allUsersProvider);
    final orgsAsync       = ref.watch(allOrganizationsProvider);
    final parentOrgsAsync = ref.watch(parentOrgsProvider);
    final allTeamsAsync   = ref.watch(allTeamsProvider);
    final users           = usersAsync.value ?? [];
    final managers   = users.where((u) => u.role == Role.Manager).length;
    final regulars   = users.where((u) => u.role == Role.User).length;

    return ScreenWithFab(
      icon: Icons.person_add_rounded,
      label: 'Add',
      onPressed: () => _showAddUserSheet(
        context, ref, parentOrgsAsync.value ?? [], allTeamsAsync.value ?? []),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.responsivePagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────────────
            ResponsivePageHeader(
                title:    'Users',
                subtitle: 'Manage platform users and their roles.',
                action: AppGradientButton(
                  label:     'Add User',
                  icon:      Icons.person_add_rounded,
                  onPressed: () => _showAddUserSheet(
                  context,
                  ref,
                  parentOrgsAsync.value ?? [],
                  allTeamsAsync.value ?? [],
                ),
              ),
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

          // ── Users table ───────────────────────────────────────────────────
          _UsersTable(
            usersAsync: usersAsync,
            orgs:       orgsAsync.value ?? [],
            onEdit:     (u) => _showEditUserSheet(context, ref, u),
            onDelete:   (u) => _confirmDeleteUser(context, ref, u),
          ),
        ],
      ),
      ),
    );
  }

  void _showEditUserSheet(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
  ) {
    final nameCtrl     = TextEditingController(text: user.userInfo?.userName ?? '');
    final passCtrl     = TextEditingController();
    final roleNotifier = ValueNotifier<Role>(user.role);

    AppSideSheet.show(
      context:   context,
      title:     'Edit User',
      saveLabel: 'Save Changes',
      body: _EditUserBody(
        nameCtrl:     nameCtrl,
        passCtrl:     passCtrl,
        roleNotifier: roleNotifier,
        currentRole:  user.role,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Name is required.');
        }
        if (user.role == Role.OrganizationAdmin) {
          await ref.read(clientProvider).admin.updateOrgAdminUser(
                user.id!,
                nameCtrl.text.trim(),
                roleNotifier.value,
              );
        } else {
          await ref.read(clientProvider).admin.updateUser(
                user.id!,
                nameCtrl.text.trim(),
                roleNotifier.value,
              );
        }
        final newPass = passCtrl.text.trim();
        if (newPass.isNotEmpty) {
          await ref.read(clientProvider).admin.adminResetUserPassword(
                user.id!,
                newPass,
              );
        }
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
    List<Organization> parentOrgs,
    List<Organization> allTeams,
  ) {
    final nameCtrl     = TextEditingController();
    final emailCtrl    = TextEditingController();
    final passCtrl     = TextEditingController();
    final roleNotifier = ValueNotifier<Role>(Role.Manager);
    final orgNotifier  = ValueNotifier<int?>(null);
    final teamNotifier = ValueNotifier<int?>(null);

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
        teamNotifier: teamNotifier,
        parentOrgs:   parentOrgs,
        allTeams:     allTeams,
      ),
      onSave: () async {
        final name  = nameCtrl.text.trim();
        final email = emailCtrl.text.trim();
        final pass  = passCtrl.text.trim();
        final role  = roleNotifier.value;
        final orgId = orgNotifier.value;
        final teamId = teamNotifier.value;

        if (name.isEmpty || email.isEmpty || pass.isEmpty) {
          throw Exception('Name, email and password are required.');
        }
        if (orgId == null) {
          throw Exception('Please select an organization.');
        }
        if (role != Role.OrganizationAdmin && teamId == null) {
          throw Exception('Please select a team.');
        }

        if (role == Role.OrganizationAdmin) {
          await ref.read(clientProvider).admin.createUserAndAssignToOrg(
                name, email, pass, role, orgId);
        } else {
          await ref.read(clientProvider).organizationAdmin.createUserInTeam(
                name, email, pass, role, teamId!);
        }
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

  /// Builds a map of appUserId → display label.
  /// Users in a team show "OrgName / TeamName"; users in a parent org show "OrgName".
  Map<int, String> _buildOrgMap() {
    final orgById = <int, Organization>{
      for (final o in orgs) if (o.id != null) o.id!: o,
    };
    final map = <int, String>{};
    for (final org in orgs) {
      for (final link in org.users ?? []) {
        final userId = link.appUserId;
        if (org.parentId != null) {
          final parentName = orgById[org.parentId!]?.name;
          map[userId] = parentName != null
              ? '$parentName / ${org.name}'
              : org.name;
        } else {
          map[userId] = org.name;
        }
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
            mobileCardBuilder: (u) => _UserMobileCard(
              user:    u,
              orgName: u.id != null ? orgMap[u.id!] : null,
              onEdit:  () => onEdit(u),
              onDelete: () => onDelete(u),
            ),
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
                  final showOrg = u.role == Role.OrganizationAdmin ||
                      u.role == Role.Manager ||
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
                  if (u.role == Role.SuperAdmin) return const SizedBox.shrink();
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
    Role.SuperAdmin         => AppColors.aiExpert,
    Role.OrganizationAdmin  => AppColors.primary,
    Role.Manager            => AppColors.info,
    Role.User               => AppColors.success,
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
        Role.OrganizationAdmin => 'Org Admin',
        Role.Manager    => 'Manager',
        Role.User       => 'User',
      },
      variant: switch (role) {
        Role.SuperAdmin         => AppChipVariant.primary,
        Role.OrganizationAdmin  => AppChipVariant.primary,
        Role.Manager            => AppChipVariant.info,
        Role.User               => AppChipVariant.success,
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
        .where((u) => u.role == Role.Manager || u.role == Role.OrganizationAdmin)
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
    required this.passCtrl,
    required this.roleNotifier,
    required this.currentRole,
  });

  final TextEditingController nameCtrl;
  final TextEditingController passCtrl;
  final ValueNotifier<Role>   roleNotifier;
  final Role                  currentRole;

  @override
  State<_EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<_EditUserBody> {
  bool _showPasswordField = false;

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
          builder: (_, role, __) {
            final roles = widget.currentRole == Role.OrganizationAdmin
                ? [Role.OrganizationAdmin, Role.Manager, Role.User]
                : [Role.Manager, Role.User];
            return DropdownButtonFormField<Role>(
              value:      role,
              decoration: const InputDecoration(hintText: 'Select role'),
              items: roles
                  .map((r) => DropdownMenuItem(
                        value: r,
                        child: Text(switch (r) {
                          Role.OrganizationAdmin => 'Organization Admin',
                          Role.Manager           => 'Manager',
                          Role.User              => 'User',
                          _                      => r.name,
                        }),
                      ))
                  .toList(),
              onChanged: (v) => widget.roleNotifier.value = v!,
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Change Password ───────────────────────────────────────────────
        const SheetSection(title: 'Security'),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          onTap: () => setState(() {
            _showPasswordField = !_showPasswordField;
            if (!_showPasswordField) widget.passCtrl.clear();
          }),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(
                  _showPasswordField
                      ? Icons.lock_open_rounded
                      : Icons.lock_reset_rounded,
                  size:  16,
                  color: AppColors.info,
                ),
                const SizedBox(width: 8),
                Text(
                  'Change Password',
                  style: AppTextStyles.labelMd
                      .copyWith(color: AppColors.info),
                ),
                const Spacer(),
                Icon(
                  _showPasswordField
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size:  16,
                  color: AppColors.onSurfaceSubtle,
                ),
              ],
            ),
          ),
        ),
        if (_showPasswordField) ...[
          const SizedBox(height: AppSpacing.sm),
          SheetField(
            label:      'New Password',
            controller: widget.passCtrl,
            hint:       '••••••••',
            obscureText: true,
          ),
        ],
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
    required this.teamNotifier,
    required this.parentOrgs,
    required this.allTeams,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final ValueNotifier<Role>   roleNotifier;
  final ValueNotifier<int?>   orgNotifier;
  final ValueNotifier<int?>   teamNotifier;
  final List<Organization>    parentOrgs;
  final List<Organization>    allTeams;

  @override
  State<_AddUserBody> createState() => _AddUserBodyState();
}

class _AddUserBodyState extends State<_AddUserBody> {
  Role   _role = Role.Manager;
  int?   _orgId;

  @override
  void initState() {
    super.initState();
    _role = widget.roleNotifier.value;
    _orgId = widget.orgNotifier.value;
  }

  List<Organization> get _teamsForOrg => _orgId == null
      ? []
      : widget.allTeams.where((t) => t.parentId == _orgId).toList();

  void _onRoleChanged(Role r) {
    setState(() => _role = r);
    widget.roleNotifier.value = r;
    widget.teamNotifier.value = null;
  }

  void _onOrgChanged(int? orgId) {
    setState(() => _orgId = orgId);
    widget.orgNotifier.value = orgId;
    widget.teamNotifier.value = null;
  }

  @override
  Widget build(BuildContext context) {
    final needsTeam = _role == Role.Manager || _role == Role.User;
    final teams     = _teamsForOrg;

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

        const SheetSection(title: 'Role & Assignment'),
        const SizedBox(height: AppSpacing.sm),

        Text('Role', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        DropdownButtonFormField<Role>(
          value:      _role,
          decoration: const InputDecoration(hintText: 'Select role'),
          items: [Role.OrganizationAdmin, Role.Manager, Role.User]
              .map((r) => DropdownMenuItem(
                    value: r,
                    child: Text(switch (r) {
                      Role.OrganizationAdmin => 'Organization Admin',
                      Role.Manager           => 'Manager',
                      Role.User              => 'User',
                      _                      => r.name,
                    }),
                  ))
              .toList(),
          onChanged: (v) => _onRoleChanged(v!),
        ),
        const SizedBox(height: AppSpacing.md),

        Text('Organization', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
          value:      _orgId,
          decoration: const InputDecoration(hintText: 'Select organization'),
          items: widget.parentOrgs
              .map((o) => DropdownMenuItem(value: o.id, child: Text(o.name)))
              .toList(),
          onChanged: _onOrgChanged,
        ),

        if (needsTeam) ...[
          const SizedBox(height: AppSpacing.md),
          Text('Team', style: AppTextStyles.labelMd),
          const SizedBox(height: 6),
          if (_orgId == null)
            Text(
              'Select an organization first.',
              style: AppTextStyles.bodySm
                  .copyWith(color: AppColors.onSurfaceSubtle),
            )
          else if (teams.isEmpty)
            Text(
              'No teams found for this organization.',
              style: AppTextStyles.bodySm
                  .copyWith(color: AppColors.onSurfaceSubtle),
            )
          else
            ValueListenableBuilder<int?>(
              valueListenable: widget.teamNotifier,
              builder: (_, teamId, __) => DropdownButtonFormField<int>(
                value:      teamId,
                decoration: const InputDecoration(hintText: 'Select team'),
                items: teams
                    .map((t) =>
                        DropdownMenuItem(value: t.id, child: Text(t.name)))
                    .toList(),
                onChanged: (v) => widget.teamNotifier.value = v,
              ),
            ),
        ],
      ],
    );
  }
}

// ── Mobile card for users ────────────────────────────────────────────────────

class _UserMobileCard extends StatelessWidget {
  const _UserMobileCard({
    required this.user,
    required this.onEdit,
    required this.onDelete,
    this.orgName,
  });

  final AppUser     user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String?     orgName;

  @override
  Widget build(BuildContext context) {
    final isSuperAdmin = user.role == Role.SuperAdmin;

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _UserAvatar(
                  name: user.userInfo?.userName ?? '?', role: user.role),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.userInfo?.userName ?? '—',
                      style: AppTextStyles.labelLg,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user.userInfo?.email ?? '',
                      style: AppTextStyles.bodyXs,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              _RoleChip(role: user.role),
            ],
          ),
          if (orgName != null || !isSuperAdmin) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                if (orgName != null) ...[
                  Icon(Icons.corporate_fare_rounded,
                      size: 12, color: AppColors.onSurfaceMuted),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(orgName!,
                        style: AppTextStyles.bodyXs,
                        overflow: TextOverflow.ellipsis),
                  ),
                ] else
                  const Spacer(),
                if (!isSuperAdmin) ...[
                  IconButton(
                    icon: const Icon(Icons.edit_rounded, size: 16),
                    tooltip: 'Edit',
                    onPressed: onEdit,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_rounded,
                        size: 16, color: AppColors.error),
                    tooltip: 'Delete',
                    onPressed: onDelete,
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
