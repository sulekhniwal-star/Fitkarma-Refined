import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'data/social_notifier.dart';
import 'community_groups_screen.dart';
import 'direct_messages_screen.dart';
import 'festival_leaderboard_screen.dart';

class SocialFeedScreen extends ConsumerStatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  ConsumerState<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends ConsumerState<SocialFeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradientLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Community',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_outlined),
            tooltip: 'Groups',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CommunityGroupsScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'Festival Challenges',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FestivalLeaderboardScreen())),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.mail_outline),
                tooltip: 'Messages',
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const DirectMessagesScreen())),
              ),
              Positioned(
                top: 8, right: 8,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Following'),
            Tab(text: 'Discover'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _FeedTab(isDiscover: false),
          _FeedTab(isDiscover: true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreatePostSheet(context, ref),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Share', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showCreatePostSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CreatePostSheet(
        onPost: (post) => ref.read(socialFeedProvider.notifier).addPost(post),
      ),
    );
  }
}

// ─── Feed Tab ─────────────────────────────────────────────────────────────────
class _FeedTab extends ConsumerWidget {
  final bool isDiscover;
  const _FeedTab({required this.isDiscover});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(socialFeedProvider);
    final displayPosts = isDiscover ? posts : posts.where((p) => p.isLikedByMe || p.userId == 'user_1').toList();

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async => await Future.delayed(const Duration(seconds: 1)),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: displayPosts.isEmpty ? 1 : displayPosts.length,
        itemBuilder: (context, index) {
          if (displayPosts.isEmpty) {
            return _EmptyFeed(isDiscover: isDiscover);
          }
          return _PostCard(post: displayPosts[index]);
        },
      ),
    );
  }
}

