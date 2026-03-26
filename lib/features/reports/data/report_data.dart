// lib/features/reports/data/report_data.dart
// Data models for health reports

import 'dart:convert';

/// Report period type
enum ReportPeriod { weekly, monthly }

/// Blood pressure data point
class BpDataPoint {
  final DateTime timestamp;
  final int systolic;
  final int diastolic;
  final int? pulse;
  final String classification;

  BpDataPoint({
    required this.timestamp,
    required this.systolic,
    required this.diastolic,
    this.pulse,
    required this.classification,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'systolic': systolic,
    'diastolic': diastolic,
    'pulse': pulse,
    'classification': classification,
  };

  factory BpDataPoint.fromJson(Map<String, dynamic> json) => BpDataPoint(
    timestamp: DateTime.parse(json['timestamp']),
    systolic: json['systolic'],
    diastolic: json['diastolic'],
    pulse: json['pulse'],
    classification: json['classification'],
  );
}

/// Glucose data point
class GlucoseDataPoint {
  final DateTime timestamp;
  final double glucoseMgdl;
  final String readingType; // fasting, before_meal, after_meal, bedtime
  final String classification;

  GlucoseDataPoint({
    required this.timestamp,
    required this.glucoseMgdl,
    required this.readingType,
    required this.classification,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'glucoseMgdl': glucoseMgdl,
    'readingType': readingType,
    'classification': classification,
  };

  factory GlucoseDataPoint.fromJson(Map<String, dynamic> json) =>
      GlucoseDataPoint(
        timestamp: DateTime.parse(json['timestamp']),
        glucoseMgdl: (json['glucoseMgdl'] as num).toDouble(),
        readingType: json['readingType'],
        classification: json['classification'],
      );
}

/// Weight/body measurement data point
class WeightDataPoint {
  final DateTime timestamp;
  final double weightKg;
  final double? bodyFatPercentage;

  WeightDataPoint({
    required this.timestamp,
    required this.weightKg,
    this.bodyFatPercentage,
  });

  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'weightKg': weightKg,
    'bodyFatPercentage': bodyFatPercentage,
  };

  factory WeightDataPoint.fromJson(Map<String, dynamic> json) =>
      WeightDataPoint(
        timestamp: DateTime.parse(json['timestamp']),
        weightKg: (json['weightKg'] as num).toDouble(),
        bodyFatPercentage: json['bodyFatPercentage'] != null
            ? (json['bodyFatPercentage'] as num).toDouble()
            : null,
      );
}

/// Lab report value
class LabValue {
  final String name;
  final String value;
  final String unit;
  final String? referenceRange;
  final bool isHigh;
  final bool isLow;

  LabValue({
    required this.name,
    required this.value,
    required this.unit,
    this.referenceRange,
    required this.isHigh,
    required this.isLow,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value,
    'unit': unit,
    'referenceRange': referenceRange,
    'isHigh': isHigh,
    'isLow': isLow,
  };

  factory LabValue.fromJson(Map<String, dynamic> json) => LabValue(
    name: json['name'],
    value: json['value'],
    unit: json['unit'],
    referenceRange: json['referenceRange'],
    isHigh: json['isHigh'],
    isLow: json['isLow'],
  );
}

/// Aggregated health report data for PDF generation
class HealthReportData {
  final String userName;
  final DateTime generatedAt;
  final ReportPeriod period;
  final DateTime startDate;
  final DateTime endDate;

  // BP statistics
  final List<BpDataPoint> bpReadings;
  final double? avgSystolic;
  final double? avgDiastolic;
  final int? bpReadingsCount;

  // Glucose statistics
  final List<GlucoseDataPoint> glucoseReadings;
  final double? avgGlucose;
  final double? minGlucose;
  final double? maxGlucose;
  final int? glucoseReadingsCount;

  // Weight statistics
  final List<WeightDataPoint> weightReadings;
  final double? currentWeight;
  final double? weightChange;
  final double? avgWeight;

  // Lab values (most recent)
  final List<LabValue> labValues;

  // Summary
  final Map<String, dynamic> summary;

