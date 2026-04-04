import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class DoshaQuizScreen extends ConsumerStatefulWidget {
  final String userId;

  const DoshaQuizScreen({super.key, required this.userId});

  @override
  ConsumerState<DoshaQuizScreen> createState() => _DoshaQuizScreenState();
}

class _DoshaQuizScreenState extends ConsumerState<DoshaQuizScreen> {
  int _currentIndex = 0;
  int _vataScore = 0;
  int _pittaScore = 0;
  int _kaphaScore = 0;
  bool _isComplete = false;

  static const _questions = [
    {'question': 'How would you describe your body frame?', 'vata': 'Thin & tall', 'pitta': 'Medium', 'kapha': 'Stocky & wide'},
    {'question': 'What is your skin type usually?', 'vata': 'Dry & rough', 'pitta': 'Oily & warm', 'kapha': 'Thick & smooth'},
    {'question': 'How do you handle stress?', 'vata': 'Anxious', 'pitta': 'Angry', 'kapha': 'Calm but depressed'},
    {'question': 'What is your appetite like?', 'vata': 'Variable', 'pitta': 'Strong', 'kapha': 'Slow'},
    {'question': 'How is your digestion?', 'vata': 'Gas & bloating', 'pitta': 'Fast, acid', 'kapha': 'Slow, heavy'},
    {'question': 'What is your sleep pattern?', 'vata': 'Light & broken', 'pitta': 'Moderate', 'kapha': 'Deep & long'},
    {'question': 'How is your memory?', 'vata': 'Quick learner, quick forgetter', 'pitta': 'Good memory', 'kapha': 'Slow but lasting'},
    {'question': 'What energizes you most?', 'vata': 'Movement', 'pitta': 'Challenge', 'kapha': 'Rest'},
    {'question': 'How do you make decisions?', 'vata': 'Quick but may change', 'pitta': 'Decisive', 'kapha': 'Slow & methodical'},
    {'question': 'What describes your mood best?', 'vata': 'Enthusiastic but flaky', 'pitta': 'Determined', 'kapha': 'Content & steady'},
    {'question': 'How is your circulation?', 'vata': 'Cold hands/feet', 'pitta': 'Warm', 'kapha': 'Cool but steady'},
    {'question': 'What is your ideal climate?', 'vata': 'Warm & humid', 'pitta': 'Cool', 'kapha': 'Moderate'},
  ];

  @override
  Widget build(BuildContext context) {
    if (_isComplete) {
      return _buildResults();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosha Quiz'),
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.pop()),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: Colors.grey.shade200,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Question ${_currentIndex + 1}/${_questions.length}',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _questions[_currentIndex]['question']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildOption('vata', _questions[_currentIndex]['vata']!),
                  const SizedBox(height: 12),
                  _buildOption('pitta', _questions[_currentIndex]['pitta']!),
                  const SizedBox(height: 12),
                  _buildOption('kapha', _questions[_currentIndex]['kapha']!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String dosha, String text) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _answer(dosha),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _answer(String dosha) {
    switch (dosha) {
      case 'vata': _vataScore++; break;
      case 'pitta': _pittaScore++; break;
      case 'kapha': _kaphaScore++; break;
    }
    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _isComplete = true);
    }
  }

  Widget _buildResults() {
    final total = _vataScore + _pittaScore + _kaphaScore;
    final vataPct = ((_vataScore / total) * 100).round();
    final pittaPct = ((_pittaScore / total) * 100).round();
    final kaphaPct = ((_kaphaScore / total) * 100).round();

    String dominant = 'Vata';
    if (pittaPct > vataPct && pittaPct > kaphaPct) dominant = 'Pitta';
    else if (kaphaPct > vataPct && kaphaPct > pittaPct) dominant = 'Kapha';

    return Scaffold(
      appBar: AppBar(title: const Text('Your Dosha Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Your Ayurvedic Constitution', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            _buildDonutChart(vataPct, pittaPct, kaphaPct),
            const SizedBox(height: 32),
            Text('Dominant: $dominant', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Vata: $vataPct% | Pitta: $pittaPct% | Kapha: $kaphaPct%'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _saveResults(vataPct, pittaPct, kaphaPct, dominant),
              child: const Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonutChart(int vata, int pitta, int kapha) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: CircularProgressIndicator(
              value: vata / 100,
              strokeWidth: 30,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(Color(0xFF8B4513)),
            ),
          ),
          Column(
            children: [
              Text('V$vata%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('P$pitta%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
              Text('K$kapha%', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveResults(int vata, int pitta, int kapha, String dominant) async {
    final db = ref.read(appDatabaseProvider);
    final profile = await db.userProfilesDao.getProfile(widget.userId);
    if (profile != null) {
      await db.userProfilesDao.updateProfile(UserProfilesCompanion(
        id: Value(profile.id),
        odUserId: Value(widget.userId),
        name: Value(profile.name),
        gender: Value(profile.gender),
        dateOfBirth: Value(profile.dateOfBirth),
        heightCm: Value(profile.heightCm),
        weightKg: Value(profile.weightKg),
        fitnessGoal: Value(profile.fitnessGoal),
        activityLevel: Value(profile.activityLevel),
        chronicConditions: Value(profile.chronicConditions),
        vataPercent: Value(vata),
        pittaPercent: Value(pitta),
        kaphaPercent: Value(kapha),
        dominantDosha: Value(dominant),
        doshaQuizDate: Value(DateTime.now()),
        language: Value(profile.language),
        stepCounterPermission: Value(profile.stepCounterPermission),
        heartRatePermission: Value(profile.heartRatePermission),
        sleepPermission: Value(profile.sleepPermission),
        abhaNumber: Value(profile.abhaNumber),
        wearableConnected: Value(profile.wearableConnected),
        karmaXp: Value(profile.karmaXp),
        syncEnabled: Value(profile.syncEnabled),
        createdAt: Value(profile.createdAt),
        updatedAt: Value(DateTime.now()),
      ));
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dosha profile saved!'), backgroundColor: Colors.green),
      );
      context.pop();
    }
  }
}