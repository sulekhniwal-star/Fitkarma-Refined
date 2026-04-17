import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../domain/dosha_calculator.dart';
import '../domain/ayurveda_providers.dart';
import '../data/ayurveda_data.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/glass_app_bar.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        title: 'Ayurveda Hub',
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showDisclaimer(context),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.white.withValues(alpha: 0.4),
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: 'Dosha'),
                BottomNavigationBarItem(icon: Icon(Icons.wb_sunny_outlined), label: 'Rituals'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Seasons'),
                BottomNavigationBarItem(icon: Icon(Icons.eco_outlined), label: 'Herbs'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDisclaimer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disclaimer'),
        content: const Text(
          'Information provided is for educational purposes based on traditional Ayurvedic principles. '
          'It is NOT medical advice. Always consult a qualified practitioner before starting any supplement or diet change.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('I Understand')),
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
          const Text('Discover Your Nature', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Ayurveda is the science of life, balancing body, mind, and spirit.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          _buildHeroCard(context),
          const SizedBox(height: 24),
          const Text('Core Principles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPrincipleItem('Vata: Air & Ether', 'Governs motion and energy.'),
          _buildPrincipleItem('Pitta: Fire & Water', 'Governs digestion and metabolism.'),
          _buildPrincipleItem('Kapha: Earth & Water', 'Governs structure and lubrication.'),
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
                const Icon(Icons.quiz_rounded, size: 32, color: AppColors.primary),
                const SizedBox(height: 16),
                Text('Analyze your Prakriti', style: AppTextStyles.h2(false).copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Identify your dominant Dosha and receive personalized lifestyle guidance.', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.push('/ayurveda/quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
  const _DoshaProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final securityState = ref.watch(ayurvedaNotifierProvider);

    return securityState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
      data: (score) {
        if (score == null) {
          return _buildEmptyState(context);
        }

        final dominant = score.dominant;
        final percentages = score.percentages;

        final doshaImg = {
          Dosha.vata: 'assets/images/ayurveda/vata.png',
          Dosha.pitta: 'assets/images/ayurveda/pitta.png',
          Dosha.kapha: 'assets/images/ayurveda/kapha.png',
        }[dominant]!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('Your Dosha Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(doshaImg, height: 160, fit: BoxFit.contain),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 180,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(color: Colors.blue.shade300, value: percentages[Dosha.vata]!, title: 'Vata', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  PieChartSectionData(color: Colors.red.shade400, value: percentages[Dosha.pitta]!, title: 'Pitta', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  PieChartSectionData(color: Colors.green.shade400, value: percentages[Dosha.kapha]!, title: 'Kapha', radius: 50, titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
                centerSpaceRadius: 40,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 0,
            color: Colors.grey.withOpacity(0.05),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.withOpacity(0.1))),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text('Primary Dosha: ${dominant.name.toUpperCase()}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                  const SizedBox(height: 12),
                  const Text('You possess the focused energy of fire and the fluidity of water. Your Agni (digestive fire) is naturally strong.', textAlign: TextAlign.center, style: TextStyle(height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.spa_outlined, size: 80, color: Colors.white.withValues(alpha: 0.2)),
          const SizedBox(height: 24),
          Text('Dosha Analysis Pending', style: AppTextStyles.h3(true)),
          const SizedBox(height: 8),
          const Text('Complete the Prakriti Quiz to see your profile.', style: TextStyle(color: Colors.grey)),
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

class _DailyRituals extends ConsumerWidget {
  const _DailyRituals({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final securityState = ref.watch(ayurvedaNotifierProvider);
    final dominant = securityState.value?.dominant ?? Dosha.pitta; 
    final rituals = AyurvedaData.dinacharya[dominant]!;

    return ListView(
      padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 24),
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(Icons.auto_awesome, color: AppColors.primary, size: 48),
          ),
        ),
        const SizedBox(height: 24),
        Text('Dinacharya', style: AppTextStyles.h2(true)),
        Text('Daily Rituals for ${dominant.name.toUpperCase()} Balance', style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        ...rituals.map((r) => Card(
          color: Colors.white.withValues(alpha: 0.05),
          margin: const EdgeInsets.only(bottom: 12),
          child: CheckboxListTile(
            value: false, // In real app, track completion in separate state
            onChanged: (v) {
              if (v == true) {
                HapticFeedback.lightImpact();
                ref.read(userDaoProvider).addKarma(
                  'current_user_id', 
                  10, 
                  'Ayurvedic Ritual', 
                  'Completed $r'
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✨ Karma Points Earned! +10'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            title: Text(r, style: const TextStyle(color: Colors.white)),
            activeColor: AppColors.primary,
            checkColor: Colors.black,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        )),
      ],
    );
  }
}

class _SeasonalPlan extends StatelessWidget {
  const _SeasonalPlan({super.key});

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
                style: AppTextStyles.labelSmall(true).copyWith(color: Colors.amber),
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
                color: isCurrent ? AppColors.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isCurrent ? AppColors.primary : Colors.white.withValues(alpha: 0.1),
                    width: isCurrent ? 2 : 1,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    r['season'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? AppColors.primary : Colors.white,
                    ),
                  ),
                  subtitle: Text(r['months'], style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
                  leading: Icon(
                    isCurrent ? Icons.wb_sunny : Icons.eco_outlined,
                    color: isCurrent ? AppColors.primary : Colors.white.withValues(alpha: 0.4),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Focus: ${r['focus']}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          const SizedBox(height: 8),
                          Text('Food: ${r['foods']}', style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text('Activity: ${r['activities']}', style: const TextStyle(color: Colors.white70)),
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
                child: Text('Herbal Remedies', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
            ],
          );
        }
        final h = AyurvedaData.remedies[index - 1];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(h['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(herb['name']!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(herb['type']!, style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Common Usage:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(herb['usage']!),
            const SizedBox(height: 24),
            Text('Disclaimer: NOT medical advice.', style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
