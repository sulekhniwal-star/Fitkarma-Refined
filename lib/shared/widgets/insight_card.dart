import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback? onThumbsUp;
  final VoidCallback? onThumbsDown;

  const InsightCard({
    super.key,
    required this.title,
    required this.body,
    this.onThumbsUp,
    this.onThumbsDown,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF3D2E0A).withValues(alpha: 0.6)
            : const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.warning.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_rounded,
                  color: AppColors.warning, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onThumbsUp,
                icon: const Icon(Icons.thumb_up_alt_outlined, size: 18),
                visualDensity: VisualDensity.compact,
                tooltip: 'Helpful',
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: onThumbsDown,
                icon: const Icon(Icons.thumb_down_alt_outlined, size: 18),
                visualDensity: VisualDensity.compact,
                tooltip: 'Not helpful',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
