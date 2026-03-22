// lib/features/lab_reports/presentation/lab_report_confirm_screen.dart
// Confirmation Screen - shows extracted values for user review

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/lab_reports/data/lab_report_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class LabReportConfirmScreen extends ConsumerStatefulWidget {
  const LabReportConfirmScreen({super.key});

  @override
  ConsumerState<LabReportConfirmScreen> createState() =>
      _LabReportConfirmScreenState();
}

class _LabReportConfirmScreenState
    extends ConsumerState<LabReportConfirmScreen> {
  final Map<String, TextEditingController> _controllers = {};
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final data = ref.read(labReportScanProvider).extractedData;
    if (data != null) {
      _controllers['glucose'] = TextEditingController(text: data.glucose ?? '');
      _controllers['hemoglobin'] = TextEditingController(
        text: data.hemoglobin ?? '',
      );
      _controllers['cholesterolTotal'] = TextEditingController(
        text: data.cholesterolTotal ?? '',
      );
      _controllers['cholesterolLDL'] = TextEditingController(
        text: data.cholesterolLDL ?? '',
      );
      _controllers['cholesterolHDL'] = TextEditingController(
        text: data.cholesterolHDL ?? '',
      );
      _controllers['tsh'] = TextEditingController(text: data.tsh ?? '');
      _controllers['creatinine'] = TextEditingController(
        text: data.creatinine ?? '',
      );
      _controllers['vitaminD'] = TextEditingController(
        text: data.vitaminD ?? '',
      );
      _controllers['vitaminB12'] = TextEditingController(
        text: data.vitaminB12 ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanState = ref.watch(labReportScanProvider);
    final data = scanState.extractedData;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Confirm Extracted Data'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(labReportScanProvider.notifier).goBack();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: data == null
          ? const Center(child: Text('No data extracted'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Please verify and edit the extracted values before saving. Values will be added to your health trackers.',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Extracted values
                  _buildValueField(
                    label: 'Glucose (mg/dL)',
                    field: 'glucose',
                    hint: 'e.g., 95',
                    unit: 'mg/dL',
                    icon: Icons.water_drop,
                    color: AppColors.warning,
                  ),
                  _buildValueField(
                    label: 'Hemoglobin (g/dL)',
                    field: 'hemoglobin',
                    hint: 'e.g., 14.5',
                    unit: 'g/dL',
                    icon: Icons.bloodtype,
                    color: AppColors.error,
                  ),
                  _buildValueField(
                    label: 'Total Cholesterol (mg/dL)',
                    field: 'cholesterolTotal',
                    hint: 'e.g., 200',
                    unit: 'mg/dL',
                    icon: Icons.favorite,
                    color: AppColors.rose,
                  ),
                  _buildValueField(
                    label: 'LDL Cholesterol (mg/dL)',
                    field: 'cholesterolLDL',
                    hint: 'e.g., 100',
                    unit: 'mg/dL',
                    icon: Icons.trending_down,
                    color: AppColors.warning,
                  ),
                  _buildValueField(
                    label: 'HDL Cholesterol (mg/dL)',
                    field: 'cholesterolHDL',
                    hint: 'e.g., 50',
                    unit: 'mg/dL',
                    icon: Icons.trending_up,
                    color: AppColors.success,
                  ),
                  _buildValueField(
                    label: 'TSH (µIU/mL)',
                    field: 'tsh',
                    hint: 'e.g., 2.5',
                    unit: 'µIU/mL',
                    icon: Icons.psychology,
                    color: AppColors.purple,
                  ),
                  _buildValueField(
                    label: 'Creatinine (mg/dL)',
                    field: 'creatinine',
                    hint: 'e.g., 1.0',
                    unit: 'mg/dL',
                    icon: Icons.science,
                    color: AppColors.teal,
                  ),
                  _buildValueField(
                    label: 'Vitamin D (ng/mL)',
                    field: 'vitaminD',
                    hint: 'e.g., 30',
                    unit: 'ng/mL',
                    icon: Icons.wb_sunny,
                    color: AppColors.accent,
                  ),
                  _buildValueField(
                    label: 'Vitamin B12 (pg/mL)',
                    field: 'vitaminB12',
                    hint: 'e.g., 400',
                    unit: 'pg/mL',
                    icon: Icons.eco,
                    color: AppColors.secondary,
                  ),

                  const SizedBox(height: 32),

                  // Action buttons
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Save to Trackers',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _isSaving
                          ? null
                          : () {
                              ref.read(labReportScanProvider.notifier).reset();
                              Navigator.of(context).pop();
                            },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSecondary,
                        side: const BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildValueField({
    required String label,
    required String field,
    required String hint,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _controllers[field],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      suffixText: unit,
                      suffixStyle: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    onChanged: (value) {
                      ref
                          .read(labReportScanProvider.notifier)
                          .updateValue(field, value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveData() async {
    setState(() => _isSaving = true);

    try {
      // Get the current extracted data
      final data = ref.read(labReportScanProvider).extractedData;
      if (data == null) return;

      // Update the notifier that we're saving
      ref.read(labReportScanProvider.notifier).setSaving();

      // TODO: Implement actual saving to database
      // 1. Encrypt the data using labReportService.encryptData()
      // 2. Save to LabReports table in database
      // 3. Auto-populate trackers:
      //    - glucose -> glucose_logs
      //    - vitaminD -> micronutrient/food logs
      //    - vitaminB12 -> micronutrient/food logs
      //    - hemoglobin -> could be stored in a separate blood_test table

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lab report saved successfully!'),
            backgroundColor: AppColors.success,
          ),
        );

        // Reset and go back
        ref.read(labReportScanProvider.notifier).reset();
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving data: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }
}
