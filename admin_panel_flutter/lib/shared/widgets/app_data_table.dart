import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';
import 'app_skeleton_loader.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Column definition
// ─────────────────────────────────────────────────────────────────────────────

/// Defines a single column in [AppDataTable].
class AppTableColumn<T> {
  const AppTableColumn({
    required this.label,
    required this.cellBuilder,
    this.flex         = 1,
    this.sortKey,
    this.comparator,
    this.searchValue,
    this.minWidth,
    this.alignment    = Alignment.centerLeft,
  });

  final String              label;
  final Widget Function(T row) cellBuilder;
  final int                 flex;

  /// Key used to identify this column for sort-toggle tracking.
  final String?             sortKey;

  /// Optional comparator for sorting rows by this column.
  /// If omitted, clicking the sort header has no effect beyond toggling the icon.
  final int Function(T a, T b)? comparator;

  /// Extracts a searchable string from a row for the global filter bar.
  final String Function(T row)? searchValue;

  final double?             minWidth;
  final Alignment           alignment;
}

// ─────────────────────────────────────────────────────────────────────────────
// Main table widget
// ─────────────────────────────────────────────────────────────────────────────

/// Sortable data table with row-hover highlight and optional pagination.
///
/// ```dart
/// AppDataTable<Organization>(
///   columns: [
///     AppTableColumn(label: 'Name',    cellBuilder: (o) => Text(o.name)),
///     AppTableColumn(label: 'Manager', cellBuilder: (o) => Text(o.manager?.userInfo?.userName ?? '—')),
///   ],
///   rows:        orgs,
///   isLoading:   orgsAsync.isLoading,
/// )
/// ```
class AppDataTable<T> extends StatefulWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.isLoading     = false,
    this.emptyMessage  = 'No data yet.',
    this.pageSize      = 15,
    this.onRowTap,
    this.rowKey,
    this.searchable    = false,
  });

  final List<AppTableColumn<T>>  columns;
  final List<T>                  rows;
  final bool                     isLoading;
  final String                   emptyMessage;
  final int                      pageSize;
  final void Function(T row)?    onRowTap;

  /// Optional stable key for a row — used to preserve hover state on rebuild.
  final Object? Function(T row)? rowKey;

  /// When true, a search bar appears above the table header.
  /// Columns must have [AppTableColumn.searchValue] set to participate.
  final bool searchable;

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  String? _sortKey;
  bool    _sortAsc    = true;
  int     _page       = 0;
  String  _query      = '';

  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<T> get _filtered {
    if (_query.isEmpty) return widget.rows;
    final q = _query.toLowerCase();
    return widget.rows.where((row) {
      return widget.columns.any((col) {
        final val = col.searchValue?.call(row) ?? '';
        return val.toLowerCase().contains(q);
      });
    }).toList();
  }

  List<T> get _sorted {
    final base = _filtered;
    if (_sortKey == null) return base;
    final col = widget.columns.firstWhere(
      (c) => c.sortKey == _sortKey,
      orElse: () => widget.columns.first,
    );
    if (col.comparator == null) return base;
    final copy = List<T>.from(base);
    copy.sort((a, b) {
      final cmp = col.comparator!(a, b);
      return _sortAsc ? cmp : -cmp;
    });
    return copy;
  }

  List<T> get _paged {
    final all   = _sorted;
    final start = _page * widget.pageSize;
    final end   = (start + widget.pageSize).clamp(0, all.length);
    return start >= all.length ? [] : all.sublist(start, end);
  }

  int get _totalPages =>
      (_sorted.length / widget.pageSize).ceil().clamp(1, 9999);

  void _toggleSort(String key) {
    setState(() {
      if (_sortKey == key) {
        _sortAsc = !_sortAsc;
      } else {
        _sortKey = key;
        _sortAsc = true;
      }
      _page = 0;
    });
  }

  void _onSearch(String value) {
    setState(() {
      _query = value;
      _page  = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sorted = _sorted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Search bar (optional) ────────────────────────────────────────────
        if (widget.searchable) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
            child: TextField(
              controller: _searchCtrl,
              onChanged:  _onSearch,
              decoration: InputDecoration(
                hintText:    'Search…',
                prefixIcon:  const Icon(Icons.search_rounded, size: 18),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon:      const Icon(Icons.close_rounded, size: 16),
                        onPressed: () {
                          _searchCtrl.clear();
                          _onSearch('');
                        },
                      )
                    : null,
                isDense:     true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const Divider(height: 1),
        ],

        // ── Header row ──────────────────────────────────────────────────────
        _HeaderRow(
          columns:  widget.columns,
          sortKey:  _sortKey,
          sortAsc:  _sortAsc,
          onSort:   _toggleSort,
        ),
        const Divider(height: 1),

        // ── Body ────────────────────────────────────────────────────────────
        if (widget.isLoading)
          AppTableSkeleton(rows: widget.pageSize.clamp(3, 8))
        else if (sorted.isEmpty)
          _EmptyState(
            message: _query.isNotEmpty
                ? 'No results for "$_query".'
                : widget.emptyMessage,
          )
        else
          for (final row in _paged)
            _DataRow<T>(
              row:      row,
              columns:  widget.columns,
              onTap:    widget.onRowTap != null
                  ? () => widget.onRowTap!(row)
                  : null,
            ),

        // ── Pagination ──────────────────────────────────────────────────────
        if (!widget.isLoading && sorted.length > widget.pageSize)
          _PaginationBar(
            currentPage: _page,
            totalPages:  _totalPages,
            totalItems:  sorted.length,
            pageSize:    widget.pageSize,
            onPageChanged: (p) => setState(() => _page = p),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _HeaderRow<T> extends StatelessWidget {
  const _HeaderRow({
    required this.columns,
    required this.sortKey,
    required this.sortAsc,
    required this.onSort,
  });

  final List<AppTableColumn<T>> columns;
  final String?                 sortKey;
  final bool                    sortAsc;
  final void Function(String)   onSort;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceVariant,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical:   10,
      ),
      child: Row(
        children: columns.map((col) {
          final isSorted = sortKey == col.sortKey;

          return Expanded(
            flex: col.flex,
            child: GestureDetector(
              onTap: col.sortKey != null ? () => onSort(col.sortKey!) : null,
              child: MouseRegion(
                cursor: col.sortKey != null
                    ? SystemMouseCursors.click
                    : MouseCursor.defer,
                child: Row(
                  mainAxisAlignment: col.alignment.x > 0
                      ? MainAxisAlignment.end
                      : col.alignment.x < 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                  children: [
                    Text(
                      col.label.toUpperCase(),
                      style: AppTextStyles.labelSm.copyWith(
                        color: isSorted
                            ? AppColors.primary
                            : AppColors.onSurfaceSubtle,
                        letterSpacing: 0.6,
                      ),
                    ),
                    if (col.sortKey != null) ...[
                      const SizedBox(width: 4),
                      Icon(
                        isSorted
                            ? (sortAsc
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded)
                            : Icons.unfold_more_rounded,
                        size:  12,
                        color: isSorted
                            ? AppColors.primary
                            : AppColors.onSurfaceSubtle,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DataRow<T> extends StatefulWidget {
  const _DataRow({
    required this.row,
    required this.columns,
    this.onTap,
  });

  final T                       row;
  final List<AppTableColumn<T>> columns;
  final VoidCallback?           onTap;

  @override
  State<_DataRow<T>> createState() => _DataRowState<T>();
}

class _DataRowState<T> extends State<_DataRow<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor:  widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: _hovered
              ? AppColors.surfaceVariant
              : Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical:   12,
          ),
          child: Row(
            children: widget.columns.map((col) {
              return Expanded(
                flex: col.flex,
                child: Align(
                  alignment: col.alignment,
                  child: col.cellBuilder(widget.row),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_rounded,
              size:  40,
              color: AppColors.onSurfaceSubtle,
            ),
            const SizedBox(height: 12),
            Text(message, style: AppTextStyles.bodySm),
          ],
        ),
      ),
    );
  }
}

class _PaginationBar extends StatelessWidget {
  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.pageSize,
    required this.onPageChanged,
  });

  final int                    currentPage;
  final int                    totalPages;
  final int                    totalItems;
  final int                    pageSize;
  final void Function(int page) onPageChanged;

  @override
  Widget build(BuildContext context) {
    final start = currentPage * pageSize + 1;
    final end   = ((currentPage + 1) * pageSize).clamp(0, totalItems);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical:   10,
      ),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Text(
            '$start–$end of $totalItems',
            style: AppTextStyles.labelMd,
          ),
          const Spacer(),
          _PageButton(
            icon:     Icons.chevron_left_rounded,
            onTap:    currentPage > 0
                ? () => onPageChanged(currentPage - 1)
                : null,
          ),
          const SizedBox(width: 4),
          Text(
            '${currentPage + 1} / $totalPages',
            style: AppTextStyles.labelMd,
          ),
          const SizedBox(width: 4),
          _PageButton(
            icon:  Icons.chevron_right_rounded,
            onTap: currentPage < totalPages - 1
                ? () => onPageChanged(currentPage + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatefulWidget {
  const _PageButton({required this.icon, this.onTap});
  final IconData      icon;
  final VoidCallback? onTap;

  @override
  State<_PageButton> createState() => _PageButtonState();
}

class _PageButtonState extends State<_PageButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor:  enabled ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width:  30,
          height: 30,
          decoration: BoxDecoration(
            color: _hovered && enabled
                ? AppColors.surfaceVariant
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.divider),
          ),
          child: Icon(
            widget.icon,
            size:  16,
            color: enabled
                ? AppColors.onSurface
                : AppColors.onSurfaceSubtle,
          ),
        ),
      ),
    );
  }
}
