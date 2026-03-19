import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onDismiss;
  final Function(bool)? onRate; // true for 👍, false for 👎

  const InsightCard({
    super.key,
    required this.title,
    required this.message,
    this.onDismiss,
    this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkAccentLight : AppColors.accentLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: AppColors.accent.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.accentDark,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    onPressed: onDismiss,
                    icon: const Icon(Icons.close, size: 18),
                    color: AppColors.accentDark.withOpacity(0.5),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _RateButton(
                  icon: Icons.thumb_up_off_alt_rounded,
                  onPressed: () => onRate?.call(true),
                ),
                const SizedBox(width: 12),
                _RateButton(
                  icon: Icons.thumb_down_off_alt_rounded,
                  onPressed: () => onRate?.call(false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RateButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _RateButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.accentDark.withOpacity(0.2),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: AppColors.accentDark,
        ),
      ),
    );
  }
}
