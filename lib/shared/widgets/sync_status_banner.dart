import 'package:flutter/material.dart';
import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_typography.dart';

/// A notification banner indicating sync failures or connectivity status.
/// 
/// Displays at the top of screens to inform users of data synchronization issues.
class SyncStatusBanner extends StatelessWidget {
  final int dlqCount;
  final bool isOffline;
  final bool isLowDataMode;
  final VoidCallback? onReviewDeadLetter;

  const SyncStatusBanner({
    super.key,
    required this.dlqCount,
    required this.isOffline,
    required this.isLowDataMode,
    this.onReviewDeadLetter,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (dlqCount > 0) {
      return _BannerContainer(
        color: isDark ? AppColorsDark.warning : AppColorsLight.warning,
        title: '⚠ $dlqCount items failed to sync',
        subtitle: 'Tap to review and retry.',
        onTap: onReviewDeadLetter,
        isDark: isDark,
      );
    }

    if (isOffline) {
      return _BannerContainer(
        color: isDark ? AppColorsDark.teal : AppColorsLight.teal,
        title: 'Offline',
        subtitle: 'Changes saved locally. Will sync when online.',
        isDark: isDark,
      );
    }

    if (isLowDataMode) {
      return _BannerContainer(
        color: isDark ? AppColorsDark.teal : AppColorsLight.teal,
        title: 'Low Data Mode active',
        subtitle: 'Syncing at a lower frequency.',
        isDark: isDark,
      );
    }

    return const SizedBox.shrink();
  }
}

class _BannerContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isDark;

  const _BannerContainer({
    required this.color,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: color.withValues(alpha: 0.9),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelLg(color: Colors.white).copyWith(
                      height: 1.1,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.caption(color: Colors.white70),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

