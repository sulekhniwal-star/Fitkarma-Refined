import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:fitkarma/core/storage/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MeditationSession {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final String category;
  final String? audioPath;
  final bool isGuided;

  const MeditationSession({
    required this.id,
    required this.title,
    this.description = '',
    required this.durationMinutes,
    this.category = 'General',
    this.audioPath,
    this.isGuided = false,
  });
}

class PranayamaSession {
  final String name;
  final String sanskritName;
  final int inhaleSeconds;
  final int holdSeconds;
  final int exhaleSeconds;
  final int holdAfterExhale;
  final int cycles;
  final String benefits;
  final String precautions;

  const PranayamaSession({
    required this.name,
    this.sanskritName = '',
    required this.inhaleSeconds,
    this.holdSeconds = 0,
    required this.exhaleSeconds,
    this.holdAfterExhale = 0,
    this.cycles = 5,
    this.benefits = '',
    this.precautions = '',
  });
}

final pranamayaSessions = [
  const PranayamaSession(
    name: 'Anulom Vilom',
    sanskritName: 'Alternate Nostril Breathing',
    inhaleSeconds: 4,
    holdSeconds: 16,
    exhaleSeconds: 4,
    holdAfterExhale: 0,
    cycles: 10,
    benefits: 'Balances hemispheres, reduces stress',
    precautions: 'Avoid after meals, not during pregnancy',
  ),
  const PranayamaSession(
    name: 'Bhramari',
    sanskritName: 'Bee Breath',
    inhaleSeconds: 4,
    holdSeconds: 4,
    exhaleSeconds: 4,
    holdAfterExhale: 0,
    cycles: 5,
    benefits: 'Calms mind, relieves anxiety, headaches',
    precautions: 'Keep teeth together, ear holes covered',
  ),
  const PranayamaSession(
    name: 'Kapalbhati',
    sanskritName: 'Skull Shining Breath',
    inhaleSeconds: 1,
    holdSeconds: 0,
    exhaleSeconds: 1,
    holdAfterExhale: 0,
    cycles: 20,
    benefits: 'Energizes, clears sinuses, improves circulation',
    precautions: 'Avoid during pregnancy, high BP, heart issues',
  ),
  const PranayamaSession(
    name: 'Bhastrika',
    sanskritName: 'Bellows Breath',
    inhaleSeconds: 2,
    holdSeconds: 2,
    exhaleSeconds: 2,
    holdAfterExhale: 2,
    cycles: 10,
    benefits: 'Increases energy, warms body, cleanses',
    precautions: 'Avoid if pregnant, high BP, heart conditions',
  ),
  const PranayamaSession(
    name: 'Box Breathing',
    sanskritName: 'Sama Vritti',
    inhaleSeconds: 4,
    holdSeconds: 4,
    exhaleSeconds: 4,
    holdAfterExhale: 4,
    cycles: 8,
    benefits: 'Reduces stress, improves focus',
    precautions: 'None',
  ),
  const PranayamaSession(
    name: '4-7-8 Breathing',
    sanskritName: 'Relaxing Breath',
    inhaleSeconds: 4,
    holdSeconds: 7,
    exhaleSeconds: 8,
    holdAfterExhale: 0,
    cycles: 4,
    benefits: 'Promotes sleep, reduces anxiety',
    precautions: 'Do not hold if pregnant',
  ),
];

final guidedSessions = [
  const MeditationSession(
    id: 'g5',
    title: '5-Min Morning Calm',
    description: 'Start your day with clarity',
    durationMinutes: 5,
    category: 'Morning',
    isGuided: true,
  ),
  const MeditationSession(
    id: 'g10',
    title: '10-Min Stress Relief',
    description: 'Release tension and anxiety',
    durationMinutes: 10,
    category: 'Stress',
    isGuided: true,
  ),
  const MeditationSession(
    id: 'g15',
    title: '15-Min Body Scan',
    description: 'Connect with your body',
    durationMinutes: 15,
    category: 'Body',
    isGuided: true,
  ),
  const MeditationSession(
    id: 'g20',
    title: '20-Min Deep Relaxation',
    description: 'Full rest and restoration',
    durationMinutes: 20,
    category: 'Sleep',
    isGuided: true,
  ),
];

class MeditationScreen extends ConsumerStatefulWidget {
  final String odUserId;

  const MeditationScreen({super.key, required this.odUserId});

