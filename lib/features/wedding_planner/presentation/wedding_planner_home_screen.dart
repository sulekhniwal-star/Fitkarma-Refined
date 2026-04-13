import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'wedding_providers.dart';
import '../../festival/presentation/festival_providers.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/insight_card.dart';
import '../../../core/storage/app_database.dart';

class WeddingPlannerHomeScreen extends ConsumerWidget {
  const WeddingPlannerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(weddingProfileProvider);
    final eventsAsync = ref.watch(weddingEventsProvider);
    final nextEventAsync = ref.watch(nextWeddingEventProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _WeddingHeroSection(
            profileAsync: profileAsync,
            nextEventAsync: nextEventAsync,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const _PhaseProgressCard(),
                  const SizedBox(height: 16),
                  const _TodaysPlanCard(),
                  const SizedBox(height: 16),
                  _EventCountdownStrip(eventsAsync: eventsAsync),
                  const SizedBox(height: 16),
                  const _WeddingInsightSection(),
                  const SizedBox(height: 16),
                  const _FitnessPlanCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeddingHeroSection extends StatelessWidget {
  final AsyncValue<WeddingProfileData?> profileAsync;
  final AsyncValue<WeddingEvent?> nextEventAsync;

  const _WeddingHeroSection({
    required this.profileAsync,
    required this.nextEventAsync,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD4A017), Color(0xFFB8860B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       AsyncValueWidget<WeddingProfileData?>(
                         value: profileAsync,
                         data: (profile) => Container(
                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                           decoration: BoxDecoration(
                             color: Colors.white24,
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Text(
                             (profile?.role ?? 'Guest').toUpperCase(),
                             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                           ),
                         ),
                       ),
                       const Icon(Icons.auto_awesome, color: Colors.white70),
                     ],
                   ),
                   const Spacer(),
                   const Text(
                     'Wedding in 12 Days',
                     style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                   ),
                   const SizedBox(height: 4),
                   AsyncValueWidget<WeddingEvent?>(
                     value: nextEventAsync,
                     data: (event) => Text(
                       event != null ? 'Next: ${event.eventName}' : 'No upcoming events',
                       style: const TextStyle(color: Colors.white70, fontSize: 16),
                     ),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhaseProgressCard extends StatelessWidget {
  const _PhaseProgressCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wedding Phase', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PhaseItem(label: 'Pre-Wedding', isActive: true, isCompleted: false),
                _PhaseItem(label: 'Wedding Week', isActive: false, isCompleted: false),
                _PhaseItem(label: 'Post-Wedding', isActive: false, isCompleted: false),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(
                value: 0.35,
                backgroundColor: Color(0xFFF5F5F5),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFB8860B)),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhaseItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isCompleted;
  const _PhaseItem({required this.label, required this.isActive, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : (isActive ? Icons.radio_button_checked : Icons.radio_button_off),
          color: isActive || isCompleted ? const Color(0xFFB8860B) : Colors.grey,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: isActive ? Colors.black : Colors.grey)),
      ],
    );
  }
}

class _TodaysPlanCard extends StatelessWidget {
  const _TodaysPlanCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.today, color: Color(0xFFB8860B)),
                SizedBox(width: 8),
                Text('Today\'s Wedding Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 24),
            const Text('Role: Bride | Goal: Glowing Skin', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 12),
            _PlanItem(icon: Icons.restaurant, label: 'Detox Morning Smoothie, High Protein Salad'),
            _PlanItem(icon: Icons.fitness_center, label: '30m Posture & Core Routine'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD4A017)),
                    child: const Text('Log Meals', style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Start Workout'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PlanItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}

class _EventCountdownStrip extends StatelessWidget {
  final AsyncValue<List<WeddingEvent>> eventsAsync;
  const _EventCountdownStrip({required this.eventsAsync});

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<List<WeddingEvent>>(
      value: eventsAsync,
      data: (events) {
        if (events.isEmpty) return const SizedBox.shrink();
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wedding Events', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: events.map((e) => _EventChip(event: e)).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EventChip extends StatelessWidget {
  final WeddingEvent event;
  const _EventChip({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/wedding-planner/event/${event.eventKey}'),
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFD4A017).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(event.eventName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 2),
            Text('${event.date.day}/${event.date.month}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _WeddingInsightSection extends ConsumerWidget {
  const _WeddingInsightSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFestivals = ref.watch(activeFestivalsProvider).value ?? [];
    
    String message = "Drink 3L of water today to keep your skin hydrated for the big day!";
    if (activeFestivals.isNotEmpty) {
      final festival = activeFestivals.first;
      message = "Wedding Prep meets ${festival.nameEn}! Opt for baked snacks during the festival to avoid pre-wedding bloating.";
    }

    return InsightCard(
      message: message,
      onThumbsUp: () {},
      onThumbsDown: () {},
      onDismiss: () {},
    );
  }
}

class _FitnessPlanCard extends StatelessWidget {
  const _FitnessPlanCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pre-Wedding Fitness Plan', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Week 4: Stamina Building', style: TextStyle(color: Color(0xFFB8860B), fontSize: 13)),
            const SizedBox(height: 12),
            _WorkoutRow(day: 'Mon', label: 'Yoga & Flexibility', isDone: true),
            _WorkoutRow(day: 'Tue', label: 'Lower Body Sculpt', isDone: true),
            _WorkoutRow(day: 'Wed', label: '30m Cardio Drill', isDone: false),
            _WorkoutRow(day: 'Thu', label: 'Rest & Recovery', isDone: false),
          ],
        ),
      ),
    );
  }
}

class _WorkoutRow extends StatelessWidget {
  final String day;
  final String label;
  final bool isDone;
  const _WorkoutRow({required this.day, required this.label, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 32, child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: TextStyle(fontSize: 13, decoration: isDone ? TextDecoration.lineThrough : null))),
          if (isDone) const Icon(Icons.check_circle, color: Colors.green, size: 16),
        ],
      ),
    );
  }
}
