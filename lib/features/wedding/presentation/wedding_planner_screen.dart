import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';

class WeddingPlannerHomeScreen extends ConsumerWidget {
  const WeddingPlannerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planner'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFFFD700)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(Icons.favorite, color: Colors.white, size: 48),
                  const SizedBox(height: 8),
                  const Text('Your Wedding Journey', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('30 days to go', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today\'s Plan', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    const Text('• Breakfast: 400 kcal - Protein rich'),
                    const Text('• Workout: 30 min light cardio'),
                    const Text('• Water: 8 glasses'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Upcoming Events', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _EventCard(eventName: 'Haldi', daysUntil: 5, color: Colors.yellow),
                    _EventCard(eventName: 'Mehendi', daysUntil: 6, color: Colors.green),
                    _EventCard(eventName: 'Sangeet', daysUntil: 7, color: Colors.purple),
                    _EventCard(eventName: 'Wedding Day', daysUntil: 30, color: Colors.red),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String eventName;
  final int daysUntil;
  final Color color;

  const _EventCard({required this.eventName, required this.daysUntil, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(eventName)),
          Text('$daysUntil days', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}

class WeddingSetupScreen extends ConsumerStatefulWidget {
  const WeddingSetupScreen({super.key});

  @override
  ConsumerState<WeddingSetupScreen> createState() => _WeddingSetupScreenState();
}

class _WeddingSetupScreenState extends ConsumerState<WeddingSetupScreen> {
  int _step = 0;
  String _role = 'bride';
  DateTimeRange? _dateRange;
  final List<String> _selectedEvents = [];
  int _prepWeeks = 4;
  String _primaryGoal = 'look_best';

  final List<String> _availableEvents = ['Haldi', 'Mehendi', 'Sangeet', 'Baraat', 'Vivah', 'Reception'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Wedding Plan')),
      body: Stepper(
        currentStep: _step,
        onStepContinue: () {
          if (_step < 5) {
            setState(() => _step++);
          } else {
            _savePlan();
          }
        },
        onStepCancel: () {
          if (_step > 0) setState(() => _step--);
        },
        steps: [
          Step(
            title: const Text('Role'),
            content: Column(
              children: [
                _RoleOption(role: 'bride', label: 'Bride', icon: Icons.face_6, selected: _role == 'bride', onTap: () => setState(() => _role = 'bride')),
                _RoleOption(role: 'groom', label: 'Groom', icon: Icons.face_5, selected: _role == 'groom', onTap: () => setState(() => _role = 'groom')),
                _RoleOption(role: 'guest', label: 'Guest', icon: Icons.people, selected: _role == 'guest', onTap: () => setState(() => _role = 'guest')),
                _RoleOption(role: 'relative', label: 'Relative', icon: Icons.family_restroom, selected: _role == 'relative', onTap: () => setState(() => _role = 'relative')),
              ],
            ),
            isActive: _step >= 0,
          ),
          Step(
            title: const Text('Dates'),
            content: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 730)),
                    );
                    if (picked != null) setState(() => _dateRange = picked);
                  },
                  child: Text(_dateRange == null ? 'Select Wedding Date Range' : '${_dateRange!.start.day}/${_dateRange!.start.month} - ${_dateRange!.end.day}/${_dateRange!.end.month}'),
                ),
              ],
            ),
            isActive: _step >= 1,
          ),
          Step(
            title: const Text('Events'),
            content: Wrap(
              spacing: 8,
              children: _availableEvents.map((e) => FilterChip(
                label: Text(e),
                selected: _selectedEvents.contains(e),
                onSelected: (val) {
                  setState(() {
                    if (val) _selectedEvents.add(e);
                    else _selectedEvents.remove(e);
                  });
                },
              )).toList(),
            ),
            isActive: _step >= 2,
          ),
          Step(
            title: const Text('Prep Time'),
            content: DropdownButton<int>(
              value: _prepWeeks,
              items: [1, 2, 4, 8, 12].map((w) => DropdownMenuItem(value: w, child: Text('$w weeks prep'))).toList(),
              onChanged: (val) => setState(() => _prepWeeks = val!),
            ),
            isActive: _step >= 3,
          ),
          Step(
            title: const Text('Primary Goal'),
            content: Column(
              children: [
                _GoalOption(goal: 'look_best', label: 'Look My Best (Glow)', selected: _primaryGoal == 'look_best', onTap: () => setState(() => _primaryGoal = 'look_best')),
                _GoalOption(goal: 'energy', label: 'High Energy (Dance)', selected: _primaryGoal == 'energy', onTap: () => setState(() => _primaryGoal = 'energy')),
                _GoalOption(goal: 'stress_manage', label: 'Stress Management', selected: _primaryGoal == 'stress_manage', onTap: () => setState(() => _primaryGoal = 'stress_manage')),
              ],
            ),
            isActive: _step >= 4,
          ),
          Step(
            title: const Text('Review'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Role: $_role'),
                Text('Events: ${_selectedEvents.join(", ")}'),
                if (_dateRange != null) Text('Dates: ${_dateRange!.start.toLocal()} to ${_dateRange!.end.toLocal()}'),
                Text('Prep: $_prepWeeks weeks'),
              ],
            ),
            isActive: _step >= 5,
          ),
        ],
      ),
    );
  }

  void _savePlan() async {
    if (_dateRange == null) return;
    
    final db = ref.read(databaseProvider);
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    final id = const Uuid().v4();
    await db.weddingEventsDao.into(db.weddingEvents).insert(
      WeddingEventsCompanion.insert(
        id: id,
        userId: user.$id,
        role: _role,
        startDate: _dateRange!.start,
        endDate: _dateRange!.end,
        prepWeeks: Value(_prepWeeks),
        eventsList: json.encode(_selectedEvents),
        primaryGoal: _primaryGoal,
        createdAt: DateTime.now(),
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Wedding plan saved!')),
      );
      Navigator.pop(context);
    }
  }
}

class _RoleOption extends StatelessWidget {
  final String role;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleOption({required this.role, required this.label, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : null),
      title: Text(label),
      trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}

class _GoalOption extends StatelessWidget {
  final String goal;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GoalOption({required this.goal, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}