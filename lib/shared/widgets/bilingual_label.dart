import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

/// A widget that displays text in both English and Hindi.
/// 
/// Used for section headers and titles where bilingual accessibility is required.
class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final TextStyle? englishStyle;
  final TextStyle? hindiStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          english,
          style: englishStyle ?? AppTextStyles.h3(isDark),
        ),
        Text(
          hindi,
          style: hindiStyle ?? AppTextStyles.sectionHeaderHindi(isDark),
        ),
      ],
    );
  }
}
