// lib/features/karma/presentation/leaderboard_screen.dart
// Leaderboard Screen - Friends / City / National tabs with weekly reset

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/karma/data/karma_models.dart';
import 'package:fitkarma/features/karma/data/karma_providers.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Friends'),
            Tab(text: 'City'),
            Tab(text: 'National'),
            Tab(text: 'Referrals'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Weekly reset banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.amber[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Weekly reset: Every Monday at midnight',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          // Leaderboard tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _LeaderboardList(type: 'friends'),
                _LeaderboardList(type: 'city'),
                _LeaderboardList(type: 'national'),
                _LeaderboardList(type: 'referrals'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardList extends ConsumerWidget {
  final String type;

  const _LeaderboardList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(leaderboardProvider(type));

    return leaderboardAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.leaderboard_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No leaderboard data yet',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  _getEmptyMessage(),
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return _LeaderboardTile(
              entry: entry,
              isCurrentUser: false, // TODO: Compare with current user ID
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      ),
    );
  }

  String _getEmptyMessage() {
    switch (type) {
      case 'friends':
        return 'Add friends to see them on the leaderboard';
      case 'city':
        return 'Users in your city will appear here';
      case 'national':
        return 'Top users across India will appear here';
      case 'referrals':
        return 'Share your referral code to climb the ranks!';
      default:
        return '';
    }
  }
}

class _LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool isCurrentUser;

  const _LeaderboardTile({required this.entry, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrentUser ? Colors.blue[50] : null,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRankBadge(),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: entry.avatarUrl != null
                  ? NetworkImage(entry.avatarUrl!)
                  : null,
              backgroundColor: Colors.grey[300],
              child: entry.avatarUrl == null
                  ? Text(entry.userName.substring(0, 1).toUpperCase())
                  : null,
            ),
          ],
        ),
        title: Row(
          children: [
            Text(
              entry.userName,
              style: TextStyle(
                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isCurrentUser)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Text(
          'Level ${entry.level}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.weeklyXp}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text('XP', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge() {
    Color badgeColor;
    IconData? icon;

    switch (entry.rank) {
      case 1:
        badgeColor = Colors.amber;
        icon = Icons.emoji_events;
        break;
      case 2:
        badgeColor = Colors.grey[400]!;
        icon = Icons.emoji_events;
        break;
      case 3:
        badgeColor = Colors.brown[400]!;
        icon = Icons.emoji_events;
        break;
      default:
        badgeColor = Colors.transparent;
        icon = null;
    }

    if (icon != null) {
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 18),
      );
    }

    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      child: Text(
        '#${entry.rank}',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
