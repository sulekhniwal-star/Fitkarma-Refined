import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/di/providers.dart';

final workoutAwServiceProvider = Provider<WorkoutAwService>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return WorkoutAwService(client);
});

class WorkoutAwService {
  final Client _client;
  late final Databases _databases;

  static const String _databaseId = AppConfig.appwriteDatabaseId;
  static const String _workoutsCollectionId = 'workouts';

  WorkoutAwService(this._client) {
    _databases = Databases(_client);
  }

  Future<List<WorkoutData>> getWorkoutsByCategory(String category) async {
    final response = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _workoutsCollectionId,
      queries: [
        Query.equal('category', [category]),
        Query.orderAsc('title'),
      ],
    );
    return response.documents.map((doc) => WorkoutData.fromDoc(doc)).toList();
  }

  Future<List<WorkoutData>> getAllWorkouts() async {
    final response = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _workoutsCollectionId,
      queries: [Query.orderAsc('title')],
    );
    return response.documents.map((doc) => WorkoutData.fromDoc(doc)).toList();
  }

  Future<WorkoutData?> getWorkoutById(String id) async {
    try {
      final doc = await _databases.getDocument(
        databaseId: _databaseId,
        collectionId: _workoutsCollectionId,
        documentId: id,
      );
      return WorkoutData.fromDoc(doc);
    } catch (e) {
      return null;
    }
  }

  Future<void> seedWorkouts() async {
    final workouts = _getSeedWorkouts();
    for (final workout in workouts) {
      try {
        await _databases.createDocument(
          databaseId: _databaseId,
          collectionId: _workoutsCollectionId,
          documentId: workout['videoId'] as String,
          data: workout,
          permissions: [],
        );
      } catch (e) {
        // Already exists
      }
    }
  }

  List<Map<String, dynamic>> _getSeedWorkouts() {
    return [
      // Yoga
      {
        'title': 'Morning Yoga Flow',
        'videoId': 'y4T45Oq4fT4',
        'duration': 20,
        'difficulty': 'beginner',
        'category': 'Yoga',
        'description': 'Start your day with this gentle yoga flow to awaken your body and mind.',
        'caloriesPerMin': 3,
      },
      {
        'title': 'Power Yoga',
        'videoId': 'JtbFh8b16JQ',
        'duration': 45,
        'difficulty': 'intermediate',
        'category': 'Yoga',
        'description': 'A challenging yoga session building strength and flexibility.',
        'caloriesPerMin': 5,
      },
      {
        'title': 'Yoga for Flexibility',
        'videoId': 'vN1u2E5r0Tg',
        'duration': 30,
        'difficulty': 'beginner',
        'category': 'Yoga',
        'description': 'Improve your flexibility with this comprehensive stretch routine.',
        'caloriesPerMin': 3,
      },
      // HIIT
      {
        'title': '20-Min HIIT Blast',
        'videoId': 'ml6cT4AZdqI',
        'duration': 20,
        'difficulty': 'advanced',
        'category': 'HIIT',
        'description': 'High-intensity interval training for maximum calorie burn.',
        'caloriesPerMin': 12,
      },
      {
        'title': 'Beginner HIIT',
        'videoId': 'qULTwquOu54',
        'duration': 15,
        'difficulty': 'beginner',
        'category': 'HIIT',
        'description': 'Perfect for beginners looking to start their HIIT journey.',
        'caloriesPerMin': 8,
      },
      {
        'title': 'Tabata Workout',
        'videoId': 'oDkaM86Cg8Y',
        'duration': 25,
        'difficulty': 'intermediate',
        'category': 'HIIT',
        'description': 'Classic Tabata protocol with 20s work, 10s rest intervals.',
        'caloriesPerMin': 10,
      },
      // Strength
      {
        'title': 'Full Body Strength',
        'videoId': 'Bk90kVQ4ymU',
        'duration': 40,
        'difficulty': 'intermediate',
        'category': 'Strength',
        'description': 'Build muscle all over with this comprehensive strength routine.',
        'caloriesPerMin': 7,
      },
      {
        'title': 'Upper Body Strength',
        'videoId': 'Vq9xX5Z4w0Y',
        'duration': 30,
        'difficulty': 'intermediate',
        'category': 'Strength',
        'description': 'Focus on arms, shoulders, and back with this targeted workout.',
        'caloriesPerMin': 6,
      },
      {
        'title': 'Core Strength',
        'videoId': 'AhgZ5R8q1PQ',
        'duration': 15,
        'difficulty': 'beginner',
        'category': 'Strength',
        'description': 'Strengthen your core with these effective ab exercises.',
        'caloriesPerMin': 5,
      },
      // Dance
      {
        'title': 'Bollywood Dance Workout',
        'videoId': 'dancer1',
        'duration': 25,
        'difficulty': 'beginner',
        'category': 'Dance',
        'description': 'Fun Bollywood-inspired dance moves to burn calories.',
        'caloriesPerMin': 7,
      },
      {
        'title': 'Hip Hop Dance',
        'videoId': 'dancer2',
        'duration': 30,
        'difficulty': 'intermediate',
        'category': 'Dance',
        'description': 'Learn cool hip hop moves while getting fit.',
        'caloriesPerMin': 8,
      },
      // Pranayama
      {
        'title': 'Breathing Basics',
        'videoId': 'b1H3xO3x5pQ',
        'duration': 10,
        'difficulty': 'beginner',
        'category': 'Pranayama',
        'description': 'Learn fundamental breathing techniques for wellness.',
        'caloriesPerMin': 1,
      },
      {
        'title': 'Relaxation Breathing',
        'videoId': 'b2H4y4O4rRs',
        'duration': 15,
        'difficulty': 'beginner',
        'category': 'Pranayama',
        'description': 'Deep breathing exercises for stress relief and relaxation.',
        'caloriesPerMin': 1,
      },
    ];
  }
}

