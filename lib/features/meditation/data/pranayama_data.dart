// lib/features/meditation/data/pranayama_data.dart
// Pranayama library and guided sessions

import 'package:fitkarma/features/meditation/data/pranayama_models.dart';

/// Pranayama library
class PranayamaData {
  static const List<Pranayama> pranyamas = [
    // Anulom Vilom - Alternate Nostril Breathing
    Pranayama(
      id: 'anulom_vilom',
      name: 'Anulom Vilom',
      sanskritName: 'अनुलोम विलोम',
      description:
          'Alternate nostril breathing that balances the left and right hemispheres of the brain and harmonizes the body\'s energy channels.',
      inhaleSeconds: 4,
      holdAfterInhaleSeconds: 4,
      exhaleSeconds: 4,
      holdAfterExhaleSeconds: 0,
      recommendedCycles: 10,
      benefits: [
        'Balances hormones and energy',
        'Improves focus and concentration',
        'Reduces anxiety and stress',
        'Supports respiratory health',
        'Calms the nervous system',
      ],
      cautions: [
        'Avoid if you have a cold or sinus infection',
        'Practice on an empty stomach',
        'Don\'t hold breath if you have heart issues',
      ],
      iconEmoji: '🌬️',
    ),

    // Bhramari - Bee Breath
    Pranayama(
      id: 'bhramari',
      name: 'Bhramari',
      sanskritName: 'भ्रमरी',
      description:
          'A calming breathing technique that produces a humming sound like a bee, helping to quiet the mind and relieve stress.',
      inhaleSeconds: 4,
      holdAfterInhaleSeconds: 0,
      exhaleSeconds: 8,
      holdAfterExhaleSeconds: 0,
      recommendedCycles: 5,
      benefits: [
        'Reduces anxiety and panic attacks',
        'Calms the mind instantly',
        'Relieves headache and tension',
        'Improves concentration',
        'Lowers blood pressure',
      ],
      cautions: [
        'Keep teeth lightly touching during exhale',
        'Avoid if you have ear infections',
        'Practice gently - don\'t strain',
      ],
      iconEmoji: '🐝',
    ),

    // Kapalbhati - Skull Shining Breath
    Pranayama(
      id: 'kapalbhati',
      name: 'Kapalbhati',
      sanskritName: 'कपालभाति',
      description:
          'An energizing breath that cleanses the respiratory system and energizes the mind. Involves forceful exhalations through the nose.',
      inhaleSeconds: 1,
      holdAfterInhaleSeconds: 0,
      exhaleSeconds: 1,
      holdAfterExhaleSeconds: 0,
      recommendedCycles: 20,
      benefits: [
        'Clears mucus from respiratory tract',
        'Energizes the brain',
        'Improves digestion',
        'Burns abdominal fat',
        'Refreshes the mind',
      ],
      cautions: [
        'Avoid during pregnancy',
        'Don\'t practice if you have heart conditions',
        'Don\'t practice on full stomach',
        'Stop if you feel dizzy',
      ],
      iconEmoji: '✨',
    ),

    // Bhastrika - Bellows Breath
    Pranayama(
      id: 'bhastrika',
      name: 'Bhastrika',
      sanskritName: 'भस्त्रिका',
      description:
          'A powerful breathing exercise that simulates the bellows of a blacksmith, rapidly filling and emptying the lungs to generate heat and energy.',
      inhaleSeconds: 2,
      holdAfterInhaleSeconds: 2,
      exhaleSeconds: 2,
      holdAfterExhaleSeconds: 2,
      recommendedCycles: 10,
      benefits: [
        'Builds strong respiratory system',
        'Increases lung capacity',
        'Generates body heat',
        'Clears energy blockages',
        'Boosts metabolism',
      ],
      cautions: [
        'Don\'t practice if pregnant',
        'Avoid with high blood pressure',
        'Stop if you feel lightheaded',
        'Practice in well-ventilated area',
      ],
      iconEmoji: '🔥',
    ),

    // Box Breathing (Sama Vritti)
    Pranayama(
      id: 'box_breathing',
      name: 'Box Breathing',
      sanskritName: 'सम वृत्ति',
      description:
          'A simple 4-phase breathing technique used by Navy SEALs and athletes to calm the nervous system and improve focus.',
      inhaleSeconds: 4,
      holdAfterInhaleSeconds: 4,
      exhaleSeconds: 4,
      holdAfterExhaleSeconds: 4,
      recommendedCycles: 8,
      benefits: [
        'Reduces stress and anxiety',
        'Improves focus and concentration',
        'Lowers blood pressure',
        'Promotes better sleep',
        'Enhances performance under pressure',
      ],
      cautions: [
        'None - safe for most people',
        'Start slowly if new to breathing exercises',
      ],
      iconEmoji: '📦',
    ),

    // 4-7-8 Relaxing Breath
    Pranayama(
      id: 'relaxing_breath',
      name: '4-7-8 Relaxing Breath',
      sanskritName: 'प्रशांत श्वसन',
      description:
          'A natural tranquilizer for the nervous system that promotes deep relaxation and helps with sleep.',
      inhaleSeconds: 4,
      holdAfterInhaleSeconds: 7,
      exhaleSeconds: 8,
      holdAfterExhaleSeconds: 0,
      recommendedCycles: 4,
      benefits: [
        'Natural sleep aid',
        'Reduces anxiety',
        'Controls anger',
        'Manages cravings',
        'Lowers heart rate',
      ],
      cautions: [
        'First few times do while sitting',
        'Avoid during pregnancy',
        'Don\'t hold too long - start with fewer cycles',
      ],
      iconEmoji: '🌙',
    ),
  ];

