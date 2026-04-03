import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// DLQ banner + offline status indicator.
class SyncStatusBanner extends StatelessWidget {
  final SyncStatus status;
  final int pendingCount;
  final int failedCount;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const SyncStatusBanner({
    super.key,
    required this.status,
    this.pendingCount = 0,
    this.failedCount = 0,
    this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    if (status == SyncStatus.synced) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _bgColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(_icon, size: 18, color: _bgColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_title, style: AppTextStyles.labelMedium),
                if (status == SyncStatus.pending && pendingCount > 0)
                  Text(
                    '$pendingCount item${pendingCount == 1 ? "" : "s"} pending',
                    style: AppTextStyles.labelSmall,
                  ),
                if (status == SyncStatus.failed && failedCount > 0)
                  Text(
                    '$failedCount failed — moved to dead-letter queue',
                    style: AppTextStyles.labelSmall
                        .copyWith(color: AppColors.error),
                  ),
              ],
            ),
          ),
          if (status == SyncStatus.failed)
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          if (status == SyncStatus.offline)
            const SizedBox.shrink()
          else if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Color get _bgColor {
    switch (status) {
      case SyncStatus.synced:
        return AppColors.success;
      case SyncStatus.pending:
        return AppColors.warning;
      case SyncStatus.failed:
        return AppColors.error;
      case SyncStatus.offline:
        return AppColors.info;
    }
  }

  IconData get _icon {
    switch (status) {
      case SyncStatus.synced:
        return Icons.cloud_done;
      case SyncStatus.pending:
        return Icons.cloud_upload;
      case SyncStatus.failed:
        return Icons.cloud_off;
      case SyncStatus.offline:
        return Icons.wifi_off;
    }
  }

  String get _title {
    switch (status) {
      case SyncStatus.synced:
        return 'All synced';
      case SyncStatus.pending:
        return 'Syncing...';
      case SyncStatus.failed:
        return 'Sync failed';
      case SyncStatus.offline:
        return 'You\'re offline';
    }
  }
}

enum SyncStatus { synced, pending, failed, offline }
