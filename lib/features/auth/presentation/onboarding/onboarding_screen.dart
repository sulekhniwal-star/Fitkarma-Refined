import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  String? _selectedGoal;
  double _height = 170;
  double _weight = 70;
  String _gender = 'Male';
  final Set<String> _conditions = {};
  int _doshaAnswer = -1;
  bool _quizComplete = false;
  String _selectedLanguage = 'English';
  bool _abhaLinked = false;
  bool _wearableLinked = false;

  final List<Map<String, dynamic>> _goals = [
    {'icon': Icons.fitness_center, 'label': 'Build Strength'},
    {'icon': Icons.trending_down, 'label': 'Lose Weight'},
    {'icon': Icons.spa, 'label': 'Improve Wellness'},
    {'icon': Icons.directions_run, 'label': 'Boost Stamina'},
  ];

  final List<String> _chronicConditions = [
    'Diabetes', 'Hypertension', 'PCOD/PCOS', 'Hypothyroid', 'Asthma', 'Heart Disease',
  ];

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
    context.go('/home/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? const Color(0xFFFF7043) : const Color(0xFFFF5722);
    final background = isDark ? const Color(0xFF121218) : const Color(0xFFFDF6EC);
    final textPrimary = isDark ? const Color(0xFFF0EEF8) : const Color(0xFF1A1A2E);
    final textSecondary = isDark ? const Color(0xFF9D9BBC) : const Color(0xFF6B6B8A);
    final divider = isDark ? const Color(0xFF2C2C3E) : const Color(0xFFEEE8E4);
    final surface = isDark ? const Color(0xFF1E1E2C) : Colors.white;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: List.generate(6, (index) => Expanded(
                  child: Container(
                    height: 6,
                    margin: EdgeInsets.only(left: index == 0 ? 0 : 2, right: index == 5 ? 0 : 2),
                    decoration: BoxDecoration(
                      color: index <= _currentStep ? primary : divider,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                )),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentStep = i),
                children: [
                  _Step1(textPrimary: textPrimary, textSecondary: textSecondary, primary: primary),
                  _Step2(textPrimary: textPrimary, textSecondary: textSecondary, divider: divider, surface: surface, primary: primary, selectedGoal: _selectedGoal, goals: _goals, onSelect: (g) => setState(() => _selectedGoal = g)),
                  _Step3(textPrimary: textPrimary, textSecondary: textSecondary, divider: divider, surface: surface, primary: primary, height: _height, weight: _weight, gender: _gender, conditions: _conditions, chronicConditions: _chronicConditions, onHeightChange: (h) => setState(() => _height = h), onWeightChange: (w) => setState(() => _weight = w), onGenderChange: (g) => setState(() => _gender = g), onConditionToggle: (c) => setState(() { if (_conditions.contains(c)) {
                    _conditions.remove(c);
                  } else {
                    _conditions.add(c);
                  } })),
                  _Step4(textPrimary: textPrimary, textSecondary: textSecondary, divider: divider, surface: surface, primary: primary, answer: _doshaAnswer, quizComplete: _quizComplete, onAnswer: (a) => setState(() => _doshaAnswer = a), onSubmit: () => setState(() => _quizComplete = true)),
                  _Step5(textPrimary: textPrimary, textSecondary: textSecondary, divider: divider, surface: surface, primary: primary, selectedLanguage: _selectedLanguage, onSelect: (l) => setState(() => _selectedLanguage = l)),
                  _Step6(textPrimary: textPrimary, textSecondary: textSecondary, divider: divider, surface: surface, primary: primary, abhaLinked: _abhaLinked, wearableLinked: _wearableLinked, onAbhaToggle: () => setState(() => _abhaLinked = !_abhaLinked), onWearableToggle: () => setState(() => _wearableLinked = !_wearableLinked)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentStep > 0)
                    TextButton(onPressed: _back, child: Text('Back', style: TextStyle(color: textSecondary)))
                  else
                    const SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(backgroundColor: primary, minimumSize: const Size(140, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text(_currentStep == 5 ? 'GET STARTED' : 'Next', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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

class _Step1 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color primary;
  const _Step1({required this.textPrimary, required this.textSecondary, required this.primary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/onboarding/hero.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text('Welcome to FitKarma', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('स्वागत है', style: TextStyle(fontSize: 14, color: textSecondary)),
          const SizedBox(height: 16),
          Text('Your journey to holistic health.\nModern science meets ancient wisdom.', style: TextStyle(fontSize: 16, color: textSecondary), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _Step2 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color surface;
  final Color primary;
  final String? selectedGoal;
  final List<Map<String, dynamic>> goals;
  final Function(String) onSelect;
  const _Step2({required this.textPrimary, required this.textSecondary, required this.divider, required this.surface, required this.primary, required this.selectedGoal, required this.goals, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Goal', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary)),
          Text('आपका लक्ष्य', style: TextStyle(fontSize: 12, color: textSecondary)),
          const SizedBox(height: 32),
          Expanded(child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 1),
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              final isSelected = selectedGoal == goal['label'];
              return GestureDetector(
                onTap: () => onSelect(goal['label'] as String),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isSelected ? primary.withValues(alpha: 0.15) : surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isSelected ? primary : divider, width: isSelected ? 2 : 1),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(goal['icon'], size: 36, color: isSelected ? primary : textSecondary),
                    const SizedBox(height: 12),
                    Text(goal['label'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary), textAlign: TextAlign.center),
                  ]),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

class _Step3 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color surface;
  final Color primary;
  final double height;
  final double weight;
  final String gender;
  final Set<String> conditions;
  final List<String> chronicConditions;
  final Function(double) onHeightChange;
  final Function(double) onWeightChange;
  final Function(String) onGenderChange;
  final Function(String) onConditionToggle;
  const _Step3({required this.textPrimary, required this.textSecondary, required this.divider, required this.surface, required this.primary, required this.height, required this.weight, required this.gender, required this.conditions, required this.chronicConditions, required this.onHeightChange, required this.onWeightChange, required this.onGenderChange, required this.onConditionToggle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About You', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary)),
          Text('आपके बारे में', style: TextStyle(fontSize: 12, color: textSecondary)),
          const SizedBox(height: 24),
          Text('Gender', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: ChoiceChip(label: const Text('Male'), selected: gender == 'Male', onSelected: (_) => onGenderChange('Male'), selectedColor: primary)),
            const SizedBox(width: 8),
            Expanded(child: ChoiceChip(label: const Text('Female'), selected: gender == 'Female', onSelected: (_) => onGenderChange('Female'), selectedColor: primary)),
            const SizedBox(width: 8),
            Expanded(child: ChoiceChip(label: const Text('Other'), selected: gender == 'Other', onSelected: (_) => onGenderChange('Other'), selectedColor: primary)),
          ]),
          const SizedBox(height: 24),
          Text('Height: ${height.toInt()} cm', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary)),
          Slider(value: height, min: 120, max: 220, onChanged: onHeightChange, activeColor: primary),
          const SizedBox(height: 16),
          Text('Weight: ${weight.toInt()} kg', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary)),
          Slider(value: weight, min: 30, max: 200, onChanged: onWeightChange, activeColor: primary),
          const SizedBox(height: 24),
          Text('Any chronic conditions?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary)),
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: chronicConditions.map((c) => FilterChip(label: Text(c), selected: conditions.contains(c), onSelected: (_) => onConditionToggle(c), selectedColor: primary)).toList()),
        ],
      ),
    );
  }
}

class _Step4 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color surface;
  final Color primary;
  final int answer;
  final bool quizComplete;
  final Function(int) onAnswer;
  final VoidCallback onSubmit;
  const _Step4({required this.textPrimary, required this.textSecondary, required this.divider, required this.surface, required this.primary, required this.answer, required this.quizComplete, required this.onAnswer, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    if (quizComplete) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset('assets/images/ayurveda/pitta.png', height: 180),
            ),
            const SizedBox(height: 32),
            Text('Your Dosha', style: TextStyle(fontSize: 20, color: textSecondary), textAlign: TextAlign.center),
            Text('Pitta Dominant', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
              child: Text('Your metabolism is strong and energetic.\nFire and water are your core elements.', style: TextStyle(fontSize: 14, color: textPrimary), textAlign: TextAlign.center),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Discover Your Nature', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary)),
          Text('अपनी प्रकृति जानें', style: TextStyle(fontSize: 12, color: textSecondary)),
          const SizedBox(height: 32),
          Text('How is your digestion?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary)),
          const SizedBox(height: 16),
          _buildOption(0, 'Irregular (Vata)', 'Often feel hungry or no appetite'),
          _buildOption(1, 'Strong/Frequent (Pitta)', 'Digest quickly, get hungry often'),
          _buildOption(2, 'Slow/Heavy (Kapha)', 'Feel full for long periods'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: answer >= 0 ? onSubmit : null,
              style: ElevatedButton.styleFrom(backgroundColor: primary, minimumSize: const Size(double.infinity, 50)),
              child: const Text('DISCOVER DOSHA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(int idx, String label, String desc) {
    final isSelected = answer == idx;
    return GestureDetector(
      onTap: () => onAnswer(idx),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primary.withValues(alpha: 0.15) : surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? primary : divider),
        ),
        child: Row(children: [
          Radio(value: idx, groupValue: answer, onChanged: (v) { if (v != null) onAnswer(v); }),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: textPrimary)),
            Text(desc, style: TextStyle(fontSize: 12, color: textSecondary)),
          ])),
        ]),
      ),
    );
  }
}

