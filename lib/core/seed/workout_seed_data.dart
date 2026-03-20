// lib/core/seed/workout_seed_data.dart
// Seed data for predefined workouts

class WorkoutSeedData {
  static List<Map<String, dynamic>> getAllWorkouts() {
    return [
      // YOGA
      {
        'id': 'yoga_001',
        'title': 'Morning Yoga Flow',
        'description':
            'Start your day with this energizing 20-minute yoga sequence. Perfect for beginners looking to build a consistent yoga practice. This flow includes sun salutations, standing poses, and gentle stretches.',
        'youtubeId': 'yOG-Zt9K4s',
        'thumbnailUrl':
            'https://img.youtube.com/vi/yOG-Zt9K4s/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'beginner',
        'category': 'Yoga',
        'caloriesPerSession': 120,
        'isFeatured': true,
      },
      {
        'id': 'yoga_002',
        'title': 'Power Yoga',
        'description':
            'A challenging 30-minute yoga session that builds strength and flexibility. Includes arm balances, inversions, and deep stretches.',
        'youtubeId': 'GLy2rYHwUqY',
        'thumbnailUrl':
            'https://img.youtube.com/vi/GLy2rYHwUqY/maxresdefault.jpg',
        'durationMinutes': 30,
        'difficulty': 'intermediate',
        'category': 'Yoga',
        'caloriesPerSession': 200,
        'isFeatured': true,
      },
      {
        'id': 'yoga_003',
        'title': 'Relaxing Evening Yoga',
        'description':
            'Wind down with this calming 15-minute yoga sequence. Perfect for improving sleep quality and releasing tension.',
        'youtubeId': 'hJ7RpT1iGw',
        'thumbnailUrl':
            'https://img.youtube.com/vi/hJ7RpT1iGw/maxresdefault.jpg',
        'durationMinutes': 15,
        'difficulty': 'beginner',
        'category': 'Yoga',
        'caloriesPerSession': 80,
        'isFeatured': false,
      },
      {
        'id': 'yoga_004',
        'title': 'Yoga for Flexibility',
        'description':
            'Improve your overall flexibility with this 25-minute session focusing on deep stretches and hip openers.',
        'youtubeId': 'g_tea8ZNk5A',
        'thumbnailUrl':
            'https://img.youtube.com/vi/g_tea8ZNk5A/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'intermediate',
        'category': 'Yoga',
        'caloriesPerSession': 150,
        'isFeatured': false,
      },

      // HIIT
      {
        'id': 'hiit_001',
        'title': 'Full Body HIIT',
        'description':
            'Torch calories with this intense 20-minute HIIT workout. No equipment needed - just your body weight!',
        'youtubeId': 'ml6cT4AZdqI',
        'thumbnailUrl':
            'https://img.youtube.com/vi/ml6cT4AZdqI/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'intermediate',
        'category': 'HIIT',
        'caloriesPerSession': 250,
        'isFeatured': true,
      },
      {
        'id': 'hiit_002',
        'title': 'Beginner HIIT',
        'description':
            'Perfect for beginners! This 15-minute HIIT workout introduces fundamental movements at a manageable pace.',
        'youtubeId': 'mJxuIPVjd7k',
        'thumbnailUrl':
            'https://img.youtube.com/vi/mJxuIPVjd7k/maxresdefault.jpg',
        'durationMinutes': 15,
        'difficulty': 'beginner',
        'category': 'HIIT',
        'caloriesPerSession': 150,
        'isFeatured': true,
      },
      {
        'id': 'hiit_003',
        'title': 'HIIT Cardio Blast',
        'description':
            'Get your heart pumping with this 25-minute cardio-focused HIIT workout. Great for endurance building.',
        'youtubeId': 'P3iN17b6v4I',
        'thumbnailUrl':
            'https://img.youtube.com/vi/P3iN17b6v4I/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'advanced',
        'category': 'HIIT',
        'caloriesPerSession': 350,
        'isFeatured': false,
      },
      {
        'id': 'hiit_004',
        'title': 'Tabata Burn',
        'description':
            'Classic Tabata protocol: 20 seconds work, 10 seconds rest. 8 rounds of high-intensity exercises.',
        'youtubeId': 'JX5j3wTzQQU',
        'thumbnailUrl':
            'https://img.youtube.com/vi/JX5j3wTzQQU/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'advanced',
        'category': 'HIIT',
        'caloriesPerSession': 300,
        'isFeatured': false,
      },

      // STRENGTH
      {
        'id': 'strength_001',
        'title': 'Full Body Strength',
        'description':
            'Build lean muscle with this comprehensive 30-minute strength training workout. Uses bodyweight exercises.',
        'youtubeId': 'F63hcp3bW2w',
        'thumbnailUrl':
            'https://img.youtube.com/vi/F63hcp3bW2w/maxresdefault.jpg',
        'durationMinutes': 30,
        'difficulty': 'intermediate',
        'category': 'Strength',
        'caloriesPerSession': 220,
        'isFeatured': true,
      },
      {
        'id': 'strength_002',
        'title': 'Upper Body Strength',
        'description':
            'Focus on arms, shoulders, chest, and back with this targeted 20-minute upper body workout.',
        'youtubeId': 'rMvh57_QGQY',
        'thumbnailUrl':
            'https://img.youtube.com/vi/rMvh57_QGQY/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'intermediate',
        'category': 'Strength',
        'caloriesPerSession': 180,
        'isFeatured': false,
      },
      {
        'id': 'strength_003',
        'title': 'Lower Body Strength',
        'description':
            'Strengthen your legs and glutes with this challenging 25-minute lower body workout.',
        'youtubeId': 'UXJrBGqmsFU',
        'thumbnailUrl':
            'https://img.youtube.com/vi/UXJrBGqmsFU/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'intermediate',
        'category': 'Strength',
        'caloriesPerSession': 200,
        'isFeatured': false,
      },
      {
        'id': 'strength_004',
        'title': 'Beginner Strength',
        'description':
            'Perfect for those new to strength training. Learn proper form with fundamental movements.',
        'youtubeId': '0jT_1vJ4k6w',
        'thumbnailUrl':
            'https://img.youtube.com/vi/0jT_1vJ4k6w/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'beginner',
        'category': 'Strength',
        'caloriesPerSession': 130,
        'isFeatured': true,
      },

      // DANCE
      {
        'id': 'dance_001',
        'title': 'Bollywood Dance Workout',
        'description':
            'Dance your way to fitness with this fun 25-minute Bollywood-inspired dance workout. No dance experience needed!',
        'youtubeId': '59E8wCZG9s',
        'thumbnailUrl':
            'https://img.youtube.com/vi/59E8wCZG9s/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'beginner',
        'category': 'Dance',
        'caloriesPerSession': 200,
        'isFeatured': true,
      },
      {
        'id': 'dance_002',
        'title': 'Hip Hop Dance Cardio',
        'description':
            'Learn cool hip hop moves while burning calories in this energetic 20-minute workout.',
        'youtubeId': 'VfJzhdJ4ku',
        'thumbnailUrl':
            'https://img.youtube.com/vi/VfJzhdJ4ku/maxresdefault.jpg',
        'durationMinutes': 20,
        'difficulty': 'intermediate',
        'category': 'Dance',
        'caloriesPerSession': 220,
        'isFeatured': false,
      },
      {
        'id': 'dance_003',
        'title': 'Latin Dance Fitness',
        'description':
            'Feel the rhythm with this Latin-inspired dance workout. Includes salsa, merengue, and cumbia moves.',
        'youtubeId': 'XQZegRIi7O4',
        'thumbnailUrl':
            'https://img.youtube.com/vi/XQZegRIi7O4/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'intermediate',
        'category': 'Dance',
        'caloriesPerSession': 250,
        'isFeatured': false,
      },

      // BOLLYWOOD
      {
        'id': 'bollywood_001',
        'title': 'Bollywood Fitness Dance',
        'description':
            'The ultimate Bollywood fitness experience! This 30-minute workout combines traditional Bollywood dance moves with fitness exercises.',
        'youtubeId': 'NWKfUbhjus',
        'thumbnailUrl':
            'https://img.youtube.com/vi/NWKfUbhjus/maxresdefault.jpg',
        'durationMinutes': 30,
        'difficulty': 'intermediate',
        'category': 'Bollywood',
        'caloriesPerSession': 280,
        'isFeatured': true,
      },
      {
        'id': 'bollywood_002',
        'title': 'Easy Bollywood Moves',
        'description':
            'Learn easy-to-follow Bollywood dance moves in this beginner-friendly 15-minute session.',
        'youtubeId': 'V7a4R7GRom',
        'thumbnailUrl':
            'https://img.youtube.com/vi/V7a4R7GRom/maxresdefault.jpg',
        'durationMinutes': 15,
        'difficulty': 'beginner',
        'category': 'Bollywood',
        'caloriesPerSession': 150,
        'isFeatured': true,
      },
      {
        'id': 'bollywood_003',
        'title': 'Bollywood Cardio Burn',
        'description':
            'High-energy Bollywood-themed cardio workout. Dance, sweat, and have fun!',
        'youtubeId': 'tZ3cK6W1pWw',
        'thumbnailUrl':
            'https://img.youtube.com/vi/tZ3cK6W1pWw/maxresdefault.jpg',
        'durationMinutes': 25,
        'difficulty': 'intermediate',
        'category': 'Bollywood',
        'caloriesPerSession': 300,
        'isFeatured': false,
      },

      // PRANAYAMA
      {
        'id': 'pranayama_001',
        'title': 'Morning Pranayama',
        'description':
            'Start your day with powerful breathing techniques. This 10-minute session includes Kapalabhati, Bhastrika, and Anulom Vilom.',
        'youtubeId': 'R4zqJN3nKz4',
        'thumbnailUrl':
            'https://img.youtube.com/vi/R4zqJN3nKz4/maxresdefault.jpg',
        'durationMinutes': 10,
        'difficulty': 'beginner',
        'category': 'Pranayama',
        'caloriesPerSession': 30,
        'isFeatured': true,
      },
      {
        'id': 'pranayama_002',
        'title': 'Deep Breathing Relaxation',
        'description':
            'Calm your mind and reduce stress with this guided deep breathing session. Perfect for relaxation.',
        'youtubeId': '3T2z3Hk8UZU',
        'thumbnailUrl':
            'https://img.youtube.com/vi/3T2z3Hk8UZU/maxresdefault.jpg',
        'durationMinutes': 10,
        'difficulty': 'beginner',
        'category': 'Pranayama',
        'caloriesPerSession': 20,
        'isFeatured': true,
      },
      {
        'id': 'pranayama_003',
        'title': 'Energizing Breath Work',
        'description':
            'Boost your energy levels with these powerful pranayama techniques. Great for afternoon slumps!',
        'youtubeId': 'Q3jU0cZ3jN4',
        'thumbnailUrl':
            'https://img.youtube.com/vi/Q3jU0cZ3jN4/maxresdefault.jpg',
        'durationMinutes': 12,
        'difficulty': 'intermediate',
        'category': 'Pranayama',
        'caloriesPerSession': 40,
        'isFeatured': false,
      },
      {
        'id': 'pranayama_004',
        'title': 'Sleep Breathing',
        'description':
            'Prepare for a restful sleep with this calming breathing practice before bed.',
        'youtubeId': 'v8Z4v8Z4v8Z',
        'thumbnailUrl':
            'https://img.youtube.com/vi/v8Z4v8Z4v8Z/maxresdefault.jpg',
        'durationMinutes': 10,
        'difficulty': 'beginner',
        'category': 'Pranayama',
        'caloriesPerSession': 15,
        'isFeatured': false,
      },
    ];
  }

  static List<String> getCategories() {
    return ['Yoga', 'HIIT', 'Strength', 'Dance', 'Bollywood', 'Pranayama'];
  }

  static List<String> getDifficulties() {
    return ['beginner', 'intermediate', 'advanced'];
  }

  static Map<String, String> getCategoryIcons() {
    return {
      'Yoga': '🧘',
      'HIIT': '🔥',
      'Strength': '💪',
      'Dance': '💃',
      'Bollywood': '🎬',
      'Pranayama': '🌬️',
    };
  }

  static Map<String, String> getDifficultyColors() {
    return {
      'beginner': '#4CAF50', // Green
      'intermediate': '#FF9800', // Orange
      'advanced': '#F44336', // Red
    };
  }
}
