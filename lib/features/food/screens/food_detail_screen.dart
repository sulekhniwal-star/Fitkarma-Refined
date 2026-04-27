import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/glass_card.dart';

// ── Mock food data ─────────────────────────────────────────────────────────────

class _FoodData {
  final String id, name, hindi;
  final double kcal, proteinG, carbsG, fatG;
  final double ironMg, b12Mcg, vitDIu, calciumMg;

  const _FoodData({
    required this.id,
    required this.name,
    required this.hindi,
    required this.kcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.ironMg,
    required this.b12Mcg,
    required this.vitDIu,
    required this.calciumMg,
  });
}

const _foodDb = {
  'dal_rice': _FoodData(
    id: 'dal_rice', name: 'Dal Rice', hindi: 'दाल चावल',
    kcal: 320, proteinG: 12, carbsG: 58, fatG: 4,
    ironMg: 3.2, b12Mcg: 0.0, vitDIu: 0, calciumMg: 48,
  ),
  'roti': _FoodData(
    id: 'roti', name: 'Roti', hindi: 'रोटी',
    kcal: 80, proteinG: 3, carbsG: 15, fatG: 1,
    ironMg: 1.1, b12Mcg: 0.0, vitDIu: 0, calciumMg: 14,
  ),
  'sabzi': _FoodData(
    id: 'sabzi', name: 'Aloo Sabzi', hindi: 'आलू सब्ज़ी',
    kcal: 150, proteinG: 3, carbsG: 28, fatG: 4,
    ironMg: 1.8, b12Mcg: 0.0, vitDIu: 0, calciumMg: 22,
  ),
  'curd': _FoodData(
    id: 'curd', name: 'Curd', hindi: 'दही',
    kcal: 60, proteinG: 4, carbsG: 5, fatG: 3,
    ironMg: 0.1, b12Mcg: 0.4, vitDIu: 2, calciumMg: 120,
  ),
  'idli': _FoodData(
    id: 'idli', name: 'Idli', hindi: 'इडली',
    kcal: 70, proteinG: 2, carbsG: 14, fatG: 0.5,
    ironMg: 0.6, b12Mcg: 0.0, vitDIu: 0, calciumMg: 10,
  ),
  'poha': _FoodData(
    id: 'poha', name: 'Poha', hindi: 'पोहा',
    kcal: 250, proteinG: 5, carbsG: 48, fatG: 5,
    ironMg: 2.4, b12Mcg: 0.0, vitDIu: 0, calciumMg: 18,
  ),
};

const _servingSizes = ['½ katori', '1 katori', '2 katori', '1 piece', '2 pieces', '1 glass', '1 tbsp', '2 tbsp'];

// ── Screen ─────────────────────────────────────────────────────────────────────

class FoodDetailScreen extends ConsumerStatefulWidget {
  final String foodId;
  const FoodDetailScreen({super.key, required this.foodId});

