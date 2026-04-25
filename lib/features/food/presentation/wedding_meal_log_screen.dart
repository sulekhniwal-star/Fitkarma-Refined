import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../wedding_planner/domain/wedding_plan_rule.dart';
import '../../wedding_planner/presentation/wedding_providers.dart';
import '../../../core/storage/app_database.dart';
import 'package:fitkarma/core/theme/app_colors.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../domain/food_providers.dart';

class WeddingMealLogScreen extends ConsumerWidget {
  const WeddingMealLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(weddingProfileProvider);
    final todaysPlanAsync = ref.watch(weddingTodaysPlanProvider);
    final nextEventAsync = ref.watch(weddingNextEventProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.weddingGoldStart,
        foregroundColor: Colors.white,
        title: const Text('Wedding Meal Plan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AsyncValueWidget<WeddingEvent?>(
              value: nextEventAsync,
              data: (event) {
                if (event == null) return const SizedBox.shrink();
                return _ActiveEventBanner(event: event);
              },
            ),
            const SizedBox(height: 20),
            AsyncValueWidget<WeddingDayPlan?>(
              value: todaysPlanAsync,
              data: (plan) {
                if (plan == null) return _NoWeddingSetupCard();
                return _TodaysMealSuggestions(plan: plan);
              },
            ),
            const SizedBox(height: 28),
            const Text(
              'Quick Add from Plan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _QuickAddSection(),
          ],
        ),
      ),
    );
  }
}

class _ActiveEventBanner extends StatelessWidget {
  final WeddingEvent event;
  const _ActiveEventBanner({required this.event});

  @override
  Widget build(BuildContext context) {
    final daysUntil = event.date.difference(DateTime.now()).inDays;
    final isToday = daysUntil == 0;
    final isPast = daysUntil < 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: isToday
          ? BoxDecoration(
              gradient: AppColors.weddingGoldGradient,
              borderRadius: BorderRadius.circular(16),
            )
          : BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.weddingGoldStart.withValues(alpha: 0.3)),
            ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isToday ? Colors.white.withValues(alpha: 0.2) : AppColors.weddingGoldStart.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isToday ? Icons.celebration : Icons.event,
              color: isToday ? Colors.white : AppColors.weddingGoldStart,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isToday ? 'Today!' : isPast ? 'Completed' : 'Coming Up',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isToday ? Colors.white70 : AppColors.textSecondary,
                  ),
                ),
                Text(
                  event.eventName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                if (!isToday && !isPast)
                  Text(
                    '$daysUntil day${daysUntil == 1 ? '' : 's'} away',
                    style: TextStyle(
                      fontSize: 12,
                      color: isToday ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          if (isToday)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'LIVE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.weddingGoldStart,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NoWeddingSetupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          const Icon(Icons.celebration, size: 48, color: AppColors.weddingGoldStart),
          const SizedBox(height: 16),
          const Text(
            'No Wedding Plan Set',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 8),
          const Text(
            'Set up your wedding planner to get personalized meal suggestions for your big day!',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed('/wedding-planner/setup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.weddingGoldStart,
              foregroundColor: Colors.white,
            ),
            child: const Text('Set Up Wedding Plan'),
          ),
        ],
      ),
    );
  }
}

class _TodaysMealSuggestions extends StatelessWidget {
  final WeddingDayPlan plan;
  const _TodaysMealSuggestions({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.weddingGoldGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.restaurant_menu, color: Colors.white, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Wedding Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      plan.dietPhaseLabel,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _MealSuggestionRow(
            icon: Icons.wb_sunny_outlined,
            label: 'Breakfast',
            suggestion: plan.breakfastSuggestion,
          ),
          _MealSuggestionRow(
            icon: Icons.lunch_dining_outlined,
            label: 'Lunch',
            suggestion: plan.lunchSuggestion,
          ),
          _MealSuggestionRow(
            icon: Icons.dinner_dining_outlined,
            label: 'Dinner',
            suggestion: plan.dinnerSuggestion,
          ),
          if (plan.snackSuggestion.isNotEmpty)
            _MealSuggestionRow(
              icon: Icons.cookie_outlined,
              label: 'Snacks',
              suggestion: plan.snackSuggestion,
            ),
          const Divider(color: Colors.white24, height: 24),
          Row(
            children: [
              const Icon(Icons.fitness_center, color: Colors.white70, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recommended Workout',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    Text(
                      plan.workoutLabel,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (plan.tip.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      plan.tip,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MealSuggestionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String suggestion;
  const _MealSuggestionRow({
    required this.icon,
    required this.label,
    required this.suggestion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                ),
                Text(
                  suggestion,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAddSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequent = ref.watch(indianFrequentFoodsProvider);

    return AsyncValueWidget<List<Map<String, dynamic>>>(
      value: frequent,
      data: (items) => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: items.map((item) {
          return ActionChip(
            avatar: Text(item['emoji'], style: const TextStyle(fontSize: 16)),
            label: Text(item['name']),
            labelStyle: const TextStyle(fontSize: 12),
            onPressed: () => _logItem(context, ref, item),
            backgroundColor: AppColors.surface,
            side: BorderSide(color: AppColors.divider.withValues(alpha: 0.5)),
          );
        }).toList(),
      ),
    );
  }

  void _logItem(BuildContext context, WidgetRef ref, Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged ${item['name']} (${item['calories']} kcal)'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      ),
    );
  }
}

