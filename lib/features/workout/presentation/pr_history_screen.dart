// lib/features/workout/presentation/pr_history_screen.dart
// Screen to display personal records history

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fitkarma/features/workout/data/pr_providers.dart';

class PRHistoryScreen extends ConsumerWidget {
  final String userId;

  const PRHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prsAsync = ref.watch(personalRecordsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () => _showAllTimeBest(context, prsAsync),
          ),
        ],
      ),
      body: prsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (prs) => _buildContent(context, prs),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<Map<String, dynamic>> prs) {
    if (prs.isEmpty) {
      return _buildEmptyState();
    }

    // Group PRs by type
    final Map<String, List<Map<String, dynamic>>> groupedPRs = {};
    for (final pr in prs) {
      final type = pr['recordType'] as String? ?? 'unknown';
      groupedPRs.putIfAbsent(type, () => []).add(pr);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header stats
        _buildHeaderStats(prs),
        const SizedBox(height: 24),

        // Grouped PRs
        ...groupedPRs.entries.map((entry) => _buildPRGroup(context, entry.key, entry.value)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Personal Records Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete workouts to set your first PR!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStats(List<Map<String, dynamic>> prs) {
    // Count by type
    int maxLifts = 0;
    int fastest5k = 0;
    int longestRun = 0;

    for (final pr in prs) {
      final type = pr['recordType'] as String? ?? '';
      if (type.startsWith('max_lift')) maxLifts++;
      if (type == 'fastest_5k') fastest5k++;
      if (type == 'longest_run') longestRun++;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber.shade700),
                const SizedBox(width: 8),
                const Text(
                  'Your PR Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.fitness_center,
                    count: maxLifts,
                    label: 'Max Lifts',
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.directions_run,
                    count: fastest5k,
                    label: '5K Times',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.route,
                    count: longestRun,
                    label: 'Longest Runs',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required int count,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPRGroup(BuildContext context, String type, List<Map<String, dynamic>> prs) {
    // Sort by date descending
    prs.sort((a, b) {
      final dateA = DateTime.tryParse(a['achievedAt'] ?? '') ?? DateTime(2000);
      final dateB = DateTime.tryParse(b['achievedAt'] ?? '') ?? DateTime(2000);
      return dateB.compareTo(dateA);
    });

    final latestPR = prs.first;
    final exerciseName = latestPR['exerciseName'] as String? ?? 'Exercise';
    final value = (latestPR['value'] as num?)?.toDouble() ?? 0;
    final unit = latestPR['unit'] as String? ?? '';
    final achievedAt = DateTime.tryParse(latestPR['achievedAt'] ?? '') ?? DateTime.now();

    // Determine the type for display
    String title;
    IconData icon;
    Color color;
    bool isTimeBased = false;

    if (type.startsWith('max_lift')) {
      title = 'Max Lift: $exerciseName';
      icon = Icons.fitness_center;
      color = Colors.blue;
    } else if (type == 'fastest_5k') {
      title = 'Fastest 5K';
      icon = Icons.directions_run;
      color = Colors.green;
      isTimeBased = true;
    } else if (type == 'longest_run') {
      title = 'Longest Run';
      icon = Icons.route;
      color = Colors.orange;
    } else {
      title = type;
      icon = Icons.emoji_events;
      color = Colors.amber;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showPRDetails(context, type, exerciseName),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.1),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatValue(value, unit, isTimeBased),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('MMM d').format(achievedAt),
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (prs.length > 1)
                    Text(
                      '${prs.length} total',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatValue(double value, String unit, bool isTimeBased) {
    if (isTimeBased) {
      final minutes = value ~/ 60;
      final seconds = (value % 60).round();
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
    return '${value.toStringAsFixed(1)} $unit';
  }

  void _showPRDetails(BuildContext context, String type, String exerciseName) {
    // Could navigate to a detailed PR view with chart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing $exerciseName PR history'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAllTimeBest(BuildContext context, AsyncValue<List<Map<String, dynamic>>> prsAsync) {
    prsAsync.whenData((prs) {
      if (prs.isEmpty) return;

      // Find the most recent PR
      prs.sort((a, b) {
        final dateA = DateTime.tryParse(a['achievedAt'] ?? '') ?? DateTime(2000);
        final dateB = DateTime.tryParse(b['achievedAt'] ?? '') ?? DateTime(2000);
        return dateB.compareTo(dateA);
      });

      final bestPR = prs.first;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.amber.shade700),
              const SizedBox(width: 8),
              const Text('All-Time Best'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bestPR['exerciseName'] ?? 'Exercise',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _formatValue(
                  (bestPR['value'] as num?)?.toDouble() ?? 0,
                  bestPR['unit'] as String? ?? '',
                  bestPR['recordType'] == 'fastest_5k',
                ),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Achieved on ${DateFormat('MMMM d, yyyy').format(DateTime.tryParse(bestPR['achievedAt'] ?? '') ?? DateTime.now())}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    });
  }
}
