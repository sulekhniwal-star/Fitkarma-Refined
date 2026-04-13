import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A small pill-shaped badge indicating that data is protected by AES-256 encryption.
/// 
/// Provides a visual trust signal to the user in sensitive modules.
class EncryptionBadge extends StatelessWidget {
  final VoidCallback? onTap;

  const EncryptionBadge({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tealColor = isDark ? AppColorsDark.teal : AppColors.teal;

    return GestureDetector(
      onTap: onTap ?? () => _showEncryptionInfo(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: tealColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: tealColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_rounded, size: 10, color: tealColor),
            const SizedBox(width: 4),
            Text(
              'AES-256',
              style: AppTextStyles.caption(isDark).copyWith(
                color: tealColor,
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEncryptionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.security, color: Colors.teal),
            SizedBox(width: 8),
            Text('Bank-Grade Security'),
          ],
        ),
        content: const Text(
          'Your sensitive data (like medical logs and journal entries) is encrypted on your device using AES-256-GCM. \n\nOnly your device holds the keys; not even FitKarma servers can read your private health information.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }
}
