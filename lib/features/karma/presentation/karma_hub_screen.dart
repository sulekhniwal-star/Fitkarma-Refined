import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/karma_repository.dart';

class KarmaHubScreen extends ConsumerStatefulWidget {
  const KarmaHubScreen({super.key});

  @override
  ConsumerState<KarmaHubScreen> createState() => _KarmaHubScreenState();
}

class _KarmaHubScreenState extends ConsumerState<KarmaHubScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karma Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _KarmaHeader(),
            const SizedBox(height: 24),
            const _ChallengeCarousel(),
            const SizedBox(height: 24),
            _LeaderboardSection(tabController: _tabController),
            const SizedBox(height: 24),
            const _DailyRitualsSection(),
            const SizedBox(height: 24),
            const _KarmaStoreSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _KarmaHeader extends ConsumerWidget {
  const _KarmaHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karmaRepo = ref.watch(karmaRepositoryProvider);
    // Mock user for now
    const currentXP = 4500;
    final level = karmaRepo.computeLevel(currentXP);
    final title = karmaRepo.getLevelTitle(level);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade700, Colors.orange.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Karma Level',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white24,
                child: Text(
                  'L$level',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.stars, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                '$currentXP / 100,000 XP',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: currentXP / 100000,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}

class _ChallengeCarousel extends StatelessWidget {
  const _ChallengeCarousel();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Active Challenges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _ChallengeCard(title: '7-Day Step Warrior', reward: '+500 XP', progress: 0.6, icon: Icons.directions_walk),
              _ChallengeCard(title: 'Water Hydrator XL', reward: '+300 XP', progress: 0.3, icon: Icons.water_drop),
              _ChallengeCard(title: 'Early Bird Streak', reward: '+1000 XP', progress: 0.8, icon: Icons.wb_sunny),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final String title;
  final String reward;
  final double progress;
  final IconData icon;
  const _ChallengeCard({required this.title, required this.reward, required this.progress, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          const Spacer(),
          Text(reward, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade100,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardSection extends StatelessWidget {
  final TabController tabController;
  const _LeaderboardSection({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Leaderboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        TabBar(
          controller: tabController,
          labelColor: Colors.orange.shade800,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Friends'),
            Tab(text: 'City'),
            Tab(text: 'National'),
            Tab(text: 'Seasonal'),
          ],
        ),
        SizedBox(
          height: 300,
          child: TabBarView(
            controller: tabController,
            children: [
              _LeaderboardList(category: 'Friends'),
              _LeaderboardList(category: 'City'),
              _LeaderboardList(category: 'National'),
              _LeaderboardList(category: 'Seasonal'),
            ],
          ),
        ),
      ],
    );
  }
}

class _LeaderboardList extends StatelessWidget {
  final String category;
  const _LeaderboardList({required this.category});

  @override
  Widget build(BuildContext context) {
    final mockUsers = [
      {'name': 'Arjun Mehta', 'xp': '12,450', 'rank': '1'},
      {'name': 'Priya Das', 'xp': '11,200', 'rank': '2'},
      {'name': 'You', 'xp': '4,500', 'rank': '42'},
      {'name': 'Sneha K.', 'xp': '4,200', 'rank': '43'},
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockUsers.length,
      itemBuilder: (context, index) {
        final user = mockUsers[index];
        final isMe = user['name'] == 'You';
        return ListTile(
          leading: CircleAvatar(child: Text(user['rank']!)),
          title: Text(user['name']!, style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
          trailing: Text('${user['xp']} XP', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
          tileColor: isMe ? Colors.orange.shade50 : null,
        );
      },
    );
  }
}

class _DailyRitualsSection extends StatelessWidget {
  const _DailyRitualsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Rituals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _RitualItem(title: 'Log Today\'s Weight', xp: '+10 XP', isDone: true),
          _RitualItem(title: 'Record Sleep Quality', xp: '+15 XP', isDone: false),
          _RitualItem(title: 'Complete 10m Meditation', xp: '+50 XP', isDone: false),
        ],
      ),
    );
  }
}

class _RitualItem extends StatelessWidget {
  final String title;
  final String xp;
  final bool isDone;
  const _RitualItem({required this.title, required this.xp, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDone ? Colors.green.shade50 : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.radio_button_off, color: isDone ? Colors.green : Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null))),
          Text(xp, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        ],
      ),
    );
  }
}

class _KarmaStoreSection extends StatelessWidget {
  const _KarmaStoreSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Karma Store', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _StoreItem(name: 'Streak Shield', cost: '50 XP', icon: Icons.shield),
              const SizedBox(width: 12),
              _StoreItem(name: 'Double XP (24h)', cost: '200 XP', icon: Icons.bolt),
            ],
          ),
        ],
      ),
    );
  }
}

class _StoreItem extends StatelessWidget {
  final String name;
  final String cost;
  final IconData icon;
  const _StoreItem({required this.name, required this.cost, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.amber.shade800),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 4),
            Text(cost, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Redeem', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }
}
