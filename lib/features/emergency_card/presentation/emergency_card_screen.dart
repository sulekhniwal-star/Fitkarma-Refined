// lib/features/emergency_card/presentation/emergency_card_screen.dart
// Emergency Card Screen - displays and manages emergency medical information

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:fitkarma/features/emergency_card/data/emergency_card_providers.dart';
import 'package:fitkarma/features/emergency_card/data/emergency_card_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class EmergencyCardScreen extends ConsumerStatefulWidget {
  const EmergencyCardScreen({super.key});

  @override
  ConsumerState<EmergencyCardScreen> createState() =>
      _EmergencyCardScreenState();
}

class _EmergencyCardScreenState extends ConsumerState<EmergencyCardScreen> {
  final _formKey = GlobalKey<FormState>();
  final _allergiesController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _medicationNameController = TextEditingController();
  final _medicationDoseController = TextEditingController();
  final _medicationFrequencyController = TextEditingController();

  String? _selectedBloodGroup;
  List<Map<String, String>> _medications = [];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _loadData() {
    final state = ref.read(emergencyCardProvider);
    _allergiesController.text = state.allergies ?? '';
    _conditionsController.text = state.chronicConditions ?? '';
    _emergencyContactController.text = state.emergencyContact ?? '';
    _selectedBloodGroup = state.bloodGroup;
    _medications = List.from(state.medications);
    setState(() {});
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _conditionsController.dispose();
    _emergencyContactController.dispose();
    _medicationNameController.dispose();
    _medicationDoseController.dispose();
    _medicationFrequencyController.dispose();
    super.dispose();
  }

  Future<void> _saveCard() async {
    if (_formKey.currentState?.validate() ?? false) {
      await ref
          .read(emergencyCardProvider.notifier)
          .saveEmergencyCard(
            bloodGroup: _selectedBloodGroup,
            allergies: _allergiesController.text.isNotEmpty
                ? _allergiesController.text
                : null,
            chronicConditions: _conditionsController.text.isNotEmpty
                ? _conditionsController.text
                : null,
            emergencyContact: _emergencyContactController.text.isNotEmpty
                ? _emergencyContactController.text
                : null,
            medications: _medications,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Emergency card saved successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        setState(() {
          _isEditing = false;
        });
      }
    }
  }

  Future<void> _addMedication() async {
    if (_medicationNameController.text.isNotEmpty &&
        _medicationDoseController.text.isNotEmpty &&
        _medicationFrequencyController.text.isNotEmpty) {
      setState(() {
        _medications.add({
          'name': _medicationNameController.text,
          'dose': _medicationDoseController.text,
          'frequency': _medicationFrequencyController.text,
        });
      });
      _medicationNameController.clear();
      _medicationDoseController.clear();
      _medicationFrequencyController.clear();
    }
  }

  Future<void> _exportPdf() async {
    final state = ref.read(emergencyCardProvider);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
              level: 0,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'EMERGENCY MEDICAL CARD',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.red,
                      borderRadius: pw.BorderRadius.circular(4),
                    ),
                    child: pw.Text(
                      'EMERGENCY',
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            _buildPdfRow('Blood Group', state.bloodGroup ?? 'Not specified'),
            pw.SizedBox(height: 10),
            _buildPdfSection('Allergies', state.allergies ?? 'None'),
            pw.SizedBox(height: 10),
            _buildPdfSection(
              'Chronic Conditions',
              state.chronicConditions ?? 'None',
            ),
            pw.SizedBox(height: 10),
            _buildPdfSection(
              'Current Medications',
              state.medications.isEmpty
                  ? 'None'
                  : state.medications
                        .map(
                          (m) =>
                              '${m['name']} - ${m['dose']} (${m['frequency']})',
                        )
                        .join('\n'),
            ),
            pw.SizedBox(height: 10),
            _buildPdfRow(
              'Emergency Contact',
              state.emergencyContact ?? 'Not specified',
            ),
            pw.SizedBox(height: 30),
            pw.Text(
              'This card is stored locally on the Fitkarma app. '
              'In case of emergency, please contact the person listed above.',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            ),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/emergency_card.pdf');
    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles([
      XFile(file.path),
    ], subject: 'Emergency Medical Card');
  }

