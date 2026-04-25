import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A compact progress bar for tracking micronutrients (e.g., Vitamin D, B12, Iron).
/// 
/// Uses a traffic-light color system based on RDA completion.
class MicronutrientBar extends StatelessWidget {
  final String name;
  final double current;
  final double goal;
  final String unit;

  const MicronutrientBar({
    super.key,
    required this.name,
    required this.current,
    required this.goal,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (current / goal).clamp(0.0, 1.0);
    final barColor = _getTrafficLightColor(progress, isDark);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)).copyWith(fontSize: 10),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: barColor.withValues(alpha: 0.1),
                color: barColor,
                minHeight: 6,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(
              '${current.toStringAsFixed(1)}$unit / ${goal.toStringAsFixed(0)}$unit',
              textAlign: TextAlign.end,
              style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)).copyWith(
                fontSize: 10,
                color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTrafficLightColor(double progress, bool isDark) {
    if (progress >= 0.8) return isDark ? AppColorsDark.success : AppColorsLight.success;
    if (progress >= 0.4) return isDark ? AppColorsDark.warning : AppColorsLight.warning;
    return isDark ? AppColorsDark.error : AppColorsLight.error;
  }
}

