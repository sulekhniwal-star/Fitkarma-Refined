import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class LabValueRow extends StatefulWidget {
  final String label;
  final String initialValue;
  final String unit;
  final String? referenceRange;
  final bool isConfirmed;
  final Function(String) onValueChanged;
  final Function(bool) onConfirmedChanged;

  const LabValueRow({
    super.key,
    required this.label,
    required this.initialValue,
    required this.unit,
    this.referenceRange,
    required this.isConfirmed,
    required this.onValueChanged,
    required this.onConfirmedChanged,
  });

  @override
  State<LabValueRow> createState() => _LabValueRowState();
}

class _LabValueRowState extends State<LabValueRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(LabValueRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? AppColors.darkDivider : AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: AppTextStyles.labelLarge.copyWith(height: 1.2),
                ),
                if (widget.referenceRange != null)
                  Text(
                    'Range: ${widget.referenceRange}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: TextField(
              controller: _controller,
              onChanged: widget.onValueChanged,
              keyboardType: TextInputType.number,
              style: AppTextStyles.h3.copyWith(color: AppColors.primary),
              decoration: InputDecoration(
                suffixText: widget.unit,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                filled: true,
                fillColor: isDarkMode ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Checkbox(
            value: widget.isConfirmed,
            onChanged: (val) => widget.onConfirmedChanged(val ?? false),
            activeColor: AppColors.success,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ],
      ),
    );
  }
}
