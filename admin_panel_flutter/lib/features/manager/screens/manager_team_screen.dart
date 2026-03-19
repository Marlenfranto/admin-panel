import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';
import '../../../src/providers.dart';

class ManagerTeamScreen extends ConsumerWidget {
  const ManagerTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync = ref.watch(managedOrganizationsProvider);
    final activeOrg = ref.watch(activeOrgProvider);
    final activeOrgId = ref.watch(activeOrgIdProvider);

    final users = activeOrg?.users
            ?.map((l) => l.appUser)
            .whereType<AppUser>()
            .toList() ??
        [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Team', style: AppTextStyles.headingLg),
                    const SizedBox(height: 4),
                    Text(
                      activeOrg != null
                          ? 'Manage members of ${activeOrg.name}.'
                          : 'Manage your team members.',
                      style: AppTextStyles.bodySm,
                    ),
                  ],
                ),
              ),
              AppGradientButton(
                label:     'Add Member',
                icon:      Icons.person_add_rounded,
                onPressed: activeOrg == null
                    ? null
                    : () => _showAddSheet(context, ref, activeOrg),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Org selector strip (multi-org managers) ────────────────────
          orgsAsync.when(
            data: (orgs) {
              if (orgs.length <= 1) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Organizations', style: AppTextStyles.labelMd),
                  const SizedBox(height: AppSpacing.sm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: orgs.map((org) {
                        final isActive = org.id == activeOrgId;
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpacing.sm),
                          child: _OrgChip(
                            org: org,
                            isActive: isActive,
                            onTap: () => ref
                                .read(selectedOrgIdProvider.notifier)
                                .state = org.id,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error:   (_, __) => const SizedBox.shrink(),
          ),

          // ── Stat card ──────────────────────────────────────────────────
          _StatCard(
            icon:        Icons.group_rounded,
            accentColor: AppColors.primary,
            value:       '${users.length}',
            label:       'Team Members',
            isLoading:   orgsAsync.isLoading,
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Members table ──────────────────────────────────────────────
          _MembersTable(
            users:      users,
            isLoading:  orgsAsync.isLoading,
            org:        activeOrg,
            orgId:      activeOrgId,
            onRemove:   (u) => _removeUser(context, ref, u, activeOrg!),
          ),
          if (activeOrgId != null) ...[
            const SizedBox(height: AppSpacing.lg),

            // ── All users training history ────────────────────────────────
            AllUsersTrainingHistoryPanel(
              users: users,
              historyLoader: (userId) => ref
                  .read(clientProvider)
                  .manager
                  .getUserTrainingHistory(userId, activeOrgId),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref, Organization org) {
    final nameCtrl  = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();

    AppSideSheet.show(
      context:   context,
      title:     'Add Team Member',
      saveLabel: 'Add Member',
      body: _AddMemberBody(
        nameCtrl:  nameCtrl,
        emailCtrl: emailCtrl,
        passCtrl:  passCtrl,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty ||
            emailCtrl.text.trim().isEmpty ||
            passCtrl.text.trim().isEmpty) {
          throw Exception('All fields are required.');
        }
        await ref.read(clientProvider).manager.createUserAndAssignToOrg(
              nameCtrl.text.trim(),
              emailCtrl.text.trim(),
              passCtrl.text.trim(),
              Role.User,
              org.id!,
            );
        ref.invalidate(managedOrganizationsProvider);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:         Text('Member added successfully.'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      },
    );
  }

  Future<void> _removeUser(
    BuildContext context,
    WidgetRef ref,
    AppUser user,
    Organization org,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        title: Text('Remove Member', style: AppTextStyles.headingSm),
        content: Text(
          'Remove ${user.userInfo?.userName ?? 'this user'} from ${org.name}?\n\nTheir account will remain intact.',
          style: AppTextStyles.bodySm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await ref
          .read(clientProvider)
          .manager
          .removeUserFromOrganization(user.id!, org.id!);
      ref.invalidate(managedOrganizationsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:         Text('Member removed.'),
            backgroundColor: AppColors.success,
          ),
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
}

// ── Members table ──────────────────────────────────────────────────────────────

class _MembersTable extends StatelessWidget {
  const _MembersTable({
    required this.users,
    required this.isLoading,
    required this.org,
    required this.orgId,
    required this.onRemove,
  });

  final List<AppUser>   users;
  final bool            isLoading;
  final Organization?   org;
  final int?            orgId;
  final void Function(AppUser) onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Row(
              children: [
                Text('Members', style: AppTextStyles.headingSm),
                const Spacer(),
                if (!isLoading)
                  Text(
                    '${users.length} total',
                    style: AppTextStyles.bodyXs,
                  ),
              ],
            ),
          ),
          AppDataTable<AppUser>(
            isLoading:  isLoading,
            rows:       users,
            searchable: true,
            columns: [
              AppTableColumn(
                label:       'Name',
                flex:        3,
                sortKey:     'name',
                comparator:  (a, b) =>
                    (a.userInfo?.userName ?? '').compareTo(b.userInfo?.userName ?? ''),
                searchValue: (u) =>
                    '${u.userInfo?.userName ?? ''} ${u.userInfo?.email ?? ''}',
                cellBuilder: (u) => Row(
                  children: [
                    _Avatar(name: u.userInfo?.userName ?? '?'),
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
                sortKey:     'role',
                comparator:  (a, b) => a.role.name.compareTo(b.role.name),
                cellBuilder: (u) => AppStatusChip(
                  label: u.role.name,
                  variant: u.role == Role.Manager
                      ? AppChipVariant.info
                      : AppChipVariant.success,
                ),
              ),
              AppTableColumn(
                label:     'Actions',
                flex:      2,
                alignment: Alignment.center,
                cellBuilder: (u) => _RemoveButton(onTap: () => onRemove(u)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Remove button (hover → red bg) ────────────────────────────────────────────

class _RemoveButton extends StatefulWidget {
  const _RemoveButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_RemoveButton> createState() => _RemoveButtonState();
}

class _RemoveButtonState extends State<_RemoveButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter:  (_) => setState(() => _hovered = true),
      onExit:   (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: 'Remove from org',
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding:  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.error.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: _hovered
                    ? AppColors.error.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_remove_rounded,
                  size:  15,
                  color: _hovered ? AppColors.error : AppColors.onSurfaceSubtle,
                ),
                const SizedBox(width: 5),
                Text(
                  'Remove',
                  style: AppTextStyles.labelMd.copyWith(
                    color: _hovered ? AppColors.error : AppColors.onSurfaceSubtle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Org chip (multi-org selector) ─────────────────────────────────────────────

class _OrgChip extends StatelessWidget {
  const _OrgChip({
    required this.org,
    required this.isActive,
    required this.onTap,
  });

  final Organization org;
  final bool         isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final initial = (org.name.isNotEmpty ? org.name[0] : '?').toUpperCase();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color:        isActive ? null : AppColors.surfaceVariant,
          gradient:     isActive ? AppColors.brandGradient : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.0)
                : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width:  28,
              height: 28,
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withValues(alpha: 0.25)
                    : AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Center(
                child: Text(
                  initial,
                  style: AppTextStyles.labelMd.copyWith(
                    color:      isActive ? Colors.white : AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              org.name,
              style: AppTextStyles.labelMd.copyWith(
                color: isActive ? Colors.white : AppColors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Compact stat card ──────────────────────────────────────────────────────────

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
      return const AppSkeletonBox(width: 200, height: 72, radius: AppSpacing.radiusLg);
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

// ── User avatar ────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width:  34,
      height: 34,
      decoration: BoxDecoration(
        color:        AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize:   13,
            fontWeight: FontWeight.w700,
            color:      AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// ── Add member side-sheet body ─────────────────────────────────────────────────

class _AddMemberBody extends StatelessWidget {
  const _AddMemberBody({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Account Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Full Name',
          controller: nameCtrl,
          hint:       'John Smith',
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:        'Email',
          controller:   emailCtrl,
          hint:         'john@example.com',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:      'Password',
          controller: passCtrl,
          hint:       '••••••••',
        ),
      ],
    );
  }
}
