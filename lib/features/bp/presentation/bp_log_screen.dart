import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final bpLoggingProvider = NotifierProvider<BPLoggingNotifier, BPLoggingState>(BPLoggingNotifier.new);

class BPLoggingState {
  final int systolic;
  final int diastolic;
  final int? pulse;
  final bool isLoading;
  final String? error;
  final bool logged;

  BPLoggingState({
    this.systolic = 120,
    this.diastolic = 80,
    this.pulse,
    this.isLoading = false,
    this.error,
    this.logged = false,
  });

  BPLoggingState copyWith({
    int? systolic,
    int? diastolic,
    int? pulse,
    bool? isLoading,
    String? error,
    bool? logged,
  }) {
    return BPLoggingState(
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      logged: logged ?? this.logged,
    );
  }

  bool get isCrisis => systolic >= 180 || diastolic >= 120;
  BPClassification get classification => DecryptedBPLog.classify(systolic, diastolic);
}

class BPLoggingNotifier extends Notifier<BPLoggingState> {
  @override
  BPLoggingState build() => BPLoggingState();

  void setSystolic(int v) => state = state.copyWith(systolic: v);
  void setDiastolic(int v) => state = state.copyWith(diastolic: v);
  void setPulse(int? v) => state = state.copyWith(pulse: v);

  Future<void> saveLog(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(appDatabaseProvider);
      await db.bloodPressureLogsDao.insertLogWithKarma(
        userId: userId,
        systolic: state.systolic,
        diastolic: state.diastolic,
        pulse: state.pulse,
      );
      state = state.copyWith(isLoading: false, logged: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = BPLoggingState();
}

class BPLogScreen extends ConsumerStatefulWidget {
  final String userId;

  const BPLogScreen({super.key, required this.userId});

  @override
  ConsumerState<BPLogScreen> createState() => _BPLogScreenState();
}

class _BPLogScreenState extends ConsumerState<BPLogScreen> {
  late TextEditingController _sysController;
  late TextEditingController _diaController;
  late TextEditingController _pulseController;

  @override
  void initState() {
    super.initState();
    _sysController = TextEditingController(text: '120');
    _diaController = TextEditingController(text: '80');
    _pulseController = TextEditingController();
  }

  @override
  void dispose() {
    _sysController.dispose();
    _diaController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bpLoggingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Pressure'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildClassificationCard(state),
              const SizedBox(height: 24),
              _buildInputFields(),
              const SizedBox(height: 24),
              _buildPulseField(),
              const SizedBox(height: 32),
              _buildSaveButton(state),
              if (state.error != null) ...[
                const SizedBox(height: 16),
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassificationCard(BPLoggingState state) {
    Color bgColor;
    String label;
    IconData icon;

    switch (state.classification) {
      case BPClassification.crisis:
        bgColor = Colors.red.shade900;
        label = 'Hypertensive Crisis';
        icon = Icons.warning_amber_rounded;
        break;
      case BPClassification.stage2:
        bgColor = Colors.orange.shade800;
        label = 'Stage 2 Hypertension';
        icon = Icons.warning_amber_rounded;
        break;
      case BPClassification.stage1:
        bgColor = Colors.yellow.shade700;
        label = 'Stage 1 Hypertension';
        icon = Icons.info_outline;
        break;
      case BPClassification.elevated:
        bgColor = AppColors.primary.withValues(alpha: 0.2);
        label = 'Elevated';
        icon = Icons.trending_up;
        break;
      case BPClassification.normal:
        bgColor = Colors.green.shade700.withValues(alpha: 0.2);
        label = 'Normal';
        icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: state.classification == BPClassification.normal 
              ? Colors.green.shade700 : Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: state.classification == BPClassification.normal 
                        ? Colors.green.shade900 : Colors.white,
                  ),
                ),
                if (state.isCrisis) ...[
                  const SizedBox(height: 4),
                  const Text(
                    'Seek immediate medical attention!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputFields() {
    return Row(
      children: [
        Expanded(
          child: _buildNumberInput(
            controller: _sysController,
            label: 'Systolic',
            hint: '120',
            unit: 'mmHg',
            onChanged: (v) {
              final val = int.tryParse(v) ?? 0;
              ref.read(bpLoggingProvider.notifier).setSystolic(val);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildNumberInput(
            controller: _diaController,
            label: 'Diastolic',
            hint: '80',
            unit: 'mmHg',
            onChanged: (v) {
              final val = int.tryParse(v) ?? 0;
              ref.read(bpLoggingProvider.notifier).setDiastolic(val);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNumberInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String unit,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            suffixText: unit,
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildPulseField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pulse (optional)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _pulseController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '72',
            suffixText: 'bpm',
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BPLoggingState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        final notifier = ref.read(bpLoggingProvider.notifier);
        await notifier.saveLog(widget.userId);
        if (mounted && ref.read(bpLoggingProvider).logged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('BP logged! +5 XP'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: state.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}