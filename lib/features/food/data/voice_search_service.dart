// lib/features/food/data/voice_search_service.dart
// Voice search service using speech_to_text

import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

/// Result of voice recognition
class VoiceSearchResult {
  final String recognizedText;
  final List<String> possibleMatches;
  final bool isFinal;

  VoiceSearchResult({
    required this.recognizedText,
    this.possibleMatches = const [],
    this.isFinal = false,
  });
}

/// Service for voice recognition
class VoiceSearchService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;
  String _lastRecognizedWords = '';
  VoidCallback? _onStatusChange;

  bool get isListening => _isListening;
  bool get isInitialized => _isInitialized;
  String get lastRecognizedWords => _lastRecognizedWords;

  /// Initialize the speech service
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          // Handle error silently
        },
        onStatus: (status) {
          _onStatusChange?.call();
        },
      );
      return _isInitialized;
    } catch (e) {
      return false;
    }
  }

  /// Check if speech recognition is available
  Future<bool> isAvailable() async {
    if (!_isInitialized) {
      await initialize();
    }
    return _isInitialized;
  }

  /// Start listening for speech
  Future<void> startListening({
    required Function(VoiceSearchResult) onResult,
    String localeId = 'en_IN',
  }) async {
    if (!_isInitialized) {
      final success = await initialize();
      if (!success) return;
    }

    if (_isListening) return;

    _lastRecognizedWords = '';
    _isListening = true;

    await _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        _lastRecognizedWords = result.recognizedWords;

        // Generate possible matches based on recognized words
        final possibleMatches = _generatePossibleMatches(
          result.recognizedWords,
        );

        onResult(
          VoiceSearchResult(
            recognizedText: result.recognizedWords,
            possibleMatches: possibleMatches,
            isFinal: result.finalResult,
          ),
        );

        if (result.finalResult) {
          _isListening = false;
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      localeId: localeId,
      partialResults: true,
      cancelOnError: true,
      listenMode: ListenMode.confirmation,
    );
  }

  /// Stop listening
  Future<void> stopListening() async {
    await _speechToText.stop();
    _isListening = false;
  }

  /// Cancel listening
  Future<void> cancelListening() async {
    await _speechToText.cancel();
    _isListening = false;
    _lastRecognizedWords = '';
  }

  /// Generate possible food matches from recognized text
  List<String> _generatePossibleMatches(String text) {
    if (text.isEmpty) return [];

    final words = text.toLowerCase().split(' ');
    final matches = <String>[];

    // Common Indian food terms to match
    final foodTerms = _getIndianFoodTerms();

    for (final word in words) {
      for (final term in foodTerms) {
        if (term.contains(word) || word.contains(term)) {
          matches.add(term);
        }
      }
    }

    // Add the full recognized phrase as a potential match
    if (text.isNotEmpty) {
      matches.insert(0, text);
    }

    return matches.take(5).toList();
  }

  /// Get common Indian food terms for matching
  List<String> _getIndianFoodTerms() {
    return [
      'dal',
      'chawal',
      'roti',
      'sabzi',
      'biryani',
      'pulao',
      'dosa',
      'idli',
      'sambar',
      'paneer',
      'chicken',
      'mutton',
      'fish',
      'egg',
      'paratha',
      'naan',
      'kebab',
      'butter chicken',
      'palak paneer',
      'dal makhani',
      'rajma',
      'chole',
      'aloo',
      'gobi',
      'bhindi',
      'mix veg',
      'poha',
      'upma',
      'poori',
      'samosa',
      'pakora',
      'chai',
      'lassi',
      'curd',
      'dahi',
      'rice',
      'khichdi',
      'thepla',
      'dhokla',
      'khandvi',
      'undhiyu',
      'pav bhaji',
      'vada pav',
      'bhelpuri',
      'pani puri',
      'sev puri',
      'ragda pattice',
      'mango',
      'banana',
      'apple',
      'orange',
      'salad',
      'thali',
      'meal',
      'breakfast',
      'lunch',
      'dinner',
      'snack',
    ];
  }

  /// Search for food items based on voice input
  List<String> searchFoodItems(String query) {
    if (query.isEmpty) return [];

    final queryLower = query.toLowerCase();
    final allFoods = _getIndianFoodTerms();

    // Exact and partial matches
    final matches = allFoods
        .where((food) => food.contains(queryLower) || queryLower.contains(food))
        .toList();

    return matches;
  }

  /// Set status change callback
  void setOnStatusChange(VoidCallback callback) {
    _onStatusChange = callback;
  }

  void dispose() {
    _speechToText.cancel();
    _isListening = false;
  }
}
