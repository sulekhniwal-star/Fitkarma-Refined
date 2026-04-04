import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/lab_reports/data/lab_report_ocr_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class LabReportScanScreen extends ConsumerStatefulWidget {
  final String userId;

  const LabReportScanScreen({super.key, required this.userId});

  @override
  ConsumerState<LabReportScanScreen> createState() => _LabReportScanScreenState();
}

class _LabReportScanScreenState extends ConsumerState<LabReportScanScreen> {
  bool _isProcessing = false;
  ExtractedLabData? _extractedData;
  final _editableValues = <String, TextEditingController>{};

  static const _displayFields = [
    ('glucose_fasting', 'Fasting Glucose', 'mg/dL'),
    ('glucose_post', 'Post-meal Glucose', 'mg/dL'),
    ('hemoglobin', 'Hemoglobin', 'g/dL'),
    ('cholesterol_total', 'Total Cholesterol', 'mg/dL'),
    ('ldl', 'LDL Cholesterol', 'mg/dL'),
    ('hdl', 'HDL Cholesterol', 'mg/dL'),
    ('triglycerides', 'Triglycerides', 'mg/dL'),
    ('tsh', 'TSH', 'µIU/mL'),
    ('t3', 'T3', 'ng/dL'),
    ('t4', 'T4', 'µg/dL'),
    ('vitamin_d', 'Vitamin D', 'ng/mL'),
    ('vitamin_b12', 'Vitamin B12', 'pg/mL'),
    ('creatinine', 'Creatinine', 'mg/dL'),
    ('urea', 'Urea', 'mg/dL'),
    ('uric_acid', 'Uric Acid', 'mg/dL'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab Report Scanner'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: _extractedData == null
            ? _buildScanPrompt()
            : _buildConfirmScreen(),
      ),
    );
  }

  Widget _buildScanPrompt() {
    return Center(
      child: _isProcessing
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.science, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('Scan your lab report'),
                const SizedBox(height: 8),
                const Text(
                  'Extract glucose, cholesterol, Vitamin D, B12, and more',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _scanReport,
                  icon: const Icon(Icons.camera),
                  label: const Text('Take Photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildConfirmScreen() {
    final values = _extractedData!.values;
    final displayValues = _displayFields.where((f) => values[f.$1] != null && values[f.$1]! > 0).toList();
    
    for (final field in displayValues) {
      final val = values[field.$1];
      if (val != null && val > 0) {
        _editableValues[field.$1] ??= TextEditingController(text: val.toString());
      }
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Confirm extracted values before saving',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: displayValues.length,
            itemBuilder: (context, index) {
              final field = displayValues[index];
              final controller = _editableValues[field.$1]!;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Text(field.$2)),
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(suffixText: field.$3, isDense: true),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _saveReport,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save to Lab Reports'),
          ),
        ),
      ],
    );
  }

  Future<void> _scanReport() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));
    
    final mockData = ExtractedLabData(
      rawText: 'Mock lab report',
      values: {
        'glucose_fasting': 95.0,
        'vitamin_d': 42.0,
        'vitamin_b12': 380.0,
        'tsh': 2.1,
        'cholesterol_total': 185.0,
        'ldl': 110.0,
        'hdl': 52.0,
        'creatinine': 0.9,
      },
    );
    
    if (mounted) {
      setState(() {
        _extractedData = mockData;
        _isProcessing = false;
      });
    }
  }

  Future<void> _saveReport() async {
    final values = _editableValues.map((k, v) => MapEntry(k, double.tryParse(v.text)));
    final dataJson = Uri(queryParameters: values).query;
    
    final db = AppDatabase();
    await db.labReportsDao.insertWithExtraction(
      userId: widget.userId,
      reportName: 'Lab Report ${DateTime.now().day}/${DateTime.now().month}',
      extractedDataJson: dataJson,
    );
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lab report saved!')),
      );
      context.pop();
    }
  }
}