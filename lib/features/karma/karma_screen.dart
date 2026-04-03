import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/karma/data/karma_notifier.dart';
import 'package:fitkarma/features/karma/data/karma_aw_service.dart';
import 'package:fitkarma/shared/widgets/karma_level_card.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class KarmaHubScreen extends ConsumerWidget {
  const KarmaHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karmaState = ref.watch(karmaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Hub'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.store),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const KarmaStoreScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
            ),
          ),
        ],
      ),
      body: karmaState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (state) => _buildContent(context, ref, state),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, KarmaState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KarmaLevelCard(
            currentKarma: state.totalKarma,
            nextLevelKarma: state.level * 100,
            level: state.level,
          ),
          const SizedBox(height: 16),
          _buildStreakCard(context, ref, state),
          const SizedBox(height: 16),
          _buildStatsRow(state),
          const SizedBox(height: 16),
          _buildHistoryList(state),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, WidgetRef ref, KarmaState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_fire_department, color: Colors.orange, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.streak} day streak',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '×${state.multiplier.toStringAsFixed(1)} multiplier',
                      style: TextStyle(color: Colors.orange.shade700),
                    ),
                  ],
                ),
              ),
              if (state.multiplier > 1)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    state.multiplier >= 2 ? '🔥 MAX' : '✨ Active',
                    style: TextStyle(color: Colors.green.shade700, fontSize: 12),
                  ),
                ),
            ],
          ),
          if (state.canRecoverStreak) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Text(
              'Streak broken? Recover it for 50 XP',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _recoverStreak(context, ref),
                icon: const Icon(Icons.restore, size: 18),
                label: const Text('Recover Streak (50 XP)'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange.shade700,
                  side: BorderSide(color: Colors.orange.shade300),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _recoverStreak(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(karmaNotifierProvider.notifier).recoverStreak();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Streak recovered! Keep it going! 🔥'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildStatsRow(KarmaState state) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'This Week',
            '+${state.recentEarnings}',
            Icons.trending_up,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'To Next Level',
            '${state.xpToNextLevel} XP',
            Icons.star,
            Colors.amber,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHistoryList(KarmaState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        if (state.history.isEmpty)
          const Center(child: Text('No karma yet. Start earning!'))
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.history.length.clamp(0, 10),
            itemBuilder: (context, index) {
              final tx = state.history[index];
              return _buildHistoryItem(tx);
            },
          ),
      ],
    );
  }

  Widget _buildHistoryItem(dynamic tx) {
    final isPositive = tx.amount > 0;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isPositive ? Colors.green.shade100 : Colors.red.shade100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPositive ? Icons.add : Icons.remove,
          color: isPositive ? Colors.green : Colors.red,
        ),
      ),
      title: Text('${isPositive ? '+' : ''}${tx.amount} XP'),
      subtitle: Text(_formatDate(tx.createdAt)),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

class KarmaStoreScreen extends ConsumerWidget {
  const KarmaStoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karmaState = ref.watch(karmaNotifierProvider);
    final rewards = ref.watch(availableRewardsProvider);

    final currentKarma = karmaState.maybeWhen(
      data: (state) => state.totalKarma,
      orElse: () => 0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Store'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Text(
                  'Your Karma',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '$currentKarma XP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                final canAfford = currentKarma >= reward.cost;
                return _buildRewardCard(context, ref, reward, canAfford, currentKarma);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, WidgetRef ref, KarmaReward reward, bool canAfford, int currentKarma) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: canAfford ? AppColors.primary.withOpacity(0.1) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              reward.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          reward.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          reward.description,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),
        trailing: ElevatedButton(
          onPressed: canAfford
              ? () => _redeemReward(context, ref, reward, currentKarma)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canAfford ? AppColors.primary : Colors.grey.shade300,
            foregroundColor: Colors.white,
          ),
          child: Text('${reward.cost} XP'),
        ),
      ),
    );
  }

  Future<void> _redeemReward(BuildContext context, WidgetRef ref, KarmaReward reward, int currentKarma) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Redeem ${reward.name}?'),
        content: Text('This will cost ${reward.cost} XP. You have $currentKarma XP.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Redeem'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref.read(karmaNotifierProvider.notifier).redeemReward(reward);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? 'Enjoy your reward!' : 'Not enough XP'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    }
  }
}

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Friends'),
            Tab(text: 'City'),
            Tab(text: 'National'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLeaderboardTab('friends'),
          _buildLeaderboardTab('city'),
          _buildLeaderboardTab('national'),
        ],
      ),
    );
  }

  Widget _buildLeaderboardTab(String scope) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Weekly reset every Monday at midnight. Current standings shown.',
                  style: TextStyle(color: Colors.amber.shade900, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        _buildLeaderboardItem(1, 'You', 1250, true),
        _buildLeaderboardItem(2, 'Rahul S.', 1100, false),
        _buildLeaderboardItem(3, 'Priya K.', 980, false),
        _buildLeaderboardItem(4, 'Amit M.', 850, false),
        _buildLeaderboardItem(5, 'Sneha R.', 720, false),
      ],
    );
  }

  Widget _buildLeaderboardItem(int rank, String name, int xp, bool isCurrentUser) {
    Color? rankColor;
    IconData? rankIcon;
    
    if (rank == 1) {
      rankColor = const Color(0xFFFFD700);
      rankIcon = Icons.emoji_events;
    } else if (rank == 2) {
      rankColor = Colors.grey.shade400;
      rankIcon = Icons.emoji_events;
    } else if (rank == 3) {
      rankColor = Colors.brown.shade300;
      rankIcon = Icons.emoji_events;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.primary.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCurrentUser ? AppColors.primary : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: rankColor?.withOpacity(0.2) ?? Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: rankIcon != null
                  ? Icon(rankIcon, size: 18, color: rankColor)
                  : Text(
                      '$rank',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withOpacity(0.2),
            child: Text(
              name[0],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                if (isCurrentUser)
                  Text(
                    'You',
                    style: TextStyle(color: AppColors.primary, fontSize: 11),
                  ),
              ],
            ),
          ),
          Text(
            '$xp XP',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}