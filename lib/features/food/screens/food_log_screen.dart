import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/food_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/interaction_widgets.dart';

// ── Static mock data ───────────────────────────────────────────────────────────

const _frequentFoods = [
  {'id': 'dal_rice', 'name': 'Dal Rice', 'hindi': 'दाल चावल', 'kcal': 320.0, 'portion': '1 katori'},
  {'id': 'roti', 'name': 'Roti', 'hindi': 'रोटी', 'kcal': 80.0, 'portion': '1 piece'},
  {'id': 'sabzi', 'name': 'Aloo Sabzi', 'hindi': 'आलू सब्ज़ी', 'kcal': 150.0, 'portion': '1 katori'},
  {'id': 'curd', 'name': 'Curd', 'hindi': 'दही', 'kcal': 60.0, 'portion': '1 glass'},
  {'id': 'idli', 'name': 'Idli', 'hindi': 'इडली', 'kcal': 70.0, 'portion': '2 pieces'},
  {'id': 'poha', 'name': 'Poha', 'hindi': 'पोहा', 'kcal': 250.0, 'portion': '1 katori'},
];

const _restaurantResults = [
  {'name': 'Butter Chicken', 'hindi': 'बटर चिकन', 'kcal': 490.0, 'portion': '1 serving', 'source': 'Swiggy'},
  {'name': 'Paneer Tikka', 'hindi': 'पनीर टिक्का', 'kcal': 310.0, 'portion': '6 pieces', 'source': 'Zomato'},
];

class FoodLogScreen extends ConsumerStatefulWidget {
  final String mealType;
  const FoodLogScreen({super.key, required this.mealType});

  @override
  ConsumerState<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends ConsumerState<FoodLogScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  final Set<String> _selected = {}; // food IDs staged for this meal

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String get _mealLabel {
    const labels = {
      'breakfast': 'Breakfast',
      'lunch': 'Lunch',
      'dinner': 'Dinner',
      'snack': 'Snacks',
    };
    return labels[widget.mealType] ?? widget.mealType;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final bg1 = isDark ? AppColorsDark.bg1 : AppColorsLight.bg1;
    final surface0 = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;

    final searchAsync = _query.length >= 2
        ? ref.watch(foodSearchProvider(_query))
        : const AsyncValue<List<dynamic>>.data([]);

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: Column(
              children: [
                // ── App bar row ─────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH, 12, AppSpacing.screenH, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20, color: text2),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('Log $_mealLabel',
                            style: AppTypography.h1(color: text0)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // ── Glass search bar ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: surface0,
                      borderRadius:
                          BorderRadius.circular(AppRadius.full),
                      border: Border.all(color: divider),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 14),
                        Icon(Icons.search_rounded, size: 20, color: text2),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchCtrl,
                            style: AppTypography.bodyMd(color: text0),
                            decoration: InputDecoration(
                              hintText: 'Search food / खाना खोजें',
                              hintStyle: AppTypography.bodyMd(color: text2),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (v) => setState(() => _query = v),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.mic_none_rounded,
                              size: 20, color: text2),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                              minWidth: 40, minHeight: 40),
                        ),
                        IconButton(
                          icon: Icon(Icons.qr_code_scanner_rounded,
                              size: 20, color: text2),
                          onPressed: () =>
                              context.push('/home/food/lab-scan'),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                              minWidth: 40, minHeight: 40),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Quick-action chips ──────────────────────────
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH),
                    children: [
                      _QuickChip(
                          icon: Icons.document_scanner_rounded,
                          label: 'Scan Label',
                          onTap: () =>
                              context.push('/home/food/lab-scan')),
                      _QuickChip(
                          icon: Icons.camera_alt_rounded,
                          label: 'Upload Plate',
                          onTap: () {}),
                      _QuickChip(
                          icon: Icons.biotech_rounded,
                          label: 'Lab/Rx Scan',
                          onTap: () =>
                              context.push('/home/food/lab-scan')),
                      _QuickChip(
                          icon: Icons.edit_rounded,
                          label: 'Manual',
                          onTap: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // ── Scrollable body ─────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH, vertical: 8),
                    children: [
                      // Search results (when query ≥ 2 chars)
                      if (_query.length >= 2) ...[
                        Text('Search Results',
                            style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 8),
                        searchAsync.when(
                          loading: () => const Center(
                              child: CircularProgressIndicator()),
                          error: (e, _) => Text('$e',
                              style: AppTypography.bodySm()),
                          data: (results) => results.isEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 16),
                                  child: Text('No results found',
                                      style: AppTypography.bodySm(
                                          color: text2)),
                                )
                              : Column(
                                  children: results
                                      .map((f) => _SearchResultRow(
                                            name: f.foodName,
                                            kcal: f.calories,
                                            isSelected: _selected
                                                .contains(f.id),
                                            onToggle: () =>
                                                _toggleFood(f.id),
                                            text0: text0,
                                            text2: text2,
                                            primary: primary,
                                          ))
                                      .toList(),
                                ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Frequent Indian Portions — 2-col bento grid
                      Text('Frequent Indian Portions',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSpacing.bentoGap,
                          mainAxisSpacing: AppSpacing.bentoGap,
                          childAspectRatio: 1.55,
                        ),
                        itemCount: _frequentFoods.length,
                        itemBuilder: (_, i) {
                          final f = _frequentFoods[i];
                          final id = f['id'] as String;
                          return CardTapAnimation(
                            onTap: () => context.push(
                                '/home/food/detail/$id'),
                            child: FoodItemCard(
                              name: f['name'] as String,
                              hindiName: f['hindi'] as String,
                              calories: f['kcal'] as double,
                              portion: f['portion'] as String,
                              onAdd: () => _toggleFood(id),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // Restaurant Results
                      Text('Restaurant Results',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      ..._restaurantResults.map((f) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8),
                            child: _RestaurantRow(
                              name: f['name'] as String,
                              hindi: f['hindi'] as String,
                              kcal: f['kcal'] as double,
                              portion: f['portion'] as String,
                              source: f['source'] as String,
                              isSelected: _selected
                                  .contains(f['name']),
                              onToggle: () =>
                                  _toggleFood(f['name'] as String),
                              text0: text0,
                              text2: text2,
                              primary: primary,
                            ),
                          )),
                      const SizedBox(height: 20),

                      // Recent Logs
                      Text('Recent Logs',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                      ..._frequentFoods.take(3).map((f) => Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8),
                            child: _RecentLogRow(
                              name: f['name'] as String,
                              kcal: f['kcal'] as double,
                              portion: f['portion'] as String,
                              onReLog: () =>
                                  _toggleFood(f['id'] as String),
                              text0: text0,
                              text2: text2,
                              primary: primary,
                            ),
                          )),

                      // Bottom clearance for button
                      const SizedBox(height: 80),
                    ],
                  ),
                ),

                // ── Confirm Meal button (replaces FAB) ──────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenH, 8, AppSpacing.screenH, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _selected.isEmpty
                          ? null
                          : () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        disabledBackgroundColor:
                            primary.withValues(alpha: 0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppRadius.md),
                        ),
                      ),
                      child: Text(
                        _selected.isEmpty
                            ? 'Select items to confirm'
                            : 'Confirm ${_selected.length} item${_selected.length > 1 ? 's' : ''}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleFood(String id) =>
      setState(() => _selected.contains(id)
          ? _selected.remove(id)
          : _selected.add(id));
}

