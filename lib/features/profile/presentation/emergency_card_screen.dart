import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/profile/data/emergency_card_repository.dart';
import 'package:fitkarma/core/widgets/widget_controller.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class EmergencyCardScreen extends ConsumerStatefulWidget {
  const EmergencyCardScreen({super.key});

  @override
  ConsumerState<EmergencyCardScreen> createState() => _EmergencyCardScreenState();
}

class _EmergencyCardScreenState extends ConsumerState<EmergencyCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bloodGroupController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  bool _isInitialized = false;

  @override
  void dispose() {
    _bloodGroupController.dispose();
    _allergiesController.dispose();
    _conditionsController.dispose();
    _medicationsController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  void _initializeFields() {
    final card = ref.read(emergencyCardRepositoryProvider);
    if (card != null && !_isInitialized) {
      _bloodGroupController.text = card.bloodGroup ?? '';
      _allergiesController.text = card.allergies ?? '';
      _conditionsController.text = card.conditions ?? '';
      _medicationsController.text = card.medications ?? '';
      _emergencyContactController.text = card.emergencyContact ?? '';
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(emergencyCardRepositoryProvider, (previous, next) {
      if (next != null && !_isInitialized) {
        _initializeFields();
      }
    });

    _initializeFields();

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Card'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: _showQrCode,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _exportPdf,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colorScheme.surface, colorScheme.background],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader('Medical Information'),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _bloodGroupController,
                  label: 'Blood Group',
                  hint: 'e.g. O+',
                ),
                _buildTextField(
                  controller: _allergiesController,
                  label: 'Allergies',
                  hint: 'Foods, meds, seasonal',
                  maxLines: 3,
                ),
                _buildTextField(
                  controller: _conditionsController,
                  label: 'Chronic Conditions',
                  hint: 'Diabetes, asthma, etc.',
                  maxLines: 3,
                ),
                _buildTextField(
                  controller: _medicationsController,
                  label: 'Current Medications',
                  hint: 'List current daily pills',
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                _buildSectionHeader('Emergency Contact'),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emergencyContactController,
                  label: 'Primary Contact (Name & Phone)',
                  hint: 'John Doe - 1234567890',
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _saveCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Save Card Locally'),
                ),
                const SizedBox(height: 16),
                Text(
                  '⚠️ This information is stored ONLY on this device for your privacy/safety. No data is synced to our servers.',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.headlineSmall.copyWith(color: AppColors.primary),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.labelMedium),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary.withValues(alpha: 0.5)),
              filled: true,
              fillColor: colorScheme.surfaceVariant,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(emergencyCardRepositoryProvider.notifier).updateCard(
            bloodGroup: _bloodGroupController.text,
            allergies: _allergiesController.text,
            conditions: _conditionsController.text,
            medications: _medicationsController.text,
            emergencyContact: _emergencyContactController.text,
          );
      
      // Update the home screen widget
      await WidgetController.updateEmergencyWidget(
        bloodGroup: _bloodGroupController.text,
        contact: _emergencyContactController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emergency card saved locally')),
        );
      }
    }
  }

  void _showQrCode() {
    final card = ref.read(emergencyCardRepositoryProvider);
    if (card == null) return;

    final cardData = {
      'blood': card.bloodGroup,
      'allergies': card.allergies,
      'contact': card.emergencyContact,
      'conditions': card.conditions,
      'medications': card.medications,
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emergency QR'),
        content: SizedBox(
          width: 250,
          height: 250,
          child: Center(
            child: QrImageView(
              data: jsonEncode(cardData),
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportPdf() async {
    final card = ref.read(emergencyCardRepositoryProvider);
    if (card == null) return;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(level: 0, text: 'EMERGENCY MEDICAL CARD - FitKarma'),
              pw.SizedBox(height: 20),
              pw.Text('Blood Group: ${card.bloodGroup ?? 'Unknown'}'),
              pw.Divider(),
              pw.Text('Allergies: ${card.allergies ?? 'None'}'),
              pw.Divider(),
              pw.Text('Chronic Conditions: ${card.conditions ?? 'None'}'),
              pw.Divider(),
              pw.Text('Medications: ${card.medications ?? 'None'}'),
              pw.Divider(),
              pw.Text('Emergency Contact: ${card.emergencyContact ?? 'Unspecified'}'),
              pw.SizedBox(height: 40),
              pw.Text('Date Updated: ${card.updatedAt.toIso8601String().split('T')[0]}'),
              pw.Footer(title: pw.Text('Generated by FitKarma App')),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
