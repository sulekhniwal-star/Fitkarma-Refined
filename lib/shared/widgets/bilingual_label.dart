import 'package:flutter/material.dart';

class BilingualLabel extends StatelessWidget {
  final String english;
  final String hindi;
  final bool showBorder;

  const BilingualLabel({
    super.key,
    required this.english,
    required this.hindi,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showBorder ? const BoxDecoration(
        border: Border(
          left: BorderSide(color: Color(0xFFF97316), width: 3),
        ),
      ) : null,
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            english,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            hindi,
            style: const TextStyle(
              fontFamily: 'Devanagari',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
