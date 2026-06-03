import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../../../src/providers.dart';
import '../providers/admin_providers.dart';

final RegExp _localeKeyRe = RegExp(r'^[A-Z]{2}-[a-z]{2,3}$');

class AdminLocaleScreen extends ConsumerStatefulWidget {
  const AdminLocaleScreen({super.key});

  @override
  ConsumerState<AdminLocaleScreen> createState() => _AdminLocaleScreenState();
}

class _AdminLocaleScreenState extends ConsumerState<AdminLocaleScreen> {
  int? _selectedOrgId;

  @override
  Widget build(BuildContext context) {
    final orgsAsync = ref.watch(parentOrgsProvider);
    final orgs = orgsAsync.value ?? [];
    if (_selectedOrgId == null && orgs.isNotEmpty) {
      _selectedOrgId = orgs.first.id;
    }

    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(context.responsivePagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsivePageHeader(
              title: 'Locales',
              subtitle:
                  'Manage regions and locale combinations per organization.',
            ),
            const SizedBox(height: AppSpacing.lg),
            _OrgSelector(
              orgs: orgs,
              value: _selectedOrgId,
              isLoading: orgsAsync.isLoading,
              onChanged: (id) => setState(() => _selectedOrgId = id),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_selectedOrgId != null) ...[
              const TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: [
                  Tab(text: 'Regions'),
                  Tab(text: 'Locales'),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 600,
                child: TabBarView(
                  children: [
                    _RegionsTab(orgId: _selectedOrgId!),
                    _LocalesTab(orgId: _selectedOrgId!),
                  ],
                ),
              ),
            ] else
              const Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text('Select an organization to manage its locales.'),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Org selector ────────────────────────────────────────────────────────────

class _OrgSelector extends StatelessWidget {
  const _OrgSelector({
    required this.orgs,
    required this.value,
    required this.isLoading,
    required this.onChanged,
  });

  final List<Organization> orgs;
  final int? value;
  final bool isLoading;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppSkeletonBox(height: 56);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.corporate_fare_rounded, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Text('Organization:', style: AppTextStyles.labelMd),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: DropdownButtonFormField<int>(
              value: value,
              isExpanded: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              items: orgs
                  .map((o) => DropdownMenuItem(
                        value: o.id,
                        child: Text(o.name),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Regions tab ─────────────────────────────────────────────────────────────

class _RegionsTab extends ConsumerWidget {
  const _RegionsTab({required this.orgId});
  final int orgId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final regionsAsync = ref.watch(adminRegionsProvider(orgId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Regions', style: AppTextStyles.headingSm),
            const Spacer(),
            AppGradientButton(
              label: 'Add Region',
              icon: Icons.add_rounded,
              onPressed: () => _showSheet(context, ref, null),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: AppDataTable<Region>(
            isLoading: regionsAsync.isLoading,
            rows: regionsAsync.value ?? [],
            searchable: true,
            mobileCardBuilder: (r) => ListTile(
              title: Text('${r.code} — ${r.displayName}'),
              subtitle: Text(r.enabled ? 'Enabled' : 'Disabled'),
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined, size: 16),
                onPressed: () => _showSheet(context, ref, r),
              ),
            ),
            columns: [
              AppTableColumn(
                label: 'Code',
                flex: 1,
                sortKey: 'code',
                comparator: (a, b) => a.code.compareTo(b.code),
                searchValue: (r) => '${r.code} ${r.displayName}',
                cellBuilder: (r) =>
                    Text(r.code, style: AppTextStyles.labelLg),
              ),
              AppTableColumn(
                label: 'Display Name',
                flex: 3,
                sortKey: 'name',
                comparator: (a, b) => a.displayName.compareTo(b.displayName),
                cellBuilder: (r) => Text(r.displayName),
              ),
              AppTableColumn(
                label: 'Enabled',
                flex: 1,
                alignment: Alignment.center,
                cellBuilder: (r) => AppStatusChip(
                  label: r.enabled ? 'Enabled' : 'Disabled',
                  variant: r.enabled
                      ? AppChipVariant.success
                      : AppChipVariant.neutral,
                ),
              ),
              AppTableColumn(
                label: 'Actions',
                flex: 1,
                alignment: Alignment.center,
                cellBuilder: (r) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      tooltip: 'Edit',
                      color: AppColors.onSurfaceMuted,
                      onPressed: () => _showSheet(context, ref, r),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.delete_outline_rounded, size: 16),
                      tooltip: 'Delete',
                      color: AppColors.error,
                      onPressed: () => _confirmDelete(context, ref, r),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSheet(BuildContext context, WidgetRef ref, Region? existing) {
    final codeCtrl = TextEditingController(text: existing?.code ?? '');
    final nameCtrl =
        TextEditingController(text: existing?.displayName ?? '');
    bool enabled = existing?.enabled ?? true;

    AppSideSheet.show(
      context: context,
      title: existing == null ? 'Add Region' : 'Edit Region',
      saveLabel: existing == null ? 'Create' : 'Save',
      body: StatefulBuilder(
        builder: (ctx, setSt) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: codeCtrl,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Region Code',
                hintText: 'e.g. US, UK, IN, AE',
                helperText: 'ISO-3166 alpha-2, uppercase.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            SwitchListTile(
              title: const Text('Enabled'),
              value: enabled,
              onChanged: (v) => setSt(() => enabled = v),
            ),
          ],
        ),
      ),
      onSave: () async {
        final code = codeCtrl.text.trim().toUpperCase();
        final name = nameCtrl.text.trim();
        if (code.length != 2 || !RegExp(r'^[A-Z]{2}$').hasMatch(code)) {
          throw Exception('Region code must be 2 uppercase letters.');
        }
        if (name.isEmpty) throw Exception('Display name is required.');

        final region = Region(
          id: existing?.id,
          organizationId: orgId,
          code: code,
          displayName: name,
          enabled: enabled,
        );
        await ref.read(clientProvider).admin.upsertRegion(orgId, region);
        ref.invalidate(adminRegionsProvider(orgId));
      },
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, Region region) async {
    // Pre-check: list locales that still reference this region so the user
    // sees a clear "in use" dialog instead of a server error.
    final locales =
        ref.read(adminLocaleConfigsProvider(orgId)).value ?? const [];
    final blocking = locales
        .where((l) => l.regionCode == region.code)
        .toList(growable: false);

    if (blocking.isNotEmpty) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Cannot delete region "${region.code}"'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blocking.length == 1
                    ? 'One locale is still using this region:'
                    : '${blocking.length} locales are still using this region:',
                style: AppTextStyles.bodySm,
              ),
              const SizedBox(height: AppSpacing.sm),
              ...blocking.map(
                (l) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      const Icon(Icons.language_rounded,
                          size: 14, color: AppColors.onSurfaceMuted),
                      const SizedBox(width: 6),
                      Text('${l.localeKey} — ${l.displayName}',
                          style: AppTextStyles.labelMd),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Remove or reassign these locales first, then delete the region.',
                style: AppTextStyles.bodyXs,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Region'),
        content: Text('Delete region "${region.code}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(clientProvider).admin.deleteRegion(region.id!);
      ref.invalidate(adminRegionsProvider(orgId));
    } catch (e) {
      if (context.mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

// ── Locales tab ─────────────────────────────────────────────────────────────

class _LocalesTab extends ConsumerWidget {
  const _LocalesTab({required this.orgId});
  final int orgId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localesAsync = ref.watch(adminLocaleConfigsProvider(orgId));
    final regionsAsync = ref.watch(adminRegionsProvider(orgId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text('Locales', style: AppTextStyles.headingSm),
            const Spacer(),
            AppGradientButton(
              label: 'Add Locale',
              icon: Icons.add_rounded,
              onPressed: () => _showSheet(
                context,
                ref,
                null,
                regionsAsync.value ?? [],
                localesAsync.value ?? [],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: AppDataTable<LocaleConfig>(
            isLoading: localesAsync.isLoading,
            rows: localesAsync.value ?? [],
            searchable: true,
            mobileCardBuilder: (l) => ListTile(
              title: Text(l.localeKey),
              subtitle: Text(l.displayName),
              trailing: l.isDefault
                  ? const Icon(Icons.star_rounded,
                      size: 16, color: AppColors.warning)
                  : null,
            ),
            columns: [
              AppTableColumn(
                label: 'Locale',
                flex: 2,
                sortKey: 'key',
                comparator: (a, b) => a.localeKey.compareTo(b.localeKey),
                searchValue: (l) => '${l.localeKey} ${l.displayName}',
                cellBuilder: (l) => Row(
                  children: [
                    Text(l.localeKey,
                        style: AppTextStyles.labelLg),
                    if (l.isDefault) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.star_rounded,
                          size: 14, color: AppColors.warning),
                    ],
                  ],
                ),
              ),
              AppTableColumn(
                label: 'Region',
                flex: 1,
                cellBuilder: (l) => Text(l.regionCode),
              ),
              AppTableColumn(
                label: 'Language',
                flex: 1,
                cellBuilder: (l) => Text(l.languageCode),
              ),
              AppTableColumn(
                label: 'Display Name',
                flex: 3,
                cellBuilder: (l) => Text(l.displayName),
              ),
              AppTableColumn(
                label: 'Fallback',
                flex: 1,
                cellBuilder: (l) =>
                    Text(l.fallbackLocaleKey ?? '—'),
              ),
              AppTableColumn(
                label: 'Enabled',
                flex: 1,
                alignment: Alignment.center,
                cellBuilder: (l) => AppStatusChip(
                  label: l.enabled ? 'Enabled' : 'Disabled',
                  variant: l.enabled
                      ? AppChipVariant.success
                      : AppChipVariant.neutral,
                ),
              ),
              AppTableColumn(
                label: 'Actions',
                flex: 2,
                alignment: Alignment.center,
                cellBuilder: (l) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!l.isDefault)
                      IconButton(
                        icon: const Icon(Icons.star_border_rounded,
                            size: 16),
                        tooltip: 'Set as default',
                        color: AppColors.warning,
                        onPressed: () => _setDefault(context, ref, l),
                      ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 16),
                      tooltip: 'Edit',
                      color: AppColors.onSurfaceMuted,
                      onPressed: () => _showSheet(
                        context,
                        ref,
                        l,
                        regionsAsync.value ?? [],
                        localesAsync.value ?? [],
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.delete_outline_rounded, size: 16),
                      tooltip: 'Delete',
                      color: AppColors.error,
                      onPressed: () => _confirmDelete(context, ref, l),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSheet(
    BuildContext context,
    WidgetRef ref,
    LocaleConfig? existing,
    List<Region> regions,
    List<LocaleConfig> allLocales,
  ) {
    String regionCode = existing?.regionCode ??
        (regions.isNotEmpty ? regions.first.code : '');
    final langCtrl =
        TextEditingController(text: existing?.languageCode ?? '');
    final nameCtrl =
        TextEditingController(text: existing?.displayName ?? '');
    String? fallback = existing?.fallbackLocaleKey;
    bool enabled = existing?.enabled ?? true;

    AppSideSheet.show(
      context: context,
      title: existing == null ? 'Add Locale' : 'Edit Locale',
      saveLabel: existing == null ? 'Create' : 'Save',
      body: StatefulBuilder(
        builder: (ctx, setSt) {
          final preview = (regionCode.isNotEmpty &&
                  langCtrl.text.trim().isNotEmpty)
              ? '$regionCode-${langCtrl.text.trim().toLowerCase()}'
              : '—';
          final fallbackOptions = allLocales
              .where((l) => l.id != existing?.id)
              .map((l) => l.localeKey)
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: regionCode.isEmpty ? null : regionCode,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Region',
                  border: OutlineInputBorder(),
                ),
                items: regions
                    .map((r) => DropdownMenuItem(
                          value: r.code,
                          child: Text('${r.code} — ${r.displayName}'),
                        ))
                    .toList(),
                onChanged: (v) => setSt(() => regionCode = v ?? ''),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: langCtrl,
                onChanged: (_) => setSt(() {}),
                decoration: const InputDecoration(
                  labelText: 'Language Code',
                  hintText: 'e.g. en, fr, ar, ta',
                  helperText: 'BCP-47, lowercase, 2–3 letters.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.infoSurface,
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.label_outline_rounded,
                        size: 16, color: AppColors.info),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Locale key: ',
                        style: AppTextStyles.labelMd),
                    Text(preview,
                        style: AppTextStyles.labelLg.copyWith(
                            color: AppColors.info)),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Display Name',
                  hintText: 'e.g. English (United States)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String?>(
                value: fallback,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Fallback locale (optional)',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<String?>(
                      value: null, child: Text('— None —')),
                  ...fallbackOptions.map(
                      (k) => DropdownMenuItem(value: k, child: Text(k))),
                ],
                onChanged: (v) => setSt(() => fallback = v),
              ),
              const SizedBox(height: AppSpacing.md),
              SwitchListTile(
                title: const Text('Enabled'),
                value: enabled,
                onChanged: (v) => setSt(() => enabled = v),
              ),
            ],
          );
        },
      ),
      onSave: () async {
        final lang = langCtrl.text.trim().toLowerCase();
        final name = nameCtrl.text.trim();
        if (regionCode.isEmpty) {
          throw Exception('Region is required.');
        }
        if (!RegExp(r'^[a-z]{2,3}$').hasMatch(lang)) {
          throw Exception('Language must be 2–3 lowercase letters.');
        }
        if (name.isEmpty) throw Exception('Display name is required.');

        final localeKey = '$regionCode-$lang';
        if (!_localeKeyRe.hasMatch(localeKey)) {
          throw Exception('Invalid locale key "$localeKey".');
        }

        final locale = LocaleConfig(
          id: existing?.id,
          organizationId: orgId,
          regionCode: regionCode,
          languageCode: lang,
          localeKey: localeKey,
          displayName: name,
          enabled: enabled,
          isDefault: existing?.isDefault ?? false,
          fallbackLocaleKey: fallback,
        );
        await ref
            .read(clientProvider)
            .admin
            .upsertLocaleConfig(orgId, locale);
        ref.invalidate(adminLocaleConfigsProvider(orgId));
      },
    );
  }

  Future<void> _setDefault(
      BuildContext context, WidgetRef ref, LocaleConfig locale) async {
    try {
      await ref
          .read(clientProvider)
          .admin
          .setDefaultLocale(orgId, locale.localeKey);
      ref.invalidate(adminLocaleConfigsProvider(orgId));
      ref.invalidate(moduleConfigProvider(orgId));
    } catch (e) {
      if (context.mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, LocaleConfig locale) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Locale'),
        content: Text('Delete locale "${locale.localeKey}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref
          .read(clientProvider)
          .admin
          .deleteLocaleConfig(locale.id!);
      ref.invalidate(adminLocaleConfigsProvider(orgId));
    } catch (e) {
      if (context.mounted) {
        final msg = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}
