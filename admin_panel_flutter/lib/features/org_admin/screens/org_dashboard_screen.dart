import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/theme.dart';
import '../providers/org_admin_providers.dart';

class OrgDashboardScreen extends ConsumerWidget {
  const OrgDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrg      = ref.watch(myOrganizationProvider).value;
    final teams      = ref.watch(orgTeamsProvider).value ?? [];
    final usersAsync = ref.watch(orgUsersProvider);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, ${myOrg?.name ?? 'Organization Admin'}', style: AppTextStyles.headingLg),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing:    AppSpacing.lg,
            runSpacing: AppSpacing.md,
            children: [
              _StatTile(
                label: 'Total Teams',
                value: '${teams.length}',
                icon:  Icons.groups_rounded,
                color: AppColors.primary,
              ),
              _StatTile(
                label: 'Total Users',
                value: usersAsync.isLoading ? '…' : '${usersAsync.value?.length ?? 0}',
                icon:  Icons.people_rounded,
                color: AppColors.info,
              ),
              _StatTile(
                label: 'Managers',
                value: usersAsync.isLoading
                    ? '…'
                    : '${usersAsync.value?.where((u) => u.role == Role.Manager).length ?? 0}',
                icon:  Icons.manage_accounts_rounded,
                color: AppColors.success,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value, required this.icon, required this.color});
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.headingSm),
              Text(label, style: AppTextStyles.bodyXs),
            ],
          ),
        ],
      ),
    );
  }
}
