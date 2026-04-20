import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/app_theme.dart';
import '../../../shared/widgets/fit_scaffold.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/ambient_glow_blobs.dart';
import '../domain/auth_providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Please fill in all fields / कृपया सभी फ़ील्ड भरें');
      return;
    }

    try {
      await ref
          .read(authStateProvider.notifier)
          .register(email, password, name);
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      heroHeight: 240,
      heroBackground: Container(
        decoration: const BoxDecoration(gradient: AppTheme.heroPrimary),
        child: const AmbientGlowBlobs(),
      ),
      heroContent: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_add_outlined, size: 64, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            'JOIN THE MOVEMENT',
            style: AppTheme.displayMd(
              context,
            ).copyWith(color: Colors.white, letterSpacing: 2),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Create Account', style: AppTheme.displayMd(context)),
          Text(
            'अपनी यात्रा शुरू करें',
            style: AppTheme.hindi(
              context,
            ).copyWith(color: AppTheme.textSecondary, fontSize: 16),
          ),
          const SizedBox(height: 32),

          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  style: AppTheme.bodyMd(context),
                  decoration: InputDecoration(
                    labelText: 'Full Name / नाम',
                    labelStyle: AppTheme.labelMd(context),
                    prefixIcon: const Icon(Icons.person_outline, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTheme.bodyMd(context),
                  decoration: InputDecoration(
                    labelText: 'Email Address / ईमेल',
                    labelStyle: AppTheme.labelMd(context),
                    prefixIcon: const Icon(Icons.alternate_email, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: AppTheme.bodyMd(context),
                  decoration: InputDecoration(
                    labelText: 'Password / पासवर्ड',
                    labelStyle: AppTheme.labelMd(context),
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
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
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
                            'CREATE ACCOUNT',
                            style: AppTheme.labelLg(context),
                          ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () => context.pop(),
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: AppTheme.bodyMd(
                    context,
                  ).copyWith(color: AppTheme.textSecondary),
                  children: [
                    TextSpan(
                      text: "Login",
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
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
