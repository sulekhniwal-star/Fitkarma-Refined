import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fitkarma/features/ayurveda/domain/dosha_calculator.dart';
import 'package:fitkarma/features/ayurveda/domain/ayurveda_providers.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_data.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import 'package:fitkarma/shared/widgets/fit_scaffold.dart';

class AyurvedaHubScreen extends ConsumerStatefulWidget {
  const AyurvedaHubScreen({super.key});

  @override
  ConsumerState<AyurvedaHubScreen> createState() => _AyurvedaHubScreenState();
}

class _AyurvedaHubScreenState extends ConsumerState<AyurvedaHubScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const _AyurvedaHome(),
    const _DoshaProfile(),
    const _DailyRituals(),
    const _SeasonalPlan(),
    const _HerbalRemedies(),
  ];

  @override
  Widget build(BuildContext context) {
    return FitScaffold(
      pattern: ScaffoldPattern.standard,
      title: 'Ayurveda Hub',
      actions: [
        IconButton(
          icon: const Icon(Icons.info_outline, color: AppTheme.textSecondary),
          onPressed: () => _showDisclaimer(context),
        ),
      ],
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        child: GlassCard(
          borderRadius: 24,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppTheme.primary,
            unselectedItemColor: AppTheme.textMuted.withValues(alpha: 0.5),
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedLabelStyle: AppTheme.caption(context).copyWith(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: 'Dosha',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wb_sunny_outlined),
                label: 'Rituals',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Seasons',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.eco_outlined),
                label: 'Herbs',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.bg2,
        title: Text('Disclaimer', style: AppTheme.h3(context)),
        content: Text(
          'Information provided is for educational purposes based on traditional Ayurvedic principles. '
          'It is NOT medical advice. Always consult a qualified practitioner before starting any supplement or diet change.',
          style: AppTheme.bodyMd(context).copyWith(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Understood', style: TextStyle(color: AppTheme.primary)),
          ),
        ],
      ),
    );
  }
}

class _AyurvedaHome extends StatelessWidget {
  const _AyurvedaHome();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Discover Your Nature',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ayurveda is the science of life, balancing body, mind, and spirit.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          _buildHeroCard(context),
          const SizedBox(height: 24),
          const Text(
            'Core Principles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildPrincipleItem(
            'Vata: Air & Ether',
            'Governs motion and energy.',
          ),
          _buildPrincipleItem(
            'Pitta: Fire & Water',
            'Governs digestion and metabolism.',
          ),
          _buildPrincipleItem(
            'Kapha: Earth & Water',
            'Governs structure and lubrication.',
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/images/ayurveda/vata.png', width: 140),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.quiz_rounded,
                  size: 40,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Analyze your Prakriti',
                  style: AppTheme.h2(context).copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Identify your dominant Dosha and receive personalized lifestyle guidance.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/ayurveda/quiz'),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('START ASSESSMENT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrincipleItem(String title, String desc) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.auto_awesome, color: Colors.amber),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
    );
  }
}

class _DoshaProfile extends ConsumerWidget {
  const _DoshaProfile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final securityState = ref.watch(ayurvedaProvider);

