import 'package:flutter/cupertino.dart';
import 'package:my_habit_streak/widgets/streak_day.dart';

import '../utils/colors.dart';

class StreakWeek extends StatelessWidget {
  final List<String> labels;
  final List<bool> isDone;
  final double spacing;

  const StreakWeek({
    super.key,
    this.labels = const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
    this.isDone = const [true, false, true, false, true, false, true],
    this.spacing = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;

        // Calculate available width considering spacing between days
        final availableWidth = maxWidth - (spacing * 6);
        final daySize = (availableWidth / 7).clamp(0.0, maxHeight);

        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              return StreakDay(
                size: daySize,
                label: labels[index],
                isDone: isDone[index],
                color: isDone[index] ? doneColor : notDoneColor,
              );
            }),
        );
      },
    );
  }
}
