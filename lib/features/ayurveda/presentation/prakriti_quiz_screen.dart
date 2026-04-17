import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/prakriti_quiz.dart';
import '../domain/ayurveda_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/theme/app_theme.dart';

class PrakritiQuizScreen extends ConsumerStatefulWidget {
  const PrakritiQuizScreen({super.key});

  @override
  ConsumerState<PrakritiQuizScreen> createState() => _PrakritiQuizScreenState();
}

class _PrakritiQuizScreenState extends ConsumerState<PrakritiQuizScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < PrakritiQuizData.questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _finishQuiz() async {
    final result = ref.read(quizProgressProvider.notifier).calculateResult();
    await ref.read(ayurvedaNotifierProvider.notifier).saveQuizResult(result);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProgressProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).languageCode;
    final isHindi = locale == 'hi';

    return Scaffold(
      backgroundColor: Colors.black, // Premium Dark Mode
      body: Stack(
        children: [
          // 1. Background Aura
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 2. Custom Progress Header
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PRAKRITI ASSESSMENT',
                              style: AppTextStyles.caption(true).copyWith(
                                color: Colors.teal,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: (_currentPage + 1) / PrakritiQuizData.questions.length,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                valueColor: const AlwaysStoppedAnimation(Colors.teal),
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${_currentPage + 1}/${PrakritiQuizData.questions.length}',
                        style: AppTextStyles.labelLarge(true).copyWith(color: Colors.teal),
                      ),
                    ],
                  ),
                ),

                // 3. Question PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (idx) => setState(() => _currentPage = idx),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: PrakritiQuizData.questions.length,
                    itemBuilder: (context, qIdx) {
                      final question = PrakritiQuizData.questions[qIdx];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              isHindi ? question.textHi : question.textEn,
                              style: AppTextStyles.h2(true).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 40),
                            ...List.generate(question.options.length, (oIdx) {
                              final option = question.options[oIdx];
                              final isSelected = quizState[qIdx] == oIdx;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: _QuizOptionCard(
                                  text: isHindi ? option.textHi : option.textEn,
                                  isSelected: isSelected,
                                  onTap: () {
                                    HapticFeedback.selectionClick();
                                    ref.read(quizProgressProvider.notifier).selectOption(qIdx, oIdx);
                                    if (qIdx < PrakritiQuizData.questions.length - 1) {
                                      Future.delayed(const Duration(milliseconds: 300), _nextPage);
                                    }
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 4. Navigation Footer
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentPage > 0)
                        TextButton(
                          onPressed: () => _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          ),
                          child: Text(
                            isHindi ? 'पीछे' : 'BACK',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                          ),
                        )
                      else
                        const SizedBox.shrink(),
                      
                      if (_currentPage == PrakritiQuizData.questions.length - 1 && quizState.containsKey(_currentPage))
                        ElevatedButton(
                          onPressed: _finishQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(isHindi ? 'परिणाम देखें' : 'VIEW RESULT'),
                        ),
                    ],
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

class _QuizOptionCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _QuizOptionCard({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.white.withValues(alpha: 0.1),
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Colors.teal.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: -5,
            )
          ] : [],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.bodyLarge(true).copyWith(
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.teal),
          ],
        ),
      ),
    );
  }
}
