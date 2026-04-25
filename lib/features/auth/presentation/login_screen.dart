import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/fit_scaffold.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/ambient_glow_blobs.dart';
import '../domain/auth_providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError(
        'Please enter your email and password / कृपया अपना ईमेल और पासवर्ड डालें',
      );
      return;
    }

    try {
      await ref.read(authStateProvider.notifier).login(email, password);
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _handleForgotPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError(
        'Please enter your email first / कृपया पहले अपना ईमेल दर्ज करें',
      );
      return;
    }

    try {
      await ref.read(authStateProvider.notifier).forgotPassword(email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Reset link sent to your email! / रीसेट लिंक आपके ईमेल पर भेज दिया गया है!',
            ),
             backgroundColor: AppColorsDark.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
         backgroundColor: AppColorsDark.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      heroHeight: 300,
      heroBackground: Container(
         decoration: const BoxDecoration(gradient: AppGradients.heroPrimary),
        child: const AmbientGlowBlobs(),
      ),
      heroContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shield_outlined, size: 80, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            'FITKARMA',
             style: AppTypography.displayLg(
              context,
            ).copyWith(color: Colors.white, letterSpacing: 4),
          ),
          Text(
            'फिटकर्मा',
             style: AppTypography.hindi(context).copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 18,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text('Welcome back', style: AppTypography.displayMd(context)),
           Text(
             'पुनः आपका स्वागत है',
             style: AppTypography.hindi(
               context,
             ).copyWith(color: AppColorsDark.textSecondary, fontSize: 16),
           ),
          const SizedBox(height: 32),

          GlassCard(
            child: Column(
               children: [
                 TextField(
                   controller: _emailController,
                   keyboardType: TextInputType.emailAddress,
                   style: AppTypography.bodyMd(context),
                   decoration: InputDecoration(
                     labelText: 'Email Address / ईमेल',
                     labelStyle: AppTypography.labelMd(context),
                     prefixIcon: const Icon(Icons.alternate_email, size: 20),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(AppRadius.md),
                     ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                   style: AppTypography.bodyMd(context),
                  decoration: InputDecoration(
                    labelText: 'Password / पासवर्ड',
                     labelStyle: AppTypography.labelMd(context),
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                      ),
                       onPressed: () =>
                           setState(() => _obscurePassword = !_obscurePassword),
                     ),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(AppRadius.md),
                     ),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _handleForgotPassword,
                    child: Text(
                      'Forgot Password?',
                       style: AppTypography.labelMd(
                        context,
                       ).copyWith(color: AppColorsDark.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColorsDark.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    child: authState.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'LOGIN / लॉग इन करें',
                             style: AppTypography.labelLg(context),
                          ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Text('OR', style: AppTypography.caption(context)),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 32),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple, size: 24),
                  label: const Text('Apple'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 48),
          Center(
            child: TextButton(
              onPressed: () => context.push('/register'),
              child: RichText(
                text: TextSpan(
                  text: "New here? ",
                  style: AppTheme.bodyMd(
                    context,
                  ).copyWith(color: AppTheme.textSecondary),
                  children: [
                    TextSpan(
                      text: "Create Account",
                      style: AppTheme.bodyMd(context).copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
