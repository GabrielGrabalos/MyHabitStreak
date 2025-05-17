import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/streak_circle.dart';

class StreakDay extends StatelessWidget {
  final String label;
  final bool isDone;
  final double size;
  final Color color;

  const StreakDay({
    super.key,
    this.label = '',
    this.isDone = false,
    this.size = 50,
    this.color = const Color(0xFF4CAF50),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: color
          ),
        ),
        SizedBox(height: size * 0.1),
        StreakCircle(
          isDone: isDone,
          size: size,
          color: color,
        )
      ],
    );
  }
}
