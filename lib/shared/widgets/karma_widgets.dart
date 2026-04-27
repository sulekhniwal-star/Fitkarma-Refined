import 'package:flutter/material.dart';
import 'glass_card.dart';

class KarmaLevelCard extends StatelessWidget {
  final int level;
  final String rank;
  final int currentXp;
  final int nextLevelXp;

  const KarmaLevelCard({
    super.key,
    required this.level,
    required this.rank,
    required this.currentXp,
    required this.nextLevelXp,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentXp / nextLevelXp;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), Color(0xFF1E1B4B)], // heroDeep colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF312E81).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
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
                    'LEVEL $level',
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    rank.toUpperCase(),
                    style: const TextStyle(color: Color(0xFFF97316), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                ],
              ),
              const Icon(Icons.shield, color: Color(0xFFF97316), size: 48),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$currentXp XP', style: const TextStyle(color: Colors.white, fontSize: 12)),
              Text('$nextLevelXp XP', style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF97316)),
            ),
          ),
        ],
      ),
    );
  }
}

class CorrelationInsightCard extends StatelessWidget {
  final String message;
  final List<IconData> icons;

  const CorrelationInsightCard({
    super.key,
    required this.message,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      showGlow: true,
      glowColor: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              for (var icon in icons) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.blue, size: 16),
                ),
                if (icon != icons.last) const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.link, color: Colors.grey, size: 12),
                ),
              ],
              const Spacer(),
              const Text(
                'CORRELATION',
                style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.4),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Was this helpful?', style: TextStyle(fontSize: 12, color: Colors.grey)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up_outlined, size: 18)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_down_outlined, size: 18)),
            ],
          ),
        ],
      ),
    );
  }
}
