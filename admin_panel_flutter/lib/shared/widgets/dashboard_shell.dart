import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/theme.dart';
import '../../src/providers.dart';
import 'app_breadcrumb.dart';
import 'app_notification_bell.dart';
import 'responsive_helper.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NavItem definition
// ─────────────────────────────────────────────────────────────────────────────

/// A single entry in the dashboard navigation rail / drawer.
class NavItem {
  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;
}

// ─────────────────────────────────────────────────────────────────────────────
// DashboardShell
// ─────────────────────────────────────────────────────────────────────────────

/// Shared layout shell for all three role portals.
///
/// Renders a persistent top AppBar and a responsive side nav:
/// - `< 1024 px`  → hidden rail; hamburger opens a [Drawer]
/// - `1024–1279 px` → collapsed NavigationRail (icon-only, 72 px wide)
/// - `≥ 1280 px`  → expanded NavigationRail (full labels, 240 px wide)
class DashboardShell extends ConsumerStatefulWidget {
  const DashboardShell({
    super.key,
    required this.navItems,
    required this.child,
    required this.portalTitle,
    this.topBarActions,
  });

  final List<NavItem> navItems;
  final Widget child;

  /// The portal name shown in the breadcrumb (e.g. "Admin Portal").
  final String portalTitle;

  /// Optional widgets inserted in the top bar before the user chip
  /// (e.g. a notification bell).
  final List<Widget>? topBarActions;

  @override
  ConsumerState<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends ConsumerState<DashboardShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  NavItem? _activeItem(String location) {
    NavItem? best;
    for (final item in widget.navItems) {
      if (location.startsWith(item.route)) {
        if (best == null || item.route.length > best.route.length) {
          best = item;
        }
      }
    }
    return best;
  }

