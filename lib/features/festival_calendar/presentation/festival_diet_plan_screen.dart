import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/festival_diet_engine.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../shared/widgets/shimmer_loader.dart';

class FestivalDietPlanScreen extends ConsumerWidget {
  final String festivalKey;

  const FestivalDietPlanScreen({super.key, required this.festivalKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeConfigsAsync = ref.watch(festivalDietProviderProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Diet Plan · त्योहार भोजन योजना'),
      ),
      body: activeConfigsAsync.when(
        data: (configs) {
          final config = configs.firstWhere(
            (c) => c.festivalKey == festivalKey,
            orElse: () => FestivalDietConfig(
              festivalKey: festivalKey,
              nameEn: 'Festival',
              nameHi: 'त्योहार',
              startDate: DateTime.now(),
              dietPlanType: 'normal',
              insightMessage: 'Follow a balanced regional diet.',
            ),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(config: config),
                const SizedBox(height: 24),
                _DietOverview(config: config),
                const SizedBox(height: 24),
                if (config.allowedFoods.isNotEmpty || config.forbiddenFoods.isNotEmpty)
                  _FoodRules(config: config),
                const SizedBox(height: 24),
                _QuickActions(config: config),
              ],
            ),
          );
        },
        loading: () => const Center(child: ShimmerLoader(width: double.infinity, height: 200)),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Could not load festival data.'),
              TextButton(
                onPressed: () => ref.invalidate(festivalDietProviderProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final FestivalDietConfig config;
  const _Header({required this.config});

  @override
  Widget build(BuildContext context) {
    final color = _getThemeColor();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            _getFastingIcon(),
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            config.dietPlanType.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            config.insightMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Color _getThemeColor() {
    switch (config.dietPlanType) {
      case 'fasting': return AppColors.primary;
      case 'feast': return Colors.purple;
      case 'sattvic': return AppColors.teal;
      default: return AppColors.primary;
    }
  }

  IconData _getFastingIcon() {
    switch (config.fastingType) {
      case 'nirjala': return Icons.water_drop;
      case 'phalahar': return Icons.apple;
      case 'roza': return Icons.nights_stay;
      default: return Icons.restaurant;
    }
  }
}

class _DietOverview extends StatelessWidget {
  final FestivalDietConfig config;
  const _DietOverview({required this.config});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BilingualText(
              english: 'Daily Guidelines',
              hindi: 'दैनिक दिशानिर्देश',
              englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _GuidelineRow(
              icon: Icons.flash_on,
              labelEn: 'Energy Target',
              labelHi: 'ऊर्जा लक्ष्य',
              value: '${(config.calorieMultiplier * 100).toInt()}% of Goal',
            ),
            _GuidelineRow(
              icon: Icons.fitness_center,
              labelEn: 'Workout',
              labelHi: 'व्यायाम',
              value: config.workoutSuppressed ? 'Rest advised' : 'Normal',
              color: config.workoutSuppressed ? Colors.orange : Colors.green,
            ),
            _GuidelineRow(
              icon: Icons.info_outline,
              labelEn: 'Classification',
              labelHi: 'वर्गीकरण',
              value: config.dietPlanType[0].toUpperCase() + config.dietPlanType.substring(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidelineRow extends StatelessWidget {
  final IconData icon;
  final String labelEn;
  final String labelHi;
  final String value;
  final Color? color;

  const _GuidelineRow({
    required this.icon,
    required this.labelEn,
    required this.labelHi,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: (color ?? AppColors.primary).withOpacity(0.1),
            child: Icon(icon, size: 18, color: color ?? AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(labelEn, style: const TextStyle(fontSize: 14)),
                Text(labelHi, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodRules extends StatelessWidget {
  final FestivalDietConfig config;
  const _FoodRules({required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (config.allowedFoods.isNotEmpty)
          _RuleCard(
            titleEn: 'Allowed Foods',
            titleHi: 'अनुमत भोजन',
            items: config.allowedFoods,
            color: Colors.green,
            icon: Icons.check_circle_outline,
          ),
        if (config.forbiddenFoods.isNotEmpty)
          const SizedBox(height: 16),
        if (config.forbiddenFoods.isNotEmpty)
          _RuleCard(
            titleEn: 'Avoid These',
            titleHi: 'इनसे बचें',
            items: config.forbiddenFoods,
            color: Colors.red,
            icon: Icons.block,
          ),
      ],
    );
  }
}

class _RuleCard extends StatelessWidget {
  final String titleEn;
  final String titleHi;
  final List<String> items;
  final Color color;
  final IconData icon;

  const _RuleCard({
    required this.titleEn,
    required this.titleHi,
    required this.items,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                BilingualText(
                  english: titleEn,
                  hindi: titleHi,
                  englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.1)),
                ),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 13),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  final FestivalDietConfig config;
  const _QuickActions({required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to food search with pre-filled filters if possible
            // For now, deep link to food
          },
          icon: const Icon(Icons.add_circle_outline),
          label: const Text('LOG MEAL ACCORDING TO PLAN'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        if (config.festivalKey == 'ramadan') ...[
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.timer),
            label: const Text('VIEW SEHRI & IFTAR TIMES'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ],
    );
  }
}
