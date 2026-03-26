// lib/features/meditation/presentation/meditation_screen.dart
// Main meditation hub screen with Pranayama and guided sessions

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/meditation/data/meditation_providers.dart';
import 'package:fitkarma/features/meditation/data/pranayama_models.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class MeditationScreen extends ConsumerWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pranyamas = ref.watch(pranyamasProvider);
    final sessions = ref.watch(guidedSessionsProvider);
    final stats = ref.watch(userMeditationStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation Hub'),
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats card
            _buildStatsCard(context, stats),

            const SizedBox(height: 24),

            // Quick breathing exercise
            Text(
              '🧘 Quick Breathing',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              '3-minute stress relief',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () =>
                  context.push('/meditation/breathing/relaxing_breath'),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.purple.shade400],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Text('🌬️', style: TextStyle(fontSize: 32)),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '4-7-8 Relaxing Breath',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Calm anxiety in 3 minutes',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Pranayama library
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pranayama Library',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _showAllPranyamas(context, pranyamas),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pranyamas.length,
                itemBuilder: (context, index) {
                  final p = pranyamas[index];
                  return _buildPranyamaCard(context, p);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Guided sessions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Guided Sessions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => _showAllSessions(context, sessions),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Duration filters
            _buildDurationFilters(context, ref),

            const SizedBox(height: 16),

            // Sessions list
            ...sessions.take(4).map((s) => _buildSessionCard(context, s)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, MeditationSessionStats stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Today', '${stats.totalSessionsToday}', '🧘'),
          _buildStatItem('Streak', '${stats.currentStreak}', '🔥'),
          _buildStatItem('Best', '${stats.longestStreak}', '🏆'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPranyamaCard(BuildContext context, Pranayama p) {
    return GestureDetector(
      onTap: () => context.push('/meditation/breathing/${p.id}'),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.iconEmoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 8),
            Text(
              p.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${p.cycleDuration}s cycle',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationFilters(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _buildFilterChip('5 min', 5),
        _buildFilterChip('10 min', 10),
        _buildFilterChip('15 min', 15),
        _buildFilterChip('20 min', 20),
      ],
    );
  }

  Widget _buildFilterChip(String label, int minutes) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: false,
        onSelected: (_) {},
        backgroundColor: AppColors.surfaceVariant,
        labelStyle: const TextStyle(fontSize: 12),
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildSessionCard(BuildContext context, GuidedSession s) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(s.iconEmoji, style: const TextStyle(fontSize: 24)),
          ),
        ),
        title: Text(
          s.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${s.durationMinutes} min • ${s.category}'),
        trailing: const Icon(Icons.play_circle_outline),
        onTap: () {
          // Would play audio here with just_audio
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Playing: ${s.title} (Audio demo)')),
          );
        },
      ),
    );
  }

  void _showAllPranyamas(BuildContext context, List<Pranayama> pranyamas) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'All Pranayama',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: pranyamas.length,
                itemBuilder: (context, index) {
                  final p = pranyamas[index];
                  return ListTile(
                    leading: Text(
                      p.iconEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(p.name),
                    subtitle: Text(
                      p.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/meditation/breathing/${p.id}');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAllSessions(BuildContext context, List<GuidedSession> sessions) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All sessions would be shown here')),
    );
  }
}
