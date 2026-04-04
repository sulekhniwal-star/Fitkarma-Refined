import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MentalHealthScreen extends ConsumerWidget {
  final String odUserId;

  const MentalHealthScreen({super.key, required this.odUserId});

  static const _indianHelplines = [
    {'name': 'iCall', 'phone': '9152987821', 'desc': 'Psychological helpline (Mon-Sat, 8am-10pm)', 'available': 'Mon-Sat 8am-10pm'},
    {'name': 'Vandrevala Foundation', 'phone': '18602662345', 'desc': '24/7 mental health helpline', 'available': '24/7'},
    {'name': 'NIMHANS', 'phone': '08046110000', 'desc': 'National Institute of Mental Health', 'available': 'Mon-Fri 9am-5pm'},
    {'name': 'Emergency', 'phone': '112', 'desc': 'Police/ Ambulance', 'available': '24/7'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Wellness'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBurnoutDetection(db),
            const SizedBox(height: 24),
            _buildHelplines(),
            const SizedBox(height: 24),
            _buildCBTLite(),
          ],
        ),
      ),
    );
  }

  Widget _buildBurnoutDetection(AppDatabase db) {
    return FutureBuilder(
      future: _checkBurnoutRisk(db),
      builder: (context, snapshot) {
        final risk = snapshot.data ?? _BurnoutRisk(low: false, lowMoodDays: 0, poorSleepDays: 0, lowEnergyDays: 0);
        
        return Card(
          color: risk.low ? null : Colors.orange.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      risk.low ? Icons.check_circle : Icons.warning,
                      color: risk.low ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      risk.low ? 'You are doing great!' : 'We notice you may need support',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                if (!risk.low) ...[
                  const SizedBox(height: 12),
                  const Text(
                    'We\'ve noticed some patterns over the past week:',
                    style: TextStyle(fontSize: 14),
                  ),
                  if (risk.lowMoodDays > 0)
                    Text('• Low mood logged $risk.lowMoodDays days'),
                  if (risk.poorSleepDays > 0)
                    Text('• Poor sleep logged $risk.poorSleepDays days'),
                  if (risk.lowEnergyDays > 0)
                    Text('• Low energy logged $risk.lowEnergyDays days'),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.healing),
                    label: const Text('Start Recovery Flow'),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHelplines() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Indian Mental Health Resources', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        ..._indianHelplines.map((h) => Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.phone, color: Colors.green),
            ),
            title: Text(h['name']!),
            subtitle: Text('${h['phone']} • ${h['desc']}'),
            trailing: Text(h['available']!, style: const TextStyle(fontSize: 12)),
          ),
        )),
      ],
    );
  }

  Widget _buildCBTLite() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('7-Day Stress Recovery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        const Text('Personalized prompts based on your logs', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 12),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.psychology, color: Colors.purple),
            title: const Text('Day 1: Awareness'),
            subtitle: const Text('What triggered your stress?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Think about a situation that made you stressed recently. Write it down without judgment. '
                    'Notice how your body feels when you think about it. This is just information, not truth.'),
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.view_in_ar, color: Colors.purple),
            title: const Text('Day 2: Patterns'),
            subtitle: const Text('Are there repeated triggers?'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Look back at your mood logs. Do you notice patterns? '
                    'Write about what happens before you feel stressed.'),
              ),
            ],
          ),
        ),
        Card(
          child: ExpansionTile(
            leading: const Icon(Icons.lightbulb, color: Colors.purple),
            title: const Text('Day 3: Reframe'),
            subtitle: const Text('Challenge the thought'),
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text('Write the stressful thought, then ask: Is this always true? '
                    'What would I tell a friend in this situation?'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<_BurnoutRisk> _checkBurnoutRisk(AppDatabase db) async {
    return _BurnoutRisk(low: false, lowMoodDays: 0, poorSleepDays: 0, lowEnergyDays: 0);
  }
}

class _BurnoutRisk {
  final bool low;
  final int lowMoodDays;
  final int poorSleepDays;
  final int lowEnergyDays;

  _BurnoutRisk({
    required this.low,
    required this.lowMoodDays,
    required this.poorSleepDays,
    required this.lowEnergyDays,
  });
}

class RecoveryFlowScreen extends ConsumerWidget {
  final String odUserId;

  const RecoveryFlowScreen({super.key, required this.odUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery Plan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDayCard(1, 'Check-in', 'How are you feeling right now? Rate 1-10'),
          _buildDayCard(2, 'Sleep hygiene', 'Aim for consistent sleep time tonight'),
          _buildDayCard(3, 'Movement', '10-minute gentle walk or stretching'),
          _buildDayCard(4, 'Social connection', 'Call a friend or family member'),
          _buildDayCard(5, 'Gratitude', 'Write 3 things you appreciate'),
          _buildDayCard(6, 'Nature', 'Spend 20 minutes outside'),
          _buildDayCard(7, 'Review', 'Look back at your progress this week'),
        ],
      ),
    );
  }

  Widget _buildDayCard(int day, String title, String task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade100,
          child: Text('$day', style: const TextStyle(color: Colors.purple)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task),
      ),
    );
  }
}