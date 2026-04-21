import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../domain/models/extraction_result.dart';
import 'lab_report_parser.dart';
import 'pdf_converter_service.dart';

class LabReportOcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final _parser = LabReportParser();
  final _pdfConverter = PdfConverterService();

  /// Processes a lab report (Image or PDF) and extracts health markers.
  Future<LabReportExtraction> processLabReport(String filePath) async {
    final extension = filePath.split('.').last.toLowerCase();
    
    if (extension == 'pdf') {
      return _processPdf(filePath);
    } else {
      return _processImage(filePath);
    }
  }

  Future<LabReportExtraction> _processImage(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    return _parser.parse(recognizedText.text);
  }

  Future<LabReportExtraction> _processPdf(String pdfPath) async {
    // 1. Convert PDF pages to images
    final imagePaths = await _pdfConverter.convertPdfToImages(pdfPath);
    
    String combinedText = '';
    
    // 2. Process each page image
    for (final path in imagePaths) {
      final inputImage = InputImage.fromFilePath(path);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      combinedText += '${recognizedText.text}\n';
      
      // Clean up temp image
      try {
        await File(path).delete();
      } catch (_) {}
    }

    // 3. Parse combined text
    final extraction = _parser.parse(combinedText);
    
    // Set source as PDF
    return extraction.copyWith(source: 'ocr_pdf');
  }

  void dispose() {
    _textRecognizer.close();
  }
}

// Add copyWith to LabReportExtraction if not using Freezed
extension LabReportExtractionExtension on LabReportExtraction {
    LabReportExtraction copyWith({
        List<LabMarker>? markers,
        DateTime? reportDate,
        String? labName,
        String? rawText,
        String? source,
    }) {
        return LabReportExtraction(
            markers: markers ?? this.markers,
            reportDate: reportDate ?? this.reportDate,
            labName: labName ?? this.labName,
            rawText: rawText ?? this.rawText,
            source: source ?? this.source,
        );
    }
}

// Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

final labReportOcrServiceProvider = Provider<LabReportOcrService>((ref) {
  final service = LabReportOcrService();
  ref.onDispose(() => service.dispose());
  return service;
});

@Deprecated('Use labReportOcrServiceProvider instead')
final labReportOcrService = Provider((ref) => LabReportOcrService());
