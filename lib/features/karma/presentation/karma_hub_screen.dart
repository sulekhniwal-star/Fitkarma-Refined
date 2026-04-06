import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/karma_level_card.dart';
import '../data/karma_service.dart';
import '../../auth/data/auth_repository.dart';

class KarmaHubScreen extends ConsumerWidget {
  const KarmaHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final user = userAsync.asData?.value;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Gradient App Bar ──────────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6C3DC8), Color(0xFF3D1A7A)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'KARMA HUB · कर्म केंद्र',
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Namaste, ${user?.name ?? 'Yogi'} 🙏',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.store_outlined, color: Colors.white),
                tooltip: 'Karma Store',
                onPressed: () => context.push('/karma/store'),
              ),
              IconButton(
                icon: const Icon(Icons.leaderboard_outlined, color: Colors.white),
                tooltip: 'Leaderboard',
                onPressed: () => context.push('/karma/leaderboard'),
              ),
            ],
          ),

          // ── XP Level Card ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _XpLevelSection(userId: user?.$id ?? ''),
            ),
          ),

          // ── Streak Cards ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _StreakSection(userId: user?.$id ?? ''),
            ),
          ),

          // ── History Header ─────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
              child: Row(
                children: [
                  const Text(
                    'Activity History · गतिविधि इतिहास',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See all', style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
          ),

          // ── Transaction List ───────────────────────────────────────
          _KarmaHistoryList(userId: user?.$id ?? ''),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class _XpLevelSection extends ConsumerWidget {
  const _XpLevelSection({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Grab stream-based total XP
    final karmaNotifier = ref.watch(karmaServiceProvider.notifier);
    return StreamBuilder<int>(
      stream: karmaNotifier.watchTotalXP(),
      builder: (context, snapshot) {
        final totalXP = snapshot.data ?? 0;
        final level = karmaNotifier.calculateLevel(totalXP);
        final levelXP = (level - 1) * 100;
        final nextLevelXP = level * 100;
        final progress = (totalXP - levelXP) / (nextLevelXP - levelXP);

        return KarmaLevelCard(
          currentXP: totalXP - levelXP,
          nextXP: nextLevelXP - levelXP,
          levelName: 'Level $level',
          nextLevelName: 'Level ${level + 1}',
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class _StreakSection extends ConsumerWidget {
  const _StreakSection({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Static streak display — later wire to streak service
    final streaks = [
      _StreakData('🥗', 'Logging Streak', 7, 1.5),
      _StreakData('🏃', 'Step Streak', 3, 1.0),
      _StreakData('💧', 'Water Streak', 14, 2.0),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Streaks · लकड़ी',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: streaks.map((s) => Expanded(child: _StreakTile(data: s))).toList(),
        ),
      ],
    );
  }
}

class _StreakData {
  const _StreakData(this.emoji, this.label, this.days, this.multiplier);
  final String emoji;
  final String label;
  final int days;
  final double multiplier;
}

class _StreakTile extends StatelessWidget {
  const _StreakTile({required this.data});
  final _StreakData data;

  @override
  Widget build(BuildContext context) {
    final isHot = data.days >= 7;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isHot
              ? [const Color(0xFFFF6B35), const Color(0xFFFF3D00)]
              : [const Color(0xFF2C2C3E), const Color(0xFF1A1A2E)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            '${data.days}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('days', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '×${data.multiplier} XP',
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
class _KarmaHistoryList extends ConsumerWidget {
  const _KarmaHistoryList({required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (userId.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // Placeholder tiles — wire to Drift stream later
            final actions = [
              ('🍛', 'Food Logged', '+10 XP', '9:30 AM'),
              ('🏃', 'Step Goal Reached', '+50 XP', '8:15 AM'),
              ('💧', 'Water Goal', '+20 XP', 'Yesterday'),
              ('💪', 'Workout Completed', '+20 XP', 'Yesterday'),
              ('😊', 'Mood Tracked', '+5 XP', '2 days ago'),
            ];
            if (index >= actions.length) return null;
            final item = actions[index];
            return _HistoryTile(
              emoji: item.$1,
              label: item.$2,
              xp: item.$3,
              time: item.$4,
            );
          },
          childCount: 5,
        ),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.emoji,
    required this.label,
    required this.xp,
    required this.time,
  });

  final String emoji;
  final String label;
  final String xp;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              xp,
              style: const TextStyle(
                color: Color(0xFF2ECC71),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}