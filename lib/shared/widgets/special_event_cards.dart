import 'package:flutter/material.dart';
import 'glass_card.dart';

class FestivalCard extends StatelessWidget {
  final String englishName;
  final String hindiName;
  final String fastingType;
  final String region;
  final VoidCallback? onTap;

  const FestivalCard({
    super.key,
    required this.englishName,
    required this.hindiName,
    required this.fastingType,
    required this.region,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Color(0xFFF97316), width: 6),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        englishName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        hindiName,
                        style: const TextStyle(fontFamily: 'Devanagari', fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      fastingType,
                      style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(region, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const Spacer(),
                  const Text(
                    'VIEW DIET',
                    style: TextStyle(color: Color(0xFFF97316), fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.chevron_right, size: 16, color: Color(0xFFF97316)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeddingCountdownCard extends StatelessWidget {
  final int daysRemaining;
  final String nextEvent;

  const WeddingCountdownCard({
    super.key,
    required this.daysRemaining,
    required this.nextEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade400, Colors.amber.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'WEDDING COUNTDOWN',
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                Text(
                  '$daysRemaining DAYS TO GO',
                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'NEXT: $nextEvent',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.celebration, color: Colors.white, size: 48),
        ],
      ),
    );
  }
}
