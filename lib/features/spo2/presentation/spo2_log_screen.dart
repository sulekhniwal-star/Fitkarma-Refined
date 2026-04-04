import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final spo2LoggingProvider = NotifierProvider<Spo2LoggingNotifier, Spo2LoggingState>(Spo2LoggingNotifier.new);

class Spo2LoggingState {
  final int spo2;
  final int? pulse;
  final bool isLoading;
  final String? error;
  final bool logged;

  Spo2LoggingState({
    this.spo2 = 98,
    this.pulse,
    this.isLoading = false,
    this.error,
    this.logged = false,
  });

  Spo2LoggingState copyWith({
    int? spo2,
    int? pulse,
    bool? isLoading,
    String? error,
    bool? logged,
  }) {
    return Spo2LoggingState(
      spo2: spo2 ?? this.spo2,
      pulse: pulse ?? this.pulse,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      logged: logged ?? this.logged,
    );
  }

  Spo2Classification get classification {
    if (spo2 < 90) return Spo2Classification.critical;
    if (spo2 < 95) return Spo2Classification.low;
    return Spo2Classification.normal;
  }
}

class Spo2LoggingNotifier extends Notifier<Spo2LoggingState> {
  @override
  Spo2LoggingState build() => Spo2LoggingState();

  void setSpo2(int v) => state = state.copyWith(spo2: v);
  void setPulse(int? v) => state = state.copyWith(pulse: v);

  Future<void> saveLog(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(appDatabaseProvider);
      await db.spo2LogsDao.insertLogWithKarma(
        userId: userId,
        spo2Percentage: state.spo2,
        pulse: state.pulse,
      );
      state = state.copyWith(isLoading: false, logged: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = Spo2LoggingState();
}

class Spo2LogScreen extends ConsumerStatefulWidget {
  final String userId;

  const Spo2LogScreen({super.key, required this.userId});

  @override
  ConsumerState<Spo2LogScreen> createState() => _Spo2LogScreenState();
}

class _Spo2LogScreenState extends ConsumerState<Spo2LogScreen> {
  late TextEditingController _spo2Controller;
  late TextEditingController _pulseController;

  @override
  void initState() {
    super.initState();
    _spo2Controller = TextEditingController(text: '98');
    _pulseController = TextEditingController();
  }

  @override
  void dispose() {
    _spo2Controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(spo2LoggingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SpO2'),
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
              _buildSpo2Input(state),
              const SizedBox(height: 16),
              _buildPulseInput(state),
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

  Widget _buildClassificationCard(Spo2LoggingState state) {
    Color bgColor;
    String label;
    IconData icon;
    String? message;

    switch (state.classification) {
      case Spo2Classification.critical:
        bgColor = Colors.red.shade900;
        label = 'Critical';
        icon = Icons.warning_amber_rounded;
        message = 'Seek immediate medical attention!';
        break;
      case Spo2Classification.low:
        bgColor = Colors.orange.shade700;
        label = 'Low';
        icon = Icons.info_outline;
        message = 'Please consult your doctor';
        break;
      case Spo2Classification.normal:
        bgColor = Colors.green.shade700.withValues(alpha: 0.2);
        label = 'Normal';
        icon = Icons.check_circle_outline;
        message = null;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: state.classification == Spo2Classification.normal 
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
                    color: state.classification == Spo2Classification.normal 
                        ? Colors.green.shade900 : Colors.white,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(
                      color: state.classification == Spo2Classification.normal 
                          ? Colors.green.shade900 : Colors.white,
                      fontSize: 12,
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

  Widget _buildSpo2Input(Spo2LoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SpO2 Level',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _spo2Controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: '98',
            suffixText: '%',
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
          onChanged: (v) {
            final val = int.tryParse(v) ?? 0;
            ref.read(spo2LoggingProvider.notifier).setSpo2(val);
          },
        ),
      ],
    );
  }

  Widget _buildPulseInput(Spo2LoggingState state) {
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

  Widget _buildSaveButton(Spo2LoggingState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        final pulse = int.tryParse(_pulseController.text);
        ref.read(spo2LoggingProvider.notifier).setPulse(pulse);
        
        final notifier = ref.read(spo2LoggingProvider.notifier);
        await notifier.saveLog(widget.userId);
        if (mounted && ref.read(spo2LoggingProvider).logged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('SpO2 logged! +5 XP'),
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