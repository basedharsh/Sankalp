import 'package:flutter/material.dart';

class TimeLineCard extends StatelessWidget {
  final child;
  final bool isPast;
  const TimeLineCard({super.key, required this.child, required this.isPast});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(40),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isPast ? Colors.cyan : Colors.cyan.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child);
  }
}
