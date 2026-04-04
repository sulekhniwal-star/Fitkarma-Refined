import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final moodHeatmapProvider = FutureProvider.family<List<MoodHeatmapData>, MoodHeatmapParams>((ref, params) async {
  final db = ref.read(appDatabaseProvider);
  return db.moodLogsDao.getMoodHeatmap(params.userId, params.days);
});

class MoodHeatmapParams {
  final String userId;
  final int days;

  MoodHeatmapParams({required this.userId, this.days = 30});
}

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MoodHistoryScreen extends ConsumerWidget {
  final String userId;

  const MoodHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatmapAsync = ref.watch(moodHeatmapProvider(MoodHeatmapParams(userId: userId)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Trends'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => context.push('/mood/log', extra: userId)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildLegend(),
            _buildHeatmapCalendar(heatmapAsync),
            _buildRecentMoods(heatmapAsync),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Mood: '),
          _legendColor(Colors.red.shade300, '😢'),
          _legendColor(Colors.orange.shade300, '😔'),
          _legendColor(Colors.yellow.shade300, '😐'),
          _legendColor(Colors.lightGreen.shade300, '🙂'),
          _legendColor(Colors.green.shade400, '😊'),
        ],
      ),
    );
  }

  Widget _legendColor(Color color, String emoji) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(emoji, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildHeatmapCalendar(AsyncValue<List<MoodHeatmapData>> heatmapAsync) {
    return heatmapAsync.when(
      data: (data) {
        final weeks = _groupByWeeks(data);
        
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Last 30 Days', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...weeks.map((week) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: week.map((day) {
                    return Container(
                      width: 36, height: 36,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: day.color ?? Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '${day.date.day}',
                          style: TextStyle(
                            fontSize: 12,
                            color: day.moodScore != null && day.moodScore! >= 3
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )),
            ],
          ),
        );
      },
      loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator())),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  List<List<MoodHeatmapData>> _groupByWeeks(List<MoodHeatmapData> data) {
    final weeks = <List<MoodHeatmapData>>[];
    var currentWeek = <MoodHeatmapData>[];
    
    for (int i = 0; i < data.length; i++) {
      currentWeek.add(data[i]);
      if (data[i].date.weekday == 7 || i == data.length - 1) {
        while (currentWeek.length < 7) {
          currentWeek.add(MoodHeatmapData(date: DateTime(2000), moodScore: null));
        }
        weeks.add(currentWeek);
        currentWeek = <MoodHeatmapData>[];
      }
    }
    
    return weeks;
  }

  Widget _buildRecentMoods(AsyncValue<List<MoodHeatmapData>> heatmapAsync) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Moods', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text('Mood logs will appear here', style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}