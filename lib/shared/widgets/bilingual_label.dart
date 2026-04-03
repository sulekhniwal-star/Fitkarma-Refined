import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Stacked bilingual label: English on top, Hindi below.
class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final TextStyle? englishStyle;
  final TextStyle? hindiStyle;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAxisAlignment;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.textAlign = TextAlign.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  /// Centered variant.
  const BilingualLabel.centered({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
  })  : textAlign = TextAlign.center,
        crossAxisAlignment = CrossAxisAlignment.center;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          english,
          textAlign: textAlign,
          style: englishStyle ?? AppTextStyles.bodyMedium,
        ),
        const SizedBox(height: 2),
        Text(
          hindi,
          textAlign: textAlign,
          style: hindiStyle ??
              AppTextStyles.bodySmall.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}