// ── Quick chip ─────────────────────────────────────────────────────────────────

class _QuickChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickChip(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface0 =
        isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;
    final text1 = isDark
        ? AppColorsDark.textSecondary
        : AppColorsLight.textSecondary;
    final divider =
        isDark ? AppColorsDark.divider : AppColorsLight.divider;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: surface0,
            borderRadius: BorderRadius.circular(AppRadius.full),
            border: Border.all(color: divider),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: text1),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: text1)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Search result row ──────────────────────────────────────────────────────────

class _SearchResultRow extends StatelessWidget {
  final String name;
  final double kcal;
  final bool isSelected;
  final VoidCallback onToggle;
  final Color text0, text2, primary;

  const _SearchResultRow({
    required this.name,
    required this.kcal,
    required this.isSelected,
    required this.onToggle,
    required this.text0,
    required this.text2,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: GlassCard(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: text0)),
                    Text('${kcal.toInt()} kcal',
                        style: TextStyle(fontSize: 11, color: text2)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onToggle,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primary
                        : primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.add,
                    size: 16,
                    color: isSelected
                        ? Colors.white
                        : primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// ── Restaurant row ─────────────────────────────────────────────────────────────

class _RestaurantRow extends StatelessWidget {
  final String name, hindi, portion, source;
  final double kcal;
  final bool isSelected;
  final VoidCallback onToggle;
  final Color text0, text2, primary;

  const _RestaurantRow({
    required this.name,
    required this.hindi,
    required this.portion,
    required this.source,
    required this.kcal,
    required this.isSelected,
    required this.onToggle,
    required this.text0,
    required this.text2,
    required this.primary,
  });

  Color get _sourceColor =>
      source == 'Swiggy' ? const Color(0xFFFC8019) : const Color(0xFFE23744);

  @override
  Widget build(BuildContext context) => GlassCard(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: text0)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _sourceColor.withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(source,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: _sourceColor)),
                      ),
                    ],
                  ),
                  Text(hindi,
                      style: TextStyle(fontSize: 11, color: text2)),
                  Text('$portion · ${kcal.toInt()} kcal',
                      style: TextStyle(fontSize: 11, color: text2)),
                ],
              ),
            ),
            GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isSelected
                      ? primary
                      : primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSelected ? Icons.check : Icons.add,
                  size: 16,
                  color: isSelected ? Colors.white : primary,
                ),
              ),
            ),
          ],
        ),
      );
}

// ── Recent log row ─────────────────────────────────────────────────────────────

class _RecentLogRow extends StatelessWidget {
  final String name, portion;
  final double kcal;
  final VoidCallback onReLog;
  final Color text0, text2, primary;

  const _RecentLogRow({
    required this.name,
    required this.portion,
    required this.kcal,
    required this.onReLog,
    required this.text0,
    required this.text2,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) => GlassCard(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(Icons.history_rounded, size: 18, color: text2),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: text0)),
                  Text('$portion · ${kcal.toInt()} kcal',
                      style: TextStyle(fontSize: 11, color: text2)),
                ],
              ),
            ),
            TextButton(
              onPressed: onReLog,
              style: TextButton.styleFrom(
                foregroundColor: primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Re-log',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      );
}
