import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;

class SocialFeedScreen extends ConsumerStatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  ConsumerState<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends ConsumerState<SocialFeedScreen> with TickerProviderStateMixin {
  bool _lowDataMode = false;
  final List<OverlayEntry> _xpAnimations = [];

  void _showXPAnimation(Offset position) {
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _XPFloatAnimation(
        position: position,
        onComplete: () {
          entry.remove();
          _xpAnimations.remove(entry);
        },
      ),
    );
    Overlay.of(context).insert(entry);
    _xpAnimations.add(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Feed'),
        actions: [
          Row(
            children: [
              const Text('Low Data', style: TextStyle(fontSize: 12)),
              Switch(
                value: _lowDataMode,
                onChanged: (v) => setState(() => _lowDataMode = v),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) => _SocialPostCard(
          lowData: _lowDataMode,
          onLike: (pos) => _showXPAnimation(pos),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}

class _SocialPostCard extends StatefulWidget {
  final bool lowData;
  final Function(Offset) onLike;

  const _SocialPostCard({required this.lowData, required this.onLike});

  @override
  State<_SocialPostCard> createState() => _SocialPostCardState();
}

class _SocialPostCardState extends State<_SocialPostCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('Arjun Mehta', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('2 hours ago • New Delhi'),
            trailing: const Icon(Icons.more_horiz),
          ),
          if (!widget.lowData)
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: const Icon(Icons.image, size: 64, color: Colors.grey),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Just completed my first 10k run today! Feeling amazing and full of energy. Thanks @FitKarma community for the daily motivation. 🏃‍♂️⚡',
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _ActionButton(
                      icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : null,
                      label: '24',
                      onTap: (pos) {
                        setState(() => _isLiked = !_isLiked);
                        if (_isLiked) widget.onLike(pos);
                      },
                    ),
                    const SizedBox(width: 24),
                    const _ActionButton(icon: Icons.chat_bubble_outline, label: '8'),
                    const Spacer(),
                    const _ActionButton(icon: Icons.share_outlined, label: 'Share'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Function(Offset)? onTap;

  const _ActionButton({required this.icon, required this.label, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          final renderBox = context.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          onTap!(position);
        }
      },
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _XPFloatAnimation extends StatefulWidget {
  final Offset position;
  final VoidCallback onComplete;

  const _XPFloatAnimation({required this.position, required this.onComplete});

  @override
  State<_XPFloatAnimation> createState() => _XPFloatAnimationState();
}

class _XPFloatAnimationState extends State<_XPFloatAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _up;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0)));
    _up = Tween<double>(begin: 0.0, end: -80.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx,
      top: widget.position.dy,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(0, _up.value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12)),
              child: const Text('+5 XP', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12, decoration: TextDecoration.none)),
            ),
          ),
        ),
      ),
    );
  }
}
