import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/theme.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/manager_providers.dart';
import '../../../src/providers.dart';

class ManagerAssetsScreen extends ConsumerWidget {
  const ManagerAssetsScreen({super.key});

  static const _modules = ['theory', 'ai', 'training', 'assessment'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgsAsync   = ref.watch(managedOrganizationsProvider);
    final activeOrgId = ref.watch(activeOrgIdProvider);
    final assetsAsync = ref.watch(managerAssetsProvider);
    final assets      = assetsAsync.value ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assets', style: AppTextStyles.headingLg),
                    const SizedBox(height: 4),
                    Text(
                      'Manage 3D models, videos and other content assets.',
                      style: AppTextStyles.bodySm,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Org selector strip (multi-org) ───────────────────────────────
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
                            org:      org,
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

          // ── Stat cards ───────────────────────────────────────────────────
          Wrap(
            spacing:    AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: [
              _StatCard(
                icon:        Icons.perm_media_rounded,
                accentColor: AppColors.training,
                value:       '${assets.length}',
                label:       'Total Assets',
                isLoading:   assetsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.menu_book_rounded,
                accentColor: AppColors.theory,
                value:       '${assets.where((a) => a.module == 'theory').length}',
                label:       'Theory',
                isLoading:   assetsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.smart_toy_rounded,
                accentColor: AppColors.aiExpert,
                value:       '${assets.where((a) => a.module == 'ai').length}',
                label:       'AR Expert',
                isLoading:   assetsAsync.isLoading,
              ),
              _StatCard(
                icon:        Icons.fitness_center_rounded,
                accentColor: AppColors.training,
                value:       '${assets.where((a) => a.module == 'training').length}',
                label:       'Training',
                isLoading:   assetsAsync.isLoading,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          // ── Assets table ─────────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color:        AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border:       Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card header
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, AppSpacing.md,
                      AppSpacing.md, AppSpacing.sm),
                  child: Row(
                    children: [
                      Text('Assets Library', style: AppTextStyles.headingSm),
                      const Spacer(),
                      if (!assetsAsync.isLoading)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: AppSpacing.md),
                          child: Text(
                            '${assets.length} total',
                            style: AppTextStyles.bodyXs,
                          ),
                        ),
                      AppGradientButton(
                        label:     'Add Asset',
                        icon:      Icons.add_rounded,
                        onPressed: () =>
                            _showAssetSheet(context, ref, null),
                      ),
                    ],
                  ),
                ),
                AppDataTable<Asset>(
                  isLoading:  assetsAsync.isLoading,
                  rows:       assets,
                  searchable: true,
                  columns: [
                    AppTableColumn(
                      label:       'Name',
                      flex:        3,
                      sortKey:     'name',
                      comparator:  (a, b) => a.name.compareTo(b.name),
                      searchValue: (a) =>
                          '${a.name} ${a.description ?? ''} ${a.module}',
                      cellBuilder: (a) => Row(
                        children: [
                          _AssetIcon(module: a.module),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  a.name,
                                  style:    AppTextStyles.labelLg,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (a.description != null &&
                                    a.description!.isNotEmpty)
                                  Text(
                                    a.description!,
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
                      label:      'Version',
                      flex:        1,
                      sortKey:    'version',
                      comparator: (a, b) => a.version.compareTo(b.version),
                      cellBuilder: (a) => _VersionBadge(version: a.version),
                    ),
                    AppTableColumn(
                      label:      'Module',
                      flex:        1,
                      sortKey:    'module',
                      comparator: (a, b) => a.module.compareTo(b.module),
                      cellBuilder: (a) => AppStatusChip(
                        label:   _moduleLabel(a.module),
                        variant: _moduleVariant(a.module),
                      ),
                    ),
                    AppTableColumn(
                      label:     'Actions',
                      flex:      1,
                      alignment: Alignment.center,
                      cellBuilder: (a) => _RowActions(
                        onEdit:   () => _showAssetSheet(context, ref, a),
                        onDelete: () => _deleteAsset(context, ref, a),
                      ),
                    ),
                  ],
                ),
                if (assetsAsync.hasError)
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Text(
                      'Error: ${assetsAsync.error}',
                      style: AppTextStyles.bodySm
                          .copyWith(color: AppColors.error),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static String _moduleLabel(String module) {
    switch (module) {
      case 'theory':     return 'Theory';
      case 'ai':         return 'AR Expert';
      case 'training':   return 'Training';
      case 'assessment': return 'Assessment';
      default:           return module;
    }
  }

  static AppChipVariant _moduleVariant(String module) {
    switch (module) {
      case 'theory':     return AppChipVariant.primary;
      case 'ai':         return AppChipVariant.info;
      case 'training':   return AppChipVariant.success;
      case 'assessment': return AppChipVariant.warning;
      default:           return AppChipVariant.neutral;
    }
  }

  void _showAssetSheet(
      BuildContext context, WidgetRef ref, Asset? existing) {
    final nameCtrl    = TextEditingController(text: existing?.name    ?? '');
    final versionCtrl = TextEditingController(text: existing?.version ?? '');
    final urlCtrl     = TextEditingController(text: existing?.url     ?? '');
    final descCtrl    = TextEditingController(
        text: existing?.description ?? '');
    final moduleNotifier =
        ValueNotifier<String>(existing?.module ?? _modules.first);

    AppSideSheet.show(
      context:   context,
      title:     existing == null ? 'Add Asset' : 'Edit Asset',
      saveLabel: existing == null ? 'Add Asset' : 'Save Changes',
      body: _AssetFormBody(
        nameCtrl:       nameCtrl,
        versionCtrl:    versionCtrl,
        urlCtrl:        urlCtrl,
        descCtrl:       descCtrl,
        moduleNotifier: moduleNotifier,
        modules:        _modules,
        moduleLabel:    _moduleLabel,
      ),
      onSave: () async {
        final name    = nameCtrl.text.trim();
        final version = versionCtrl.text.trim();
        final url     = urlCtrl.text.trim();
        if (name.isEmpty || version.isEmpty || url.isEmpty) {
          throw Exception('Name, version and URL are required.');
        }
        final asset = Asset(
          id:          existing?.id,
          name:        name,
          version:     version,
          url:         url,
          description: descCtrl.text.trim().isEmpty
              ? null
              : descCtrl.text.trim(),
          module: moduleNotifier.value,
        );
        await ref.read(clientProvider).manager.upsertAsset(
              ref.read(activeOrgIdProvider) ?? 0, asset);
        ref.invalidate(managerAssetsProvider);
      },
    );
  }

  Future<void> _deleteAsset(
      BuildContext context, WidgetRef ref, Asset asset) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
        title:   Text('Delete Asset', style: AppTextStyles.headingSm),
        content: Text(
          'Delete "${asset.name}"? This cannot be undone.',
          style: AppTextStyles.bodySm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:     const Text('Cancel'),
          ),
          TextButton(
            style:     TextButton.styleFrom(foregroundColor: AppColors.error),
            onPressed: () => Navigator.pop(ctx, true),
            child:     const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await ref.read(clientProvider).manager.deleteAsset(asset.id!);
      ref.invalidate(managerAssetsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:         Text('Asset deleted.'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:         Text('Error: $e'),
              backgroundColor: AppColors.error),
        );
      }
    }
  }
}

// ── Asset icon (module-colored) ────────────────────────────────────────────────

class _AssetIcon extends StatelessWidget {
  const _AssetIcon({required this.module});
  final String module;

  static IconData _icon(String m) {
    switch (m) {
      case 'theory':     return Icons.menu_book_rounded;
      case 'ai':         return Icons.smart_toy_rounded;
      case 'training':   return Icons.fitness_center_rounded;
      case 'assessment': return Icons.quiz_rounded;
      default:           return Icons.perm_media_rounded;
    }
  }

  static Color _color(String m) {
    switch (m) {
      case 'theory':     return AppColors.theory;
      case 'ai':         return AppColors.aiExpert;
      case 'training':   return AppColors.training;
      case 'assessment': return AppColors.assess;
      default:           return AppColors.training;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _color(module);
    return Container(
      width:  34,
      height: 34,
      decoration: BoxDecoration(
        color:        color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Icon(_icon(module), size: 16, color: color),
    );
  }
}

// ── Version badge ──────────────────────────────────────────────────────────────

class _VersionBadge extends StatelessWidget {
  const _VersionBadge({required this.version});
  final String version;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color:        AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Text(
        'v$version',
        style: AppTextStyles.labelMd.copyWith(
          color:      AppColors.onSurfaceMuted,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

// ── Row action buttons ─────────────────────────────────────────────────────────

class _RowActions extends StatelessWidget {
  const _RowActions({required this.onEdit, required this.onDelete});
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HoverIconBtn(
          icon:    Icons.edit_rounded,
          tooltip: 'Edit',
          color:   AppColors.primary,
          onTap:   onEdit,
        ),
        const SizedBox(width: 4),
        _HoverIconBtn(
          icon:    Icons.delete_outline_rounded,
          tooltip: 'Delete',
          color:   AppColors.error,
          onTap:   onDelete,
        ),
      ],
    );
  }
}

class _HoverIconBtn extends StatefulWidget {
  const _HoverIconBtn({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData     icon;
  final String       tooltip;
  final Color        color;
  final VoidCallback onTap;

  @override
  State<_HoverIconBtn> createState() => _HoverIconBtnState();
}

class _HoverIconBtnState extends State<_HoverIconBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width:  30,
            height: 30,
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              widget.icon,
              size:  15,
              color: _hovered ? widget.color : AppColors.onSurfaceSubtle,
            ),
          ),
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
      return const AppSkeletonBox(
          width: 180, height: 72, radius: AppSpacing.radiusLg);
    }
    return Container(
      constraints: const BoxConstraints(minWidth: 160),
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

// ── Org chip ───────────────────────────────────────────────────────────────────

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

// ── Asset form body (side-sheet) ───────────────────────────────────────────────

class _AssetFormBody extends StatelessWidget {
  const _AssetFormBody({
    required this.nameCtrl,
    required this.versionCtrl,
    required this.urlCtrl,
    required this.descCtrl,
    required this.moduleNotifier,
    required this.modules,
    required this.moduleLabel,
  });

  final TextEditingController  nameCtrl;
  final TextEditingController  versionCtrl;
  final TextEditingController  urlCtrl;
  final TextEditingController  descCtrl;
  final ValueNotifier<String>  moduleNotifier;
  final List<String>           modules;
  final String Function(String) moduleLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Asset Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Name',
          controller: nameCtrl,
          hint:       'Safety Gloves Model',
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: SheetField(
                label:      'Version',
                controller: versionCtrl,
                hint:       '1.0.0',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 2,
              child: ValueListenableBuilder<String>(
                valueListenable: moduleNotifier,
                builder: (_, selected, __) =>
                    DropdownButtonFormField<String>(
                  value:      selected,
                  isExpanded: true,
                  decoration: const InputDecoration(labelText: 'Module'),
                  items: modules
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(moduleLabel(m)),
                          ))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) moduleNotifier.value = v;
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:      'URL',
          controller: urlCtrl,
          hint:       'https://cdn.example.com/asset.glb',
        ),
        const SizedBox(height: AppSpacing.md),
        SheetField(
          label:      'Description (optional)',
          controller: descCtrl,
          hint:       'Brief description of this asset',
        ),
      ],
    );
  }
}
