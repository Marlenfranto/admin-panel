import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../../src/providers.dart';
import 'app_side_sheet.dart';
import 'widgets.dart';

/// Shared settings page used by Admin, Manager, and User portals.
/// Shows account info, change-password action, and sign-out.
class AccountSettingsPage extends ConsumerWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth     = ref.watch(authProvider);
    final userInfo = auth.userInfo;
    final appUser  = auth.appUser;
    final initial  = (userInfo?.userName ?? '?')[0].toUpperCase();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────────────
          Text('Settings', style: AppTextStyles.headingLg),
          const SizedBox(height: 4),
          Text('Account details and security settings.',
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
                  title:    'Account',
                  subtitle: 'Your profile information',
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
                            userInfo?.userName ?? '—',
                            style: AppTextStyles.headingMd,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            userInfo?.email ?? '—',
                            style: AppTextStyles.bodySm,
                          ),
                        ],
                      ),
                    ),
                    _RolePill(role: appUser?.role.name ?? '—'),
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
                  title:    'Security',
                  subtitle: 'Manage your password',
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Password',
                              style: AppTextStyles.labelMd),
                          const SizedBox(height: 2),
                          Text(
                            'Change your account password.',
                            style: AppTextStyles.bodyXs,
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      icon:     const Icon(Icons.lock_outline_rounded,
                          size: 15),
                      label:    const Text('Change Password'),
                      onPressed: () =>
                          _showChangePasswordSheet(context, ref),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Danger zone ────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
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
                      Text('Sign Out',
                          style: AppTextStyles.labelLg
                              .copyWith(color: AppColors.error)),
                      const SizedBox(height: 2),
                      Text('Sign out of your account on this device.',
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
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordSheet(BuildContext context, WidgetRef ref) {
    final currentCtrl = TextEditingController();
    final newCtrl     = TextEditingController();
    final confirmCtrl = TextEditingController();

    AppSideSheet.show(
      context:   context,
      title:     'Change Password',
      saveLabel: 'Update Password',
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
          throw Exception('All fields are required.');
        }
        if (next.length < 6) {
          throw Exception('New password must be at least 6 characters.');
        }
        if (next != confirm) {
          throw Exception('Passwords do not match.');
        }

        final success = await ref
            .read(clientProvider)
            .user
            .changePassword(current, next);

        if (!success) {
          throw Exception('Current password is incorrect.');
        }

        // Sign out so the user re-authenticates with their new password.
        await ref.read(authProvider.notifier).logout();
      },
    );
  }
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SheetSection(title: 'Current Password'),
        const SizedBox(height: AppSpacing.sm),
        _PasswordField(
          controller: widget.currentCtrl,
          label:      'Current Password',
          hint:       '••••••••',
          obscure:    _obscureCurrent,
          onToggle:   () =>
              setState(() => _obscureCurrent = !_obscureCurrent),
        ),
        const SizedBox(height: AppSpacing.lg),
        const SheetSection(title: 'New Password'),
        const SizedBox(height: AppSpacing.sm),
        _PasswordField(
          controller: widget.newCtrl,
          label:      'New Password',
          hint:       '••••••••',
          obscure:    _obscureNew,
          onToggle:   () => setState(() => _obscureNew = !_obscureNew),
        ),
        const SizedBox(height: AppSpacing.md),
        _PasswordField(
          controller: widget.confirmCtrl,
          label:      'Confirm New Password',
          hint:       '••••••••',
          obscure:    _obscureConfirm,
          onToggle:   () =>
              setState(() => _obscureConfirm = !_obscureConfirm),
        ),
        const SizedBox(height: AppSpacing.lg),
        // Password requirements hint
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
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
                  'Password must be at least 6 characters.',
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
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
