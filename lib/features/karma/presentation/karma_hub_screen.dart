import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/challenge_card.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
      body: Stack(
        children: [
          // Pattern B - Hero Background
          Container(
            height: 280,
            decoration: BoxDecoration(
              gradient: isDark ? AppGradients.heroDeep : AppGradients.heroDeepLight,
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                   const _KarmaHero(),
                  
                  // Wrap body in a rounded container to create the "Warm Body" look
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColorsDark.bg1 : AppColorsLight.bg1,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _DailyRitualsSection(),
                        const SizedBox(height: 32),
                        const _ChallengeCarousel(),
                        const SizedBox(height: 32),
                        const _TrophyCaseSection(),
                        const SizedBox(height: 32),
                        _LeaderboardSection(tabController: _tabController),
                        const SizedBox(height: 32),
                        const _KarmaStoreSection(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Transparent AppBar overlaid
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text('Karma Hub', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}


class _KarmaHero extends ConsumerWidget {
  const _KarmaHero();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock user for now
    const currentXP = 4500;
    const progressToNext = 0.45;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/gamification/badge_warrior.png',
                height: 40,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Text(
                'Level 12 Warrior',
                style: AppTypography.h1(color: Colors.white).copyWith(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text('🪙', style: TextStyle(fontSize: 32)),
              const SizedBox(width: 12),
              Text(
                '4,500',
                style: AppTypography.monoXL(color: Colors.white),
              ),
              const SizedBox(width: 8),
              Text(
                'XP',
                style: AppTypography.h2(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const LinearProgressIndicator(
                  value: progressToNext,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '5,500 XP to next level',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Challenges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('सक्रिय चुनौतियाँ', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              ChallengeCarouselCard(
                title: '7-Day Step Warrior',
                description: 'Hit 10k steps for 7 days in a row.',
                progress: 0.6,
                xpReward: 500,
                onTap: () {},
              ),
              ChallengeCarouselCard(
                title: 'Navratri Fast Adherence',
                description: 'Log all Phalahar meals correctly.',
                progress: 0.3,
                xpReward: 300,
                festivalTag: 'Navratri',
                onTap: () {},
              ),
              ChallengeCarouselCard(
                title: 'Early Bird Streak',
                description: 'Wake up before 6 AM for 5 days.',
                progress: 0.8,
                xpReward: 1000,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daily Rituals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('दैनिक अनुष्ठान', style: TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 16),
          _RitualItem(title: 'Log Today\'s Weight', xp: '+10 XP', isDone: true, isDark: isDark),
          _RitualItem(title: 'Record Sleep Quality', xp: '+15 XP', isDone: false, isDark: isDark),
          _RitualItem(title: 'Complete 10m Meditation', xp: '+50 XP', isDone: false, isDark: isDark),
        ],
      ),
    );
  }
}

class _RitualItem extends StatelessWidget {
  final String title;
  final String xp;
  final bool isDone;
  final bool isDark;
  const _RitualItem({required this.title, required this.xp, required this.isDone, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDone 
          ? (isDark ? Colors.green.withValues(alpha: 0.1) : Colors.green.shade50)
          : (isDark ? AppColorsDark.surface0 : AppColorsLight.surface0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDone
            ? (isDark ? Colors.green.withValues(alpha: 0.3) : Colors.green.shade200)
            : (isDark ? AppColorsDark.divider : AppColorsLight.divider),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_off, 
            color: isDone ? Colors.green : (isDark ? Colors.grey.shade600 : Colors.grey),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title, 
              style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : null,
                color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          Text(
            xp, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: isDark ? AppColorsDark.primary : AppColorsLight.primary,
              fontSize: 12,
            ),
          ),
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

class _TrophyCaseSection extends StatelessWidget {
  const _TrophyCaseSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Achievements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('आपकी उपलब्धियां', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _TrophyItem(
                name: '30 Day Streak',
                assetPath: 'assets/images/gamification/streak_30_day.png',
                date: 'Unlocked 2d ago',
              ),
              _TrophyItem(
                name: 'Personal Best',
                assetPath: 'assets/images/gamification/trophy_pr.png',
                date: 'Unlocked 1w ago',
              ),
              _TrophyItem(
                name: 'Legend Rank',
                assetPath: 'assets/images/gamification/badge_legend.png',
                date: 'In Progress (85%)',
                isLocked: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrophyItem extends StatelessWidget {
  final String name;
  final String assetPath;
  final String date;
  final bool isLocked;

  const _TrophyItem({
    required this.name,
    required this.assetPath,
    required this.date,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLocked ? (isDark ? Colors.white10 : Colors.grey.shade200) : (isDark ? AppColorsDark.primary : AppColorsLight.primary).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Opacity(
              opacity: isLocked ? 0.3 : 1.0,
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 13,
              color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

