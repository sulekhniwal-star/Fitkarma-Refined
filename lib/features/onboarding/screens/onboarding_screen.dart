import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/health_charts.dart';
import '../../../shared/widgets/badge_widgets.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final int _totalSteps = 6;

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home/dashboard');
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: List.generate(_totalSteps, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= _currentStep 
                          ? const Color(0xFFF97316) 
                          : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (val) => setState(() => _currentStep = val),
                children: [
                  _Step1NameGender(),
                  _Step2BodyMetrics(),
                  _Step3Medical(),
                  _Step4Dosha(),
                  _Step5Language(),
                  _Step6Sync(),
                ],
              ),
            ),
            
            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    IconButton(
                      onPressed: _prevStep,
                      icon: const Icon(Icons.arrow_back),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF97316),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(_currentStep == _totalSteps - 1 ? 'FINISH' : 'NEXT'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Step1NameGender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('TELL US ABOUT YOURSELF', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('This helps us personalize your health insights.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 40),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Display Name',
              hintText: 'e.g., Arjun',
            ),
          ),
          const SizedBox(height: 32),
          const Text('Gender', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: ['Male', 'Female', 'Non-binary', 'Prefer not to say'].map((g) {
              return ChoiceChip(
                label: Text(g),
                selected: g == 'Male',
                onSelected: (_) {},
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          const Text('Date of Birth', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.calendar_today),
            label: const Text('Select Date'),
          ),
        ],
      ),
    );
  }
}

class _Step2BodyMetrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('BODY METRICS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Height', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('175 cm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFF97316))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Weight', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('72 kg', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFF97316))),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('Primary Goal', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _GoalCard(icon: Icons.monitor_weight, label: 'Weight Loss'),
              _GoalCard(icon: Icons.fitness_center, label: 'Muscle Gain'),
              _GoalCard(icon: Icons.bolt, label: 'Endurance'),
              _GoalCard(icon: Icons.spa, label: 'Longevity'),
            ],
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _GoalCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFF97316)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class _Step3Medical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MEDICAL HISTORY', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Diabetes', 'Hypertension', 'PCOS', 'Thyroid', 'Asthma', 'None'].map((c) {
              return FilterChip(
                label: Text(c),
                selected: false,
                onSelected: (_) {},
              );
            }).toList(),
          ),
          const Spacer(),
          const GlassCard(
            glowColor: Colors.amber,
            showGlow: true,
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.amber),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'This data is stored locally and encrypted. We use it to filter diet advice.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Step4Dosha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text('DOSHA ANALYSIS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const Expanded(
            child: Center(
              child: DoshaDonutChart(vata: 40, pitta: 30, kapha: 30),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'You are Vata-dominant',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your metabolic profile suggests a focus on warm, cooked foods and regular routines.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _Step5Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('LANGUAGE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: ['English', 'Hindi', 'Marathi', 'Gujarati', 'Tamil', 'Telugu'].map((l) {
                return ChoiceChip(
                  label: Text(l),
                  selected: l == 'English',
                  onSelected: (_) {},
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Step6Sync extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Text('SYNC & SECURE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          const ABHALinkBadge(isLinked: false),
          const SizedBox(height: 24),
          const TextField(
            decoration: InputDecoration(
              labelText: 'ABHA Number (14 digits)',
              hintText: 'XX-XXXX-XXXX-XXXX',
            ),
          ),
          const Spacer(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.watch, color: Colors.grey),
              SizedBox(width: 12),
              Text('Connect Wearables', style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
