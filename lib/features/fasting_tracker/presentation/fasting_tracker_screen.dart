import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/fasting_stage.dart';
import '../../karma/data/karma_repository.dart';

class FastingTrackerScreen extends ConsumerStatefulWidget {
  const FastingTrackerScreen({super.key});

  @override
  ConsumerState<FastingTrackerScreen> createState() => _FastingTrackerScreenState();
}

class _FastingTrackerScreenState extends ConsumerState<FastingTrackerScreen> {
  DateTime? _fastStart;
  double _targetHours = 16.0;
  String _activeProtocol = '16:8';
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    // In a real app, we'd load the active fast from Drift
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_fastStart != null) {
        setState(() {
          _elapsed = DateTime.now().difference(_fastStart!);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleFast() {
    if (_fastStart == null) {
      setState(() {
        _fastStart = DateTime.now().subtract(const Duration(hours: 14)); // Simulation
      });
    } else {
      _showBreakFastDialog();
    }
  }

  void _showBreakFastDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Break Your Fast?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Great job! To break your fast gently, try:'),
            const SizedBox(height: 12),
            const Text('• Bone broth or vegetable soup'),
            const Text('• Fermented foods (Kefir, Yogurt)'),
            const Text('• Healthy fats (Avocado, Nuts)'),
            const SizedBox(height: 12),
            const Text('Ready to record your completion?'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _completeFast();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Confirm & Log'),
          ),
        ],
      ),
    );
  }

  Future<void> _completeFast() async {
    // Award +15 XP
    final repo = ref.read(karmaRepositoryProvider);
    await repo.awardXP(
      userId: 'current_user', 
      amount: 15, 
      action: 'fasting_completion',
      description: 'Completed a $_activeProtocol fast.',
    );

    setState(() {
      _fastStart = null;
      _elapsed = Duration.zero;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fast completed! +15 Karma XP earned! 🧘')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stage = FastingStageEngine.getStage(_elapsed);
    final progress = _elapsed.inSeconds / (_targetHours * 3600);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasting Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade900, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildProgressUI(progress),
                const SizedBox(height: 40),
                _buildStageCard(stage),
                const SizedBox(height: 24),
                _buildProtocolSelector(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressUI(double progress) {
    return Column(
      children: [
        SizedBox(
          height: 280,
          width: 280,
          child: CustomPaint(
            painter: FastingProgressPainter(progress: progress.clamp(0.0, 1.0)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _fastStart == null ? '00:00:00' : _formatDuration(_elapsed),
                    style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ELAPSED TIME',
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Goal: ${_targetHours.toInt()}h',
                    style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  Widget _buildStageCard(FastingStage stage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.bolt, color: Colors.orange),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FastingStageEngine.getStageName(stage),
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  FastingStageEngine.getStageDescription(stage),
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolSelector() {
    final protocols = ['16:8', '18:6', 'OMAD', '20:4', 'Ramadan'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Protocol', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: protocols.length,
            itemBuilder: (context, index) {
              final p = protocols[index];
              final isSelected = _activeProtocol == p;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(p),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      _activeProtocol = p;
                      if (p == 'OMAD') {
                        _targetHours = 23;
                      } else if (p == '16:8') _targetHours = 16;
                      else if (p == '18:6') _targetHours = 18;
                      else if (p == '20:4') _targetHours = 20;
                      else if (p == 'Ramadan') _targetHours = 14; // Default Ramadan
                    });
                  },
                  backgroundColor: Colors.white10,
                  selectedColor: Colors.orange,
                  labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white60),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _toggleFast,
              style: ElevatedButton.styleFrom(
                backgroundColor: _fastStart == null ? Colors.orange : Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                _fastStart == null ? 'START FASTING' : 'END FAST / BREAK FAST',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_fastStart != null)
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water_drop, color: Colors.blue, size: 16),
                SizedBox(width: 8),
                Text('Don\'t forget to stay hydrated!', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
        ],
      ),
    );
  }
}

class FastingProgressPainter extends CustomPainter {
  final double progress;

  FastingProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final strokeWidth = 12.0;

    // Background track
    final paintTrack = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius - strokeWidth, paintTrack);

    // Progress arc
    final paintProgress = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.orange, Colors.orangeAccent],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth),
      -pi / 2,
      2 * pi * progress,
      false,
      paintProgress,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
