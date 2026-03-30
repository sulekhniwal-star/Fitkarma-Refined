import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final TextStyle? englishStyle;
  final TextStyle? hindiStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          english,
          style: englishStyle ??
              AppTextStyles.bodyMedium.copyWith(
                color: colorScheme.onSurface,
              ),
          textAlign: textAlign,
        ),
        const SizedBox(height: 2),
        Text(
          hindi,
          style: hindiStyle ??
              AppTextStyles.bodySmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
          textAlign: textAlign,
        ),
      ],
    );
  }
}
