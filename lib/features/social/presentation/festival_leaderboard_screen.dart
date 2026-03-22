// lib/features/social/presentation/festival_leaderboard_screen.dart
// Festival Leaderboard Screen - Indian festival tied seasonal leaderboards

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/social/data/social_models.dart';
import 'package:fitkarma/features/social/data/social_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

/// Festival Leaderboard Screen
class FestivalLeaderboardScreen extends ConsumerStatefulWidget {
  const FestivalLeaderboardScreen({super.key});

  @override
  ConsumerState<FestivalLeaderboardScreen> createState() =>
      _FestivalLeaderboardScreenState();
}

class _FestivalLeaderboardScreenState
    extends ConsumerState<FestivalLeaderboardScreen> {
  String? _currentUserId;
  FestivalInfo? _selectedFestival;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final authService = AuthAwService();
    final user = await authService.getCurrentUser();
    if (mounted) {
      setState(() => _currentUserId = user?.$id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final festivalsAsync = ref.watch(activeFestivalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Challenges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showFestivalInfo(context),
          ),
        ],
      ),
      body: festivalsAsync.when(
        data: (festivals) {
          if (festivals.isEmpty) {
            return _buildNoActiveFestivals();
          }
          return Column(
            children: [
              // Festival selector
              if (_selectedFestival == null)
                _buildFestivalSelector(festivals)
              else
                _buildSelectedFestivalHeader(),
              // Leaderboard
              Expanded(
                child: _selectedFestival != null
                    ? _FestivalLeaderboardList(
                        festival: _selectedFestival!,
                        currentUserId: _currentUserId ?? '',
                      )
                    : const Center(
                        child: Text('Select a festival to view leaderboard'),
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildNoActiveFestivals() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No Active Festival Challenges',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back soon for upcoming festivals!',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          const Text(
            'Upcoming Festivals:',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          _buildUpcomingFestivalsList(),
        ],
      ),
    );
  }

  Widget _buildUpcomingFestivalsList() {
    // Default festivals that will be available
    final festivals = _getDefaultFestivals();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: festivals.map((festival) {
          final now = DateTime.now();
          final isPast = festival.endDate.isBefore(now);
          final isActive = festival.isActive;

          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(
                _getFestivalIcon(festival.name),
                color: isActive ? Colors.green : Colors.orange,
              ),
              title: Text(festival.name),
              subtitle: Text(
                isPast
                    ? 'Ended'
                    : isActive
                    ? 'Active Now!'
                    : _formatDateRange(festival.startDate, festival.endDate),
              ),
              trailing: isActive
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<FestivalInfo> _getDefaultFestivals() {
    final now = DateTime.now();
    final year = now.year;
    return [
      FestivalInfo(
        id: 'navratri_$year',
        name: 'Navratri Wellness Challenge',
        startDate: DateTime(year, 10, 1),
        endDate: DateTime(year, 10, 10),
        leaderboardType: 'steps',
        targetValue: 90000,
      ),
      FestivalInfo(
        id: 'diwali_$year',
        name: 'Diwali Step Challenge',
        startDate: DateTime(year, 11, 1),
        endDate: DateTime(year, 11, 5),
        leaderboardType: 'steps',
        targetValue: 50000,
      ),
      FestivalInfo(
        id: 'holi_$year',
        name: 'Holi Fitness Challenge',
        startDate: DateTime(year, 3, 1),
        endDate: DateTime(year, 3, 31),
        leaderboardType: 'workout',
        targetValue: 10,
      ),
    ];
  }

  Widget _buildFestivalSelector(List<FestivalInfo> festivals) {
    return SizedBox(
      height: 120,
      ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: festivals.length,
        itemBuilder: (context, index) {
          final festival = festivals[index];
          return _FestivalCard(
            festival: festival,
            onTap: () => setState(() => _selectedFestival = festival),
          );
        },
      ),
    );
  }

  Widget _buildSelectedFestivalHeader() {
    final festival = _selectedFestival!;
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => setState(() => _selectedFestival = null),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  festival.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDateRange(festival.startDate, festival.endDate),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: festival.isActive ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              festival.isActive ? 'ACTIVE' : 'ENDED',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFestivalIcon(String name) {
    if (name.toLowerCase().contains('navratri')) return Icons.fitness_center;
    if (name.toLowerCase().contains('diwali')) return Icons.lightbulb;
    if (name.toLowerCase().contains('holi')) return Icons.palette;
    if (name.toLowerCase().contains('independence')) return Icons.flag;
    if (name.toLowerCase().contains('new year')) return Icons.celebration;
    return Icons.emoji_events;
  }

  String _formatDateRange(DateTime start, DateTime end) {
    final startStr = '${start.day}/${start.month}';
    final endStr = '${end.day}/${end.month}';
    return '$startStr - $endStr';
  }

  void _showFestivalInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Festival Challenges'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🎉 How it works:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('1. Join active festival challenges'),
              Text('2. Complete daily goals (steps, workouts, etc.)'),
              Text('3. Earn points and climb the leaderboard'),
              Text('4. Win exciting rewards!'),
              SizedBox(height: 16),
              Text(
                '🏆 Rewards:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Top 3: Special badge + bonus XP'),
              Text('• Top 10: Exclusive avatar frame'),
              Text('• All participants: Festival sticker'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}

/// Festival Card
class _FestivalCard extends StatelessWidget {
  final FestivalInfo festival;
  final VoidCallback onTap;

  const _FestivalCard({required this.festival, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 160,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getFestivalIcon(festival.name),
                    color: festival.isActive ? Colors.orange : Colors.grey,
                  ),
                  const Spacer(),
                  if (festival.isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'LIVE',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                festival.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(festival.startDate),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getFestivalIcon(String name) {
    if (name.toLowerCase().contains('navratri')) return Icons.fitness_center;
    if (name.toLowerCase().contains('diwali')) return Icons.lightbulb;
    if (name.toLowerCase().contains('holi')) return Icons.palette;
    if (name.toLowerCase().contains('independence')) return Icons.flag;
    if (name.toLowerCase().contains('new year')) return Icons.celebration;
    return Icons.emoji_events;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

/// Festival Leaderboard List
class _FestivalLeaderboardList extends ConsumerWidget {
  final FestivalInfo festival;
  final String currentUserId;

  const _FestivalLeaderboardList({
    required this.festival,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(
      festivalLeaderboardProvider(festival.id),
    );

    return leaderboardAsync.when(
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.leaderboard_outlined, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No participants yet'),
                SizedBox(height: 8),
                Text('Be the first to join this challenge!'),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return _LeaderboardTile(
              entry: entry,
              rank: index + 1,
              isCurrentUser: entry.oderId == currentUserId,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

/// Leaderboard Tile
class _LeaderboardTile extends StatelessWidget {
  final FestivalLeaderboardEntry entry;
  final int rank;
  final bool isCurrentUser;

  const _LeaderboardTile({
    required this.entry,
    required this.rank,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrentUser ? AppColors.primary.withValues(alpha: 0.1) : null,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getRankColor(rank),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: rank <= 3
                ? Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                    size: rank == 1 ? 24 : 20,
                  )
                : Text(
                    '$rank',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        title: Row(
          children: [
            Text(
              entry.userName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            if (entry.isVerified) ...[
              const SizedBox(width: 4),
              Icon(Icons.verified, size: 16, color: Colors.blue[400]),
            ],
          ],
        ),
        subtitle: isCurrentUser
            ? const Text('You', style: TextStyle(color: AppColors.primary))
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.score}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              _getScoreUnit(),
              style: TextStyle(color: Colors.grey[600], fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey[400]!;
      case 3:
        return Colors.brown[400]!;
      default:
        return Colors.grey;
    }
  }

  String _getScoreUnit() {
    if (entry.score == 1) return 'point';
    return 'points';
  }
}
