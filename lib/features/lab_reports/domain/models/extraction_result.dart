class LabMarker {
  final String name;
  final String nameHi;
  final double value;
  final String unit;
  bool isConfirmed;
  final double confidence;

  LabMarker({
    required this.name,
    required this.nameHi,
    required this.value,
    required this.unit,
    this.isConfirmed = false,
    this.confidence = 1.0,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'nameHi': nameHi,
    'value': value,
    'unit': unit,
    'isConfirmed': isConfirmed,
    'confidence': confidence,
  };

  factory LabMarker.fromJson(Map<String, dynamic> json) => LabMarker(
    name: json['name'],
    nameHi: json['nameHi'],
    value: (json['value'] as num).toDouble(),
    unit: json['unit'],
    isConfirmed: json['isConfirmed'] ?? false,
    confidence: (json['confidence'] as num?)?.toDouble() ?? 1.0,
  );

  LabMarker copyWith({
    String? name,
    String? nameHi,
    double? value,
    String? unit,
    bool? isConfirmed,
    double? confidence,
  }) {
    return LabMarker(
      name: name ?? this.name,
      nameHi: nameHi ?? this.nameHi,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      confidence: confidence ?? this.confidence,
    );
  }
}

class LabReportExtraction {
  final List<LabMarker> markers;
  final DateTime reportDate;
  final String? labName;
  final String? rawText;
  final String source;

  LabReportExtraction({
    required this.markers,
    required this.reportDate,
    this.labName,
    this.rawText,
    this.source = 'ocr',
  });

  Map<String, dynamic> toJson() => {
    'markers': markers.map((m) => m.toJson()).toList(),
    'reportDate': reportDate.toIso8601String(),
    'labName': labName,
    'rawText': rawText,
    'source': source,
  };

  factory LabReportExtraction.fromJson(Map<String, dynamic> json) => LabReportExtraction(
    markers: (json['markers'] as List).map((m) => LabMarker.fromJson(m)).toList(),
    reportDate: DateTime.parse(json['reportDate']),
    labName: json['labName'],
    rawText: json['rawText'],
    source: json['source'] ?? 'ocr',
  );

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
