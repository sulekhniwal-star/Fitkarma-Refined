// lib/features/karma/presentation/karma_hub_screen.dart
// Karma Hub Screen - Level card, XP bar, karma history

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/karma/data/karma_models.dart';
import 'package:fitkarma/features/karma/data/karma_providers.dart';

class KarmaHubScreen extends ConsumerStatefulWidget {
  const KarmaHubScreen({super.key});

  @override
  ConsumerState<KarmaHubScreen> createState() => _KarmaHubScreenState();
}

class _KarmaHubScreenState extends ConsumerState<KarmaHubScreen> {
  @override
  Widget build(BuildContext context) {
    final karmaNotifier = ref.watch(karmaNotifierProvider);
    final state = karmaNotifier.state;

    // Initialize on first build
    if (state.isLoading && state.profile == null && state.error == null) {
      karmaNotifier.initialize();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () => Navigator.pushNamed(context, '/karma/store'),
          ),
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => Navigator.pushNamed(context, '/karma/leaderboard'),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                // Trigger refresh
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Level Card
                    _buildLevelCard(state.profile),
                    const SizedBox(height: 16),

                    // XP Progress Bar
                    _buildXpProgressBar(state.profile),
                    const SizedBox(height: 24),

                    // Stats Row
                    _buildStatsRow(state.profile),
                    const SizedBox(height: 24),

                    // Streak Section
                    _buildStreakSection(state.profile, karmaNotifier),
                    const SizedBox(height: 24),

                    // Recent Activity
                    _buildRecentActivity(state.transactions),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildLevelCard(KarmaProfile? profile) {
    final levelConfig = profile?.levelConfig ?? KarmaLevelConfig.levels.first;

    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Text(levelConfig.icon, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            Text(
              'Level ${levelConfig.level}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              levelConfig.title,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              '${profile?.totalXp ?? 0} XP',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXpProgressBar(KarmaProfile? profile) {
    final progress = profile?.progressToNextLevel ?? 0.0;
    final currentXp = profile?.totalXp ?? 0;
    final nextLevelXp = profile?.xpForNextLevel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Progress to Next Level',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (nextLevelXp != null) Text('$currentXp / $nextLevelXp XP'),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 16,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
          ),
        ),
        if (nextLevelXp == null)
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              '🎉 Maximum level reached!',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStatsRow(KarmaProfile? profile) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            value: '${profile?.currentStreak ?? 0}',
            label: 'Day Streak',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.emoji_events,
            iconColor: Colors.amber,
            value: '${profile?.longestStreak ?? 0}',
            label: 'Best Streak',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.bolt,
            iconColor: Colors.purple,
            value: '${profile?.streakMultiplier.toStringAsFixed(1) ?? "1.0"}x',
            label: 'Multiplier',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakSection(
    KarmaProfile? profile,
    KarmaNotifierSimple notifier,
  ) {
    final canRecover7Day = profile?.canRecover7DayStreak ?? false;
    final canRecover30Day = profile?.canRecover30DayStreak ?? false;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔥 Streak Recovery',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Recover a broken streak by spending 50 XP',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: canRecover7Day
                        ? () async {
                            final success = await notifier.useStreakRecovery(
                              true,
                            );
                            if (success && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('7-day streak recovered!'),
                                ),
                              );
                            }
                          }
                        : null,
                    icon: const Icon(Icons.restore),
                    label: const Text('7-Day'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: canRecover30Day
                        ? () async {
                            final success = await notifier.useStreakRecovery(
                              false,
                            );
                            if (success && mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('30-day streak recovered!'),
                                ),
                              );
                            }
                          }
                        : null,
                    icon: const Icon(Icons.restore),
                    label: const Text('30-Day'),
                  ),
                ),
              ],
            ),
            if (!canRecover7Day || !canRecover30Day)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '⏰ Recovery available once per 30 days',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(List<KarmaTransactionRecord> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '📜 Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (transactions.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No activity yet. Start earning XP!',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length.clamp(0, 10),
            itemBuilder: (context, index) {
              final txn = transactions[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: txn.amount > 0
                        ? Colors.green[100]
                        : Colors.red[100],
                    child: Icon(
                      txn.amount > 0 ? Icons.add : Icons.remove,
                      color: txn.amount > 0 ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(txn.action.replaceAll('_', ' ').toUpperCase()),
                  subtitle: Text(
                    _formatDate(txn.createdAt),
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    '${txn.amount > 0 ? '+' : ''}${txn.amount} XP',
                    style: TextStyle(
                      color: txn.amount > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';

    return '${date.day}/${date.month}/${date.year}';
  }
}
