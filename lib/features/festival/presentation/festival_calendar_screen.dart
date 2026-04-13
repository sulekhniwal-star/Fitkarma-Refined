import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/app_database.dart';
import 'festival_providers.dart';
import 'festival_filter_provider.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/bilingual_label.dart';

class FestivalCalendarScreen extends ConsumerWidget {
  const FestivalCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festival Calendar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ActiveFestivalBanner(),
            const SizedBox(height: 16),
            const RegionFilterRow(),
            const SizedBox(height: 16),
            const UpcomingFestivalsList(),
            const SizedBox(height: 24),
            const MiniTableCalendar(),
            const SizedBox(height: 24),
            const WeddingSetupCTA(),
          ],
        ),
      ),
    );
  }
}

class ActiveFestivalBanner extends ConsumerWidget {
  const ActiveFestivalBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAsync = ref.watch(activeFestivalsProvider);

    return AsyncValueWidget<List<FestivalCalendarEntry>>(
  value: activeAsync as AsyncValue<List<FestivalCalendarEntry>>,
      data: (festivals) {
        if (festivals.isEmpty) return const SizedBox.shrink();

        final festival = festivals.first;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.orangeAccent],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   const Icon(Icons.celebration, color: Colors.white),
                   const SizedBox(width: 8),
                   Expanded(
                     child: Text(
                       '${festival.nameEn} is Active!',
                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                     ),
                   ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                festival.insightMessage,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => context.push('/festival-calendar/${festival.festivalKey}/diet'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.orange),
                child: const Text('View Diet Plan'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RegionFilterRow extends ConsumerWidget {
  const RegionFilterRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(festivalRegionFilterProvider);
    final regions = ['All', 'Hindu', 'Muslim', 'Sikh', 'Christian', 'Jain', 'Buddhist', 'National'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: regions.map((region) {
          final isSelected = currentFilter == region;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(region),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) ref.read(festivalRegionFilterProvider.notifier).setFilter(region);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class UpcomingFestivalsList extends ConsumerWidget {
  const UpcomingFestivalsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingAsync = ref.watch(upcomingFestivalsProvider);

    return AsyncValueWidget<List<FestivalCalendarEntry>>(
  value: upcomingAsync as AsyncValue<List<FestivalCalendarEntry>>,
      data: (festivals) {
        if (festivals.isEmpty) return const Text('No upcoming festivals found.');

        return Column(
          children: festivals.map((f) => FestivalCard(festival: f)).toList(),
        );
      },
    );
  }
}

class FestivalCard extends StatelessWidget {
  final FestivalCalendarEntry festival;
  const FestivalCard({super.key, required this.festival});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.event, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BilingualLabel(english: festival.nameEn, hindi: festival.nameHi),
                      Text(
                        '${festival.startDate.day} ${_getMonth(festival.startDate.month)} - ${festival.endDate.day} ${_getMonth(festival.endDate.month)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (festival.fastingType != null && festival.fastingType!.isNotEmpty)
                  _TagChip(label: festival.fastingType!, color: Colors.green),
                const SizedBox(width: 8),
                _TagChip(label: festival.religion.toUpperCase(), color: Colors.blue),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Set Reminder'),
                ),
                ElevatedButton(
                  onPressed: () => context.push('/festival-calendar/${festival.festivalKey}/diet'),
                  child: const Text('View Diet Plan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getMonth(int m) {
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
  }
}

class _TagChip extends StatelessWidget {
  final String label;
  final Color color;
  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MiniTableCalendar extends StatelessWidget {
  const MiniTableCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2024, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: DateTime.now(),
        calendarFormat: CalendarFormat.month,
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        calendarStyle: const CalendarStyle(
          todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class WeddingSetupCTA extends StatelessWidget {
  const WeddingSetupCTA({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/wedding-planner/setup'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.amber.shade700,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Plan a Wedding 💍',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Get tailored diet & fitness plans for the big day.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
