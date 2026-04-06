import '../../../core/storage/app_database.dart';

class WorkoutRepository {
  final AppDatabase db;

  WorkoutRepository(this.db);

  Future<List<Workout>> getAllWorkouts() => db.workoutsDao.getAllWorkouts();
  
  Future<Workout?> getWorkoutById(String id) => 
      (db.select(db.workouts)..where((t) => t.id.equals(id))).getSingleOrNull();
  
  Future<List<Workout>> getByCategory(String category) => 
      db.workoutsDao.getByCategory(category);

  Future<void> seedWorkouts() async {
    final existing = await db.workoutsDao.getAllWorkouts();
    if (existing.isNotEmpty) return;

    final items = [
      Workout(
        id: '1',
        title: 'Morning Surya Namaskar',
        youtubeId: null,
        durationMin: 15,
        difficulty: 'Beginner',
        category: 'Yoga',
        language: 'en',
        isPremium: false,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b',
      ),
      Workout(
        id: '2',
        title: 'High Intensity HIIT',
        youtubeId: null,
        durationMin: 20,
        difficulty: 'Advanced',
        category: 'HIIT',
        language: 'en',
        isPremium: false,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438',
      ),
      Workout(
        id: '3',
        title: 'Bollywood Dance Workout',
        youtubeId: null,
        durationMin: 30,
        difficulty: 'Intermediate',
        category: 'Dance',
        language: 'en',
        isPremium: false,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad',
      ),
      Workout(
        id: '4',
        title: 'Core Strength Basics',
        youtubeId: null,
        durationMin: 25,
        difficulty: 'Beginner',
        category: 'Strength',
        language: 'en',
        isPremium: false,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1541534741688-6078c64b52de',
      ),
      Workout(
        id: '5',
        title: 'Pranayama & Breathing',
        youtubeId: null,
        durationMin: 10,
        difficulty: 'Beginner',
        category: 'Pranayama',
        language: 'en',
        isPremium: false,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773',
      ),
      Workout(
        id: '6',
        title: 'Upper Body Pump',
        youtubeId: null,
        durationMin: 45,
        difficulty: 'Advanced',
        category: 'Strength',
        language: 'en',
        isPremium: true,
        rpeLevel: null,
        thumbnailUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e',
      ),
      Workout(
        id: '7',
        title: 'Garba Night Cardio',
        youtubeId: null,
        durationMin: 45,
        difficulty: 'Intermediate',
        category: 'Dance',
        language: 'en',
        isPremium: false,
        rpeLevel: 6, // MET ~6.5
        thumbnailUrl: 'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad',
      ),
    ];

    await db.batch((batch) {
      batch.insertAll(db.workouts, items);
    });
  }
}