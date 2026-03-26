// lib/features/mental_health/data/cbt_program_service.dart
// CBT-Lite Stress Program - 7-day program with prompts tied to user's actual logged data

import 'package:fitkarma/core/storage/drift_database.dart';

/// CBT Program Day Structure
class CbtProgramDay {
  final int dayNumber;
  final String title;
  final String theme;
  final String description;
  final List<CbtActivity> activities;
  final CbtPrompt prompt;

  CbtProgramDay({
    required this.dayNumber,
    required this.title,
    required this.theme,
    required this.description,
    required this.activities,
    required this.prompt,
  });
}

/// CBT Activity
class CbtActivity {
  final String id;
  final String title;
  final String description;
  final String duration; // e.g., "5 min"
  final String
  type; // 'reflection', 'exercise', 'breathing', 'gratitude', 'awareness'
  final String? promptTemplate;

  CbtActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.type,
    this.promptTemplate,
  });
}

/// CBT Prompt - personalized based on user's data
class CbtPrompt {
  final String question;
  final String? contextFromData; // Data-driven context
  final List<String> suggestedResponses;

  CbtPrompt({
    required this.question,
    this.contextFromData,
    required this.suggestedResponses,
  });
}

/// User's CBT Program Progress
class CbtProgramProgress {
  final String id;
  final String userId;
  final DateTime startDate;
  final int currentDay; // 1-7
  final List<DayProgress> dayProgress;
  final CbtProgramStatus status;
  final DateTime? completedDate;
  final BurnoutAnalysisData? burnoutAnalysisAtStart;

  CbtProgramProgress({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.currentDay,
    required this.dayProgress,
    required this.status,
    this.completedDate,
    this.burnoutAnalysisAtStart,
  });
}

/// Day Progress
class DayProgress {
  final int dayNumber;
  final bool completed;
  final DateTime? completedAt;
  final String? reflectionNote;
  final List<String> completedActivities;

  DayProgress({
    required this.dayNumber,
    required this.completed,
    this.completedAt,
    this.reflectionNote,
    required this.completedActivities,
  });
}

/// Program Status
enum CbtProgramStatus { notStarted, inProgress, completed, paused }

/// Indian Mental Health Helpline Resources
class IndianHelplineResources {
  final String name;
  final String description;
  final String phoneNumber;
  final String? alternatePhone;
  final String hours;
  final String language;
  final String type; // 'crisis', 'counselling', 'general'

  const IndianHelplineResources({
    required this.name,
    required this.description,
    required this.phoneNumber,
    this.alternatePhone,
    required this.hours,
    required this.language,
    required this.type,
  });

  static const List<IndianHelplineResources> allResources = [
    IndianHelplineResources(
      name: 'iCall',
      description:
          'Tata Trusts\'s helpline offering free, confidential mental health support. '
          'Professional counselors provide support for stress, anxiety, depression, and other concerns.',
      phoneNumber: '9152987821',
      hours: 'Mon-Sat: 8am-10pm',
      language:
          'Hindi, English, Marathi, Tamil, Telugu, Bengali, Kannada, Malayalam',
      type: 'counselling',
    ),
    IndianHelplineResources(
      name: 'Vandrevala Foundation',
      description:
          '24/7 mental health helpline providing free, confidential support. '
          'Experienced psychologists and psychiatrists offer assistance for various mental health concerns.',
      phoneNumber: '1860 2662 345',
      hours: '24/7',
      language: 'Hindi, English',
      type: 'crisis',
    ),
    IndianHelplineResources(
      name: 'NIMHANS',
      description:
          'National Institute of Mental Health and Neurosciences provides '
          'comprehensive mental health services including crisis support.',
      phoneNumber: '080-4611 0007',
      hours: 'Mon-Fri: 9am-5pm',
      language: 'English, Kannada, Hindi',
      type: 'general',
    ),
    IndianHelplineResources(
      name: 'Aasra',
      description:
          'Crisis helpline for emotional support and suicide prevention. '
          'Volunteers provide empathetic listening and referral services.',
      phoneNumber: '91-22-2754 6669',
      hours: '24/7',
      language: 'English, Hindi',
      type: 'crisis',
    ),
    IndianHelplineResources(
      name: 'Sanjivani',
      description:
          '24/7 mental health support helpline by MPower. '
          'Offers free, confidential counseling for various mental health issues.',
      phoneNumber: '1800-120-2842000',
      hours: '24/7',
      language: 'English, Hindi',
      type: 'counselling',
    ),
  ];
}

