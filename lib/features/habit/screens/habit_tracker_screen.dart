import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/animation_widgets.dart';
import '../../habit/providers/habit_provider.dart';

// ── Screen ─────────────────────────────────────────────────────────────────────

class HabitTrackerScreen extends ConsumerWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;

    final habitsAsync = ref.watch(habitProvider);
    final habits = habitsAsync.asData?.value ?? [];

    final today = DateTime.now();
    final todayStr =
        DateTime(today.year, today.month, today.day).toIso8601String();

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: text2),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Habits',
                          style: AppTypography.h1(color: text0)),
                      Text('आदतें',
                          style: AppTypography.hindi(color: text2)),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add_rounded, color: text2),
                      onPressed: () =>
                          _showAddHabitSheet(context, ref, isDark, text0, text2),
                    ),
                  ],
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ── Today's habits ────────────────────────
                      Text("Today's Habits",
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),

                      if (habits.isEmpty)
                        _EmptyHabits(text2: text2, primary: primary)
                      else
                        ...habits.map((h) {
                          final dates = _parseDates(h.completedDatesJson);
                          final doneToday = dates.contains(todayStr);
                          final streakBroken = h.currentStreak == 0 &&
                              h.longestStreak > 0;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _HabitCard(
                              habit: h,
                              doneToday: doneToday,
                              streakBroken: streakBroken,
                              isDark: isDark,
                              text0: text0,
                              text2: text2,
                              primary: primary,
                              onComplete: () => ref
                                  .read(habitProvider.notifier)
                                  .completeHabit(h.id),
                              onRecover: () => ref
                                  .read(habitProvider.notifier)
                                  .recoverStreak(h.id, ''),
                            ),
                          );
                        }),

                      const SizedBox(height: 20),

                      // ── Streak stats ──────────────────────────
                      if (habits.isNotEmpty) ...[
                        Text('Streak Stats',
                            style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        _StreakStatsRow(
                            habits: habits,
                            isDark: isDark,
                            text0: text0,
                            text2: text2),
                        const SizedBox(height: 20),

                        // ── Weekly heatmap ────────────────────
                        Text('Weekly Activity',
                            style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        _WeeklyHeatmap(
                            habits: habits,
                            isDark: isDark,
                            text2: text2,
                            primary: primary),
                      ],

                      const SizedBox(height: AppSpacing.fabClearance),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _parseDates(String? json) {
    if (json == null) return [];
    try {
      return List<String>.from(jsonDecode(json));
    } catch (_) {
      return [];
    }
  }

  void _showAddHabitSheet(BuildContext context, WidgetRef ref, bool isDark,
      Color text0, Color text2) {
    final nameCtrl = TextEditingController();
    String selectedIcon = '💪';
    const icons = ['💪', '🧘', '🏃', '💧', '📚', '🥗', '😴', '🧠', '🌿', '🎯'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) {
          final surface1 =
              isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;
          final divider =
              isDark ? AppColorsDark.divider : AppColorsLight.divider;
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: surface1,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.lg)),
              ),
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenH, 12, AppSpacing.screenH, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                          color: divider,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  Text('New Habit',
                      style: AppTypography.h3(color: text0)),
                  const SizedBox(height: 16),
                  // Icon picker
                  Wrap(
                    spacing: 8,
                    children: icons.map((ic) {
                      final active = ic == selectedIcon;
                      return GestureDetector(
                        onTap: () => setS(() => selectedIcon = ic),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: active
                                ? AppColorsDark.primary
                                    .withValues(alpha: 0.2)
                                : (isDark
                                    ? AppColorsDark.surface0
                                    : AppColorsLight.surface0),
                            borderRadius:
                                BorderRadius.circular(AppRadius.sm),
                            border: Border.all(
                                color: active
                                    ? AppColorsDark.primary
                                    : divider),
                          ),
                          child: Center(
                              child: Text(ic,
                                  style:
                                      const TextStyle(fontSize: 20))),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: nameCtrl,
                    style: TextStyle(fontSize: 15, color: text0),
                    decoration: InputDecoration(
                      hintText: 'Habit name (e.g. Morning Walk)',
                      hintStyle: TextStyle(color: text2),
                      filled: true,
                      fillColor: isDark
                          ? AppColorsDark.surface0
                          : AppColorsLight.surface0,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadius.sm),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.trim().isEmpty) return;
                        ref
                            .read(habitProvider.notifier)
                            .createHabit(
                                name: nameCtrl.text.trim(),
                                icon: selectedIcon);
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsDark.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppRadius.md)),
                      ),
                      child: const Text('Add Habit',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Habit card ─────────────────────────────────────────────────────────────────

class _HabitCard extends StatelessWidget {
  final dynamic habit;
  final bool doneToday, streakBroken, isDark;
  final Color text0, text2, primary;
  final VoidCallback onComplete, onRecover;
  const _HabitCard({
    required this.habit,
    required this.doneToday,
    required this.streakBroken,
    required this.isDark,
    required this.text0,
    required this.text2,
    required this.primary,
    required this.onComplete,
    required this.onRecover,
  });

  @override
  Widget build(BuildContext context) {
    final streak = habit.currentStreak as int;
    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        children: [
          Row(
            children: [
              // Icon
              Text(habit.icon as String,
                  style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(habit.name as String,
                        style: AppTypography.labelMd(color: text0)),
                    const SizedBox(height: 2),
                    Text('$streak day streak',
                        style: AppTypography.caption(color: text2)),
                  ],
                ),
              ),
              // Streak flame (compact)
              if (streak > 0)
                SizedBox(
                  width: 36,
                  height: 36,
                  child: StreakFlameWidget(count: streak),
                ),
              const SizedBox(width: 8),
              // Complete button
              GestureDetector(
                onTap: doneToday ? null : onComplete,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: doneToday
                        ? AppColorsDark.success.withValues(alpha: 0.2)
                        : primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: doneToday
                            ? AppColorsDark.success
                            : primary.withValues(alpha: 0.4)),
                  ),
                  child: Icon(
                    doneToday
                        ? Icons.check_rounded
                        : Icons.radio_button_unchecked_rounded,
                    size: 18,
                    color: doneToday ? AppColorsDark.success : primary,
                  ),
                ),
              ),
            ],
          ),
          // Target progress bar
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: doneToday ? 1.0 : 0.0,
              minHeight: 4,
              backgroundColor: primary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(
                  doneToday ? AppColorsDark.success : primary),
            ),
          ),
          // Streak recovery amber pill
          if (streakBroken) ...[
            const SizedBox(height: 10),
            GestureDetector(
              onTap: onRecover,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColorsDark.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  border: Border.all(
                      color: AppColorsDark.warning
                          .withValues(alpha: 0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restore_rounded,
                        size: 13, color: AppColorsDark.warning),
                    const SizedBox(width: 6),
                    Text('Recover Streak · 50 XP',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColorsDark.warning)),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Streak stats row ───────────────────────────────────────────────────────────

class _StreakStatsRow extends StatelessWidget {
  final List<dynamic> habits;
  final bool isDark;
  final Color text0, text2;
  const _StreakStatsRow(
      {required this.habits,
      required this.isDark,
      required this.text0,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    final maxCurrent = habits.isEmpty
        ? 0
        : habits
            .map((h) => h.currentStreak as int)
            .reduce((a, b) => a > b ? a : b);
    final maxLongest = habits.isEmpty
        ? 0
        : habits
            .map((h) => h.longestStreak as int)
            .reduce((a, b) => a > b ? a : b);

    return Row(
      children: [
        Expanded(
          child: GlassCard(
            borderRadius: AppRadius.md,
            padding: const EdgeInsets.all(AppSpacing.cardH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current',
                    style: AppTypography.caption(color: text2)),
                const SizedBox(height: 4),
                Text('$maxCurrent',
                    style: AppTypography.monoLg(
                        color: AppColorsDark.primary)),
                Text('days',
                    style: AppTypography.caption(color: text2)),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.bentoGap),
        Expanded(
          child: GlassCard(
            borderRadius: AppRadius.md,
            padding: const EdgeInsets.all(AppSpacing.cardH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Longest',
                    style: AppTypography.caption(color: text2)),
                const SizedBox(height: 4),
                Text('$maxLongest',
                    style: AppTypography.monoLg(
                        color: AppColorsDark.accent)),
                Text('days',
                    style: AppTypography.caption(color: text2)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Weekly heatmap ─────────────────────────────────────────────────────────────

class _WeeklyHeatmap extends StatelessWidget {
  final List<dynamic> habits;
  final bool isDark;
  final Color text2, primary;
  const _WeeklyHeatmap(
      {required this.habits,
      required this.isDark,
      required this.text2,
      required this.primary});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Build 7 columns (days) × habits rows
    // For each day, count how many habits were completed
    final days = List.generate(7, (i) {
      final day = DateTime(now.year, now.month, now.day)
          .subtract(Duration(days: 6 - i));
      final dayStr = day.toIso8601String();
      int completed = 0;
      for (final h in habits) {
        final dates = _parseDates(h.completedDatesJson as String?);
        if (dates.any((d) => d.startsWith(dayStr.substring(0, 10)))) {
          completed++;
        }
      }
      return (day: day, completed: completed);
    });

    final maxCompleted =
        habits.isEmpty ? 1 : habits.length;

    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((d) {
              final ratio = maxCompleted == 0
                  ? 0.0
                  : d.completed / maxCompleted;
              final color = ratio == 0
                  ? (isDark
                      ? AppColorsDark.surface1
                      : AppColorsLight.surface1)
                  : ratio < 0.5
                      ? primary.withValues(alpha: 0.35)
                      : primary.withValues(alpha: ratio);

              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: d.completed > 0
                        ? Center(
                            child: Text('${d.completed}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: ratio > 0.5
                                        ? Colors.white
                                        : primary)),
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dayLabel(d.day),
                    style: TextStyle(fontSize: 9, color: text2),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Less', style: AppTypography.caption(color: text2)),
              const SizedBox(width: 6),
              ...List.generate(4, (i) {
                final alpha = 0.15 + (i * 0.25);
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: alpha),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
              const SizedBox(width: 6),
              Text('More', style: AppTypography.caption(color: text2)),
            ],
          ),
        ],
      ),
    );
  }

  String _dayLabel(DateTime d) {
    const labels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return labels[d.weekday % 7];
  }

  List<String> _parseDates(String? json) {
    if (json == null) return [];
    try {
      return List<String>.from(jsonDecode(json));
    } catch (_) {
      return [];
    }
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────

class _EmptyHabits extends StatelessWidget {
  final Color text2, primary;
  const _EmptyHabits({required this.text2, required this.primary});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(Icons.checklist_rounded,
                size: 48, color: text2.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text('No habits yet.',
                style: AppTypography.bodyMd(color: text2)),
            const SizedBox(height: 4),
            Text('Tap + to add your first habit.',
                style: AppTypography.bodySm(color: text2)),
          ],
        ),
      );
}
