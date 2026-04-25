import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_router/go_router.dart';
import '../../../core/storage/app_database.dart';
import 'festival_providers.dart';
import 'festival_filter_provider.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/glass_card.dart';

class FestivalCalendarScreen extends ConsumerWidget {
  const FestivalCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: AppTheme.bg0,
      appBar: AppBar(
        title: Text('Festival Calendar', style: AppTheme.h1(context)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark 
            ? const LinearGradient(
                colors: [AppTheme.bg0, AppTheme.bg1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- BENTO ROW 1: Hero Banner ---
              const FestivalHeaderBanner(),
              const SizedBox(height: 16),
              
              // --- BENTO ROW 2: Filters & Quick Actions ---
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: const RegionFilterRow(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- BENTO ROW 3: Upcoming Festivals (Main Content) ---
              Text('Upcoming Festivals', style: AppTheme.h2(context)),
              const SizedBox(height: 12),
              const UpcomingFestivalsList(),
              const SizedBox(height: 24),

              // --- BENTO ROW 4: Calendar & Stats ---
              const MiniTableCalendar(),
              const SizedBox(height: 24),

              // --- BENTO ROW 5: Wedding Planner CTA ---
              const WeddingSetupCTA(),
            ],
          ),
        ),
      ),
    );
  }
}

class FestivalHeaderBanner extends ConsumerWidget {
  const FestivalHeaderBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final festivalsAsync = ref.watch(activeFestivalsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AsyncValueWidget<List<FestivalCalendarEntry>>(
      value: festivalsAsync,
      data: (festivals) {
        if (festivals.isEmpty) return const SizedBox.shrink();

        final festival = festivals.first;
        
        Color bannerColor;
        switch (festival.religion.toLowerCase()) {
          case 'hindu':
            bannerColor = const Color(0xFFFF9933);
            break;
          case 'muslim':
            bannerColor = const Color(0xFF006400);
            break;
          case 'sikh':
            bannerColor = const Color(0xFF000080);
            break;
          case 'christian':
            bannerColor = const Color(0xFF800000);
            break;
          default:
            bannerColor = AppTheme.primary;
        }

        return GlassCard(
          padding: EdgeInsets.zero,
          color: bannerColor.withValues(alpha: 0.15),
          borderColor: bannerColor.withValues(alpha: 0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      bannerColor.withValues(alpha: 0.6), 
                      bannerColor.withValues(alpha: 0.1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          festival.nameEn,
                                          style: AppTheme.h1(context).copyWith(color: Colors.white),
                                        ),
                                        Text(
                                          'Day 5 of 9 · Fasting Mode',
                                          style: AppTheme.monoSm(context).copyWith(
                                            color: Colors.white.withValues(alpha: 0.7),
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      festival.nameHi,
                      style: AppTheme.hindi(context).copyWith(
                        fontSize: 18,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Phalahar diet plan is currently active for you.',
                      style: AppTheme.bodyMd(context),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.push('/festival/${festival.festivalKey}/diet'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bannerColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
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
                              foregroundColor: isDark ? Colors.white : bannerColor,
                              side: BorderSide(color: bannerColor.withValues(alpha: 0.5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Daily Rituals'),
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
      physics: const BouncingScrollPhysics(),
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
              backgroundColor: AppTheme.surface1,
              selectedColor: AppTheme.primary,
              labelStyle: TextStyle(
                color: isSelected 
                  ? Colors.white 
                  : (AppTheme.textSecondary),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      value: upcomingAsync,
      data: (festivals) {
        if (festivals.isEmpty) return const Text('No upcoming festivals found.');

        return Column(
          children: festivals.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              onTap: () => context.push('/festival/${f.festivalKey}/diet'),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (AppTheme.primary).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(festivalEmojis[f.festivalKey] ?? '✨', style: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(f.nameEn, style: AppTheme.h3(context)),
                        Text(
                          '${f.startDate.day} ${_getMonth(f.startDate.month)} · ${f.religion.toUpperCase()}',
                          style: AppTheme.bodyMd(context).copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
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
    final allFestivalsAsync = ref.watch(upcomingFestivalsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: AppTheme.accent),
                const SizedBox(width: 8),
                Text('Festival Calendar', style: AppTheme.h3(context)),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            headerVisible: true,
            headerStyle: HeaderStyle(
              formatButtonVisible: false, 
              titleCentered: true,
              titleTextStyle: AppTheme.h3(context),
              leftChevronIcon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
              rightChevronIcon: Icon(Icons.chevron_right, color: isDark ? Colors.white : Colors.black),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: (AppTheme.primary).withValues(alpha: 0.3), 
                shape: BoxShape.circle
              ),
              todayTextStyle: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
              markerDecoration: BoxDecoration(
                color: AppTheme.accent, 
                shape: BoxShape.circle
              ),
              outsideDaysVisible: false,
              defaultTextStyle: AppTheme.bodyMd(context),
              weekendTextStyle: AppTheme.bodyMd(context).copyWith(color: Colors.redAccent),
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
    return GlassCard(
      padding: EdgeInsets.zero,
      color: (AppTheme.accent).withValues(alpha: 0.1),
      borderColor: (AppTheme.accent).withValues(alpha: 0.2),
      onTap: () => context.push('/wedding-planner/setup'),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              (AppTheme.accent).withValues(alpha: 0.1),
              Colors.transparent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Text('💍', style: TextStyle(fontSize: 40)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wedding Coming Up?',
                    style: AppTheme.h2(context),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Get a custom diet & fitness plan for your special role.',
                    style: AppTheme.bodyMd(context),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.accent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Start Planner →',
                      style: AppTheme.labelLg(context).copyWith(color: Colors.black),
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


