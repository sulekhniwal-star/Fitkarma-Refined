import 'package:flutter/material.dart';

class LabValueRow extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final String? referenceRange;
  final bool isAbnormal;
  final bool isConfirmed;
  final ValueChanged<bool>? onConfirmedChanged;

  const LabValueRow({
    super.key,
    required this.label,
    required this.value,
    this.unit,
    this.referenceRange,
    this.isAbnormal = false,
    this.isConfirmed = false,
    this.onConfirmedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                if (referenceRange != null)
                  Text(
                    'Ref: $referenceRange',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: value),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: isAbnormal
                    ? Colors.red.withValues(alpha: 0.1)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              onChanged: (val) {},
            ),
          ),
          if (unit != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                unit!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          if (onConfirmedChanged != null)
            Checkbox(
              value: isConfirmed,
              onChanged: (val) => onConfirmedChanged!(val ?? false),
            ),
        ],
      ),
    );
  }
}