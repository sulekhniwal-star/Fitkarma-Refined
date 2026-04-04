import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class FastingScreen extends ConsumerStatefulWidget {
  final String userId;

  const FastingScreen({super.key, required this.userId});

  @override
  ConsumerState<FastingScreen> createState() => _FastingScreenState();
}

class _FastingScreenState extends ConsumerState<FastingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasting'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: FutureBuilder(
        future: db.fastingLogsDao.getFastingState(widget.userId),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null || !state.isActive) {
            return _buildProtocolSelector(db);
          }
          return _buildActiveFast(state, db);
        },
      ),
    );
  }

  Widget _buildProtocolSelector(AppDatabase db) {
    return FutureBuilder(
      future: db.fastingLogsDao.getProtocols(),
      builder: (context, snapshot) {
        final protocols = snapshot.data ?? [];
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Choose Protocol', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 16),
              ...protocols.map((p) => _ProtocolCard(p, onTap: () => _startFast(db, p))),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Ramadan Mode'),
                subtitle: const Text('Use Sehri/Iftar times'),
                value: false,
                onChanged: (v) {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _ProtocolCard(FastingProtocol protocol, {required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(protocol.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(protocol.description, style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Icon(Icons.play_arrow, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startFast(AppDatabase db, FastingProtocol protocol) async {
    await db.fastingLogsDao.startFast(
      userId: widget.userId,
      protocol: protocol.name,
      targetHours: protocol.hours,
    );
    setState(() {});
  }

  Widget _buildActiveFast(FastingState state, AppDatabase db) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          _buildTimerRing(state),
          const SizedBox(height: 24),
          _buildStageIndicator(state),
          const Spacer(),
          _buildEndButton(db),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTimerRing(FastingState state) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 250,
            height: 250,
            child: CircularProgressIndicator(
              value: state.progress,
              strokeWidth: 12,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(_getStageColor(state.stage)),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                state.elapsedTime,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Text('elapsed', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              Text(
                '${state.remainingTime} remaining',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStageIndicator(FastingState state) {
    final stages = FastingStage.values.where((s) => s != FastingStage.idle).toList();
    final currentIndex = stages.indexOf(state.stage);
    
    return Column(
      children: [
        Text(_getStageLabel(state.stage), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: stages.asMap().entries.map((e) {
            final isActive = e.key <= currentIndex;
            return Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive ? _getStageColor(e.value) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEndButton(AppDatabase db) {
    return ElevatedButton(
      onPressed: () async {
        final id = await db.fastingLogsDao.endFastWithKarma(widget.userId);
        if (id > 0 && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Fast complete! +15 XP'), backgroundColor: Colors.green),
          );
          setState(() {});
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('End Fast Early'),
    );
  }

  Color _getStageColor(FastingStage stage) {
    switch (stage) {
      case FastingStage.eatingWindow: return Colors.grey;
      case FastingStage.fatBurning: return Colors.blue;
      case FastingStage.ketosis: return Colors.orange;
      case FastingStage.autophagy: return Colors.purple;
      case FastingStage.deepAutophagy: return Colors.pink;
      case FastingStage.idle: return Colors.grey;
    }
  }

  String _getStageLabel(FastingStage stage) {
    switch (stage) {
      case FastingStage.eatingWindow: return 'Eating Window';
      case FastingStage.fatBurning: return 'Fat Burning';
      case FastingStage.ketosis: return 'Ketosis';
      case FastingStage.autophagy: return 'Autophagy';
      case FastingStage.deepAutophagy: return 'Deep Autophagy';
      case FastingStage.idle: return 'Idle';
    }
  }
}