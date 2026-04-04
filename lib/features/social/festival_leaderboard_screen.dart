import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'data/social_notifier.dart';

class FestivalLeaderboardScreen extends ConsumerStatefulWidget {
  const FestivalLeaderboardScreen({super.key});

  @override
  ConsumerState<FestivalLeaderboardScreen> createState() =>
      _FestivalLeaderboardScreenState();
}

class _FestivalLeaderboardScreenState
    extends ConsumerState<FestivalLeaderboardScreen> {
  int _selectedChallengeIndex = 0;

  List<Color> _festivalColors(String festival) => switch (festival.toLowerCase()) {
    'navratri' => [const Color(0xFFB71C1C), const Color(0xFF880E4F)],
    'diwali' => [const Color(0xFFE65100), const Color(0xFFF57F17)],
    'holi' => [const Color(0xFF880E4F), const Color(0xFF1565C0)],
    _ => [const Color(0xFF4A148C), const Color(0xFF1A237E)],
  };

  String _formatDate(DateTime dt) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  String _formatValue(int value, String metricType) => switch (metricType) {
    'steps' => '${(value / 1000).toStringAsFixed(0)}k steps',
    'calories_burned' => '${value} cal',
    'wellness_score' => '$value / 9 days',
    _ => '$value',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final challenges = ref.watch(festivalChallengesProvider);
    final selected = challenges[_selectedChallengeIndex];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context, selected),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(selected.festivalEmoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  const Text(
                    'Seasonal Leaderboard',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildChallengeSelector(context, isDark, challenges),
          ),
          SliverToBoxAdapter(
            child: _buildStatsRow(context, isDark, selected),
          ),
          if (selected.leaderboard.isEmpty)
            SliverFillRemaining(
              child: _buildUpcoming(context, selected),
            )
          else ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Top Participants',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _LeaderboardEntryCard(
                    entry: selected.leaderboard[i],
                    metricType: selected.metricType,
                    targetValue: selected.targetValue,
                  ),
                  childCount: selected.leaderboard.length,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FestivalChallengeUi challenge) {
    final colors = _festivalColors(challenge.festivalName);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(challenge.festivalEmoji, style: const TextStyle(fontSize: 44)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (challenge.isAutoCreated)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('🤖 Auto-created from Festival Calendar', style: TextStyle(color: Colors.white, fontSize: 11)),
                          ),
                        const SizedBox(height: 6),
                        Text(
                          challenge.title,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeSelector(BuildContext context, bool isDark, List<FestivalChallengeUi> challenges) {
    return Container(
      color: isDark ? AppColors.darkSurface : Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: challenges.asMap().entries.map((e) {
            final i = e.key;
            final ch = e.value;
            final isSelected = i == _selectedChallengeIndex;
            return GestureDetector(
              onTap: () => setState(() => _selectedChallengeIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.heroGradientLight : null,
                  color: isSelected ? null : (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected ? null : Border.all(color: isDark ? AppColors.darkOutline : AppColors.lightOutline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(ch.festivalEmoji, style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 6),
                        Text(
                          ch.festivalName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : null,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          width: 6, height: 6,
                          decoration: BoxDecoration(
                            color: ch.isActive ? (isSelected ? Colors.white : Colors.green) : (isSelected ? Colors.white60 : Colors.grey),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          ch.isActive ? 'Active' : 'Upcoming',
                          style: TextStyle(fontSize: 11, color: isSelected ? Colors.white70 : Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, bool isDark, FestivalChallengeUi ch) {
    final daysLeft = ch.endDate.difference(DateTime.now()).inDays;
    final myEntry = ch.leaderboard.where((e) => e.isMe).firstOrNull;
    final progress = myEntry != null ? (myEntry.value / ch.targetValue).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(ch.description, style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: 'Days Left',
                  value: ch.isActive ? (daysLeft > 0 ? '$daysLeft' : 'Ended') : 'Upcoming',
                  icon: Icons.timer_outlined,
                  color: daysLeft < 3 ? AppColors.error : AppColors.primary,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Participants',
                  value: '${ch.leaderboard.length}+',
                  icon: Icons.people_outline,
                  color: AppColors.secondary,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: 'Your Rank',
                  value: myEntry != null ? '#${myEntry.rank}' : '-',
                  icon: Icons.emoji_events_outlined,
                  color: AppColors.karmaGold,
                  isDark: isDark,
                ),
              ),
            ],
          ),
          if (myEntry != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Your Progress', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primary)),
                      const Spacer(),
                      Text(
                        '${_formatValue(myEntry.value, ch.metricType)} / ${_formatValue(ch.targetValue, ch.metricType)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('${(progress * 100).toStringAsFixed(0)}% complete', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUpcoming(BuildContext context, FestivalChallengeUi ch) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ch.festivalEmoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text('${ch.festivalName} Challenge', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Starts ${_formatDate(ch.startDate)}', style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.notifications_outlined),
              label: const Text('Remind Me'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _StatCard({required this.label, required this.value, required this.icon, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
          Text(label, style: TextStyle(color: Colors.grey.shade500, fontSize: 11), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _LeaderboardEntryCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final String metricType;
  final int targetValue;

  const _LeaderboardEntryCard({required this.entry, required this.metricType, required this.targetValue});

  String _formatValue(int value, String metricType) => switch (metricType) {
    'steps' => '${(value / 1000).toStringAsFixed(1)}k',
    'calories_burned' => '${value}kcal',
    'wellness_score' => '${value}d',
    _ => '$value',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = (entry.value / targetValue).clamp(0.0, 1.0);
    final rankColor = entry.rank == 1
        ? const Color(0xFFFFD700)
        : entry.rank == 2
            ? Colors.grey.shade400
            : entry.rank == 3
                ? Colors.brown.shade300
                : null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: entry.isMe ? AppColors.primary.withOpacity(0.08) : (isDark ? AppColors.darkSurface : Colors.white),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: entry.isMe ? AppColors.primary.withOpacity(0.4) : (isDark ? AppColors.darkOutline : AppColors.lightOutline),
          width: entry.isMe ? 1.5 : 1,
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: rankColor?.withOpacity(0.15) ?? Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: entry.rank <= 3
                  ? Icon(Icons.emoji_events, size: 20, color: rankColor)
                  : Text('#${entry.rank}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Text(entry.avatarInitial, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ),
              if (entry.isVerified)
                Positioned(
                  bottom: 0, right: 0,
                  child: Container(
                    width: 14, height: 14,
                    decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                    child: const Icon(Icons.verified, size: 9, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.username,
                      style: TextStyle(fontWeight: entry.isMe ? FontWeight.bold : FontWeight.w600, fontSize: 14),
                    ),
                    if (entry.isMe) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(6)),
                        child: const Text('You', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    entry.rank == 1 ? const Color(0xFFFFD700) : AppColors.primary,
                  ),
                  minHeight: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            _formatValue(entry.value, metricType),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: entry.rank == 1 ? const Color(0xFFE65100) : null,
            ),
          ),
        ],
      ),
    );
  }
}