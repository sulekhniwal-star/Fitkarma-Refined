import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/bilingual_label.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/health_charts.dart';

const _doshaColors = {
  'vata': AppColorsDark.secondary,
  'pitta': AppColorsDark.primary,
  'kapha': AppColorsDark.teal,
};

const _doshaLabels = {
  'vata': 'Vata',
  'pitta': 'Pitta',
  'kapha': 'Kapha',
};

const _doshaRituals = {
  'vata': [
    (
      en: 'Abhyanga Oil Massage',
      hi: 'अभ्यंग',
      time: 'Morning',
      icon: Icons.spa_rounded,
    ),
    (
      en: 'Warm Sesame Tea',
      hi: 'तिल चाय',
      time: 'Morning',
      icon: Icons.local_cafe_rounded,
    ),
    (
      en: 'Grounding Meditation',
      hi: 'ध्यान',
      time: 'Evening',
      icon: Icons.self_improvement_rounded,
    ),
    (
      en: 'Early Bedtime',
      hi: 'जल्दी सोना',
      time: 'Night',
      icon: Icons.bedtime_rounded,
    ),
  ],
  'pitta': [
    (
      en: 'Coconut Water',
      hi: 'नारियल पानी',
      time: 'Morning',
      icon: Icons.water_drop_rounded,
    ),
    (
      en: 'Sheetali Pranayama',
      hi: 'शीतली प्राणायाम',
      time: 'Morning',
      icon: Icons.air_rounded,
    ),
    (
      en: 'Avoid Spicy Meals',
      hi: 'मसालेदार न खाएं',
      time: 'Meals',
      icon: Icons.no_food_rounded,
    ),
    (
      en: 'Moon Gazing',
      hi: 'चंद्र दर्शन',
      time: 'Night',
      icon: Icons.nightlight_round,
    ),
  ],
  'kapha': [
    (
      en: 'Dry Brush Massage',
      hi: 'सूखी मालिश',
      time: 'Morning',
      icon: Icons.brush_rounded,
    ),
    (
      en: 'Ginger Tea',
      hi: 'अदरक चाय',
      time: 'Morning',
      icon: Icons.local_cafe_rounded,
    ),
    (
      en: 'Invigorating Walk',
      hi: 'तेज चाल',
      time: 'Morning',
      icon: Icons.directions_walk_rounded,
    ),
    (
      en: 'Light Dinner',
      hi: 'हल्का रात्रि भोजन',
      time: 'Night',
      icon: Icons.dinner_dining_rounded,
    ),
  ],
};

const _doshaFoods = {
  'vata': (
    good: [
      'Warm soups',
      'Ghee',
      'Sesame',
      'Root vegetables',
      'Dates',
      'Almonds'
    ],
    avoid: ['Raw salads', 'Dry crackers', 'Caffeine', 'Cold drinks'],
  ),
  'pitta': (
    good: ['Coconut', 'Cucumber', 'Coriander', 'Mint', 'Sweet fruits', 'Milk'],
    avoid: ['Chilli', 'Mustard', 'Garlic', 'Alcohol', 'Fried food'],
  ),
  'kapha': (
    good: [
      'Ginger',
      'Turmeric',
      'Honey',
      'Legumes',
      'Light grains',
      'Bitter greens'
    ],
    avoid: ['Dairy', 'Sweets', 'Fried food', 'Cold food', 'Wheat'],
  ),
};

const _seasons = [
  (
    name: 'Vasant',
    en: 'Spring',
    months: 'Mar-Apr',
    tip: 'Light, bitter foods. Avoid heavy dairy.',
  ),
  (
    name: 'Grishma',
    en: 'Summer',
    months: 'May-Jun',
    tip: 'Cooling foods. Coconut water, cucumber, and mint work well.',
  ),
  (
    name: 'Varsha',
    en: 'Monsoon',
    months: 'Jul-Aug',
    tip: 'Avoid raw foods. Prefer cooked, warm meals.',
  ),
  (
    name: 'Sharad',
    en: 'Autumn',
    months: 'Sep-Oct',
    tip: 'Choose sweet, bitter, and astringent foods to cool pitta.',
  ),
  (
    name: 'Hemant',
    en: 'Early Winter',
    months: 'Nov-Dec',
    tip: 'Nourishing foods. Ghee, sesame, and warm spices are useful.',
  ),
  (
    name: 'Shishir',
    en: 'Late Winter',
    months: 'Jan-Feb',
    tip: 'Heavy, warm foods. Avoid cold and dry meals.',
  ),
];

class AyurvedaHubScreen extends StatefulWidget {
  const AyurvedaHubScreen({super.key});

  @override
  State<AyurvedaHubScreen> createState() => _AyurvedaHubScreenState();
}

