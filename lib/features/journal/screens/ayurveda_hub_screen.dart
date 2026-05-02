import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';

// ── Dosha data ─────────────────────────────────────────────────────────────────

const _doshaColors = {
  'vata':  Color(0xFF7B6FF0), // secondary/indigo
  'pitta': Color(0xFFFF6B35), // primary/orange
  'kapha': Color(0xFF00D4B4), // teal
};

const _doshaRituals = {
  'vata': [
    (en: 'Abhyanga Oil Massage', hi: 'अभ्यंग', time: 'Morning', icon: '🫙'),
    (en: 'Warm Sesame Tea',      hi: 'तिल चाय', time: 'Morning', icon: '🍵'),
    (en: 'Grounding Meditation', hi: 'ध्यान',   time: 'Evening', icon: '🧘'),
    (en: 'Early Bedtime',        hi: 'जल्दी सोना', time: 'Night', icon: '🌙'),
  ],
  'pitta': [
    (en: 'Coconut Water',        hi: 'नारियल पानी', time: 'Morning', icon: '🥥'),
    (en: 'Sheetali Pranayama',   hi: 'शीतली प्राणायाम', time: 'Morning', icon: '🌬️'),
    (en: 'Avoid Spicy Meals',    hi: 'मसालेदार न खाएं', time: 'Meals', icon: '🌶️'),
    (en: 'Moon Gazing',          hi: 'चंद्र दर्शन', time: 'Night', icon: '🌕'),
  ],
  'kapha': [
    (en: 'Dry Brush Massage',    hi: 'सूखी मालिश', time: 'Morning', icon: '🪥'),
    (en: 'Ginger Tea',           hi: 'अदरक चाय', time: 'Morning', icon: '🫚'),
    (en: 'Invigorating Walk',    hi: 'तेज चाल', time: 'Morning', icon: '🚶'),
    (en: 'Light Dinner',         hi: 'हल्का रात्रि भोजन', time: 'Night', icon: '🥗'),
  ],
};

const _doshaFoods = {
  'vata': (
    good:  ['Warm soups', 'Ghee', 'Sesame', 'Root vegetables', 'Dates', 'Almonds'],
    avoid: ['Raw salads', 'Dry crackers', 'Caffeine', 'Cold drinks'],
  ),
  'pitta': (
    good:  ['Coconut', 'Cucumber', 'Coriander', 'Mint', 'Sweet fruits', 'Milk'],
    avoid: ['Chilli', 'Mustard', 'Garlic', 'Alcohol', 'Fried food'],
  ),
  'kapha': (
    good:  ['Ginger', 'Turmeric', 'Honey', 'Legumes', 'Light grains', 'Bitter greens'],
    avoid: ['Dairy', 'Sweets', 'Fried food', 'Cold food', 'Wheat'],
  ),
};

// 6 Indian seasons (Ritu)
const _seasons = [
  (name: 'Vasant',  en: 'Spring',       months: 'Mar–Apr', tip: 'Light, bitter foods. Avoid heavy dairy.'),
  (name: 'Grishma', en: 'Summer',       months: 'May–Jun', tip: 'Cooling foods. Coconut water, cucumber.'),
  (name: 'Varsha',  en: 'Monsoon',      months: 'Jul–Aug', tip: 'Avoid raw foods. Prefer cooked, warm meals.'),
  (name: 'Sharad',  en: 'Autumn',       months: 'Sep–Oct', tip: 'Pitta pacifying. Sweet, bitter, astringent.'),
  (name: 'Hemant',  en: 'Early Winter', months: 'Nov–Dec', tip: 'Nourishing foods. Ghee, sesame, warm spices.'),
  (name: 'Shishir', en: 'Late Winter',  months: 'Jan–Feb', tip: 'Heavy, warm foods. Avoid cold and dry.'),
];

// ── Screen ─────────────────────────────────────────────────────────────────────

class AyurvedaHubScreen extends ConsumerStatefulWidget {
  const AyurvedaHubScreen({super.key});

  @override
  ConsumerState<AyurvedaHubScreen> createState() =>
      _AyurvedaHubScreenState();
}

