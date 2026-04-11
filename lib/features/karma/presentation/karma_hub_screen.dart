import 'package:fitkarma/features/karma/data/streak_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/karma_level_card.dart';
import '../data/karma_service.dart';
import '../../auth/data/auth_repository.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

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
                   Text(
                    'Activity History · गतिविधि इतिहास',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
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
    final karmaNotifier = ref.watch(karmaServiceProvider.notifier);
    return StreamBuilder<int>(
      stream: karmaNotifier.watchTotalXP(),
      builder: (context, snapshot) {
        final totalXP = snapshot.data ?? 0;
        final level = karmaNotifier.calculateLevel(totalXP);
        final levelXP = (level - 1) * 100;
        final nextLevelXP = level * 100;

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
    if (userId.isEmpty) return const SizedBox.shrink();
    
    final streakService = ref.watch(streakServiceProvider.notifier);
    
    return StreamBuilder<List<UserStreak>>(
      stream: streakService.watchStreaks(userId),
      builder: (context, snapshot) {
        final streaks = snapshot.data ?? [];
        
        final activityIcons = {
          'food': '🥗',
          'steps': '🏃',
          'water': '💧',
          'workout': '💪',
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Streaks · लकड़ी',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: activityIcons.entries.map((e) {
                  final s = streaks.where((st) => st.activityType == e.key).firstOrNull;
                  final days = s?.streakCount ?? 0;
                  final multiplier = days >= 30 ? 2.0 : (days >= 7 ? 1.5 : 1.0);
                  final isBroken = s != null && _isBroken(s.lastActivityDate);
                  
                  return _StreakTile(
                    data: _StreakData(e.value, '${e.key[0].toUpperCase()}${e.key.substring(1)}', days, multiplier),
                    isBroken: isBroken,
                    onRecover: isBroken 
                        ? () => _showRecoveryDialog(context, ref, userId, e.key)
                        : null,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  bool _isBroken(DateTime? lastDate) {
    if (lastDate == null) return false;
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastDDate = DateTime(lastDate.year, lastDate.month, lastDate.day);
    return todayDate.difference(lastDDate).inDays > 1;
  }

  void _showRecoveryDialog(BuildContext context, WidgetRef ref, String userId, String activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Recover Your $activity Streak?'),
        content: const Text('Spend 50 Karma XP to restore your broken streak and keep your progress!'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              ref.read(streakServiceProvider.notifier).recoverStreak(userId, activity);
              Navigator.pop(context);
            },
            child: const Text('Recover (50 XP)'),
          ),
        ],
      ),
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
  const _StreakTile({required this.data, this.isBroken = false, this.onRecover});
  final _StreakData data;
  final bool isBroken;
  final VoidCallback? onRecover;

  @override
  Widget build(BuildContext context) {
    final isHot = data.days >= 7;
    return GestureDetector(
      onTap: onRecover,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isBroken 
                ? [Colors.grey[800]!, Colors.grey[900]!]
                : isHot
                    ? [const Color(0xFFFF6B35), const Color(0xFFFF3D00)]
                    : [const Color(0xFF2C2C3E), const Color(0xFF1A1A2E)],
          ),
          borderRadius: BorderRadius.circular(16),
          border: isBroken ? Border.all(color: Colors.red.withOpacity(0.5), width: 1.5) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.emoji, style: const TextStyle(fontSize: 24)),
                if (isBroken) const Icon(Icons.restore, color: Colors.orangeAccent, size: 20),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${data.days}',
              style: TextStyle(
                color: isBroken ? Colors.grey[400] : Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(isBroken ? 'broken' : 'days', 
                style: TextStyle(color: (isBroken ? Colors.redAccent : Colors.white).withOpacity(0.7), fontSize: 11)),
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

    final db = ref.watch(databaseProvider);
    return StreamBuilder<List<KarmaTransaction>>(
      stream: db.karmaTransactionsDao.watchRecentTransactions(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(48),
              child: Center(
                child: Column(
                  children: [
                    Icon(Icons.history_toggle_off, size: 48, color: Colors.grey[600]),
                    const SizedBox(height: 12),
                    Text('No activity recorded yet.', style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              ),
            ),
          );
        }

        final transactions = snapshot.data!;
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tx = transactions[index];
                return _HistoryTile(
                  emoji: _getEmoji(tx.activityType),
                  label: tx.activityType.replaceAll('_', ' ').replaceAll('Log', '').toUpperCase(),
                  xp: '${tx.amount > 0 ? '+' : ''}${tx.amount} XP',
                  time: _timeAgo(tx.createdAt),
                );
              },
              childCount: transactions.length,
            ),
          ),
        );
      },
    );
  }

  String _getEmoji(String type) {
    final t = type.toLowerCase();
    if (t.contains('food')) return '🍛';
    if (t.contains('step')) return '🏃';
    if (t.contains('workout')) return '💪';
    if (t.contains('water')) return '💧';
    if (t.contains('mood')) return '😊';
    if (t.contains('bp') || t.contains('pulse')) return '🩺';
    if (t.contains('glucose')) return '🩸';
    if (t.contains('recovery')) return '🔧';
    return '✨';
  }

  String _timeAgo(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${dt.day}/${dt.month}';
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
    final isNegative = xp.startsWith('-');
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
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.5)),
                Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: (isNegative ? Colors.orange : const Color(0xFF2ECC71)).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              xp,
              style: TextStyle(
                color: isNegative ? Colors.orange : const Color(0xFF2ECC71),
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