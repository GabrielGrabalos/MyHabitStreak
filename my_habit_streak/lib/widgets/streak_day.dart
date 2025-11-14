import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/streak_circle.dart';

class StreakDay extends StatelessWidget {
  final String label;
  final bool isDone;
  final bool isOtherMonth;
  final double size;
  final Color labelColor;
  final Color color;
  final int day;
  final String dateKey;
  final Function(String dateKey) onClick;

  const StreakDay({
    super.key,
    required this.dateKey,
    required this.onClick,
    this.label = '',
    this.isDone = false,
    this.isOtherMonth = false,
    this.size = 50,
    this.labelColor = const Color(0xFF4CAF50),
    this.color = const Color(0xFF4CAF50),
    this.day = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (day == 0) return;

        onClick(dateKey);
      },
      child: Column(
        children: [
          if (label.isNotEmpty) ...[
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: size * 0.4,
                    fontWeight: FontWeight.bold,
                    color: labelColor,
                  ),
            ),
            SizedBox(height: size * 0.1),
          ],
          Stack(
            clipBehavior: Clip.none,
            children: [
              StreakCircle(
                dateKey: dateKey,
                isDone: isDone,
                size: size,
                color: color,
                opacity: !isOtherMonth ? color.a : color.a * 0.3,
              ),
              if (day > 0)
                Positioned(
                  bottom: -size * 0.1,
                  right: -size * 0.1,
                  child: Container(
                    padding: EdgeInsets.all(size * 0.05),
                    alignment: Alignment.center,
                    width: size * 0.5,
                    height: size * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
      ),
    );
  }
}
