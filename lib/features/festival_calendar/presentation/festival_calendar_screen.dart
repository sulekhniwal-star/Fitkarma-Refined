import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

final upcomingFestivalsProvider = StreamProvider((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.festivalCalendar).watch();
});

class FestivalCalendarScreen extends ConsumerWidget {
  const FestivalCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivalsAsync = ref.watch(upcomingFestivalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Wellness Calendar'),
        backgroundColor: Colors.deepOrange.shade100,
        foregroundColor: Colors.deepOrange.shade900,
      ),
      body: festivalsAsync.when(
        data: (festivals) {
          if (festivals.isEmpty) {
            return const Center(child: Text('No upcoming festivals found.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: festivals.length,
            itemBuilder: (context, index) {
              final f = festivals[index];
              return _FestivalCard(f: f);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _FestivalCard extends StatelessWidget {
  final FestivalCalendarEntry f;
  const _FestivalCard({required this.f});

  @override
  Widget build(BuildContext context) {
    final bool isToday = DateTime.now().isAfter(f.startDate) && DateTime.now().isBefore(f.endDate);
    final color = _getFestivalColor(f.dietPlanType);

    return Card(
      elevation: isToday ? 8 : 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isToday ? BorderSide(color: color, width: 2) : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.nameEn, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(f.nameHi!, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                    ],
                  ),
                ),
                if (isToday)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
                    child: const Text('TODAY', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  )
                else
                  Text('${f.startDate.day} ${_getMonthName(f.startDate.month)}', style: TextStyle(color: color, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (f.isFastingDay == true)
                  _TagLine(icon: Icons.timer, text: 'Fasting: ${f.fastingType ?? 'Required'}', color: Colors.orange),
                if (f.dietPlanType == 'feast')
                  _TagLine(icon: Icons.restaurant, text: 'Feast Day — Plan for indulgence!', color: Colors.purple),
                if (f.dietPlanType == 'sattvic')
                   _TagLine(icon: Icons.eco, text: 'Sattvic Diet Recommended', color: Colors.green),
                
                if (f.insightMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline, size: 20, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(child: Text(f.insightMessage!, style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Set Reminder'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
                        child: const Text('View Diet Plan'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getFestivalColor(String type) {
    switch (type) {
      case 'fasting': return Colors.orange.shade700;
      case 'feast': return Colors.purple.shade700;
      case 'sattvic': return Colors.green.shade700;
      default: return Colors.blueGrey;
    }
  }

  String _getMonthName(int month) {
    const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return names[month - 1];
  }
}

class _TagLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const _TagLine({required this.icon, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }
}