/// Burnout analysis data snapshot
class BurnoutAnalysisData {
  final double avgMoodScore;
  final double avgEnergyLevel;
  final double avgSleepDuration;
  final double avgSleepQuality;
  final int consecutiveLowMoodDays;
  final int consecutivePoorSleepDays;
  final int consecutiveLowEnergyDays;
  final List<String> contributingFactors;

  BurnoutAnalysisData({
    required this.avgMoodScore,
    required this.avgEnergyLevel,
    required this.avgSleepDuration,
    required this.avgSleepQuality,
    required this.consecutiveLowMoodDays,
    required this.consecutivePoorSleepDays,
    required this.consecutiveLowEnergyDays,
    required this.contributingFactors,
  });
}

/// CBT Program Service
class CbtProgramService {
  final AppDatabase? db;

  CbtProgramService([this.db]);

  /// Get the full 7-day CBT program
  List<CbtProgramDay> getProgram([BurnoutAnalysisData? analysis]) {
    return [
      _createDay1(analysis),
      _createDay2(analysis),
      _createDay3(analysis),
      _createDay4(analysis),
      _createDay5(analysis),
      _createDay6(analysis),
      _createDay7(analysis),
    ];
  }

  /// Day 1: Awareness & Understanding
  CbtProgramDay _createDay1(BurnoutAnalysisData? analysis) {
    String context = '';
    if (analysis != null) {
      final factors = analysis.contributingFactors;
      if (factors.isNotEmpty) {
        context =
            'Based on your recent logs, you\'ve been experiencing: ${factors.take(3).join(", ")}. ';
      }
    }

    return CbtProgramDay(
      dayNumber: 1,
      title: 'Understanding Your Burnout',
      theme: 'Awareness',
      description:
          'Begin by recognizing the signs of burnout and understanding your current state.',
      activities: [
        CbtActivity(
          id: 'd1_a1',
          title: 'Body Scan Meditation',
          description:
              'A 5-minute guided meditation to help you tune into physical sensations.',
          duration: '5 min',
          type: 'breathing',
        ),
        CbtActivity(
          id: 'd1_a2',
          title: 'Check Your Stats',
          description:
              'Review your mood, sleep, and energy patterns from the past week.',
          duration: '3 min',
          type: 'awareness',
        ),
      ],
      prompt: CbtPrompt(
        question: 'How are you feeling right now, in this moment?',
        contextFromData: context.isNotEmpty
            ? '${context}This awareness is the first step toward recovery.'
            : null,
        suggestedResponses: [
          'I feel exhausted but relieved to be here',
          'I\'m overwhelmed but hopeful',
          'I need someone to talk to',
          'I\'m ready to start my recovery journey',
        ],
      ),
    );
  }

  /// Day 2: Sleep Restoration
  CbtProgramDay _createDay2(BurnoutAnalysisData? analysis) {
    String sleepContext = '';
    if (analysis != null && analysis.avgSleepDuration < 420) {
      sleepContext =
          'Your average sleep has been ${(analysis.avgSleepDuration / 60).toStringAsFixed(1)} hours - below the recommended 7 hours. ';
    }

    return CbtProgramDay(
      dayNumber: 2,
      title: 'Restoring Your Sleep',
      theme: 'Sleep Hygiene',
      description:
          'Focus on improving your sleep quality and establishing healthy bedtime routines.',
      activities: [
        CbtActivity(
          id: 'd2_a1',
          title: 'Sleep Wind-Down Routine',
          description:
              'Create a 30-minute pre-sleep routine to help your body prepare for rest.',
          duration: '10 min',
          type: 'exercise',
        ),
        CbtActivity(
          id: 'd2_a2',
          title: 'Breathing Exercise',
          description:
              '4-7-8 breathing technique to calm your nervous system before bed.',
          duration: '5 min',
          type: 'breathing',
        ),
      ],
      prompt: CbtPrompt(
        question: 'What currently prevents you from getting good sleep?',
        contextFromData: sleepContext.isNotEmpty
            ? '${sleepContext}Let\'s identify barriers to better rest.'
            : null,
        suggestedResponses: [
          'Racing thoughts keep me awake',
          'I\'m not tired but staying up late',
          'I wake up frequently during the night',
          'I don\'t have a consistent bedtime',
        ],
      ),
    );
  }

