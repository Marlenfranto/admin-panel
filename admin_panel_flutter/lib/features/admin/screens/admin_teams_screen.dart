import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
import '../../../src/providers.dart';

class AdminTeamsScreen extends ConsumerWidget {
  const AdminTeamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync    = ref.watch(allTeamsProvider);
    final parentOrgsAsync = ref.watch(parentOrgsProvider);

    final teams   = teamsAsync.value ?? [];
    final managed = teams.where((t) => t.manager != null).length;
    final members = teams.fold<int>(0, (s, t) => s + (t.users?.length ?? 0));

    return ScreenWithFab(
      icon: Icons.add_rounded,
      label: 'Create',
      onPressed: parentOrgsAsync.value == null
          ? null
          : () => _showCreateSheet(context, ref, parentOrgsAsync.value!),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.responsivePagePadding),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          ResponsivePageHeader(
              title:    'Teams',
              subtitle: 'Manage teams within your organizations.',
              action: AppGradientButton(
                label:     'Create Team',
                icon:      Icons.add_rounded,
                onPressed: parentOrgsAsync.value == null
                    ? null
                    : () => _showCreateSheet(
                          context, ref, parentOrgsAsync.value!),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),

          // ── Stats ──────────────────────────────────────────────────────
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _StatCard(
                icon:        Icons.groups_rounded,
                accentColor: AppColors.primary,
                value:       '${teams.length}',
                label:       'Total Teams',
                isLoading:   teamsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.manage_accounts_rounded,
                accentColor: AppColors.info,
                value:       '$managed',
                label:       'Teams with Manager',
                isLoading:   teamsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.person_rounded,
                accentColor: AppColors.success,
                value:       '$members',
                label:       'Total Members',
                isLoading:   teamsAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Teams table ────────────────────────────────────────────────
          _TeamsTable(
            teamsAsync:      teamsAsync,
            parentOrgsAsync: parentOrgsAsync,
            onEdit:          (t) => _showEditSheet(context, ref, t),
            onDelete:        (t) => _confirmDelete(context, ref, t),
          ),
        ],
      ),
      ),
    );
  }

  // ── Create team sheet ─────────────────────────────────────────────────────

  void _showCreateSheet(
    BuildContext context,
    WidgetRef ref,
    List<Organization> parentOrgs,
  ) {
    if (parentOrgs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Create an organization first.')),
      );
      return;
    }

    final nameCtrl   = TextEditingController();
    final orgNotifier = ValueNotifier<int?>(parentOrgs.first.id);

    AppSideSheet.show(
      context:   context,
      title:     'Create Team',
      saveLabel: 'Create',
      body: _CreateTeamBody(
        nameCtrl:    nameCtrl,
        orgNotifier: orgNotifier,
        parentOrgs:  parentOrgs,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Team name is required.');
        }
        if (orgNotifier.value == null) {
          throw Exception('Please select an organization.');
        }
        await ref.read(clientProvider).organizationAdmin.createTeam(
          nameCtrl.text.trim(),
          orgNotifier.value!,
          null,
        );
        ref.invalidate(allOrganizationsProvider);
      },
    );
  }

  // ── Edit team sheet ───────────────────────────────────────────────────────

  void _showEditSheet(
    BuildContext context,
    WidgetRef ref,
    Organization team,
  ) {
    final nameCtrl = TextEditingController(text: team.name);

    AppSideSheet.show(
      context:   context,
      title:     'Edit Team',
      saveLabel: 'Save',
      body: _EditTeamBody(nameCtrl: nameCtrl),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Team name is required.');
        }
        final newName = nameCtrl.text.trim();
        if (newName != team.name) {
          await ref.read(clientProvider).organizationAdmin
              .updateTeam(team.id!, newName);
        }
        ref.invalidate(allOrganizationsProvider);
      },
    );
  }

  // ── Delete confirmation ───────────────────────────────────────────────────

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Organization team,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title:   const Text('Delete Team'),
        content: Text(
          'Delete team "${team.name}"?\n\n'
          'This will remove the team and all its member links permanently.',
        ),
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
      await ref.read(clientProvider).admin.deleteOrganization(team.id!);
      ref.invalidate(allOrganizationsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${team.name}" deleted.')),
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

// ── Teams table ───────────────────────────────────────────────────────────────

class _TeamsTable extends StatelessWidget {
  const _TeamsTable({
    required this.teamsAsync,
    required this.parentOrgsAsync,
    required this.onEdit,
    required this.onDelete,
  });

  final AsyncValue<List<Organization>>  teamsAsync;
  final AsyncValue<List<Organization>>  parentOrgsAsync;
  final void Function(Organization)     onEdit;
  final void Function(Organization)     onDelete;

  Map<int, String> _buildOrgNameMap() {
    final map = <int, String>{};
    for (final o in parentOrgsAsync.value ?? []) {
      if (o.id != null) map[o.id!] = o.name;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final orgNames = _buildOrgNameMap();

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
                Text('All Teams', style: AppTextStyles.headingSm),
                const Spacer(),
                if (teamsAsync.value != null)
                  Text(
                    '${teamsAsync.value!.length} total',
                    style: AppTextStyles.bodyXs,
                  ),
              ],
            ),
          ),
          AppDataTable<Organization>(
            isLoading:  teamsAsync.isLoading,
            rows:       teamsAsync.value ?? [],
            searchable: true,
            mobileCardBuilder: (t) {
              final orgName =
                  t.parentId != null ? orgNames[t.parentId!] : null;
              return _TeamMobileCard(
                team:    t,
                orgName: orgName,
                onEdit:  () => onEdit(t),
                onDelete: () => onDelete(t),
              );
            },
            columns: [
              // ── Team name ────────────────────────────────────────────────
              AppTableColumn(
                label:       'Team',
                flex:        3,
                sortKey:     'name',
                comparator:  (a, b) => a.name.compareTo(b.name),
                searchValue: (t) => t.name,
                cellBuilder: (t) => Row(
                  children: [
                    _TeamAvatar(name: t.name, imageUrl: t.imageUrl),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            t.name,
                            style:    AppTextStyles.labelLg,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('ID #${t.id}', style: AppTextStyles.bodyXs),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Organization ─────────────────────────────────────────────
              AppTableColumn(
                label:       'Organization',
                flex:        2,
                searchValue: (t) =>
                    t.parentId != null ? (orgNames[t.parentId!] ?? '') : '',
                cellBuilder: (t) {
                  final orgName =
                      t.parentId != null ? orgNames[t.parentId!] : null;
                  if (orgName == null) {
                    return Text('—',
                        style: AppTextStyles.bodyXs
                            .copyWith(color: AppColors.onSurfaceSubtle));
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
                        child: const Icon(Icons.corporate_fare_rounded,
                            size: 12, color: AppColors.primary),
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

              // ── Manager ──────────────────────────────────────────────────
              AppTableColumn(
                label:       'Manager',
                flex:        2,
                sortKey:     'manager',
                comparator:  (a, b) =>
                    (a.manager?.userInfo?.userName ?? '')
                        .compareTo(b.manager?.userInfo?.userName ?? ''),
                cellBuilder: (t) => t.manager != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MiniAvatar(
                              name: t.manager!.userInfo?.userName ?? '?'),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              t.manager!.userInfo?.userName ?? '—',
                              style:    AppTextStyles.bodyMd,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : const AppStatusChip(
                        label:   'Unassigned',
                        variant: AppChipVariant.neutral,
                        dot:     false,
                      ),
              ),

              // ── Members ──────────────────────────────────────────────────
              AppTableColumn(
                label:      'Members',
                flex:       1,
                alignment:  Alignment.center,
                sortKey:    'members',
                comparator: (a, b) =>
                    (a.users?.length ?? 0).compareTo(b.users?.length ?? 0),
                cellBuilder: (t) => _MembersBadge(count: t.users?.length ?? 0),
              ),

              // ── Actions ──────────────────────────────────────────────────
              AppTableColumn(
                label:      'Actions',
                flex:       1,
                alignment:  Alignment.center,
                cellBuilder: (t) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon:    const Icon(Icons.edit_outlined, size: 16),
                      tooltip: 'Edit',
                      color:   AppColors.onSurfaceMuted,
                      onPressed: () => onEdit(t),
                    ),
                    IconButton(
                      icon:    const Icon(Icons.delete_outline_rounded, size: 16),
                      tooltip: 'Delete',
                      color:   AppColors.error,
                      onPressed: () => onDelete(t),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (teamsAsync.hasError)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Error: ${teamsAsync.error}',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.error),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Create team form body ─────────────────────────────────────────────────────

class _CreateTeamBody extends StatefulWidget {
  const _CreateTeamBody({
    required this.nameCtrl,
    required this.orgNotifier,
    required this.parentOrgs,
  });

  final TextEditingController  nameCtrl;
  final ValueNotifier<int?>    orgNotifier;
  final List<Organization>     parentOrgs;

  @override
  State<_CreateTeamBody> createState() => _CreateTeamBodyState();
}

class _CreateTeamBodyState extends State<_CreateTeamBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Team Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Team Name',
          controller: widget.nameCtrl,
          hint:       'Engineering / Sales / Operations',
        ),
        const SizedBox(height: AppSpacing.lg),

        const SheetSection(title: 'Parent Organization'),
        const SizedBox(height: AppSpacing.sm),
        Text('Organization', style: AppTextStyles.labelMd),
        const SizedBox(height: 6),
        ValueListenableBuilder<int?>(
          valueListenable: widget.orgNotifier,
          builder: (_, orgId, __) => DropdownButtonFormField<int>(
            value:      orgId,
            decoration: const InputDecoration(
                hintText: 'Select organization'),
            items: widget.parentOrgs
                .map((o) => DropdownMenuItem(
                      value: o.id,
                      child: Text(o.name),
                    ))
                .toList(),
            onChanged: (v) =>
                setState(() => widget.orgNotifier.value = v),
          ),
        ),
      ],
    );
  }
}

// ── Edit team form body ───────────────────────────────────────────────────────

class _EditTeamBody extends StatelessWidget {
  const _EditTeamBody({required this.nameCtrl});

  final TextEditingController nameCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Team Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Team Name',
          controller: nameCtrl,
          hint:       'Engineering / Sales / Operations',
        ),
      ],
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

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
            mainAxisSize:       MainAxisSize.min,
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

class _TeamAvatar extends StatelessWidget {
  const _TeamAvatar({required this.name, this.imageUrl});
  final String  name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Image.network(imageUrl!, width: 34, height: 34, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _AvatarFallback(initial: initial)),
      );
    }
    return _AvatarFallback(initial: initial);
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback({required this.initial});
  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  34,
      height: 34,
      decoration: BoxDecoration(
        color:        AppColors.info.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize:   13,
            fontWeight: FontWeight.w700,
            color:      AppColors.info,
          ),
        ),
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width:  24,
      height: 24,
      decoration: BoxDecoration(
        color:        AppColors.info.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize:   10,
            fontWeight: FontWeight.w700,
            color:      AppColors.info,
          ),
        ),
      ),
    );
  }
}