  /// Get all guided sessions
  static const List<GuidedSession> guidedSessions = [
    // 5-minute sessions
    GuidedSession(
      id: 'morning_5',
      title: 'Morning Awakening',
      description:
          'A gentle 5-minute session to energize your morning and set positive intentions.',
      durationMinutes: 5,
      audioAsset: 'assets/audio/morning_5min.mp3',
      category: 'morning',
      iconEmoji: '🌅',
    ),
    GuidedSession(
      id: 'stress_relief_5',
      title: 'Stress Relief',
      description:
          'Quick 5-minute stress relief session to calm your mind and body.',
      durationMinutes: 5,
      audioAsset: 'assets/audio/stress_relief_5min.mp3',
      category: 'stress',
      iconEmoji: '😌',
    ),
    GuidedSession(
      id: 'focus_5',
      title: 'Mental Clarity',
      description:
          'Improve focus and concentration with this 5-minute guided session.',
      durationMinutes: 5,
      audioAsset: 'assets/audio/focus_5min.mp3',
      category: 'focus',
      iconEmoji: '🧠',
    ),

    // 10-minute sessions
    GuidedSession(
      id: 'body_scan_10',
      title: 'Body Scan Relaxation',
      description:
          'A progressive body scan to release tension and promote deep relaxation.',
      durationMinutes: 10,
      audioAsset: 'assets/audio/body_scan_10min.mp3',
      category: 'relaxation',
      iconEmoji: '🧘',
    ),
    GuidedSession(
      id: 'gratitude_10',
      title: 'Gratitude Meditation',
      description:
          'Cultivate gratitude and positive emotions with this 10-minute session.',
      durationMinutes: 10,
      audioAsset: 'assets/audio/gratitude_10min.mp3',
      category: 'mindfulness',
      iconEmoji: '🙏',
    ),
    GuidedSession(
      id: 'sleep_10',
      title: 'Sleep Preparation',
      description: 'Wind down and prepare your mind for restful sleep.',
      durationMinutes: 10,
      audioAsset: 'assets/audio/sleep_10min.mp3',
      category: 'sleep',
      iconEmoji: '😴',
    ),

    // 15-minute sessions
    GuidedSession(
      id: 'loving_kindness_15',
      title: 'Loving Kindness',
      description:
          'Generate compassion for yourself and others with metta bhavana meditation.',
      durationMinutes: 15,
      audioAsset: 'assets/audio/love_kindness_15min.mp3',
      category: 'compassion',
      iconEmoji: '❤️',
    ),
    GuidedSession(
      id: 'mindful_walking_15',
      title: 'Mindful Movement',
      description:
          'Combine breath awareness with gentle movement for mindful presence.',
      durationMinutes: 15,
      audioAsset: 'assets/audio/mindful_movement_15min.mp3',
      category: 'mindfulness',
      iconEmoji: '🚶',
    ),
    GuidedSession(
      id: 'anxiety_relief_15',
      title: 'Anxiety Release',
      description:
          'A comprehensive session to release anxiety and find inner peace.',
      durationMinutes: 15,
      audioAsset: 'assets/audio/anxiety_release_15min.mp3',
      category: 'stress',
      iconEmoji: '🕊️',
    ),

    // 20-minute sessions
    GuidedSession(
      id: 'deep_relaxation_20',
      title: 'Deep Relaxation',
      description: 'Complete guided relaxation for deep rest and rejuvenation.',
      durationMinutes: 20,
      audioAsset: 'assets/audio/deep_relax_20min.mp3',
      category: 'relaxation',
      iconEmoji: '🌊',
    ),
    GuidedSession(
      id: 'manifestation_20',
      title: 'Manifestation',
      description: 'Align with your goals and intentions for positive change.',
      durationMinutes: 20,
      audioAsset: 'assets/audio/manifestation_20min.mp3',
      category: 'spiritual',
      iconEmoji: '✨',
    ),
    GuidedSession(
      id: 'evening_wind_down_20',
      title: 'Evening Wind Down',
      description: 'Transition from your day into a peaceful evening state.',
      durationMinutes: 20,
      audioAsset: 'assets/audio/evening_20min.mp3',
      category: 'evening',
      iconEmoji: '🌆',
    ),
  ];

  /// Get pranyama by ID
  static Pranayama? getById(String id) {
    try {
      return pranyamas.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get guided session by ID
  static GuidedSession? getSessionById(String id) {
    try {
      return guidedSessions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Get sessions by duration
  static List<GuidedSession> getByDuration(int minutes) {
    return guidedSessions.where((s) => s.durationMinutes == minutes).toList();
  }

  /// Get sessions by category
  static List<GuidedSession> getByCategory(String category) {
    return guidedSessions.where((s) => s.category == category).toList();
  }
}