class _AyurvedaHubScreenState extends State<AyurvedaHubScreen> {
  final double _vata = 40;
  final double _pitta = 35;
  final double _kapha = 25;
  final Set<String> _completedRituals = {};

  String get _dominant {
    if (_vata >= _pitta && _vata >= _kapha) return 'vata';
    if (_pitta >= _vata && _pitta >= _kapha) return 'pitta';
    return 'kapha';
  }

  String get _currentSeason {
    final month = DateTime.now().month;
    if (month == 3 || month == 4) return 'Vasant';
    if (month == 5 || month == 6) return 'Grishma';
    if (month == 7 || month == 8) return 'Varsha';
    if (month == 9 || month == 10) return 'Sharad';
    if (month == 11 || month == 12) return 'Hemant';
    return 'Shishir';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 =
        isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text1 =
        isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final dominant = _dominant;
    final dominantLabel = _doshaLabels[dominant]!;
    final doshaColor = _doshaColors[dominant]!;
    final rituals = _doshaRituals[dominant]!;
    final foods = _doshaFoods[dominant]!;
    final season = _seasons.firstWhere(
      (season) => season.name == _currentSeason,
      orElse: () => _seasons.first,
    );

    return Scaffold(
      backgroundColor: bg1,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: bg1,
              elevation: 0,
              pinned: true,
              centerTitle: false,
              leading: IconButton(
                tooltip: 'Back',
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 20, color: text1),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ayurveda', style: AppTypography.h1(color: text0)),
                  Text('आयुर्वेद', style: AppTypography.hindi(color: text1)),
                ],
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 8),
                  _DoshaSummaryCard(
                    vata: _vata,
                    pitta: _pitta,
                    kapha: _kapha,
                    dominantLabel: dominantLabel,
                    doshaColor: doshaColor,
                    text0: text0,
                    text2: text2,
                    onRetakeQuiz: () => context.push('/onboarding'),
                  ),
                  const SizedBox(height: 20),
                  const BilingualLabel(
                      english: 'Daily Rituals', hindi: 'दैनिक दिनचर्या'),
                  const SizedBox(height: 10),
                  GlassCard(
                    borderRadius: AppRadius.md,
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: rituals.asMap().entries.map((entry) {
                        final index = entry.key;
                        final ritual = entry.value;
                        final key = '${dominant}_$index';
                        final done = _completedRituals.contains(key);

                        return Column(
                          children: [
                            if (index > 0) Divider(color: divider, height: 1),
                            _RitualTile(
                              icon: ritual.icon,
                              english: ritual.en,
                              hindi: ritual.hi,
                              time: ritual.time,
                              done: done,
                              color: doshaColor,
                              text0: text0,
                              text1: text1,
                              text2: text2,
                              divider: divider,
                              onToggle: () => setState(() {
                                if (done) {
                                  _completedRituals.remove(key);
                                } else {
                                  _completedRituals.add(key);
                                }
                              }),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const BilingualLabel(
                    english: 'Seasonal Recommendations',
                    hindi: 'ऋतुचर्या सुझाव',
                  ),
                  const SizedBox(height: 10),
                  _SeasonCard(
                    season: season,
                    currentSeason: _currentSeason,
                    text0: text0,
                    text2: text2,
                    divider: divider,
                  ),
                  const SizedBox(height: 20),
                  BilingualLabel(
                    english: 'Food Guide for $dominantLabel',
                    hindi: 'आहार मार्गदर्शन',
                  ),
                  const SizedBox(height: 10),
                  _FoodGuideCard(
                      goodFoods: foods.good, avoidFoods: foods.avoid),
                  const SizedBox(height: AppSpacing.fabClearance),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoshaSummaryCard extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;
  final String dominantLabel;
  final Color doshaColor;
  final Color text0;
  final Color text2;
  final VoidCallback onRetakeQuiz;

  const _DoshaSummaryCard({
    required this.vata,
    required this.pitta,
    required this.kapha,
    required this.dominantLabel,
    required this.doshaColor,
    required this.text0,
    required this.text2,
    required this.onRetakeQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      showGlow: true,
      glowColor: doshaColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useStackedLayout = constraints.maxWidth < 330;
          final chart = SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              alignment: Alignment.center,
              children: [
                DoshaDonutChart(vata: vata, pitta: pitta, kapha: kapha),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dominantLabel,
                      style:
                          AppTypography.displayMd(color: doshaColor).copyWith(
                        shadows: [
                          Shadow(
                            color: doshaColor.withValues(alpha: 0.35),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                    ),
                    Text('dominant',
                        style: AppTypography.caption(color: text2)),
                  ],
                ),
              ],
            ),
          );
          final details = _DoshaDetails(
            vata: vata,
            pitta: pitta,
            kapha: kapha,
            text2: text2,
            onRetakeQuiz: onRetakeQuiz,
            doshaColor: doshaColor,
          );

          if (useStackedLayout) {
            return Column(
              children: [
                chart,
                const SizedBox(height: 16),
                details,
              ],
            );
          }

          return Row(
            children: [
              chart,
              const SizedBox(width: 16),
              Expanded(child: details),
            ],
          );
        },
      ),
    );
  }
}

class _DoshaDetails extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;
  final Color text2;
  final Color doshaColor;
  final VoidCallback onRetakeQuiz;

  const _DoshaDetails({
    required this.vata,
    required this.pitta,
    required this.kapha,
    required this.text2,
    required this.doshaColor,
    required this.onRetakeQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DoshaLegendRow(
            label: 'Vata',
            value: vata,
            color: _doshaColors['vata']!,
            text2: text2),
        const SizedBox(height: 8),
        _DoshaLegendRow(
            label: 'Pitta',
            value: pitta,
            color: _doshaColors['pitta']!,
            text2: text2),
        const SizedBox(height: 8),
        _DoshaLegendRow(
            label: 'Kapha',
            value: kapha,
            color: _doshaColors['kapha']!,
            text2: text2),
        const SizedBox(height: 14),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: doshaColor,
            minimumSize: const Size(44, 44),
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onRetakeQuiz,
          child: const Text('Retake Quiz'),
        ),
      ],
    );
  }
}

