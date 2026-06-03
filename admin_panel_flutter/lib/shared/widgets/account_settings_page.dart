import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/localization/locale_providers.dart';
import '../../core/theme/theme.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../src/providers.dart';
import 'app_side_sheet.dart';
import 'widgets.dart';

/// Shared settings page used by Admin, Manager, and User portals.
/// Shows account info, change-password action, and sign-out.
class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t        = AppLocalizations.of(context);
    final auth     = ref.watch(authProvider);
    final userInfo = auth.userInfo;
    final appUser  = auth.appUser;
    final initial  = (userInfo?.userName ?? '?')[0].toUpperCase();

    return SingleChildScrollView(
      padding: EdgeInsets.all(context.responsivePagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Text(t.settingsPageTitle, style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text(t.settingsPageSubtitle,
              style: AppTextStyles.bodySm),
          const SizedBox(height: AppSpacing.lg),

          // ── Account card ───────────────────────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(
                  icon:     Icons.person_rounded,
                  color:    AppColors.primary,
                  title:    t.settingsAccountTitle,
                  subtitle: t.settingsAccountSubtitle,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    // Avatar
                    Container(
                      width:  56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient:     AppColors.brandGradientDiagonal,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusXl),
                      ),
                      child: Center(
                        child: Text(
                          initial,
                          style: const TextStyle(
                            fontSize:   22,
                            fontWeight: FontWeight.w700,
                            color:      Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userInfo?.userName ?? t.emDash,
                            style: AppTextStyles.headingMd,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            userInfo?.email ?? t.emDash,
                            style: AppTextStyles.bodySm,
                          ),
                        ],
                      ),
                    ),
                    _RolePill(role: _localizedRoleName(t, appUser?.role)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Security card ──────────────────────────────────────────────
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(
                  icon:     Icons.lock_rounded,
                  color:    AppColors.info,
                  title:    t.settingsSecurityTitle,
                  subtitle: t.settingsSecuritySubtitle,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.settingsSecurityPasswordLabel,
                              style: AppTextStyles.labelMd),
                          const SizedBox(height: 2),
                          Text(
                            t.settingsSecurityPasswordDesc,
                            style: AppTextStyles.bodyXs,
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      icon:     const Icon(Icons.lock_outline_rounded,
                          size: 15),
                      label:    Text(t.settingsSecurityChangeBtn),
                      onPressed: () =>
                          _showChangePasswordSheet(context, ref),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Locale card ────────────────────────────────────────────────
          // Language & Region is a per-end-user preference — only the User
          // role sees content rendered through the locale chain. Admin /
          // OrgAdmin / Manager roles author content rather than consume it
          // here, so their settings page hides this card.
          if (appUser?.role == Role.User) ...[
            _LocaleCard(),
            const SizedBox(height: AppSpacing.md),
          ],

          // ── Danger zone ────────────────────────────────────────────────
          Container(
            padding: const EdgeInsetsDirectional.all(AppSpacing.cardPadding),
            decoration: BoxDecoration(
              color:        AppColors.errorSurface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              border:
                  Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.logout_rounded,
                    size: 20, color: AppColors.error),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.settingsSignOutTitle,
                          style: AppTextStyles.labelLg
                              .copyWith(color: AppColors.error)),
                      const SizedBox(height: 2),
                      Text(t.settingsSignOutDesc,
                          style: AppTextStyles.bodyXs),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () =>
                      ref.read(authProvider.notifier).logout(),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                  ),
                  child: Text(t.settingsSignOutBtn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordSheet(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final currentCtrl = TextEditingController();
    final newCtrl     = TextEditingController();
    final confirmCtrl = TextEditingController();

    AppSideSheet.show(
      context:   context,
      title:     t.settingsSecurityChangeBtn,
      saveLabel: t.settingsSecurityUpdateBtn,
      body: _ChangePasswordBody(
        currentCtrl: currentCtrl,
        newCtrl:     newCtrl,
        confirmCtrl: confirmCtrl,
      ),
      onSave: () async {
        final current = currentCtrl.text;
        final next    = newCtrl.text;
        final confirm = confirmCtrl.text;

        if (current.isEmpty || next.isEmpty || confirm.isEmpty) {
          throw Exception(t.settingsSecurityErrAllRequired);
        }
        if (next.length < 6) {
          throw Exception(t.settingsSecurityErrMinLength);
        }
        if (next != confirm) {
          throw Exception(t.settingsSecurityErrMismatch);
        }

        final success = await ref
            .read(clientProvider)
            .user
            .changePassword(current, next);

        if (!success) {
          throw Exception(t.settingsSecurityErrCurrentWrong);
        }

        // Sign out so the user re-authenticates with their new password.
        await ref.read(authProvider.notifier).logout();
      },
    );
  }

  String _localizedRoleName(AppLocalizations t, Role? role) => switch (role) {
        Role.SuperAdmin => t.roleSuperAdmin,
        Role.OrganizationAdmin => t.roleOrgAdmin,
        Role.Manager => t.roleManager,
        Role.User => t.roleUser,
        null => t.emDash,
      };
}

// ── Change password form body ──────────────────────────────────────────────────

class _ChangePasswordBody extends StatefulWidget {
  const _ChangePasswordBody({
    required this.currentCtrl,
    required this.newCtrl,
    required this.confirmCtrl,
  });

  final TextEditingController currentCtrl;
  final TextEditingController newCtrl;
  final TextEditingController confirmCtrl;

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  bool _obscureCurrent = true;
  bool _obscureNew     = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SheetSection(title: t.settingsSecurityCurrentPassword),
        const SizedBox(height: AppSpacing.sm),
        _PasswordField(
          controller: widget.currentCtrl,
          label:      t.settingsSecurityCurrentPassword,
          hint:       '••••••••',
          obscure:    _obscureCurrent,
          onToggle:   () =>
              setState(() => _obscureCurrent = !_obscureCurrent),
        ),
        const SizedBox(height: AppSpacing.lg),
        SheetSection(title: t.settingsSecurityNewPassword),
        const SizedBox(height: AppSpacing.sm),
        _PasswordField(
          controller: widget.newCtrl,
          label:      t.settingsSecurityNewPassword,
          hint:       '••••••••',
          obscure:    _obscureNew,
          onToggle:   () => setState(() => _obscureNew = !_obscureNew),
        ),
        const SizedBox(height: AppSpacing.md),
        _PasswordField(
          controller: widget.confirmCtrl,
          label:      t.settingsSecurityConfirmPassword,
          hint:       '••••••••',
          obscure:    _obscureConfirm,
          onToggle:   () =>
              setState(() => _obscureConfirm = !_obscureConfirm),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Password requirements hint
        Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          decoration: BoxDecoration(
            color:        AppColors.info.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border:
                Border.all(color: AppColors.info.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded,
                  size: 15, color: AppColors.info),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  t.settingsSecurityPasswordHint,
                  style: AppTextStyles.bodyXs
                      .copyWith(color: AppColors.info),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.obscure,
    required this.onToggle,
  });

  final TextEditingController controller;
  final String                label;
  final String                hint;
  final bool                  obscure;
  final VoidCallback          onToggle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:   controller,
      obscureText:  obscure,
      decoration: InputDecoration(
        labelText: label,
        hintText:  hint,
        suffixIcon: IconButton(
          icon: Icon(
            obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 18,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}

// ── Shared sub-widgets ────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color:        AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border:       Border.all(color: AppColors.divider),
      ),
      child: child,
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color    color;
  final String   title;
  final String   subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width:  38,
          height: 38,
          decoration: BoxDecoration(
            color:        color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,    style: AppTextStyles.headingSm),
              Text(subtitle, style: AppTextStyles.bodyXs),
            ],
          ),
        ),
      ],
    );
  }
}

