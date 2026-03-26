// lib/features/reports/data/pdf_report_service.dart
// PDF Report Generation Service with Dart Isolate support

import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'report_data.dart';

/// DateFormat type alias
typedef DateTimeFormat = DateFormat;

/// Reference ranges for medical metrics
class MedicalReferenceRanges {
  // Blood Pressure (mmHg)
  static const bpNormal = '90-120/60-80';
  static const bpElevated = '120-129/<80';
  static const bpHigh1 = '130-139/80-89';
  static const bpHigh2 = '≥140/≥90';

  // Glucose (mg/dL)
  static const glucoseFastingNormal = '70-99';
  static const glucoseFastingPrediabetes = '100-125';
  static const glucoseFastingDiabetes = '≥126';
  static const glucoseAfterMealNormal = '<140';
  static const glucoseAfterMealPrediabetes = '140-199';
  static const glucoseAfterMealDiabetes = '≥200';

  // Weight/BMI
  static const bmiUnderweight = '<18.5';
  static const bmiNormal = '18.5-24.9';
  static const bmiOverweight = '25-29.9';
  static const bmiObese = '≥30';

  // Common Lab Values (simplified reference ranges)
  static const Map<String, String> labReferenceRanges = {
    'Hemoglobin': '12-16 g/dL (F), 14-17 g/dL (M)',
    'HbA1c': '<5.7%',
    'Total Cholesterol': '<200 mg/dL',
    'LDL': '<100 mg/dL',
    'HDL': '>40 mg/dL (M), >50 mg/dL (F)',
    'Triglycerides': '<150 mg/dL',
    'Creatinine': '0.7-1.3 mg/dL (M), 0.6-1.1 mg/dL (F)',
    'BUN': '7-20 mg/dL',
    'Sodium': '136-145 mEq/L',
    'Potassium': '3.5-5.0 mEq/L',
    'TSH': '0.4-4.0 mIU/L',
    'Vitamin D': '30-100 ng/mL',
    'Vitamin B12': '200-900 pg/mL',
    'Iron': '60-170 μg/dL (M), 50-150 μg/dL (F)',
    'Ferritin': '20-200 ng/mL',
  };
}

/// Data passed to isolate for PDF generation
class PdfGenerationParams {
  final String reportJson;
  final bool isWeekly;

  PdfGenerationParams({required this.reportJson, required this.isWeekly});
}

/// PDF Report Generation Service
class PdfReportService {
  static final PdfReportService _instance = PdfReportService._internal();
  factory PdfReportService() => _instance;
  PdfReportService._internal();

  final _dateFormat = DateFormat('MMM dd, yyyy');
  final _dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

  /// Generate PDF report in an isolate for better performance
  Future<Uint8List> generatePdfInIsolate(HealthReportData reportData) async {
    // Send data to isolate for processing
    final params = PdfGenerationParams(
      reportJson: reportData.toJsonString(),
      isWeekly: reportData.period == ReportPeriod.weekly,
    );

    // Use Isolate.run for Dart 2.17+
    final result = await Isolate.run(() => _generatePdfSync(params));
    return result;
  }

