import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/shimmer_loader.dart';
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
      _showError('Please enter your email and password');
      return;
    }

    try {
      await ref.read(authStateProvider.notifier).login(email, password);
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: authState.isLoading
          ? const Center(child: ShimmerLoader())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  Stack(
                    children: [
                      Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(
                                // Absolute path from generation
                                // Note: In production, this would be an asset
                                File(r'C:\Users\sulek\.gemini\antigravity\brain\0b390528-bf81-4962-aa61-78af37d60a25\login_hero_yoga_1776079948878.png')),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 350,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              (isDark ? AppColorsDark.background : AppColors.background).withValues(alpha: 0.8),
                              isDark ? AppColorsDark.background : AppColors.background,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Login Form
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Home',
                          style: AppTextStyles.displayMedium(isDark),
                        ),
                        Text(
                          'पुनः आपका स्वागत है',
                          style: AppTextStyles.sectionHeaderHindi(isDark),
                        ),
                        const SizedBox(height: 32),
                        
                        // Email
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            child: const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Google Login
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => ref.read(authStateProvider.notifier).loginWithGoogle(),
                            icon: const Icon(Icons.g_mobiledata, size: 32),
                            label: const Text('Continue with Google'),
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        Center(
                          child: TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text("Don't have an account? Register"),
                          ),
                        ),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

