// lib/features/workout/data/workout_aw_service.dart
// Appwrite service for workout operations

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/foundation.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/core/seed/workout_seed_data.dart';

/// Collection IDs for workout-related data
class WorkoutCollectionIds {
  static const String workouts = 'workouts';
  static const String workoutLogs = 'workout_logs';
  static const String scheduledWorkouts = 'scheduled_workouts';
  static const String personalRecords = 'personal_records';
  static const String databaseId = 'fitkarma';
}

/// Workout model
class Workout {
  final String id;
  final String title;
  final String description;
  final String youtubeId;
  final String? thumbnailUrl;
  final int durationMinutes;
  final String difficulty;
  final String category;
  final int? caloriesPerSession;
  final bool isFeatured;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeId,
    this.thumbnailUrl,
    required this.durationMinutes,
    required this.difficulty,
    required this.category,
    this.caloriesPerSession,
    required this.isFeatured,
  });

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['\$id'] as String? ?? map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      youtubeId: map['youtubeId'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String?,
      durationMinutes: map['durationMinutes'] as int,
      difficulty: map['difficulty'] as String,
      category: map['category'] as String,
      caloriesPerSession: map['caloriesPerSession'] as int?,
      isFeatured: map['isFeatured'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'youtubeId': youtubeId,
      'thumbnailUrl': thumbnailUrl,
      'durationMinutes': durationMinutes,
      'difficulty': difficulty,
      'category': category,
      'caloriesPerSession': caloriesPerSession,
      'isFeatured': isFeatured,
    };
  }
}

/// Appwrite service for workout-related operations
class WorkoutAwService {
  final AuthAwService _authService = AuthAwService();

  /// Get the Appwrite Databases instance
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Seed workouts to Appwrite (for initial setup)
  Future<void> seedWorkouts() async {
    try {
      final workouts = WorkoutSeedData.getAllWorkouts();

      for (final workout in workouts) {
        // Check if workout already exists
        try {
          await _databases.getDocument(
            databaseId: WorkoutCollectionIds.databaseId,
            collectionId: WorkoutCollectionIds.workouts,
            documentId: workout['id'] as String,
          );
          // Skip if exists
          debugPrint('Workout ${workout['id']} already exists, skipping...');
        } on appwrite.AppwriteException catch (e) {
          if (e.code == 404) {
            // Create the workout
            await _databases.createDocument(
              databaseId: WorkoutCollectionIds.databaseId,
              collectionId: WorkoutCollectionIds.workouts,
              documentId: workout['id'] as String,
              data: workout,
            );
            debugPrint('Created workout: ${workout['title']}');
          } else {
            rethrow;
          }
        }
      }
      debugPrint('Workout seeding completed!');
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Seed workouts failed: ${e.message}');
      rethrow;
    }
  }

