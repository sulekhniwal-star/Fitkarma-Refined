import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class SleepLoggingState {
  final TimeOfDay bedtime;
  final TimeOfDay wakeTime;
  final int quality;
  final bool isLoading;
  final String? error;
  final bool logged;

  SleepLoggingState({
    TimeOfDay? bedtime,
    TimeOfDay? wakeTime,
    this.quality = 3,
    this.isLoading = false,
    this.error,
    this.logged = false,
  })  : bedtime = bedtime ?? const TimeOfDay(hour: 22, minute: 0),
        wakeTime = wakeTime ?? const TimeOfDay(hour: 6, minute: 0);

  SleepLoggingState copyWith({
    TimeOfDay? bedtime,
    TimeOfDay? wakeTime,
    int? quality,
    bool? isLoading,
    String? error,
    bool? logged,
  }) {
    return SleepLoggingState(
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      quality: quality ?? this.quality,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      logged: logged ?? this.logged,
    );
  }

  int get durationMin {
    var bed = bedtime.hour + bedtime.minute / 60;
    if (bed > 12) bed -= 24;
    
    var wake = wakeTime.hour + wakeTime.minute / 60;
    if (wake < 12) wake += 24;
    
    final duration = wake - bed;
    return (duration * 60).round();
  }

  String get durationDisplay {
    final hours = durationMin ~/ 60;
    final mins = durationMin % 60;
    return '${hours}h ${mins}m';
  }
}

class SleepLoggingNotifier extends Notifier<SleepLoggingState> {
  @override
  SleepLoggingState build() => SleepLoggingState();

  void setBedtime(TimeOfDay v) {
    state = state.copyWith(bedtime: v, logged: false);
  }

  void setWakeTime(TimeOfDay v) {
    state = state.copyWith(wakeTime: v, logged: false);
  }

  void setQuality(int v) {
    state = state.copyWith(quality: v);
  }

  Future<void> saveLog(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final now = DateTime.now();
      final bedDateTime = DateTime(now.year, now.month, now.day - 1, state.bedtime.hour, state.bedtime.minute);
      final wakeDateTime = DateTime(now.year, now.month, now.day, state.wakeTime.hour, state.wakeTime.minute);
      
      final db = ref.read(appDatabaseProvider);
      await db.sleepLogsDao.insertLogWithKarma(
        userId: userId,
        durationMin: state.durationMin,
        quality: state.quality,
        bedTime: bedDateTime,
        wakeTime: wakeDateTime,
        date: now,
      );
      state = state.copyWith(isLoading: false, logged: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = SleepLoggingState();
}

final sleepLoggingProvider = NotifierProvider<SleepLoggingNotifier, SleepLoggingState>(SleepLoggingNotifier.new);

class SleepLogScreen extends ConsumerStatefulWidget {
  final String userId;

  const SleepLogScreen({super.key, required this.userId});

  @override
  ConsumerState<SleepLogScreen> createState() => _SleepLogScreenState();
}

class _SleepLogScreenState extends ConsumerState<SleepLogScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sleepLoggingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
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
              _buildDurationDisplay(state),
              const SizedBox(height: 24),
              _buildTimePickers(state),
              const SizedBox(height: 24),
              _buildQualitySelector(state),
              const SizedBox(height: 32),
              _buildSaveButton(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDurationDisplay(SleepLoggingState state) {
    final hours = state.durationMin ~/ 60;
    final isTarget = state.durationMin >= 480;
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isTarget ? Colors.green.shade700.withValues(alpha: 0.2) : Colors.orange.shade700.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            state.durationDisplay,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: isTarget ? Colors.green.shade700 : Colors.orange.shade700,
            ),
          ),
          Text(
            isTarget ? 'Target met (8h)' : 'Below target',
            style: TextStyle(
              fontSize: 16,
              color: isTarget ? Colors.green.shade700 : Colors.orange.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePickers(SleepLoggingState state) {
    return Row(
      children: [
        Expanded(
          child: _buildTimePicker(
            'Bedtime', state.bedtime, (v) => ref.read(sleepLoggingProvider.notifier).setBedtime(v),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimePicker(
            'Wake time', state.wakeTime, (v) => ref.read(sleepLoggingProvider.notifier).setWakeTime(v),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final picked = await showTimePicker(context: context, initialTime: time);
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQualitySelector(SleepLoggingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sleep Quality', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (i) {
            final emoji = ['', '😫', '😕', '😐', '🙂', '😊'][i + 1];
            final isSelected = state.quality == i + 1;
            return GestureDetector(
              onTap: () => ref.read(sleepLoggingProvider.notifier).setQuality(i + 1),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.2) : null,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? Border.all(color: AppColors.primary, width: 2) : null,
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 28)),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSaveButton(SleepLoggingState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        final notifier = ref.read(sleepLoggingProvider.notifier);
        await notifier.saveLog(widget.userId);
        if (mounted && ref.read(sleepLoggingProvider).logged) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sleep logged! +5 XP'), backgroundColor: Colors.green),
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
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
          : const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}