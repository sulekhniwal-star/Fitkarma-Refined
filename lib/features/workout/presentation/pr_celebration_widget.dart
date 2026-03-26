// lib/features/workout/presentation/pr_celebration_widget.dart
// Widget to display PR celebration notification

import 'package:flutter/material.dart';
import 'package:fitkarma/features/workout/data/pr_detection_service.dart';

/// Widget to display PR celebration dialog
class PRCelebrationDialog extends StatelessWidget {
  final DetectedPR pr;
  final VoidCallback? onDismiss;
  final VoidCallback? onViewHistory;

  const PRCelebrationDialog({
    super.key,
    required this.pr,
    this.onDismiss,
    this.onViewHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trophy icon with animation
            _buildTrophy(),
            const SizedBox(height: 16),

            // Title
            Text(
              '🎉 NEW PR! 🎉',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
            const SizedBox(height: 8),

            // PR type
            Text(
              pr.typeLabel,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),

            // PR value
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade100, Colors.orange.shade100],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    pr.exerciseName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pr.formattedValue,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
            ),

            // Improvement indicator
            if (pr.previousBest != null) ...[
              const SizedBox(height: 12),
              _buildImprovementIndicator(),
            ],

            // XP reward
            const SizedBox(height: 16),
            _buildXPReward(),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                if (onViewHistory != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onViewHistory,
                      child: const Text('View History'),
                    ),
                  ),
                if (onViewHistory != null) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDismiss,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Awesome!'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrophy() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.amber.shade300, Colors.amber.shade600],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(Icons.emoji_events, size: 48, color: Colors.white),
    );
  }

  Widget _buildImprovementIndicator() {
    final improvementPercent = pr.previousBest != null && pr.previousBest! > 0
        ? (pr.improvement / pr.previousBest! * 100).toStringAsFixed(1)
        : '0';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 8),
          Text(
            '+$improvementPercent% improvement',
            style: TextStyle(
              color: Colors.green.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPReward() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade100, Colors.deepPurple.shade100],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.purple, size: 24),
          const SizedBox(width: 8),
          Text(
            '+${PRDetectionService.prXpReward} XP',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ],
      ),
    );
  }
}

/// Show PR celebration dialog
Future<void> showPRCelebration(
  BuildContext context,
  DetectedPR pr, {
  VoidCallback? onViewHistory,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PRCelebrationDialog(
      pr: pr,
      onDismiss: () => Navigator.of(context).pop(),
      onViewHistory: onViewHistory != null
          ? () {
              Navigator.of(context).pop();
              onViewHistory();
            }
          : null,
    ),
  );
}

/// Show multiple PRs celebration dialog
Future<void> showMultiplePRCelebration(
  BuildContext context,
  List<DetectedPR> prs, {
  VoidCallback? onViewHistory,
}) async {
  final totalXP = prs.length * PRDetectionService.prXpReward;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Trophy icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.amber.shade300, Colors.amber.shade600],
                ),
              ),
              child: const Icon(
                Icons.emoji_events,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              '🎉 ${prs.length} NEW PRs! 🎉',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
            const SizedBox(height: 16),

            // PRs list
            ...prs.map(
              (pr) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  pr.celebrationMessage,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Total XP reward
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.deepPurple.shade100],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.purple, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '+$totalXP XP',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                if (onViewHistory != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onViewHistory,
                      child: const Text('View History'),
                    ),
                  ),
                if (onViewHistory != null) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Awesome!'),
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
