/// Lightweight on-device sentiment analyzer using keyword-based approach.
/// This is a Dart-only implementation that does not require ML models or network calls.
/// It analyzes text to determine emotional tone (-1.0 to 1.0 scale).
class SentimentAnalyzer {
  // Positive words with weights
  static const Map<String, double> _positiveWords = {
    // Joy/Happiness
    'happy': 0.8, 'joy': 0.9, 'love': 0.95, 'excited': 0.85, 'delighted': 0.9,
    'pleased': 0.7,
    'glad': 0.7,
    'cheerful': 0.8,
    'elated': 0.9,
    'thrilled': 0.9,
    'grateful': 0.85, 'thankful': 0.8, 'blessed': 0.85, 'appreciate': 0.75,
    'wonderful': 0.9, 'amazing': 0.9, 'awesome': 0.85, 'fantastic': 0.9,
    'great': 0.7, 'good': 0.5, 'nice': 0.5, 'pleasant': 0.6, 'lovely': 0.75,
    'beautiful': 0.8, 'perfect': 0.95, 'brilliant': 0.85, 'excellent': 0.9,
    'outstanding': 0.9, 'superb': 0.9, 'marvelous': 0.85, 'fabulous': 0.85,
    // Hope/Optimism
    'hope': 0.6, 'optimistic': 0.7, 'confident': 0.65, 'encouraged': 0.7,
    'inspired': 0.75, 'motivated': 0.7, 'determined': 0.6, 'focused': 0.5,
    // Calm/Peace
    'peaceful': 0.8,
    'calm': 0.7,
    'relaxed': 0.7,
    'serene': 0.8,
    'tranquil': 0.85,
    'balanced': 0.6, 'centered': 0.65, 'mindful': 0.6, 'present': 0.5,
    // Love/Connection
    'caring': 0.7, 'compassionate': 0.75, 'kind': 0.7, 'generous': 0.7,
    'supportive': 0.65, 'connected': 0.6, 'close': 0.5, 'bond': 0.55,
    'friend': 0.5, 'family': 0.5, 'together': 0.55, 'warm': 0.6,
    // Accomplishment
    'accomplished': 0.8, 'proud': 0.75, 'successful': 0.8, 'achieved': 0.75,
    'progress': 0.65, 'improved': 0.65, 'better': 0.55, 'strong': 0.6,
    'healthy': 0.6, 'energetic': 0.65, 'vibrant': 0.7, 'alive': 0.55,
  };

  // Negative words with weights (negative values)
  static const Map<String, double> _negativeWords = {
    // Sadness
    'sad': -0.7, 'unhappy': -0.6, 'depressed': -0.9, 'miserable': -0.85,
    'heartbroken': -0.9, 'grief': -0.9, 'sorrow': -0.85, 'lonely': -0.7,
    'alone': -0.6, 'isolated': -0.7, 'rejected': -0.75, 'abandoned': -0.8,
    // Fear/Anxiety
    'afraid': -0.7, 'scared': -0.7, 'frightened': -0.75, 'terrified': -0.9,
    'anxious': -0.7, 'worried': -0.6, 'nervous': -0.55, 'stressed': -0.65,
    'panic': -0.8, 'dread': -0.75, 'tense': -0.5, 'uneasy': -0.55,
    // Anger
    'angry': -0.8, 'mad': -0.6, 'furious': -0.95, 'irritated': -0.5,
    'annoyed': -0.45, 'frustrated': -0.6, 'enraged': -0.9, 'hostile': -0.8,
    'resentful': -0.7, 'bitter': -0.7, 'hateful': -0.9,
    // Disappointment
    'disappointed': -0.7, 'discouraged': -0.65, 'hopeless': -0.85,
    'helpless': -0.8, 'worthless': -0.9, 'guilty': -0.7, 'ashamed': -0.7,
    'regret': -0.6, 'remorse': -0.65,
    // Pain/Discomfort
    'pain': -0.7, 'hurt': -0.6, 'suffering': -0.8, 'exhausted': -0.5,
    'tired': -0.3, 'sick': -0.6, 'ill': -0.5, 'unwell': -0.5,
    'weak': -0.4, 'drained': -0.5, 'fatigue': -0.45,
  };

