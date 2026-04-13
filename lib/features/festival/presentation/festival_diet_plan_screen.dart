import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/festival_diet_plan.dart';
import 'festival_providers.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../core/storage/app_database.dart';

class FestivalDietPlanScreen extends ConsumerWidget {
  final String festivalKey;
  const FestivalDietPlanScreen({super.key, required this.festivalKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = festivalDietConfigs[festivalKey];
    final detailAsync = ref.watch(festivalDetailProvider(festivalKey));

    if (config == null) {
      return const Scaffold(body: Center(child: Text('Diet plan not found.')));
    }

    return AsyncValueWidget<FestivalCalendarEntry?>(
  value: detailAsync as AsyncValue<FestivalCalendarEntry?>,
      data: (detail) {
        if (detail == null) return const Scaffold(body: Center(child: Text('Festival details not found.')));

        return Scaffold(
          backgroundColor: _getHeroColor(config.type),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(detail.nameEn),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black54, _getHeroColor(config.type)],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FastingOverviewCard(config: config),
                      const SizedBox(height: 24),
                      if (festivalKey == 'ramadan') const _RamadanClocks(),
                      if (festivalKey == 'karva_chauth') const _MoonriseCountdown(),
                      const SizedBox(height: 24),
                      if (config.forbiddenFoodIds != null || config.allowedFoodIds != null)
                        _FoodRestrictionsSection(config: config),
                      const SizedBox(height: 24),
                      const _MealPlanTabs(),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('Quick Log'),
            icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Color _getHeroColor(FestivalDietType type) {
    switch (type) {
      case FestivalDietType.nirjalaFast: return Colors.red.shade900;
      case FestivalDietType.sattvicFast: return Colors.orange.shade700;
      case FestivalDietType.rozaFast: return Colors.green.shade800;
      case FestivalDietType.feastMode: return Colors.purple.shade700;
      default: return Colors.blue.shade800;
    }
  }
}

class _FastingOverviewCard extends StatelessWidget {
  final FestivalDietConfig config;
  const _FastingOverviewCard({required this.config});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text('Diet Profile: ${config.type.name}', 
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Text(config.insightCardMessage),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(label: 'Budget', value: '${(config.calorieBudgetMultiplier * 100).toInt()}%', icon: Icons.straighten),
                _StatItem(label: 'Exercise', value: config.suppressWorkoutIntensity ? 'Low' : 'Normal', icon: Icons.fitness_center),
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
        Icon(icon, size: 20, color: Colors.grey),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

class _FoodRestrictionsSection extends StatelessWidget {
  final FestivalDietConfig config;
  const _FoodRestrictionsSection({required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Food Guidelines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        if (config.allowedFoodIds != null) ...[
          const Text('Recommended Foods', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: config.allowedFoodIds!.map((f) => Chip(label: Text(f))).toList(),
          ),
        ],
        if (config.forbiddenFoodIds != null) ...[
          const SizedBox(height: 16),
          const Text('Forbidden Foods', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: config.forbiddenFoodIds!.map((f) => Chip(label: Text(f))).toList(),
          ),
        ],
      ],
    );
  }
}

class _MealPlanTabs extends StatelessWidget {
  const _MealPlanTabs();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Tomorrow'),
              Tab(text: 'Day 3'),
            ],
          ),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: [
                _MealList(day: 'Today'),
                _MealList(day: 'Tomorrow'),
                _MealList(day: 'Day 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealList extends StatelessWidget {
  final String day;
  const _MealList({required this.day});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ListTile(leading: Icon(Icons.breakfast_dining), title: Text('Morning Ritual'), subtitle: Text('Warm water with lemon & honey')),
        ListTile(leading: Icon(Icons.lunch_dining), title: Text('Festive Lunch'), subtitle: Text('Baked Sabudana Vada + Curd')),
        ListTile(leading: Icon(Icons.dinner_dining), title: Text('Evening Reset'), subtitle: Text('Mixed Fruit Bowl + Milk')),
      ],
    );
  }
}

class _RamadanClocks extends StatelessWidget {
  const _RamadanClocks();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _TimeBox(label: 'Sehri Ends', time: '04:32 AM', color: Colors.blue)),
        const SizedBox(width: 16),
        Expanded(child: _TimeBox(label: 'Iftar Starts', time: '06:48 PM', color: Colors.orange)),
      ],
    );
  }
}

class _MoonriseCountdown extends StatelessWidget {
  const _MoonriseCountdown();

  @override
  Widget build(BuildContext context) {
    return _TimeBox(label: 'Expected Moonrise', time: '08:12 PM', color: Colors.indigo);
  }
}

class _TimeBox extends StatelessWidget {
  final String label;
  final String time;
  final Color color;
  const _TimeBox({required this.label, required this.time, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 12)),
          const SizedBox(height: 4),
          Text(time, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
