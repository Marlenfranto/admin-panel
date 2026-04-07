import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/org_admin_providers.dart';
import '../../../src/providers.dart';

class OrgTeamsScreen extends ConsumerWidget {
  const OrgTeamsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrgAsync = ref.watch(myOrganizationProvider);
    final teamsAsync = ref.watch(orgTeamsProvider);

    return ScreenWithFab(
      icon: Icons.add_rounded,
      label: 'Create',
      onPressed: myOrgAsync.value == null
          ? null
          : () => _showCreateTeamSheet(context, ref, myOrgAsync.value!),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.responsivePagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ─────────────────────────────────────────────────────
            myOrgAsync.when(
              data: (org) => ResponsivePageHeader(
                title:    'Teams',
                subtitle: org != null
                    ? 'Manage teams within ${org.name}.'
                    : 'Manage your organization teams.',
                action: AppGradientButton(
                  label:     'Create Team',
                  icon:      Icons.add_rounded,
                  onPressed: org == null
                      ? null
                      : () => _showCreateTeamSheet(context, ref, org),
                ),
              ),
              loading: () => const AppSkeletonBox(width: 250, height: 40),
              error:   (_, __) => Text('Error loading organization.',
                  style: AppTextStyles.labelMd),
            ),
            const SizedBox(height: AppSpacing.lg),

            // ── Teams list table ──────────────────────────────────────────
            teamsAsync.when(
              data: (teams) => _TeamsTable(
                teams:     teams,
                isLoading: teamsAsync.isLoading,
                onEdit:    (t) => _showEditTeamSheet(context, ref, t),
                onRemove:  (t) => _removeTeam(context, ref, t),
              ),
              loading: () => const _TeamsTable(teams: [], isLoading: true, onEdit: null, onRemove: null),
              error:   (e, __) => Text('Error: $e', style: AppTextStyles.bodySm.copyWith(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateTeamSheet(BuildContext context, WidgetRef ref, Organization parentOrg) {
    final nameCtrl = TextEditingController();

    AppSideSheet.show(
      context:   context,
      title:     'Create New Team',
      saveLabel: 'Create Team',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetSection(title: 'Team Details'),
          const SizedBox(height: AppSpacing.sm),
          SheetField(
            label:      'Team Name',
            controller: nameCtrl,
            hint:       'Engineering / Sales / Support',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'This team will be created under ${parentOrg.name}.',
            style: AppTextStyles.bodyXs.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) throw Exception('Name is required.');
        await ref.read(clientProvider).organizationAdmin.createTeam(
          nameCtrl.text.trim(),
          parentOrg.id!,
          null, // imageUrl
        );
        ref.invalidate(orgTeamsProvider);
      },
    );
  }

  void _showEditTeamSheet(BuildContext context, WidgetRef ref, Organization team) {
    final nameCtrl       = TextEditingController(text: team.name);
    final managers       = ref.read(orgManagersProvider);
    final managerNotifier = ValueNotifier<int?>(team.manager?.id);

    AppSideSheet.show(
      context:   context,
      title:     'Edit Team',
      saveLabel: 'Save',
      body: _EditTeamBody(
        nameCtrl:        nameCtrl,
        managerNotifier: managerNotifier,
        managers:        managers,
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) throw Exception('Team name is required.');
        final newName = nameCtrl.text.trim();
        if (newName != team.name) {
          await ref.read(clientProvider).organizationAdmin
              .updateTeam(team.id!, newName);
        }
        final newManagerId = managerNotifier.value;
        if (newManagerId != null && newManagerId != team.manager?.id) {
          await ref.read(clientProvider).organizationAdmin
              .assignManagerToTeam(newManagerId, team.id!);
        }
        ref.invalidate(orgTeamsProvider);
      },
    );
  }

  Future<void> _removeTeam(BuildContext context, WidgetRef ref, Organization team) async {
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
            style:     FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child:     const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(clientProvider).organizationAdmin.deleteTeam(team.id!);
      ref.invalidate(orgTeamsProvider);
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

class _TeamsTable extends StatelessWidget {
  const _TeamsTable({
    required this.teams,
    required this.isLoading,
    this.onEdit,
    this.onRemove,
  });

  final List<Organization> teams;
  final bool               isLoading;
  final Function(Organization)? onEdit;
  final Function(Organization)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: AppDataTable<Organization>(
        isLoading:  isLoading,
        rows:       teams,
        searchable: true,
        mobileCardBuilder: (t) => MobileDataCard(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name, style: AppTextStyles.labelLg,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(
                      t.manager?.userInfo?.userName ?? 'No manager',
                      style: AppTextStyles.bodyXs.copyWith(
                        color: t.manager != null
                            ? null : AppColors.onSurfaceSubtle,
                      ),
                    ),
                  ],
                ),
              ),
              MobileCardActions(
                onEdit:  onEdit != null ? () => onEdit!(t) : null,
                onDelete: onRemove != null ? () => onRemove!(t) : null,
              ),
            ],
          ),
        ),
        columns: [
          AppTableColumn(
            label:       'Team Name',
            flex:        2,
            sortKey:     'name',
            searchValue: (t) => t.name,
            cellBuilder: (t) => Text(t.name, style: AppTextStyles.labelLg),
          ),
          AppTableColumn(
            label:       'Manager',
            flex:        2,
            cellBuilder: (t) => t.manager != null
                ? Row(
                    children: [
                      Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                        child: Center(child: Text(t.manager?.userInfo?.userName?[0] ?? '?', style: const TextStyle(fontSize: 10, color: AppColors.primary))),
                      ),
                      const SizedBox(width: 8),
                      Text(t.manager?.userInfo?.userName ?? 'Unknown', style: AppTextStyles.bodySm),
                    ],
                  )
                : Text('Not Assigned', style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceSubtle)),
          ),
          AppTableColumn(
            label:       'Actions',
            flex:        2,
            alignment:   Alignment.center,
            cellBuilder: (t) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon:    const Icon(Icons.edit_outlined, size: 16),
                  tooltip: 'Edit',
                  color:   AppColors.onSurfaceMuted,
                  onPressed: onEdit != null ? () => onEdit!(t) : null,
                ),
                IconButton(
                  icon:    const Icon(Icons.delete_outline_rounded, size: 16, color: AppColors.error),
                  tooltip: 'Delete',
                  onPressed: onRemove != null ? () => onRemove!(t) : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Edit team form body ───────────────────────────────────────────────────────

class _EditTeamBody extends StatefulWidget {
  const _EditTeamBody({
    required this.nameCtrl,
    required this.managerNotifier,
    required this.managers,
  });

  final TextEditingController   nameCtrl;
  final ValueNotifier<int?>     managerNotifier;
  final List<AppUser>           managers;

  @override
  State<_EditTeamBody> createState() => _EditTeamBodyState();
}

class _EditTeamBodyState extends State<_EditTeamBody> {
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

        const SheetSection(title: 'Manager'),
        const SizedBox(height: AppSpacing.sm),
        if (widget.managers.isEmpty)
          Text(
            'No managers in this organization. Add a user with the Manager role first.',
            style: AppTextStyles.bodySm
                .copyWith(color: AppColors.onSurfaceSubtle),
          )
        else ...[
          Text('Assign Manager', style: AppTextStyles.labelMd),
          const SizedBox(height: 6),
          ValueListenableBuilder<int?>(
            valueListenable: widget.managerNotifier,
            builder: (_, managerId, __) =>
                DropdownButtonFormField<int?>(
              value:      managerId,
              decoration: const InputDecoration(
                  hintText: 'Select a manager...'),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('None'),
                ),
                ...widget.managers.map((m) => DropdownMenuItem<int?>(
                      value: m.id,
                      child: Text(
                        m.userInfo?.userName ?? m.userInfo?.email ?? 'Unknown',
                      ),
                    )),
              ],
              onChanged: (v) =>
                  setState(() => widget.managerNotifier.value = v),
            ),
          ),
        ],
      ],
    );
  }
}
