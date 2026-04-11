import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../data/lifestyle_repository.dart';
import '../../../shared/theme/app_colors.dart';

class FastingScreen extends ConsumerStatefulWidget {
  const FastingScreen({super.key});

  @override
  ConsumerState<FastingScreen> createState() => _FastingScreenState();
}

class _FastingScreenState extends ConsumerState<FastingScreen> {
  bool _isFasting = false;
  DateTime? _startTime;
  String _protocol = '16:8';
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  final List<Map<String, dynamic>> _protocols = [
    {'name': '14:10', 'hours': 14, 'desc': 'Beginner Friendly'},
    {'name': '16:8', 'hours': 16, 'desc': 'Popular Method'},
    {'name': '18:6', 'hours': 18, 'desc': 'Intermediate'},
    {'name': '20:4', 'hours': 20, 'desc': 'Warrior Mode'},
    {'name': 'Nirjala', 'hours': 24, 'desc': 'Festival Fast'},
  ];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        setState(() {
          _elapsed = DateTime.now().difference(_startTime!);
        });
      }
    });
  }

  Future<void> _toggleFasting() async {
    final repo = ref.read(lifestyleRepositoryProvider.notifier);
    if (_isFasting) {
      // Ending fast
      await repo.saveFastingLog(
        startTime: _startTime!,
        endTime: DateTime.now(),
        fastingType: _protocol,
        isCompleted: _elapsed.inHours >= _getTargetHours(),
      );
      _timer?.cancel();
      setState(() {
        _isFasting = false;
        _startTime = null;
        _elapsed = Duration.zero;
      });
    } else {
      // Starting fast
      _startTime = DateTime.now();
      await repo.saveFastingLog(
        startTime: _startTime!,
        fastingType: _protocol,
      );
      setState(() {
        _isFasting = true;
      });
      _startTimer();
    }
  }

  int _getTargetHours() {
    if (_protocol == 'Nirjala') return 24;
    return int.tryParse(_protocol.split(':').first) ?? 16;
  }

  @override
  Widget build(BuildContext context) {
    final targetHours = _getTargetHours();
    final progress = _isFasting ? (_elapsed.inSeconds / (targetHours * 3600)).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fasting Clock · उपवास घड़ी'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildClockSection(progress, targetHours),
            const SizedBox(height: 40),
            if (!_isFasting) _buildProtocolSelector(),
            if (_isFasting) _buildActiveFastingInfo(),
            const SizedBox(height: 60),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildClockSection(double progress, int targetHours) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 15,
              backgroundColor: Colors.indigo[50],
              color: Colors.indigo[700],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isFasting ? _formatDuration(_elapsed) : '00:00:00',
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 8),
              Text(
                _isFasting ? 'EST. END ${DateFormat('jm').format(_startTime!.add(Duration(hours: targetHours)))}' : 'Ready to start?',
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  Widget _buildProtocolSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose Protocol', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _protocols.map((p) {
                final isSelected = _protocol == p['name'];
                return GestureDetector(
                  onTap: () => setState(() => _protocol = p['name']),
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.indigo[900] : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? Colors.indigo[900]! : Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['name'] as String, style: TextStyle(
                          color: isSelected ? Colors.white : Colors.indigo[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                        const Spacer(),
                        Text(p['desc'] as String, style: TextStyle(
                          color: isSelected ? Colors.white70 : Colors.grey[600],
                          fontSize: 12,
                        )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFastingInfo() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.timer_outlined, size: 40, color: Colors.indigo),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Level: ${_protocol}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Started at ${DateFormat('jm').format(_startTime!)}', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _toggleFasting,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isFasting ? Colors.redAccent : Colors.indigo[900],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            _isFasting ? 'END FASTING · उपवास समाप्त करें' : 'START FASTING · उपवास शुरू करें',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