  List<BreadcrumbItem> _breadcrumbs(String location) {
    final active = _activeItem(location);
    return [
      BreadcrumbItem(label: widget.portalTitle),
      if (active != null) BreadcrumbItem(label: active.label),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final width = MediaQuery.sizeOf(context).width;
    final showFull = width >= AppSpacing.breakpointWide;
    final showRail = width >= AppSpacing.breakpointTablet;
    final isMobile = width < AppSpacing.breakpointMobile;
    final activeItem = _activeItem(location);

    // On mobile: show bottom nav bar with up to 4 items + "More" if needed.
    final showBottomNav = isMobile;
    final needsMore = widget.navItems.length > 5;
    final maxBottomItems = needsMore ? 4 : widget.navItems.length;
    final bottomItems = widget.navItems.take(maxBottomItems).toList();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: !showRail && (!showBottomNav || needsMore)
          ? _NavDrawer(
              navItems: widget.navItems,
              activeItem: activeItem,
              portalTitle: widget.portalTitle,
            )
          : null,
      appBar: _TopBar(
        scaffoldKey: _scaffoldKey,
        breadcrumbs: _breadcrumbs(location),
        showHamburger: !showRail && !showBottomNav,
        topBarActions: widget.topBarActions,
      ),
      body: Row(
        children: [
          if (showRail)
            _SideNav(
              navItems: widget.navItems,
              activeItem: activeItem,
              expanded: showFull,
            ),
          Expanded(child: widget.child),
        ],
      ),
      // ── Bottom Navigation Bar (mobile only) ──────────────────────────
      bottomNavigationBar: showBottomNav
          ? _MobileBottomNav(
              items:      bottomItems,
              allItems:   widget.navItems,
              activeItem: activeItem,
              showMore:   needsMore,
              scaffoldKey: _scaffoldKey,
            )
          : null,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile Bottom Navigation Bar
// ─────────────────────────────────────────────────────────────────────────────

class _MobileBottomNav extends StatelessWidget {
  const _MobileBottomNav({
    required this.items,
    required this.allItems,
    required this.activeItem,
    required this.showMore,
    required this.scaffoldKey,
  });

  final List<NavItem> items;
  final List<NavItem> allItems;
  final NavItem? activeItem;
  final bool showMore;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    // Determine the selected index
    int selectedIndex = -1;
    for (var i = 0; i < items.length; i++) {
      if (items[i] == activeItem) {
        selectedIndex = i;
        break;
      }
    }
    // If active item is in the "More" overflow, highlight the More tab
    if (selectedIndex == -1 && showMore) {
      selectedIndex = items.length; // the "More" slot
    }

    final safeIndex = selectedIndex.clamp(0, items.length + (showMore ? 0 : -1));

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                _BottomNavItem(
                  icon:       items[i].icon,
                  activeIcon: items[i].activeIcon,
                  label:      items[i].label,
                  isActive:   i == safeIndex,
                  onTap:      () => context.go(items[i].route),
                ),
              if (showMore)
                _BottomNavItem(
                  icon:       Icons.more_horiz_rounded,
                  activeIcon: Icons.more_horiz_rounded,
                  label:      'More',
                  isActive:   selectedIndex == items.length,
                  onTap:      () => scaffoldKey.currentState?.openDrawer(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single item in the mobile bottom navigation bar.
class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.onSurfaceMuted;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Active indicator bar
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width:  isActive ? 32 : 0,
              height: 3,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color:        isActive ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Icon(
              isActive ? activeIcon : icon,
              size:  22,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize:   10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color:      color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Top AppBar
// ─────────────────────────────────────────────────────────────────────────────

class _TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const _TopBar({
    required this.scaffoldKey,
    required this.breadcrumbs,
    required this.showHamburger,
    this.topBarActions,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final List<BreadcrumbItem> breadcrumbs;
  final bool showHamburger;
  final List<Widget>? topBarActions;

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.topBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final userName = auth.userInfo?.userName ?? '—';
    final role = auth.appUser?.role;
    final isMobile = context.isMobile;

    // Use a real AppBar so Flutter automatically handles status bar insets
    // (notch, Dynamic Island, Android status bar) on all platforms.
    return AppBar(
      toolbarHeight: AppSpacing.topBarHeight,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: isMobile ? AppSpacing.sm : AppSpacing.md,
      shape: const Border(
        bottom: BorderSide(color: AppColors.divider),
      ),
      title: Row(
        children: [
          // Hamburger (mobile) ──────────────────────────────────────────
          if (showHamburger)
            _TopBarIconButton(
              icon: Icons.menu_rounded,
              onTap: () => scaffoldKey.currentState?.openDrawer(),
            )
          else
            const SizedBox(width: AppSpacing.xs),

          // Breadcrumb ──────────────────────────────────────────────────
          Expanded(child: AppBreadcrumb(items: breadcrumbs)),

          // Top-bar actions (e.g. notification bell) ───────────────────
          if (topBarActions != null) ...[
            ...topBarActions!,
            const SizedBox(width: AppSpacing.sm),
            Container(width: 1, height: 20, color: AppColors.divider),
            const SizedBox(width: AppSpacing.sm),
          ],

          // User chip — compact on mobile (avatar only) ────────────────
          _UserChip(
            userName: userName,
            role: role,
            compact: isMobile,
            onLogout: () => ref.read(authProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }
}

// Simple icon button for top bar
class _TopBarIconButton extends StatefulWidget {
  const _TopBarIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  State<_TopBarIconButton> createState() => _TopBarIconButtonState();
}

class _TopBarIconButtonState extends State<_TopBarIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceVariant : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(
            widget.icon,
            size: 20,
            color: _hovered ? AppColors.onSurface : AppColors.onSurfaceMuted,
          ),
        ),
      ),
    );
  }
}

// User avatar chip with popup menu for logout
class _UserChip extends StatefulWidget {
  const _UserChip({
    required this.userName,
    required this.role,
    required this.onLogout,
    this.compact = false,
  });

  final String userName;
  final Role? role;
  final VoidCallback onLogout;

  /// When true, only the avatar circle is shown (mobile).
  final bool compact;

  @override
  State<_UserChip> createState() => _UserChipState();
}

class _UserChipState extends State<_UserChip> {
  bool _hovered = false;

  String get _initial =>
      widget.userName.isNotEmpty ? widget.userName[0].toUpperCase() : '?';

  String get _roleLabel => switch (widget.role) {
        Role.SuperAdmin => 'Super Admin',
        Role.OrganizationAdmin => 'Org Admin',
        Role.Manager => 'Manager',
        Role.User => 'User',
        null => '—',
      };

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: PopupMenuButton<String>(
        tooltip: '',
        offset: const Offset(0, 44),
        color: AppColors.surfaceVariant,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: const BorderSide(color: AppColors.divider),
        ),
        onSelected: (value) {
          if (value == 'logout') widget.onLogout();
        },
        itemBuilder: (_) => [
          PopupMenuItem(
            enabled: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userName, style: AppTextStyles.labelLg),
                const SizedBox(height: 2),
                Text(_roleLabel, style: AppTextStyles.labelMd),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: 'logout',
            child: Row(
              children: [
                const Icon(Icons.logout_rounded,
                    size: 16, color: AppColors.onSurfaceMuted),
                const SizedBox(width: 8),
                Text('Sign out', style: AppTextStyles.bodySm),
              ],
            ),
          ),
        ],
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 6 : 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.surfaceVariant : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar circle
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradientDiagonal,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Center(
                  child: Text(
                    _initial,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Hide name/role on compact (mobile) mode
              if (!widget.compact) ...[
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.userName, style: AppTextStyles.labelLg),
                    Text(_roleLabel, style: AppTextStyles.labelMd),
                  ],
                ),
              ],
              SizedBox(width: widget.compact ? 2 : 6),
              const Icon(
                Icons.expand_more_rounded,
                size: 16,
                color: AppColors.onSurfaceSubtle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Side Navigation Rail
// ─────────────────────────────────────────────────────────────────────────────

class _SideNav extends StatelessWidget {
  const _SideNav({
    required this.navItems,
    required this.activeItem,
    required this.expanded,
  });

  final List<NavItem> navItems;
  final NavItem? activeItem;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
      width:
          expanded ? AppSpacing.sidebarWidth : AppSpacing.sidebarCollapsedWidth,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        children: [
          // ── Logo area ──────────────────────────────────────────────────
          SizedBox(
            height: AppSpacing.topBarHeight,
            child: expanded ? _LogoBanner() : _LogoIcon(),
          ),
          const Divider(height: 1),

          // ── Nav items ──────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.sm,
              ),
              children: navItems.map((item) {
                return _NavTile(
                  item: item,
                  isActive: item == activeItem,
                  expanded: expanded,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width:  28,
            height: 28,
            fit:    BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text('FireSafeX', style: AppTextStyles.headingSm),
        ],
      ),
    );
  }
}

class _LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/logo.png',
        width:  28,
        height: 28,
        fit:    BoxFit.contain,
      ),
    );
  }
}

// Individual nav tile with hover + gradient active state
class _NavTile extends StatefulWidget {
  const _NavTile({
    required this.item,
    required this.isActive,
    required this.expanded,
  });

  final NavItem item;
  final bool isActive;
  final bool expanded;

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isActive;
    final expanded = widget.expanded;
    final iconColor = isActive
        ? Colors.white
        : _hovered
            ? AppColors.onSurface
            : AppColors.onSurfaceMuted;

    final tile = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            gradient: isActive ? AppColors.brandGradient : null,
            color: isActive ? null : (_hovered
                ? AppColors.surfaceVariant
                : Colors.transparent),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: expanded
              ? Row(
                  children: [
                    SizedBox(
                      width:
                          AppSpacing.sidebarCollapsedWidth - AppSpacing.sm * 2,
                      child: Icon(
                        isActive ? widget.item.activeIcon : widget.item.icon,
                        size: 20,
                        color: iconColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.item.label,
                        style: AppTextStyles.navLabel.copyWith(
                          color: iconColor,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Icon(
                    isActive ? widget.item.activeIcon : widget.item.icon,
                    size: 20,
                    color: iconColor,
                  ),
                ),
        ),
      ),
    );

    // Wrap with tooltip when collapsed
    if (!expanded) {
      return Tooltip(
        message: widget.item.label,
        preferBelow: false,
        verticalOffset: 0,
        waitDuration: const Duration(milliseconds: 400),
        child: tile,
      );
    }
    return tile;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile Drawer
// ─────────────────────────────────────────────────────────────────────────────

class _NavDrawer extends StatelessWidget {
  const _NavDrawer({
    required this.navItems,
    required this.activeItem,
    required this.portalTitle,
  });

  final List<NavItem> navItems;
  final NavItem? activeItem;
  final String portalTitle;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width:  28,
                    height: 28,
                    fit:    BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(portalTitle, style: AppTextStyles.headingSm),
                ],
              ),
            ),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),

            // Nav items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                ),
                children: navItems.map((item) {
                  final isActive = item == activeItem;
                  return _DrawerTile(
                    item: item,
                    isActive: isActive,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({required this.item, required this.isActive});
  final NavItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        selected: isActive,
        selectedTileColor: AppColors.primary.withValues(alpha: 0.15),
        leading: Icon(
          isActive ? item.activeIcon : item.icon,
          size: 20,
          color: isActive ? AppColors.primary : AppColors.onSurfaceMuted,
        ),
        title: Text(
          item.label,
          style: AppTextStyles.navLabel.copyWith(
            color: isActive ? AppColors.primary : AppColors.onSurface,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(); // close drawer
          context.go(item.route);
        },
      ),
    );
  }
}
