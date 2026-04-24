import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/festival_diet_plan.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../core/storage/app_database.dart';
import 'festival_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_card.dart';

class FestivalDietPlanScreen extends ConsumerWidget {
  final String festivalKey;
  const FestivalDietPlanScreen({super.key, required this.festivalKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = festivalDietConfigs[festivalKey];
    final detailAsync = ref.watch(festivalDetailProvider(festivalKey));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (config == null) {
      return Scaffold(
        backgroundColor: isDark ? AppColorsDark.bg0 : AppColors.bg0,
        body: Center(child: Text('Diet plan not found.', style: AppTextStyles.body1(isDark))),
      );
    }

    return AsyncValueWidget<FestivalCalendarEntry?>(
      value: detailAsync,
      data: (detail) {
        if (detail == null) {
          return Scaffold(
            backgroundColor: isDark ? AppColorsDark.bg0 : AppColors.bg0,
            body: Center(child: Text('Festival details not found.', style: AppTextStyles.body1(isDark))),
          );
        }

        final heroColor = _getHeroColor(config.type, isDark);

        return Scaffold(
          backgroundColor: isDark ? AppColorsDark.bg0 : AppColors.bg0,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                stretch: true,
                backgroundColor: isDark ? AppColorsDark.bg0 : AppColors.bg0,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
                  title: Text(
                    detail.nameEn,
                    style: AppTextStyles.h1(true).copyWith(fontSize: 20),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              heroColor,
                              heroColor.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -20,
                        bottom: -20,
                        child: Opacity(
                          opacity: 0.2,
                          child: Text(
                            festivalEmojis[festivalKey] ?? '✨',
                            style: const TextStyle(fontSize: 180),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              isDark ? AppColorsDark.bg0 : AppColors.bg0,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FastingOverviewCard(config: config, heroColor: heroColor),
                      const SizedBox(height: 24),
                      if (festivalKey == 'ramadan') 
                        _RamadanClocks(festival: detail),
                      if (festivalKey == 'karva_chauth') 
                        _MoonriseCountdown(festival: detail),
                      if (festivalKey == 'ramadan' || festivalKey == 'karva_chauth')
                        const SizedBox(height: 24),
                      if (config.forbiddenFoodIds != null || config.allowedFoodIds != null)
                        _FoodRestrictionsSection(config: config),
                      const SizedBox(height: 24),
                      const _MealPlanTabs(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            backgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
            foregroundColor: Colors.white,
            label: Text('Quick Log Meal', style: AppTextStyles.labelLarge(true)),
            icon: const Icon(Icons.add_task),
          ),
        );
      },
    );
  }

  Color _getHeroColor(FestivalDietType type, bool isDark) {
    switch (type) {
      case FestivalDietType.nirjalaFast: return isDark ? const Color(0xFF450A0A) : const Color(0xFF991B1B);
      case FestivalDietType.sattvicFast: return isDark ? const Color(0xFF451A03) : const Color(0xFF9A3412);
      case FestivalDietType.rozaFast: return isDark ? const Color(0xFF064E3B) : const Color(0xFF065F46);
      case FestivalDietType.feastMode: return isDark ? const Color(0xFF4C1D95) : const Color(0xFF6D28D9);
      default: return isDark ? AppColorsDark.secondary : AppColors.secondary;
    }
  }
}

class _FastingOverviewCard extends StatelessWidget {
  final FestivalDietConfig config;
  final Color heroColor;
  const _FastingOverviewCard({required this.config, required this.heroColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(20),
      color: heroColor.withValues(alpha: 0.1),
      borderColor: heroColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: heroColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Diet Profile: ${config.type.name.toUpperCase()}', 
                style: AppTextStyles.monoSm(isDark).copyWith(
                  fontWeight: FontWeight.bold,
                  color: heroColor,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            config.insightCardMessage,
            style: AppTextStyles.body1(isDark).copyWith(height: 1.5),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  label: 'Calorie Budget', 
                  value: '${(config.calorieBudgetMultiplier * 100).toInt()}%', 
                  icon: Icons.track_changes,
                  color: heroColor,
                ),
                _StatItem(
                  label: 'Workout Level', 
                  value: config.suppressWorkoutIntensity ? 'LOW' : 'NORMAL', 
                  icon: Icons.fitness_center,
                  color: heroColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatItem({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(icon, size: 24, color: color.withValues(alpha: 0.7)),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.monoLg(isDark).copyWith(fontSize: 18)),
        Text(label, style: AppTextStyles.caption(isDark)),
      ],
    );
  }
}

class _FoodRestrictionsSection extends StatelessWidget {
  final FestivalDietConfig config;
  const _FoodRestrictionsSection({required this.config});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dietary Guidelines', style: AppTextStyles.h2(isDark)),
        const SizedBox(height: 16),
        if (config.allowedFoodIds != null && config.allowedFoodIds!.isNotEmpty) ...[
          _RestrictionList(
            title: 'Recommended / Allowed',
            items: config.allowedFoodIds!,
            color: AppColors.success,
            icon: Icons.check_circle_outline,
          ),
          const SizedBox(height: 16),
        ],
        if (config.forbiddenFoodIds != null && config.forbiddenFoodIds!.isNotEmpty) ...[
          _RestrictionList(
            title: 'Restricted / Forbidden',
            items: config.forbiddenFoodIds!,
            color: AppColors.error,
            icon: Icons.block_flipped,
          ),
        ],
      ],
    );
  }
}

class _RestrictionList extends StatelessWidget {
  final String title;
  final List<String> items;
  final Color color;
  final IconData icon;

  const _RestrictionList({
    required this.title,
    required this.items,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      color: color.withValues(alpha: 0.05),
      borderColor: color.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(title, style: AppTextStyles.labelLarge(isDark).copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.1)),
              ),
              child: Text(
                item.replaceAll('_', ' ').toUpperCase(),
                style: AppTextStyles.monoSm(isDark).copyWith(
                  color: color, 
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _MealPlanTabs extends StatelessWidget {
  const _MealPlanTabs();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: EdgeInsets.zero,
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              labelColor: isDark ? AppColorsDark.primary : AppColors.primary,
              unselectedLabelColor: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
              indicatorColor: isDark ? AppColorsDark.primary : AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: AppTextStyles.labelLarge(isDark),
              tabs: const [
                Tab(text: 'Today'),
                Tab(text: 'Tomorrow'),
                Tab(text: 'Day 3'),
              ],
            ),
            SizedBox(
              height: 240,
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
      ),
    );
  }
}

class _MealList extends StatelessWidget {
  final String day;
  const _MealList({required this.day});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _MealTile(
          icon: Icons.wb_twilight, 
          title: 'Morning Ritual', 
          subtitle: 'Warm water with lemon & honey',
          isDark: isDark,
        ),
        _MealTile(
          icon: Icons.lunch_dining, 
          title: 'Festive Lunch', 
          subtitle: 'Baked Sabudana Vada + Curd',
          isDark: isDark,
        ),
        _MealTile(
          icon: Icons.nightlight_round, 
          title: 'Evening Reset', 
          subtitle: 'Mixed Fruit Bowl + Milk',
          isDark: isDark,
        ),
      ],
    );
  }
}

