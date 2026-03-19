import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final CrossAxisAlignment crossAxisAlignment;
  final Color? color;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          english,
          style: AppTextStyles.h3.copyWith(color: color),
        ),
        const SizedBox(height: 2),
        Text(
          hindi,
          style: AppTextStyles.sectionHeaderHindi.copyWith(
            color: color?.withOpacity(0.7) ?? Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
