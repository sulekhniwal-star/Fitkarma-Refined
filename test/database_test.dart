import 'package:flutter_test/flutter_test.dart';
import 'package:fitkarma/core/storage/app_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDatabase', () {
    test('DAOs are accessible', () {
      final db = AppDatabase();
      expect(db.foodItemsDao, isNotNull);
      expect(db.foodLogsDao, isNotNull);
      expect(db.workoutLogsDao, isNotNull);
      expect(db.bloodPressureLogsDao, isNotNull);
      expect(db.glucoseLogsDao, isNotNull);
      db.close();
    });
  });
}