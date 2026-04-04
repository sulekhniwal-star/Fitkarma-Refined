import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class HabitsScreen extends ConsumerWidget {
  final String userId;

  const HabitsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: StreamBuilder(
        stream: db.habitsDao.watchActiveHabits(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final habits = (snapshot.data ?? []).toList();
          if (habits.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.track_changes, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No habits yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      await db.habitsDao.seedPresetHabits(userId);
                    },
                    child: const Text('Add Preset Habits'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.push('/habits/create', extra: userId),
                    child: const Text('Create Custom Habit'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return _WeeklyHeatmap(userId: userId);
              }
              final habit = habits[index - 1];
              return _HabitTile(habit: habit, userId: userId);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/habits/create', extra: userId),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _HabitTile extends ConsumerWidget {
  final Habit habit;
  final String userId;

  const _HabitTile({required this.habit, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () async {
          final isComplete = await db.habitCompletionsDao.isCompletedToday(habit.id, DateTime.now());
          if (!isComplete) {
            await db.habitCompletionsDao.markCompleteWithKarma(userId, habit.id);
            if (context.mounted) {
              final streak = await db.habitsDao.getStreakForHabit(habit.id);
              final msg = streak.currentStreak >= 7
                  ? 'Streak! +10 XP!'
                  : '+2 XP';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.green),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(habit.emoji ?? '✓', style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${habit.targetCount} ${habit.unit ?? ''} ${habit.frequency}',
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: db.habitCompletionsDao.isCompletedToday(habit.id, DateTime.now()),
                builder: (context, snapshot) {
                  final isComplete = snapshot.data ?? false;
                  if (isComplete) {
                    return Column(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        FutureBuilder(
                          future: db.habitsDao.getStreakForHabit(habit.id),
                          builder: (ctx, ss) {
                            final streak = ss.data;
                            if (streak != null && streak.currentStreak > 0) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('🔥', style: TextStyle(fontSize: 14)),
                                  Text(
                                    '${streak.currentStreak}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  }
                  return const Icon(Icons.circle_outlined, color: Colors.grey);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeeklyHeatmap extends StatelessWidget {
  final String userId;

  const _WeeklyHeatmap({required this.userId});

  @override
  Widget build(BuildContext context) {
    final db = AppDatabase();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Last 12 Weeks', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FutureBuilder(
            future: db.habitsDao.getWeeklyHeatmap(userId),
            builder: (context, snapshot) {
              final heatmap = snapshot.data ?? [];
              final weeks = <List<WeeklyHabitHeatmap>>[];
              for (int i = 0; i < heatmap.length; i += 7) {
                weeks.add(heatmap.skip(i).take(7).toList());
              }
              
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: weeks.map((week) {
                    return Column(
                      children: week.map((day) {
                        return Container(
                          width: 14,
                          height: 14,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: day.isComplete
                                ? Colors.green
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}