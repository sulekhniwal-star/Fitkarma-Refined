import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen4 extends ConsumerStatefulWidget {
  const OnboardingScreen4({super.key});

  @override
  ConsumerState<OnboardingScreen4> createState() => _OnboardingScreen4State();
}

class _OnboardingScreen4State extends ConsumerState<OnboardingScreen4> {
  int _currentQuestion = 0;
  final Map<int, String> _answers = {};

  final List<Map<String, dynamic>> _questions = [
    {
      'question': {
        'en': 'How would you describe your body frame?',
        'hi': 'आप अपने शरीर का वर्णन कैसे करेंगे?',
      },
      'options': {
        'en': [
          ('vata', 'Thin, slender, tall'),
          ('pitta', 'Medium, well-built'),
          ('kapha', 'Stocky, broad, solid'),
        ],
        'hi': [
          ('vata', 'पतला, लंबा'),
          ('pitta', 'मध्यम, अच्छी तरह बना हुआ'),
          ('kapha', 'मोटा, चौड़ा'),
        ],
      },
    },
    {
      'question': {
        'en': 'How is your skin usually?',
        'hi': 'आपकी त्वचा सामान्यतः कैसी होती है?',
      },
      'options': {
        'en': [
          ('vata', 'Dry, rough, cold'),
          ('pitta', 'Oily, warm, sensitive'),
          ('kapha', 'Smooth, oily, cool'),
        ],
        'hi': [
          ('vata', 'सूखी, खुरदरी, ठंडी'),
          ('pitta', 'तेलीय, गर्म, संवेदनशील'),
          ('kapha', 'चिकना, तेलीय, ठंडा'),
        ],
      },
    },
    {
      'question': {
        'en': 'How do you usually feel in cold weather?',
        'hi': 'आप सामान्यतः ठंडे मौसम में कैसा महसूस करते हैं?',
      },
      'options': {
        'en': [
          ('vata', 'Feel cold easily'),
          ('pitta', 'Comfortable'),
          ('kapha', 'Comfortable but prefer warmth'),
        ],
        'hi': [
          ('vata', 'आसानी से ठंड लगती है'),
          ('pitta', 'सुखद महसूस होता है'),
          ('kapha', 'सुखद लेकिन गर्मी पसंद करते हैं'),
        ],
      },
    },
    {
      'question': {
        'en': 'How is your appetite?',
        'hi': 'आपकी भूख कैसी होती है?',
      },
      'options': {
        'en': [
          ('vata', 'Irregular, often forget to eat'),
          ('pitta', 'Strong, can get hungry'),
          ('kapha', 'Steady, can skip meals'),
        ],
        'hi': [
          ('vata', 'अनियमित, अक्सर खाना भूल जाते हैं'),
          ('pitta', 'मजबूत, भूख लग सकती है'),
          ('kapha', 'स्थिर, भोजन छोड़ सकते हैं'),
        ],
      },
    },
    {
      'question': {
        'en': 'How would you describe your energy levels?',
        'hi': 'आप अपने ऊर्जा स्तर का वर्णन कैसे करेंगे?',
      },
      'options': {
        'en': [
          ('vata', 'Quick bursts, then tired'),
          ('pitta', 'Steady and strong'),
          ('kapha', 'Slow but consistent'),
        ],
        'hi': [
          ('vata', 'जल्दी थक जाते हैं'),
          ('pitta', 'स्थिर और मजबूत'),
          ('kapha', 'धीमे लेकिन निरंतर'),
        ],
      },
    },
    {
      'question': {
        'en': 'How do you handle stress?',
        'hi': 'आप तनाव को कैसे संभालते हैं?',
      },
      'options': {
        'en': [
          ('vata', 'Get anxious, overthink'),
          ('pitta', 'Get angry, frustrated'),
          ('kapha', 'Stay calm, withdraw'),
        ],
        'hi': [
          ('vata', 'चिंतित हो जाते हैं, ज्यादा सोचते हैं'),
          ('pitta', 'गुस्सा, निराश'),
          ('kapha', 'शांत रहते हैं, अलग हो जाते हैं'),
        ],
      },
    },
    {
      'question': {
        'en': 'How is your sleep pattern?',
        'hi': 'आपका नींद का पैटर्न कैसा है?',
      },
      'options': {
        'en': [
          ('vata', 'Light, often insomnia'),
          ('pitta', 'Moderate, sometimes deep'),
          ('kapha', 'Deep, can oversleep'),
        ],
        'hi': [
          ('vata', 'हल्का, अक्सर अनिद्रा'),
          ('pitta', 'मध्यम, कभी-कभी गहरी'),
          ('kapha', 'गहरी, ज्यादा सो सकते हैं'),
        ],
      },
    },
    {
      'question': {
        'en': 'How do you make decisions?',
        'hi': 'आप निर्णय कैसे लेते हैं?',
      },
      'options': {
        'en': [
          ('vata', 'Quick, impulsive'),
          ('pitta', 'Decisive, authoritative'),
          ('kapha', 'Slow, thoughtful'),
        ],
        'hi': [
          ('vata', 'जल्दी, आवेगी'),
          ('pitta', 'निर्णायक, अधिकारी'),
          ('kapha', 'धीमा, विचारशील'),
        ],
      },
    },
    {
      'question': {
        'en': 'How is your memory?',
        'hi': 'आपकी स्मृति कैसी है?',
      },
      'options': {
        'en': [
          ('vata', 'Quick to learn, quick to forget'),
          ('pitta', 'Good, focused'),
          ('kapha', 'Slow but long-lasting'),
        ],
        'hi': [
          ('vata', 'जल्दी सीखते, जल्दी भूलते हैं'),
          ('pitta', 'अच्छी, केंद्रित'),
          ('kapha', 'धीमे लेकिन लंबे समय तक याद'),
        ],
      },
    },
    {
      'question': {
        'en': 'How do you prefer to exercise?',
        'hi': 'आप व्यायाम कैसे पसंद करते हैं?',
      },
      'options': {
        'en': [
          ('vata', 'Varied, light activities'),
          ('pitta', 'Intense, competitive'),
          ('kapha', 'Slow, steady routines'),
        ],
        'hi': [
          ('vata', 'विविध, हल्की गतिविधियां'),
          ('pitta', 'तीव्र, प्रतिस्पर्धात्मक'),
          ('kapha', 'धीमे, स्थिर दिनचर्या'),
        ],
      },
    },
    {
      'question': {
        'en': 'How would your friends describe your personality?',
        'hi': 'आपके मित्र आपके व्यक्तित्व का वर्णन कैसे करेंगे?',
      },
      'options': {
        'en': [
          ('vata', 'Creative, energetic, talkative'),
          ('pitta', 'Ambitious, focused, bold'),
          ('kapha', 'Calm, patient, reliable'),
        ],
        'hi': [
          ('vata', 'रचनात्मक, ऊर्जावान, बातूनी'),
          ('pitta', 'महत्वाकांक्षी, केंद्रित, बहादुर'),
          ('kapha', 'शांत, धैर्यवान, विश्वसनीय'),
        ],
      },
    },
    {
      'question': {
        'en': 'How often do you feel thirsty?',
        'hi': 'आप को प्यास लगने की कितनी बार होती है?',
      },
      'options': {
        'en': [
          ('vata', 'Frequent, small sips'),
          ('pitta', 'Moderate, prefer cold drinks'),
          ('kapha', 'Rarely, prefer warm drinks'),
        ],
        'hi': [
          ('vata', 'बार-बार, छोटे घूंट'),
          ('pitta', 'मध्यम, ठंडे पेय पसंद'),
          ('kapha', 'कम, गर्म पेय पसंद'),
        ],
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    final isComplete = _currentQuestion >= _questions.length;

    if (isComplete) {
      return _buildResultsScreen(isHindi);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'आयुर्वेद दोष प्रश्नोत्तरी' : 'Ayurveda Dosha Quiz'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${isHindi ? 'प्रश्न' : 'Question'} ${_currentQuestion + 1}/${_questions.length}',
                    style: AppTextStyles.labelLarge.copyWith(color: AppColors.primary),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => _calculateAndProceed(isHindi),
                    child: Text(
                      isHindi ? 'छोड़ें' : 'Skip',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                ],
              ),
              LinearProgressIndicator(
                value: (_currentQuestion + 1) / _questions.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              const SizedBox(height: 24),
              Text(
                _questions[_currentQuestion]['question'][isHindi ? 'hi' : 'en'],
                style: AppTextStyles.headlineSmall,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: (_questions[_currentQuestion]['options'][isHindi ? 'hi' : 'en'] as List)
                      .map((opt) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _selectOption(opt.$1, isHindi),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            opt.$2,
                            style: AppTextStyles.bodyLarge,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  if (_currentQuestion > 0)
                    OutlinedButton(
                      onPressed: () => setState(() => _currentQuestion--),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                      child: Text(isHindi ? 'पीछे' : 'Back'),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => _calculateAndProceed(isHindi),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      _currentQuestion == _questions.length - 1
                          ? (isHindi ? 'परिणाम दिखाएं' : 'See Results')
                          : (isHindi ? 'आगे बढ़ें' : 'Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectOption(String dosha, bool isHindi) {
    setState(() {
      _answers[_currentQuestion] = dosha;
    });
    if (_currentQuestion < _questions.length - 1) {
      setState(() => _currentQuestion++);
    } else {
      _calculateAndProceed(isHindi);
    }
  }

  void _calculateAndProceed(bool isHindi) {
    int vata = 0, pitta = 0, kapha = 0;
    for (final answer in _answers.values) {
      if (answer == 'vata') vata++;
      if (answer == 'pitta') pitta++;
      if (answer == 'kapha') kapha++;
    }

    final total = vata + pitta + kapha;
    if (total > 0) {
      vata = ((vata / total) * 100).round();
      pitta = ((pitta / total) * 100).round();
      kapha = ((kapha / total) * 100).round();

      final remainder = 100 - (vata + pitta + kapha);
      if (vata >= pitta && vata >= kapha) {
        vata += remainder;
      } else if (pitta >= kapha) {
        pitta += remainder;
      } else {
        kapha += remainder;
      }
    }

    ref.read(onboardingStateProvider.notifier).updateDosha(vata, pitta, kapha);
    setState(() {
      _currentQuestion = _questions.length;
    });
  }

  Widget _buildResultsScreen(bool isHindi) {
    final state = ref.watch(onboardingStateProvider);
    final dominant = state.vataPercent >= state.pittaPercent && state.vataPercent >= state.kaphaPercent
        ? 'Vata'
        : state.pittaPercent >= state.kaphaPercent
            ? 'Pitta'
            : 'Kapha';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'आपका दोष प्रोफाइल' : 'Your Dosha Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                width: 200,
                child: _buildDonutChart(state.vataPercent, state.pittaPercent, state.kaphaPercent),
              ),
              const SizedBox(height: 24),
              Text(
                isHindi ? 'प्रमुख दोष:' : 'Dominant Dosha:',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                dominant,
                style: AppTextStyles.displaySmall.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildDoshaCard('Vata', state.vataPercent, Colors.orange, isHindi),
                  _buildDoshaCard('Pitta', state.pittaPercent, Colors.red, isHindi),
                  _buildDoshaCard('Kapha', state.kaphaPercent, Colors.green, isHindi),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestion = 0;
                        _answers.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    child: Text(isHindi ? 'पुनः प्रयास करें' : 'Retake'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => context.go('/onboarding/5'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      isHindi ? 'आगे बढ़ें' : 'Continue',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonutChart(int vata, int pitta, int kapha) {
    return CustomPaint(
      painter: _DonutChartPainter(vata, pitta, kapha),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.spa, size: 32, color: AppColors.primary),
            const SizedBox(height: 4),
            Text('Ayurveda', style: AppTextStyles.labelMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildDoshaCard(String dosha, int percent, Color color, bool isHindi) {
    final descriptions = isHindi
        ? {
            'Vata': 'गति, संवेदना',
            'Pitta': 'चयापचय, ऊर्जा',
            'Kapha': 'संरचना, स्थिरता',
          }
        : {
            'Vata': 'Movement',
            'Pitta': 'Metabolism',
            'Kapha': 'Structure',
          };

    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color, width: 3),
          ),
          child: Center(
            child: Text(
              '$percent%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(dosha, style: AppTextStyles.labelLarge),
        Text(
          descriptions[dosha]!,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final int vata, pitta, kapha;

  _DonutChartPainter(this.vata, this.pitta, this.kapha);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final strokeWidth = 30.0;

    final colors = [Colors.orange, Colors.red, Colors.green];
    final percents = [vata, pitta, kapha];

    double startAngle = -90;
    for (int i = 0; i < 3; i++) {
      if (percents[i] > 0) {
        final sweepAngle = (percents[i] / 100) * 360;
        final paint = Paint()
          ..color = colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle * (3.14159 / 180),
          sweepAngle * (3.14159 / 180),
          false,
          paint,
        );
        startAngle += sweepAngle;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}