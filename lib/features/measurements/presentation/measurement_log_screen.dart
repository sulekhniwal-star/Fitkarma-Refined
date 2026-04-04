import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MeasurementLogScreen extends ConsumerStatefulWidget {
  final String userId;

  const MeasurementLogScreen({super.key, required this.userId});

  @override
  ConsumerState<MeasurementLogScreen> createState() => _MeasurementLogScreenState();
}

class _MeasurementLogScreenState extends ConsumerState<MeasurementLogScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _chestController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipsController = TextEditingController();
  final _leftArmController = TextEditingController();
  final _rightArmController = TextEditingController();
  final _leftThighController = TextEditingController();
  final _rightThighController = TextEditingController();
  final _bodyFatController = TextEditingController();
  
  String? _photoPath;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Measurements'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Basic', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _numberField('Weight (kg)', _weightController, required: true),
            _numberField('Height (cm)', _heightController),
            const SizedBox(height: 24),
            const Text('Circumferences (cm)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField('Chest', _chestController)),
                const SizedBox(width: 12),
                Expanded(child: _numberField('Waist', _waistController)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField('Hips', _hipsController)),
                const SizedBox(width: 12),
                Expanded(child: _numberField('Body Fat %', _bodyFatController)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Arms (cm)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField('Left Arm', _leftArmController)),
                const SizedBox(width: 12),
                Expanded(child: _numberField('Right Arm', _rightArmController)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Thighs (cm)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _numberField('Left Thigh', _leftThighController)),
                const SizedBox(width: 12),
                Expanded(child: _numberField('Right Thigh', _rightThighController)),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Progress Photo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  const Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                  const SizedBox(height: 8),
                  const Text('Tap to add progress photo'),
                  const SizedBox(height: 4),
                  Text(
                    '🔒 Stored locally only',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveMeasurement,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberField(String label, TextEditingController controller, {bool required = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: required ? (v) => v?.isEmpty == true ? 'Required' : null : null,
    );
  }

  Future<void> _saveMeasurement() async {
    final weight = double.tryParse(_weightController.text);
    if (weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Weight is required'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final db = ref.read(appDatabaseProvider);
      
      await db.bodyMeasurementsDao.insertWithCalculations(
        userId: widget.userId,
        weightKg: weight,
        heightCm: double.tryParse(_heightController.text),
        chestCm: double.tryParse(_chestController.text),
        waistCm: double.tryParse(_waistController.text),
        hipsCm: double.tryParse(_hipsController.text),
        leftArmCm: double.tryParse(_leftArmController.text),
        rightArmCm: double.tryParse(_rightArmController.text),
        leftThighCm: double.tryParse(_leftThighController.text),
        rightThighCm: double.tryParse(_rightThighController.text),
        bodyFatPercent: double.tryParse(_bodyFatController.text),
        photoPath: _photoPath,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Measurements saved!')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    _leftArmController.dispose();
    _rightArmController.dispose();
    _leftThighController.dispose();
    _rightThighController.dispose();
    _bodyFatController.dispose();
    super.dispose();
  }
}