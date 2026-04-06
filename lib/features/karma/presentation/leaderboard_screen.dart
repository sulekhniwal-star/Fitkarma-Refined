import 'package:flutter/material.dart';
import '../../../shared/theme/app_colors.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Leaderboard · लीडरबोर्ड'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tab,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Friends'),
            Tab(text: 'City'),
            Tab(text: 'National'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _LeaderboardTab(entries: _friendsData, isMyRank: true),
          _LeaderboardTab(entries: _cityData),
          _LeaderboardTab(entries: _nationalData),
        ],
      ),
    );
  }
}

// ── Sample Data ───────────────────────────────────────────────────────────────
class _LeaderEntry {
  const _LeaderEntry(this.rank, this.name, this.city, this.xp, {this.isMe = false});
  final int rank;
  final String name;
  final String city;
  final int xp;
  final bool isMe;
}

final _friendsData = [
  const _LeaderEntry(1, 'Priya Sharma', 'Mumbai', 2840),
  const _LeaderEntry(2, 'You', 'Delhi', 2100, isMe: true),
  const _LeaderEntry(3, 'Rajan Mehta', 'Pune', 1990),
  const _LeaderEntry(4, 'Ananya Singh', 'Bangalore', 1750),
  const _LeaderEntry(5, 'Vikram Das', 'Chennai', 1400),
];

final _cityData = [
  const _LeaderEntry(1, 'Aarav Patel', 'Delhi', 6200),
  const _LeaderEntry(2, 'Sunita Modi', 'Delhi', 5910),
  const _LeaderEntry(3, 'You', 'Delhi', 2100, isMe: true),
  const _LeaderEntry(4, 'Kiran Gupta', 'Delhi', 1980),
  const _LeaderEntry(5, 'Manish Tiwari', 'Delhi', 1800),
];

final _nationalData = [
  const _LeaderEntry(1, 'Arjun Reddy', 'Hyderabad', 18400),
  const _LeaderEntry(2, 'Meera Nair', 'Kochi', 17900),
  const _LeaderEntry(3, 'Suresh Kumar', 'Chennai', 16500),
  const _LeaderEntry(4, 'Divya Iyer', 'Bangalore', 15200),
  const _LeaderEntry(5, 'Rahul Bose', 'Kolkata', 14800),
];

// ── Tab Widget ────────────────────────────────────────────────────────────────
class _LeaderboardTab extends StatelessWidget {
  const _LeaderboardTab({required this.entries, this.isMyRank = false});
  final List<_LeaderEntry> entries;
  final bool isMyRank;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopThreePodium(entries: entries.take(3).toList()),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: entries.length,
            itemBuilder: (context, i) => _RankTile(entry: entries[i]),
          ),
        ),
      ],
    );
  }
}

class _TopThreePodium extends StatelessWidget {
  const _TopThreePodium({required this.entries});
  final List<_LeaderEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6C3DC8), Color(0xFF3D1A7A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (entries.length > 1) _PodiumBar(entry: entries[1], height: 90),
          _PodiumBar(entry: entries[0], height: 120, crown: true),
          if (entries.length > 2) _PodiumBar(entry: entries[2], height: 70),
        ],
      ),
    );
  }
}

class _PodiumBar extends StatelessWidget {
  const _PodiumBar({required this.entry, required this.height, this.crown = false});
  final _LeaderEntry entry;
  final double height;
  final bool crown;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (crown) const Text('👑', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Text(entry.name.split(' ').first,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text('${entry.xp} XP',
            style: const TextStyle(color: Color(0xFFFFD700), fontSize: 10)),
        const SizedBox(height: 6),
        Container(
          width: 72,
          height: height,
          decoration: BoxDecoration(
            color: crown ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              '#${entry.rank}',
              style: TextStyle(
                color: crown ? const Color(0xFF3D1A7A) : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RankTile extends StatelessWidget {
  const _RankTile({required this.entry});
  final _LeaderEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: entry.isMe
            ? AppColors.primary.withOpacity(0.12)
            : Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF1E1E2E)
                : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: entry.isMe
            ? Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5)
            : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '#${entry.rank}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: entry.rank <= 3 ? const Color(0xFFFFD700) : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.primary.withOpacity(0.15),
            child: Text(
              entry.name[0],
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: entry.isMe ? AppColors.primary : null,
                      ),
                    ),
                    if (entry.isMe) ...[
                      const SizedBox(width: 6),
                      const Text('(You)', style: TextStyle(color: AppColors.primary, fontSize: 12)),
                    ],
                  ],
                ),
                Text(entry.city, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF6C3DC8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '⚡ ${entry.xp}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C3DC8),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
