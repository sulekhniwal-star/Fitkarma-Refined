import 'package:flutter/material.dart';
import 'festival_diet_badge.dart';

class FestivalCard extends StatelessWidget {
  final String nameEn;
  final String nameHi;
  final DateTime startDate;
  final DateTime endDate;
  final bool isFasting;
  final FastingType? fastingType;
  final String? region;
  final VoidCallback? onTap;
  final VoidCallback? onSetReminder;
  final VoidCallback? onViewDiet;

  const FestivalCard({
    super.key,
    required this.nameEn,
    required this.nameHi,
    required this.startDate,
    required this.endDate,
    this.isFasting = false,
    this.fastingType,
    this.region,
    this.onTap,
    this.onSetReminder,
    this.onViewDiet,
  });

  int get _daysUntil {
    return startDate.difference(DateTime.now()).inDays;
  }

  bool get _isActive {
    final now = DateTime.now();
    return now.isAfter(startDate.subtract(const Duration(days: 1))) &&
        now.isBefore(endDate.add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nameEn,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          nameHi,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (_isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else if (_daysUntil > 0 && _daysUntil <= 7)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$_daysUntil days',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${_formatDate(startDate)} - ${_formatDate(endDate)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (isFasting && fastingType != null)
                    FestivalDietBadge(type: fastingType!),
                  if (region != null)
                    Chip(
                      avatar: const Icon(Icons.location_on, size: 16),
                      label: Text(region!, style: const TextStyle(fontSize: 12)),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (onSetReminder != null)
                    TextButton.icon(
                      onPressed: onSetReminder,
                      icon: const Icon(Icons.alarm, size: 18),
                      label: const Text('Remind'),
                    ),
                  if (onViewDiet != null)
                    TextButton.icon(
                      onPressed: onViewDiet,
                      icon: const Icon(Icons.restaurant_menu, size: 18),
                      label: const Text('Diet Plan'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}