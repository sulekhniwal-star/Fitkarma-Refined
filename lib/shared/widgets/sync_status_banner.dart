import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum SyncStatus { healthy, lowData, syncFailed }

class SyncStatusBanner extends StatelessWidget {
  final SyncStatus status;
  final int? failureCount;
  final VoidCallback? onTap;

  const SyncStatusBanner({
    super.key,
    required this.status,
    this.failureCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (status == SyncStatus.healthy) return const SizedBox.shrink();

    final isFailed = status == SyncStatus.syncFailed;
    final Color bgColor = isFailed ? AppColors.warning : AppColors.teal;
    final IconData icon = isFailed ? Icons.sync_problem_rounded : Icons.cloud_off_rounded;
    final String label = isFailed 
        ? 'Syncing Failed ($failureCount items)' 
        : 'Low Data Mode Active';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: bgColor,
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.1,
                ),
              ),
            ),
            if (isFailed)
              const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}