  /// Day 3: Energy Management
  CbtProgramDay _createDay3(BurnoutAnalysisData? analysis) {
    String energyContext = '';
    if (analysis != null && analysis.avgEnergyLevel <= 3) {
      energyContext =
          'Your energy levels have been averaging ${analysis.avgEnergyLevel.toStringAsFixed(1)}/10. ';
    }

    return CbtProgramDay(
      dayNumber: 3,
      title: 'Managing Your Energy',
      theme: 'Energy Conservation',
      description:
          'Learn to recognize your energy patterns and conserve energy for what matters most.',
      activities: [
        CbtActivity(
          id: 'd3_a1',
          title: 'Energy Audit',
          description:
              'Identify activities that drain vs. energize you throughout the day.',
          duration: '10 min',
          type: 'reflection',
        ),
        CbtActivity(
          id: 'd3_a2',
          title: 'Micro-Rest Breaks',
          description:
              'Schedule 2-minute breaks every hour to prevent energy depletion.',
          duration: '5 min',
          type: 'exercise',
        ),
      ],
      prompt: CbtPrompt(
        question:
            'What activities or situations leave you feeling most drained?',
        contextFromData: energyContext.isNotEmpty
            ? '${energyContext}Identifying these helps you plan restorative breaks.'
            : null,
        suggestedResponses: [
          'Work meetings and deadlines',
          'Social interactions',
          'Household responsibilities',
          'Constant screen time',
        ],
      ),
    );
  }

  /// Day 4: Thought Patterns
  CbtProgramDay _createDay4(BurnoutAnalysisData? analysis) {
    return CbtProgramDay(
      dayNumber: 4,
      title: 'Identifying Thought Patterns',
      theme: 'Cognitive Awareness',
      description:
          'Recognize how your thoughts affect your mood and energy levels.',
      activities: [
        CbtActivity(
          id: 'd4_a1',
          title: 'Thought Journaling',
          description:
              'Write down recurring thoughts you\'ve had this week and their impact.',
          duration: '10 min',
          type: 'reflection',
        ),
        CbtActivity(
          id: 'd4_a2',
          title: 'Cognitive Distortion Awareness',
          description:
              'Learn to identify common thinking patterns that contribute to stress.',
          duration: '10 min',
          type: 'awareness',
        ),
      ],
      prompt: CbtPrompt(
        question: 'What thoughts have been repeating in your mind lately?',
        contextFromData:
            'Noticing these patterns is the first step to changing them.',
        suggestedResponses: [
          '"I\'m not doing enough"',
          '"Everyone expects too much from me"',
          '"I should be handling this better"',
          '"Things will never get better"',
        ],
      ),
    );
  }

  /// Day 5: Self-Compassion
  CbtProgramDay _createDay5(BurnoutAnalysisData? analysis) {
    return CbtProgramDay(
      dayNumber: 5,
      title: 'Cultivating Self-Compassion',
      theme: 'Self-Kindness',
      description:
          'Practice being kinder to yourself and reducing self-criticism.',
      activities: [
        CbtActivity(
          id: 'd5_a1',
          title: 'Self-Compassion Break',
          description:
              'A guided exercise to treat yourself with the same kindness you\'d offer a friend.',
          duration: '7 min',
          type: 'breathing',
        ),
        CbtActivity(
          id: 'd5_a2',
          title: 'Letter to Yourself',
          description:
              'Write a supportive letter to yourself acknowledging your efforts.',
          duration: '10 min',
          type: 'reflection',
        ),
      ],
      prompt: CbtPrompt(
        question:
            'What would you say to a friend who was going through what you\'re experiencing?',
        contextFromData:
            'Often we\'re harder on ourselves than we would ever be on someone else.',
        suggestedResponses: [
          'You\'re doing your best and that\'s enough',
          'It\'s okay to take breaks',
          'Your feelings are valid',
          'You deserve rest and kindness',
        ],
      ),
    );
  }

  /// Day 6: Building Support
  CbtProgramDay _createDay6(BurnoutAnalysisData? analysis) {
    return CbtProgramDay(
      dayNumber: 6,
      title: 'Building Your Support System',
      theme: 'Connection',
      description:
          'Recognize the importance of reaching out and building your support network.',
      activities: [
        CbtActivity(
          id: 'd6_a1',
          title: 'Support Network Mapping',
          description: 'Identify people in your life who can provide support.',
          duration: '10 min',
          type: 'reflection',
        ),
        CbtActivity(
          id: 'd6_a2',
          title: 'Reach Out Practice',
          description:
              'Practice reaching out to one person for a brief check-in.',
          duration: '5 min',
          type: 'awareness',
        ),
      ],
      prompt: CbtPrompt(
        question: 'Who in your life makes you feel understood and supported?',
        contextFromData: 'Connection is crucial for mental health recovery.',
        suggestedResponses: [
          'A family member I trust',
          'A close friend',
          'A mentor or colleague',
          'I\'d like to reach out but find it hard',
        ],
      ),
    );
  }

