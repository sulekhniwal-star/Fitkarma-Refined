import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'wedding_providers.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../core/storage/app_database.dart';

class WeddingEventDayScreen extends ConsumerWidget {
  final String eventKey;
  const WeddingEventDayScreen({super.key, required this.eventKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(weddingEventsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: AppBar(
        title: Text(eventKey.toUpperCase()),
        backgroundColor: const Color(0xFFD4A017),
        foregroundColor: Colors.white,
      ),
      body: AsyncValueWidget<List<WeddingEvent>>(
        value: eventsAsync,
        data: (events) {
          final event = events.firstWhere((e) => e.eventKey == eventKey, orElse: () => null as dynamic);
          if (event == null) return const Center(child: Text('Event not found'));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _EventOverviewCard(event: event),
                const SizedBox(height: 16),
                const _CalorieBudgetCard(),
                const SizedBox(height: 16),
                const _EventMealPlanCard(),
                const SizedBox(height: 16),
                const _EventTipsCard(),
                const SizedBox(height: 16),
                const _QuickLogCTA(),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EventOverviewCard extends StatelessWidget {
  final WeddingEvent event;
  const _EventOverviewCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
          ),
        ),
        child: Column(
          children: [
             Text(event.eventName, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
             const SizedBox(height: 8),
             Text(
               'Celebrate with awareness and joy!',
               style: TextStyle(color: Colors.white.withOpacity(0.9)),
             ),
          ],
        ),
      ),
    );
  }
}

class _CalorieBudgetCard extends StatelessWidget {
  const _CalorieBudgetCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today\'s Budget', style: TextStyle(color: Colors.grey)),
                    Text('2,450 kcal', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.bolt, color: Colors.orange),
                ),
              ],
            ),
            const Divider(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(label: 'Dance Burn', value: '450 kcal', icon: Icons.celebration),
                _StatItem(label: 'Standing', value: '120 kcal', icon: Icons.accessibility),
                _StatItem(label: 'Net Budget', value: '3,020 kcal', icon: Icons.calculate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const _StatItem({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFFB8860B)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

class _EventMealPlanCard extends StatelessWidget {
  const _EventMealPlanCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Event Day Meal Strategy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _MealRow(title: 'Pre-Event', subtitle: 'Complex carbs + Electrolytes'),
            _MealRow(title: 'During-Event', subtitle: 'Mini-bites, avoid sugary soda'),
            _MealRow(title: 'Post-Event', subtitle: 'Green tea + Fiber-rich detox meal'),
          ],
        ),
      ),
    );
  }
}

class _MealRow extends StatelessWidget {
  final String title;
  final String subtitle;
  const _MealRow({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.restaurant_menu, size: 16, color: Color(0xFFD4A017)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventTipsCard extends StatelessWidget {
  const _EventTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFB8860B).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB8860B).withOpacity(0.2)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡 Wedding Wisdom', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB8860B))),
          SizedBox(height: 8),
          Text(
            'Keep moving! A 30-minute dance session can burn up to 400 calories. Prioritize protein starters to stay full longer.',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _QuickLogCTA extends StatelessWidget {
  const _QuickLogCTA();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_a_photo, color: Colors.white),
        label: const Text('QUICK LOG EVENT MEAL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD4A017),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
