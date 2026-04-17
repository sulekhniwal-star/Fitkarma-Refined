import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepDoshaQuiz extends ConsumerStatefulWidget {
  const StepDoshaQuiz({super.key});

  @override
  ConsumerState<StepDoshaQuiz> createState() => _StepDoshaQuizState();
}

class _StepDoshaQuizState extends ConsumerState<StepDoshaQuiz> {
  int _currentQuestionIndex = 0;
  bool _showResult = false;

  static const List<Map<String, dynamic>> _questions = [
    {
      'question': 'How would you describe your digestion?',
      'questionHi': 'आपका पाचन कैसा है?',
      'options': [
        ('Irregular, often feel hungry or no appetite', 'अनियमित, अक्सर भूख या भूख नहीं लगना'),
        ('Strong, digest quickly, get hungry often', 'मजबूत, जल्दी पचता है, अक्सर भूख लगती है'),
        ('Slow, feel full for long periods', 'धीमा, लंबे समय तक भरा हुआ महसूस'),
      ],
    },
    {
      'question': 'What\'s your typical energy level throughout the day?',
      'questionHi': 'दिन भर आपकी ऊर्जा का स्तर कैसा रहता है?',
      'options': [
        ('Fluctuating, often feel energetic but sometimes fatigued', 'उतार-चढ़ाव, कभी ऊर्जावान कभी थका हुआ'),
        ('High, consistently energetic', 'उच्च, लगातार ऊर्जावान'),
        ('Steady, but can feel sluggish', 'स्थिर, लेकिन सुस्त लग सकता है'),
      ],
    },
    {
      'question': 'How would you describe your body frame?',
      'questionHi': 'आप अपने शरीर की संरचना का वर्णन कैसे करेंगे?',
      'options': [
        ('Thin, slender, often feel cold', 'पतला, लंबा, अक्सर ठंड लगता है'),
        ('Medium build, warm body temperature', 'मध्यम बनावट, गर्म शरीर का तापमान'),
        ('Stocky, gain weight easily', 'मोटा, आसानी से वजन बढ़ता है'),
      ],
    },
    {
      'question': 'How\'s your skin generally?',
      'questionHi': 'आपकी त्वचा कैसी होती है?',
      'options': [
        ('Dry, rough, prone to cracking', 'शुष्क, खुरदरा, दरारें आती हैं'),
        ('Oily, prone to rashes or acne', 'तेलीय, दाने या जलन होती है'),
        ('Smooth, thick, oily in some areas', 'मुलायम, कुछ जगहों पर तेलीय'),
      ],
    },
    {
      'question': 'How\'s your hair?',
      'questionHi': 'आपके बाल कैसे हैं?',
      'options': [
        ('Thin, dry, curly or wavy', 'पतले, सूखे, घुंघराले या लहरदार'),
        ('Thick, shiny, early greying', 'घने, चमकदार, जल्दी सफेद होते हैं'),
        ('Thick, oily, prone to dandruff', 'मोटे, तेलीय, रूसी होती है'),
      ],
    },
    {
      'question': 'How do you usually sleep?',
      'questionHi': 'आप आमतौर पर कैसे सोते हैं?',
      'options': [
        ('Light sleeper, often wake up', 'हल्की नींद, अक्सर जाग जाते हैं'),
        ('Sound sleeper, sleep deeply', 'गहरी नींद'),
        ('Heavy sleeper, hard to wake up', 'गहरी नींद, जागने में कठिनाई'),
      ],
    },
    {
      'question': 'How would you describe your mood?',
      'questionHi': 'आप अपने मूड का वर्णन कैसे करेंगे?',
      'options': [
        ('Variable, anxious or worried', 'बदलावपूर्ण, चिंतित या परेशान'),
        ('Intense, quick to anger or frustrate', 'तीव्र, जल्दी गुस्सा या निराशा'),
        ('Calm, content, but can feel lazy', 'शांत, संतुष्ट, लेकिन आलसी लग सकता है'),
      ],
    },
    {
      'question': 'How\'s your tendency to gain or lose weight?',
      'questionHi': 'वजन बढ़ने या घटने की प्रवृत्ति कैसी है?',
      'options': [
        ('Hard to gain, easy to lose', 'बढ़ना कठिन, घटना आसान'),
        ('Easy to gain and lose quickly', 'बढ़ना और घटना दोनों आसान'),
        ('Easy to gain, hard to lose', 'बढ़ना आसान, घटना कठिन'),
      ],
    },
    {
      'question': 'How do you react to weather changes?',
      'questionHi': 'मौसम बदलाव पर आपकी प्रतिक्रिया कैसी होती है?',
      'options': [
        ('Dislike cold, prefer warm weather', 'ठंड पसंद नहीं, गर्म मौसम पसंद'),
        ('Dislike heat, prefer cooler weather', 'गर्मी पसंद नहीं, ठंडा मौसम पसंद'),
        ('Comfortable in most weather', 'अधिकांश मौसम में सहज'),
      ],
    },
    {
      'question': 'What\'s your appetite like?',
      'questionHi': 'आपकी भूख कैसी होती है?',
      'options': [
        ('Variable, sometimes forget to eat', 'बदलावपूर्ण, कभी खाना भूल जाते हैं'),
        ('Strong, need to eat frequently', 'मजबूत, बार-बार खाना चाहिए'),
        ('Moderate, can skip meals easily', 'मध्यम, आसानी से भोजन छोड़ सकते हैं'),
      ],
    },
    {
      'question': 'How\'s your mind?',
      'questionHi': 'आपका मन कैसा है?',
      'options': [
        ('Creative, but can overthink', 'सृजनात्मक, लेकिन ज्यादा सोच सकते हैं'),
        ('Sharp, focused, determined', 'तेज, केंद्रित, दृढ़निश्चय'),
        ('Calm, patient, but can be slow', 'शांत, धीरजवान, लेकिन धीमा हो सकता है'),
      ],
    },
    {
      'question': 'How do you prefer to exercise?',
      'questionHi': 'आप व्यायाम कैसे करना पसंद करते हैं?',
      'options': [
        ('Light, gentle activities like yoga, walking', 'हल्की, धीमी गतिविधियां जैसे योग, चलना'),
        ('Intense, competitive workouts', 'तीव्र, प्रतिस्पर्धी व्यायाम'),
        ('Moderate, steady exercises', 'मध्यम, स्थिर व्यायाम'),
      ],
    },
  ];

