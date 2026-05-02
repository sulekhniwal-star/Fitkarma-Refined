import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/animation_widgets.dart';
import '../../../shared/widgets/glass_card.dart';

const _categories = [
  'All', 'Yoga', 'HIIT', 'Strength', 'Cardio',
  'Dance', 'Bollywood', 'Cricket', 'Kabaddi', 'Pranayama',
];

const _catalogue = [
  {'id': 'yoga_flow',       'title': 'Morning Yoga Flow',     'duration': '30 min', 'difficulty': 'Beginner',     'premium': false, 'category': 'Yoga'},
  {'id': 'hiit_20',         'title': '20-Min HIIT Blast',     'duration': '20 min', 'difficulty': 'Intermediate', 'premium': false, 'category': 'HIIT'},
  {'id': 'strength_upper',  'title': 'Upper Body Strength',   'duration': '45 min', 'difficulty': 'Intermediate', 'premium': false, 'category': 'Strength'},
  {'id': 'bollywood_dance', 'title': 'Bollywood Dance Fit',   'duration': '35 min', 'difficulty': 'Beginner',     'premium': true,  'category': 'Bollywood'},
  {'id': 'pranayama_basic', 'title': 'Pranayama Basics',      'duration': '20 min', 'difficulty': 'Beginner',     'premium': false, 'category': 'Pranayama'},
  {'id': 'cardio_run',      'title': 'Cardio Endurance Run',  'duration': '40 min', 'difficulty': 'Advanced',     'premium': true,  'category': 'Cardio'},
  {'id': 'kabaddi_drill',   'title': 'Kabaddi Agility Drill', 'duration': '25 min', 'difficulty': 'Intermediate', 'premium': true,  'category': 'Kabaddi'},
  {'id': 'cricket_fit',     'title': 'Cricket Fitness',       'duration': '30 min', 'difficulty': 'Intermediate', 'premium': false, 'category': 'Cricket'},
];

class WorkoutHomeScreen extends ConsumerStatefulWidget {
  const WorkoutHomeScreen({super.key});

  @override
  ConsumerState<WorkoutHomeScreen> createState() => _WorkoutHomeScreenState();
}

class _WorkoutHomeScreenState extends ConsumerState<WorkoutHomeScreen> {
  int _catIndex = 0;

  List<Map<String, dynamic>> get _filtered {
    if (_catIndex == 0) return List<Map<String, dynamic>>.from(_catalogue);
    final cat = _categories[_catIndex];
    return _catalogue
        .where((w) => w['category'] == cat)
        .map((w) => Map<String, dynamic>.from(w))
        .toList();
  }

