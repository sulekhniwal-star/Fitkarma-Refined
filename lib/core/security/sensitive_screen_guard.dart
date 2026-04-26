import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'biometric_service.dart';

/// Wrap route builder for screens requiring biometric re-auth
class SensitiveScreenGuard extends ConsumerWidget {
  final Widget child;
  const SensitiveScreenGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<bool>(
      future: BiometricService.authenticate(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (snap.data != true) {
          // Auth failed or cancelled — pop back to previous screen
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.canPop()) {
              context.pop();
            }
          });
          return const Scaffold(body: SizedBox.shrink());
        }
        
        return child;
      },
    );
  }
}
