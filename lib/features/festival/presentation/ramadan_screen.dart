// lib/features/festival/presentation/ramadan_screen.dart
// Ramadan Sehri/Iftar planner integrated with Fasting Tracker

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/festival/data/festival_data.dart';
import 'package:fitkarma/features/festival/data/festival_providers.dart';

class RamadanScreen extends ConsumerStatefulWidget {
  const RamadanScreen({super.key});

  @override
  ConsumerState<RamadanScreen> createState() => _RamadanScreenState();
}

class _RamadanScreenState extends ConsumerState<RamadanScreen> {
  TimeOfDay? _sehriTime;
  TimeOfDay? _iftarTime;

  @override
  Widget build(BuildContext context) {
    final planner = ref.watch(sehriIftarPlannerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramadan'),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ramadan Info Card
            Card(
              color: const Color(0xFF4CAF50),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.nights_stay, color: Colors.white, size: 32),
                        SizedBox(width: 12),
                        Text(
                          'Ramadan Mubarak!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Fast from Sehri to Iftar. Track your meals and stay healthy during this holy month.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/home/fasting'),
                        icon: const Icon(Icons.timer),
                        label: const Text('Open Fasting Tracker'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4CAF50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Time Settings
            const Text(
              'Sehri & Iftar Times',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildTimeCard(
                    title: 'Sehri',
                    subtitle: 'Pre-dawn meal',
                    icon: Icons.wb_sunny,
                    time: _sehriTime,
                    onTap: () => _selectTime(true),
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTimeCard(
                    title: 'Iftar',
                    subtitle: 'Sunset meal',
                    icon: Icons.nightlight_round,
                    time: _iftarTime,
                    onTap: () => _selectTime(false),
                    color: const Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recommended Foods
            const Text(
              'Sehri Foods (Pre-dawn)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildFoodSection(FoodCategory.sehri),

            const SizedBox(height: 16),

            const Text(
              'Iftar Foods (Sunset)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildFoodSection(FoodCategory.iftar),

            const SizedBox(height: 24),

            // Guidelines
            const Text(
              'Ramadan Fasting Tips',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildGuidelines(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required TimeOfDay? time,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                time?.format(context) ?? 'Set time',
                style: TextStyle(
                  color: time != null ? color : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodSection(FoodCategory category) {
    final foods = FestivalDatabase()
        .getFestivalsForYear(DateTime.now().year)
        .where((f) => f.type == FestivalType.ramadan)
        .expand((f) => f.recommendedFoods ?? [])
        .toList();

    if (foods.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No food recommendations available'),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      food.nameHindi,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                    const Spacer(),
                    Text(
                      '~${food.caloriesPer100g.toInt()} cal/100g',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      food.healthTip,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuidelines() {
    final guidelines =
        FestivalDatabase()
            .getFestivalsForYear(DateTime.now().year)
            .where((f) => f.type == FestivalType.ramadan)
            .firstOrNull
            ?.fastingGuidelines ??
        [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: guidelines
              .map(
                (guideline) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF4CAF50),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(guideline)),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Future<void> _selectTime(bool isSehri) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isSehri
          ? const TimeOfDay(hour: 4, minute: 30)
          : const TimeOfDay(hour: 18, minute: 30),
    );

    if (time != null) {
      setState(() {
        if (isSehri) {
          _sehriTime = time;
        } else {
          _iftarTime = time;
        }
      });
    }
  }
}

enum FoodCategory { sehri, iftar }