  /// Get all workouts
  Future<List<Workout>> getAllWorkouts() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workouts,
        queries: <String>['limit(100)'],
      );

      return response.documents
          .map((doc) => Workout.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get all workouts failed: ${e.message}');
      // Return seed data as fallback
      return WorkoutSeedData.getAllWorkouts()
          .map((w) => Workout.fromMap(w))
          .toList();
    }
  }

  /// Get workouts by category
  Future<List<Workout>> getWorkoutsByCategory(String category) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workouts,
        queries: <String>['category="$category"', 'limit(50)'],
      );

      return response.documents
          .map((doc) => Workout.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get workouts by category failed: ${e.message}');
      // Return filtered seed data as fallback
      return WorkoutSeedData.getAllWorkouts()
          .where((w) => w['category'] == category)
          .map((w) => Workout.fromMap(w))
          .toList();
    }
  }

  /// Get featured workouts
  Future<List<Workout>> getFeaturedWorkouts() async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workouts,
        queries: <String>['isFeatured=true', 'limit(10)'],
      );

      return response.documents
          .map((doc) => Workout.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get featured workouts failed: ${e.message}');
      // Return filtered seed data as fallback
      return WorkoutSeedData.getAllWorkouts()
          .where((w) => w['isFeatured'] == true)
          .map((w) => Workout.fromMap(w))
          .toList();
    }
  }

  /// Get workout by ID
  Future<Workout?> getWorkout(String workoutId) async {
    try {
      final response = await _databases.getDocument(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workouts,
        documentId: workoutId,
      );

      return Workout.fromMap(response.data);
    } on appwrite.AppwriteException catch (e) {
      if (e.code == 404) {
        // Try to get from seed data
        final seedWorkout = WorkoutSeedData.getAllWorkouts()
            .where((w) => w['id'] == workoutId)
            .firstOrNull;
        if (seedWorkout != null) {
          return Workout.fromMap(seedWorkout);
        }
        return null;
      }
      debugPrint('Get workout failed: ${e.message}');
      rethrow;
    }
  }

  /// Get workouts by difficulty
  Future<List<Workout>> getWorkoutsByDifficulty(String difficulty) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workouts,
        queries: <String>['difficulty="$difficulty"', 'limit(50)'],
      );

      return response.documents
          .map((doc) => Workout.fromMap(doc.data))
          .toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get workouts by difficulty failed: ${e.message}');
      // Return filtered seed data as fallback
      return WorkoutSeedData.getAllWorkouts()
          .where((w) => w['difficulty'] == difficulty)
          .map((w) => Workout.fromMap(w))
          .toList();
    }
  }

  /// Create a workout log
  Future<String> createWorkoutLog({
    required String id,
    required String userId,
    required String title,
    required int durationMinutes,
    required String workoutType,
    double? caloriesBurned,
    String? rpeLevel,
    String? notes,
    String? gpsData,
  }) async {
    try {
      final response = await _databases.createDocument(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workoutLogs,
        documentId: id,
        data: {
          'userId': userId,
          'title': title,
          'durationMinutes': durationMinutes,
          'workoutType': workoutType,
          'calories': caloriesBurned,
          'rpeLevel': rpeLevel,
          'loggedAt': DateTime.now().toIso8601String(),
          'gpsData': gpsData,
          'syncStatus': 'synced',
        },
      );

      return response.$id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create workout log failed: ${e.message}');
      rethrow;
    }
  }

  /// Get workout logs for user
  Future<List<Map<String, dynamic>>> getWorkoutLogs(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.workoutLogs,
        queries: <String>[
          'userId="$userId"',
          'orderBy(loggedAt,DESC)',
          'limit(100)',
        ],
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get workout logs failed: ${e.message}');
      rethrow;
    }
  }

  /// Schedule a workout
  Future<String> scheduleWorkout({
    required String id,
    required String userId,
    required String workoutId,
    required DateTime scheduledDate,
    required String scheduledTime,
    bool isRestDay = false,
  }) async {
    try {
      final response = await _databases.createDocument(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.scheduledWorkouts,
        documentId: id,
        data: {
          'userId': userId,
          'workoutId': workoutId,
          'scheduledDate': scheduledDate.toIso8601String(),
          'scheduledTime': scheduledTime,
          'isRestDay': isRestDay,
          'isCompleted': false,
        },
      );

      return response.$id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Schedule workout failed: ${e.message}');
      rethrow;
    }
  }

  /// Get scheduled workouts for user
  Future<List<Map<String, dynamic>>> getScheduledWorkouts(
    String userId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queries = <String>['userId="$userId"'];

      if (startDate != null && endDate != null) {
        queries.add('scheduledDate>="${startDate.toIso8601String()}"');
        queries.add('scheduledDate<="${endDate.toIso8601String()}"');
      }

      queries.add('orderBy(scheduledDate,ASC)');
      queries.add('limit(100)');

      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.scheduledWorkouts,
        queries: queries,
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get scheduled workouts failed: ${e.message}');
      rethrow;
    }
  }

  /// Mark scheduled workout as completed
  Future<void> completeScheduledWorkout(String scheduledWorkoutId) async {
    try {
      await _databases.updateDocument(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.scheduledWorkouts,
        documentId: scheduledWorkoutId,
        data: {'isCompleted': true},
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Complete scheduled workout failed: ${e.message}');
      rethrow;
    }
  }

  /// Record a personal record
  Future<String> recordPersonalRecord({
    required String id,
    required String userId,
    required String recordType,
    required String exerciseName,
    required double value,
    required String unit,
    String? workoutLogId,
  }) async {
    try {
      final response = await _databases.createDocument(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.personalRecords,
        documentId: id,
        data: {
          'userId': userId,
          'recordType': recordType,
          'exerciseName': exerciseName,
          'value': value,
          'unit': unit,
          'achievedAt': DateTime.now().toIso8601String(),
          'workoutLogId': workoutLogId,
        },
      );

      return response.$id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Record personal record failed: ${e.message}');
      rethrow;
    }
  }

  /// Get personal records for user
  Future<List<Map<String, dynamic>>> getPersonalRecords(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.personalRecords,
        queries: <String>[
          'userId="$userId"',
          'orderBy(achievedAt,DESC)',
          'limit(50)',
        ],
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get personal records failed: ${e.message}');
      rethrow;
    }
  }

  /// Get best record for a specific type
  Future<Map<String, dynamic>?> getBestRecord(
    String userId,
    String recordType,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: WorkoutCollectionIds.databaseId,
        collectionId: WorkoutCollectionIds.personalRecords,
        queries: <String>[
          'userId="$userId"',
          'recordType="$recordType"',
          'orderBy(value,DESC)',
          'limit(1)',
        ],
      );

      if (response.documents.isEmpty) {
        return null;
      }

      return response.documents.first.data;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get best record failed: ${e.message}');
      return null;
    }
  }
}