class _MealTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isDark;

  const _MealTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isDark ? AppColorsDark.primary : AppColors.primary).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isDark ? AppColorsDark.primary : AppColors.primary, size: 20),
      ),
      title: Text(title, style: AppTextStyles.labelLarge(isDark)),
      subtitle: Text(subtitle, style: AppTextStyles.body2(isDark)),
      trailing: Icon(Icons.add_circle_outline, color: isDark ? AppColorsDark.divider : AppColors.divider, size: 20),
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
            color: AppColors.primary,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GlassCard(
      padding: const EdgeInsets.all(16),
      color: color.withValues(alpha: 0.1),
      borderColor: color.withValues(alpha: 0.2),
      child: Column(
        children: [
          Text(
            label, 
            style: AppTextStyles.monoSm(isDark).copyWith(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            time, 
            style: AppTextStyles.monoLg(isDark).copyWith(color: color, fontSize: 24),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              countdown, 
              style: AppTextStyles.monoSm(true).copyWith(
                color: color, 
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const Map<String, String> festivalEmojis = {
  'navratri': '🔱',
  'diwali': '🪔',
  'holi': '🎨',
  'karva_chauth': '🌙',
  'ramadan': '🌙',
  'eid_ul_fitr': '🌙',
  'eid_ul_adha': '🕋',
  'janmashtami': '🏺',
  'shivaratri': '🔱',
  'christmas': '🎄',
  'ganesh_chaturthi': '🐘',
  'raksha_bandhan': '🥨',
  'guru_nanak_jayanti': '🕯️',
  'onam': '🛶',
  'pongal': '🥣',
  'baisakhi': '🌾',
  'lohri': '🔥',
  'buddha_purnima': '☸️',
  'republic_day': '🇮🇳',
  'independence_day': '🇮🇳',
};


