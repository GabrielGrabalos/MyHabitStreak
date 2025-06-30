import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/streak_day.dart';

class StreakWeek extends StatelessWidget {
  final List<String>? labels;
  final List<bool> isDone;
  final List<bool> isOtherMonth;
  final double spacing;
  final bool dynamicLabelColor;
  final List<int> days;

  const StreakWeek({
    super.key,
    this.labels,
    this.isDone = const [true, false, true, false, true, false, true],
    this.isOtherMonth = const [false, false, false, false, false, false, false],
    this.days = const [0, 0, 0, 0, 0, 0, 0],
    this.spacing = 6.0,
    this.dynamicLabelColor = true,
  });

  @override
  Widget build(BuildContext context) {
    // Get localized weekday names
    final weekdayNames = _getLocalizedWeekdayNames(context);

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
              label: labels?[index] ?? weekdayNames[index],
              isDone: isDone[index],
              isOtherMonth: isOtherMonth[index],
              labelColor: dynamicLabelColor
                  ? (isDone[index] ? doneColor : notDoneColor)
                  : doneColor,
              color: isDone[index] ? doneColor : notDoneColor,
              day: days[index],
            );
          }),
        );
      },
    );
  }

  List<String> _getLocalizedWeekdayNames(BuildContext context) {
    // Create a date for Sunday (2023-10-01 was a Sunday)
    final sunday = DateTime(2023, 10, 1);

    // Get the current locale from the context
    final locale = Localizations.localeOf(context);

    return List.generate(7, (index) {
      final day = sunday.add(Duration(days: index));
      return DateFormat.E(locale.toString()).format(day); // 'E' gives short weekday name
    });
  }
}