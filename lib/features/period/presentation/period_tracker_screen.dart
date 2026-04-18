import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../data/period_drift_service.dart';
import '../../../core/storage/drift_service.dart';

class PeriodTrackerScreen extends ConsumerStatefulWidget {
  const PeriodTrackerScreen({super.key});

  @override
  ConsumerState<PeriodTrackerScreen> createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends ConsumerState<PeriodTrackerScreen> {
  late PeriodDriftService _service;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _pcosMode = false;

  @override
  void initState() {
    super.initState();
    _service = PeriodDriftService(db: DriftService.db);
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    // Usually we would watch a provider, but for brevity we'll mock some states
    final currentPhase = _service.getCurrentPhase(DateTime.now().subtract(const Duration(days: 3)));
    final workoutTip = _service.getWorkoutSuggestion(currentPhase);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Period Tracker'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPrivacyNotice(),
            _buildCalendar(),
            const SizedBox(height: 16),
            _buildPhaseIndicator(currentPhase),
            const SizedBox(height: 16),
            _buildWorkoutSuggestion(workoutTip),
            const SizedBox(height: 16),
            _buildLogSection(),
            const SizedBox(height: 16),
            _buildPCODToggle(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // Log period start/end
        label: const Text('Log Period'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink.shade300,
      ),
    );
  }

  Widget _buildPrivacyNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      color: Colors.blue.shade50,
      child: const Row(
        children: [
          Icon(Icons.lock, size: 16, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'This data is AES-256 encrypted and never shared.',
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(CyclePhase phase) {
    Color phaseColor;
    String phaseName;
    String phaseDesc;

    switch (phase) {
      case CyclePhase.menstrual:
        phaseColor = Colors.red.shade400;
        phaseName = 'Menstrual';
        phaseDesc = 'Day 1-5: Your cycle has just started.';
        break;
      case CyclePhase.follicular:
        phaseColor = Colors.orange.shade400;
        phaseName = 'Follicular';
        phaseDesc = 'Day 6-13: Estrogen is rising.';
        break;
      case CyclePhase.ovulatory:
        phaseColor = Colors.green.shade400;
        phaseName = 'Ovulatory';
        phaseDesc = 'Day 14-15: Highest chance of conception.';
        break;
      case CyclePhase.luteal:
        phaseColor = Colors.purple.shade400;
        phaseName = 'Luteal';
        phaseDesc = 'Day 16-28: Progesterone is peak.';
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: phaseColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: phaseColor, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _PhaseIcon(phase: phase, color: phaseColor),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Phase: $phaseName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: phaseColor),
                  ),
                  const SizedBox(height: 4),
                  Text(phaseDesc, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutSuggestion(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              child: Icon(Icons.fitness_center, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phase-Adapted Workout', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(tip, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Symptom Logging', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _SymptomChip(label: 'Cramps'),
              _SymptomChip(label: 'Headache'),
              _SymptomChip(label: 'Mood Swings'),
              _SymptomChip(label: 'Bloating'),
              _SymptomChip(label: 'Acne'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPCODToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SwitchListTile(
        title: const Text('PCOD / PCOS Mode'),
        subtitle: const Text('Adjusts cycle predictions for irregular cycles'),
        value: _pcosMode,
        onChanged: (val) => setState(() => _pcosMode = val),
        activeThumbColor: Colors.pink,
      ),
    );
  }
}

class _PhaseIcon extends StatelessWidget {
  final CyclePhase phase;
  final Color color;
  const _PhaseIcon({required this.phase, required this.color});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (phase) {
      case CyclePhase.menstrual: icon = Icons.water_drop; break;
      case CyclePhase.follicular: icon = Icons.wb_sunny; break;
      case CyclePhase.ovulatory: icon = Icons.favorite; break;
      case CyclePhase.luteal: icon = Icons.nightlight_round; break;
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }
}

class _SymptomChip extends StatefulWidget {
  final String label;
  const _SymptomChip({required this.label});

  @override
  State<_SymptomChip> createState() => _SymptomChipState();
}

class _SymptomChipState extends State<_SymptomChip> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: _selected,
      onSelected: (val) => setState(() => _selected = val),
      selectedColor: Colors.pink.shade100,
      labelStyle: TextStyle(color: _selected ? Colors.pink : Colors.black87),
    );
  }
}

