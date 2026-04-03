import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Extracted lab metric with inline text field and confirm checkbox.
class LabValueRow extends StatelessWidget {
  final String label;
  final String unit;
  final String? initialValue;
  final bool confirmed;
  final ValueChanged<String> onChanged;
  final ValueChanged<bool?> onConfirm;

  const LabValueRow({
    super.key,
    required this.label,
    required this.unit,
    this.initialValue,
    required this.confirmed,
    required this.onChanged,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 3,
            child: Text(label, style: AppTextStyles.bodyMedium),
          ),
          // Value field
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: initialValue != null
                    ? TextEditingController(text: initialValue)
                    : null,
                onChanged: onChanged,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  suffixText: unit,
                  suffixStyle: AppTextStyles.labelSmall,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: AppTextStyles.bodyMedium,
              ),
            ),
          ),
          // Confirm checkbox
          SizedBox(
            width: 48,
            child: Checkbox(
              value: confirmed,
              onChanged: onConfirm,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
