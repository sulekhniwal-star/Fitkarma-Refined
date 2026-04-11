import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/lifestyle_providers.dart';
import '../data/lifestyle_repository.dart';
import '../../auth/data/auth_repository.dart';

class HabitTrackerScreen extends ConsumerWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final habitsAsync = user != null 
        ? ref.watch(activeHabitsProvider(user.$id)) 
        : const AsyncValue.loading();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker · आदत ट्रैकर'),
      ),
      body: habitsAsync.when(
        data: (habits) => habits.isEmpty
            ? const Center(child: Text('No active habits. Add some to get started!'))
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Text(habit.iconEmoji, style: const TextStyle(fontSize: 24)),
                      title: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: ElevatedButton(
                        onPressed: () => ref.read(lifestyleRepositoryProvider.notifier).completeHabit(habit.id),
                        child: const Text('Done'),
                      ),
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}