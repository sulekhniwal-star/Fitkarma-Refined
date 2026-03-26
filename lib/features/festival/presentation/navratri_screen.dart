// lib/features/festival/presentation/navratri_screen.dart
// Navratri 9-day fasting guide + Garba calorie tracker

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/festival/data/festival_data.dart';
import 'package:fitkarma/features/festival/data/festival_providers.dart';

class NavratriScreen extends ConsumerStatefulWidget {
  const NavratriScreen({super.key});

  @override
  ConsumerState<NavratriScreen> createState() => _NavratriScreenState();
}

class _NavratriScreenState extends ConsumerState<NavratriScreen> {
  int _selectedDay = 1;
  Timer? _garbaTimer;
  int _garbaSeconds = 0;

  @override
  void dispose() {
    _garbaTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final garbaSession = ref.watch(garbaSessionProvider);
    final garbaActivities = ref.watch(garbaActivitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navratri'),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 9-Day Guide Section
            const Text(
              '9-Day Fasting Guide',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildDaySelector(),
            const SizedBox(height: 16),
            _buildDayGuide(_selectedDay),

            const SizedBox(height: 24),

            // Garba Calorie Tracker
            const Text(
              'Garba Calorie Tracker',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildGarbaTracker(garbaSession, garbaActivities),

            const SizedBox(height: 24),

            // General Guidelines
            const Text(
              'General Fasting Guidelines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildGuidelines(),
          ],
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, index) {
          final day = index + 1;
          final isSelected = _selectedDay == day;
          return GestureDetector(
            onTap: () => setState(() => _selectedDay = day),
            child: Container(
              width: 50,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE91E63) : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Day',
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected ? Colors.white : Colors.grey[600],
                    ),
                  ),
                  Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
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

  Widget _buildDayGuide(int day) {
    final guides = FestivalDatabase()
        .getFestivalsForYear(DateTime.now().year)
        .where((f) => f.type == FestivalType.navratri)
        .expand((f) => f.dayGuides ?? [])
        .toList();

    DaySpecificGuide? guide;
    try {
      guide = guides.firstWhere((g) => g.day == day);
    } catch (_) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No guide available for this day'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE91E63).withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.temple_hindu,
                    color: Color(0xFFE91E63),
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Day $day: ${guide.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Mantra: ${guide.mantra}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(
                      guide.fastingDifficulty,
                    ).withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    guide.fastingDifficulty,
                    style: TextStyle(
                      color: _getDifficultyColor(guide.fastingDifficulty),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '✅ Allowed Foods:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: guide.allowedFoods
                  .map(
                    (food) => Chip(
                      label: Text(food, style: const TextStyle(fontSize: 12)),
                      backgroundColor: Colors.green.withAlpha(30),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            const Text(
              '❌ Prohibited Foods:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: guide.prohibitedFoods
                  .map(
                    (food) => Chip(
                      label: Text(food, style: const TextStyle(fontSize: 12)),
                      backgroundColor: Colors.red.withAlpha(30),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildGarbaTracker(
    GarbaSession session,
    List<GarbaActivity> activities,
  ) {
    return Column(
      children: [
        // Active Session
        if (session.activity != null) ...[
          Card(
            color: const Color(0xFFE91E63),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Garba Session Active',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    session.activity!.name,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${session.caloriesBurned} cal',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _garbaTimer?.cancel();
                      ref.read(garbaSessionProvider.notifier).endSession();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFE91E63),
                    ),
                    child: const Text('End Session'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Activity Selection
        const Text(
          'Select Activity:',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ...activities.map(
          (activity) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E63).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.music_note, color: Color(0xFFE91E63)),
              ),
              title: Text(activity.name),
              subtitle: Text(
                '${activity.caloriesPerHour} cal/hr • ${activity.difficulty}',
              ),
              trailing: ElevatedButton(
                onPressed: session.activity == null
                    ? () {
                        ref
                            .read(garbaSessionProvider.notifier)
                            .startSession(activity);
                        _startGarbaTimer(activity);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                ),
                child: const Text('Start'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _startGarbaTimer(GarbaActivity activity) {
    _garbaSeconds = 0;
    _garbaTimer?.cancel();
    _garbaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _garbaSeconds++;
      final calories = (_garbaSeconds / 3600 * activity.caloriesPerHour)
          .round();
      ref.read(garbaSessionProvider.notifier).updateCalories(calories);
    });
  }

  Widget _buildGuidelines() {
    final guidelines =
        FestivalDatabase()
            .getFestivalsForYear(DateTime.now().year)
            .where((f) => f.type == FestivalType.navratri)
            .firstOrNull
            ?.fastingGuidelines ??
        [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: guidelines
              .map(
                (guideline) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFFE91E63),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(guideline)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