  /// Day 7: Integration & Moving Forward
  CbtProgramDay _createDay7(BurnoutAnalysisData? analysis) {
    return CbtProgramDay(
      dayNumber: 7,
      title: 'Moving Forward',
      theme: 'Integration',
      description:
          'Create a sustainable plan to maintain your recovery and prevent burnout.',
      activities: [
        CbtActivity(
          id: 'd7_a1',
          title: 'Recovery Action Plan',
          description:
              'Create a personal plan with specific actions to maintain your wellbeing.',
          duration: '15 min',
          type: 'reflection',
        ),
        CbtActivity(
          id: 'd7_a2',
          title: 'Gratitude Practice',
          description:
              'Reflect on three things you\'re grateful for from this past week.',
          duration: '5 min',
          type: 'gratitude',
        ),
      ],
      prompt: CbtPrompt(
        question:
            'What specific changes will you commit to making in your daily routine?',
        contextFromData: 'Small, consistent changes lead to lasting recovery.',
        suggestedResponses: [
          'Prioritize 7+ hours of sleep',
          'Take regular breaks throughout the day',
          'Practice daily mindfulness',
          'Schedule time for activities I enjoy',
        ],
      ),
    );
  }

  /// Generate personalized prompt based on user's recent data
  CbtPrompt generatePersonalizedPrompt({
    required int dayNumber,
    double? recentMood,
    double? recentEnergy,
    double? recentStress,
    List<String>? recentTags,
  }) {
    String question;
    String? context;
    List<String> responses;

    switch (dayNumber) {
      case 1:
        question = 'How are you feeling right now?';
        if (recentMood != null) {
          context =
              'Your recent mood average is ${recentMood.toStringAsFixed(1)}/5';
        }
        responses = [
          'Exhausted but hopeful',
          'Overwhelmed',
          'Anxious',
          'Ready to start',
        ];
        break;
      case 2:
        question = 'How was your sleep last night?';
        responses = [
          'Restful',
          'Restless',
          'Difficult to fall asleep',
          'Woke up frequently',
        ];
        break;
      case 3:
        question = 'What drained your energy today?';
        if (recentTags != null && recentTags.isNotEmpty) {
          context = 'You recently tagged: ${recentTags.take(3).join(", ")}';
        }
        responses = [
          'Work demands',
          'Social interactions',
          'Personal worries',
          'Physical fatigue',
        ];
        break;
      default:
        question = 'What\'s on your mind today?';
        responses = [
          'Grateful for progress',
          'Still struggling',
          'Feeling hopeful',
          'Need more support',
        ];
    }

    return CbtPrompt(
      question: question,
      contextFromData: context,
      suggestedResponses: responses,
    );
  }

  /// In-memory progress tracking (for simplicity)
  final Map<String, Map<String, dynamic>> _progressCache = {};

  /// Get progress from cache
  Map<String, dynamic>? _getProgressInMemory(String userId) {
    return _progressCache[userId];
  }

  /// Save program progress (in-memory for now)
  Future<void> saveProgress({
    required String userId,
    required int dayNumber,
    required bool completed,
    String? reflectionNote,
    List<String>? completedActivities,
  }) async {
    final existing = _getProgressInMemory(userId);

    Map<String, dynamic> progressData =
        existing ??
        {
          'userId': userId,
          'startDate': DateTime.now().toIso8601String(),
          'currentDay': 1,
          'days': <Map<String, dynamic>>[],
        };

    // Update or add day progress
    final days = List<Map<String, dynamic>>.from(progressData['days'] ?? []);
    final existingDayIndex = days.indexWhere(
      (d) => d['dayNumber'] == dayNumber,
    );

    final dayData = {
      'dayNumber': dayNumber,
      'completed': completed,
      'completedAt': completed ? DateTime.now().toIso8601String() : null,
      'reflectionNote': reflectionNote,
      'completedActivities': completedActivities ?? [],
    };

    if (existingDayIndex >= 0) {
      days[existingDayIndex] = dayData;
    } else {
      days.add(dayData);
    }

    progressData['days'] = days;
    progressData['currentDay'] =
        completed && dayNumber >= (progressData['currentDay'] as int? ?? 1)
        ? dayNumber + 1
        : (progressData['currentDay'] as int? ?? 1);
    progressData['status'] = (progressData['currentDay'] as int) > 7
        ? 'completed'
        : 'inProgress';

    _progressCache[userId] = progressData;
  }

  /// Get program progress
  Future<CbtProgramProgress?> getProgress(String userId) async {
    final data = _progressCache[userId];
    if (data == null) return null;

    return CbtProgramProgress(
      id: 'progress',
      userId: userId,
      startDate: DateTime.tryParse(data['startDate'] ?? '') ?? DateTime.now(),
      currentDay: data['currentDay'] ?? 1,
      dayProgress: [],
      status: CbtProgramStatus.inProgress,
    );
  }
}
