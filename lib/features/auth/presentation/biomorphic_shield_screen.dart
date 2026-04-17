import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/security/security_providers.dart';
import '../../../core/security/biometric_service.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class BiomorphicShieldScreen extends ConsumerStatefulWidget {
  const BiomorphicShieldScreen({super.key});

  @override
  ConsumerState<BiomorphicShieldScreen> createState() =>
      _BiomorphicShieldScreenState();
}

class _BiomorphicShieldScreenState extends ConsumerState<BiomorphicShieldScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Automatically trigger biometric prompt on entry
    WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    try {
      final success = await ref
          .read(biometricServiceProvider)
          .authenticate(reason: 'Authenticate to access your health data');

      if (success) {
        HapticFeedback.mediumImpact();
        ref.read(securityProvider.notifier).unlock();
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final securityState = ref.watch(securityProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.black, // Force deep black for high-end look
      body: Stack(
        children: [
          // 1. Abstract premium background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),

          // 2. Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Biometric Target Icon
                AnimatedBuilder(
                  animation: _glowAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary.withValues(
                            alpha: _glowAnimation.value * 0.5,
                          ),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(
                              alpha: _glowAnimation.value * 0.2,
                            ),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fingerprint_rounded,
                        size: 80,
                        color: AppColors.primary.withValues(alpha: 0.8),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 48),

                // Text labels
                Text(
                  'FitKarma Shield',
                  style: AppTextStyles.h1(true).copyWith(
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'IDENTIFY VERIFICATION REQUIRED',
                  style: AppTextStyles.caption(true).copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Unlock Button (Glassmorphic)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: ElevatedButton(
                      onPressed: _authenticate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'TAP TO UNLOCK',
                        style: AppTextStyles.labelLarge(true).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Jailbreak Warning (Non-blocking but persistent)
          if (securityState.value?.isCompromised ?? false)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Device integrity check failed. Enclave protection is reduced.',
                        style: AppTextStyles.bodySmall(
                          true,
                        ).copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

