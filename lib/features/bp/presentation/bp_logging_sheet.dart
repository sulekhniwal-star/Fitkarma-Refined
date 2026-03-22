// lib/features/bp/presentation/bp_logging_sheet.dart
// BP Logging Bottom Sheet - Quick input for BP readings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitkarma/features/bp/data/bp_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class BpLoggingSheet extends StatefulWidget {
  final String userId;
  final Function(
    int systolic,
    int diastolic,
    BpClassification classification,
    bool isCrisis,
  )?
  onLogComplete;
  final Future<dynamic> Function({
    required int systolic,
    required int diastolic,
    int? pulse,
  })?
  onLog;

  const BpLoggingSheet({
    super.key,
    required this.userId,
    this.onLogComplete,
    this.onLog,
  });

  @override
  State<BpLoggingSheet> createState() => _BpLoggingSheetState();
}

class _BpLoggingSheetState extends State<BpLoggingSheet> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();

  bool _isLoading = false;
  BpClassification? _previewClassification;

  @override
  void dispose() {
    _systolicController.dispose();
    _diastolicController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _updatePreview() {
    final sysText = _systolicController.text;
    final diaText = _diastolicController.text;

    if (sysText.isNotEmpty && diaText.isNotEmpty) {
      final systolic = int.tryParse(sysText);
      final diastolic = int.tryParse(diaText);

      if (systolic != null &&
          diastolic != null &&
          systolic > 0 &&
          diastolic > 0 &&
          systolic < 300 &&
          diastolic < 200) {
        setState(() {
          _previewClassification = classifyBp(systolic, diastolic);
        });
        return;
      }
    }
    setState(() {
      _previewClassification = null;
    });
  }

  Future<void> _logBp() async {
    final systolic = int.tryParse(_systolicController.text);
    final diastolic = int.tryParse(_diastolicController.text);
    final pulse = _pulseController.text.isNotEmpty
        ? int.tryParse(_pulseController.text)
        : null;

    if (systolic == null || diastolic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid blood pressure values'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // If external onLog is provided, use it
      if (widget.onLog != null) {
        await widget.onLog!(
          systolic: systolic,
          diastolic: diastolic,
          pulse: pulse,
        );
      }

      if (mounted) {
        final classification = classifyBp(systolic, diastolic);
        final isCrisis = isHypertensiveCrisis(systolic, diastolic);

        Navigator.pop(context);

        widget.onLogComplete?.call(
          systolic,
          diastolic,
          classification,
          isCrisis,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('BP logged: $systolic/$diastolic mmHg (+5 XP)'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging BP: $e'),
            backgroundColor: AppColors.error,
          ),
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Log Blood Pressure',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your blood pressure reading',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),

            // Input fields
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    controller: _systolicController,
                    label: 'Systolic',
                    hint: '120',
                    suffix: 'mmHg',
                    icon: Icons.favorite,
                    iconColor: AppColors.error,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    controller: _diastolicController,
                    label: 'Diastolic',
                    hint: '80',
                    suffix: 'mmHg',
                    icon: Icons.favorite_border,
                    iconColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Pulse (optional)
            _buildInputField(
              controller: _pulseController,
              label: 'Pulse (Optional)',
              hint: '72',
              suffix: 'bpm',
              icon: Icons.monitor_heart,
              iconColor: AppColors.purple,
            ),
            const SizedBox(height: 24),

            // Classification Preview
            if (_previewClassification != null) _buildClassificationPreview(),

            const SizedBox(height: 24),

            // Log Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _logBp,
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
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text(
                        'Log BP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                '+5 XP',
                style: TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String suffix,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(3),
          ],
          onChanged: (_) => _updatePreview(),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: suffix,
            prefixIcon: Icon(icon, color: iconColor, size: 20),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildClassificationPreview() {
    final classification = _previewClassification!;
    final color = Color(classification.colorValue);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classification.displayName,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  classification.description,
                  style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
                ),
              ],
            ),
          ),
          if (isHypertensiveCrisis(
            int.tryParse(_systolicController.text) ?? 0,
            int.tryParse(_diastolicController.text) ?? 0,
          ))
            const Icon(Icons.warning, color: Colors.purple),
        ],
      ),
    );
  }
}
