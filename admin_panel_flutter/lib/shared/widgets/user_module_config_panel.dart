import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/theme.dart';
import 'app_gradient_button.dart';
import 'app_status_chip.dart';

// ── Public state class (callers receive this on save) ─────────────────────────

class UserModuleState {
  UserModuleState({
    required this.moduleId,
    required this.isEnabled,
    this.deadline,
    this.status = ModuleProgressStatus.notStarted,
    this.startedAt,
    this.completedAt,
  });

  final String moduleId;
  bool isEnabled;
  DateTime? deadline;
  ModuleProgressStatus status;
  DateTime? startedAt;
  DateTime? completedAt;

  void applyRecord(UserModuleProgress r) {
    isEnabled   = r.isEnabled;
    deadline    = r.deadline;
    status      = r.status;
    startedAt   = r.startedAt;
    completedAt = r.completedAt;
  }
}

// ── Callbacks ─────────────────────────────────────────────────────────────────

typedef ProgressLoader = Future<List<UserModuleProgress>> Function(int userId);
typedef ProgressSaver  = Future<void> Function(int userId, List<UserModuleState> states);

// ── Constants ─────────────────────────────────────────────────────────────────

const _moduleIds = ['theory', 'aiExpert', 'smartTraining', 'assessment'];

const _moduleMeta = [
  (id: 'theory',        icon: Icons.menu_book_rounded,     color: AppColors.theory,   label: 'Theory'),
  (id: 'aiExpert',      icon: Icons.smart_toy_rounded,     color: AppColors.aiExpert, label: 'AR Expert'),
  (id: 'smartTraining', icon: Icons.fitness_center_rounded, color: AppColors.training, label: 'Smart Training'),
  (id: 'assessment',    icon: Icons.quiz_rounded,           color: AppColors.assess,   label: 'Assessment'),
];

// ── Panel ─────────────────────────────────────────────────────────────────────

class UserModuleConfigPanel extends ConsumerStatefulWidget {
  const UserModuleConfigPanel({
    super.key,
    required this.orgUsers,
    required this.globalEnabled,
    required this.onLoadProgress,
    required this.onSaveProgress,
  });

  /// All AppUser objects belonging to the target organization.
  final List<AppUser> orgUsers;

  /// Global module enabled state: moduleId → bool.
  final Map<String, bool> globalEnabled;

  /// Fetches per-user progress records from the correct endpoint.
  final ProgressLoader onLoadProgress;

  /// Persists all four module states for [userId].
  final ProgressSaver onSaveProgress;

  @override
  ConsumerState<UserModuleConfigPanel> createState() =>
      _UserModuleConfigPanelState();
}

