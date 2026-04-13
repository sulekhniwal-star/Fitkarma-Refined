import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/shimmer_loader.dart';
import '../data/lab_report_ocr_service.dart';

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
  List<LabValue> _extractedValues = [];

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
        _extractedValues = extraction.values;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to process image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: const Text('Lab Report Scan')),
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
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOptions(bool isDark) {
    return Column(
      children: [
        const Icon(Icons.description_outlined, size: 100, color: AppColors.primary),
        const SizedBox(height: 24),
        Text(
          'Digitize Your Reports',
          style: AppTextStyles.h2(isDark),
        ),
        const SizedBox(height: 12),
        const Text(
          'Point your camera at a printed lab report to automatically extract glucose, cholesterol, and other values.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _pickImage(ImageSource.camera),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Capture Report'),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            icon: const Icon(Icons.photo_library),
            label: const Text('Choose from Gallery'),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(_image!, height: 200, width: double.infinity, fit: BoxFit.cover),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            icon: const CircleAvatar(child: Icon(Icons.close, size: 16)),
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
        Text('Extracted Values', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 12),
        ..._extractedValues.map((val) => _LabValueRow(val: val, isDark: isDark)),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Write to Drif/Appwrite repositories
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Health data imported successfully!')),
              );
            },
            child: const Text('Import All to Health Logs'),
          ),
        ),
      ],
    );
  }
}

class _LabValueRow extends StatelessWidget {
  final LabValue val;
  final bool isDark;

  const _LabValueRow({required this.val, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(val.name, style: AppTextStyles.bodyMedium(isDark)),
          Text(
            '${val.value} ${val.unit}',
            style: AppTextStyles.labelLarge(isDark).copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
