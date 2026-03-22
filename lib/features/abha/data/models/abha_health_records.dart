/// ABHA Health Record model for prescriptions and discharge summaries
class ABHAHealthRecord {
  final String id;
  final String
  recordType; // 'prescription' | 'discharge_summary' | 'lab_report'
  final String? visitId;
  final String? facilityName;
  final DateTime? recordDate;
  final String? diagnosis;
  final List<String> medications;
  final String? doctorName;
  final String? prescriptionUrl;
  final Map<String, dynamic>? rawData;

  const ABHAHealthRecord({
    required this.id,
    required this.recordType,
    this.visitId,
    this.facilityName,
    this.recordDate,
    this.diagnosis,
    this.medications = const [],
    this.doctorName,
    this.prescriptionUrl,
    this.rawData,
  });

  factory ABHAHealthRecord.fromJson(Map<String, dynamic> json) {
    return ABHAHealthRecord(
      id: json['id'] as String? ?? json['recordId'] as String? ?? '',
      recordType:
          json['recordType'] as String? ??
          json['type'] as String? ??
          'prescription',
      visitId: json['visitId'] as String?,
      facilityName:
          json['facilityName'] as String? ?? json['hospitalName'] as String?,
      recordDate: json['recordDate'] != null
          ? DateTime.tryParse(json['recordDate'] as String)
          : json['date'] != null
          ? DateTime.tryParse(json['date'] as String)
          : null,
      diagnosis: json['diagnosis'] as String?,
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      doctorName: json['doctorName'] as String? ?? json['physician'] as String?,
      prescriptionUrl:
          json['prescriptionUrl'] as String? ?? json['documentUrl'] as String?,
      rawData: json,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'recordType': recordType,
    'visitId': visitId,
    'facilityName': facilityName,
    'recordDate': recordDate?.toIso8601String(),
    'diagnosis': diagnosis,
    'medications': medications,
    'doctorName': doctorName,
    'prescriptionUrl': prescriptionUrl,
  };

  /// Get display title for the record
  String get displayTitle {
    if (diagnosis != null && diagnosis!.isNotEmpty) {
      return diagnosis!;
    }
    switch (recordType) {
      case 'prescription':
        return 'Prescription';
      case 'discharge_summary':
        return 'Discharge Summary';
      case 'lab_report':
        return 'Lab Report';
      default:
        return 'Health Record';
    }
  }

  /// Get icon for record type
  String get recordTypeIcon {
    switch (recordType) {
      case 'prescription':
        return '📝';
      case 'discharge_summary':
        return '🏥';
      case 'lab_report':
        return '🔬';
      default:
        return '📋';
    }
  }
}

/// ABHA prescription model
class ABHAPrescription extends ABHAHealthRecord {
  const ABHAPrescription({
    required super.id,
    super.visitId,
    super.facilityName,
    super.recordDate,
    super.diagnosis,
    super.medications,
    super.doctorName,
    super.prescriptionUrl,
    super.rawData,
  }) : super(recordType: 'prescription');

  factory ABHAPrescription.fromJson(Map<String, dynamic> json) {
    return ABHAPrescription(
      id: json['id'] as String? ?? '',
      visitId: json['visitId'] as String?,
      facilityName: json['facilityName'] as String?,
      recordDate: json['recordDate'] != null
          ? DateTime.tryParse(json['recordDate'] as String)
          : null,
      diagnosis: json['diagnosis'] as String?,
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      doctorName: json['doctorName'] as String?,
      prescriptionUrl: json['prescriptionUrl'] as String?,
      rawData: json,
    );
  }
}

/// ABHA discharge summary model
class ABHADischargeSummary extends ABHAHealthRecord {
  final String? dischargeDate;
  final String? dischargeCondition;
  final String? followUpInstructions;

  const ABHADischargeSummary({
    required super.id,
    super.visitId,
    super.facilityName,
    super.recordDate,
    super.diagnosis,
    super.medications,
    super.doctorName,
    super.prescriptionUrl,
    super.rawData,
    this.dischargeDate,
    this.dischargeCondition,
    this.followUpInstructions,
  }) : super(recordType: 'discharge_summary');

  factory ABHADischargeSummary.fromJson(Map<String, dynamic> json) {
    return ABHADischargeSummary(
      id: json['id'] as String? ?? '',
      visitId: json['visitId'] as String?,
      facilityName: json['facilityName'] as String?,
      recordDate: json['recordDate'] != null
          ? DateTime.tryParse(json['recordDate'] as String)
          : null,
      diagnosis: json['diagnosis'] as String?,
      medications:
          (json['medications'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      doctorName: json['doctorName'] as String?,
      prescriptionUrl: json['prescriptionUrl'] as String?,
      rawData: json,
      dischargeDate: json['dischargeDate'] as String?,
      dischargeCondition: json['dischargeCondition'] as String?,
      followUpInstructions: json['followUpInstructions'] as String?,
    );
  }
}

/// ABHA records fetch result
class ABHARecordsResult {
  final List<ABHAHealthRecord> records;
  final int totalCount;
  final bool hasMore;
  final String? nextPageToken;
  final String? error;

  const ABHARecordsResult({
    required this.records,
    this.totalCount = 0,
    this.hasMore = false,
    this.nextPageToken,
    this.error,
  });

  factory ABHARecordsResult.fromJson(Map<String, dynamic> json) {
    final recordsList = (json['records'] as List<dynamic>?) ?? [];
    return ABHARecordsResult(
      records: recordsList
          .map((e) => ABHAHealthRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? recordsList.length,
      hasMore: json['hasMore'] as bool? ?? false,
      nextPageToken: json['nextPageToken'] as String?,
      error: json['error'] as String?,
    );
  }

  bool get isEmpty => records.isEmpty;
  bool get hasError => error != null;
}
