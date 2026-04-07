import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/org_admin_providers.dart';
import '../../../src/providers.dart';

class OrgUsersScreen extends ConsumerWidget {
  const OrgUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync   = ref.watch(orgUsersProvider);
    final teamsAsync   = ref.watch(orgTeamsProvider);
    final currentUserId = ref.watch(authProvider).appUser?.id;

    final users    = usersAsync.value ?? [];
    final managers = users.where((u) => u.role == Role.Manager).length;
    final regular  = users.where((u) => u.role == Role.User).length;

    return ScreenWithFab(
      icon: Icons.person_add_rounded,
      label: 'Add',
      onPressed: teamsAsync.value == null
          ? null
          : () => _showAddUserSheet(context, ref, teamsAsync.value!),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.responsivePagePadding),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          ResponsivePageHeader(
              title:    'Users',
              subtitle: 'Manage users across your organization and teams.',
              action: AppGradientButton(
                label:     'Add User',
                icon:      Icons.person_add_rounded,
                onPressed: teamsAsync.value == null
                    ? null
                    : () => _showAddUserSheet(context, ref, teamsAsync.value!),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),

          // ── Stats row ──────────────────────────────────────────────────
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
                value:       '$regular',
                label:       'Regular Users',
                isLoading:   usersAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Users table ────────────────────────────────────────────────
          _UsersTable(
            usersAsync:     usersAsync,
            teamsAsync:     teamsAsync,
            currentUserId:  currentUserId,
            onEdit:         (u) => _showEditUserSheet(context, ref, u),
            onDelete:       (u) => _confirmDeleteUser(context, ref, u),
          ),
        ],
      ),
      ),
    );
  }

  // ── Edit user sheet ───────────────────────────────────────────────────────

  void _showEditUserSheet(BuildContext context, WidgetRef ref, AppUser user) {
    final nameCtrl     = TextEditingController(
        text: user.userInfo?.userName ?? '');
    final passCtrl     = TextEditingController();
    final roleNotifier = ValueNotifier<Role>(user.role);

    AppSideSheet.show(
      context:   context,
      title:     'Edit User',
      saveLabel: 'Save',
      body: _EditUserBody(
        nameCtrl:     nameCtrl,
        passCtrl:     passCtrl,
        roleNotifier: roleNotifier,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Name is required.');
        }
        await ref.read(clientProvider).organizationAdmin.updateOrgUser(
          user.id!,
          nameCtrl.text.trim(),
          roleNotifier.value,
        );
        final newPass = passCtrl.text.trim();
        if (newPass.isNotEmpty) {
          await ref.read(clientProvider).organizationAdmin
              .resetOrgUserPassword(user.id!, newPass);
        }
        ref.invalidate(orgUsersProvider);
        ref.invalidate(orgTeamsProvider);
      },
    );
  }

  // ── Delete user confirmation ───────────────────────────────────────────────

  Future<void> _confirmDeleteUser(
      BuildContext context, WidgetRef ref, AppUser user) async {
    final name = user.userInfo?.userName ?? user.userInfo?.email ?? 'this user';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title:   const Text('Delete User'),
        content: Text(
          'Delete "$name"?\n\nThis will permanently remove the account and all associated data.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child:     const Text('Cancel'),
          ),
          FilledButton(
            style:     FilledButton.styleFrom(
                backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child:     const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(clientProvider).organizationAdmin
          .deleteOrgUser(user.id!);
      ref.invalidate(orgUsersProvider);
      ref.invalidate(orgTeamsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"$name" deleted.')),
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
    List<Organization> teams,
  ) {
    if (teams.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Create a team first before adding users.'),
        ),
      );
      return;
    }

    final nameCtrl     = TextEditingController();
    final emailCtrl    = TextEditingController();
    final passCtrl     = TextEditingController();
    final roleNotifier = ValueNotifier<Role>(Role.User);
    final teamNotifier = ValueNotifier<int?>(teams.first.id);

    AppSideSheet.show(
      context:   context,
      title:     'Add User',
      saveLabel: 'Create User',
      body: _AddUserBody(
        nameCtrl:     nameCtrl,
        emailCtrl:    emailCtrl,
        passCtrl:     passCtrl,
        roleNotifier: roleNotifier,
        teamNotifier: teamNotifier,
        teams:        teams,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty ||
            emailCtrl.text.trim().isEmpty ||
            passCtrl.text.trim().isEmpty ||
            teamNotifier.value == null) {
          throw Exception('All fields are required.');
        }
        await ref.read(clientProvider).organizationAdmin.createUserInTeam(
          nameCtrl.text.trim(),
          emailCtrl.text.trim(),
          passCtrl.text.trim(),
          roleNotifier.value,
          teamNotifier.value!,
        );
        ref.invalidate(orgUsersProvider);
        ref.invalidate(orgTeamsProvider);
      },
    );
  }
}

// ── Users table ───────────────────────────────────────────────────────────────

class _UsersTable extends StatelessWidget {
  const _UsersTable({
    required this.usersAsync,
    required this.teamsAsync,
    this.currentUserId,
    this.onEdit,
    this.onDelete,
  });

  final AsyncValue<List<AppUser>>      usersAsync;
  final AsyncValue<List<Organization>> teamsAsync;
  final int?                           currentUserId;
  final void Function(AppUser)?        onEdit;
  final void Function(AppUser)?        onDelete;

