import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class LabValue {
  final String name;
  final double value;
  final String unit;

  LabValue({required this.name, required this.value, required this.unit});
}

class LabReportExtraction {
  final List<LabValue> values;
  LabReportExtraction(this.values);
}

class LabReportOcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Processes a lab report image and extracts health markers.
  Future<LabReportExtraction> recognizeLabReport(InputImage inputImage) async {
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    final String text = recognizedText.text.toLowerCase();
    
    final List<LabValue> extracted = [];

    // Regex Mapping: Metric -> Pattern
    final patterns = {
      'Glucose (Fasting)': r'(fasting glucose|glucose fasting|sugar fasting)\D*(\d+\.?\d*)\s*(mg/dl|mmol/l)?',
      'HbA1c': r'(hba1c|hemoglobin a1c)\D*(\d+\.?\d*)\s*(%)?',
      'Hemoglobin': r'(hemoglobin|hgb)\D*(\d+\.?\d*)\s*(g/dl|g/l)?',
      'Cholesterol': r'(total cholesterol|cholesterol total)\D*(\d+\.?\d*)\s*(mg/dl|mmol/l)?',
      'Vitamin D': r'(vitamin d|vit d|25-oh vit d)\D*(\d+\.?\d*)\s*(ng/ml|nmol/l)?',
      'Vitamin B12': r'(vitamin b12|b12|cobalamin)\D*(\d+\.?\d*)\s*(pg/ml|pmol/l)?',
      'TSH': r'(tsh|thyroid stimulating hormone)\D*(\d+\.?\d*)\s*(uiu/ml|mu/l)?',
      'Creatinine': r'(creatinine|serum creatinine)\D*(\d+\.?\d*)\s*(mg/dl|umol/l)?',
    };

    patterns.forEach((name, pattern) {
      final regex = RegExp(pattern);
      final match = regex.firstMatch(text);
      if (match != null) {
        final value = double.tryParse(match.group(2) ?? '');
        final unit = match.group(3) ?? '';
        if (value != null) {
          extracted.add(LabValue(name: name, value: value, unit: unit));
        }
      }
    });

    return LabReportExtraction(extracted);
  }

  void dispose() {
    _textRecognizer.close();
  }
}