  // Negation words that flip sentiment
  static const Set<String> _negations = {
    'not',
    'no',
    'never',
    'neither',
    'nobody',
    'nothing',
    'nowhere',
    'none',
    'hardly',
    'barely',
    'scarcely',
    'without',
    'didnt',
    'dont',
    'doesnt',
    'wont',
    'wouldnt',
    'couldnt',
    'shouldnt',
    'cant',
    'cannot',
    'isnt',
    'arent',
    'wasnt',
    'werent',
    'hasnt',
    'havent',
    'hadnt',
  };

  // Intensity modifiers
  static const Map<String, double> _intensifiers = {
    'extremely': 1.5,
    'very': 1.3,
    'really': 1.2,
    'so': 1.2,
    'absolutely': 1.5,
    'totally': 1.4,
    'completely': 1.4,
    'highly': 1.3,
    'incredibly': 1.5,
    'especially': 1.2,
    'particularly': 1.2,
    'slightly': 0.5,
    'somewhat': 0.6,
    'abit': 0.5,
    'alittle': 0.5,
    'barely': 0.3,
    'hardly': 0.3,
  };

  /// Analyze text and return sentiment result
  SentimentResult analyze(String text) {
    if (text.isEmpty) {
      return SentimentResult(score: 0.0, label: 'neutral');
    }

    final words = _tokenize(text);
    double totalScore = 0.0;
    int wordCount = 0;
    bool negationActive = false;
    double intensityMultiplier = 1.0;

    for (int i = 0; i < words.length; i++) {
      final word = words[i].toLowerCase();
      final cleanWord = _cleanWord(word);

      // Check for negation
      if (_negations.contains(cleanWord)) {
        negationActive = true;
        continue;
      }

      // Check for intensifiers
      if (_intensifiers.containsKey(cleanWord)) {
        intensityMultiplier = _intensifiers[cleanWord]!;
        continue;
      }

      double wordScore = 0.0;

      // Check positive words
      if (_positiveWords.containsKey(cleanWord)) {
        wordScore = _positiveWords[cleanWord]!;
      } else if (_negativeWords.containsKey(cleanWord)) {
        wordScore = _negativeWords[cleanWord]!;
      }

      if (wordScore != 0.0) {
        // Apply negation
        if (negationActive) {
          wordScore =
              -wordScore * 0.8; // Negation reverses and slightly dampens
          negationActive = false;
        }

        // Apply intensity
        wordScore *= intensityMultiplier;
        intensityMultiplier = 1.0; // Reset intensity

        totalScore += wordScore;
        wordCount++;
      }

      // Reset negation after a few words
      if (i > 0 && i % 3 == 0) {
        negationActive = false;
      }
    }

    // Normalize score to -1.0 to 1.0 range
    double normalizedScore = 0.0;
    if (wordCount > 0) {
      normalizedScore = (totalScore / wordCount).clamp(-1.0, 1.0);
    }

    // Determine label
    String label;
    if (normalizedScore > 0.3) {
      label = 'positive';
    } else if (normalizedScore < -0.3) {
      label = 'negative';
    } else {
      label = 'neutral';
    }

    return SentimentResult(score: normalizedScore, label: label);
  }

  /// Tokenize text into words
  List<String> _tokenize(String text) {
    // Remove common punctuation and split
    final cleaned = text.replaceAll(RegExp(r'[^a-zA-Z\s]'), ' ');
    return cleaned.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
  }

  /// Clean word by removing trailing punctuation
  String _cleanWord(String word) {
    if (word.isEmpty) return word;
    // Remove leading/trailing non-alphanumeric characters
    var result = word;
    while (result.isNotEmpty && !_isAlphanumeric(result[0])) {
      result = result.substring(1);
    }
    while (result.isNotEmpty && !_isAlphanumeric(result[result.length - 1])) {
      result = result.substring(0, result.length - 1);
    }
    return result;
  }

  bool _isAlphanumeric(String char) {
    final code = char.codeUnitAt(0);
    return (code >= 65 && code <= 90) ||
        (code >= 97 && code <= 122) ||
        (code >= 48 && code <= 57);
  }
}

/// Result of sentiment analysis
class SentimentResult {
  final double score; // -1.0 to 1.0
  final String label; // 'positive', 'negative', 'neutral'

  const SentimentResult({required this.score, required this.label});

  @override
  String toString() => 'SentimentResult(score: $score, label: $label)';
}
