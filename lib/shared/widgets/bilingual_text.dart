import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BilingualText extends StatelessWidget {
  final String english;
  final String? hindi;
  final TextStyle? englishStyle;
  final TextStyle? hindiStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const BilingualText({
    super.key,
    required this.english,
    this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          english,
          style: englishStyle ?? theme.textTheme.headlineSmall,
        ),
        if (hindi != null)
          Text(
            hindi!,
            style: hindiStyle ?? 
                theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
          ),
      ],
    );
  }
}
