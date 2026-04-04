import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'data/social_notifier.dart';

class CommunityGroupsScreen extends ConsumerStatefulWidget {
  const CommunityGroupsScreen({super.key});

  @override
  ConsumerState<CommunityGroupsScreen> createState() =>
      _CommunityGroupsScreenState();
}

class _CommunityGroupsScreenState extends ConsumerState<CommunityGroupsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final groups = ref.watch(communityGroupsProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Community Groups', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Discover'),
            Tab(text: 'My Groups'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _GroupsTab(groups: groups, showJoined: false, filter: _selectedFilter, onFilterChanged: (f) => setState(() => _selectedFilter = f)),
          _GroupsTab(groups: groups, showJoined: true, filter: _selectedFilter, onFilterChanged: (f) => setState(() => _selectedFilter = f)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateGroupSheet(context, ref),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Create Group', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showCreateGroupSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CreateGroupSheet(
        onCreate: (group) => ref.read(communityGroupsProvider.notifier).addGroup(group),
      ),
    );
  }
}

class _GroupsTab extends ConsumerWidget {
  final List<CommunityGroupUi> groups;
  final bool showJoined;
  final String filter;
  final void Function(String) onFilterChanged;

  const _GroupsTab({
    required this.groups,
    required this.showJoined,
    required this.filter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtered = groups.where((g) {
      if (showJoined && !g.isJoined) return false;
      if (!showJoined && g.isJoined) return false;
      if (filter == 'all') return true;
      return g.groupType == filter;
    }).toList();

    return Column(
      children: [
        _FilterRow(selected: filter, onChanged: onFilterChanged),
        Expanded(
          child: filtered.isEmpty
              ? _EmptyGroups(showJoined: showJoined)
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) => _GroupCard(group: filtered[i]),
                ),
        ),
      ],
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;

  const _FilterRow({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const filters = [
      ('all', '🌐', 'All'),
      ('diet', '🥗', 'Diet'),
      ('location', '📍', 'Location'),
      ('sport', '🏅', 'Sport'),
      ('challenge', '🏆', 'Challenge'),
      ('support', '💜', 'Support'),
    ];

    return Container(
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((f) {
            final (value, emoji, label) = f;
            final isSelected = selected == value;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text('$emoji $label'),
                selected: isSelected,
                selectedColor: AppColors.primary.withOpacity(0.2),
                checkmarkColor: AppColors.primary,
                side: BorderSide(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                ),
                onSelected: (_) => onChanged(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _EmptyGroups extends StatelessWidget {
  final bool showJoined;
  const _EmptyGroups({required this.showJoined});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.group_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              showJoined ? 'No groups joined yet' : 'No groups found',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              showJoined ? 'Discover and join groups!' : 'Try changing the filter',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends ConsumerWidget {
  final CommunityGroupUi group;
  const _GroupCard({required this.group});

  LinearGradient _groupGradient(String type) => switch (type) {
    'diet' => const LinearGradient(colors: [Color(0xFF43A047), Color(0xFF66BB6A)]),
    'location' => const LinearGradient(colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)]),
    'sport' => const LinearGradient(colors: [Color(0xFFF57C00), Color(0xFFFFB74D)]),
    'challenge' => const LinearGradient(colors: [Color(0xFF8E24AA), Color(0xFFBA68C8)]),
    'support' => const LinearGradient(colors: [Color(0xFFE91E63), Color(0xFFF48FB1)]),
    _ => AppColors.heroGradientLight,
  };

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k members';
    return '$count members';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final g = group;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.darkCardShadow : AppColors.lightCardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GroupDetailScreen(group: g)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: _groupGradient(g.groupType),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: Text(g.emoji, style: const TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(g.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                        if (g.isPrivate)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(6)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock_outline, size: 10, color: Colors.grey),
                                SizedBox(width: 2),
                                Text('Private', style: TextStyle(fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(g.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.people_outline, size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 4),
                        Text(_formatCount(g.membersCount), style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                        const SizedBox(width: 8),
                        _GroupTypePill(type: g.groupType),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _JoinButton(group: g),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupTypePill extends StatelessWidget {
  final String type;
  const _GroupTypePill({required this.type});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (type) {
      'diet' => ('Diet', Colors.green),
      'location' => ('Location', Colors.blue),
      'sport' => ('Sport', Colors.orange),
      'challenge' => ('Challenge', Colors.purple),
      'support' => ('Support', Colors.pink),
      _ => ('General', Colors.grey),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class _JoinButton extends ConsumerWidget {
  final CommunityGroupUi group;
  const _JoinButton({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return group.isJoined
        ? OutlinedButton(
            onPressed: () => ref.read(communityGroupsProvider.notifier).toggleJoin(group.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text('Joined', style: TextStyle(fontSize: 12)),
          )
        : ElevatedButton(
            onPressed: () => ref.read(communityGroupsProvider.notifier).toggleJoin(group.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: const Text('Join', style: TextStyle(fontSize: 12)),
          );
  }
}

// ─── Group Detail Screen ──────────────────────────────────────────────────────
class GroupDetailScreen extends StatefulWidget {
  final CommunityGroupUi group;
  const GroupDetailScreen({super.key, required this.group});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _ctrl = TextEditingController();
  final _posts = <(String, String, String, DateTime, int)>[
    ('Priya K.', 'P', 'Just tried a new sattvic recipe for Navratri! Sharing below 🙏', DateTime.now().subtract(const Duration(hours: 2)), 15),
    ('Rahul S.', 'R', 'Day 3 of the challenge done 💪 Who else is keeping up?', DateTime.now().subtract(const Duration(hours: 5)), 8),
    ('Sneha R.', 'S', 'Morning yoga + detox water = perfect start. Feeling amazing!', DateTime.now().subtract(const Duration(days: 1)), 22),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  List<Color> _groupColors(String type) => switch (type) {
    'diet' => [const Color(0xFF43A047), const Color(0xFF1B5E20)],
    'location' => [const Color(0xFF1E88E5), const Color(0xFF0D47A1)],
    'sport' => [const Color(0xFFF57C00), const Color(0xFFE65100)],
    'challenge' => [const Color(0xFF8E24AA), const Color(0xFF4A148C)],
    'support' => [const Color(0xFFE91E63), const Color(0xFF880E4F)],
    _ => [AppColors.primary, AppColors.primaryDark],
  };

  String _formatCount(int count) {
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}k';
    return '$count';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final g = widget.group;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _groupColors(g.groupType),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Text(g.emoji, style: const TextStyle(fontSize: 48)),
                      const SizedBox(height: 4),
                      Text('${_formatCount(g.membersCount)} members', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              title: Text(g.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: 'Feed'),
                  Tab(text: 'Challenges'),
                  Tab(text: 'Leaderboard'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFeedTab(isDark),
                _buildChallengesTab(isDark),
                _buildLeaderboardTab(isDark),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPostSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildFeedTab(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (_, i) {
        final (name, initial, content, time, likes) = _posts[i];
        return _GroupPostCard(name: name, initial: initial, content: content, time: time, likes: likes);
      },
    );
  }

  Widget _buildChallengesTab(bool isDark) {
    const challenges = [
      ('🏆 21-Day Step Streak', '10,000 steps/day for 21 days', '2,100 / 3,411 joined', true),
      ('🧘 Daily Meditation', '10 min meditation every morning', '890 / 3,411 joined', false),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: challenges.length,
      itemBuilder: (_, i) {
        final (title, desc, joined, isActive) = challenges[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isActive ? AppColors.primary : Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                  if (isActive)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Text('Active', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              const SizedBox(height: 8),
              Text(joined, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(isActive ? 'View Challenge' : 'Join Challenge'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardTab(bool isDark) {
    const entries = [
      (1, 'Dr. Amit V.', 'A', true, 9820),
      (2, 'Priya K.', 'P', true, 8750),
      (3, 'You', 'Y', false, 7200),
      (4, 'Rahul S.', 'R', false, 6100),
      (5, 'Sneha R.', 'S', false, 5400),
    ];
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: AppColors.heroGradientLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.leaderboard, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Group Karma Leaderboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text('Week of Apr 4', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
            ],
          ),
        ),
        for (final (rank, name, initial, verified, xp) in entries)
          _LeaderboardRow(rank: rank, name: name, initial: initial, isVerified: verified, xp: xp, isMe: name == 'You'),
      ],
    );
  }

  void _showPostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Post to ${widget.group.name}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              TextField(
                controller: _ctrl,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share with the group…',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_ctrl.text.isNotEmpty) {
                      setState(() {
                        _posts.insert(0, ('You', 'Y', _ctrl.text, DateTime.now(), 0));
                        _ctrl.clear();
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Post', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupPostCard extends StatelessWidget {
  final String name, initial, content;
  final DateTime time;
  final int likes;
  const _GroupPostCard({required this.name, required this.initial, required this.content, required this.time, required this.likes});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(_timeAgo(time), style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 16, color: Colors.grey.shade500),
              const SizedBox(width: 4),
              Text('$likes', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey.shade500),
            ],
          ),
        ],
      ),
    );
  }
}

class _LeaderboardRow extends StatelessWidget {
  final int rank, xp;
  final String name, initial;
  final bool isVerified, isMe;
  const _LeaderboardRow({required this.rank, required this.name, required this.initial, required this.isVerified, required this.xp, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final rankColor = rank == 1 ? const Color(0xFFFFD700) : rank == 2 ? Colors.grey.shade400 : rank == 3 ? Colors.brown.shade300 : null;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isMe ? AppColors.primary.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isMe ? AppColors.primary.withOpacity(0.3) : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 30, height: 30,
            decoration: BoxDecoration(
              color: rankColor?.withOpacity(0.2) ?? Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: rank <= 3
                  ? Icon(Icons.emoji_events, size: 16, color: rankColor)
                  : Text('$rank', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withOpacity(0.2),
            child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Text(name, style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.w500)),
                if (isVerified) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, size: 14, color: Colors.blue),
                ],
              ],
            ),
          ),
          Text('$xp XP', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? AppColors.darkSurface : Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate old) => false;
}

class _CreateGroupSheet extends StatefulWidget {
  final void Function(CommunityGroupUi) onCreate;
  const _CreateGroupSheet({required this.onCreate});

  @override
  State<_CreateGroupSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends State<_CreateGroupSheet> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _selectedType = 'sport';
  bool _isPrivate = false;

  static const _types = [
    ('diet', '🥗', 'Diet'),
    ('location', '📍', 'Location'),
    ('sport', '🏅', 'Sport'),
    ('challenge', '🏆', 'Challenge'),
    ('support', '💜', 'Support'),
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create Group', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),
              TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Group Type', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _types.map((t) {
                  final (value, emoji, label) = t;
                  return ChoiceChip(
                    label: Text('$emoji $label'),
                    selected: _selectedType == value,
                    selectedColor: AppColors.primary.withOpacity(0.2),
                    onSelected: (_) => setState(() => _selectedType = value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Private Group'),
                subtitle: const Text('Members join by invite only'),
                value: _isPrivate,
                onChanged: (v) => setState(() => _isPrivate = v),
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameCtrl.text.isEmpty) return;
                    const emojis = {'diet': '🥗', 'location': '📍', 'sport': '🏅', 'challenge': '🏆', 'support': '💜'};
                    widget.onCreate(CommunityGroupUi(
                      id: DateTime.now().millisecondsSinceEpoch,
                      name: _nameCtrl.text,
                      description: _descCtrl.text,
                      groupType: _selectedType,
                      emoji: emojis[_selectedType] ?? '🌐',
                      membersCount: 1,
                      isJoined: true,
                      isPrivate: _isPrivate,
                    ));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Create Group', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}