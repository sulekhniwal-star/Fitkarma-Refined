import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A widget to display error states with a retry action.
/// 
/// Hides raw technical exceptions and provides a user-friendly message
/// and a prominent retry button.
class ErrorRetryWidget extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;
  final String? message;

  const ErrorRetryWidget({
    super.key,
    required this.error,
    required this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColorsDark.primary : AppColors.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: isDark ? AppColorsDark.error : AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: AppTextStyles.h2(isDark),
            ),
            const SizedBox(height: 8),
            Text(
              message ?? 'We encountered an error while loading your data. Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium(isDark).copyWith(
                color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.buttonLarge(isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
