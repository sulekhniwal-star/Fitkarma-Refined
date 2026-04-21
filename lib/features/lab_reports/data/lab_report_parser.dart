import '../domain/models/extraction_result.dart';

class LabReportParser {
  // Regex Patterns for top Indian labs
  static final _patterns = {
    'Glucose (Fasting)': {
      'regex': RegExp(r'(fasting glucose|glucose fasting|sugar fasting|fbs|f\.b\.s)\D*(\d+\.?\d*)\s*(mg/dl|mmol/l)?', caseSensitive: false),
      'hi': 'ग्लूकोज (फास्टिंग)',
      'unit': 'mg/dL'
    },
    'Glucose (PP)': {
      'regex': RegExp(r'(pp glucose|glucose pp|sugar pp|post prandial|2hr pp)\D*(\d+\.?\d*)\s*(mg/dl|mmol/l)?', caseSensitive: false),
      'hi': 'ग्लूकोज (भोजन के बाद)',
      'unit': 'mg/dL'
    },
    'HbA1c': {
      'regex': RegExp(r'(hba1c|hemoglobin a1c|glycosylated hemoglobin)\D*(\d+\.?\d*)\s*(%)?', caseSensitive: false),
      'hi': 'एचबीए1सी (HbA1c)',
      'unit': '%'
    },
    'Hemoglobin': {
      'regex': RegExp(r'(hemoglobin|hgb|hb)\D*(\d+\.?\d*)\s*(g/dl|g/l)?', caseSensitive: false),
      'hi': 'हीमोग्लोबिन',
      'unit': 'g/dL'
    },
    'Systolic BP': {
      'regex': RegExp(r'(systolic|bp systolic)\D*(\d{2,3})\s*(mm\s*hg)?', caseSensitive: false),
      'hi': 'सिस्टोलिक रक्तचाप',
      'unit': 'mmHg'
    },
    'Diastolic BP': {
      'regex': RegExp(r'(diastolic|bp diastolic)\D*(\d{2,3})\s*(mm\s*hg)?', caseSensitive: false),
      'hi': 'डायस्टोलिक रक्तचाप',
      'unit': 'mmHg'
    },
    'Cholesterol': {
      'regex': RegExp(r'(total cholesterol|cholesterol total)\D*(\d+\.?\d*)\s*(mg/dl|mmol/l)?', caseSensitive: false),
      'hi': 'कुल कोलेस्ट्रॉल',
      'unit': 'mg/dL'
    },
    'Vitamin D': {
      'regex': RegExp(r'(vitamin d|vit d|25-oh vit d)\D*(\d+\.?\d*)\s*(ng/ml|nmol/l)?', caseSensitive: false),
      'hi': 'विटामिन डी',
      'unit': 'ng/mL'
    },
    'Vitamin B12': {
      'regex': RegExp(r'(vitamin b12|b12|cobalamin)\D*(\d+\.?\d*)\s*(pg/ml|pmol/l)?', caseSensitive: false),
      'hi': 'विटामिन बी12',
      'unit': 'pg/mL'
    },
    'TSH': {
      'regex': RegExp(r'(tsh|thyroid stimulating hormone)\D*(\d+\.?\d*)\s*(uiu/ml|mu/l)?', caseSensitive: false),
      'hi': 'टीएसएच (TSH)',
      'unit': 'uIU/mL'
    },
    'Creatinine': {
      'regex': RegExp(r'(creatinine|serum creatinine)\D*(\d+\.?\d*)\s*(mg/dl|umol/l)?', caseSensitive: false),
      'hi': 'क्रिएटिनिन',
      'unit': 'mg/dL'
    },
  };

  LabReportExtraction parse(String text) {
    final List<LabMarker> markers = [];
    final lowerText = text.toLowerCase();

    _patterns.forEach((name, data) {
      final regex = data['regex'] as RegExp;
      final matches = regex.allMatches(lowerText);
      
      for (final match in matches) {
        final valueStr = match.group(2);
        if (valueStr != null) {
          final value = double.tryParse(valueStr);
          if (value != null) {
              markers.add(LabMarker(
                name: name,
                nameHi: data['hi'] as String,
                value: value,
                unit: data['unit'] as String,
                confidence: 0.9, // Base confidence for regex match
              ));
              // Once we find a marker, we stop searching for that specific one
              // (e.g. don't pick multiple glucose readings if found)
              break; 
          }
        }
      }
    });

    // Extract Lab Name (Simple heuristic)
    String? labName;
    if (lowerText.contains('dr lal pathlabs')) labName = 'Dr Lal PathLabs';
    else if (lowerText.contains('srl diagnostics')) labName = 'SRL Diagnostics';
    else if (lowerText.contains('apollo diagnostics')) labName = 'Apollo Diagnostics';
    else if (lowerText.contains('thyrocare')) labName = 'Thyrocare';

    return LabReportExtraction(
      markers: markers,
      reportDate: DateTime.now(), // Fallback
      labName: labName,
      rawText: text,
    );
  }
}
