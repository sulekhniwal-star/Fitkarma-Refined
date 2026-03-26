import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

/// Voice command types for different actions in the app
enum VoiceCommandType {
  // Navigation commands
  goToDashboard,
  goToFood,
  goToWorkout,
  goToSteps,
  goToProfile,
  goToSettings,
  goToSleep,
  goToMeditation,
  goToReports,
  goToHabits,
  goToKarma,
  goToAyurveda,
  goToSocial,

  // Logging commands
  logFood,
  logWater,
  logWeight,
  logBloodPressure,
  logBloodGlucose,
  logSteps,
  logSleep,
  logMood,
  logWorkout,
  logMedication,
  logPeriod,

  // Action commands
  startWorkout,
  startMeditation,
  startFast,
  openCamera,
  scanFood,
  scanLabel,

  // Query commands
  howAmIDoing,
  showInsights,
  showProgress,
  showLeaderboard,
}

/// Represents a parsed voice command
class VoiceCommand {
  final VoiceCommandType type;
  final Map<String, dynamic> parameters;
  final String rawText;
  final double confidence;

  const VoiceCommand({
    required this.type,
    required this.parameters,
    required this.rawText,
    required this.confidence,
  });
}

/// Voice command recognition state
class VoiceRecognitionState {
  final bool isListening;
  final bool isAvailable;
  final String lastWords;
  final String? lastError;
  final VoiceCommand? lastCommand;
  final List<stt.LocaleName> availableLocales;

  const VoiceRecognitionState({
    this.isListening = false,
    this.isAvailable = false,
    this.lastWords = '',
    this.lastError,
    this.lastCommand,
    this.availableLocales = const [],
  });

  VoiceRecognitionState copyWith({
    bool? isListening,
    bool? isAvailable,
    String? lastWords,
    String? lastError,
    VoiceCommand? lastCommand,
    List<stt.LocaleName>? availableLocales,
  }) {
    return VoiceRecognitionState(
      isListening: isListening ?? this.isListening,
      isAvailable: isAvailable ?? this.isAvailable,
      lastWords: lastWords ?? this.lastWords,
      lastError: lastError ?? this.lastError,
      lastCommand: lastCommand ?? this.lastCommand,
      availableLocales: availableLocales ?? this.availableLocales,
    );
  }
}

/// Voice command recognition service
class VoiceCommandService extends Notifier<VoiceRecognitionState> {
  late stt.SpeechToText _speech;
  bool _initialized = false;

  @override
  VoiceRecognitionState build() {
    _speech = stt.SpeechToText();
    return const VoiceRecognitionState();
  }

