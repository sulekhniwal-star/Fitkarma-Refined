import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/app_database.dart';
import 'festival_providers.dart';
import 'festival_filter_provider.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/festival_card.dart' as shared;
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

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

class FestivalCountdownBanner extends ConsumerWidget {
  const FestivalCountdownBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeAsync = ref.watch(activeFestivalsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AsyncValueWidget<List<FestivalCalendarEntry>>(
      value: activeAsync as AsyncValue<List<FestivalCalendarEntry>>,
      data: (festivals) {
        if (festivals.isEmpty) return const SizedBox.shrink();

        final festival = festivals.first;
        
        Color bannerColor;
        switch (festival.religion.toLowerCase()) {
          case 'hindu':
            bannerColor = const Color(0xFFFF9933); // Saffron
            break;
          case 'muslim':
            bannerColor = const Color(0xFF006400); // Green
            break;
          case 'sikh':
            bannerColor = const Color(0xFF000080); // Deep Blue
            break;
          case 'christian':
            bannerColor = const Color(0xFF800000); // Maroon
            break;
          default:
            bannerColor = AppColors.primary;
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [bannerColor, bannerColor.withValues(alpha: 0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: bannerColor.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                                '${festival.nameEn} — Day 5 of 9', // Example day counter
                                style: AppTextStyles.h2(true).copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          festival.nameHi,
                          style: AppTextStyles.sectionHeaderHindi(true).copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Fasting mode active · Phalahar diet plan enabled',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.push('/festival-calendar/${festival.festivalKey}/diet'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: bannerColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View Diet Plan'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Garba Tracker 💃'), // Or relevant special action
                    ),
                  ),
                ],
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
          children: festivals.map((f) => shared.FestivalCard(
            title: f.nameEn,
            titleHi: f.nameHi,
            dateRange: '${f.startDate.day} ${_getMonth(f.startDate.month)} - ${f.endDate.day} ${_getMonth(f.endDate.month)}',
            fastingType: f.fastingType ?? 'None',
            region: f.religion.toUpperCase(),
            icon: festivalEmojis[f.festivalKey] ?? '✨',
            onSetReminder: () {},
            onViewDietPlan: () => context.push('/festival-calendar/${f.festivalKey}/diet'),
          )).toList(),
        );
      },
    );
  }

  String _getMonth(int m) {
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][m - 1];
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
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppColors.amberGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text('💍', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planning for a Wedding?',
                    style: AppTextStyles.h2(false).copyWith(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get a personalised diet & fitness plan tailored to your role.',
                    style: AppTextStyles.bodyMedium(false).copyWith(color: AppColors.textPrimary.withValues(alpha: 0.8)),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Start Wedding Planner →',
                      style: AppTextStyles.labelLarge(false).copyWith(color: AppColors.accentDark),
                    ),
                  ),
                ],
              ),
            ),
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

