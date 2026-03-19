import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HealthShareCard extends StatelessWidget {
  final String doctorName;
  final String activeUntil;
  final int daysRemaining;
  final VoidCallback onShareWhatsApp;
  final VoidCallback onRevoke;

  const HealthShareCard({
    super.key,
    required this.doctorName,
    required this.activeUntil,
    required this.daysRemaining,
    required this.onShareWhatsApp,
    required this.onRevoke,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
      shape: theme.cardTheme.shape,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share_rounded, color: AppColors.teal, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Secure Health Share',
                        style: AppTextStyles.labelLarge.copyWith(color: AppColors.teal),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Active for Dr. $doctorName',
                        style: AppTextStyles.h4,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: onRevoke,
                  child: Text(
                    'Revoke',
                    style: AppTextStyles.labelMedium.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expires on $activeUntil',
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$daysRemaining days remaining',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: daysRemaining < 2 ? AppColors.error : AppColors.success,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: onShareWhatsApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  icon: const Icon(Icons.share_rounded, size: 20), // Fallback: share_rounded
                  label: const Text('Share Link'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
