import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/admin_providers.dart';
import '../../../src/providers.dart';

class OrganizationsScreen extends ConsumerWidget {
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync  = ref.watch(allOrganizationsProvider);
    final usersAsync = ref.watch(allUsersProvider);

    final orgs    = orgsAsync.value ?? [];
    final managed = orgs.where((o) => o.manager != null).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Page header ───────────────────────────────────────────────────
          _PageHeader(
            title:    'Organizations',
            subtitle: 'Manage your registered organizations.',
            action: AppGradientButton(
              label:     'Add Organization',
              icon:      Icons.add_rounded,
              onPressed: () => _showAddSheet(context, ref),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Stats row ─────────────────────────────────────────────────────
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _StatCard(
                icon:        Icons.corporate_fare_rounded,
                accentColor: AppColors.primary,
                value:       '${orgs.length}',
                label:       'Total Organizations',
                isLoading:   orgsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.people_rounded,
                accentColor: AppColors.info,
                value:       '${usersAsync.value?.length ?? 0}',
                label:       'Total Users',
                isLoading:   usersAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.manage_accounts_rounded,
                accentColor: AppColors.success,
                value:       '$managed',
                label:       'Managed',
                isLoading:   orgsAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Table ─────────────────────────────────────────────────────────
          _OrgsTable(orgsAsync: orgsAsync),
        ],
      ),
    );
  }

  void _showAddSheet(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    AppSideSheet.show(
      context:   context,
      title:     'Add Organization',
      saveLabel: 'Create',
      body:      _OrgFormBody(nameCtrl: nameCtrl),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Organization name is required.');
        }
        await ref
            .read(clientProvider)
            .admin
            .createOrganization(nameCtrl.text.trim());
        ref.invalidate(allOrganizationsProvider);
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

// ── Organizations table ────────────────────────────────────────────────────────

class _OrgsTable extends StatelessWidget {
  const _OrgsTable({required this.orgsAsync});
  final AsyncValue<List<Organization>> orgsAsync;

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
                Text('All Organizations', style: AppTextStyles.headingSm),
                const Spacer(),
                if (orgsAsync.value != null)
                  Text(
                    '${orgsAsync.value!.length} total',
                    style: AppTextStyles.bodyXs,
                  ),
              ],
            ),
          ),
          AppDataTable<Organization>(
            isLoading:  orgsAsync.isLoading,
            rows:       orgsAsync.value ?? [],
            searchable: true,
            columns: [
              AppTableColumn(
                label:       'Organization',
                flex:        3,
                sortKey:     'name',
                comparator:  (a, b) => a.name.compareTo(b.name),
                searchValue: (o) =>
                    '${o.name} ${o.manager?.userInfo?.userName ?? ''}',
                cellBuilder: (o) => Row(
                  children: [
                    _OrgAvatar(name: o.name),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            o.name,
                            style:    AppTextStyles.labelLg,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'ID #${o.id}',
                            style: AppTextStyles.bodyXs,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppTableColumn(
                label:       'Manager',
                flex:        2,
                sortKey:     'manager',
                comparator:  (a, b) =>
                    (a.manager?.userInfo?.userName ?? '')
                        .compareTo(b.manager?.userInfo?.userName ?? ''),
                cellBuilder: (o) => o.manager != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MiniAvatar(
                            name: o.manager!.userInfo?.userName ?? '?',
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              o.manager!.userInfo?.userName ?? '—',
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
              AppTableColumn(
                label:       'Members',
                flex:        1,
                alignment:   Alignment.center,
                sortKey:     'members',
                comparator:  (a, b) =>
                    (a.users?.length ?? 0).compareTo(b.users?.length ?? 0),
                cellBuilder: (o) => _MembersBadge(count: o.users?.length ?? 0),
              ),
            ],
          ),
          if (orgsAsync.hasError)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'Error: ${orgsAsync.error}',
                style: AppTextStyles.bodySm.copyWith(color: AppColors.error),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Row sub-widgets ───────────────────────────────────────────────────────────

class _OrgAvatar extends StatelessWidget {
  const _OrgAvatar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Container(
      width:  34,
      height: 34,
      decoration: BoxDecoration(
        gradient:     AppColors.brandGradientDiagonal,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize:   13,
            fontWeight: FontWeight.w700,
            color:      Colors.white,
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
          Icon(
            Icons.person_rounded,
            size:  12,
            color: hasMembers ? AppColors.success : AppColors.onSurfaceSubtle,
          ),
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

// ── Add Org form body (side sheet) ───────────────────────────────────────────

class _OrgFormBody extends StatelessWidget {
  const _OrgFormBody({required this.nameCtrl});
  final TextEditingController nameCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Organization Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Name',
          controller: nameCtrl,
          hint:       'e.g. Acme Corp',
        ),
      ],
    );
  }
}

// ── Page header ────────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader({
    required this.title,
    required this.subtitle,
    this.action,
  });

  final String  title;
  final String  subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,    style: AppTextStyles.headingLg),
              const SizedBox(height: 4),
              Text(subtitle, style: AppTextStyles.bodySm),
            ],
          ),
        ),
        if (action != null) ...[
          const SizedBox(width: AppSpacing.md),
          action!,
        ],
      ],
    );
  }
}
