import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme.dart';
import '../../shared/widgets/app_gradient_button.dart';
import '../providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool   _loading     = false;
  bool   _obscure     = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Email and password are required.');
      return;
    }
    setState(() { _loading = true; _error = null; });
    final success = await ref.read(authProvider.notifier).login(email, password);
    if (!mounted) return;
    if (!success) {
      setState(() {
        _error   = 'Invalid email or password.';
        _loading = false;
      });
    }
    // On success GoRouter redirect handles navigation automatically.
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // ── Left branding panel ─────────────────────────────────────────
          if (isWide)
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradientDiagonal,
                ),
                child: Stack(
                  children: [
                    // Background pattern
                    Positioned.fill(
                      child: CustomPaint(painter: _GridPainter()),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(48),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          Row(
                            children: [
                              Container(
                                width: 48, height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusLg),
                                ),
                                child: const Icon(
                                  Icons.bolt_rounded,
                                  size:  28,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'FireSafeX Admin',
                                style: TextStyle(
                                  fontSize:   22,
                                  fontWeight: FontWeight.w700,
                                  color:      Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 64),

                          // Headline
                          Text(
                            'Manage your\norganization\nwith confidence.',
                            style: const TextStyle(
                              fontSize:   40,
                              fontWeight: FontWeight.w800,
                              color:      Colors.white,
                              height:     1.15,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'One platform for teams, content, training\nand AI-powered expertise.',
                            style: TextStyle(
                              fontSize: 16,
                              color:    Colors.white.withValues(alpha: 0.8),
                              height:   1.5,
                            ),
                          ),
                          const SizedBox(height: 48),

                          // Feature pills
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: const [
                              _Pill('Theory Modules'),
                              _Pill('Smart Training'),
                              _Pill('AR Expert AI'),
                              _Pill('Assessments'),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Footer
                    Positioned(
                      bottom: 24,
                      left:   48,
                      child: Text(
                        '© 2026 Mako IT Lab. All rights reserved.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // ── Right login form ─────────────────────────────────────────────
          Expanded(
            flex: isWide ? 2 : 1,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo (mobile only)
                      if (!isWide) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShaderMask(
                              blendMode:    BlendMode.srcIn,
                              shaderCallback: (b) =>
                                  AppColors.brandGradient.createShader(b),
                              child: const Icon(
                                Icons.bolt_rounded,
                                size:  32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('FireSafeX Admin', style: AppTextStyles.headingMd),
                          ],
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Heading
                      Text('Sign in', style: AppTextStyles.headingLg),
                      const SizedBox(height: 4),
                      Text(
                        'Enter your credentials to access your portal.',
                        style: AppTextStyles.bodySm,
                      ),
                      const SizedBox(height: 32),

                      // Email
                      _Label('Email'),
                      const SizedBox(height: 6),
                      TextField(
                        controller:   _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText:   'you@example.com',
                          prefixIcon: Icon(Icons.email_outlined, size: 18),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password
                      _Label('Password'),
                      const SizedBox(height: 6),
                      StatefulBuilder(
                        builder: (_, localSet) => TextField(
                          controller:  _passwordCtrl,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submit(),
                          decoration: InputDecoration(
                            hintText:   '••••••••',
                            prefixIcon: const Icon(
                                Icons.lock_outline_rounded, size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 18,
                              ),
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                      ),

                      // Error
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.errorSurface,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                            border: Border.all(
                                color: AppColors.error.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline_rounded,
                                  size: 16, color: AppColors.error),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: AppTextStyles.bodyXs
                                      .copyWith(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Submit button
                      AppGradientButton(
                        label:     'Sign In',
                        icon:      Icons.login_rounded,
                        onPressed: _submit,
                        isLoading: _loading,
                        width:     double.infinity,
                        height:    48,
                      ),

                      const SizedBox(height: 32),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Container(height: 1,
                                color: AppColors.divider),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text('Secured by Mako',
                                style: AppTextStyles.labelSm),
                          ),
                          Expanded(
                            child: Container(height: 1,
                                color: AppColors.divider),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTextStyles.labelMd);
}

class _Pill extends StatelessWidget {
  const _Pill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color:        Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppSpacing.radiusChip),
        border:       Border.all(
            color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize:   13,
          fontWeight: FontWeight.w500,
          color:      Colors.white,
        ),
      ),
    );
  }
}

// Subtle dot-grid background for the left panel
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color  = Colors.white.withValues(alpha: 0.07)
      ..strokeWidth = 1;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