  HealthReportData({
    required this.userName,
    required this.generatedAt,
    required this.period,
    required this.startDate,
    required this.endDate,
    this.bpReadings = const [],
    this.avgSystolic,
    this.avgDiastolic,
    this.bpReadingsCount,
    this.glucoseReadings = const [],
    this.avgGlucose,
    this.minGlucose,
    this.maxGlucose,
    this.glucoseReadingsCount,
    this.weightReadings = const [],
    this.currentWeight,
    this.weightChange,
    this.avgWeight,
    this.labValues = const [],
    this.summary = const {},
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'generatedAt': generatedAt.toIso8601String(),
    'period': period.name,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'bpReadings': bpReadings.map((e) => e.toJson()).toList(),
    'avgSystolic': avgSystolic,
    'avgDiastolic': avgDiastolic,
    'bpReadingsCount': bpReadingsCount,
    'glucoseReadings': glucoseReadings.map((e) => e.toJson()).toList(),
    'avgGlucose': avgGlucose,
    'minGlucose': minGlucose,
    'maxGlucose': maxGlucose,
    'glucoseReadingsCount': glucoseReadingsCount,
    'weightReadings': weightReadings.map((e) => e.toJson()).toList(),
    'currentWeight': currentWeight,
    'weightChange': weightChange,
    'avgWeight': avgWeight,
    'labValues': labValues.map((e) => e.toJson()).toList(),
    'summary': summary,
  };

  factory HealthReportData.fromJson(Map<String, dynamic> json) =>
      HealthReportData(
        userName: json['userName'],
        generatedAt: DateTime.parse(json['generatedAt']),
        period: ReportPeriod.values.firstWhere((e) => e.name == json['period']),
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        bpReadings: (json['bpReadings'] as List)
            .map((e) => BpDataPoint.fromJson(e))
            .toList(),
        avgSystolic: json['avgSystolic']?.toDouble(),
        avgDiastolic: json['avgDiastolic']?.toDouble(),
        bpReadingsCount: json['bpReadingsCount'],
        glucoseReadings: (json['glucoseReadings'] as List)
            .map((e) => GlucoseDataPoint.fromJson(e))
            .toList(),
        avgGlucose: json['avgGlucose']?.toDouble(),
        minGlucose: json['minGlucose']?.toDouble(),
        maxGlucose: json['maxGlucose']?.toDouble(),
        glucoseReadingsCount: json['glucoseReadingsCount'],
        weightReadings: (json['weightReadings'] as List)
            .map((e) => WeightDataPoint.fromJson(e))
            .toList(),
        currentWeight: json['currentWeight']?.toDouble(),
        weightChange: json['weightChange']?.toDouble(),
        avgWeight: json['avgWeight']?.toDouble(),
        labValues: (json['labValues'] as List)
            .map((e) => LabValue.fromJson(e))
            .toList(),
        summary: json['summary'],
      );

  String toJsonString() => jsonEncode(toJson());

  factory HealthReportData.fromJsonString(String jsonString) =>
      HealthReportData.fromJson(jsonDecode(jsonString));
}

/// Shareable health summary (for doctor link)
class DoctorShareableSummary {
  final String userId;
  final String userName;
  final DateTime generatedAt;
  final DateTime expiresAt;
  final String shareToken;

  // 30-day trends (aggregate only)
  final double? avgSystolic;
  final double? avgDiastolic;
  final int bpReadingsCount;

  final double? avgGlucose;
  final double? minGlucose;
  final double? maxGlucose;
  final int glucoseReadingsCount;

  final double? currentWeight;
  final double? weightChange;
  final int weightReadingsCount;

  // Lab values
  final List<LabValue> labValues;

  DoctorShareableSummary({
    required this.userId,
    required this.userName,
    required this.generatedAt,
    required this.expiresAt,
    required this.shareToken,
    this.avgSystolic,
    this.avgDiastolic,
    required this.bpReadingsCount,
    this.avgGlucose,
    this.minGlucose,
    this.maxGlucose,
    required this.glucoseReadingsCount,
    this.currentWeight,
    this.weightChange,
    required this.weightReadingsCount,
    this.labValues = const [],
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'generatedAt': generatedAt.toIso8601String(),
    'expiresAt': expiresAt.toIso8601String(),
    'shareToken': shareToken,
    'avgSystolic': avgSystolic,
    'avgDiastolic': avgDiastolic,
    'bpReadingsCount': bpReadingsCount,
    'avgGlucose': avgGlucose,
    'minGlucose': minGlucose,
    'maxGlucose': maxGlucose,
    'glucoseReadingsCount': glucoseReadingsCount,
    'currentWeight': currentWeight,
    'weightChange': weightChange,
    'weightReadingsCount': weightReadingsCount,
    'labValues': labValues.map((e) => e.toJson()).toList(),
  };

  factory DoctorShareableSummary.fromJson(Map<String, dynamic> json) =>
      DoctorShareableSummary(
        userId: json['userId'],
        userName: json['userName'],
        generatedAt: DateTime.parse(json['generatedAt']),
        expiresAt: DateTime.parse(json['expiresAt']),
        shareToken: json['shareToken'],
        avgSystolic: json['avgSystolic']?.toDouble(),
        avgDiastolic: json['avgDiastolic']?.toDouble(),
        bpReadingsCount: json['bpReadingsCount'],
        avgGlucose: json['avgGlucose']?.toDouble(),
        minGlucose: json['minGlucose']?.toDouble(),
        maxGlucose: json['maxGlucose']?.toDouble(),
        glucoseReadingsCount: json['glucoseReadingsCount'],
        currentWeight: json['currentWeight']?.toDouble(),
        weightChange: json['weightChange']?.toDouble(),
        weightReadingsCount: json['weightReadingsCount'],
        labValues:
            (json['labValues'] as List?)
                ?.map((e) => LabValue.fromJson(e))
                .toList() ??
            [],
      );
}

/// Stored share link info
class ShareLinkInfo {
  final String id;
  final String shareToken;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isRevoked;
  final String? sharedVia; // whatsapp, copy, etc

  ShareLinkInfo({
    required this.id,
    required this.shareToken,
    required this.createdAt,
    required this.expiresAt,
    this.isRevoked = false,
    this.sharedVia,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
  bool get isValid => !isRevoked && !isExpired;

  Map<String, dynamic> toJson() => {
    'id': id,
    'shareToken': shareToken,
    'createdAt': createdAt.toIso8601String(),
    'expiresAt': expiresAt.toIso8601String(),
    'isRevoked': isRevoked,
    'sharedVia': sharedVia,
  };

  factory ShareLinkInfo.fromJson(Map<String, dynamic> json) => ShareLinkInfo(
    id: json['id'],
    shareToken: json['shareToken'],
    createdAt: DateTime.parse(json['createdAt']),
    expiresAt: DateTime.parse(json['expiresAt']),
    isRevoked: json['isRevoked'] ?? false,
    sharedVia: json['sharedVia'],
  );
}
