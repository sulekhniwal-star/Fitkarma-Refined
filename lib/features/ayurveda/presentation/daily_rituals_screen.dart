import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class DailyRitualsScreen extends ConsumerWidget {
  final String odUserId;

  const DailyRitualsScreen({super.key, required this.odUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Rituals (Dinacharya)')),
      body: _buildRituals('Vata'),
    );
  }

  Widget _buildRituals(String dosha) {
    final rituals = _getRitualsForDosha(dosha);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: rituals.length,
      itemBuilder: (context, index) {
        final r = rituals[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: CheckboxListTile(
            title: Text(r['time']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['activity']!),
                Text(r['note']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            value: false,
            onChanged: (v) {},
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getRitualsForDosha(String dosha) {
    return [
      {'time': '5:00 AM', 'activity': 'Wake up early', 'note': 'Drink warm water'},
      {'time': '5:30 AM', 'activity': 'Oil massage (Abhyanga)', 'note': 'Warm sesame oil, 10-15 min'},
      {'time': '6:00 AM', 'activity': 'Light yoga', 'note': 'Gentle stretches'},
      {'time': '7:00 AM', 'activity': 'Breakfast', 'note': 'Warm, cooked food'},
      {'time': '10:00 AM', 'activity': 'Snack', 'note': 'Nuts or dried fruit'},
      {'time': '1:00 PM', 'activity': 'Lunch', 'note': 'Main meal'},
      {'time': '6:00 PM', 'activity': 'Dinner', 'note': 'Light, early'},
      {'time': '9:00 PM', 'activity': 'Bedtime routine', 'note': 'Warm milk, meditation'},
    ];
  }
}

class SeasonalPlanScreen extends ConsumerWidget {
  final String odUserId;

  const SeasonalPlanScreen({super.key, required this.odUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seasonal Plan (Ritucharya)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSeason('Spring', 'Kapha', ['Light foods', 'Honey', 'Avoid dairy'], ['Exercise', 'Running']),
          _buildSeason('Summer', 'Pitta', ['Cooling foods', 'Coconut', 'Avoid spice'], ['Swimming', 'Evening walks']),
          _buildSeason('Monsoon', 'Vata', ['Warm foods', 'Ginger', 'Soup'], ['Indoor yoga']),
          _buildSeason('Autumn', 'Pitta', ['Sweet foods', 'Ghee', 'Pomegranate'], ['Moderate exercise']),
          _buildSeason('Winter', 'Kapha', ['Warm, oily', 'Ghee', 'Nuts'], ['Outdoor exercise']),
        ],
      ),
    );
  }

  Widget _buildSeason(String name, String concern, List<String> diet, List<String> activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Concern: $concern', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            const Text('Diet:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...diet.map((d) => Padding(padding: const EdgeInsets.only(left: 8), child: Text('• $d'))),
            const SizedBox(height: 8),
            const Text('Activity:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...activity.map((a) => Padding(padding: const EdgeInsets.only(left: 8), child: Text('• $a'))),
          ],
        ),
      ),
    );
  }
}