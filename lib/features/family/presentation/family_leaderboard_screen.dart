// lib/features/family/presentation/family_leaderboard_screen.dart
// Weekly step leaderboard for family members

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/family_models.dart';
import '../data/family_providers.dart';

/// Family leaderboard screen showing weekly step rankings
class FamilyLeaderboardScreen extends ConsumerWidget {
  final String userId;
  final String userName;
  final String? userEmail;

  const FamilyLeaderboardScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyDataAsync = ref.watch(familyDataProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('Weekly Leaderboard')),
      body: familyDataAsync.when(
        data: (familyData) {
          if (!familyData.hasFamily) {
            return _buildNoFamilyState(context);
          }

          return _buildLeaderboard(context, ref, familyData);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error.toString()),
      ),
    );
  }

  Widget _buildNoFamilyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.leaderboard, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Family Yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create or join a family to see the leaderboard!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard(
    BuildContext context,
    WidgetRef ref,
    FamilyData familyData,
  ) {
    final leaderboardAsync = ref.watch(
      familyLeaderboardProvider((familyData.family!.id, userId)),
    );

    return leaderboardAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(
              familyLeaderboardProvider((familyData.family!.id, userId)),
            );
          },
          child: Column(
            children: [
              // Header
              _buildHeader(context, entries),

              // Leaderboard list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    return _buildLeaderboardItem(
                      context,
                      entries[index],
                      entries[index].oduserId == userId,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildErrorState(context, error.toString()),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    List<FamilyLeaderboardEntry> entries,
  ) {
    // Find top 3 for podium
    final top3 = entries.take(3).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '🏆 This Week',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${_getTotalSteps(entries)} total steps',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 24),
          // Podium
          if (top3.isNotEmpty) _buildPodium(context, top3),
        ],
      ),
    );
  }

  Widget _buildPodium(BuildContext context, List<FamilyLeaderboardEntry> top3) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // 2nd place
        if (top3.length > 1)
          _buildPodiumItem(context, top3[1], 2, 80, Colors.grey.shade300),
        const SizedBox(width: 8),
        // 1st place
        if (top3.isNotEmpty)
          _buildPodiumItem(context, top3[0], 1, 100, Colors.amber),
        const SizedBox(width: 8),
        // 3rd place
        if (top3.length > 2)
          _buildPodiumItem(context, top3[2], 3, 60, Colors.brown.shade300),
      ],
    );
  }

  Widget _buildPodiumItem(
    BuildContext context,
    FamilyLeaderboardEntry entry,
    int rank,
    double height,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          entry.oduserName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        CircleAvatar(
          radius: rank == 1 ? 28 : 22,
          backgroundColor: color,
          child: Text(
            entry.oduserName.substring(0, 1).toUpperCase(),
            style: TextStyle(
              color: rank == 1 ? Colors.amber.shade700 : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: rank == 1 ? 20 : 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _formatNumber(entry.weeklySteps),
                style: TextStyle(
                  color: rank == 1 ? Colors.amber.shade700 : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                'steps',
                style: TextStyle(
                  color: rank == 1 ? Colors.amber.shade700 : Colors.black87,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: _getRankColor(rank),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '#$rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardItem(
    BuildContext context,
    FamilyLeaderboardEntry entry,
    bool isCurrentUser,
  ) {
    return Card(
      color: isCurrentUser ? Colors.blue.shade50 : null,
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 30,
              child: Text(
                '#${entry.rank}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getRankColor(entry.rank),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: _getRankColor(entry.rank).withOpacity(0.2),
              child: Text(
                entry.oduserName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: _getRankColor(entry.rank),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            Text(
              entry.oduserName,
              style: TextStyle(
                fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isCurrentUser) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
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
          ],
        ),
        subtitle: Row(
          children: [
            if (entry.distanceKm != null) ...[
              const Icon(Icons.directions_walk, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${entry.distanceKm!.toStringAsFixed(1)} km',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(width: 12),
            ],
            if (entry.activeMinutes > 0) ...[
              const Icon(Icons.timer, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${entry.activeMinutes} min',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatNumber(entry.weeklySteps),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            if (entry.streak > 0)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    size: 12,
                    color: Colors.orange,
                  ),
                  Text(
                    '${entry.streak} day streak',
                    style: const TextStyle(fontSize: 10, color: Colors.orange),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No leaderboard data yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Start tracking your steps to appear on the leaderboard!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $error'),
        ],
      ),
    );
  }

  int _getTotalSteps(List<FamilyLeaderboardEntry> entries) {
    int total = 0;
    for (final entry in entries) {
      total += entry.weeklySteps;
    }
    return total;
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}
