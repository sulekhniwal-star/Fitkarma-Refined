// lib/features/social/presentation/community_groups_screen.dart
// Community Groups Screen - Create/join groups

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/social/data/social_models.dart';
import 'package:fitkarma/features/social/data/social_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

/// Community Groups Screen
class CommunityGroupsScreen extends ConsumerStatefulWidget {
  const CommunityGroupsScreen({super.key});

  @override
  ConsumerState<CommunityGroupsScreen> createState() =>
      _CommunityGroupsScreenState();
}

class _CommunityGroupsScreenState extends ConsumerState<CommunityGroupsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadUser();
  }

  Future<void> _loadUser() async {
    final authService = AuthAwService();
    final user = await authService.getCurrentUser();
    if (mounted) {
      setState(() => _currentUserId = user?.$id);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUserId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Groups'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Diet'),
            Tab(text: 'Location'),
            Tab(text: 'Sport'),
            Tab(text: 'Challenge'),
            Tab(text: 'Support'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.create),
            onPressed: () => _showCreateGroupSheet(context),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _GroupsListTab(groupType: null, currentUserId: _currentUserId!),
          _GroupsListTab(
            groupType: GroupType.diet,
            currentUserId: _currentUserId!,
          ),
          _GroupsListTab(
            groupType: GroupType.location,
            currentUserId: _currentUserId!,
          ),
          _GroupsListTab(
            groupType: GroupType.sport,
            currentUserId: _currentUserId!,
          ),
          _GroupsListTab(
            groupType: GroupType.challenge,
            currentUserId: _currentUserId!,
          ),
          _GroupsListTab(
            groupType: GroupType.support,
            currentUserId: _currentUserId!,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateGroupSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showCreateGroupSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _CreateGroupSheet(currentUserId: _currentUserId!),
    );
  }
}

/// Groups List Tab
class _GroupsListTab extends ConsumerWidget {
  final GroupType? groupType;
  final String currentUserId;

