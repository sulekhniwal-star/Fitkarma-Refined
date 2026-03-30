import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';

import '../../shared/theme/app_colors.dart';
import '../../shared/theme/app_text_styles.dart';

class RootShell extends StatefulWidget {
  final Widget child;

  const RootShell({super.key, required this.child});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  bool _isRooted = false;
  bool _isJailbroken = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checkDevice();
  }

  Future<void> _checkDevice() async {
    try {
      final jailbroken = await FlutterJailbreakDetection.jailbroken;
      if (mounted) {
        setState(() {
          _isJailbroken = jailbroken;
          _isRooted = jailbroken; // jailbroken covers rooted on Android
          _checked = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _checked = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_checked) return widget.child;

    final isCompromised = _isRooted || _isJailbroken;

    if (!isCompromised) return widget.child;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            border: Border(
              bottom:
                  BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.shield_outlined, size: 18, color: AppColors.error),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Security warning: This device appears to be ${_isRooted ? "rooted" : "jailbroken"}. '
                  'Some features may be restricted.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}