  /// Initialize speech recognition
  Future<bool> initialize() async {
    if (_initialized) return state.isAvailable;

    try {
      final available = await _speech.initialize(
        onError: (error) {
          state = state.copyWith(isListening: false, lastError: error.errorMsg);
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            state = state.copyWith(isListening: false);
          }
        },
      );

      // Get available locales for Indian languages
      final locales = await _speech.locales();

      state = state.copyWith(isAvailable: available, availableLocales: locales);
      _initialized = true;
      return available;
    } catch (e) {
      state = state.copyWith(isAvailable: false, lastError: e.toString());
      return false;
    }
  }

  /// Start listening for voice commands
  Future<void> startListening({
    String? localeId,
    VoidCallback? onCommandRecognized,
  }) async {
    if (!state.isAvailable) {
      final initialized = await initialize();
      if (!initialized) return;
    }

    if (state.isListening) {
      await stopListening();
    }

    state = state.copyWith(
      isListening: true,
      lastWords: '',
      lastError: null,
      lastCommand: null,
    );

    await _speech.listen(
      onResult: (SpeechRecognitionResult result) {
        final words = result.recognizedWords;
        state = state.copyWith(lastWords: words);

        if (result.finalResult && words.isNotEmpty) {
          final command = _parseCommand(words, result.confidence);
          if (command != null) {
            state = state.copyWith(lastCommand: command);
            onCommandRecognized?.call();
          }
        }
      },
      localeId: localeId,
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      partialResults: true,
      cancelOnError: false,
      listenMode: stt.ListenMode.confirmation,
    );
  }

  /// Stop listening
  Future<void> stopListening() async {
    await _speech.stop();
    state = state.copyWith(isListening: false);
  }

  /// Cancel listening
  Future<void> cancelListening() async {
    await _speech.cancel();
    state = state.copyWith(isListening: false, lastWords: '');
  }

  /// Parse voice input into a command
  VoiceCommand? _parseCommand(String text, double confidence) {
    final lowerText = text.toLowerCase();

    // Navigation commands
    if (_containsAny(lowerText, ['dashboard', 'home', 'main'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToDashboard,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['food', 'meal', 'eat', 'nutrition'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToFood,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['workout', 'exercise', 'fitness', 'gym'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToWorkout,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['steps', 'walking', 'walk', 'steps'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToSteps,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['profile', 'me', 'my profile'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToProfile,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['settings', 'preferences', 'configure'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToSettings,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['sleep', 'rest', 'night'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToSleep,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['meditation', 'breathe', 'relax'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToMeditation,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['reports', 'insights', 'analysis'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToReports,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['habits', 'routines'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToHabits,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['karma', 'points', 'rewards'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToKarma,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['ayurveda', 'dosha', 'herbs'])) {
      return VoiceCommand(
        type: VoiceCommandType.goToAyurveda,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }

    // Logging commands - extract numbers from text
    if (_containsAny(lowerText, [
      'log food',
      'log meal',
      'record food',
      'add food',
    ])) {
      final foodName = _extractFoodName(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logFood,
        parameters: {'name': foodName},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['water', 'drink water', 'hydrate'])) {
      final amount = _extractNumber(lowerText) ?? 1;
      return VoiceCommand(
        type: VoiceCommandType.logWater,
        parameters: {'glasses': amount},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['weight', 'weigh'])) {
      final weight = _extractNumber(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logWeight,
        parameters: {'weight': weight},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['blood pressure', 'bp', 'pressure'])) {
      final systolic = _extractNumber(lowerText);
      final diastolic = _extractSecondNumber(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logBloodPressure,
        parameters: {'systolic': systolic, 'diastolic': diastolic},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['blood sugar', 'glucose', 'sugar'])) {
      final glucose = _extractNumber(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logBloodGlucose,
        parameters: {'glucose': glucose},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['log steps', 'walked', 'steps walked'])) {
      final steps = _extractNumber(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logSteps,
        parameters: {'steps': steps},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['log sleep', 'sleep hours', 'slept'])) {
      final hours = _extractNumber(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logSleep,
        parameters: {'hours': hours},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['mood', 'feeling', 'emotion'])) {
      final mood = _extractMood(lowerText);
      return VoiceCommand(
        type: VoiceCommandType.logMood,
        parameters: {'mood': mood},
        rawText: text,
        confidence: confidence,
      );
    }

    // Action commands
    if (_containsAny(lowerText, [
      'start workout',
      'begin workout',
      'start exercise',
    ])) {
      return VoiceCommand(
        type: VoiceCommandType.startWorkout,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, [
      'start meditation',
      'begin meditation',
      'meditate',
    ])) {
      return VoiceCommand(
        type: VoiceCommandType.startMeditation,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['start fast', 'begin fast', 'fasting'])) {
      return VoiceCommand(
        type: VoiceCommandType.startFast,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['open camera', 'scan'])) {
      return VoiceCommand(
        type: VoiceCommandType.openCamera,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['scan food', 'identify food'])) {
      return VoiceCommand(
        type: VoiceCommandType.scanFood,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }

    // Query commands
    if (_containsAny(lowerText, ['how am i', 'how am i doing', 'status'])) {
      return VoiceCommand(
        type: VoiceCommandType.howAmIDoing,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['show insights', 'insights', 'analytics'])) {
      return VoiceCommand(
        type: VoiceCommandType.showInsights,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, [
      'show progress',
      'progress',
      'achievements',
    ])) {
      return VoiceCommand(
        type: VoiceCommandType.showProgress,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }
    if (_containsAny(lowerText, ['leaderboard', 'rank', 'compete'])) {
      return VoiceCommand(
        type: VoiceCommandType.showLeaderboard,
        parameters: {},
        rawText: text,
        confidence: confidence,
      );
    }

    return null;
  }

  bool _containsAny(String text, List<String> keywords) {
    return keywords.any((keyword) => text.contains(keyword));
  }

  int? _extractNumber(String text) {
    final numbers = RegExp(r'\d+').allMatches(text);
    if (numbers.isEmpty) return null;
    return int.tryParse(numbers.first.group(0)!);
  }

  int? _extractSecondNumber(String text) {
    final numbers = RegExp(r'\d+').allMatches(text);
    if (numbers.length < 2) return null;
    return int.tryParse(numbers.elementAt(1).group(0)!);
  }

  String? _extractFoodName(String text) {
    // Extract food name after keywords like "log food" or "add"
    final patterns = [
      RegExp(r'log food\s+(.+)'),
      RegExp(r'log meal\s+(.+)'),
      RegExp(r'add\s+(.+)'),
      RegExp(r'eat\s+(.+)'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(text);
      if (match != null && match.group(1) != null) {
        return match.group(1)!.trim();
      }
    }
    return null;
  }

  String _extractMood(String text) {
    if (_containsAny(text, ['happy', 'good', 'great', 'excellent', 'joy'])) {
      return 'happy';
    }
    if (_containsAny(text, ['sad', 'down', 'depressed', 'unhappy'])) {
      return 'sad';
    }
    if (_containsAny(text, ['angry', 'mad', 'frustrated', 'annoyed'])) {
      return 'angry';
    }
    if (_containsAny(text, ['anxious', 'worried', 'stressed', 'nervous'])) {
      return 'anxious';
    }
    if (_containsAny(text, ['calm', 'relaxed', 'peaceful', 'serene'])) {
      return 'calm';
    }
    if (_containsAny(text, ['tired', 'exhausted', 'fatigued', 'sleepy'])) {
      return 'tired';
    }
    if (_containsAny(text, ['energetic', 'energetic', 'full of energy'])) {
      return 'energetic';
    }
    return 'neutral';
  }
}

/// Provider for voice command service
final voiceCommandProvider =
    NotifierProvider<VoiceCommandService, VoiceRecognitionState>(
      VoiceCommandService.new,
    );

/// Provider to check if voice commands are available
final isVoiceCommandAvailableProvider = Provider<bool>((ref) {
  return ref.watch(voiceCommandProvider).isAvailable;
});

/// Provider for the last recognized command
final lastVoiceCommandProvider = Provider<VoiceCommand?>((ref) {
  return ref.watch(voiceCommandProvider).lastCommand;
});