class _RitualTile extends StatelessWidget {
  final IconData icon;
  final String english;
  final String hindi;
  final String time;
  final bool done;
  final Color color;
  final Color text0;
  final Color text1;
  final Color text2;
  final Color divider;
  final VoidCallback onToggle;

  const _RitualTile({
    required this.icon,
    required this.english,
    required this.hindi,
    required this.time,
    required this.done,
    required this.color,
    required this.text0,
    required this.text1,
    required this.text2,
    required this.divider,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.cardH, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(english, style: AppTypography.labelMd(color: text0)),
                Text(hindi, style: AppTypography.hindi(color: text1)),
              ],
            ),
          ),
          Text(time, style: AppTypography.caption(color: text2)),
          const SizedBox(width: 8),
          Semantics(
            button: true,
            checked: done,
            label: '$english complete',
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.full),
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44,
                height: 44,
                alignment: Alignment.center,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done
                        ? color.withValues(alpha: 0.18)
                        : Colors.transparent,
                    border: Border.all(color: done ? color : divider),
                  ),
                  child: done
                      ? Icon(Icons.check_rounded, size: 16, color: color)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeasonCard extends StatelessWidget {
  final ({String en, String months, String name, String tip}) season;
  final String currentSeason;
  final Color text0;
  final Color text2;
  final Color divider;

  const _SeasonCard({
    required this.season,
    required this.currentSeason,
    required this.text0,
    required this.text2,
    required this.divider,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Pill(
                  label: '${season.name} · ${season.en}',
                  color: AppColorsDark.teal),
              const SizedBox(width: 8),
              Text(season.months, style: AppTypography.caption(color: text2)),
            ],
          ),
          const SizedBox(height: 10),
          Text(season.tip, style: AppTypography.bodyMd(color: text0)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _seasons.map((item) {
                final active = item.name == currentSeason;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _Pill(
                    label: item.name,
                    color: active ? AppColorsDark.teal : text2,
                    outlinedOnly: !active,
                    borderColor: active
                        ? AppColorsDark.teal.withValues(alpha: 0.4)
                        : divider,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FoodGuideCard extends StatelessWidget {
  final List<String> goodFoods;
  final List<String> avoidFoods;

  const _FoodGuideCard({required this.goodFoods, required this.avoidFoods});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(AppSpacing.cardH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good', style: AppTypography.labelMd(color: AppColorsDark.teal)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: goodFoods
                .map((food) => _Pill(label: food, color: AppColorsDark.teal))
                .toList(),
          ),
          const SizedBox(height: 14),
          Text('Avoid',
              style: AppTypography.labelMd(color: AppColorsDark.error)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: avoidFoods
                .map((food) => _Pill(label: food, color: AppColorsDark.error))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DoshaLegendRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final Color text2;

  const _DoshaLegendRow({
    required this.label,
    required this.value,
    required this.color,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        const Spacer(),
        Text('${value.toInt()}%', style: AppTypography.caption(color: text2)),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color color;
  final bool outlinedOnly;
  final Color? borderColor;

  const _Pill({
    required this.label,
    required this.color,
    this.outlinedOnly = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: outlinedOnly ? Colors.transparent : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: borderColor ?? color.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style:
            TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}
