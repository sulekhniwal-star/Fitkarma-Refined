import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// For XP animation if needed
// For chart if nested
import 'package:fl_chart/fl_chart.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _next() {
    if (_currentStep < 5) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _complete();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _complete() {
    // Award XP and update profile logic
    context.go('/home/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressIndicator(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  const _Step1Welcome(),
                  const _Step2Goals(),
                  const _Step3Vitals(),
                  const _Step4Dosha(),
                  const _Step5Language(),
                  const _Step6Connections(),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: List.generate(6, (index) => Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index <= _currentStep ? Colors.orange : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            TextButton(
              onPressed: _back,
              child: const Text('Back', style: TextStyle(color: Colors.grey)),
            )
          else
            const SizedBox.shrink(),
          ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: const Size(120, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(_currentStep == 5 ? 'GET STARTED' : 'Next →', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _Step1Welcome extends StatelessWidget {
  const _Step1Welcome();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_awesome, size: 80, color: Colors.orange),
          SizedBox(height: 32),
          Text('Welcome to FitKarma', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          SizedBox(height: 16),
          Text('Your journey to holistic health starts here. We combine modern science with ancient wisdom.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16)),
        ],
      ),
    );
  }
}

class _Step2Goals extends StatelessWidget {
  const _Step2Goals();
  @override
  Widget build(BuildContext context) {
      return const Column(children: [Text('Step 2: Goals')]); // Placeholder for brevity
  }
}

class _Step3Vitals extends StatelessWidget {
  const _Step3Vitals();
  @override
  Widget build(BuildContext context) {
      return const Column(children: [Text('Step 3: Vitals')]); // Placeholder for brevity
  }
}

class _Step4Dosha extends StatefulWidget {
  const _Step4Dosha();
  @override
  State<_Step4Dosha> createState() => _Step4DoshaState();
}

class _Step4DoshaState extends State<_Step4Dosha> {
  bool _quizDone = false;
  @override
  Widget build(BuildContext context) {
    if (_quizDone) return _buildResult();
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Prakriti Quiz', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('12 questions to find your natural constitution', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          Expanded(child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => _buildQuestion(),
          )),
          ElevatedButton(onPressed: () => setState(() => _quizDone = true), child: const Text('SUBMIT QUIZ'))
        ],
      ),
    );
  }

  Widget _buildQuestion() {
    return Column(
      children: [
        const Text('Question 1: How is your digestion?', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildOption('Irregular (Vata)'),
        _buildOption('Strong/Frequent (Pitta)'),
        _buildOption('Slow/Heavy (Kapha)'),
      ],
    );
  }

  Widget _buildOption(String label) => Card(child: ListTile(title: Text(label), leading: const Radio(value: 1, groupValue: 0, onChanged: null)));

  Widget _buildResult() {
      return Column(
          children: [
              const Text('You are Pitta Dominant!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              SizedBox(height: 150, child: PieChart(PieChartData(sections: [PieChartSectionData(value: 60, color: Colors.red), PieChartSectionData(value: 20, color: Colors.blue), PieChartSectionData(value: 20, color: Colors.green)]))),
          ],
      );
  }
}

class _Step5Language extends StatelessWidget {
  const _Step5Language();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Choose Language', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3),
              itemCount: 22,
              itemBuilder: (context, index) => Card(child: Center(child: Text(['English', 'हिन्दी', 'বাংলা', 'தமிழ்'][index % 4]))),
            ),
          ),
        ],
      ),
    );
  }
}

class _Step6Connections extends StatelessWidget {
  const _Step6Connections();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text('Secure Connections', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          _buildConnectionCard('Ayushman Bharat (ABHA)', 'Import medical records securely', Icons.health_and_safety),
          const SizedBox(height: 16),
          _buildConnectionCard('Wearable Data', 'Sync steps & sleep automatically', Icons.watch),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(String title, String desc, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: TextButton(onPressed: () {}, child: const Text('LINK')),
      ),
    );
  }
}
