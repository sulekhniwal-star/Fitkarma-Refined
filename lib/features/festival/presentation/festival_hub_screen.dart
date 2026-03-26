// lib/features/festival/presentation/festival_hub_screen.dart
// Main Festival Hub Screen - displays upcoming festivals and features

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/festival/data/festival_data.dart';
import 'package:fitkarma/features/festival/data/festival_providers.dart';
import 'package:fitkarma/features/festival/data/festival_notification_service.dart';
import 'package:intl/intl.dart';

class FestivalHubScreen extends ConsumerWidget {
  const FestivalHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingFestivals = ref.watch(upcomingFestivalsProvider);
    final activeFestival = ref.watch(activeFestivalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Festivals'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotificationSettings(context, ref),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Festival Banner
            if (activeFestival != null) ...[
              _buildActiveFestivalBanner(context, activeFestival),
              const SizedBox(height: 24),
            ],

            // Festival Quick Access Grid
            const Text(
              'Festival Features',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildFeatureGrid(context),

            const SizedBox(height: 24),

            // Upcoming Festivals
            const Text(
              'Upcoming Festivals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildUpcomingFestivals(context, upcomingFestivals),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveFestivalBanner(BuildContext context, Festival festival) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [festival.type.color, festival.type.color.withAlpha(180)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(festival.type.icon, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎉 Currently Active!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      festival.type.displayName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            festival.type.description,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            '${festival.daysRemaining} days remaining',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildFeatureCard(
          context,
          icon: Icons.temple_hindu,
          title: 'Navratri',
          subtitle: '9-Day Fasting',
          color: const Color(0xFFE91E63),
          onTap: () => context.push('/home/festival/navratri'),
        ),
        _buildFeatureCard(
          context,
          icon: Icons.nights_stay,
          title: 'Ramadan',
          subtitle: 'Sehri & Iftar',
          color: const Color(0xFF4CAF50),
          onTap: () => context.push('/home/festival/ramadan'),
        ),
        _buildFeatureCard(
          context,
          icon: Icons.lightbulb,
          title: 'Diwali',
          subtitle: 'Sweet Tracker',
          color: const Color(0xFFFF9800),
          onTap: () => context.push('/home/festival/diwali'),
        ),
        _buildFeatureCard(
          context,
          icon: Icons.water_drop,
          title: 'Karwa Chauth',
          subtitle: 'Fasting Guide',
          color: const Color(0xFF9C27B0),
          onTap: () => context.push('/home/festival/karwa-chauth'),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingFestivals(
    BuildContext context,
    List<Festival> festivals,
  ) {
    if (festivals.isEmpty) {
      return const Center(child: Text('No upcoming festivals'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: festivals.length,
      itemBuilder: (context, index) {
        final festival = festivals[index];
        return _buildFestivalListItem(context, festival);
      },
    );
  }

  Widget _buildFestivalListItem(BuildContext context, Festival festival) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final daysUntil = festival.daysUntilStart;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: festival.type.color.withAlpha(30),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(festival.type.icon, color: festival.type.color),
        ),
        title: Text(
          festival.type.displayName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(festival.type.hindiName),
            Text(
              dateFormat.format(festival.startDate),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: daysUntil <= 7
                ? Colors.orange.withAlpha(30)
                : festival.type.color.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            daysUntil == 0
                ? 'Today!'
                : daysUntil == 1
                ? 'Tomorrow'
                : 'In $daysUntil days',
            style: TextStyle(
              color: daysUntil <= 7 ? Colors.orange : festival.type.color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        onTap: () => _navigateToFestival(context, festival.type),
      ),
    );
  }

  void _navigateToFestival(BuildContext context, FestivalType type) {
    switch (type) {
      case FestivalType.navratri:
        context.push('/home/festival/navratri');
        break;
      case FestivalType.ramadan:
        context.push('/home/festival/ramadan');
        break;
      case FestivalType.diwali:
        context.push('/home/festival/diwali');
        break;
      case FestivalType.karwaChauth:
        context.push('/home/festival/karwa-chauth');
        break;
      case FestivalType.holi:
        context.push('/home/festival/holi');
        break;
    }
  }

  void _showNotificationSettings(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Festival Notifications',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.notifications_active),
                title: const Text('Festival Reminders'),
                subtitle: const Text(
                  'Get notified 3 days before each festival',
                ),
                trailing: Switch(
                  value: true,
                  onChanged: (value) async {
                    if (value) {
                      final service = FestivalNotificationService();
                      await service.init();
                      await service.requestPermissions();
                      await service.scheduleFestivalReminders();
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final service = FestivalNotificationService();
                    await service.init();
                    await service.requestPermissions();
                    await service.scheduleFestivalReminders();
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Festival notifications scheduled!'),
                        ),
                      );
                    }
                  },
                  child: const Text('Enable Notifications'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
