// lib/features/lab_reports/data/lab_report_providers.dart
// Riverpod providers for Lab Reports feature

import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/lab_reports/data/lab_report_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for Lab Report Service
final labReportServiceProvider = Provider<LabReportService>((ref) {
  final service = LabReportService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for user ID
final labReportUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// State for lab report scanning
class LabReportScanState {
  final bool isLoading;
  final String? error;
  final File? selectedFile;
  final String? extractedText;
  final ExtractedLabReportData? extractedData;
  final int
  currentStep; // 0 = select source, 1 = processing, 2 = confirm, 3 = saving

  const LabReportScanState({
    this.isLoading = false,
    this.error,
    this.selectedFile,
    this.extractedText,
    this.extractedData,
    this.currentStep = 0,
  });

  LabReportScanState copyWith({
    bool? isLoading,
    String? error,
    File? selectedFile,
    String? extractedText,
    ExtractedLabReportData? extractedData,
    int? currentStep,
    bool clearError = false,
    bool clearFile = false,
    bool clearData = false,
  }) {
    return LabReportScanState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedFile: clearFile ? null : (selectedFile ?? this.selectedFile),
      extractedText: clearData ? null : (extractedText ?? this.extractedText),
      extractedData: clearData ? null : (extractedData ?? this.extractedData),
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

/// Notifier for lab report scanning state - using Riverpod 3.x pattern
class LabReportScanNotifier extends Notifier<LabReportScanState> {
  @override
  LabReportScanState build() {
    return const LabReportScanState();
  }

  LabReportService get _service => ref.read(labReportServiceProvider);

  /// Pick image from camera
  Future<void> pickFromCamera() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final file = await _service.pickImageFromCamera();
      if (file != null) {
        state = state.copyWith(
          selectedFile: file,
          isLoading: false,
          currentStep: 1,
        );
        await _processImage(file);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);
      final file = await _service.pickImageFromGallery();
      if (file != null) {
        state = state.copyWith(
          selectedFile: file,
          isLoading: false,
          currentStep: 1,
        );
        await _processImage(file);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Process the selected image
  Future<void> _processImage(File file) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);

      // Extract text using OCR
      final text = await _service.extractTextFromImage(file);
      state = state.copyWith(extractedText: text);

      // Extract values using regex (fallback when LLM unavailable)
      final extractedData = _service.extractLabValuesWithRegex(rawText: text);

      state = state.copyWith(
        extractedData: extractedData,
        isLoading: false,
        currentStep: 2,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Update a specific extracted value
  void updateValue(String field, String value) {
    if (state.extractedData != null) {
      final currentData = state.extractedData!;
      ExtractedLabReportData? updatedData;

      switch (field) {
        case 'glucose':
          updatedData = currentData.copyWith(glucose: value);
          break;
        case 'hemoglobin':
          updatedData = currentData.copyWith(hemoglobin: value);
          break;
        case 'cholesterolTotal':
          updatedData = currentData.copyWith(cholesterolTotal: value);
          break;
        case 'cholesterolLDL':
          updatedData = currentData.copyWith(cholesterolLDL: value);
          break;
        case 'cholesterolHDL':
          updatedData = currentData.copyWith(cholesterolHDL: value);
          break;
        case 'tsh':
          updatedData = currentData.copyWith(tsh: value);
          break;
        case 'creatinine':
          updatedData = currentData.copyWith(creatinine: value);
          break;
        case 'vitaminD':
          updatedData = currentData.copyWith(vitaminD: value);
          break;
        case 'vitaminB12':
          updatedData = currentData.copyWith(vitaminB12: value);
          break;
        default:
          return;
      }

      if (updatedData != null) {
        state = state.copyWith(extractedData: updatedData);
      }
    }
  }

  /// Set saving state
  void setSaving() {
    state = state.copyWith(isLoading: true, currentStep: 3);
  }

  /// Reset state
  void reset() {
    state = const LabReportScanState();
  }

  /// Go back to previous step
  void goBack() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }
}

/// Provider for lab report scan state
final labReportScanProvider =
    NotifierProvider<LabReportScanNotifier, LabReportScanState>(() {
      return LabReportScanNotifier();
    });

/// Provider for checking if user has any lab data
final hasLabDataProvider = FutureProvider<bool>((ref) async {
  // This would check the database for any lab reports
  // For now, return false - to be implemented with database
  return false;
});

/// Provider for last lab report date
final lastLabReportDateProvider = FutureProvider<DateTime?>((ref) async {
  // This would query the database for the most recent lab report
  // For now, return null - to be implemented with database
  return null;
});
