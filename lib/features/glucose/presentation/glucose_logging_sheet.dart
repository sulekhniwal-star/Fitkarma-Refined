// lib/features/glucose/presentation/glucose_logging_sheet.dart
// Glucose logging bottom sheet with reading type selector

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/glucose/data/glucose_service.dart';
import 'package:fitkarma/features/glucose/data/glucose_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class GlucoseLoggingSheet extends ConsumerStatefulWidget {
  final String? preselectedFoodLogId;

  const GlucoseLoggingSheet({super.key, this.preselectedFoodLogId});

  @override
  ConsumerState<GlucoseLoggingSheet> createState() =>
      _GlucoseLoggingSheetState();
}

class _GlucoseLoggingSheetState extends ConsumerState<GlucoseLoggingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _glucoseController = TextEditingController();

  GlucoseReadingType _selectedReadingType = GlucoseReadingType.fasting;
  bool _isLoading = false;
  String? _selectedFoodLogId;

  @override
  void initState() {
    super.initState();
    _selectedFoodLogId = widget.preselectedFoodLogId;
  }

  @override
  void dispose() {
    _glucoseController.dispose();
    super.dispose();
  }

  Future<void> _saveGlucose() async {
    if (!_formKey.currentState!.validate()) return;

    final glucoseValue = double.tryParse(_glucoseController.text);
    if (glucoseValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid glucose value')),
      );
      return;
    }

    // Validate glucose range (20-600 mg/dL is a reasonable medical range)
    if (glucoseValue < 20 || glucoseValue > 600) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Glucose value seems out of range (20-600 mg/dL)'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final helper = ref.read(glucoseLoggingHelperProvider);
      final log = await helper.logGlucose(
        glucoseMgdl: glucoseValue,
        readingType: _selectedReadingType,
        foodLogId: _selectedFoodLogId,
        source: 'manual',
      );

      if (mounted) {
        if (log != null) {
          // Show classification feedback
          final classification = classifyGlucose(
            glucoseValue,
            _selectedReadingType,
          );
          _showSuccessAndClassification(classification);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to log glucose')),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessAndClassification(GlucoseClassification classification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              classification.isNormal ? Icons.check_circle : Icons.warning,
              color: Color(classification.colorValue),
            ),
            const SizedBox(width: 8),
            const Text('Glucose Logged!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reading: ${_glucoseController.text} mg/dL',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(classification.colorValue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(classification.colorValue)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    classification.displayName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(classification.colorValue),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    classification.description,
                    style: TextStyle(
                      color: Color(classification.colorValue).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                const Text(
                  '+5 XP earned!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close sheet
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Text(
                'Log Blood Glucose',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Track your blood sugar levels',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Reading Type Selector
              const Text(
                'Reading Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _buildReadingTypeSelector(),
              const SizedBox(height: 20),

              // Target Range Info
              _buildTargetRangeInfo(),
              const SizedBox(height: 20),

              // Glucose Input
              const Text(
                'Glucose Level (mg/dL)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _glucoseController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter glucose value',
                  suffixText: 'mg/dL',
                  prefixIcon: const Icon(Icons.water_drop),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter glucose value';
                  }
                  final num = double.tryParse(value);
                  if (num == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Quick values
              _buildQuickValues(),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveGlucose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text(
                        'Save Glucose',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadingTypeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: GlucoseReadingType.values.map((type) {
        final isSelected = type == _selectedReadingType;
        return ChoiceChip(
          label: Text(type.displayName),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() => _selectedReadingType = type);
            }
          },
          selectedColor: AppColors.primary.withOpacity(0.2),
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTargetRangeInfo() {
    final bands = _getTargetBands();
    String rangeText;

    switch (_selectedReadingType) {
      case GlucoseReadingType.fasting:
        rangeText = 'Normal: 70-100 mg/dL';
        break;
      case GlucoseReadingType.postMeal:
        rangeText = 'Normal: <140 mg/dL (2h after meal)';
        break;
      case GlucoseReadingType.random:
        rangeText = 'Normal: <140 mg/dL';
        break;
      case GlucoseReadingType.bedtime:
        rangeText = 'Normal: 80-120 mg/dL';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              rangeText,
              style: TextStyle(color: Colors.blue[700], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  GlucoseTargetBands _getTargetBands() {
    switch (_selectedReadingType) {
      case GlucoseReadingType.fasting:
        return GlucoseTargetBands.fasting;
      case GlucoseReadingType.postMeal:
        return GlucoseTargetBands.postMeal;
      case GlucoseReadingType.random:
        return GlucoseTargetBands.random;
      case GlucoseReadingType.bedtime:
        return GlucoseTargetBands.bedtime;
    }
  }

  Widget _buildQuickValues() {
    final quickValues = [70, 80, 90, 100, 110, 120, 140, 160, 180];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Values',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: quickValues.map((value) {
            return ActionChip(
              label: Text('$value'),
              onPressed: () {
                _glucoseController.text = value.toString();
              },
              backgroundColor: Colors.grey[100],
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Show the glucose logging sheet
Future<void> showGlucoseLoggingSheet(
  BuildContext context, {
  String? foodLogId,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => GlucoseLoggingSheet(preselectedFoodLogId: foodLogId),
  );
}
