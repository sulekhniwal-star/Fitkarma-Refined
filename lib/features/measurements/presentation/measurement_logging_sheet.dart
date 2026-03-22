// lib/features/measurements/presentation/measurement_logging_sheet.dart
// Bottom sheet for logging body measurements

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitkarma/features/measurements/data/measurement_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class MeasurementLoggingSheet extends ConsumerStatefulWidget {
  const MeasurementLoggingSheet({super.key});

  @override
  ConsumerState<MeasurementLoggingSheet> createState() =>
      _MeasurementLoggingSheetState();
}

class _MeasurementLoggingSheetState
    extends ConsumerState<MeasurementLoggingSheet> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bodyFatController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipController = TextEditingController();
  final _chestController = TextEditingController();
  final _armsController = TextEditingController();
  final _thighsController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  File? _selectedPhoto;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadLatestMeasurement();
  }

  Future<void> _loadLatestMeasurement() async {
    final latest = await ref.read(latestMeasurementProvider.future);
    if (latest != null && mounted) {
      if (latest.weightKg != null) {
        _weightController.text = latest.weightKg!.toStringAsFixed(1);
      }
      if (latest.heightCm != null) {
        _heightController.text = latest.heightCm!.toStringAsFixed(1);
      }
      if (latest.bodyFatPercentage != null) {
        _bodyFatController.text = latest.bodyFatPercentage!.toStringAsFixed(1);
      }
      if (latest.waistCm != null) {
        _waistController.text = latest.waistCm!.toStringAsFixed(1);
      }
      if (latest.hipCm != null) {
        _hipController.text = latest.hipCm!.toStringAsFixed(1);
      }
      if (latest.chestCm != null) {
        _chestController.text = latest.chestCm!.toStringAsFixed(1);
      }
      if (latest.armsCm != null) {
        _armsController.text = latest.armsCm!.toStringAsFixed(1);
      }
      if (latest.thighsCm != null) {
        _thighsController.text = latest.thighsCm!.toStringAsFixed(1);
      }
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _bodyFatController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    _chestController.dispose();
    _armsController.dispose();
    _thighsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _selectedPhoto = File(picked.path));
    }
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1080,
      maxHeight: 1920,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _selectedPhoto = File(picked.path));
    }
  }

  Future<void> _saveMeasurement() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if at least one measurement is entered
    final hasData =
        _weightController.text.isNotEmpty ||
        _bodyFatController.text.isNotEmpty ||
        _waistController.text.isNotEmpty ||
        _hipController.text.isNotEmpty ||
        _chestController.text.isNotEmpty ||
        _armsController.text.isNotEmpty ||
        _thighsController.text.isNotEmpty;

    if (!hasData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter at least one measurement')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final notifier = ref.read(measurementNotifierProvider.notifier);

      final weight = _weightController.text.isNotEmpty
          ? double.tryParse(_weightController.text)
          : null;
      final height = _heightController.text.isNotEmpty
          ? double.tryParse(_heightController.text)
          : null;
      final bodyFat = _bodyFatController.text.isNotEmpty
          ? double.tryParse(_bodyFatController.text)
          : null;
      final waist = _waistController.text.isNotEmpty
          ? double.tryParse(_waistController.text)
          : null;
      final hip = _hipController.text.isNotEmpty
          ? double.tryParse(_hipController.text)
          : null;
      final chest = _chestController.text.isNotEmpty
          ? double.tryParse(_chestController.text)
          : null;
      final arms = _armsController.text.isNotEmpty
          ? double.tryParse(_armsController.text)
          : null;
      final thighs = _thighsController.text.isNotEmpty
          ? double.tryParse(_thighsController.text)
          : null;

      final result = await notifier.saveMeasurement(
        measuredAt: _selectedDate,
        weightKg: weight,
        heightCm: height,
        bodyFatPercentage: bodyFat,
        waistCm: waist,
        hipCm: hip,
        chestCm: chest,
        armsCm: arms,
        thighsCm: thighs,
        photoFile: _selectedPhoto,
      );

      if (mounted) {
        if (result != null) {
          Navigator.of(context).pop(true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Measurement saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save measurement'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Log Measurements',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),

                // Date picker
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date'),
                  subtitle: Text(
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  ),
                  onTap: _selectDate,
                ),

                const Divider(),

                // Form content
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Basic Measurements Section
                      _buildSectionTitle('Basic'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _weightController,
                              label: 'Weight',
                              suffix: 'kg',
                              hint: '70.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _heightController,
                              label: 'Height',
                              suffix: 'cm',
                              hint: '175.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _bodyFatController,
                        label: 'Body Fat',
                        suffix: '%',
                        hint: '20.0',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Body Measurements Section
                      _buildSectionTitle('Body Measurements'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _waistController,
                              label: 'Waist',
                              suffix: 'cm',
                              hint: '80.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _hipController,
                              label: 'Hip',
                              suffix: 'cm',
                              hint: '95.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller: _chestController,
                        label: 'Chest',
                        suffix: 'cm',
                        hint: '100.0',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _armsController,
                              label: 'Arms',
                              suffix: 'cm',
                              hint: '35.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTextField(
                              controller: _thighsController,
                              label: 'Thighs',
                              suffix: 'cm',
                              hint: '55.0',
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Progress Photo Section
                      _buildSectionTitle('Progress Photo'),
                      const SizedBox(height: 12),
                      _buildPhotoSection(),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),

                // Save button
                Container(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _saveMeasurement,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Save Measurement',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    String? hint,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: inputFormatters,
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info text
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Photos are stored locally only and never uploaded to the cloud.',
                  style: TextStyle(fontSize: 12, color: Colors.blue[700]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Photo preview or buttons
        if (_selectedPhoto != null)
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedPhoto!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => setState(() => _selectedPhoto = null),
                  ),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickPhoto,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
