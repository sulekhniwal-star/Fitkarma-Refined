import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SyncStatusBanner extends StatelessWidget {
  final bool isOffline;
  final int pendingCount;
  final int deadLetterCount;
  final VoidCallback? onTap;
  final VoidCallback? onRetry;

  const SyncStatusBanner({
    super.key,
    this.isOffline = false,
    this.pendingCount = 0,
    this.deadLetterCount = 0,
    this.onTap,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOffline && pendingCount == 0 && deadLetterCount == 0) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isOffline) {
      return _Banner(
        color: AppColors.warning,
        icon: Icons.wifi_off_rounded,
        message: 'You\'re offline — changes will sync when connected',
        onTap: onTap,
      );
    }

    if (deadLetterCount > 0) {
      return _Banner(
        color: AppColors.error,
        icon: Icons.error_outline_rounded,
        message: '$deadLetterCount changes failed to sync',
        actionLabel: 'Retry',
        onAction: onRetry,
        onTap: onTap,
      );
    }

    if (pendingCount > 0) {
      return _Banner(
        color: AppColors.info,
        icon: Icons.cloud_sync_outlined,
        message: '$pendingCount changes pending sync',
        onTap: onTap,
      );
    }

    return const SizedBox.shrink();
  }
}

class _Banner extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onTap;

  const _Banner({
    required this.color,
    required this.icon,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          border: Border(
            bottom: BorderSide(color: color.withValues(alpha: 0.3)),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySmall.copyWith(color: color),
              ),
            ),
            if (actionLabel != null && onAction != null)
              GestureDetector(
                onTap: onAction,
                child: Text(
                  actionLabel!,
                  style: AppTextStyles.labelMedium.copyWith(color: color),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
