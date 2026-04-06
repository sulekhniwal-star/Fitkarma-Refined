import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';

class WeddingPlannerHomeScreen extends ConsumerWidget {
  const WeddingPlannerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planner · वेडिंग प्लानर'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/wedding-planner/setup'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeroSection(),
            const SizedBox(height: 24),
            _FeatureGrid(),
            const SizedBox(height: 24),
            _UpcomingCeremonies(),
            const SizedBox(height: 24),
            _PlanSummary(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB8860B), Color(0xFFD4AF37), Color(0xFFFFD700)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: const Column(
        children: [
          Icon(Icons.auto_awesome, color: Colors.white, size: 40),
          SizedBox(height: 16),
          Text(
            'THE BRIDE\'S JOURNEY',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 3),
          ),
          SizedBox(height: 8),
          Text(
            '30 Days to Forever',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _FeatureGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FeatureItem(
            icon: Icons.fitness_center,
            label: 'Fitness',
            color: Colors.orange,
            onTap: () => context.go('/wedding-planner/fitness'),
          ),
          _FeatureItem(
            icon: Icons.spa,
            label: 'Recovery',
            color: AppColors.teal,
            onTap: () => context.go('/wedding-planner/recovery'),
          ),
          _FeatureItem(
            icon: Icons.shopping_cart,
            label: 'Groceries',
            color: Colors.purple,
            onTap: () => context.go('/wedding-planner/grocery'),
          ),
          _FeatureItem(
            icon: Icons.calendar_today,
            label: 'Ceremonies',
            color: AppColors.secondary,
            onTap: () {
              final now = DateTime.now();
              context.go('/wedding-planner/event/${now.year}-${now.month}-${now.day}');
            },
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FeatureItem({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _UpcomingCeremonies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BilingualText(
          english: 'Upcoming Ceremonies',
          hindi: 'आने वाले समारोह',
          englishStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _EventCard(eventName: 'Mehendi', daysUntil: 6, color: Colors.green),
        _EventCard(eventName: 'Sangeet', daysUntil: 7, color: Colors.purple),
        _EventCard(eventName: 'Baraat', daysUntil: 8, color: Colors.orange),
      ],
    );
  }
}

class _PlanSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withOpacity(0.1)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TODAY\'S FOCUS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            SizedBox(height: 12),
            Text('• Stay hydrated (3L Goal) for skin glow.', style: TextStyle(fontSize: 15)),
            SizedBox(height: 4),
            Text('• Light cardio + core toning (25 mins).', style: TextStyle(fontSize: 15)),
            SizedBox(height: 4),
            Text('• Avoid salt-heavy meals tonight.', style: TextStyle(fontSize: 15)),
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
                    if (val) {
                      _selectedEvents.add(e);
                    } else {
                      _selectedEvents.remove(e);
                    }
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