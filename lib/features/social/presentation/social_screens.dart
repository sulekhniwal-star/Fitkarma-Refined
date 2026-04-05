import 'package:flutter/material.dart';

class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(icon: const Icon(Icons.group_add), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _PostCard(
            user: 'Priya S.',
            avatar: 'P',
            content: 'Just completed my 30-day yoga challenge! Feeling stronger and more flexible. 🧘‍♀️',
            likes: 24,
            comments: 5,
            time: '2 hours ago',
          ),
          _PostCard(
            user: 'Raj K.',
            avatar: 'R',
            content: 'Hit a new PR on bench press today! 75kg for 5 reps 💪',
            likes: 45,
            comments: 12,
            time: '4 hours ago',
          ),
          _PostCard(
            user: 'Anita M.',
            avatar: 'A',
            content: 'Made healthy paneer tikka today! High protein, low oil. Recipe coming soon...',
            likes: 18,
            comments: 3,
            time: '6 hours ago',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String user;
  final String avatar;
  final String content;
  final int likes;
  final int comments;
  final String time;

  const _PostCard({
    required this.user,
    required this.avatar,
    required this.content,
    required this.likes,
    required this.comments,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(child: Text(avatar)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(content),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.favorite_border, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text('$likes'),
                const SizedBox(width: 16),
                Icon(Icons.comment_outlined, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 4),
                Text('$comments'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommunityGroupsScreen extends StatelessWidget {
  const CommunityGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Groups')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _GroupCard(
            name: 'Mumbai Runners',
            members: 1250,
            category: 'Running',
            image: '🏃',
          ),
          _GroupCard(
            name: 'Yoga Warriors',
            members: 890,
            category: 'Yoga',
            image: '🧘',
          ),
          _GroupCard(
            name: 'Keto India',
            members: 2100,
            category: 'Diet',
            image: '🥑',
          ),
          _GroupCard(
            name: 'Weight Loss Support',
            members: 3500,
            category: 'Support',
            image: '💪',
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final String name;
  final int members;
  final String category;
  final String image;

  const _GroupCard({required this.name, required this.members, required this.category, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Text(image, style: const TextStyle(fontSize: 32)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$category · $members members'),
        trailing: OutlinedButton(onPressed: () {}, child: const Text('Join')),
      ),
    );
  }
}

class DirectMessageScreen extends StatelessWidget {
  const DirectMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(child: Text('P')),
            title: const Text('Priya Sharma'),
            subtitle: const Text('Great progress on your workout! 💪'),
            trailing: const Text('2m'),
          ),
          ListTile(
            leading: const CircleAvatar(child: Text('R')),
            title: const Text('Raj Kumar'),
            subtitle: const Text('Did you see the new yoga session?'),
            trailing: const Text('1h'),
          ),
        ],
      ),
    );
  }
}