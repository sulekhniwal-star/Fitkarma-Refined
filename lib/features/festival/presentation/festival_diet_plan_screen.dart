import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      if (festivalKey == 'ramadan') 
                        _RamadanClocks(festival: detail),
                      if (festivalKey == 'karva_chauth') 
                        _MoonriseCountdown(festival: detail),
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
        const SizedBox(height: 16),
        if (config.allowedFoodIds != null && config.allowedFoodIds!.isNotEmpty) ...[
          const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Recommended / Allowed', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: config.allowedFoodIds!.length,
            itemBuilder: (context, index) => _FoodItemChip(
              name: config.allowedFoodIds![index],
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 20),
        ],
        if (config.forbiddenFoodIds != null && config.forbiddenFoodIds!.isNotEmpty) ...[
          const Row(
            children: [
              Icon(Icons.cancel, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text('Restricted / Forbidden', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: config.forbiddenFoodIds!.length,
            itemBuilder: (context, index) => _FoodItemChip(
              name: config.forbiddenFoodIds![index],
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}

class _FoodItemChip extends StatelessWidget {
  final String name;
  final Color color;
  const _FoodItemChip({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        name.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
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

class _RamadanClocks extends ConsumerStatefulWidget {
  final FestivalCalendarEntry festival;
  const _RamadanClocks({required this.festival});

  @override
  ConsumerState<_RamadanClocks> createState() => _RamadanClocksState();
}

class _RamadanClocksState extends ConsumerState<_RamadanClocks> {
  Timer? _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // These would ideally come from an API or specific date engine
    final sehriTime = DateTime(_now.year, _now.month, _now.day, 4, 45);
    final iftarTime = DateTime(_now.year, _now.month, _now.day, 18, 52);

    final sehriRemaining = sehriTime.isAfter(_now) ? sehriTime.difference(_now) : Duration.zero;
    final iftarRemaining = iftarTime.isAfter(_now) ? iftarTime.difference(_now) : Duration.zero;

    return Row(
      children: [
        Expanded(
          child: _TimeBox(
            label: 'Sehri Ends', 
            time: '04:45 AM', 
            countdown: _formatDuration(sehriRemaining),
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _TimeBox(
            label: 'Iftar Starts', 
            time: '06:52 PM', 
            countdown: _formatDuration(iftarRemaining),
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    if (d.isNegative || d.inSeconds == 0) return "Active";
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return "${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}

class _MoonriseCountdown extends ConsumerStatefulWidget {
  final FestivalCalendarEntry festival;
  const _MoonriseCountdown({required this.festival});

  @override
  ConsumerState<_MoonriseCountdown> createState() => _MoonriseCountdownState();
}

class _MoonriseCountdownState extends ConsumerState<_MoonriseCountdown> {
  Timer? _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moonriseTime = _computeMoonrise(_now);
    final timeRemaining = moonriseTime.isAfter(_now) ? moonriseTime.difference(_now) : Duration.zero;

    return _TimeBox(
      label: 'Expected Moonrise (Arghya Time)', 
      time: '08:24 PM', 
      countdown: _formatDuration(timeRemaining),
      color: Colors.indigo,
      fullWidth: true,
    );
  }

  DateTime _computeMoonrise(DateTime date) {
    // Simplified astronomical approximation for Delhi/Central India
    // On Karva Chauth, moonrise is roughly 8:20 PM - 8:45 PM
    return DateTime(date.year, date.month, date.day, 20, 24);
  }

  String _formatDuration(Duration d) {
    if (d.isNegative || d.inSeconds == 0) return "Arghya Time! 🌙";
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return "T-Minus: ${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}

class _TimeBox extends StatelessWidget {
  final String label;
  final String time;
  final String countdown;
  final Color color;
  final bool fullWidth;

  const _TimeBox({
    required this.label, 
    required this.time, 
    required this.countdown,
    required this.color,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(time, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              countdown, 
              style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }
}

