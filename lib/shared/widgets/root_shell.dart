import 'package:flutter/material.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';

class RootShell extends StatefulWidget {
  final Widget child;

  const RootShell({super.key, required this.child});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  bool _checked = false;
  static bool _isCompromised = false;

  @override
  void initState() {
    super.initState();
    _checkCompromised();
  }

  Future<void> _checkCompromised() async {
    if (_checked) return;
    _checked = true;

    final isCompromised = await isDeviceCompromised();
    if (mounted) {
      setState(() {
        _isCompromised = isCompromised;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_isCompromised)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 8,
              bottom: 8,
              left: 16,
              right: 16,
            ),
            color: Colors.orange.shade800,
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Security warning: Device may be compromised',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
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