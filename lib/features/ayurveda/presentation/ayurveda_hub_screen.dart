import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../domain/dosha_calculator.dart';
import '../data/ayurveda_data.dart';

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
      appBar: AppBar(
        title: const Text('Ayurveda Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showDisclaimer(context),
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Dosha'),
          BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), label: 'Rituals'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Seasons'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Herbs'),
        ],
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
                const Icon(Icons.quiz, size: 32, color: Colors.teal),
                const SizedBox(height: 16),
                const Text('Take the Prakriti Quiz', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Identify your dominant Dosha and learn your natural constitution.', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('START QUIZ'),
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

class _DoshaProfile extends StatelessWidget {
  const _DoshaProfile();

  @override
  Widget build(BuildContext context) {
    // Mock user dosha: Pitta dominant
    final score = DoshaScore(vata: 4, pitta: 8, kapha: 3);
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
  }
}

class _DailyRituals extends StatelessWidget {
  const _DailyRituals();

  @override
  Widget build(BuildContext context) {
    final rituals = AyurvedaData.dinacharya[Dosha.pitta]!; // Mock

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Text('Dinacharya', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text('Daily Rituals for Pitta Balance', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 24),
        ...rituals.map((r) => CheckboxListTile(
          value: false,
          onChanged: (v) {},
          title: Text(r),
          controlAffinity: ListTileControlAffinity.leading,
        )),
      ],
    );
  }
}

class _SeasonalPlan extends StatelessWidget {
  const _SeasonalPlan();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: AyurvedaData.ritucharya.length,
      itemBuilder: (context, index) {
        final r = AyurvedaData.ritucharya[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(r['season'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(r['months']),
            leading: const Icon(Icons.eco_outlined, color: Colors.teal),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Focus: ${r['focus']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                    const SizedBox(height: 8),
                    Text('Food: ${r['foods']}'),
                    const SizedBox(height: 4),
                    Text('Activity: ${r['activities']}'),
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

class _HerbalRemedies extends StatelessWidget {
  const _HerbalRemedies();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: AyurvedaData.remedies.length,
      itemBuilder: (context, index) {
        final h = AyurvedaData.remedies[index];
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
