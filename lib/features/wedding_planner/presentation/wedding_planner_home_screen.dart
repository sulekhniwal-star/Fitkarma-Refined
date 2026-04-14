import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'wedding_providers.dart';
import '../domain/wedding_plan_rule.dart';
import '../../festival/presentation/festival_providers.dart';
import '../../../shared/theme/app_colors.dart';
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
    final planAsync = ref.watch(weddingTodaysPlanProvider);
    final phaseAsync = ref.watch(weddingPhaseProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _WeddingHeroSection(
            profileAsync: profileAsync,
            nextEventAsync: nextEventAsync,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AsyncValueWidget<WeddingPhase>(
                    value: phaseAsync,
                    data: (phase) => _PhaseProgressCard(phase: phase),
                  ),
                  const SizedBox(height: 24),
                  AsyncValueWidget<WeddingDayPlan?>(
                    value: planAsync,
                    data: (plan) => _TodaysPlanCard(plan: plan),
                  ),
                  const SizedBox(height: 28),
                  _EventCountdownStrip(eventsAsync: eventsAsync),
                  const SizedBox(height: 28),
                  const _WeddingInsightSection(),
                  const SizedBox(height: 24),
                  _WeddingTipsGrid(profileAsync: profileAsync),
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
      expandedHeight: 260,
      pinned: true,
      backgroundColor: AppColors.weddingGoldStart,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () => context.push('/wedding-planner/setup'),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.weddingGoldGradient,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AsyncValueWidget<WeddingProfileData?>(
                    value: profileAsync,
                    data: (profile) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: Text(
                            (profile?.role ?? 'Guest').toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ),
                        if (profile?.startDate != null)
                          _CountdownBadge(startDate: profile!.startDate!),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Celebrate Your Big Day',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Your Personalised Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AsyncValueWidget<WeddingEvent?>(
                    value: nextEventAsync,
                    data: (event) => Row(
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white70, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          event != null ? 'Next Event: ${event.eventName}' : 'Organise your events',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
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

class _CountdownBadge extends StatelessWidget {
  final DateTime startDate;
  const _CountdownBadge({required this.startDate});

  @override
  Widget build(BuildContext context) {
    final days = WeddingPlanEngine.daysUntilWedding(startDate);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            days.toString(),
            style: const TextStyle(
              color: AppColors.weddingGoldStart,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Text(
            'DAYS LEFT',
            style: TextStyle(
              color: AppColors.weddingGoldStart,
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseProgressCard extends StatelessWidget {
  final WeddingPhase phase;
  const _PhaseProgressCard({required this.phase});

  @override
  Widget build(BuildContext context) {
    final progress = phase == WeddingPhase.preWedding ? 0.35 : (phase == WeddingPhase.weddingWeek ? 0.75 : 1.0);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Wedding Phase Status',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              Text(
                '${(progress * 100).toInt()}% Done',
                style: const TextStyle(color: AppColors.weddingGoldStart, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PhaseLabel(label: 'Pre-Wedding', status: _getStatus(WeddingPhase.preWedding, phase)),
              _PhaseLabel(label: 'Wedding Week', status: _getStatus(WeddingPhase.weddingWeek, phase)),
              _PhaseLabel(label: 'Post-Recovery', status: _getStatus(WeddingPhase.postWedding, phase)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.divider,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.weddingGoldStart),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  int _getStatus(WeddingPhase item, WeddingPhase current) {
    if (current == item) return 1; // active
    if (current.index > item.index) return 2; // completed
    return 0; // upcoming
  }
}

class _PhaseLabel extends StatelessWidget {
  final String label;
  final int status; // 0: upcoming, 1: active, 2: completed
  const _PhaseLabel({required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status == 1 ? AppColors.weddingGoldStart : (status == 2 ? AppColors.success : AppColors.textMuted);
    
    return Column(
      children: [
        Icon(
          status == 2 ? Icons.check_circle_rounded : Icons.radio_button_checked,
          color: color,
          size: 16,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: status == 1 ? FontWeight.bold : FontWeight.normal,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _TodaysPlanCard extends StatelessWidget {
  final WeddingDayPlan? plan;
  const _TodaysPlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    if (plan == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.weddingGoldGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.weddingGoldStart.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: const Icon(Icons.star_rounded, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Today\'s Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(plan!.dietPhaseLabel, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          _PlanRow(icon: Icons.breakfast_dining_outlined, label: 'Breakfast', value: plan!.breakfastSuggestion),
          _PlanRow(icon: Icons.lunch_dining_outlined, label: 'Lunch', value: plan!.lunchSuggestion),
          _PlanRow(icon: Icons.fitness_center_rounded, label: 'Workout', value: plan!.workoutLabel),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => context.push('/home/food/log/wedding'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.weddingGoldStart,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Log Meals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => context.push('/home/workout'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1.5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Start Workout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}

class _PlanRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _PlanRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detailed Event Guides',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 16),
        ),
        const SizedBox(height: 16),
        AsyncValueWidget<List<WeddingEvent>>(
          value: eventsAsync,
          data: (events) {
            if (events.isEmpty) return _EmptyEventsPlaceholder();
            
            return SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, i) => _EventChip(event: events[i]),
              ),
            );
          },
        ),
      ],
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          children: [
            Text(event.eventName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
            const SizedBox(height: 2),
            Text(
              '${event.date.day} ${_getMonth(event.date.month)}',
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonth(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m-1];
}

class _EmptyEventsPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.divider.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, style: BorderStyle.solid),
      ),
      child: const Center(
        child: Text('Add your wedding events to see countdowns', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
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

class _WeddingTipsGrid extends StatelessWidget {
  final AsyncValue<WeddingProfileData?> profileAsync;
  const _WeddingTipsGrid({required this.profileAsync});

  @override
  Widget build(BuildContext context) {
    return AsyncValueWidget<WeddingProfileData?>(
      value: profileAsync,
      data: (profile) {
        final isBride = profile?.role == 'bride';
        final tips = isBride 
          ? ['Skin Care Routine', 'Posture Prep', 'Lehenga Comfort', 'Stress Relief']
          : ['Grooming Tips', 'Stamina Guide', 'Outfit Comfort', 'Manage Stress'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Wedding Expert Tips', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: tips.map((t) => _TipSquare(title: t)).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _TipSquare extends StatelessWidget {
  final String title;
  const _TipSquare({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.weddingGoldStart, size: 20),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
