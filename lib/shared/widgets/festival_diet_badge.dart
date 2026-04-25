import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class FestivalDietBadge extends StatelessWidget {
  final String fastingType; // Nirjala / Phalahar / Roza / Feast

  const FestivalDietBadge({
    super.key,
    required this.fastingType,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.primaryMuted : AppColorsLight.primaryMuted,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha:0.5),
          width: 1,
        ),
      ),
      child: Text(
        fastingType,
        style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)).copyWith(
          color: isDark ? AppColorsDark.primary : AppColorsLight.primary,
        ),
      ),
    );
  }
}

