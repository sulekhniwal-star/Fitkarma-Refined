import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';

import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_text_styles.dart';
import '../../../../shared/widgets/shimmer_loader.dart';
import '../../../../shared/widgets/encryption_badge.dart';
import '../../../../shared/widgets/lab_value_row.dart';
import '../../../auth/domain/auth_providers.dart';
import '../../data/lab_report_ocr_service.dart';
import '../../data/lab_report_repository.dart';
import '../../domain/models/extraction_result.dart';

class LabReportScanScreen extends ConsumerStatefulWidget {
  const LabReportScanScreen({super.key});

  @override
  ConsumerState<LabReportScanScreen> createState() => _LabReportScanScreenState();
}

class _LabReportScanScreenState extends ConsumerState<LabReportScanScreen> {
  final ImagePicker _picker = ImagePicker();
  
  File? _file;
  bool _isPdf = false;
  bool _isProcessing = false;
  LabReportExtraction? _extraction;
  bool _retainOcrText = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
        _isPdf = false;
        _isProcessing = true;
        _extraction = null;
      });
      _processFile();
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _isPdf = true;
        _isProcessing = true;
        _extraction = null;
      });
      _processFile();
    }
  }

  Future<void> _processFile() async {
    if (_file == null) return;
    
    final ocrService = ref.read(labReportOcrServiceProvider);
    try {
      final extraction = await ocrService.processLabReport(_file!.path);
      setState(() {
        _extraction = extraction;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() => _isProcessing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to process file: $e')),
        );
      }
    }
  }

  Future<void> _importResults() async {
    if (_extraction == null) return;
    
    final user = ref.read(userProfileProvider).value;
    if (user == null) return;

    final repo = ref.read(labReportRepositoryProvider);
    
    setState(() => _isProcessing = true);
    try {
      await repo.saveExtraction(
        userId: user.id,
        extraction: _extraction!,
        shouldRetainRawText: _retainOcrText,
      );
      
      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully imported health markers!')),
        );
      }
    } catch (e) {
      setState(() => _isProcessing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to import: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(
        title: const Text('Scan Lab Report'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            if (_file == null) 
              _buildInitialState(isDark)
            else 
              _buildProcessingState(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState(bool isDark) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Icon(Icons.document_scanner_rounded, size: 80, color: AppColors.primary),
        const SizedBox(height: 24),
        Text('Digital Health Import', style: AppTextStyles.h2(isDark)),
        const SizedBox(height: 12),
        Text(
          'Point your camera at a report or upload a PDF from your lab (Dr Lal, SRL, etc.).',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyMedium(isDark),
        ),
        const SizedBox(height: 48),
        _buildActionCard(
          icon: Icons.camera_alt_rounded,
          title: 'Take Photo',
          subtitle: 'Best for printed paper reports',
          onTap: () => _pickImage(ImageSource.camera),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildActionCard(
          icon: Icons.picture_as_pdf_rounded,
          title: 'Upload PDF',
          subtitle: 'Import digital reports directly',
          onTap: _pickPdf,
          isDark: isDark,
        ),
        const SizedBox(height: 40),
        _buildSecurityNote(isDark),
      ],
    );
  }

  Widget _buildProcessingState(bool isDark) {
    return Column(
      children: [
        _buildFilePreview(isDark),
        const SizedBox(height: 24),
        if (_isProcessing)
          const ShimmerLoader()
        else if (_extraction == null || _extraction!.markers.isEmpty)
          _buildNoDataState(isDark)
        else
          _buildReviewState(isDark),
      ],
    );
  }

  Widget _buildFilePreview(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          Icon(_isPdf ? Icons.picture_as_pdf : Icons.image, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _file!.path.split('/').last,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.labelMedium(isDark),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => setState(() {
              _file = null;
              _extraction = null;
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewState(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Review Extracted Data', style: AppTextStyles.h3(isDark)),
            if (_extraction?.labName != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(_extraction!.labName!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
          ],
        ),
        const SizedBox(height: 16),
        ..._extraction!.markers.asMap().entries.map((entry) {
          final i = entry.key;
          final marker = entry.value;
          return LabValueRow(
            name: marker.name,
            hindiName: marker.nameHi,
            initialValue: marker.value,
            unit: marker.unit,
            classification: _getClassification(marker),
            onValueChanged: (val) {
              setState(() {
                _extraction!.markers[i] = marker.copyWith(value: val);
              });
            },
            onConfirmChanged: (val) {
              setState(() {
                _extraction!.markers[i] = marker.copyWith(isConfirmed: val);
              });
            },
          );
        }),
        const SizedBox(height: 24),
        _buildRetentionToggle(isDark),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _extraction!.markers.any((m) => m.isConfirmed) ? _importResults : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              disabledBackgroundColor: AppColors.divider,
            ),
            child: const Text('Confirm & Save to Health Logs', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildRetentionToggle(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(Icons.history_edu, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Retain raw OCR transcription', style: AppTextStyles.labelMedium(isDark)),
                const Text('Stores the extracted text locally for future reference.', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Switch.adaptive(
            value: _retainOcrText,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _retainOcrText = val),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataState(bool isDark) {
    return Column(
      children: [
        const SizedBox(height: 48),
        const Icon(Icons.search_off_rounded, size: 64, color: AppColors.error),
        const SizedBox(height: 16),
        Text('No Health Markers Found', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 12),
        const Text(
          'We couldn\'t identify any glucose, BP, or vitamin values in this report. Please ensure the photo is clear and well-lit.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        TextButton.icon(
          onPressed: () => setState(() => _file = null),
          icon: const Icon(Icons.refresh),
          label: const Text('Try Another File'),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColorsDark.surface : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelLarge(isDark)),
                  Text(subtitle, style: AppTextStyles.bodySmall(isDark)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.divider),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityNote(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield_outlined, color: AppColors.success, size: 14),
          const SizedBox(width: 8),
          Text(
            'Secure On-Device Processing',
            style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  LabClassification _getClassification(LabMarker marker) {
    if (marker.name.contains('Glucose')) {
      if (marker.value < 100) return LabClassification.normal;
      if (marker.value < 126) return LabClassification.borderline;
      return LabClassification.risk;
    }
    if (marker.name.contains('BP')) {
        // Simple logic for individual values
        if (marker.name.contains('Systolic')) {
            if (marker.value < 120) return LabClassification.normal;
            if (marker.value < 140) return LabClassification.borderline;
            return LabClassification.risk;
        }
    }
    return LabClassification.normal;
  }
}
