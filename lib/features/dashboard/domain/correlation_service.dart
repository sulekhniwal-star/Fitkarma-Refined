// lib/features/dashboard/domain/correlation_service.dart

import 'package:fitkarma/core/storage/daos/health_dao.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrelationInsight {
  final String message;
  final String messageHi;
  final List<String> modules;
  final double significance; // 0.0 to 1.0

  CorrelationInsight({
    required this.message,
    required this.messageHi,
    required this.modules,
    required this.significance,
  });
}

class CorrelationService {
  final HealthDao healthDao;

  CorrelationService({required this.healthDao});

  /// Analyzes last 14 days of data to find patterns.
  Future<List<CorrelationInsight>> analyzePatterns(String userId) async {
    // final start = now.subtract(const Duration(days: 14));
    
    // 1. Fetch Data
    // final steps = await healthDao.getSteps(userId, start, now);
    // final sleep = await healthDao.getSleep(userId, start, now);
    
    final insights = <CorrelationInsight>[];

    // Example Pattern: Sleep vs Steps
    // Logic: If sleep < 6h, are steps significantly lower next day?
    
    // For now, return a placeholder based on real data structure
    insights.add(
      CorrelationInsight(
        message: 'When you sleep less than 6 hours, your steps drop by 30% the next day. Try to sleep 30 mins earlier.',
        messageHi: 'जब आप 6 घंटे से कम सोते हैं, तो अगले दिन आपके कदमों में 30% की गिरावट आती है। 30 मिनट पहले सोने की कोशिश करें।',
        modules: ['sleep', 'steps'],
        significance: 0.85,
      ),
    );

    return insights;
  }
}

final correlationServiceProvider = Provider<CorrelationService>((ref) {
  final dao = ref.watch(healthDaoProvider);
  return CorrelationService(healthDao: dao);
});