class _MembersBadge extends StatelessWidget {
  const _MembersBadge({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    final hasMembers = count > 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: hasMembers
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border: Border.all(
          color: hasMembers
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.divider,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_rounded,
              size:  12,
              color: hasMembers ? AppColors.success : AppColors.onSurfaceSubtle),
          const SizedBox(width: 4),
          Text(
            '$count',
            style: AppTextStyles.labelMd.copyWith(
              color: hasMembers
                  ? AppColors.success
                  : AppColors.onSurfaceSubtle,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Mobile card for teams ────────────────────────────────────────────────────

class _TeamMobileCard extends StatelessWidget {
  const _TeamMobileCard({
    required this.team,
    required this.onEdit,
    required this.onDelete,
    this.orgName,
  });

  final Organization team;
  final VoidCallback  onEdit;
  final VoidCallback  onDelete;
  final String?       orgName;

  @override
  Widget build(BuildContext context) {
    return MobileDataCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: avatar + team name + members badge
          Row(
            children: [
              _TeamAvatar(name: team.name, imageUrl: team.imageUrl),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team.name, style: AppTextStyles.labelLg,
                        overflow: TextOverflow.ellipsis),
                    Text('ID #${team.id}', style: AppTextStyles.bodyXs),
                  ],
                ),
              ),
              _MembersBadge(count: team.users?.length ?? 0),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          // Bottom row: org + manager + actions
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (orgName != null)
                      Row(
                        children: [
                          Icon(Icons.corporate_fare_rounded,
                              size: 12, color: AppColors.onSurfaceMuted),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(orgName!,
                                style: AppTextStyles.bodyXs,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person_rounded,
                            size: 12, color: AppColors.onSurfaceMuted),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            team.manager?.userInfo?.userName ?? 'Unassigned',
                            style: AppTextStyles.bodyXs.copyWith(
                              color: team.manager != null
                                  ? null
                                  : AppColors.onSurfaceSubtle,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MobileCardActions(onEdit: onEdit, onDelete: onDelete),
            ],
          ),
        ],
      ),
    );
  }
}
