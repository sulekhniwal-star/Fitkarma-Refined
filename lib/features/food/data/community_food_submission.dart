// lib/features/food/data/community_food_submission.dart
// Community food submission service

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Status of a community food submission
enum FoodSubmissionStatus { pending, approved, rejected }

/// Service for community food submissions
class CommunityFoodSubmissionService {
  final AppDatabase db;
  final AuthAwService _authService = AuthAwService();

  CommunityFoodSubmissionService(this.db);

  /// Submit a new food item for community review
  Future<String> submitFood({
    required String name,
    required String nameLocal,
    required String region,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    double? fiberPer100g,
    double? vitaminDPer100g,
    double? vitaminB12Per100g,
    double? ironPer100g,
    double? calciumPer100g,
    String? servingSizesJson,
    String? notes,
  }) async {
    final userId = await _authService.getStoredUserId() ?? 'anonymous';
    final submissionId = 'submission_${DateTime.now().millisecondsSinceEpoch}';

    // Create submission entry
    await db
        .into(db.foodSubmissions)
        .insert(
          FoodSubmissionsCompanion.insert(
            id: submissionId,
            userId: userId,
            name: name,
            nameLocal: nameLocal,
            region: region,
            caloriesPer100g: caloriesPer100g,
            proteinPer100g: proteinPer100g,
            carbsPer100g: carbsPer100g,
            fatPer100g: fatPer100g,
            fiberPer100g: Value(fiberPer100g),
            vitaminDPer100g: Value(vitaminDPer100g),
            vitaminB12Per100g: Value(vitaminB12Per100g),
            ironPer100g: Value(ironPer100g),
            calciumPer100g: Value(calciumPer100g),
            servingSizes: Value(servingSizesJson),
            notes: Value(notes),
            status: 'pending',
            submittedAt: DateTime.now(),
          ),
        );

    return submissionId;
  }

  /// Get all submissions by a user
  Future<List<FoodSubmission>> getUserSubmissions() async {
    final userId = await _authService.getStoredUserId() ?? 'anonymous';
    return await (db.select(db.foodSubmissions)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.submittedAt)]))
        .get();
  }

  /// Get pending submissions (for admins)
  Future<List<FoodSubmission>> getPendingSubmissions() async {
    return await (db.select(db.foodSubmissions)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.submittedAt)]))
        .get();
  }

  /// Approve a submission and add to food_items
  Future<void> approveSubmission(String submissionId, String approvedBy) async {
    final submission = await (db.select(
      db.foodSubmissions,
    )..where((t) => t.id.equals(submissionId))).getSingle();

    // Add to food_items
    await db
        .into(db.foodItems)
        .insert(
          FoodItemsCompanion.insert(
            id: 'community_${submission.id}',
            name: submission.name,
            nameLocal: submission.nameLocal,
            region: submission.region,
            barcode: const Value(null),
            caloriesPer100g: submission.caloriesPer100g,
            proteinPer100g: submission.proteinPer100g,
            carbsPer100g: submission.carbsPer100g,
            fatPer100g: submission.fatPer100g,
            fiberPer100g: Value(submission.fiberPer100g),
            vitaminDPer100g: Value(submission.vitaminDPer100g),
            vitaminB12Per100g: Value(submission.vitaminB12Per100g),
            ironPer100g: Value(submission.ironPer100g),
            calciumPer100g: Value(submission.calciumPer100g),
            isIndian: const Value(true),
            servingSizes: submission.servingSizes ?? '[]',
            source: 'community_${submission.userId}',
          ),
        );

    // Update submission status
    await (db.update(
      db.foodSubmissions,
    )..where((t) => t.id.equals(submissionId))).write(
      FoodSubmissionsCompanion(
        status: const Value('approved'),
        reviewedBy: Value(approvedBy),
        reviewedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Reject a submission
  Future<void> rejectSubmission(
    String submissionId,
    String rejectedBy,
    String reason,
  ) async {
    await (db.update(
      db.foodSubmissions,
    )..where((t) => t.id.equals(submissionId))).write(
      FoodSubmissionsCompanion(
        status: const Value('rejected'),
        reviewedBy: Value(rejectedBy),
        reviewedAt: Value(DateTime.now()),
        rejectionReason: Value(reason),
      ),
    );
  }
}
