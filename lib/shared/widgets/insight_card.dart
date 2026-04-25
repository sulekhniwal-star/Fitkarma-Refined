import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A card used to display actionable health insights to the user.
/// 
/// Features a distinct left accent border, a lightbulb icon, and feedback controls.
class InsightCard extends StatelessWidget {
  final String message;
  final VoidCallback onThumbsUp;
  final VoidCallback onThumbsDown;
  final VoidCallback onDismiss;

  const InsightCard({
    super.key,
    required this.message,
    required this.onThumbsUp,
    required this.onThumbsDown,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColorsDark.accentMuted : AppColorsLight.accentMuted;
    final textColor = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Colors.amber, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 32, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Colors.amber[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message,
                        style: (isDark ? AppTypography.bodyMd() : AppTypography.bodyMd(color: AppColorsLight.textPrimary)).copyWith(
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up_outlined, size: 18),
                      onPressed: onThumbsUp,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.thumb_down_outlined, size: 18),
                      onPressed: onThumbsDown,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close, size: 18),
              onPressed: onDismiss,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

