import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityGroupsScreen extends ConsumerWidget {
  const CommunityGroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Communities')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildChallengeBanner(),
            const SizedBox(height: 32),
            _buildMyGroups(context),
            const SizedBox(height: 32),
            _buildDiscoverGroups(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=500&auto=format'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TEAM CHALLENGE', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(height: 8),
          Text('Delhi Daredevils vs Mumbai Warriors', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Text('Biggest 7-day step challenge in India starts in 2 days.', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(backgroundColor: Colors.amber, child: Text('DD', style: TextStyle(color: Colors.black))),
              SizedBox(width: 8),
              Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              CircleAvatar(backgroundColor: Colors.blue, child: Text('MW', style: TextStyle(color: Colors.white))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyGroups(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('My Groups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
                _MyGroupItem(name: 'Early Birds', icon: Icons.wb_sunny, color: Colors.orange.shade100),
                _MyGroupItem(name: 'Yoga Souls', icon: Icons.self_improvement, color: Colors.purple.shade100),
                _MyGroupItem(name: 'Delhi Runners', icon: Icons.run_circle_outlined, color: Colors.blue.shade100),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverGroups(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Discover Groups', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _DiscoverItem(name: 'PCOS Warriors', members: '12k members', tag: 'Health'),
          _DiscoverItem(name: 'Veggie Delights', members: '34k members', tag: 'Nutrition'),
          _DiscoverItem(name: 'Marathoners India', members: '8k members', tag: 'Fitness'),
        ],
      ),
    );
  }
}

class _MyGroupItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  const _MyGroupItem({required this.name, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.black54, size: 32),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center, maxLines: 1),
        ],
      ),
    );
  }
}

class _DiscoverItem extends StatelessWidget {
  final String name;
  final String members;
  final String tag;
  const _DiscoverItem({required this.name, required this.members, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(members),
        trailing: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, minimumSize: const Size(80, 36)),
            child: const Text('JOIN'),
        ),
      ),
    );
  }
}