  int _computeStreak(List<dynamic> workouts) {
    if (workouts.isEmpty) return 0;
    int streak = 0;
    DateTime check = DateTime.now();
    for (final w in workouts) {
      final d = (w as dynamic).startedAt as DateTime;
      if (check.difference(d).inDays <= 1) {
        streak++;
        check = d;
      } else {
        break;
      }
    }
    return streak;
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

    final historyAsync = ref.watch(workoutHistoryProvider());
    final streak = historyAsync.when(
      data: (list) => _computeStreak(list),
      loading: () => 0,
      error: (_, __) => 0,
    );

    final filtered = _filtered;

    return Scaffold(
      backgroundColor: bg1,
      body: Stack(
        children: [
          const AmbientBlobs(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // ── App bar ──────────────────────────────────────
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  title: Text('Workouts', style: AppTypography.h1(color: text0)),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add_rounded, color: text2),
                      onPressed: () => context.push('/home/workout/custom'),
                    ),
                  ],
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // ── Streak banner ─────────────────────────
                      if (streak > 0) ...[
                        _StreakBanner(
                            streak: streak, isDark: isDark, text0: text0),
                        const SizedBox(height: AppSpacing.bentoGap),
                      ],

                      // ── Featured workout ──────────────────────
                      _FeaturedCard(
                        workout: Map<String, dynamic>.from(_catalogue.first),
                        isDark: isDark,
                        text0: text0,
                        text2: text2,
                        primary: primary,
                      ),
                      const SizedBox(height: 20),

                      Text('Categories',
                          style: AppTypography.h4(color: text0)),
                      const SizedBox(height: 10),
                    ]),
                  ),
                ),

                // ── Category chips ────────────────────────────
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenH),
                      itemCount: _categories.length,
                      itemBuilder: (_, i) {
                        final active = i == _catIndex;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () => setState(() => _catIndex = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: active ? primary : surface0,
                                borderRadius: BorderRadius.circular(
                                    AppRadius.full),
                                border: Border.all(
                                  color: active
                                      ? Colors.transparent
                                      : divider,
                                ),
                              ),
                              child: Text(
                                _categories[i],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: active ? Colors.white : text2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // ── 2-col bento grid ──────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenH),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.bentoGap,
                      mainAxisSpacing: AppSpacing.bentoGap,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (_, i) => _WorkoutGridCard(
                        workout: filtered[i],
                        isDark: isDark,
                        text0: text0,
                        text2: text2,
                        primary: primary,
                      ),
                      childCount: filtered.length,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                    child: SizedBox(height: AppSpacing.fabClearance)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Streak banner ──────────────────────────────────────────────────────────────

class _StreakBanner extends StatelessWidget {
  final int streak;
  final bool isDark;
  final Color text0;
  const _StreakBanner(
      {required this.streak, required this.isDark, required this.text0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient:
            isDark ? AppGradients.heroPrimary : AppGradients.heroDeepLight,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          StreakFlameWidget(count: streak),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day $streak Streak!',
                  style: AppTypography.h3(color: Colors.white)),
              Text("Keep it up — don't break the chain",
                  style: AppTypography.bodySm(
                      color: Colors.white.withValues(alpha: 0.7))),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Featured card ──────────────────────────────────────────────────────────────

class _FeaturedCard extends StatelessWidget {
  final Map<String, dynamic> workout;
  final bool isDark;
  final Color text0, text2, primary;
  const _FeaturedCard(
      {required this.workout,
      required this.isDark,
      required this.text0,
      required this.text2,
      required this.primary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/workout/${workout['id']}'),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          gradient:
              isDark ? AppGradients.heroDeep : AppGradients.heroDeepLight,
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text('FEATURED',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: primary)),
            ),
            const SizedBox(height: 8),
            Text(workout['title'] as String,
                style: AppTypography.displayMd(color: Colors.white)),
            Text('${workout['duration']} · ${workout['difficulty']}',
                style: AppTypography.bodySm(
                    color: Colors.white.withValues(alpha: 0.7))),
            const Spacer(),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: () =>
                    context.push('/home/workout/${workout['id']}'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md)),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                ),
                child: const Text('Start',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Workout grid card ──────────────────────────────────────────────────────────

class _WorkoutGridCard extends StatelessWidget {
  final Map<String, dynamic> workout;
  final bool isDark;
  final Color text0, text2, primary;
  const _WorkoutGridCard(
      {required this.workout,
      required this.isDark,
      required this.text0,
      required this.text2,
      required this.primary});

  @override
  Widget build(BuildContext context) {
    final isPremium = workout['premium'] as bool;
    return GestureDetector(
      onTap: () => context.push('/home/workout/${workout['id']}'),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: isDark
                    ? AppGradients.heroDeep
                    : AppGradients.heroDeepLight,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Text(workout['category'] as String,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: primary)),
                  ),
                  const Spacer(),
                  Text(workout['title'] as String,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined,
                          size: 12,
                          color: Colors.white.withValues(alpha: 0.7)),
                      const SizedBox(width: 4),
                      Text(workout['duration'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ],
              ),
            ),
            if (isPremium)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColorsDark.accent.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.lock_rounded,
                      size: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
