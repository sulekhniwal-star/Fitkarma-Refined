import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FestivalCalendarScreen extends ConsumerWidget {
  const FestivalCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivals = _getUpcomingFestivals();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Calendar'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: festivals.length,
        itemBuilder: (context, index) {
          final festival = festivals[index];
          final daysUntil = festival['startDate'].difference(DateTime.now()).inDays;

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                festival['nameEn'],
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                festival['nameHi'],
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        if (daysUntil <= 7 && daysUntil >= 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              daysUntil == 0 ? 'Today' : '$daysUntil days',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${festival['startDate'].day}/${festival['startDate'].month} - ${festival['endDate'].day}/${festival['endDate'].month}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    if (festival['isFasting'] == true) ...[
                      const SizedBox(height: 8),
                      Chip(
                        avatar: const Icon(Icons.restaurant, size: 16),
                        label: Text(festival['fastingType'] ?? 'Fasting'),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> _getUpcomingFestivals() {
    final now = DateTime.now();
    return [
      {'nameEn': 'Navratri', 'nameHi': 'नवरात्रि', 'startDate': now.add(const Duration(days: 15)), 'endDate': now.add(const Duration(days: 24)), 'isFasting': true, 'fastingType': 'Phalahar'},
      {'nameEn': 'Diwali', 'nameHi': 'दीवाली', 'startDate': now.add(const Duration(days: 45)), 'endDate': now.add(const Duration(days: 46)), 'isFasting': false, 'fastingType': null},
      {'nameEn': 'Karva Chauth', 'nameHi': 'करवा चौथ', 'startDate': now.add(const Duration(days: 30)), 'endDate': now.add(const Duration(days: 30)), 'isFasting': true, 'fastingType': 'Nirjala'},
      {'nameEn': 'Ramadan', 'nameHi': 'रमज़ान', 'startDate': now.add(const Duration(days: 60)), 'endDate': now.add(const Duration(days: 90)), 'isFasting': true, 'fastingType': 'Roza'},
    ];
  }
}

class FestivalDietPlanScreen extends StatelessWidget {
  final String festivalKey;

  const FestivalDietPlanScreen({super.key, required this.festivalKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Diet Plan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Allowed Foods', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: const Text('Fruits')),
                      Chip(label: const Text('Milk')),
                      Chip(label: const Text('Sabudana')),
                      Chip(label: const Text('Makhana')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Avoid', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: const Text('Grains'), backgroundColor: Colors.red.shade100),
                      Chip(label: const Text('Beans'), backgroundColor: Colors.red.shade100),
                      Chip(label: const Text('Onion'), backgroundColor: Colors.red.shade100),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}