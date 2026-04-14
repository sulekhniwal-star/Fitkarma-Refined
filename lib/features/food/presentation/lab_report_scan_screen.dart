import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../../../shared/widgets/lab_value_row.dart';
import '../../auth/domain/auth_providers.dart';
import '../../blood_pressure/domain/bp_providers.dart';
import '../../glucose/domain/glucose_providers.dart';
import '../data/lab_report_ocr_service.dart';

class _ExtractedValueState {
  final LabValue original;
  double currentValue;
  bool isConfirmed;

  _ExtractedValueState({
    required this.original,
    required this.currentValue,
    this.isConfirmed = false,
  });
}

class LabReportScanScreen extends ConsumerStatefulWidget {
  const LabReportScanScreen({super.key});

  @override
  ConsumerState<LabReportScanScreen> createState() => _LabReportScanScreenState();
}

class _LabReportScanScreenState extends ConsumerState<LabReportScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final LabReportOcrService _ocrService = LabReportOcrService();
  
  File? _image;
  bool _isProcessing = false;
  List<_ExtractedValueState> _extractedValues = [];

  @override
  void dispose() {
    _ocrService.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _isProcessing = true;
        _extractedValues = [];
      });
      _processImage();
    }
  }

  Future<void> _processImage() async {
    if (_image == null) return;
    
    final inputImage = InputImage.fromFile(_image!);
    try {
      final extraction = await _ocrService.recognizeLabReport(inputImage);
      setState(() {
        _extractedValues = extraction.values.map((v) => _ExtractedValueState(
          original: v,
          currentValue: v.value,
        )).toList();
        _isProcessing = false;
      });
    } catch (e) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process image')),
      );
    }
  }

  Future<void> _importToHealthLogs() async {
    final auth = ref.read(authStateProvider).value;
    if (auth == null) return;

    final bpService = ref.read(bpDriftServiceProvider);
    final glucoseService = ref.read(glucoseDriftServiceProvider);

    int count = 0;
    for (final item in _extractedValues) {
      if (!item.isConfirmed) continue;

      if (item.original.name.contains('Glucose')) {
        await glucoseService.insertGlucoseLog(
          userId: auth.id,
          value: item.currentValue,
          readingType: item.original.name.toLowerCase().contains('fasting') ? 'fasting' : 'random',
          note: 'Imported from Lab Report',
        );
        count++;
      } else if (item.original.name.contains('Pressure') || item.original.name.contains('Systolic')) {
        // Lab reports usually don't have BP unless it's a vitals sheet
      } else if (item.original.name == 'HbA1c') {
        // Save as a special glucose log or similar if supported
      }
    }

    if (count > 0) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Succesfully imported $count values to health logs.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm at least one value to import.')),
      );
    }
  }

  LabClassification _getClassification(String name, double value) {
    if (name.contains('Glucose')) {
      if (value < 100) return LabClassification.normal;
      if (value < 126) return LabClassification.borderline;
      return LabClassification.risk;
    }
    return LabClassification.normal;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(
        title: const Text('Scan Lab Report'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: isDark ? AppColorsDark.textPrimary : AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (_image == null) ...[
              _buildPickerOptions(isDark),
            ] else ...[
              _buildImagePreview(),
              const SizedBox(height: 24),
              if (_isProcessing)
                const ShimmerLoader()
              else if (_extractedValues.isEmpty)
                const Center(child: Text('No health markers identified in this image.'))
              else
                _buildResultsList(isDark),
            ],
            const SizedBox(height: 40),
            _buildPrivacyNote(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOptions(bool isDark) {
    return Column(
      children: [
        const Icon(Icons.description_outlined, size: 80, color: AppColors.primary),
        const SizedBox(height: 24),
        Text(
          'Digitize Your Reports',
          style: AppTextStyles.h2(isDark),
        ),
        const SizedBox(height: 12),
        const Text(
          'Point your camera at a printed lab report to automatically extract health values.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        Row(
          children: [
            Expanded(
              child: _PickerCard(
                icon: Icons.camera_alt_rounded,
                label: 'Take Photo',
                onTap: () => _pickImage(ImageSource.camera),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _PickerCard(
                icon: Icons.picture_as_pdf_rounded,
                label: 'Upload PDF',
                onTap: () => _pickImage(ImageSource.gallery),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(_image!, height: 180, width: double.infinity, fit: BoxFit.cover),
        ),
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.close, size: 18, color: Colors.white),
            ),
            onPressed: () => setState(() {
              _image = null;
              _extractedValues = [];
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsList(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Extracted Values', style: AppTextStyles.h3(isDark)),
            const EncryptionBadge(),
          ],
        ),
        const SizedBox(height: 16),
        ..._extractedValues.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return LabValueRow(
            name: item.original.name,
            hindiName: _getHindiName(item.original.name),
            initialValue: item.currentValue,
            unit: item.original.unit,
            classification: _getClassification(item.original.name, item.currentValue),
            onValueChanged: (val) => setState(() => item.currentValue = val),
            onConfirmChanged: (val) => setState(() => item.isConfirmed = val),
          );
        }),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _importToHealthLogs,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text('Import confirmed values', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  String _getHindiName(String name) {
    if (name.contains('Glucose')) return 'ग्लूकोज / शर्करा';
    if (name.contains('HbA1c')) return 'एचबीए1सी परीक्षण';
    if (name.contains('Hemoglobin')) return 'हीमोग्लोबिन';
    if (name.contains('Cholesterol')) return 'कोलेस्ट्रॉल';
    return '';
  }

  Widget _buildPrivacyNote(bool isDark) {
    return Opacity(
      opacity: 0.7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security_rounded, size: 14, color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary),
              const SizedBox(width: 6),
              const Text('Privacy Protected', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Raw text stored locally only. Values go to your encrypted health logs.',
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PickerCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary, size: 32),
            const SizedBox(height: 12),
            Text(label, style: AppTextStyles.labelMedium(isDark)),
          ],
        ),
      ),
    );
  }
}
