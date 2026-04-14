import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/app_database.dart';
import 'festival_providers.dart';
import 'festival_filter_provider.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/bilingual_label.dart';
import 'dart:async';

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
            const FestivalCountdownBanner(),
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

class FestivalCountdownBanner extends ConsumerStatefulWidget {
  const FestivalCountdownBanner({super.key});

  @override
  ConsumerState<FestivalCountdownBanner> createState() => _FestivalCountdownBannerState();
}

class _FestivalCountdownBannerState extends ConsumerState<FestivalCountdownBanner> {
  Timer? _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeAsync = ref.watch(activeFestivalsProvider);

    return AsyncValueWidget<List<FestivalCalendarEntry>>(
      value: activeAsync as AsyncValue<List<FestivalCalendarEntry>>,
      data: (festivals) {
        if (festivals.isEmpty) return const SizedBox.shrink();

        final festival = festivals.first;
        final timeRemaining = festival.endDate.difference(_now);
        
        final hours = timeRemaining.inHours;
        final minutes = timeRemaining.inMinutes.remainder(60);
        final seconds = timeRemaining.inSeconds.remainder(60);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).primaryColor, Colors.orangeAccent],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Text(
                     festivalEmojis[festival.festivalKey] ?? '✨',
                     style: const TextStyle(fontSize: 24),
                   ),
                   const SizedBox(width: 8),
                   Expanded(
                     child: Text(
                       '${festival.nameEn} is Active!',
                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                     ),
                   ),
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     decoration: BoxDecoration(
                       color: Colors.white24,
                       borderRadius: BorderRadius.circular(8),
                     ),
                     child: Text(
                       '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, 
                  foregroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    festivalEmojis[festival.festivalKey] ?? '✨',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BilingualLabel(
                        english: festival.nameEn, 
                        hindi: festival.nameHi,
                        englishStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${festival.startDate.day} ${_getMonth(festival.startDate.month)} - ${festival.endDate.day} ${_getMonth(festival.endDate.month)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
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
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, size: 18),
                    label: const Text('Remind Me'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.push('/festival-calendar/${festival.festivalKey}/diet'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Diet Plan'),
                  ),
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

class MiniTableCalendar extends ConsumerWidget {
  const MiniTableCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allFestivalsAsync = ref.watch(upcomingFestivalsProvider); // Using upcoming for now or create a better provider

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.orange),
                const SizedBox(width: 8),
                Text('Festival Calendar', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            headerVisible: true,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false, 
              titleCentered: true,
              titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              markerDecoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
              outsideDaysVisible: false,
            ),
            eventLoader: (day) {
              return allFestivalsAsync.when(
                data: (festivals) => festivals.where((f) => 
                  isSameDay(f.startDate, day) || 
                  (day.isAfter(f.startDate) && day.isBefore(f.endDate)) ||
                  isSameDay(f.endDate, day)
                ).toList(),
                loading: () => [],
                error: (_, _) => [],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
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
const Map<String, String> festivalEmojis = {
  'navratri': '🔱',
  'diwali': '🪔',
  'holi': '🎨',
  'karva_chauth': '🌙',
  'ramadan': '🌙',
  'eid_ul_fitr': '🌙',
  'eid_ul_adha': '🕋',
  'janmashtami': '🏺',
  'shivaratri': '🔱',
  'christmas': '🎄',
  'ganesh_chaturthi': '🐘',
  'raksha_bandhan': '🥨',
  'guru_nanak_jayanti': '🕯️',
  'onam': '🛶',
  'pongal': '🥣',
  'baisakhi': '🌾',
  'lohri': '🔥',
  'buddha_purnima': '☸️',
  'republic_day': '🇮🇳',
  'independence_day': '🇮🇳',
};
