import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/security/security_providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A wrapper widget that blurs its content unless a biometric challenge is passed.
/// Used for sensitive data protection inside screens without locking the whole app.
class ShieldedView extends ConsumerStatefulWidget {
  final Widget child;
  final String reason;

  const ShieldedView({
    super.key,
    required this.child,
    this.reason = 'Authenticate to reveal sensitive data',
  });

  @override
  ConsumerState<ShieldedView> createState() => _ShieldedViewState();
}

class _ShieldedViewState extends ConsumerState<ShieldedView> {
  bool _revealed = false;

  void _handleReveal() async {
    final success = await ref.read(biometricServiceProvider).authenticate(
      reason: widget.reason,
    );
    if (success) {
      setState(() => _revealed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_revealed) return widget.child;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _handleReveal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Blurred Content
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
              child: widget.child,
            ),

            // 2. Shield Overlay
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),

            // 3. Instruction
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_person_rounded,
                  color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.8),
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'TAP TO REVEAL',
                  style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)).copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: isDark ? AppColorsDark.primary : AppColorsLight.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

