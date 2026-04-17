import 'package:home_widget/home_widget.dart';
import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';

class HomeWidgetService {
  final AppDatabase db;

  HomeWidgetService({required this.db});

  /// Updates activity ring data for widgets
  Future<void> updateActivityRings(String userId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);

    // 1. Fetch steps
    final stepsResult = await (db.select(db.stepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerOrEqualValue(todayStart)))
        .get();
    final totalSteps = stepsResult.fold(0, (sum, log) => sum + log.stepCount);

    // 2. Water intake (using FoodLogs as hydration tracker if available)
    // TODO: Add WaterLogs table to database
    final totalWater = 0.0;

    // 3. Save to HomeWidget storage
    await HomeWidget.saveWidgetData<int>('steps_count', totalSteps);
    await HomeWidget.saveWidgetData<double>('water_count', totalWater);
    await HomeWidget.saveWidgetData<int>('calories_burned', 450); // Mock
    
    // 4. Signal platform update
    await HomeWidget.updateWidget(
      name: 'ActivityRingsWidgetProvider', // Android class name
      androidName: 'ActivityRingsWidgetProvider',
      iOSName: 'ActivityRingsWidget',
    );
  }

  /// Updates the festival countdown widget
  Future<void> updateFestivalCountdown() async {
    final now = DateTime.now();
    final nextFestival = await (db.select(db.festivalCalendar)
          ..where((t) => t.startDate.isBiggerOrEqualValue(now))
          ..orderBy([(t) => OrderingTerm(expression: t.startDate, mode: OrderingMode.asc)])
          ..limit(1))
        .getSingleOrNull();

    if (nextFestival != null) {
      final daysLeft = nextFestival.startDate.difference(now).inDays;
      await HomeWidget.saveWidgetData<String>('festival_name', nextFestival.nameEn);
      await HomeWidget.saveWidgetData<int>('festival_days', daysLeft);
      
      await HomeWidget.updateWidget(
        name: 'FestivalCountdownWidgetProvider',
        androidName: 'FestivalCountdownWidgetProvider',
        iOSName: 'FestivalCountdownWidget',
      );
    }
  }
}