class _EmptyFeed extends StatelessWidget {
  final bool isDiscover;
  const _EmptyFeed({required this.isDiscover});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            isDiscover ? 'No posts yet' : 'Follow people to see their posts',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isDiscover
                ? 'Be the first to share!'
                : 'Discover and follow fellow FitKarma users',
            style: TextStyle(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Post Card ────────────────────────────────────────────────────────────────
class _PostCard extends ConsumerStatefulWidget {
  final SocialPostUi post;
  const _PostCard({required this.post});

  @override
  ConsumerState<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<_PostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeAnim;
  late Animation<double> _likeScale;

  @override
  void initState() {
    super.initState();
    _likeAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _likeScale = Tween<double>(begin: 1, end: 1.4).animate(
      CurvedAnimation(parent: _likeAnim, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _likeAnim.dispose();
    super.dispose();
  }

  void _handleLike() {
    ref.read(socialFeedProvider.notifier).toggleLike(widget.post.id);
    _likeAnim.forward().then((_) => _likeAnim.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.post;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildAvatar(p),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            p.username,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          if (p.isVerified) ...[
                            const SizedBox(width: 4),
                            _VerifiedBadge(type: p.verifiedType),
                          ],
                        ],
                      ),
                      Text(
                        _timeAgo(p.createdAt),
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                _PostTypeBadge(type: p.postType),
                IconButton(
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ),

          // ── Content ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(p.content, style: const TextStyle(fontSize: 15, height: 1.5)),
          ),

          // ── Actions ─────────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                // Like button with animation
                ScaleTransition(
                  scale: _likeScale,
                  child: IconButton(
                    onPressed: _handleLike,
                    icon: Icon(
                      p.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                      color: p.isLikedByMe ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
                Text(
                  '${p.likesCount}',
                  style: TextStyle(
                    color: p.isLikedByMe ? Colors.red : Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _showComments(context, p),
                  icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                ),
                Text(
                  '${p.commentsCount}',
                  style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                if (p.userId != kCurrentUserId)
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined, size: 16),
                    label: const Text('Follow'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.share_outlined, color: Colors.grey, size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showComments(BuildContext context, SocialPostUi post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CommentsSheet(post: post),
    );
  }

  Widget _buildAvatar(SocialPostUi p) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: AppColors.heroGradientLight,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          p.avatarInitial,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

// ─── Verified Badge ───────────────────────────────────────────────────────────
class _VerifiedBadge extends StatelessWidget {
  final String type;
  const _VerifiedBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isNutritionist = type == 'nutritionist';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isNutritionist ? Colors.teal.shade50 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isNutritionist ? Colors.teal.shade200 : Colors.blue.shade200,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified,
            size: 12,
            color: isNutritionist ? Colors.teal : Colors.blue,
          ),
          const SizedBox(width: 2),
          Text(
            isNutritionist ? 'Nutritionist' : 'Trainer',
            style: TextStyle(
              fontSize: 10,
              color: isNutritionist ? Colors.teal.shade700 : Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Post Type Badge ──────────────────────────────────────────────────────────
class _PostTypeBadge extends StatelessWidget {
  final String type;
  const _PostTypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final (icon, color, label) = switch (type) {
      'workout' => (Icons.fitness_center, Colors.orange, 'Workout'),
      'meal' => (Icons.restaurant, Colors.green, 'Meal'),
      'milestone' => (Icons.emoji_events, Colors.amber, 'Milestone'),
      _ => (Icons.chat, Colors.purple, 'Post'),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ─── Comments Sheet ───────────────────────────────────────────────────────────
class _CommentsSheet extends StatefulWidget {
  final SocialPostUi post;
  const _CommentsSheet({required this.post});

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  final _ctrl = TextEditingController();
  final _comments = [
    ('Rahul S.', 'R', 'Amazing progress! Keep it up! 💪'),
    ('Sneha R.', 'S', 'This is so inspiring 🙏'),
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40, height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Comments (${widget.post.commentsCount})',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                controller: scrollCtrl,
                itemCount: _comments.length,
                itemBuilder: (_, i) {
                  final (name, initial, text) = _comments[i];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                    subtitle: Text(text),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        hintText: 'Add a comment…',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      if (_ctrl.text.isNotEmpty) {
                        setState(() {
                          _comments.add(('You', 'Y', _ctrl.text));
                          _ctrl.clear();
                        });
                      }
                    },
                    icon: const Icon(Icons.send),
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Create Post Sheet ────────────────────────────────────────────────────────
class _CreatePostSheet extends StatefulWidget {
  final void Function(SocialPostUi) onPost;
  const _CreatePostSheet({required this.onPost});

  @override
  State<_CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<_CreatePostSheet> {
  final _ctrl = TextEditingController();
  String _selectedType = 'general';

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text('Share with Community', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            // Post type selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final (type, icon, label, color) in [
                    ('workout', Icons.fitness_center, 'Workout', Colors.orange),
                    ('meal', Icons.restaurant, 'Meal', Colors.green),
                    ('milestone', Icons.emoji_events, 'Milestone', Colors.amber),
                    ('general', Icons.chat, 'General', Colors.purple),
                  ])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, size: 14, color: _selectedType == type ? Colors.white : color),
                            const SizedBox(width: 4),
                            Text(label),
                          ],
                        ),
                        selected: _selectedType == type,
                        selectedColor: color,
                        onSelected: (_) => setState(() => _selectedType = type),
                        labelStyle: TextStyle(color: _selectedType == type ? Colors.white : null),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ctrl,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What\'s your wellness win today?',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_ctrl.text.isNotEmpty) {
                    widget.onPost(SocialPostUi(
                      id: DateTime.now().millisecondsSinceEpoch,
                      userId: kCurrentUserId,
                      username: kCurrentUsername,
                      avatarInitial: 'Y',
                      isVerified: false,
                      verifiedType: 'none',
                      postType: _selectedType,
                      content: _ctrl.text,
                      likesCount: 0,
                      commentsCount: 0,
                      isLikedByMe: false,
                      createdAt: DateTime.now(),
                    ));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Post to Community', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