  void _selectOption(int optionIndex) {
    ref.read(onboardingProvider.notifier).setDoshaAnswer(_currentQuestionIndex, optionIndex);
    
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Calculate and show result
      ref.read(onboardingProvider.notifier).calculateDosha();
      setState(() {
        _showResult = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final textPrimary = isDark ? const Color(0xFFF1F0FF) : const Color(0xFF1A1830);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final divider = isDark ? const Color(0x33FFFFFF) : const Color(0x12000000);
    
    final vataColor = const Color(0xFF7B6FF0);
    final pittaColor = const Color(0xFFFF6B35);
    final kaphaColor = const Color(0xFF00D4B4);

    if (_showResult || state.determinedDosha != null) {
      final dosha = state.determinedDosha ?? DoshaType.balanced;
      
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getDoshaColor(dosha).withValues(alpha: 0.2),
                    _getDoshaColor(dosha).withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Image.asset(
                    _getDoshaAsset(dosha),
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your Dosha',
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dosha.labelEn,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: _getDoshaColor(dosha),
                    ),
                  ),
                  Text(
                    dosha.labelHi,
                    style: TextStyle(
                      fontSize: 18,
                      color: textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getDoshaDescription(dosha),
                    style: TextStyle(
                      fontSize: 14,
                      color: textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Dosha breakdown
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: divider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Elements',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDoshaBar('Vata', _calculateVataPercent(state.doshaAnswers).toDouble(), vataColor, textSecondary),
                  const SizedBox(height: 12),
                  _buildDoshaBar('Pitta', _calculatePittaPercent(state.doshaAnswers).toDouble(), pittaColor, textSecondary),
                  const SizedBox(height: 12),
                  _buildDoshaBar('Kapha', _calculateKaphaPercent(state.doshaAnswers).toDouble(), kaphaColor, textSecondary),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Recommendation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primary.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This helps us personalize your diet, workouts, and lifestyle recommendations.',
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discover Your Nature',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentQuestionIndex + 1}/${_questions.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'अपनी प्रकृति जानें',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: divider,
              valueColor: AlwaysStoppedAnimation<Color>(primary),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 32),
          
          // Question
          Text(
            currentQuestion['question'] as String,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            currentQuestion['questionHi'] as String,
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Options
          ...List.generate((currentQuestion['options'] as List).length, (index) {
            final option = (currentQuestion['options'] as List)[index] as (String, String);
            final isSelected = state.doshaAnswers.length > _currentQuestionIndex && 
                state.doshaAnswers[_currentQuestionIndex] == index;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => _selectOption(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primary.withValues(alpha: 0.15) 
                        : surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primary : divider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? primary : textSecondary,
                            width: 2,
                          ),
                          color: isSelected ? primary : Colors.transparent,
                        ),
                        child: isSelected 
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.$1,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: textPrimary,
                              ),
                            ),
                            Text(
                              option.$2,
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDoshaBar(String label, double percent, Color color, Color textSecondary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 14, color: textSecondary)),
            Text('${percent.toInt()}%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Color _getDoshaColor(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
      case DoshaType.vataPitta:
      case DoshaType.vataKapha:
        return const Color(0xFF7B6FF0);
      case DoshaType.pitta:
      case DoshaType.pittaKapha:
        return const Color(0xFFFF6B35);
      case DoshaType.kapha:
        return const Color(0xFF00D4B4);
      case DoshaType.balanced:
        return const Color(0xFFFFB547);
    }
  }

  String _getDoshaAsset(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
      case DoshaType.vataPitta:
      case DoshaType.vataKapha:
        return 'assets/images/ayurveda/vata.png';
      case DoshaType.pitta:
      case DoshaType.pittaKapha:
        return 'assets/images/ayurveda/pitta.png';
      case DoshaType.kapha:
        return 'assets/images/ayurveda/kapha.png';
      case DoshaType.balanced:
        return 'assets/images/ayurveda/kapha.png';
    }
  }

  IconData _getDoshaIcon(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
      case DoshaType.vataPitta:
      case DoshaType.vataKapha:
        return Icons.air;
      case DoshaType.pitta:
      case DoshaType.pittaKapha:
        return Icons.local_fire_department;
      case DoshaType.kapha:
        return Icons.water_drop;
      case DoshaType.balanced:
        return Icons.balance;
    }
  }

  String _getDoshaDescription(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
        return 'You have a light, creative energy. Focus on routine, warmth, and hydration for balance.';
      case DoshaType.pitta:
        return 'You have a strong, intense energy. Focus on cooling foods, moderation, and stress management.';
      case DoshaType.kapha:
        return 'You have a steady, grounded energy. Focus on stimulation, movement, and light foods.';
      case DoshaType.vataPitta:
        return 'A blend of creative fire and controlled energy. Balance with routine and cooling practices.';
      case DoshaType.vataKapha:
        return 'A mix of creative lightness and grounded stability. Focus on consistent routine and activity.';
      case DoshaType.pittaKapha:
        return 'Strong energy with steady grounding. Balance intense heat with calming practices.';
      case DoshaType.balanced:
        return 'Well-balanced constitution. Maintain harmony with diverse diet and varied exercise.';
    }
  }

int _calculateVataPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int vata = 0;
    for (int i = 0; i < answers.length && i < _questions.length; i++) {
      if (answers[i] == 0) vata++;
    }
    return (vata / _questions.length * 100).round();
  }

  int _calculatePittaPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int pitta = 0;
    for (int i = 0; i < answers.length && i < _questions.length; i++) {
      if (answers[i] == 1) pitta++;
    }
    return (pitta / _questions.length * 100).round();
  }

  int _calculateKaphaPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int kapha = 0;
    for (int i = 0; i < answers.length && i < _questions.length; i++) {
      if (answers[i] == 2) kapha++;
    }
    return (kapha / _questions.length * 100).round();
  }
}