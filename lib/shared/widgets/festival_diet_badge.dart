import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
        color: isDark ? AppColorsDark.primarySurface : AppColors.primarySurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.primary.withValues(alpha:0.5) : AppColors.primary.withValues(alpha:0.5),
          width: 1,
        ),
      ),
      child: Text(
        fastingType,
        style: AppTextStyles.labelMedium(isDark).copyWith(
          color: isDark ? AppColorsDark.primary : AppColors.primary,
        ),
      ),
    );
  }
}