class _UserModuleConfigPanelState
    extends ConsumerState<UserModuleConfigPanel> {
  final _searchCtrl = TextEditingController();

  AppUser?              _selectedUser;
  List<AppUser>         _filtered    = [];
  List<UserModuleState> _states      = [];
  bool                  _loading     = false;
  bool                  _saving      = false;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _filtered = widget.orgUsers;
    _searchCtrl.addListener(_onSearch);
  }

  @override
  void didUpdateWidget(UserModuleConfigPanel old) {
    super.didUpdateWidget(old);
    if (old.orgUsers != widget.orgUsers) {
      _applyFilter(_searchCtrl.text);
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  void _onSearch() => _applyFilter(_searchCtrl.text);

  void _applyFilter(String q) {
    final lower = q.toLowerCase();
    setState(() {
      _filtered = lower.isEmpty
          ? widget.orgUsers
          : widget.orgUsers.where((u) {
              final name  = (u.userInfo?.userName ?? '').toLowerCase();
              final email = (u.userInfo?.email ?? '').toLowerCase();
              return name.contains(lower) || email.contains(lower);
            }).toList();
    });
  }

  void _initStates() {
    _states = _moduleIds.map((id) => UserModuleState(
          moduleId:  id,
          isEnabled: widget.globalEnabled[id] ?? false,
        )).toList();
  }

  UserModuleState _stateFor(String id) =>
      _states.firstWhere((s) => s.moduleId == id);

  Future<void> _selectUser(AppUser user) async {
    setState(() {
      _selectedUser = user;
      _loading      = true;
    });
    _initStates();
    try {
      final records = await widget.onLoadProgress(user.id!);
      for (final r in records) {
        try {
          _stateFor(r.moduleId).applyRecord(r);
        } catch (_) {}
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (_selectedUser == null) return;
    setState(() => _saving = true);
    try {
      await widget.onSaveProgress(_selectedUser!.id!, _states);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User module configuration saved.')),
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
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickDeadline(UserModuleState state) async {
    final now  = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: state.deadline?.toLocal() ?? now,
      firstDate:   now.subtract(const Duration(days: 365)),
      lastDate:    now.add(const Duration(days: 365 * 5)),
    );
    if (date != null && mounted) {
      setState(() {
        state.deadline = DateTime(date.year, date.month, date.day, 23, 59, 59)
            .toUtc();
      });
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Row(
            children: [
              Container(
                width:  38,
                height: 38,
                decoration: BoxDecoration(
                  color:        AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(
                  Icons.manage_accounts_rounded,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Per-User Module Configuration',
                        style: AppTextStyles.headingSm),
                    Text(
                      'Override module access and set deadlines for individual users',
                      style: AppTextStyles.bodyXs,
                    ),
                  ],
                ),
              ),
              // User count badge
              if (widget.orgUsers.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color:        AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
                  ),
                  child: Text(
                    '${widget.orgUsers.length} '
                    '${widget.orgUsers.length == 1 ? 'user' : 'users'}',
                    style: AppTextStyles.labelSm
                        .copyWith(color: AppColors.onSurfaceMuted),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),

          // ── Body ────────────────────────────────────────────────────────
          if (widget.orgUsers.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Center(
                child: Text(
                  'No users in this organization yet.',
                  style: AppTextStyles.bodySm
                      .copyWith(color: AppColors.onSurfaceMuted),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final useSplit = constraints.maxWidth >= 680;
                if (useSplit) {
                  return _SplitLayout(
                    userList:    _buildUserList(),
                    configPanel: _buildConfigPanel(),
                  );
                }
                return _StackedLayout(
                  userList:    _buildUserList(),
                  configPanel: _buildConfigPanel(),
                );
              },
            ),
        ],
      ),
    );
  }

  // ── User list ────────────────────────────────────────────────────────────────

  Widget _buildUserList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        TextField(
          controller: _searchCtrl,
          style:      AppTextStyles.bodySm,
          decoration: InputDecoration(
            hintText:    'Search users…',
            prefixIcon:  const Icon(Icons.search_rounded, size: 16),
            suffixIcon:  _searchCtrl.text.isNotEmpty
                ? IconButton(
                    icon:       const Icon(Icons.close_rounded, size: 14),
                    onPressed:  () {
                      _searchCtrl.clear();
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // User count
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 6),
          child: Text(
            _filtered.isEmpty
                ? 'No results'
                : '${_filtered.length} of ${widget.orgUsers.length}',
            style: AppTextStyles.bodyXs
                .copyWith(color: AppColors.onSurfaceSubtle),
          ),
        ),

        // Scrollable list (max ~340px)
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 340),
          child: _filtered.isEmpty
              ? _EmptySearch(query: _searchCtrl.text)
              : ListView.separated(
                  shrinkWrap:    true,
                  itemCount:     _filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 2),
                  itemBuilder:   (_, i) {
                    final user     = _filtered[i];
                    final isActive = _selectedUser?.id == user.id;
                    return _UserTile(
                      user:     user,
                      isActive: isActive,
                      globalEnabled: widget.globalEnabled,
                      onTap:    () => _selectUser(user),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ── Config panel ─────────────────────────────────────────────────────────────

  Widget _buildConfigPanel() {
    if (_selectedUser == null) {
      return const _NoSelectionPlaceholder();
    }
    if (_loading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Selected user header
        Row(
          children: [
            _Avatar(user: _selectedUser!, size: 32),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedUser!.userInfo?.userName ?? '—',
                    style: AppTextStyles.labelMd,
                  ),
                  Text(
                    _selectedUser!.userInfo?.email ?? '',
                    style: AppTextStyles.bodyXs
                        .copyWith(color: AppColors.onSurfaceMuted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Table header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              const SizedBox(width: 34 + 10), // icon col
              Expanded(
                child: Text('MODULE',
                    style: AppTextStyles.labelSm
                        .copyWith(letterSpacing: 0.5,
                            color: AppColors.onSurfaceSubtle)),
              ),
              SizedBox(
                width: _kSwitchColW,
                child: Text('ENABLED',
                    style: AppTextStyles.labelSm
                        .copyWith(letterSpacing: 0.5,
                            color: AppColors.onSurfaceSubtle),
                    textAlign: TextAlign.center),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: _kDeadlineColW,
                child: Text('DEADLINE',
                    style: AppTextStyles.labelSm
                        .copyWith(letterSpacing: 0.5,
                            color: AppColors.onSurfaceSubtle)),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: _kStatusColW,
                child: Text('STATUS',
                    style: AppTextStyles.labelSm
                        .copyWith(letterSpacing: 0.5,
                            color: AppColors.onSurfaceSubtle)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Divider(height: 1),

        // Module rows
        ..._moduleMeta.map((meta) {
          final state       = _stateFor(meta.id);
          final globalVal   = widget.globalEnabled[meta.id] ?? false;
          final isOverride  = state.isEnabled != globalVal;
          return _ModuleRow(
            meta:        meta,
            state:       state,
            isOverride:  isOverride,
            onToggle:    (v) => setState(() => state.isEnabled = v),
            onDeadline:  () => _pickDeadline(state),
            onClearDeadline: () => setState(() => state.deadline = null),
            onStatus:    (s) => setState(() {
              state.status = s;
              if (s == ModuleProgressStatus.inProgress &&
                  state.startedAt == null) {
                state.startedAt = DateTime.now().toUtc();
              } else if (s == ModuleProgressStatus.completed &&
                  state.completedAt == null) {
                state.completedAt = DateTime.now().toUtc();
              } else if (s == ModuleProgressStatus.notStarted) {
                state.startedAt   = null;
                state.completedAt = null;
              }
            }),
          );
        }),

        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppGradientButton(
              label:     'Save User Config',
              icon:      Icons.save_rounded,
              isLoading: _saving,
              onPressed: _save,
            ),
          ],
        ),
      ],
    );
  }
}

// ── Column widths ─────────────────────────────────────────────────────────────

const _kSwitchColW  = 64.0;
const _kDeadlineColW = 148.0;
const _kStatusColW  = 136.0;

// ── Layout helpers ────────────────────────────────────────────────────────────

class _SplitLayout extends StatelessWidget {
  const _SplitLayout({required this.userList, required this.configPanel});
  final Widget userList;
  final Widget configPanel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Right border replaces the separate divider widget, so no
        // IntrinsicHeight (and no viewport intrinsic-dimension query) needed.
        Container(
          width: 252,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: AppColors.divider),
            ),
          ),
          padding: const EdgeInsets.only(right: AppSpacing.md),
          child: userList,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: configPanel),
      ],
    );
  }
}

class _StackedLayout extends StatelessWidget {
  const _StackedLayout({required this.userList, required this.configPanel});
  final Widget userList;
  final Widget configPanel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userList,
        const SizedBox(height: AppSpacing.lg),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.lg),
        configPanel,
      ],
    );
  }
}

