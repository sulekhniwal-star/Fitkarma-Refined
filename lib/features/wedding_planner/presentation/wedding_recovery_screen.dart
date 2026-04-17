import 'package:flutter/material.dart';

class WeddingRecoveryScreen extends StatelessWidget {
  const WeddingRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Post-Wedding Recovery'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const _DetoxOverviewHeader(),
            const SizedBox(height: 24),
            const _ThreeDayDetoxPlan(),
            const SizedBox(height: 24),
            const _CalorieReturnChart(),
            const SizedBox(height: 24),
            const _YogaPlanCard(),
            const SizedBox(height: 24),
            const _SocialShareCTA(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _DetoxOverviewHeader extends StatelessWidget {
  const _DetoxOverviewHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        children: [
          const Icon(Icons.spa, color: Colors.teal, size: 48),
          const SizedBox(height: 16),
          const Text('Recuperate & Reset', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal)),
          const SizedBox(height: 8),
          Text(
            'The festivities were grand, now let\'s bring your body back to its natural rhythm.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.teal.shade900, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _ThreeDayDetoxPlan extends StatelessWidget {
  const _ThreeDayDetoxPlan();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('3-Day Reset Protocol', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _DetoxDayCard(day: 'Day 1', focus: 'Hydration & Fiber', description: 'Zero sugar, 4L water, large green salads.'),
        _DetoxDayCard(day: 'Day 2', focus: 'Gut Health', description: 'Kefir/Curd, probiotic-rich foods, light soups.'),
        _DetoxDayCard(day: 'Day 3', focus: 'Energy Return', description: 'Lean protein, complex carbs, normal activity.'),
      ],
    );
  }
}

class _DetoxDayCard extends StatelessWidget {
  final String day;
  final String focus;
  final String description;
  const _DetoxDayCard({required this.day, required this.focus, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.teal.shade100, child: Text(day.split(' ')[1], style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        title: Text(focus, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}

class _CalorieReturnChart extends StatelessWidget {
  const _CalorieReturnChart();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('5-Day Calorie Normalization', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(height: 150, color: Colors.grey.shade50, child: const Center(child: Text('Calorie Slope Chart Placeholder'))),
            const SizedBox(height: 12),
            const Text('Gradually returning your metabolism to your baseline.', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _YogaPlanCard extends StatelessWidget {
  const _YogaPlanCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.self_improvement, color: Colors.teal.shade400),
                const SizedBox(width: 8),
                const Text('Yoga-Only Week', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Focus on joint mobility and stress reduction. Avoid heavy lifting for 5 days.', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 16),
            _YogaItem(label: 'Sun Salutations (Slow)', time: '15m'),
            _YogaItem(label: 'Deep Joint Rotation', time: '10m'),
            _YogaItem(label: 'Pranayama (Breathing)', time: '15m'),
          ],
        ),
      ),
    );
  }
}

class _YogaItem extends StatelessWidget {
  final String label;
  final String time;
  const _YogaItem({required this.label, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}

class _SocialShareCTA extends StatelessWidget {
  const _SocialShareCTA();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.share),
        label: const Text('SHARE RECOVERY JOURNEY'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

