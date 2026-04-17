import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum LabClassification { normal, borderline, risk }

class LabValueRow extends StatefulWidget {
  final String name;
  final String hindiName;
  final double initialValue;
  final String unit;
  final LabClassification classification;
  final Function(double) onValueChanged;
  final Function(bool) onConfirmChanged;

  const LabValueRow({
    super.key,
    required this.name,
    required this.hindiName,
    required this.initialValue,
    required this.unit,
    required this.classification,
    required this.onValueChanged,
    required this.onConfirmChanged,
  });

  @override
  State<LabValueRow> createState() => _LabValueRowState();
}

class _LabValueRowState extends State<LabValueRow> {
  late TextEditingController _controller;
  bool _isEditing = false;
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getClassificationColor() {
    switch (widget.classification) {
      case LabClassification.normal:
        return AppColors.success;
      case LabClassification.borderline:
        return AppColors.warning;
      case LabClassification.risk:
        return AppColors.error;
    }
  }

  String _getClassificationText() {
    switch (widget.classification) {
      case LabClassification.normal:
        return 'Normal';
      case LabClassification.borderline:
        return 'Borderline';
      case LabClassification.risk:
        return 'Risk';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final classificationColor = _getClassificationColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isConfirmed ? AppColors.primary.withValues(alpha: 0.5) : AppColors.divider,
          width: _isConfirmed ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🩸', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppTextStyles.labelLarge(isDark),
                    ),
                    Text(
                      widget.hindiName,
                      style: AppTextStyles.caption(isDark),
                    ),
                  ],
                ),
              ),
              if (_isEditing)
                SizedBox(
                  width: 60,
                  height: 36,
                  child: TextField(
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium(isDark).copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    onSubmitted: (val) {
                      final parsed = double.tryParse(val);
                      if (parsed != null) {
                        widget.onValueChanged(parsed);
                      }
                      setState(() => _isEditing = false);
                    },
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.divider.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _controller.text,
                    style: AppTextStyles.labelLarge(isDark).copyWith(color: AppColors.primary),
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                widget.unit,
                style: AppTextStyles.bodySmall(isDark),
              ),
              const SizedBox(width: 12),
              _buildClassificationPill(classificationColor),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() => _isEditing = !_isEditing),
                child: Row(
                  children: [
                    Icon(
                      _isEditing ? Icons.check_rounded : Icons.edit_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isEditing ? 'Save' : 'Edit',
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Confirm Correct',
                    style: AppTextStyles.bodySmall(isDark),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _isConfirmed,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (val) {
                        setState(() => _isConfirmed = val ?? false);
                        widget.onConfirmChanged(_isConfirmed);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationPill(Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            _getClassificationText(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

