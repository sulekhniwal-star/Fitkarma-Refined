import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/ambient_widgets.dart';
import '../../../shared/widgets/challenge_widgets.dart';
import '../../../shared/widgets/glass_card.dart';
import '../providers/karma_provider.dart';

class KarmaHubScreen extends ConsumerStatefulWidget {
  const KarmaHubScreen({super.key});

  @override
  ConsumerState<KarmaHubScreen> createState() => _KarmaHubScreenState();
}

class _KarmaHubScreenState extends ConsumerState<KarmaHubScreen>
    with SingleTickerProviderStateMixin {
  int _leaderboardTab = 0;
  late AnimationController _xpAnim;
  late Animation<double> _xpProgress;

  @override
  void initState() {
    super.initState();
    _xpAnim = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _xpProgress = CurvedAnimation(parent: _xpAnim, curve: Curves.easeOut);
    _xpAnim.forward();
  }

  @override
  void dispose() {
    _xpAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final karmaAsync = ref.watch(userKarmaProvider);

    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;
    final amber = isDark ? AppColorsDark.accent : AppColorsLight.accent;
    final secondary = isDark ? AppColorsDark.secondary : AppColorsLight.secondary;
    final primary = isDark ? AppColorsDark.primary : AppColorsLight.primary;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg0 : AppColorsLight.bg0,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ── heroDeep gradient ───────────────────────────────
          Container(
            height: 320,
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.heroDeep : AppGradients.heroDeepLight,
            ),
            child: const AmbientBlobs(),
          ),

          // ── Pattern B body ──────────────────────────────────
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1.0,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.surface1 : AppColorsLight.surface1,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  // ── Hero: XP total + animated progress + level badge ──
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.screenH, 24, AppSpacing.screenH, 8,
                      ),
                      child: karmaAsync.when(
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Text('Error: $e'),
                        data: (profile) {
                          final xp = profile?.xp ?? 1250;
                          final level = profile?.level ?? 5;
                          final levelName = _levelName(level);
                          final currentFloor = _xpFloor(level);
                          final nextCeil = _xpFloor(level + 1);
                          final rawProgress = nextCeil > currentFloor
                              ? (xp - currentFloor) / (nextCeil - currentFloor)
                              : 0.0;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // displayLg XP total
                              Text(
                                '$xp',
                                style: AppTypography.displayLg(color: text0),
                              ),
                              Text('Total XP', style: AppTypography.bodySm(color: text2)),
                              const SizedBox(height: 16),

                              // Animated XP progress bar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Level $level → ${level + 1}',
                                      style: AppTypography.bodySm(color: text2)),
                                  Text('$xp / $nextCeil XP',
                                      style: AppTypography.bodySm(color: text2)),
                                ],
                              ),
                              const SizedBox(height: 6),
                              AnimatedBuilder(
                                animation: _xpProgress,
                                builder: (_, __) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: rawProgress * _xpProgress.value,
                                    minHeight: 8,
                                    backgroundColor: isDark
                                        ? AppColorsDark.surface0
                                        : AppColorsLight.surface0,
                                    valueColor: AlwaysStoppedAnimation(amber),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Level badge + coin tap
                              GestureDetector(
                                onTap: () {
                                  // TODO: play coin Lottie
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: secondary.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: secondary.withValues(alpha: 0.4)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('⭐ Level $level',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: secondary)),
                                      const SizedBox(width: 8),
                                      Text(levelName,
                                          style: AppTypography.bodySm(color: text2)),
                                      const SizedBox(width: 8),
                                      const Text('💰', style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // ── Sections ────────────────────────────────────────
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenH, vertical: AppSpacing.bentoGap),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Daily Rituals
                        Text('Daily Rituals', style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        ..._rituals.map((r) => _RitualTile(
                              icon: r['icon'] as String,
                              name: r['name'] as String,
                              completed: r['completed'] as bool,
                              isDark: isDark,
                            )),
                        const SizedBox(height: 20),

                        // Active Challenges
                        Text('Active Challenges', style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 140,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              ChallengeCarouselCard(
                                title: '10K Steps Challenge',
                                reward: '+100 XP',
                                progress: 0.75,
                              ),
                              ChallengeCarouselCard(
                                title: 'Meal Streak',
                                reward: '+50 XP',
                                progress: 0.50,
                                festivalTag: 'Navratri',
                              ),
                              ChallengeCarouselCard(
                                title: 'Sleep Goal',
                                reward: '+75 XP',
                                progress: 0.85,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Leaderboard
                        Text('Leaderboard', style: AppTypography.h4(color: text0)),
                        const SizedBox(height: 10),
                        _LeaderboardPillBar(
                          selected: _leaderboardTab,
                          onSelect: (i) => setState(() => _leaderboardTab = i),
                          isDark: isDark,
                          primary: primary,
                        ),
                        const SizedBox(height: 10),
                        ..._leaderboard.map((e) => _LeaderboardRow(
                              entry: e,
                              isDark: isDark,
                            )),
                        const SizedBox(height: 20),

                        // Karma Store
                        GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.cardH),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Karma Store', style: AppTypography.h4(color: text0)),
                                  Icon(Icons.store_rounded, color: amber),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text('Redeem XP for rewards',
                                  style: AppTypography.bodySm(color: text2)),
                              const SizedBox(height: 12),
                              // Streak Recovery amber pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: amber.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: amber.withValues(alpha: 0.3)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('🔥', style: TextStyle(fontSize: 16)),
                                        const SizedBox(width: 8),
                                        Text('Streak Recovery',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: amber)),
                                        const SizedBox(width: 6),
                                        Text('500 XP',
                                            style: AppTypography.bodySm(color: text2)),
                                      ],
                                    ),
                                    Text('Redeem',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: amber)),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }

  // ── Static data ─────────────────────────────────────────────────────────────

  static const _rituals = [
    {'icon': '🧘', 'name': 'Morning Yoga', 'completed': false},
    {'icon': '🕉️', 'name': 'Meditate 10 min', 'completed': true},
    {'icon': '💧', 'name': 'Drink 8 glasses', 'completed': false},
  ];

  static const _leaderboard = [
    {'name': 'Aarav', 'xp': 2100, 'rank': 1},
    {'name': 'Ishani', 'xp': 1850, 'rank': 2},
    {'name': 'Vihaan', 'xp': 1650, 'rank': 3},
    {'name': 'Priya', 'xp': 1500, 'rank': 4},
    {'name': 'You', 'xp': 1250, 'rank': 5},
  ];

  // ── Helpers ──────────────────────────────────────────────────────────────────

  String _levelName(int level) {
    const names = [
      'Newcomer', 'Beginner', 'Starter', 'Mover', 'Achiever',
      'Consistent', 'Dedicated', 'Warrior', 'Champion', 'Elite',
      'Legend', 'Grandmaster', 'Karma Master',
    ];
    return level > 0 && level <= names.length ? names[level - 1] : 'Karma Master';
  }

  int _xpFloor(int level) {
    const t = [0, 200, 500, 1000, 1800, 2800, 4200, 6000, 8500, 12000, 16000, 21000, 27000];
    return level > 0 && level < t.length ? t[level - 1] : 27000;
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _RitualTile extends StatelessWidget {
  final String icon;
  final String name;
  final bool completed;
  final bool isDark;

  const _RitualTile({
    required this.icon,
    required this.name,
    required this.completed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final successColor = isDark ? AppColorsDark.success : AppColorsLight.success;
    final dividerColor = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(name,
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500, color: text0)),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: completed ? successColor.withValues(alpha: 0.15) : Colors.transparent,
                border: Border.all(
                  color: completed ? successColor : dividerColor,
                  width: 2,
                ),
              ),
              child: completed
                  ? Icon(Icons.check, size: 14, color: successColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _LeaderboardPillBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final bool isDark;
  final Color primary;

  const _LeaderboardPillBar({
    required this.selected,
    required this.onSelect,
    required this.isDark,
    required this.primary,
  });

  static const _tabs = ['Friends', 'City', 'National', 'Seasonal'];

  @override
  Widget build(BuildContext context) {
    final divider = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final text1 = isDark ? AppColorsDark.textSecondary : AppColorsLight.textSecondary;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.asMap().entries.map((e) {
          final active = e.key == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => onSelect(e.key),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? primary : Colors.transparent,
                  border: Border.all(color: active ? Colors.transparent : divider),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  e.value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: active ? Colors.white : text1,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final Map<String, dynamic> entry;
  final bool isDark;

  const _LeaderboardRow({required this.entry, required this.isDark});

  static const _medals = {1: '🥇', 2: '🥈', 3: '🥉'};
  static const _glows = {
    1: Color(0xFFFFD700),
    2: Color(0xFFC0C0C0),
    3: Color(0xFFCD7F32),
  };

  @override
  Widget build(BuildContext context) {
    final rank = entry['rank'] as int;
    final medal = _medals[rank];
    final glowColor = _glows[rank];
    final text0 = isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary;
    final text2 = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        showGlow: glowColor != null,
        glowColor: glowColor,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                medal ?? '#$rank',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry['name'] as String,
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600, color: text0)),
                  Text('${entry['xp']} XP',
                      style: AppTypography.bodySm(color: text2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