// ── User list tile ────────────────────────────────────────────────────────────

class _UserTile extends StatefulWidget {
  const _UserTile({
    required this.user,
    required this.isActive,
    required this.globalEnabled,
    required this.onTap,
  });

  final AppUser          user;
  final bool             isActive;
  final Map<String, bool> globalEnabled;
  final VoidCallback     onTap;

  @override
  State<_UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<_UserTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final name  = widget.user.userInfo?.userName ?? '—';
    final email = widget.user.userInfo?.email    ?? '';

    // Count enabled modules for this user (using global as proxy since we
    // haven't loaded per-user overrides for non-selected users).
    final enabledCount = widget.globalEnabled.values
        .where((v) => v)
        .length;

    return MouseRegion(
      cursor:  SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withValues(alpha: 0.08)
                : _hovered
                    ? AppColors.surfaceVariant
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: widget.isActive
                ? Border.all(
                    color: AppColors.primary.withValues(alpha: 0.25))
                : Border.all(color: Colors.transparent),
          ),
          child: Row(
            children: [
              _Avatar(user: widget.user, size: 34, active: widget.isActive),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.labelMd.copyWith(
                        color: widget.isActive
                            ? AppColors.primary
                            : AppColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      email,
                      style: AppTextStyles.bodyXs.copyWith(
                        color: AppColors.onSurfaceMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Mini module dots
              _ModuleDots(enabledCount: enabledCount),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Mini module dots ──────────────────────────────────────────────────────────

class _ModuleDots extends StatelessWidget {
  const _ModuleDots({required this.enabledCount});
  final int enabledCount;

  static const _colors = [
    AppColors.theory,
    AppColors.aiExpert,
    AppColors.training,
    AppColors.assess,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (i) {
        final enabled = i < enabledCount;
        return Container(
          width:  6,
          height: 6,
          margin: const EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled
                ? _colors[i]
                : AppColors.divider,
          ),
        );
      }),
    );
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.user, required this.size, this.active = false});
  final AppUser user;
  final double  size;
  final bool    active;

  static const _palette = [
    Color(0xFF2563EB), Color(0xFF7C3AED), Color(0xFFD97706),
    Color(0xFF16A34A), Color(0xFFDC2626), Color(0xFF0891B2),
  ];

  @override
  Widget build(BuildContext context) {
    final name    = user.userInfo?.userName ?? '?';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final color   = _palette[(name.codeUnitAt(0)) % _palette.length];

    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color:        active
            ? AppColors.primary.withValues(alpha: 0.15)
            : color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Center(
        child: Text(
          initial,
          style: AppTextStyles.labelMd.copyWith(
            color:      active ? AppColors.primary : color,
            fontSize:   size * 0.4,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ── Compact module row ────────────────────────────────────────────────────────

class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.meta,
    required this.state,
    required this.isOverride,
    required this.onToggle,
    required this.onDeadline,
    required this.onClearDeadline,
    required this.onStatus,
  });

  final ({String id, IconData icon, Color color, String label}) meta;
  final UserModuleState                    state;
  final bool                               isOverride;
  final ValueChanged<bool>                 onToggle;
  final VoidCallback                       onDeadline;
  final VoidCallback                       onClearDeadline;
  final ValueChanged<ModuleProgressStatus> onStatus;

  static final _dateFmt = DateFormat('MMM d, y');

  @override
  Widget build(BuildContext context) {
    final enabled = state.isEnabled;
    final color   = enabled ? meta.color : AppColors.onSurfaceSubtle;
    final dim     = !enabled;

    return Container(
      margin: const EdgeInsets.only(top: 1),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.divider, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Module icon ─────────────────────────────────────────────
          Container(
            width:  34,
            height: 34,
            decoration: BoxDecoration(
              color: enabled
                  ? meta.color.withValues(alpha: 0.12)
                  : AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Icon(meta.icon, size: 15, color: color),
          ),
          const SizedBox(width: 10),

          // ── Module name + override badge ─────────────────────────────
          Expanded(
            child: Row(
              children: [
                Text(
                  meta.label,
                  style: AppTextStyles.labelMd.copyWith(
                    color: enabled
                        ? AppColors.onSurface
                        : AppColors.onSurfaceMuted,
                  ),
                ),
                if (isOverride) ...[
                  const SizedBox(width: 6),
                  AppStatusChip(
                    label:   'Override',
                    variant: AppChipVariant.primary,
                    small:   true,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),

          // ── Enabled toggle ───────────────────────────────────────────
          SizedBox(
            width: _kSwitchColW,
            child: Center(
              child: Transform.scale(
                scale: 0.85,
                child: Switch(
                  value:            enabled,
                  onChanged:        onToggle,
                  activeThumbColor: meta.color,
                  activeTrackColor: meta.color.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // ── Deadline ─────────────────────────────────────────────────
          SizedBox(
            width: _kDeadlineColW,
            child: Opacity(
              opacity: dim ? 0.38 : 1.0,
              child: _DeadlineCell(
                deadline:   state.deadline,
                onTap:      dim ? null : onDeadline,
                onClear:    dim ? null : onClearDeadline,
                dateFmt:    _dateFmt,
              ),
            ),
          ),
          const SizedBox(width: 8),

          // ── Status ───────────────────────────────────────────────────
          SizedBox(
            width: _kStatusColW,
            child: Opacity(
              opacity: dim ? 0.38 : 1.0,
              child: _StatusDropdown(
                value:     state.status,
                enabled:   !dim,
                onChanged: onStatus,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Deadline cell ─────────────────────────────────────────────────────────────

class _DeadlineCell extends StatefulWidget {
  const _DeadlineCell({
    required this.deadline,
    required this.onTap,
    required this.onClear,
    required this.dateFmt,
  });

  final DateTime?        deadline;
  final VoidCallback?    onTap;
  final VoidCallback?    onClear;
  final DateFormat       dateFmt;

  @override
  State<_DeadlineCell> createState() => _DeadlineCellState();
}

class _DeadlineCellState extends State<_DeadlineCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final hasDate = widget.deadline != null;

    return MouseRegion(
      cursor:  widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered && widget.onTap != null
                ? AppColors.surfaceVariant
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: hasDate ? AppColors.divider : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_rounded,
                size:  13,
                color: hasDate
                    ? AppColors.onSurfaceMuted
                    : AppColors.onSurfaceSubtle,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  hasDate
                      ? widget.dateFmt.format(widget.deadline!.toLocal())
                      : '—',
                  style: AppTextStyles.bodyXs.copyWith(
                    color: hasDate
                        ? AppColors.onSurface
                        : AppColors.onSurfaceSubtle,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasDate && widget.onClear != null) ...[
                const SizedBox(width: 2),
                GestureDetector(
                  onTap: widget.onClear,
                  child: const Icon(
                    Icons.close_rounded,
                    size:  11,
                    color: AppColors.onSurfaceSubtle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Status dropdown ───────────────────────────────────────────────────────────

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final ModuleProgressStatus             value;
  final bool                             enabled;
  final ValueChanged<ModuleProgressStatus> onChanged;

  static AppChipVariant _variant(ModuleProgressStatus s) => switch (s) {
    ModuleProgressStatus.notStarted => AppChipVariant.neutral,
    ModuleProgressStatus.inProgress => AppChipVariant.warning,
    ModuleProgressStatus.completed  => AppChipVariant.success,
  };

  static String _label(ModuleProgressStatus s) => switch (s) {
    ModuleProgressStatus.notStarted => 'Not Started',
    ModuleProgressStatus.inProgress => 'In Progress',
    ModuleProgressStatus.completed  => 'Completed',
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<ModuleProgressStatus>(
        value:        value,
        isDense:      true,
        isExpanded:   true,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        icon:  Icon(
          Icons.expand_more_rounded,
          size:  16,
          color: enabled
              ? AppColors.onSurfaceMuted
              : AppColors.onSurfaceSubtle,
        ),
        selectedItemBuilder: (_) => ModuleProgressStatus.values.map((s) {
          return Align(
            alignment: Alignment.centerLeft,
            child: AppStatusChip(
              label:   _label(s),
              variant: _variant(s),
              small:   true,
            ),
          );
        }).toList(),
        items: ModuleProgressStatus.values.map((s) {
          return DropdownMenuItem(
            value: s,
            child: AppStatusChip(
              label:   _label(s),
              variant: _variant(s),
              small:   true,
            ),
          );
        }).toList(),
        onChanged: enabled ? (v) { if (v != null) onChanged(v); } : null,
      ),
    );
  }
}

// ── Placeholders ──────────────────────────────────────────────────────────────

class _NoSelectionPlaceholder extends StatelessWidget {
  const _NoSelectionPlaceholder();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width:  56,
              height: 56,
              decoration: BoxDecoration(
                color:        AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              ),
              child: const Icon(Icons.person_search_rounded,
                  size: 26, color: AppColors.onSurfaceSubtle),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Select a user', style: AppTextStyles.headingSm),
            const SizedBox(height: 4),
            Text(
              'Choose a user from the list to configure their module access.',
              style:     AppTextStyles.bodyXs,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptySearch extends StatelessWidget {
  const _EmptySearch({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded,
                size: 28, color: AppColors.onSurfaceSubtle),
            const SizedBox(height: 8),
            Text(
              'No users match "$query"',
              style: AppTextStyles.bodyXs
                  .copyWith(color: AppColors.onSurfaceMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