class _AyurvedaHubScreenState extends ConsumerState<AyurvedaHubScreen> {
  // Placeholder dosha values — would come from user profile provider
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
    final m = DateTime.now().month;
    if (m == 3 || m == 4) return 'Vasant';
    if (m == 5 || m == 6) return 'Grishma';
    if (m == 7 || m == 8) return 'Varsha';
    if (m == 9 || m == 10) return 'Sharad';
    if (m == 11 || m == 12) return 'Hemant';
    return 'Shishir';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final dominant = _dominant;
    final doshaColor = _doshaColors[dominant]!;
    final rituals = _doshaRituals[dominant]!;
    final foods = _doshaFoods[dominant]!;
    final season = _seasons.firstWhere((s) => s.name == _currentSeason,
        orElse: () => _seasons.first);

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                        size: 20, color: text2),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ayurveda',
                          style: AppTypography.h1(color: text0)),
                      Text('आयुर्वेद',
                          style: AppTypography.hindi(color: text2)),
                    ],
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([

                      // ── Dosha donut chart ─────────────────────
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Row(
                          children: [
                            // 180px donut
                            SizedBox(
                              width: 180,
                              height: 180,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  PieChart(
                                    PieChartData(
                                      sectionsSpace: 3,
                                      centerSpaceRadius: 52,
                                      sections: [
                                        PieChartSectionData(
                                          value: _vata,
                                          color: _doshaColors['vata']!,
                                          radius: 28,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: _pitta,
                                          color: _doshaColors['pitta']!,
                                          radius: 28,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: _kapha,
                                          color: _doshaColors['kapha']!,
                                          radius: 28,
                                          showTitle: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Center: dominant dosha
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        dominant[0].toUpperCase() +
                                            dominant.substring(1),
                                        style: AppTypography.displayMd(
                                                color: doshaColor)
                                            .copyWith(shadows: [
                                          Shadow(
                                              color: doshaColor
                                                  .withValues(alpha: 0.4),
                                              blurRadius: 16),
                                        ]),
                                      ),
                                      Text('dominant',
                                          style: AppTypography.caption(
                                              color: text2)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Legend + retake
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  _DoshaLegendRow(
                                      label: 'Vata',
                                      value: _vata,
                                      color: _doshaColors['vata']!,
                                      text2: text2),
                                  const SizedBox(height: 8),
                                  _DoshaLegendRow(
                                      label: 'Pitta',
                                      value: _pitta,
                                      color: _doshaColors['pitta']!,
                                      text2: text2),
                                  const SizedBox(height: 8),
                                  _DoshaLegendRow(
                                      label: 'Kapha',
                                      value: _kapha,
                                      color: _doshaColors['kapha']!,
                                      text2: text2),
                                  const SizedBox(height: 14),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text('Retake Quiz →',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: doshaColor)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Daily rituals ─────────────────────────
                      Text('Daily Rituals',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: rituals.asMap().entries.map((e) {
                            final i = e.key;
                            final r = e.value;
                            final key = '${dominant}_$i';
                            final done = _completedRituals.contains(key);
                            return Column(
                              children: [
                                if (i > 0)
                                  Divider(color: divider, height: 1),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSpacing.cardH,
                                      vertical: 12),
                                  child: Row(
                                    children: [
                                      Text(r.icon,
                                          style: const TextStyle(
                                              fontSize: 22)),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(r.en,
                                                style: AppTypography
                                                    .labelMd(
                                                        color: text0)),
                                            Text(r.hi,
                                                style: AppTypography
                                                    .hindi(
                                                        color: text2)),
                                          ],
                                        ),
                                      ),
                                      Text(r.time,
                                          style: AppTypography.caption(
                                              color: text2)),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          if (done) {
                                            _completedRituals
                                                .remove(key);
                                          } else {
                                            _completedRituals.add(key);
                                          }
                                        }),
                                        child: AnimatedContainer(
                                          duration: const Duration(
                                              milliseconds: 200),
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: done
                                                ? doshaColor.withValues(
                                                    alpha: 0.2)
                                                : Colors.transparent,
                                            border: Border.all(
                                                color: done
                                                    ? doshaColor
                                                    : divider),
                                          ),
                                          child: done
                                              ? Icon(
                                                  Icons.check_rounded,
                                                  size: 16,
                                                  color: doshaColor)
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Seasonal recommendations ──────────────
                      Text('Seasonal Recommendations',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColorsDark.teal
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(
                                        AppRadius.full),
                                    border: Border.all(
                                        color: AppColorsDark.teal
                                            .withValues(alpha: 0.4)),
                                  ),
                                  child: Text(
                                    '${season.name} · ${season.en}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppColorsDark.teal),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(season.months,
                                    style: AppTypography.caption(
                                        color: text2)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(season.tip,
                                style: AppTypography.bodyMd(color: text0)),
                            const SizedBox(height: 12),
                            // All 6 seasons mini-strip
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _seasons.map((s) {
                                  final active =
                                      s.name == _currentSeason;
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: active
                                            ? AppColorsDark.teal
                                                .withValues(alpha: 0.15)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(
                                                AppRadius.full),
                                        border: Border.all(
                                            color: active
                                                ? AppColorsDark.teal
                                                    .withValues(alpha: 0.4)
                                                : divider),
                                      ),
                                      child: Text(s.name,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: active
                                                  ? AppColorsDark.teal
                                                  : text2)),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Food guide ────────────────────────────
                      Text('Food Guide for ${dominant[0].toUpperCase()}${dominant.substring(1)}',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      GlassCard(
                        borderRadius: AppRadius.md,
                        padding: const EdgeInsets.all(AppSpacing.cardH),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good for you',
                                style: AppTypography.labelMd(
                                    color: AppColorsDark.teal)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: foods.good
                                  .map((f) => _FoodChip(
                                      label: f,
                                      color: AppColorsDark.teal))
                                  .toList(),
                            ),
                            const SizedBox(height: 14),
                            Text('Avoid',
                                style: AppTypography.labelMd(
                                    color: AppColorsDark.error)),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: foods.avoid
                                  .map((f) => _FoodChip(
                                      label: f,
                                      color: AppColorsDark.error))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.fabClearance),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Dosha legend row ───────────────────────────────────────────────────────────

class _DoshaLegendRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color, text2;
  const _DoshaLegendRow(
      {required this.label,
      required this.value,
      required this.color,
      required this.text2});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color)),
          const Spacer(),
          Text('${value.toInt()}%',
              style: TextStyle(fontSize: 11, color: text2)),
        ],
      );
}

// ── Food chip ──────────────────────────────────────────────────────────────────

class _FoodChip extends StatelessWidget {
  final String label;
  final Color color;
  const _FoodChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: color)),
      );
}
