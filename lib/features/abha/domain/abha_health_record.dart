enum AbhaRecordType { bloodPressure, glucose, labReport, prescription, unknown }

class AbhaHealthRecord {
  final String id;
  final AbhaRecordType type;
  final String source; // e.g., 'Apollo Clinics', 'Dr Lal PathLabs'
  final DateTime date;
  final bool isImported;
  final Map<String, dynamic> rawData; // FHIR/JSON structure

  const AbhaHealthRecord({
    required this.id,
    required this.type,
    required this.source,
    required this.date,
    this.isImported = false,
    required this.rawData,
  });

  factory AbhaHealthRecord.fromJson(Map<String, dynamic> json) {
    final typeStr = json['type'] as String? ?? 'unknown';
    final type = _parseType(typeStr);
    
    return AbhaHealthRecord(
      id: json['id'] as String,
      type: type,
      source: json['source'] as String? ?? 'Unknown Source',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      rawData: json['raw_data'] as Map<String, dynamic>? ?? {},
    );
  }

  static AbhaRecordType _parseType(String t) {
    switch (t.toLowerCase()) {
      case 'blood_pressure': return AbhaRecordType.bloodPressure;
      case 'glucose': return AbhaRecordType.glucose;
      case 'lab_report': return AbhaRecordType.labReport;
      case 'prescription': return AbhaRecordType.prescription;
      default: return AbhaRecordType.unknown;
    }
  }

  AbhaHealthRecord copyWith({
    bool? isImported,
  }) {
    return AbhaHealthRecord(
      id: id,
      type: type,
      source: source,
      date: date,
      isImported: isImported ?? this.isImported,
      rawData: rawData,
    );
  }
}
