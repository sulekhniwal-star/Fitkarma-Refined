import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../domain/wedding_logic.dart';

class WeddingEventDayScreen extends ConsumerWidget {
  final DateTime date;

  const WeddingEventDayScreen({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);
    final userAsync = ref.watch(currentUserProvider);
    final userId = userAsync.value?.$id;

    return Scaffold(
      appBar: AppBar(
        title: Text('${date.day}/${date.month} Wedding Schedule'),
      ),
      body: FutureBuilder<WeddingEventEntry?>(
        future: db.weddingEventsDao.getActiveWeddingPlan(userId ?? ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No active wedding plan found.'));
          }

          final plan = snapshot.data!;
          final List<dynamic> allEvents = json.decode(plan.eventsList);
          
          final dayEvents = allEvents.where((e) {
            final eDate = DateTime.parse(e['date'].toString());
            return eDate.year == date.year && eDate.month == date.month && eDate.day == date.day;
          }).toList();

          if (dayEvents.isEmpty) {
            return const Center(child: Text('No ceremonies scheduled for today.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _DaySummary(plan: plan, eventsCount: dayEvents.length),
              const SizedBox(height: 24),
              const BilingualText(
                english: 'Today\'s Events',
                hindi: 'आज के कार्यक्रम',
                englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...dayEvents.map((e) => _EventCard(event: e)),
              const SizedBox(height: 24),
              _DietaryAdvice(plan: plan, highIntensity: dayEvents.any((e) => e['isHighIntensity'] == true)),
            ],
          );
        },
      ),
    );
  }
}

class _DaySummary extends StatelessWidget {
  final WeddingEventEntry plan;
  final int eventsCount;
  const _DaySummary({required this.plan, required this.eventsCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondarySurface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'ROLE: ${plan.role.toUpperCase()}',
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
          ),
          const SizedBox(height: 8),
          Text(
            '$eventsCount Rituals Today',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final Map<String, dynamic> event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final isHigh = event['isHighIntensity'] == true;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: BilingualText(
          english: event['nameEn'] ?? 'Ceremony',
          hindi: event['nameHi'] ?? 'समारोह',
          englishStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.flash_on, size: 14, color: Colors.orange),
            const SizedBox(width: 4),
            Text(isHigh ? 'High Energy Demand' : 'Standard Activity'),
          ],
        ),
        trailing: isHigh ? const Icon(Icons.directions_run, color: Colors.orange) : null,
      ),
    );
  }
}

class _DietaryAdvice extends StatelessWidget {
  final WeddingEventEntry plan;
  final bool highIntensity;

  const _DietaryAdvice({required this.plan, required this.highIntensity});

  @override
  Widget build(BuildContext context) {
    final role = WeddingRole.values.firstWhere((r) => r.name == plan.role, orElse: () => WeddingRole.guest);
    final goal = WeddingPrimaryGoal.values.firstWhere((g) => g.name == plan.primaryGoal, orElse: () => WeddingPrimaryGoal.highEnergy);
    
    final advice = WeddingLogic.getRoleBasedAdvice(role, goal);

    return Card(
      color: Colors.amber[50],
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.amber),
                SizedBox(width: 8),
                Text('LIFESTYLE TIP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 12),
            Text(advice),
            if (highIntensity) ...[
              const SizedBox(height: 12),
              const Text(
                'Today involves high activity. Increase your carb intake in the morning to maintain energy.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