    return securityState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (score) {
        if (score == null) {
          return _buildEmptyState(context);
        }

        final dominant = score.dominant;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 80),
              Card(
                elevation: 0,
                color: Colors.grey.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Primary Dosha: ${dominant.name.toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Your Agni (digestive fire) is naturally strong. Focus on cooling foods and avoiding excessive heat.',
                        textAlign: TextAlign.center,
                        style: TextStyle(height: 1.5),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildGuideline(
                            'Favor',
                            Icons.check_circle_outline,
                            Colors.green,
                          ),
                          _buildGuideline(
                            'Avoid',
                            Icons.cancel_outlined,
                            Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextButton.icon(
                onPressed: () => _confirmReset(context, ref),
                icon: const Icon(Icons.refresh_rounded, color: Colors.grey),
                label: const Text(
                  'RETAKE ASSESSMENT',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGuideline(String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Assessment?'),
        content: const Text(
          'This will clear your current profile and history. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              ref.read(ayurvedaProvider.notifier).resetAssessment();
              Navigator.pop(context);
            },
            child: const Text(
              'YES, RESET',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.spa_outlined,
            size: 80,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 24),
          Text('Dosha Analysis Pending', style: AppTheme.h3(context)),
          const SizedBox(height: 8),
          const Text(
            'Complete the Prakriti Quiz to see your profile.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.push('/ayurveda/quiz'),
            child: const Text('START QUIZ'),
          ),
        ],
      ),
    );
  }
}

class _DailyRituals extends ConsumerStatefulWidget {
  const _DailyRituals();

  @override
  ConsumerState<_DailyRituals> createState() => _DailyRitualsState();
}

class _DailyRitualsState extends ConsumerState<_DailyRituals> {
  DateTime _selectedDate = DateTime.now();
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    final ayurveda = ref.watch(ayurvedaProvider);
    final dominant = ayurveda.value?.dominant ?? Dosha.pitta;
    final rituals = AyurvedaData.dinacharya[dominant]!;
    final completedKeys =
        ref.watch(ritualHistoryProvider(_selectedDate)).value ?? [];

    return Column(
      children: [
        const SizedBox(height: 80),
        _buildCalendarHeader(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dinacharya', style: AppTheme.h2(context)),
                      Text(
                        '${dominant.name.toUpperCase()} Balance Guidelines',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  _buildAuspiciousStamp(completedKeys.length, rituals.length),
                ],
              ),
              const SizedBox(height: 24),
              ...rituals.map((ritual) {
                final isDone = completedKeys.contains(ritual['key']);
                final isToday = isSameDay(_selectedDate, DateTime.now());

                return Card(
                  color: isDone
                      ? AppTheme.primary.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.05),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isDone
                          ? AppTheme.primary.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: CheckboxListTile(
                    value: isDone,
                    onChanged: isToday && !isDone
                        ? (v) => _confirmRitual(context, ritual)
                        : null,
                    title: Text(
                      ritual['label'],
                      style: TextStyle(
                        color: isDone
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.7),
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    subtitle: isDone
                        ? Text(
                            'Auspiciously Completed',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 12,
                            ),
                          )
                        : Text(
                            'Karma Points: +${ritual['karma']}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                    activeColor: AppTheme.primary,
                    checkColor: Colors.black,
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              }),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 90)),
        lastDay: DateTime.now(),
        focusedDay: _selectedDate,
        calendarFormat: _calendarFormat,
        availableCalendarFormats: const {CalendarFormat.week: 'Week'},
        selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (selected, focused) {
          setState(() => _selectedDate = selected);
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(
            color: AppTheme.primary,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          defaultTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.white60),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
          rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAuspiciousStamp(int done, int total) {
    final percent = total > 0 ? (done / total) : 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: percent > 0.8
            ? Colors.amber.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: percent > 0.8 ? Colors.amber : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          Text(
            '$done/$total',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: percent > 0.8 ? Colors.amber : Colors.white,
            ),
          ),
          Text(
            'DONE',
            style: AppTheme.labelMd(context).copyWith(fontSize: 8),
          ),
        ],
      ),
    );
  }

  void _confirmRitual(BuildContext context, Map<String, dynamic> ritual) {
    HapticFeedback.mediumImpact();
    ref
        .read(ritualHistoryProvider(_selectedDate).notifier)
        .toggleRitual(ritual);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.amber),
            const SizedBox(width: 12),
            Text('Auspicious Action! +${ritual['karma']} Karma'),
          ],
        ),
        backgroundColor: Colors.teal.shade900,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _SeasonalPlan extends StatelessWidget {
  const _SeasonalPlan();

  String _getVedicSeason() {
    final month = DateTime.now().month;
    // Strict Indian Vedic Season (Ritu) mapping
    if (month == 3 || month == 4) return 'Vasanta (Spring)';
    if (month == 5 || month == 6) return 'Grishma (Summer)';
    if (month == 7 || month == 8) return 'Varsha (Monsoon)';
    if (month == 9 || month == 10) return 'Sharad (Autumn)';
    if (month == 11 || month == 12) return 'Hemanta (Late Autumn)';
    return 'Shishira (Winter)'; // Jan-Feb
  }

  @override
  Widget build(BuildContext context) {
    final currentSeason = _getVedicSeason();

    return Column(
      children: [
        const SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              const Icon(Icons.stars, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Text(
                'CURRENT SEASON: ${currentSeason.toUpperCase()}',
                style: AppTheme.labelMd(context).copyWith(color: Colors.amber),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: AyurvedaData.ritucharya.length,
            itemBuilder: (context, index) {
              final r = AyurvedaData.ritucharya[index];
              final isCurrent = r['season'] == currentSeason;

              return Card(
                elevation: isCurrent ? 8 : 0,
                color: isCurrent
                    ? AppTheme.primary.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isCurrent
                        ? AppTheme.primary
                        : Colors.white.withValues(alpha: 0.1),
                    width: isCurrent ? 2 : 1,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    r['season'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? AppTheme.primary : Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    r['months'],
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  leading: Icon(
                    isCurrent ? Icons.wb_sunny : Icons.eco_outlined,
                    color: isCurrent
                        ? AppTheme.primary
                        : Colors.white.withValues(alpha: 0.4),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Focus: ${r['focus']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Food: ${r['foods']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Activity: ${r['activities']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HerbalRemedies extends StatelessWidget {
  const _HerbalRemedies();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: AyurvedaData.remedies.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/ayurveda/herbal_remedies.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Herbal Remedies',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
            ],
          );
        }
        final h = AyurvedaData.remedies[index - 1];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(
              h['name']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(h['benefits']!),
            trailing: const Icon(Icons.info_outline),
            onTap: () => _showRemedyDetails(context, h),
          ),
        );
      },
    );
  }

  void _showRemedyDetails(BuildContext context, Map<String, String> herb) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              herb['name']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              herb['type']!,
              style: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Common Usage:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(herb['usage']!),
            const SizedBox(height: 24),
            Text(
              'Disclaimer: NOT medical advice.',
              style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

