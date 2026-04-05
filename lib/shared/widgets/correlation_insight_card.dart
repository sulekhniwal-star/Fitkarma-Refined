import 'package:flutter/material.dart';

class CorrelationInsightCard extends StatelessWidget {
  final String title;
  final String description;
  final List<ModulePill> moduleLinks;
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;
  final bool isPositive;

  const CorrelationInsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.moduleLinks,
    this.onPositive,
    this.onNegative,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isPositive
          ? Colors.green.shade50
          : Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isPositive ? Icons.trending_up : Icons.warning_amber,
                  color: isPositive ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: moduleLinks.map((pill) {
                return ActionChip(
                  avatar: Icon(pill.icon, size: 16),
                  label: Text(pill.label),
                  onPressed: pill.onTap,
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onNegative,
                  icon: const Icon(Icons.thumb_down_outlined),
                  tooltip: 'Not helpful',
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: onPositive,
                  icon: const Icon(Icons.thumb_up_outlined),
                  tooltip: 'Helpful',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModulePill {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const ModulePill({
    required this.label,
    required this.icon,
    this.onTap,
  });
}