  /// Generate PDF report synchronously (runs in isolate)
  static Uint8List _generatePdfSync(PdfGenerationParams params) {
    final pdf = pw.Document();
    final reportData = HealthReportData.fromJsonString(params.reportJson);
    final isWeekly = params.isWeekly;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');

    final title = isWeekly ? 'Weekly Health Report' : 'Monthly Health Report';
    final periodStr =
        '${dateFormat.format(reportData.startDate)} - ${dateFormat.format(reportData.endDate)}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) =>
            _buildHeaderStatic(title, periodStr, reportData, dateTimeFormat),
        footer: (context) => _buildFooterStatic(context),
        build: (context) => [
          // Summary Section
          _buildSummarySectionStatic(reportData),
          pw.SizedBox(height: 20),

          // Blood Pressure Section
          if (reportData.bpReadings.isNotEmpty) ...[
            _buildBloodPressureSectionStatic(reportData, dateFormat),
            pw.SizedBox(height: 20),
          ],

          // Glucose Section
          if (reportData.glucoseReadings.isNotEmpty) ...[
            _buildGlucoseSectionStatic(reportData, dateFormat),
            pw.SizedBox(height: 20),
          ],

          // Weight Section
          if (reportData.weightReadings.isNotEmpty) ...[
            _buildWeightSectionStatic(reportData, dateFormat),
            pw.SizedBox(height: 20),
          ],

          // Lab Values Section
          if (reportData.labValues.isNotEmpty) ...[
            _buildLabValuesSectionStatic(reportData),
          ],
        ],
      ),
    );

    // Synchronous save
    return pdf.save() as Uint8List;
  }

  static pw.Widget _buildHeaderStatic(
    String title,
    String periodStr,
    HealthReportData data,
    DateTimeFormat dateTimeFormat,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: const pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Fitkarma Health Report',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.teal700,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                title,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                periodStr,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                'Patient: ${data.userName}',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                'Generated: ${dateTimeFormat.format(data.generatedAt)}',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooterStatic(pw.Context context) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 8),
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
      ),
    );
  }

  static pw.Widget _buildSummarySectionStatic(HealthReportData data) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            '📊 Health Summary',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 12),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItemStatic(
                'BP Readings',
                '${data.bpReadingsCount ?? 0}',
                'Total entries',
              ),
              _buildSummaryItemStatic(
                'Avg BP',
                data.avgSystolic != null
                    ? '${data.avgSystolic!.toStringAsFixed(0)}/${data.avgDiastolic?.toStringAsFixed(0) ?? "--"}'
                    : '--/--',
                'mmHg',
              ),
              _buildSummaryItemStatic(
                'Glucose Readings',
                '${data.glucoseReadingsCount ?? 0}',
                'Total entries',
              ),
              _buildSummaryItemStatic(
                'Avg Glucose',
                data.avgGlucose?.toStringAsFixed(0) ?? '--',
                'mg/dL',
              ),
              _buildSummaryItemStatic(
                'Current Weight',
                data.currentWeight?.toStringAsFixed(1) ?? '--',
                'kg',
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSummaryItemStatic(
    String title,
    String value,
    String subtitle,
  ) {
    return pw.Column(
      children: [
        pw.Text(
          title,
          style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal700,
          ),
        ),
        pw.Text(
          subtitle,
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey500),
        ),
      ],
    );
  }

  static pw.Widget _buildBloodPressureSectionStatic(
    HealthReportData data,
    DateFormat dateFormat,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: PdfColors.red50,
          child: pw.Row(
            children: [
              pw.Text(
                '💓 Blood Pressure',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.red700,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Reference: ${MedicalReferenceRanges.bpNormal}',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 12),
        _buildBpStatsTableStatic(data),
        pw.SizedBox(height: 12),
        if (data.bpReadings.isNotEmpty) ...[
          pw.Text(
            'Recent Readings:',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _buildBpReadingsTableStatic(
            data.bpReadings.take(14).toList(),
            dateFormat,
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildBpStatsTableStatic(HealthReportData data) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Average', isHeader: true),
            _buildTableCellStatic('Minimum', isHeader: true),
            _buildTableCellStatic('Maximum', isHeader: true),
            _buildTableCellStatic('Total Readings', isHeader: true),
          ],
        ),
        pw.TableRow(
          children: [
            _buildTableCellStatic(
              data.avgSystolic != null
                  ? '${data.avgSystolic!.toStringAsFixed(0)}/${data.avgDiastolic?.toStringAsFixed(0) ?? ""} mmHg'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.bpReadings.isNotEmpty
                  ? '${data.bpReadings.map((e) => e.systolic).reduce((a, b) => a < b ? a : b)}/${data.bpReadings.map((e) => e.diastolic).reduce((a, b) => a < b ? a : b)} mmHg'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.bpReadings.isNotEmpty
                  ? '${data.bpReadings.map((e) => e.systolic).reduce((a, b) => a > b ? a : b)}/${data.bpReadings.map((e) => e.diastolic).reduce((a, b) => a > b ? a : b)} mmHg'
                  : 'N/A',
            ),
            _buildTableCellStatic('${data.bpReadingsCount ?? 0}'),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildBpReadingsTableStatic(
    List<BpDataPoint> readings,
    DateFormat dateFormat,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(1.5),
        2: const pw.FlexColumnWidth(1.5),
        3: const pw.FlexColumnWidth(1),
        4: const pw.FlexColumnWidth(1.5),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Date', isHeader: true),
            _buildTableCellStatic('Systolic', isHeader: true),
            _buildTableCellStatic('Diastolic', isHeader: true),
            _buildTableCellStatic('Pulse', isHeader: true),
            _buildTableCellStatic('Classification', isHeader: true),
          ],
        ),
        ...readings.map(
          (bp) => pw.TableRow(
            children: [
              _buildTableCellStatic(dateFormat.format(bp.timestamp)),
              _buildTableCellStatic('${bp.systolic} mmHg'),
              _buildTableCellStatic('${bp.diastolic} mmHg'),
              _buildTableCellStatic(bp.pulse != null ? '${bp.pulse} bpm' : '-'),
              _buildTableCellStatic(
                bp.classification,
                color: _getClassificationColor(bp.classification),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildGlucoseSectionStatic(
    HealthReportData data,
    DateFormat dateFormat,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: PdfColors.blue50,
          child: pw.Row(
            children: [
              pw.Text(
                '🩸 Glucose',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.blue700,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Reference (fasting): ${MedicalReferenceRanges.glucoseFastingNormal}',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 12),
        _buildGlucoseStatsTableStatic(data),
        pw.SizedBox(height: 12),
        if (data.glucoseReadings.isNotEmpty) ...[
          pw.Text(
            'Recent Readings:',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _buildGlucoseReadingsTableStatic(
            data.glucoseReadings.take(14).toList(),
            dateFormat,
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildGlucoseStatsTableStatic(HealthReportData data) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Average', isHeader: true),
            _buildTableCellStatic('Minimum', isHeader: true),
            _buildTableCellStatic('Maximum', isHeader: true),
            _buildTableCellStatic('Total Readings', isHeader: true),
          ],
        ),
        pw.TableRow(
          children: [
            _buildTableCellStatic(
              data.avgGlucose != null
                  ? '${data.avgGlucose!.toStringAsFixed(0)} mg/dL'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.minGlucose != null
                  ? '${data.minGlucose!.toStringAsFixed(0)} mg/dL'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.maxGlucose != null
                  ? '${data.maxGlucose!.toStringAsFixed(0)} mg/dL'
                  : 'N/A',
            ),
            _buildTableCellStatic('${data.glucoseReadingsCount ?? 0}'),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildGlucoseReadingsTableStatic(
    List<GlucoseDataPoint> readings,
    DateFormat dateFormat,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(1.5),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(1.5),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Date', isHeader: true),
            _buildTableCellStatic('Glucose', isHeader: true),
            _buildTableCellStatic('Reading Type', isHeader: true),
            _buildTableCellStatic('Classification', isHeader: true),
          ],
        ),
        ...readings.map(
          (glucose) => pw.TableRow(
            children: [
              _buildTableCellStatic(dateFormat.format(glucose.timestamp)),
              _buildTableCellStatic(
                '${glucose.glucoseMgdl.toStringAsFixed(0)} mg/dL',
              ),
              _buildTableCellStatic(_formatReadingType(glucose.readingType)),
              _buildTableCellStatic(
                glucose.classification,
                color: _getClassificationColor(glucose.classification),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildWeightSectionStatic(
    HealthReportData data,
    DateFormat dateFormat,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: PdfColors.green50,
          child: pw.Row(
            children: [
              pw.Text(
                '⚖️ Weight & Body Measurements',
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green700,
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Reference (BMI): ${MedicalReferenceRanges.bmiNormal}',
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey600,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 12),
        _buildWeightStatsTableStatic(data),
        pw.SizedBox(height: 12),
        if (data.weightReadings.isNotEmpty) ...[
          pw.Text(
            'Recent Readings:',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          _buildWeightReadingsTableStatic(
            data.weightReadings.take(10).toList(),
            dateFormat,
          ),
        ],
      ],
    );
  }

  static pw.Widget _buildWeightStatsTableStatic(HealthReportData data) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Current', isHeader: true),
            _buildTableCellStatic('Average', isHeader: true),
            _buildTableCellStatic('Change', isHeader: true),
            _buildTableCellStatic('Total Readings', isHeader: true),
          ],
        ),
        pw.TableRow(
          children: [
            _buildTableCellStatic(
              data.currentWeight != null
                  ? '${data.currentWeight!.toStringAsFixed(1)} kg'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.avgWeight != null
                  ? '${data.avgWeight!.toStringAsFixed(1)} kg'
                  : 'N/A',
            ),
            _buildTableCellStatic(
              data.weightChange != null
                  ? '${data.weightChange! >= 0 ? '+' : ''}${data.weightChange!.toStringAsFixed(1)} kg'
                  : 'N/A',
              color: data.weightChange != null
                  ? (data.weightChange! > 0
                        ? PdfColors.orange
                        : PdfColors.green)
                  : null,
            ),
            _buildTableCellStatic('${data.weightReadings.length}'),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildWeightReadingsTableStatic(
    List<WeightDataPoint> readings,
    DateFormat dateFormat,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(2),
        2: const pw.FlexColumnWidth(2),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Date', isHeader: true),
            _buildTableCellStatic('Weight (kg)', isHeader: true),
            _buildTableCellStatic('Body Fat %', isHeader: true),
          ],
        ),
        ...readings.map(
          (weight) => pw.TableRow(
            children: [
              _buildTableCellStatic(dateFormat.format(weight.timestamp)),
              _buildTableCellStatic(weight.weightKg.toStringAsFixed(1)),
              _buildTableCellStatic(
                weight.bodyFatPercentage != null
                    ? '${weight.bodyFatPercentage!.toStringAsFixed(1)}%'
                    : '-',
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildLabValuesSectionStatic(HealthReportData data) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: PdfColors.purple50,
          child: pw.Text(
            '🧪 Lab Values',
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.purple700,
            ),
          ),
        ),
        pw.SizedBox(height: 12),
        _buildLabValuesTableStatic(data.labValues),
      ],
    );
  }

  static pw.Widget _buildLabValuesTableStatic(List<LabValue> labValues) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(2),
        1: const pw.FlexColumnWidth(1.5),
        2: const pw.FlexColumnWidth(1),
        3: const pw.FlexColumnWidth(2.5),
        4: const pw.FlexColumnWidth(1),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: [
            _buildTableCellStatic('Test', isHeader: true),
            _buildTableCellStatic('Value', isHeader: true),
            _buildTableCellStatic('Unit', isHeader: true),
            _buildTableCellStatic('Reference Range', isHeader: true),
            _buildTableCellStatic('Status', isHeader: true),
          ],
        ),
        ...labValues.map(
          (lab) => pw.TableRow(
            children: [
              _buildTableCellStatic(lab.name),
              _buildTableCellStatic(lab.value),
              _buildTableCellStatic(lab.unit),
              _buildTableCellStatic(
                lab.referenceRange ??
                    MedicalReferenceRanges.labReferenceRanges[lab.name] ??
                    '-',
              ),
              _buildTableCellStatic(
                lab.isHigh ? '⬆️ High' : (lab.isLow ? '⬇️ Low' : '✅ Normal'),
                color: lab.isHigh || lab.isLow
                    ? PdfColors.red
                    : PdfColors.green,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildTableCellStatic(
    String text, {
    bool isHeader = false,
    PdfColor? color,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: isHeader ? 10 : 9,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color ?? PdfColors.black,
        ),
      ),
    );
  }

  static PdfColor _getClassificationColor(String classification) {
    switch (classification.toLowerCase()) {
      case 'normal':
        return PdfColors.green;
      case 'elevated':
        return PdfColors.yellow700;
      case 'high':
        return PdfColors.orange;
      case 'high 2':
      case 'hypertension':
        return PdfColors.red;
      default:
        return PdfColors.grey;
    }
  }

  static String _formatReadingType(String readingType) {
    switch (readingType) {
      case 'fasting':
        return 'Fasting';
      case 'before_meal':
        return 'Before Meal';
      case 'after_meal':
        return 'After Meal';
      case 'bedtime':
        return 'Bedtime';
      case 'random':
        return 'Random';
      default:
        return readingType;
    }
  }
}
