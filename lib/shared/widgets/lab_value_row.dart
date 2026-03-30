import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class LabValueRow extends StatelessWidget {
  final String testName;
  final String value;
  final String unit;
  final String? normalRange;
  final bool isAbnormal;
  final bool isConfirmed;
  final ValueChanged<bool?>? onConfirmChanged;
  final ValueChanged<String>? onValueChanged;

  const LabValueRow({
    super.key,
    required this.testName,
    required this.value,
    required this.unit,
    this.normalRange,
    this.isAbnormal = false,
    this.isConfirmed = false,
    this.onConfirmChanged,
    this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final abnormalColor = isAbnormal ? const Color(0xFFFF6B6B) : null;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  testName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: abnormalColor,
                    fontWeight: isAbnormal ? FontWeight.w600 : null,
                  ),
                ),
                if (normalRange != null)
                  Text(
                    'Normal: $normalRange',
                    style: AppTextStyles.caption.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 72,
            child: onValueChanged != null
                ? TextFormField(
                    initialValue: value,
                    onChanged: onValueChanged,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: abnormalColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: abnormalColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 32,
            child: Text(
              unit,
              style: AppTextStyles.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (onConfirmChanged != null)
            Checkbox(
              value: isConfirmed,
              onChanged: onConfirmChanged,
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
        ],
      ),
    );
  }
}
