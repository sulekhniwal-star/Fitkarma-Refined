import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'wedding_providers.dart';
import '../../../core/storage/app_database.dart';
import '../domain/wedding_plan_rule.dart';

class WeddingEventDayScreen extends ConsumerWidget {
  final String eventKey;
  const WeddingEventDayScreen({super.key, required this.eventKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsAsync = ref.watch(weddingEventsProvider);
    final planAsync = ref.watch(weddingEventPlanProvider(eventKey));

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7E6),
      appBar: AppBar(
        title: Text(_eventTitle(eventKey)),
        backgroundColor: const Color(0xFFD4A017),
        foregroundColor: Colors.white,
      ),
      body: eventsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
        data: (events) {
          final event = events.where((e) => e.eventKey == eventKey).firstOrNull;
          final weddingDayPlan = planAsync.when(
            loading: () => null,
            error: (_, _) => null,
            data: (data) => data,
          );
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _EventOverviewCard(event: event, eventKey: eventKey),
                const SizedBox(height: 16),
                _CalorieBudgetCard(plan: weddingDayPlan),
                const SizedBox(height: 16),
                _EventMealPlanCard(plan: weddingDayPlan),
                const SizedBox(height: 16),
                _EventTipsCard(plan: weddingDayPlan),
                const SizedBox(height: 16),
                _QuickLogCTA(eventKey: eventKey),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

String _eventTitle(String key) {
    switch (key.toLowerCase()) {
      case 'haldi': return 'Haldi Ceremony';
      case 'mehendi': return 'Mehendi Night';
      case 'sangeet': return 'Sangeet';
      case 'baraat': return 'Baraat';
      case 'vivah': return 'Wedding Day';
      default: return key.toUpperCase();
    }
}

class _EventOverviewCard extends StatelessWidget {
  final WeddingEvent? event;
  final String eventKey;
  const _EventOverviewCard({this.event, required this.eventKey});

  String get _eventEmoji {
    switch (eventKey.toLowerCase()) {
      case 'haldi': return '🥣';
      case 'mehendi': return '🎨';
      case 'sangeet': return '💃';
      case 'baraat': return '🎺';
      case 'vivah': return '💍';
      case 'reception': return '🥂';
      default: return '💒';
    }
  }

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
            Text(_eventEmoji, style: const TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            Text(event?.eventName ?? _eventTitle(eventKey), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
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

  String _eventTitle(String key) {
    switch (key.toLowerCase()) {
      case 'haldi': return 'Haldi Ceremony';
      case 'mehendi': return 'Mehendi Night';
      case 'sangeet': return 'Sangeet';
      case 'baraat': return 'Baraat';
      case 'vivah': return 'Wedding Day';
      case 'reception': return 'Reception';
      default: return key;
    }
  }
}

class _CalorieBudgetCard extends StatelessWidget {
  final WeddingDayPlan? plan;
  const _CalorieBudgetCard({this.plan});

  @override
  Widget build(BuildContext context) {
    final hasPlan = plan != null;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Today's Budget", style: TextStyle(color: Colors.grey)),
                    Text(
                      hasPlan ? '2,450 kcal' : '-- kcal',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatItem(label: 'Dance Burn', value: hasPlan ? '400 kcal' : '-- kcal', icon: Icons.celebration),
                _StatItem(label: 'Standing', value: hasPlan ? '120 kcal' : '-- kcal', icon: Icons.accessibility),
                _StatItem(label: 'Net Budget', value: hasPlan ? '~2,800 kcal' : '-- kcal', icon: Icons.calculate),
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
  final String eventKey;
  const _QuickLogCTA({required this.eventKey});

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

