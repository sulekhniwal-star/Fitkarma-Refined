import '../../../core/storage/drift_service.dart';

abstract class InsightRule {
  String get id;
  int get priority; // 1 = highest
  Future<bool> condition(DriftService db, String userId);
  Future<String> message(DriftService db, String userId);
}