  @override
  ConsumerState<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends ConsumerState<FoodDetailScreen>
    with SingleTickerProviderStateMixin {
  int _servingIndex = 1; // default: 1 katori
  late AnimationController _barAnim;
  late Animation<double> _barProgress;

  @override
  void initState() {
    super.initState();
    _barAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _barProgress =
        CurvedAnimation(parent: _barAnim, curve: Curves.easeOut);
    _barAnim.forward();
  }

  @override
  void dispose() {
    _barAnim.dispose();
    super.dispose();
  }

  double get _multiplier {
    // Rough multiplier per serving label
    const m = [0.5, 1.0, 2.0, 1.0, 2.0, 1.0, 0.25, 0.5];
    return m[_servingIndex.clamp(0, m.length - 1)];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final food = _foodDb[widget.foodId] ??
        const _FoodData(
          id: 'unknown', name: 'Food Item', hindi: 'खाना',
          kcal: 200, proteinG: 8, carbsG: 30, fatG: 5,
          ironMg: 1.0, b12Mcg: 0.1, vitDIu: 10, calciumMg: 50,
        );

    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final bg0 = isDark ? AppColorsDark.bg0 : AppColorsLight.bg0;
    final surface1 = isDark ? AppColorsDark.surface1 : AppColorsLight.surface1;

    final kcal = (food.kcal * _multiplier).round();
    final protein = (food.proteinG * _multiplier).toStringAsFixed(1);
    final carbs = (food.carbsG * _multiplier).toStringAsFixed(1);
    final fat = (food.fatG * _multiplier).toStringAsFixed(1);

    return Scaffold(
      backgroundColor: bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── Hero: blurred food photo (colour placeholder) ───
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppGradients.heroPrimary
                  : AppGradients.heroDeepLight,
            ),
            child: Stack(
              children: [
                const AmbientBlobs(),
                // Back button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenH),
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Bilingual name + kcal hero
                Positioned(
                  bottom: 24,
                  left: AppSpacing.screenH,
                  right: AppSpacing.screenH,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(food.name,
                          style: AppTypography.displayMd(
                              color: Colors.white)),
                      Text(food.hindi,
                          style: AppTypography.hindi(
                              color: Colors.white70)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '$kcal',
                            style: AppTypography.metricLg(
                                color: primary),
                          ),
                          const SizedBox(width: 4),
                          Text('kcal',
                              style: AppTypography.labelMd(
                                  color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Scrollable body ─────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.62,
            minChildSize: 0.62,
            maxChildSize: 1.0,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: surface1,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.xl)),
              ),
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenH, 20, AppSpacing.screenH, 32),
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColorsDark.divider
                            : AppColorsLight.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // ── Serving size drum-roll picker ─────────────
                  Text('Serving Size',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 44,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _servingSizes.length,
                      itemBuilder: (_, i) {
                        final active = i == _servingIndex;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _servingIndex = i);
                              _barAnim
                                ..reset()
                                ..forward();
                            },
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: active
                                    ? primary
                                    : primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(
                                    AppRadius.full),
                                border: Border.all(
                                  color: active
                                      ? Colors.transparent
                                      : primary.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Text(
                                _servingSizes[i],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: active
                                      ? Colors.white
                                      : primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Macro table with animated bars ────────────
                  Text('Macronutrients',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 12),
                  GlassCard(
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: AnimatedBuilder(
                      animation: _barProgress,
                      builder: (_, __) => Column(
                        children: [
                          _MacroRow(
                            label: 'Calories',
                            value: '$kcal kcal',
                            progress: (food.kcal / 2000).clamp(0.0, 1.0) *
                                _barProgress.value,
                            color: primary,
                            text0: text0,
                            text2: text2,
                          ),
                          const SizedBox(height: 12),
                          _MacroRow(
                            label: 'Protein',
                            value: '${protein}g',
                            progress:
                                (food.proteinG / 120).clamp(0.0, 1.0) *
                                    _barProgress.value,
                            color: AppColorsDark.teal,
                            text0: text0,
                            text2: text2,
                          ),
                          const SizedBox(height: 12),
                          _MacroRow(
                            label: 'Carbs',
                            value: '${carbs}g',
                            progress:
                                (food.carbsG / 250).clamp(0.0, 1.0) *
                                    _barProgress.value,
                            color: AppColorsDark.accent,
                            text0: text0,
                            text2: text2,
                          ),
                          const SizedBox(height: 12),
                          _MacroRow(
                            label: 'Fat',
                            value: '${fat}g',
                            progress:
                                (food.fatG / 65).clamp(0.0, 1.0) *
                                    _barProgress.value,
                            color: AppColorsDark.secondary,
                            text0: text0,
                            text2: text2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Micronutrient table with RDA % ────────────
                  Text('Micronutrients',
                      style: AppTypography.h4(color: text0)),
                  const SizedBox(height: 12),
                  GlassCard(
                    padding: const EdgeInsets.all(AppSpacing.cardH),
                    child: Column(
                      children: [
                        _MicroRow(
                          label: 'Iron',
                          value:
                              '${(food.ironMg * _multiplier).toStringAsFixed(1)} mg',
                          rdaPct:
                              (food.ironMg * _multiplier / 18 * 100)
                                  .round(),
                          color: AppColorsDark.error,
                          text0: text0,
                          text2: text2,
                        ),
                        const Divider(height: 20),
                        _MicroRow(
                          label: 'Vitamin B12',
                          value:
                              '${(food.b12Mcg * _multiplier).toStringAsFixed(1)} µg',
                          rdaPct:
                              (food.b12Mcg * _multiplier / 2.4 * 100)
                                  .round(),
                          color: AppColorsDark.secondary,
                          text0: text0,
                          text2: text2,
                        ),
                        const Divider(height: 20),
                        _MicroRow(
                          label: 'Vitamin D',
                          value:
                              '${(food.vitDIu * _multiplier).round()} IU',
                          rdaPct:
                              (food.vitDIu * _multiplier / 600 * 100)
                                  .round(),
                          color: AppColorsDark.accent,
                          text0: text0,
                          text2: text2,
                        ),
                        const Divider(height: 20),
                        _MicroRow(
                          label: 'Calcium',
                          value:
                              '${(food.calciumMg * _multiplier).round()} mg',
                          rdaPct:
                              (food.calciumMg * _multiplier / 1000 * 100)
                                  .round(),
                          color: AppColorsDark.teal,
                          text0: text0,
                          text2: text2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Add to Log button ─────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: Text(
                        'Add $kcal kcal to Log',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Macro row ──────────────────────────────────────────────────────────────────

class _MacroRow extends StatelessWidget {
  final String label, value;
  final double progress;
  final Color color;
  final Color text0, text2;

  const _MacroRow({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
    required this.text0,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 13, color: text2)),
              Text(value,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: text0)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: color.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      );
}

// ── Micro row ──────────────────────────────────────────────────────────────────

class _MicroRow extends StatelessWidget {
  final String label, value;
  final int rdaPct;
  final Color color;
  final Color text0, text2;

  const _MicroRow({
    required this.label,
    required this.value,
    required this.rdaPct,
    required this.color,
    required this.text0,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 13, color: text2)),
          ),
          Text(value,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: text0)),
          const SizedBox(width: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              '$rdaPct% RDA',
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color),
            ),
          ),
        ],
      );
}
