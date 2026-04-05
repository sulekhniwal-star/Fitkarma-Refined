import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitTrackerScreen extends ConsumerStatefulWidget {
  const HabitTrackerScreen({super.key});

  @override
  ConsumerState<HabitTrackerScreen> createState() => _HabitTrackerScreenState();
}

class _HabitTrackerScreenState extends ConsumerState<HabitTrackerScreen> {
  final _habits = [
    {'id': '1', 'name': 'Drink 8 glasses of water', 'icon': Icons.water_drop, 'target': 8, 'current': 0},
    {'id': '2', 'name': '10 min meditation', 'icon': Icons.self_improvement, 'target': 1, 'current': 0},
    {'id': '3', 'name': '30 min walk', 'icon': Icons.directions_walk, 'target': 1, 'current': 0},
    {'id': '4', 'name': 'Read 10 pages', 'icon': Icons.menu_book, 'target': 1, 'current': 0},
    {'id': '5', 'name': 'No sugar', 'icon': Icons.no_food, 'target': 1, 'current': 0},
  ];

  void _toggleHabit(String id, int current, int target) {
    setState(() {
      final index = _habits.indexWhere((h) => h['id'] == id);
      if (index >= 0) {
        _habits[index]['current'] = current >= target ? 0 : current + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Tracker'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _habits.length,
        itemBuilder: (context, index) {
          final habit = _habits[index];
          final current = habit['current'] as int;
          final target = habit['target'] as int;
          final progress = current / target;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(habit['icon'] as IconData, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          habit['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (current >= target)
                        const Icon(Icons.check_circle, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(value: progress, minHeight: 8),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$current / $target'),
                      TextButton(
                        onPressed: () => _toggleHabit(habit['id'] as String, current, target),
                        child: Text(current >= target ? 'Reset' : 'Done'),
                      ),
                    ],
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

class FastingTrackerScreen extends StatefulWidget {
  const FastingTrackerScreen({super.key});

  @override
  State<FastingTrackerScreen> createState() => _FastingTrackerScreenState();
}

class _FastingTrackerScreenState extends State<FastingTrackerScreen> {
  String _protocol = '16:8';
  bool _isFasting = false;
  DateTime? _startTime;
  int _elapsedMinutes = 0;

  final _protocols = ['16:8', '18:6', '20:4', '5:2', 'OMAD'];

  void _toggleFasting() {
    setState(() {
      if (_isFasting) {
        _isFasting = false;
        _startTime = null;
      } else {
        _isFasting = true;
        _startTime = DateTime.now();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intermittent Fasting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!_isFasting) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Select Protocol', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: _protocols.map((p) {
                          return ChoiceChip(
                            label: Text(p),
                            selected: _protocol == p,
                            onSelected: (s) => setState(() => _protocol = p),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _toggleFasting,
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Start Fasting'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text('Fasting in Progress', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 24),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: CircularProgressIndicator(
                              value: _elapsedMinutes / 960, // 16 hours
                              strokeWidth: 12,
                            ),
                          ),
                          Column(
                            children: [
                              Text('${_elapsedMinutes ~/ 60}h ${_elapsedMinutes % 60}m'),
                              const Text('16:8 Protocol'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                            onPressed: _toggleFasting,
                            icon: const Icon(Icons.stop),
                            label: const Text('End Fast'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MedicationReminderScreen extends StatelessWidget {
  const MedicationReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.medication),
              title: const Text('Add Medication'),
              trailing: const Icon(Icons.add),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.medication_liquid, size: 48, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 8),
                    const Text('No medications added'),
                    const SizedBox(height: 4),
                    const Text('Add your medications to set reminders'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}