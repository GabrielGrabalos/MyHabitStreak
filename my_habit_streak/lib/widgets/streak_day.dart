import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/streak_circle.dart';

class StreakDay extends StatelessWidget {
  final String label;
  final bool isDone;
  final bool isOtherMonth;
  final double size;
  final Color color;
  final int day;

  const StreakDay({
    super.key,
    this.label = '',
    this.isDone = false,
    this.isOtherMonth = false,
    this.size = 50,
    this.color = const Color(0xFF4CAF50),
    this.day = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          SizedBox(height: size * 0.1),
        ],
        Stack(
          clipBehavior: Clip.none,
          children: [
            StreakCircle(
              isDone: isDone,
              size: size,
              color: !isOtherMonth ? color : color.withOpacity(0.5),
            ),
            if (day > 0)
              Positioned(
                bottom: -size * 0.1,
                right: -size * 0.1,
                child: Container(
                  padding: EdgeInsets.all(size * 0.1),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$day',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: size * 0.3,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
