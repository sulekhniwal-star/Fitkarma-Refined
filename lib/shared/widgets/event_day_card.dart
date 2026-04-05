import 'package:flutter/material.dart';

class EventDayCard extends StatelessWidget {
  final String eventName;
  final DateTime date;
  final String? mealSummary;
  final int? energyDemand;
  final VoidCallback? onTap;

  const EventDayCard({
    super.key,
    required this.eventName,
    required this.date,
    this.mealSummary,
    this.energyDemand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (mealSummary != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        mealSummary!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (energyDemand != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getEnergyColor(energyDemand!).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _getEnergyColor(energyDemand!).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        size: 14,
                        color: _getEnergyColor(energyDemand!),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getEnergyLabel(energyDemand!),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getEnergyColor(energyDemand!),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getEnergyColor(int demand) {
    if (demand <= 2) return Colors.green;
    if (demand <= 4) return Colors.orange;
    return Colors.red;
  }

  String _getEnergyLabel(int demand) {
    if (demand <= 2) return 'Low';
    if (demand <= 4) return 'Medium';
    return 'High';
  }
}