  const _GroupsListTab({required this.groupType, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = groupType == null
        ? ref.watch(allGroupsProvider)
        : ref.watch(groupsByTypeProvider(groupType!));

    return groupsAsync.when(
      data: (groups) {
        if (groups.isEmpty) {
          return _buildEmptyState();
        }
        return RefreshIndicator(
          onRefresh: () async {
            if (groupType == null) {
              ref.invalidate(allGroupsProvider);
            } else {
              ref.invalidate(groupsByTypeProvider(groupType!));
            }
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return _GroupCard(
                group: groups[index],
                currentUserId: currentUserId,
              );
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.group_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            groupType == null
                ? 'No groups yet'
                : 'No ${groupType!.name} groups',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          const Text('Be the first to create a group!'),
        ],
      ),
    );
  }
}

/// Group Card Widget
class _GroupCard extends ConsumerWidget {
  final CommunityGroup group;
  final String currentUserId;

  const _GroupCard({required this.group, required this.currentUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membershipAsync = ref.watch(
      isGroupMemberProvider((group.id, currentUserId)),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => _GroupDetailScreen(
              groupId: group.id,
              currentUserId: currentUserId,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Group avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getGroupColor(group.type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: group.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          group.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        _getGroupIcon(group.type),
                        color: Colors.white,
                        size: 28,
                      ),
              ),
              const SizedBox(width: 12),
              // Group info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            group.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (group.isPrivate)
                          Icon(Icons.lock, size: 16, color: Colors.grey[600]),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      group.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people, size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          '${group.membersCount} members',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _buildTypeBadge(group.type),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Join/Joined button
              membershipAsync.when(
                data: (isMember) => isMember
                    ? OutlinedButton(
                        onPressed: () => _leaveGroup(context, ref),
                        child: const Text('Joined'),
                      )
                    : ElevatedButton(
                        onPressed: () => _joinGroup(context, ref),
                        child: const Text('Join'),
                      ),
                loading: () => const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                error: (_, __) => ElevatedButton(
                  onPressed: () => _joinGroup(context, ref),
                  child: const Text('Join'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeBadge(GroupType type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getGroupColor(type).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        type.name.toUpperCase(),
        style: TextStyle(
          color: _getGroupColor(type),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getGroupColor(GroupType type) {
    switch (type) {
      case GroupType.diet:
        return Colors.green;
      case GroupType.location:
        return Colors.blue;
      case GroupType.sport:
        return Colors.orange;
      case GroupType.challenge:
        return Colors.red;
      case GroupType.support:
        return Colors.purple;
    }
  }

  IconData _getGroupIcon(GroupType type) {
    switch (type) {
      case GroupType.diet:
        return Icons.restaurant;
      case GroupType.location:
        return Icons.location_on;
      case GroupType.sport:
        return Icons.sports;
      case GroupType.challenge:
        return Icons.emoji_events;
      case GroupType.support:
        return Icons.support;
    }
  }

  Future<void> _joinGroup(BuildContext context, WidgetRef ref) async {
    try {
      final service = ref.read(groupsAwServiceProvider);
      await service.joinGroup(group.id, currentUserId);
      ref.invalidate(isGroupMemberProvider((group.id, currentUserId)));
      ref.invalidate(allGroupsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Joined ${group.name}!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error joining group: $e')));
      }
    }
  }

  Future<void> _leaveGroup(BuildContext context, WidgetRef ref) async {
    try {
      final service = ref.read(groupsAwServiceProvider);
      await service.leaveGroup(group.id, currentUserId);
      ref.invalidate(isGroupMemberProvider((group.id, currentUserId)));
      ref.invalidate(allGroupsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Left ${group.name}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error leaving group: $e')));
      }
    }
  }
}

/// Create Group Sheet
class _CreateGroupSheet extends ConsumerStatefulWidget {
  final String currentUserId;

  const _CreateGroupSheet({required this.currentUserId});

  @override
  ConsumerState<_CreateGroupSheet> createState() => _CreateGroupSheetState();
}

class _CreateGroupSheetState extends ConsumerState<_CreateGroupSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  GroupType _selectedType = GroupType.support;
  bool _isPrivate = false;
  bool _isCreating = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Create Group',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Group type
            const Text(
              'Group Type:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: GroupType.values.map((type) {
                return ChoiceChip(
                  label: Text(type.name.toUpperCase()),
                  selected: _selectedType == type,
                  onSelected: (_) => setState(() => _selectedType = type),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Private switch
            SwitchListTile(
              title: const Text('Private Group'),
              subtitle: const Text('Only invited members can join'),
              value: _isPrivate,
              onChanged: (value) => setState(() => _isPrivate = value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            // Create button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isCreating ? null : _createGroup,
                child: _isCreating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create Group'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createGroup() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a group name')),
      );
      return;
    }

    setState(() => _isCreating = true);

    try {
      final service = ref.read(groupsAwServiceProvider);
      await service.createGroup(
        creatorId: widget.currentUserId,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        type: _selectedType,
        isPrivate: _isPrivate,
      );

      ref.invalidate(allGroupsProvider);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group created successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error creating group: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isCreating = false);
      }
    }
  }
}

/// Group Detail Screen
class _GroupDetailScreen extends ConsumerStatefulWidget {
  final String groupId;
  final String currentUserId;

  const _GroupDetailScreen({
    required this.groupId,
    required this.currentUserId,
  });

  @override
  ConsumerState<_GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends ConsumerState<_GroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupAsync = ref.watch(groupProvider(widget.groupId));

    return Scaffold(
      appBar: AppBar(
        title: groupAsync.when(
          data: (group) => Text(group?.name ?? 'Group'),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Group'),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Feed'),
            Tab(text: 'Challenges'),
            Tab(text: 'Members'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _GroupFeedTab(groupId: widget.groupId),
          _GroupChallengesTab(groupId: widget.groupId),
          _GroupMembersTab(groupId: widget.groupId),
        ],
      ),
    );
  }
}

/// Group Feed Tab
class _GroupFeedTab extends StatelessWidget {
  final String groupId;

  const _GroupFeedTab({required this.groupId});

  @override
  Widget build(BuildContext context) {
    // For now, show a placeholder
    return const Center(child: Text('Group feed coming soon'));
  }
}

/// Group Challenges Tab
class _GroupChallengesTab extends ConsumerWidget {
  final String groupId;

  const _GroupChallengesTab({required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesAsync = ref.watch(groupChallengesProvider(groupId));

    return challengesAsync.when(
      data: (challenges) {
        if (challenges.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_outlined, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No active challenges'),
                SizedBox(height: 8),
                Text('Create a challenge for this group!'),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            return _ChallengeCard(challenge: challenges[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

/// Challenge Card
class _ChallengeCard extends StatelessWidget {
  final GroupChallenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isActive =
        now.isAfter(challenge.startDate) && now.isBefore(challenge.endDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: isActive ? Colors.orange : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    challenge.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isActive ? 'ACTIVE' : 'ENDED',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(challenge.description),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.flag, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${challenge.targetValue} ${challenge.targetUnit}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const Spacer(),
                Icon(Icons.people, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${challenge.participantsCount} joined',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Group Members Tab
class _GroupMembersTab extends StatelessWidget {
  final String groupId;

  const _GroupMembersTab({required this.groupId});

  @override
  Widget build(BuildContext context) {
    // For now, show a placeholder
    return const Center(child: Text('Members list coming soon'));
  }
}