class _Step5 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color surface;
  final Color primary;
  final String selectedLanguage;
  final Function(String) onSelect;
  const _Step5({required this.textPrimary, required this.textSecondary, required this.divider, required this.surface, required this.primary, required this.selectedLanguage, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {'name': 'English', 'script': 'English'},
      {'name': 'हिंदी', 'script': 'Devanagari'},
      {'name': 'বাংলা', 'script': 'Bengali'},
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choose Language', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary)),
          Text('भाषा चुनें', style: TextStyle(fontSize: 12, color: textSecondary)),
          const SizedBox(height: 32),
          Expanded(child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 2.5),
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final lang = languages[index];
              final isSelected = selectedLanguage == lang['name'];
              return GestureDetector(
                onTap: () => onSelect(lang['name'] as String),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? primary.withValues(alpha: 0.15) : surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isSelected ? primary : divider, width: isSelected ? 2 : 1),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(lang['script'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary)),
                    Text(lang['name'] as String, style: TextStyle(fontSize: 11, color: textSecondary)),
                  ]),
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}

class _Step6 extends StatelessWidget {
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color surface;
  final Color primary;
  final bool abhaLinked;
  final bool wearableLinked;
  final VoidCallback onAbhaToggle;
  final VoidCallback onWearableToggle;
  const _Step6({required this.textPrimary, required this.textSecondary, required this.divider, required this.surface, required this.primary, required this.abhaLinked, required this.wearableLinked, required this.onAbhaToggle, required this.onWearableToggle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Connect Health ID', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textPrimary)),
          Text('स्वास्थ्य ID', style: TextStyle(fontSize: 12, color: textSecondary)),
          const SizedBox(height: 32),
          _buildCard('ABHA Health ID', 'Import medical records securely', Icons.health_and_safety, abhaLinked, onAbhaToggle),
          const SizedBox(height: 16),
          _buildCard('Wearable', 'Sync steps & sleep automatically', Icons.watch, wearableLinked, onWearableToggle),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: divider, borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              Icon(Icons.lock, size: 16, color: textSecondary),
              const SizedBox(width: 12),
              Expanded(child: Text('Your data is encrypted and stored locally.', style: TextStyle(fontSize: 12, color: textSecondary))),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String desc, IconData icon, bool isLinked, VoidCallback onToggle) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: isLinked ? primary : divider)),
        child: Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: primary)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: textPrimary)),
            Text(desc, style: TextStyle(fontSize: 12, color: textSecondary)),
          ])),
          Text(isLinked ? 'Linked' : 'Link', style: TextStyle(fontWeight: FontWeight.w600, color: isLinked ? primary : textPrimary)),
        ]),
      ),
    );
  }
}
