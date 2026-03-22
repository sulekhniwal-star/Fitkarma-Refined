// lib/features/spo2/presentation/spo2_logging_sheet.dart
// SpO2 logging bottom sheet

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/spo2/data/spo2_service.dart';
import 'package:fitkarma/features/spo2/data/spo2_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class SpO2LoggingSheet extends ConsumerStatefulWidget {
  const SpO2LoggingSheet({super.key});

  @override
  ConsumerState<SpO2LoggingSheet> createState() => _SpO2LoggingSheetState();
}

class _SpO2LoggingSheetState extends ConsumerState<SpO2LoggingSheet> {
  final _formKey = GlobalKey<FormState>();
  final _spo2Controller = TextEditingController();
  final _pulseController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _spo2Controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _saveSpO2() async {
    if (!_formKey.currentState!.validate()) return;

    final spo2Value = double.tryParse(_spo2Controller.text);
    if (spo2Value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid SpO2 value')),
      );
      return;
    }

    // Validate SpO2 range (70-100%)
    if (spo2Value < 70 || spo2Value > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SpO2 value should be between 70-100%')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final helper = ref.read(spo2LoggingHelperProvider);
      final pulseRate = _pulseController.text.isNotEmpty
          ? int.tryParse(_pulseController.text)
          : null;

      final log = await helper.logSpO2(
        spo2Percentage: spo2Value,
        pulseRate: pulseRate,
        source: 'manual',
      );

      if (mounted) {
        if (log != null) {
          _showSuccessAndClassification(spo2Value);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Failed to log SpO2')));
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessAndClassification(double spo2Value) {
    final classification = classifySpO2(spo2Value);
    final isAlert = isSpO2Alert(spo2Value);

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
            const Text('SpO2 Logged!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SpO2: ${spo2Value.toStringAsFixed(0)}%',
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
            // Alert message when SpO2 < 95%
            if (isAlert) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: Colors.orange),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Please consult your doctor',
                        style: TextStyle(
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                'Log Blood Oxygen (SpO2)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Track your oxygen saturation levels',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Normal Range Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.green[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Normal SpO2: 95-100%',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // SpO2 Input
              const Text(
                'SpO2 Level (%)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _spo2Controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Enter SpO2 value',
                  suffixText: '%',
                  prefixIcon: const Icon(Icons.air),
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
                    return 'Please enter SpO2 value';
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
              const SizedBox(height: 20),

              // Pulse Rate (optional)
              const Text(
                'Pulse Rate (BPM) - Optional',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _pulseController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: 'Enter pulse rate',
                  suffixText: 'BPM',
                  prefixIcon: const Icon(Icons.favorite),
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
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _isLoading ? null : _saveSpO2,
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
                        'Save SpO2',
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

  Widget _buildQuickValues() {
    final quickValues = [95, 96, 97, 98, 99, 100];

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
              label: Text('$value%'),
              onPressed: () {
                _spo2Controller.text = value.toString();
              },
              backgroundColor: Colors.grey[100],
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// Show the SpO2 logging sheet
Future<void> showSpO2LoggingSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const SpO2LoggingSheet(),
  );
}