  @override
  ConsumerState<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends ConsumerState<MeditationScreen> {
  bool _isPlaying = false;
  int _selectedIndex = 0;
  int _currentCycle = 0;
  String _phase = 'Inhale';
  Timer? _breathingTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _breathingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meditation & Pranayama'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Guided'),
              Tab(text: 'Pranayama'),
              Tab(text: 'Breathing'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGuidedList(),
            _buildPranayamaList(),
            _buildBreathingExercise(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidedList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: guidedSessions.length,
      itemBuilder: (context, index) {
        final session = guidedSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.headphones, color: Colors.indigo),
            ),
            title: Text(session.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${session.durationMinutes} min'),
            trailing: IconButton(
              icon: Icon(_isPlaying && _selectedIndex == index ? Icons.pause : Icons.play_arrow),
              onPressed: () => _playAudio(session.durationMinutes),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPranayamaList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pranamayaSessions.length,
      itemBuilder: (context, index) {
        final session = pranamayaSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.air, color: Colors.orange),
            ),
            title: Text(session.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(session.sanskritName, style: TextStyle(fontStyle: FontStyle.italic)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cycle: ${_formatCycle(session)}'),
                    const SizedBox(height: 8),
                    Text('Benefits: ${session.benefits}'),
                    if (session.precautions.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            const Icon(Icons.warning, color: Colors.red, size: 16),
                            const SizedBox(width: 8),
                            Expanded(child: Text(session.precautions)),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => _startPranayama(session),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start'),
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

  Widget _buildBreathingExercise() {
    if (!_isPlaying) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.air, size: 64, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Tap a pranayama to start', style: TextStyle(fontSize: 18)),
          ],
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _phase,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getPhaseColor(_phase).withValues(alpha: 0.3),
              border: Border.all(color: _getPhaseColor(_phase), width: 4),
            ),
            child: Center(
              child: Text(
                '${_currentCycle}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: _getPhaseColor(_phase)),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text('Cycle $_currentCycle of $_selectedIndex'),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _breathingTimer?.cancel();
              setState(() => _isPlaying = false);
            },
            icon: const Icon(Icons.stop),
            label: const Text('Stop'),
          ),
        ],
      ),
    );
  }

  String _formatCycle(PranayamaSession s) {
    final parts = <String>[];
    if (s.inhaleSeconds > 0) parts.add('In ${s.inhaleSeconds}s');
    if (s.holdSeconds > 0) parts.add('Hold ${s.holdSeconds}s');
    if (s.exhaleSeconds > 0) parts.add('Out ${s.exhaleSeconds}s');
    if (s.holdAfterExhale > 0) parts.add('Hold ${s.holdAfterExhale}s');
    return '${parts.join(' - ')} x ${s.cycles}';
  }

  Color _getPhaseColor(String phase) {
    switch (phase) {
      case 'Inhale': return Colors.blue;
      case 'Hold': return Colors.orange;
      case 'Exhale': return Colors.green;
      default: return Colors.grey;
    }
  }

  void _playAudio(int minutes) {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _selectedIndex = minutes;
      }
    });
  }

  void _startPranayama(PranayamaSession session) {
    setState(() {
      _isPlaying = true;
      _selectedIndex = session.cycles;
      _currentCycle = 1;
      _phase = 'Inhale';
    });
    _runBreathingCycle(session);
  }

  void _runBreathingCycle(PranayamaSession session) {
    if (!_isPlaying || _currentCycle > session.cycles) {
      _completeSession();
      return;
    }
    setState(() => _phase = 'Inhale');
    _startTimer(session.inhaleSeconds, () {
      if (session.holdSeconds > 0) {
        setState(() => _phase = 'Hold');
        _startTimer(session.holdSeconds, () {
          _exhalePhase(session);
        });
      } else {
        _exhalePhase(session);
      }
    });
  }

  void _exhalePhase(PranayamaSession session) {
    setState(() => _phase = 'Exhale');
    _startTimer(session.exhaleSeconds, () {
      if (session.holdAfterExhale > 0) {
        setState(() => _phase = 'Hold');
        _startTimer(session.holdAfterExhale, () {
          setState(() => _currentCycle++);
          _runBreathingCycle(session);
        });
      } else {
        setState(() => _currentCycle++);
        _runBreathingCycle(session);
      }
    });
  }

  void _startTimer(int seconds, VoidCallback onComplete) {
    _breathingTimer?.cancel();
    int count = seconds;
    _breathingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      count--;
      if (count <= 0) {
        timer.cancel();
        onComplete();
      }
    });
  }

  void _completeSession() {
    _breathingTimer?.cancel();
    setState(() => _isPlaying = false);
    _awardXP();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Session complete! +5 XP'), backgroundColor: Colors.green),
    );
  }

  Future<void> _awardXP() async {
    final db = ref.read(appDatabaseProvider);
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: widget.odUserId,
        amount: 5,
        createdAt: DateTime.now(),
      ),
    );
  }
}