class _RolePill extends StatelessWidget {
  const _RolePill({required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        gradient:     AppColors.brandGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
      ),
      child: Text(
        role,
        style: const TextStyle(
          fontSize:   11,
          fontWeight: FontWeight.w700,
          color:      Colors.white,
        ),
      ),
    );
  }
}

class _LocaleCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final localesAsync = ref.watch(supportedLocalesProvider);
    final current = ref.watch(currentLocaleProvider);

    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardHeader(
            icon:     Icons.language_rounded,
            color:    AppColors.success,
            title:    t.settingsLocaleTitle,
            subtitle: t.settingsLocaleSubtitle,
          ),
          const SizedBox(height: AppSpacing.md),
          localesAsync.when(
            loading: () => const AppSkeletonBox(height: 48),
            error: (e, _) => Text(t.settingsLocaleLoadFailed(e.toString()),
                style: AppTextStyles.bodySm),
            data: (locales) {
              if (locales.isEmpty) {
                return Text(
                  t.settingsLocaleEmpty,
                  style: AppTextStyles.bodySm,
                );
              }
              final values = locales.map((l) => l.localeKey).toSet();
              final selected = values.contains(current) ? current : null;
              return Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(t.settingsLocaleLabel,
                            style: AppTextStyles.labelMd),
                        const SizedBox(height: 2),
                        Text(
                          t.settingsLocaleDesc,
                          style: AppTextStyles.bodyXs,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    child: DropdownButtonFormField<String>(
                      value: selected,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                      ),
                      items: locales
                          .map((l) => DropdownMenuItem(
                                value: l.localeKey,
                                child: Text(
                                  '${l.localeKey} — ${l.displayName}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (v) async {
                        if (v == null) return;
                        try {
                          await ref
                              .read(currentLocaleProvider.notifier)
                              .set(v);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(t.commonError(e.toString())),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
