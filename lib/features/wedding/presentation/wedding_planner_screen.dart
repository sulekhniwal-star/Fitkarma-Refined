import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class WeddingSetupScreen extends StatefulWidget {
  const WeddingSetupScreen({super.key});

  @override
  State<WeddingSetupScreen> createState() => _WeddingSetupScreenState();
}

class _WeddingSetupScreenState extends State<WeddingSetupScreen> {
  int _step = 0;
  String _role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set Up Wedding Plan')),
      body: Stepper(
        currentStep: _step,
        onStepContinue: () {
          if (_step < 5) setState(() => _step++);
        },
        onStepCancel: () {
          if (_step > 0) setState(() => _step--);
        },
        steps: [
          Step(
            title: const Text('Select Role'),
            content: Column(
              children: [
                _RoleOption(role: 'Bride', icon: Icons.face_6, selected: _role == 'Bride', onTap: () => setState(() => _role = 'Bride')),
                _RoleOption(role: 'Groom', icon: Icons.face_5, selected: _role == 'Groom', onTap: () => setState(() => _role = 'Groom')),
                _RoleOption(role: 'Guest', icon: Icons.people, selected: _role == 'Guest', onTap: () => setState(() => _role = 'Guest')),
                _RoleOption(role: 'Relative', icon: Icons.family_restroom, selected: _role == 'Relative', onTap: () => setState(() => _role = 'Relative')),
              ],
            ),
            isActive: _step >= 0,
          ),
          const Step(title: Text('Wedding Date'), content: Text('Date picker here')),
          const Step(title: Text('Events'), content: Text('Event selection')),
          const Step(title: Text('Prep Time'), content: Text('Weeks selection')),
          const Step(title: Text('Goal'), content: Text('Goal selection')),
          const Step(title: Text('Confirm'), content: Text('Summary')),
        ],
      ),
    );
  }
}

class _RoleOption extends StatelessWidget {
  final String role;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _RoleOption({required this.role, required this.icon, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : null),
      title: Text(role),
      trailing: selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}