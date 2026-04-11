import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class HealthShareCard extends StatelessWidget {
  final DateTime expiryDate;
  final String shareLink;
  final VoidCallback onShareWhatsApp;
  final VoidCallback onCopyLink;
  final VoidCallback onDelete;

  const HealthShareCard({
    super.key,
    required this.expiryDate,
    required this.shareLink,
    required this.onShareWhatsApp,
    required this.onCopyLink,
    required this.onDelete,
  });

  String _getRemainingTime() {
    final diff = expiryDate.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';
    if (diff.inDays > 0) return 'Expires in ${diff.inDays} days';
    if (diff.inHours > 0) return 'Expires in ${diff.inHours} hours';
    return 'Expires in ${diff.inMinutes} minutes';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final remainingTime = _getRemainingTime();
    final isExpired = expiryDate.isBefore(DateTime.now());

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isExpired ? AppColors.error.withOpacity(0.1) : AppColors.teal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: isExpired ? AppColors.error : AppColors.teal,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      remainingTime,
                      style: AppTextStyles.caption.copyWith(
                        color: isExpired ? AppColors.error : AppColors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(Icons.share, size: 20, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Shareable Health Summary',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 4),
          Text(
            'This link provides a read-only view of your 30-day health trends for your doctor.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isExpired ? null : onShareWhatsApp,
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Share via WhatsApp'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCopyLink,
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('Copy Link'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18, color: AppColors.error),
                  label: Text(
                    'Delete Link',
                    style: TextStyle(color: isDark ? AppColors.error : AppColors.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: AppColors.divider),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
