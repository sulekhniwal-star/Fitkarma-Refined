import 'package:flutter/material.dart';

enum BPClassification { normal, elevated, stage1, stage2, crisis }

class BPClassifier {
  /// Classifies blood pressure based on AHA (American Heart Association) thresholds.
  static BPClassification classify(int systolic, int diastolic) {
    if (systolic >= 180 || diastolic >= 120) return BPClassification.crisis;
    if (systolic >= 140 || diastolic >= 90) return BPClassification.stage2;
    if (systolic >= 130 || diastolic >= 80) return BPClassification.stage1;
    if (systolic >= 120 && diastolic < 80) return BPClassification.elevated;
    return BPClassification.normal;
  }

  static String getLabel(BPClassification classification) {
    switch (classification) {
      case BPClassification.normal: return 'Normal';
      case BPClassification.elevated: return 'Elevated';
      case BPClassification.stage1: return 'Hypertension Stage 1';
      case BPClassification.stage2: return 'Hypertension Stage 2';
      case BPClassification.crisis: return 'Hypertensive Crisis';
    }
  }

  static Color getColor(BPClassification classification) {
    switch (classification) {
      case BPClassification.normal: return Colors.green;
      case BPClassification.elevated: return Colors.yellow[700]!;
      case BPClassification.stage1: return Colors.orange;
      case BPClassification.stage2: return Colors.deepOrange;
      case BPClassification.crisis: return Colors.red;
    }
  }
}

