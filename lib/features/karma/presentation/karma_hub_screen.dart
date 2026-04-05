import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/auth_repository.dart';
import '../../../shared/widgets/karma_level_card.dart';

class KarmaHubScreen extends ConsumerWidget {
  const KarmaHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {},
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Please login'));
          }

          return const SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KarmaLevelCard(
                  currentXP: 0,
                  nextXP: 100,
                  levelName: 'Newcomer',
                  nextLevelName: 'Learner',
                ),
                SizedBox(height: 24),
                _ActivitySection(),
                SizedBox(height: 24),
                _StreakSection(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.star_border,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 8),
                  const Text('Start logging to earn karma!'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StreakSection extends StatelessWidget {
  const _StreakSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Streaks',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _StreakCard(
                icon: Icons.restaurant,
                label: 'Food',
                days: 0,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StreakCard(
                icon: Icons.directions_walk,
                label: 'Steps',
                days: 0,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _StreakCard(
                icon: Icons.fitness_center,
                label: 'Workout',
                days: 0,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int days;
  final Color color;

  const _StreakCard({
    required this.icon,
    required this.label,
    required this.days,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              days > 0 ? '$days' : '-',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: days > 0 ? color : Colors.grey,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class KarmaStoreScreen extends StatelessWidget {
  const KarmaStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Store'),
      ),
      body: const Center(
        child: Text('Rewards coming soon!'),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: const Center(
        child: Text('Leaderboard coming soon!'),
      ),
    );
  }
}