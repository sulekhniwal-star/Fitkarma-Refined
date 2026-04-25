import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum TrendDirection { up, down, stable }

/// A compact chip widget that displays trend indicators with directional arrows.
/// 
/// Used to show positive (up), negative (down), or stable trends in metrics
/// like steps, calories, blood pressure, etc.
/// 
/// The color scheme adapts to the current theme (dark/light) automatically.
class TrendChip extends StatelessWidget {
  final TrendDirection direction;
  final String label;

  const TrendChip({
    super.key,
    required this.direction,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final (icon, color) = switch (direction) {
      TrendDirection.up => (
          '▲',
          isDark ? AppColorsDark.success : AppColors.success,
        ),
      TrendDirection.down => (
          '▼',
          isDark ? AppColorsDark.error : AppColors.error,
        ),
      TrendDirection.stable => (
          '→',
          isDark ? AppColorsDark.textMuted : AppColors.textMuted,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            icon,
            style: TextStyle(
              color: color,
              fontSize: 10,
              height: 1,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            label,
            style: AppTextStyles.caption(isDark).copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
