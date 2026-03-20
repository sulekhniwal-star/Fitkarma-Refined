// lib/features/workout/presentation/workout_calendar_screen.dart
// Calendar view for scheduling and viewing workouts

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/workout/data/workout_providers.dart';

class WorkoutCalendarScreen extends ConsumerStatefulWidget {
  const WorkoutCalendarScreen({super.key});

  @override
  ConsumerState<WorkoutCalendarScreen> createState() =>
      _WorkoutCalendarScreenState();
}

class _WorkoutCalendarScreenState extends ConsumerState<WorkoutCalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
                _currentMonth = DateTime.now().month;
                _currentYear = DateTime.now().year;
              });
            },
            tooltip: 'Today',
          ),
        ],
      ),
      body: Column(
        children: [
          // Simple Calendar Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      if (_currentMonth == 1) {
                        _currentMonth = 12;
                        _currentYear--;
                      } else {
                        _currentMonth--;
                      }
                    });
                  },
                ),
                Text(
                  '$_currentMonth/$_currentYear',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      if (_currentMonth == 12) {
                        _currentMonth = 1;
                        _currentYear++;
                      } else {
                        _currentMonth++;
                      }
                    });
                  },
                ),
              ],
            ),
          ),

          // Weekday headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map(
                    (day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Calendar Grid
          _buildCalendarGrid(),

          const Divider(),

          // Selected day info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showScheduleWorkoutDialog(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Schedule'),
                ),
              ],
            ),
          ),

          // Scheduled workouts for selected day
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text(
                  'Scheduled Workouts',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.fitness_center),
                    ),
                    title: const Text('No workouts scheduled'),
                    subtitle: Text(
                      'Tap "Schedule" to add a workout',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(_currentYear, _currentMonth, 1);
    final daysInMonth = DateTime(_currentYear, _currentMonth + 1, 0).day;
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    List<Widget> rows = [];
    List<Widget> currentRow = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < startWeekday; i++) {
      currentRow.add(const SizedBox(width: 40, height: 40));
    }

    // Add day cells
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentYear, _currentMonth, day);
      final isSelected = isSameDay(date, _selectedDate);
      final isToday = isSameDay(date, DateTime.now());

      currentRow.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : isToday
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : isToday
                      ? Theme.of(context).colorScheme.primary
                      : null,
                  fontWeight: isToday || isSelected ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ),
      );

      if (currentRow.length == 7) {
        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: currentRow,
          ),
        );
        currentRow = [];
      }
    }

    // Add remaining days
    if (currentRow.isNotEmpty) {
      while (currentRow.length < 7) {
        currentRow.add(const SizedBox(width: 40, height: 40));
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: currentRow,
        ),
      );
    }

    return Column(children: rows);
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _showScheduleWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Schedule Workout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text('Start Workout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.self_improvement),
              title: const Text('Rest Day'),
              subtitle: const Text('Mark this day as rest'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rest day scheduled!')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