class WorkoutData {
  final String id;
  final String title;
  final String videoId;
  final int duration;
  final String difficulty;
  final String category;
  final String description;
  final double caloriesPerMin;

  WorkoutData({
    required this.id,
    required this.title,
    required this.videoId,
    required this.duration,
    required this.difficulty,
    required this.category,
    required this.description,
    required this.caloriesPerMin,
  });

  factory WorkoutData.fromDoc(dynamic doc) {
    return WorkoutData(
      id: doc.$id,
      title: doc.data['title'] as String? ?? '',
      videoId: doc.data['videoId'] as String? ?? '',
      duration: doc.data['duration'] as int? ?? 0,
      difficulty: doc.data['difficulty'] as String? ?? 'beginner',
      category: doc.data['category'] as String? ?? '',
      description: doc.data['description'] as String? ?? '',
      caloriesPerMin: (doc.data['caloriesPerMin'] as num?)?.toDouble() ?? 0,
    );
  }
}

class WorkoutCategory {
  final String name;
  final String icon;
  final String description;

  const WorkoutCategory({
    required this.name,
    required this.icon,
    required this.description,
  });

  static const List<WorkoutCategory> all = [
    WorkoutCategory(name: 'Yoga', icon: '🧘', description: 'Flexibility & Mindfulness'),
    WorkoutCategory(name: 'HIIT', icon: '⚡', description: 'High Intensity Intervals'),
    WorkoutCategory(name: 'Strength', icon: '💪', description: 'Build Muscle'),
    WorkoutCategory(name: 'Dance', icon: '💃', description: 'Fun Cardio'),
    WorkoutCategory(name: 'Bollywood', icon: '🎬', description: 'Bollywood Dance'),
    WorkoutCategory(name: 'Pranayama', icon: '🌬️', description: 'Breathing Exercises'),
  ];
}