  pw.Widget _buildPdfRow(String label, String value) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 120,
          child: pw.Text(
            '$label:',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.Expanded(child: pw.Text(value)),
      ],
    );
  }

  pw.Widget _buildPdfSection(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$title:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 4),
        pw.Text(content),
      ],
    );
  }

  void _showQrCode() {
    final state = ref.read(emergencyCardProvider);

    final qrData = json.encode({
      'bloodGroup': state.bloodGroup,
      'allergies': state.allergies,
      'conditions': state.chronicConditions,
      'medications': state.medications,
      'emergencyContact': state.emergencyContact,
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Emergency Card QR Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Scan this to access emergency information',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Keep this QR code accessible for emergencies. '
                'Anyone can scan it to see your critical medical information.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(emergencyCardProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.error,
        foregroundColor: Colors.white,
        title: const Text('Emergency Card'),
        elevation: 0,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.qr_code),
              onPressed: state.hasData ? _showQrCode : null,
              tooltip: 'Show QR Code',
            ),
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              onPressed: state.hasData ? _exportPdf : null,
              tooltip: 'Export PDF',
            ),
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  _isEditing = true;
                });
              },
              tooltip: 'Edit',
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Blood Group Section
                    _buildSectionCard(
                      title: 'Blood Group',
                      icon: Icons.water_drop,
                      iconColor: AppColors.error,
                      child: _isEditing
                          ? DropdownButtonFormField<String>(
                              initialValue: _selectedBloodGroup,
                              decoration: const InputDecoration(
                                hintText: 'Select blood group',
                                border: OutlineInputBorder(),
                              ),
                              items: BloodGroups.values.map((bg) {
                                return DropdownMenuItem(
                                  value: bg,
                                  child: Text(bg),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBloodGroup = value;
                                });
                              },
                            )
                          : Text(
                              _selectedBloodGroup ?? 'Not specified',
                              style: AppTextStyles.bodyLarge,
                            ),
                    ),

                    const SizedBox(height: 16),

                    // Allergies Section
                    _buildSectionCard(
                      title: 'Allergies',
                      icon: Icons.warning_amber,
                      iconColor: AppColors.warning,
                      child: _isEditing
                          ? TextFormField(
                              controller: _allergiesController,
                              decoration: const InputDecoration(
                                hintText: 'Enter allergies (comma separated)',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            )
                          : Text(
                              state.allergies ?? 'None',
                              style: AppTextStyles.bodyLarge,
                            ),
                    ),

                    const SizedBox(height: 16),

                    // Chronic Conditions Section
                    _buildSectionCard(
                      title: 'Chronic Conditions',
                      icon: Icons.medical_information,
                      iconColor: AppColors.secondary,
                      child: _isEditing
                          ? TextFormField(
                              controller: _conditionsController,
                              decoration: const InputDecoration(
                                hintText: 'Enter chronic conditions',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            )
                          : Text(
                              state.chronicConditions ?? 'None',
                              style: AppTextStyles.bodyLarge,
                            ),
                    ),

                    const SizedBox(height: 16),

                    // Medications Section
                    _buildSectionCard(
                      title: 'Current Medications',
                      icon: Icons.medication,
                      iconColor: AppColors.teal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_medications.isEmpty && !_isEditing)
                            const Text('None', style: AppTextStyles.bodyLarge)
                          else
                            ..._medications.asMap().entries.map((entry) {
                              final index = entry.key;
                              final med = entry.value;
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.medication,
                                    color: AppColors.teal,
                                  ),
                                  title: Text(med['name'] ?? ''),
                                  subtitle: Text(
                                    '${med['dose']} - ${med['frequency']}',
                                  ),
                                  trailing: _isEditing
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: AppColors.error,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _medications.removeAt(index);
                                            });
                                          },
                                        )
                                      : null,
                                ),
                              );
                            }),
                          if (_isEditing) ...[
                            const SizedBox(height: 16),
                            const Text(
                              'Add Medication',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _medicationNameController,
                              decoration: const InputDecoration(
                                labelText: 'Medication Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _medicationDoseController,
                                    decoration: const InputDecoration(
                                      labelText: 'Dose',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    controller: _medicationFrequencyController,
                                    decoration: const InputDecoration(
                                      labelText: 'Frequency',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: _addMedication,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Medication'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.teal,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Emergency Contact Section
                    _buildSectionCard(
                      title: 'Emergency Contact',
                      icon: Icons.phone,
                      iconColor: AppColors.success,
                      child: _isEditing
                          ? TextFormField(
                              controller: _emergencyContactController,
                              decoration: const InputDecoration(
                                hintText: 'Name and phone number',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 2,
                            )
                          : Text(
                              state.emergencyContact ?? 'Not specified',
                              style: AppTextStyles.bodyLarge,
                            ),
                    ),

                    const SizedBox(height: 24),

                    // Save Button
                    if (_isEditing)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isSaving ? null : _saveCard,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: state.isSaving
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Save Emergency Card',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Info text
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Your emergency information is stored locally only and never synced to the cloud.',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 12),
                Text(title, style: AppTextStyles.h3),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}
