enum FastingStage { 
  fed, 
  earlyFast, 
  fatBurning, 
  ketosis, 
  deepFast 
}

class FastingStageEngine {
  static FastingStage getStage(Duration elapsed) {
    final hours = elapsed.inHours;
    if (hours < 4) return FastingStage.fed;
    if (hours < 8) return FastingStage.earlyFast;
    if (hours < 12) return FastingStage.fatBurning;
    if (hours < 16) return FastingStage.ketosis;
    return FastingStage.deepFast;
  }

  static String getStageName(FastingStage stage) {
    switch (stage) {
      case FastingStage.fed: return 'Fed State';
      case FastingStage.earlyFast: return 'Early Fasting';
      case FastingStage.fatBurning: return 'Fat Burning';
      case FastingStage.ketosis: return 'Ketosis';
      case FastingStage.deepFast: return 'Deep Fasting (Autophagy)';
    }
  }

  static String getStageDescription(FastingStage stage) {
    switch (stage) {
      case FastingStage.fed: return 'Blood sugar rises, insulin is secreted.';
      case FastingStage.earlyFast: return 'Blood sugar levels start to fall.';
      case FastingStage.fatBurning: return 'Liver starts using fat as a primary fuel.';
      case FastingStage.ketosis: return 'Insulin is low, ketones are rising.';
      case FastingStage.deepFast: return 'Cellular repair processes begin.';
    }
  }
}

