// lib/features/sleep/presentation/sleep_logging_sheet.dart
// Sleep logging bottom sheet with time pickers and emoji quality scale

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/sleep/data/sleep_service.dart';
import 'package:fitkarma/features/sleep/data/sleep_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

class SleepLoggingSheet extends ConsumerStatefulWidget {
  const SleepLoggingSheet({super.key});

  @override
  ConsumerState<SleepLoggingSheet> createState() => _SleepLoggingSheetState();
}

class _SleepLoggingSheetState extends ConsumerState<SleepLoggingSheet> {
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  int _qualityScore = 3;
  bool _isLoading = false;

  // Emoji options for quality scale (1-5)
  final List<_EmojiOption> _emojiOptions = [
    _EmojiOption(emoji: '😫', label: 'Very Poor', value: 1),
    _EmojiOption(emoji: '😔', label: 'Poor', value: 2),
    _EmojiOption(emoji: '😐', label: 'Fair', value: 3),
    _EmojiOption(emoji: '😊', label: 'Good', value: 4),
    _EmojiOption(emoji: '😴', label: 'Excellent', value: 5),
  ];

  @override
  void initState() {
    super.initState();
    _loadLastSleep();
  }

  Future<void> _loadLastSleep() async {
    final lastSleep = await ref.read(lastNightSleepProvider.future);
    if (lastSleep != null && mounted) {
      // Parse bedtime
      final bedtimeParts = lastSleep.bedtime.split(':');
      if (bedtimeParts.length == 2) {
        final hour = int.tryParse(bedtimeParts[0]) ?? 22;
        final minute =
            int.tryParse(bedtimeParts[1].replaceAll(RegExp(r'[^0-9]'), '')) ??
            0;
        setState(() {
          _bedtime = TimeOfDay(hour: hour, minute: minute);
        });
      }

      // Parse wake time
      final wakeParts = lastSleep.wakeTime.split(':');
      if (wakeParts.length == 2) {
        final hour = int.tryParse(wakeParts[0]) ?? 7;
        final minute =
            int.tryParse(wakeParts[1].replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        setState(() {
          _wakeTime = TimeOfDay(hour: hour, minute: minute);
        });
      }
    }
  }

  int get _durationMinutes {
    int bedtimeMinutes = _bedtime.hour * 60 + _bedtime.minute;
    int wakeTimeMinutes = _wakeTime.hour * 60 + _wakeTime.minute;

    // If wake time is before bedtime, it means wake time is next day
    if (wakeTimeMinutes <= bedtimeMinutes) {
      wakeTimeMinutes += 24 * 60; // Add 24 hours
    }

    return wakeTimeMinutes - bedtimeMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
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
            Text(
              'Log Your Sleep',
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'How did you sleep last night?',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Time Pickers
            Row(
              children: [
                Expanded(
                  child: _TimePickerCard(
                    label: 'Bedtime',
                    icon: Icons.bedtime,
                    time: _bedtime,
                    onTap: () => _selectTime(context, isBedtime: true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _TimePickerCard(
                    label: 'Wake Time',
                    icon: Icons.wb_sunny,
                    time: _wakeTime,
                    onTap: () => _selectTime(context, isBedtime: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Duration Display
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: AppColors.purple),
                  const SizedBox(width: 8),
                  Text(
                    'Duration: ${(_durationMinutes / 60).toStringAsFixed(1)} hours',
                    style: AppTextStyles.h4.copyWith(color: AppColors.purple),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quality Scale
            Text(
              'How was your sleep quality?',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _emojiOptions.map((option) {
                final isSelected = _qualityScore == option.value;
                return GestureDetector(
                  onTap: () => setState(() => _qualityScore = option.value),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.purple.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.purple
                            : Colors.grey.withValues(alpha: 0.2),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          option.emoji,
                          style: TextStyle(fontSize: isSelected ? 32 : 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          option.label,
                          style: AppTextStyles.caption.copyWith(
                            color: isSelected
                                ? AppColors.purple
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // XP Award Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: AppColors.success, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    '+5 XP will be awarded',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveSleep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Save Sleep Log',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(
    BuildContext context, {
    required bool isBedtime,
  }) async {
    final initialTime = isBedtime ? _bedtime : _wakeTime;
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.purple),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isBedtime) {
          _bedtime = picked;
        } else {
          _wakeTime = picked;
        }
      });
    }
  }

  Future<void> _saveSleep() async {
    setState(() => _isLoading = true);

    try {
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null || userId.isEmpty) {
        _showError('Please log in first');
        return;
      }

      // Format times
      final bedtimeStr = _formatTimeOfDay(_bedtime);
      final wakeTimeStr = _formatTimeOfDay(_wakeTime);

      // Convert quality (1-5) to score (20-100)
      final qualityScore = _qualityScore * 20;

      // Get the date (yesterday for bedtime, today for wake)
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);

      // Get sleep service
      final driftService = ref.read(driftServiceProvider);
      final sleepService = SleepService(driftService.db);

      // Save to database
      await sleepService.logSleep(
        userId: userId,
        date: yesterday,
        bedtime: bedtimeStr,
        wakeTime: wakeTimeStr,
        durationMin: _durationMinutes,
        qualityScore: qualityScore,
        source: 'manual',
      );

      // Award XP
      await _awardXp(userId, 5);

      // Invalidate providers to refresh UI
      ref.invalidate(todaySleepLogProvider);
      ref.invalidate(lastNightSleepProvider);
      ref.invalidate(weeklySleepDataProvider);
      ref.invalidate(sleepDebtProvider);
      ref.invalidate(sleepLogs30DaysProvider);
      ref.invalidate(sleepStatsProvider);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('+5 XP earned! 🎉'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      _showError('Failed to save sleep log: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _awardXp(String userId, int xpAmount) async {
    try {
      final driftService = ref.read(driftServiceProvider);
      final db = driftService.db;

      final profile = await (db.select(
        db.userProfiles,
      )..where((t) => t.userId.equals(userId))).getSingleOrNull();

      if (profile != null) {
        final newXp = profile.xpPoints + xpAmount;
        await (db.update(db.userProfiles)
              ..where((t) => t.userId.equals(userId)))
            .write(UserProfilesCompanion(xpPoints: drift.Value(newXp)));
      }
    } catch (e) {
      // Silent fail for XP
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.error),
      );
    }
  }
}

class _TimePickerCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final TimeOfDay time;
  final VoidCallback onTap;

  const _TimePickerCard({
    required this.label,
    required this.icon,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.purple, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmojiOption {
  final String emoji;
  final String label;
  final int value;

  _EmojiOption({required this.emoji, required this.label, required this.value});
}
