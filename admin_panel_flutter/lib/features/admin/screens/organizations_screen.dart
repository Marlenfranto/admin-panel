import 'dart:typed_data';

import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/services/cloudinary_uploader.dart';
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
              onPressed: () => _showSheet(context, ref, null),
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
          _OrgsTable(
            orgsAsync: orgsAsync,
            onEdit:   (o) => _showSheet(context, ref, o),
            onDelete: (o) => _confirmDelete(context, ref, o),
          ),
        ],
      ),
    );
  }

  // ── Create / Edit sheet ──────────────────────────────────────────────────

  void _showSheet(BuildContext context, WidgetRef ref, Organization? existing) {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');

    Uint8List? pickedBytes;
    String?    pickedName;
    bool       imageChanged = false;

    AppSideSheet.show(
      context:   context,
      title:     existing == null ? 'Add Organization' : 'Edit Organization',
      saveLabel: existing == null ? 'Create' : 'Save',
      body: _OrgFormBody(
        nameCtrl:        nameCtrl,
        existingImageUrl: existing?.imageUrl,
        onImageChanged:  (bytes, name) {
          pickedBytes  = bytes;
          pickedName   = name;
          imageChanged = true;
        },
      ),
      onSave: () async {
        if (nameCtrl.text.trim().isEmpty) {
          throw Exception('Organization name is required.');
        }

        String? imageUrl;
        if (pickedBytes != null) {
          final ext  = (pickedName?.split('.').last ?? 'jpg').toLowerCase();
          final name = '${DateTime.now().millisecondsSinceEpoch}.$ext';
          imageUrl = await CloudinaryUploader.uploadImage(
            pickedBytes!,
            fileName: name,
            folder:   'organizations',
          );
        } else if (!imageChanged) {
          imageUrl = existing?.imageUrl;
        }
        // imageChanged && pickedBytes == null → user cleared the image → null

        if (existing == null) {
          await ref.read(clientProvider).admin
              .createOrganization(nameCtrl.text.trim(), imageUrl);
        } else {
          await ref.read(clientProvider).admin
              .updateOrganization(existing.id!, nameCtrl.text.trim(), imageUrl);
        }
        ref.invalidate(allOrganizationsProvider);
      },
    );
  }

  // ── Delete confirmation ──────────────────────────────────────────────────

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    Organization org,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Organization'),
        content: Text(
          'Delete "${org.name}"?\n\nThis will permanently remove the organization '
          'and all associated modules, content, and user links.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
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
      await ref.read(clientProvider).admin.deleteOrganization(org.id!);
      ref.invalidate(allOrganizationsProvider);
      ref.invalidate(allUsersProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${org.name}" deleted.')),
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
              Text(label,  style: AppTextStyles.bodyXs),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Organizations table ────────────────────────────────────────────────────────

class _OrgsTable extends StatelessWidget {
  const _OrgsTable({
    required this.orgsAsync,
    required this.onEdit,
    required this.onDelete,
  });

  final AsyncValue<List<Organization>> orgsAsync;
  final void Function(Organization)   onEdit;
  final void Function(Organization)   onDelete;

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
                    _OrgAvatar(name: o.name, imageUrl: o.imageUrl),
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
                          Text('ID #${o.id}', style: AppTextStyles.bodyXs),
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
                              name: o.manager!.userInfo?.userName ?? '?'),
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
                label:      'Members',
                flex:       1,
                alignment:  Alignment.center,
                sortKey:    'members',
                comparator: (a, b) =>
                    (a.users?.length ?? 0).compareTo(b.users?.length ?? 0),
                cellBuilder: (o) =>
                    _MembersBadge(count: o.users?.length ?? 0),
              ),
              AppTableColumn(
                label:      'Actions',
                flex:       1,
                alignment:  Alignment.center,
                cellBuilder: (o) => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon:    const Icon(Icons.edit_outlined, size: 16),
                      tooltip: 'Edit',
                      color:   AppColors.onSurfaceMuted,
                      onPressed: () => onEdit(o),
                    ),
                    IconButton(
                      icon:    const Icon(Icons.delete_outline_rounded, size: 16),
                      tooltip: 'Delete',
                      color:   AppColors.error,
                      onPressed: () => onDelete(o),
                    ),
                  ],
                ),
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
  const _OrgAvatar({required this.name, this.imageUrl});
  final String  name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Image.network(
          imageUrl!,
          width:        34,
          height:       34,
          fit:          BoxFit.cover,
          errorBuilder: (_, __, ___) => _Initials(initial: initial),
        ),
      );
    }
    return _Initials(initial: initial);
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.initial});
  final String initial;

  @override
  Widget build(BuildContext context) {
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

// ── Org form body (create & edit) ─────────────────────────────────────────────

class _OrgFormBody extends StatefulWidget {
  const _OrgFormBody({
    required this.nameCtrl,
    required this.onImageChanged,
    this.existingImageUrl,
  });

  final TextEditingController                          nameCtrl;
  final void Function(Uint8List? bytes, String? name) onImageChanged;
  final String?                                        existingImageUrl;

  @override
  State<_OrgFormBody> createState() => _OrgFormBodyState();
}

class _OrgFormBodyState extends State<_OrgFormBody> {
  Uint8List? _imageBytes;
  bool       _picking = false;

  Future<void> _pickImage() async {
    if (_picking) return;
    setState(() => _picking = true);
    try {
      final file = await ImagePicker().pickImage(
        source:       ImageSource.gallery,
        imageQuality: 85,
        maxWidth:     512,
        maxHeight:    512,
      );
      if (file != null) {
        final bytes = await file.readAsBytes();
        setState(() => _imageBytes = bytes);
        widget.onImageChanged(bytes, file.name);
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  void _clearImage() {
    setState(() => _imageBytes = null);
    widget.onImageChanged(null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Organization Details'),
        const SizedBox(height: AppSpacing.sm),
        SheetField(
          label:      'Name',
          controller: widget.nameCtrl,
          hint:       'e.g. Acme Corp',
        ),
        const SizedBox(height: AppSpacing.lg),

        const SheetSection(title: 'Organization Image'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImagePickerBox(
              bytes:      _imageBytes,
              networkUrl: _imageBytes == null ? widget.existingImageUrl : null,
              picking:    _picking,
              onPick:     _pickImage,
              onClear:    _clearImage,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text('Optional', style: AppTextStyles.labelMd),
                  const SizedBox(height: 4),
                  Text(
                    'PNG, JPG or WebP.\nMax 5 MB.',
                    style: AppTextStyles.bodyXs,
                  ),
                  if (_imageBytes != null ||
                      widget.existingImageUrl != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    GestureDetector(
                      onTap: _clearImage,
                      child: Text(
                        'Remove image',
                        style: AppTextStyles.bodyXs.copyWith(
                          color:           AppColors.error,
                          decoration:      TextDecoration.underline,
                          decorationColor: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Image picker box ──────────────────────────────────────────────────────────

class _ImagePickerBox extends StatefulWidget {
  const _ImagePickerBox({
    required this.bytes,
    required this.picking,
    required this.onPick,
    required this.onClear,
    this.networkUrl,
  });

  final Uint8List?   bytes;
  final String?      networkUrl;
  final bool         picking;
  final VoidCallback onPick;
  final VoidCallback onClear;

  @override
  State<_ImagePickerBox> createState() => _ImagePickerBoxState();
}

class _ImagePickerBoxState extends State<_ImagePickerBox> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    const size     = 88.0;
    final hasLocal = widget.bytes != null;
    final hasNet   = widget.networkUrl != null && widget.networkUrl!.isNotEmpty;
    final hasImage = hasLocal || hasNet;

    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: hasImage ? null : widget.onPick,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width:  size,
              height: size,
              decoration: BoxDecoration(
                color: hasImage
                    ? Colors.transparent
                    : _hovered
                        ? AppColors.primary.withValues(alpha: 0.06)
                        : AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(
                  color: hasImage
                      ? AppColors.primary.withValues(alpha: 0.35)
                      : _hovered
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : AppColors.divider,
                ),
              ),
              child: hasLocal
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusLg - 1),
                      child: Image.memory(widget.bytes!, fit: BoxFit.cover),
                    )
                  : hasNet
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusLg - 1),
                          child: Image.network(
                            widget.networkUrl!,
                            fit:          BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image_outlined,
                                    color: AppColors.onSurfaceSubtle),
                          ),
                        )
                      : widget.picking
                          ? const Center(
                              child: SizedBox(
                                width:  22,
                                height: 22,
                                child:  CircularProgressIndicator(
                                    strokeWidth: 2),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_rounded,
                                  size:  26,
                                  color: _hovered
                                      ? AppColors.primary
                                      : AppColors.onSurfaceSubtle,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Upload',
                                  style: AppTextStyles.bodyXs.copyWith(
                                    color: _hovered
                                        ? AppColors.primary
                                        : AppColors.onSurfaceSubtle,
                                  ),
                                ),
                              ],
                            ),
            ),
            if (hasImage)
              Positioned(
                top:   -7,
                right: -7,
                child: GestureDetector(
                  onTap: widget.onClear,
                  child: Container(
                    width:  20,
                    height: 20,
                    decoration: BoxDecoration(
                      color:  AppColors.error,
                      shape:  BoxShape.circle,
                      border: Border.all(
                          color: AppColors.surfaceVariant, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size:  11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Page header ───────────────────────────────────────────────────────────────

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