  /// Build a map of appUserId → team name from loaded teams.
  Map<int, String> _buildTeamMap() {
    final map = <int, String>{};
    for (final team in teamsAsync.value ?? []) {
      for (final link in team.users ?? []) {
        final userId = link.appUserId;
        map[userId] = team.name;
      }
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final teamMap = _buildTeamMap();

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
            mobileCardBuilder: (u) {
              final teamName = u.id != null ? teamMap[u.id!] : null;
              final isSelf = u.id != null && u.id == currentUserId;
              return MobileDataCard(
                child: Row(
                  children: [
                    _UserAvatar(name: u.userInfo?.userName ?? '?', role: u.role),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(u.userInfo?.userName ?? '—',
                              style: AppTextStyles.labelLg,
                              overflow: TextOverflow.ellipsis),
                          Text(u.userInfo?.email ?? '',
                              style: AppTextStyles.bodyXs,
                              overflow: TextOverflow.ellipsis),
                          if (teamName != null)
                            Text(teamName,
                                style: AppTextStyles.bodyXs.copyWith(
                                    color: AppColors.onSurfaceMuted),
                                overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    AppStatusChip(
                      label: u.role == Role.Manager ? 'Manager' : 'User',
                      variant: u.role == Role.Manager
                          ? AppChipVariant.info : AppChipVariant.success,
                      small: true,
                    ),
                    if (!isSelf)
                      MobileCardActions(
                        onEdit:  onEdit != null ? () => onEdit!(u) : null,
                        onDelete: onDelete != null ? () => onDelete!(u) : null,
                      ),
                  ],
                ),
              );
            },
            columns: [
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
                    _UserAvatar(name: u.userInfo?.userName ?? '?', role: u.role),
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
              AppTableColumn(
                label:       'Team',
                flex:        3,
                searchValue: (u) => u.id != null ? (teamMap[u.id!] ?? '') : '',
                cellBuilder: (u) {
                  final teamName = u.id != null ? teamMap[u.id!] : null;
                  if (teamName == null) {
                    return Text(
                      '—',
                      style: AppTextStyles.bodyXs
                          .copyWith(color: AppColors.onSurfaceSubtle),
                    );
                  }
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width:  22,
                        height: 22,
                        decoration: BoxDecoration(
                          color:        AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: const Icon(
                          Icons.groups_rounded,
                          size:  12,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          teamName,
                          style:    AppTextStyles.labelMd,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
              AppTableColumn(
                label:       'Role',
                flex:        2,
                cellBuilder: (u) => AppStatusChip(
                  label: switch (u.role) {
                    Role.Manager => 'Manager',
                    Role.User    => 'User',
                    _            => u.role.name,
                  },
                  variant: u.role == Role.Manager
                      ? AppChipVariant.info
                      : AppChipVariant.success,
                ),
              ),
              AppTableColumn(
                label:      'Actions',
                flex:       1,
                alignment:  Alignment.center,
                cellBuilder: (u) {
                  if (u.id != null && u.id == currentUserId) {
                    return const SizedBox.shrink();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon:    const Icon(Icons.edit_outlined, size: 16),
                        tooltip: 'Edit',
                        color:   AppColors.onSurfaceMuted,
                        onPressed: onEdit != null ? () => onEdit!(u) : null,
                      ),
                      IconButton(
                        icon:    const Icon(Icons.delete_outline_rounded,
                            size: 16),
                        tooltip: 'Delete',
                        color:   AppColors.error,
                        onPressed:
                            onDelete != null ? () => onDelete!(u) : null,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          if (usersAsync.hasError)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Error: ${usersAsync.error}',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.error),
              ),
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

  Color get _color => role == Role.Manager ? AppColors.info : AppColors.success;

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
              Text(label,  style: AppTextStyles.bodyXs),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Edit User form body ───────────────────────────────────────────────────────

class _EditUserBody extends StatefulWidget {
  const _EditUserBody({
    required this.nameCtrl,
    required this.passCtrl,
    required this.roleNotifier,
  });

  final TextEditingController nameCtrl;
  final TextEditingController passCtrl;
  final ValueNotifier<Role>   roleNotifier;

  @override
  State<_EditUserBody> createState() => _EditUserBodyState();
}

class _EditUserBodyState extends State<_EditUserBody> {
  bool _showPassword = false;

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
                      child: Text(r == Role.Manager ? 'Manager' : 'User'),
                    ))
                .toList(),
            onChanged: (v) =>
                setState(() => widget.roleNotifier.value = v!),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // ── Change password (collapsible) ─────────────────────────────
        InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: () => setState(() => _showPassword = !_showPassword),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SheetSection(title: 'Security'),
                const Spacer(),
                Icon(
                  _showPassword
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size:  18,
                  color: AppColors.onSurfaceSubtle,
                ),
              ],
            ),
          ),
        ),
        if (_showPassword) ...[
          const SizedBox(height: AppSpacing.sm),
          SheetField(
            label:       'New Password',
            controller:  widget.passCtrl,
            hint:        '••••••••',
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Leave blank to keep the current password.',
            style: AppTextStyles.bodyXs
                .copyWith(color: AppColors.onSurfaceSubtle),
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
    required this.teamNotifier,
    required this.teams,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final ValueNotifier<Role>   roleNotifier;
  final ValueNotifier<int?>   teamNotifier;
  final List<Organization>    teams;

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

        const SheetSection(title: 'Role & Team'),
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
                      child: Text(r == Role.Manager ? 'Manager' : 'User'),
                    ))
                .toList(),
            onChanged: (v) => setState(() => widget.roleNotifier.value = v!),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        Text('Team', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        ValueListenableBuilder<int?>(
          valueListenable: widget.teamNotifier,
          builder: (_, teamId, __) => DropdownButtonFormField<int>(
            value:      teamId,
            decoration: const InputDecoration(hintText: 'Select team'),
            items: widget.teams
                .map((t) => DropdownMenuItem(
                      value: t.id,
                      child: Text(t.name),
                    ))
                .toList(),
            onChanged: (v) => setState(() => widget.teamNotifier.value = v),
          ),
        ),
      ],
    );
  }
}
