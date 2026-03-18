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
          _UsersTable(usersAsync: usersAsync),
        ],
      ),
    );
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
  const _UsersTable({required this.usersAsync});
  final AsyncValue<List<AppUser>> usersAsync;

  @override
  Widget build(BuildContext context) {
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
              AppTableColumn(
                label:       'User',
                flex:        3,
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
              AppTableColumn(
                label:       'Role',
                flex:        1,
                cellBuilder: (u) => _RoleChip(role: u.role),
              ),
              AppTableColumn(
                label:       'ID',
                flex:        1,
                alignment:   Alignment.center,
                cellBuilder: (u) => Text(
                  '#${u.id}',
                  style: AppTextStyles.labelMd,
                ),
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
