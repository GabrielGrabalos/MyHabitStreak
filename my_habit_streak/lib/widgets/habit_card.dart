import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../models/habit.dart';
import '../utils/colors.dart';
import '../utils/habit_theme.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({
    super.key,
    required this.habit,
  });

  // Helper to get the first day of the week (Monday)
  DateTime _findFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // Generate current week dates (Monday to Sunday)
  List<DateTime> _getCurrentWeek() {
    final today = DateTime.now();
    final firstDay = _findFirstDayOfWeek(today);
    return List.generate(7, (index) => firstDay.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    // Generate week history (Monday to Sunday)
    final weekHistory = _getCurrentWeek().map((date) {
      return habit.streakHistory[habit.formatDate(date)] ?? false;
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 10;
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: width,
              height: width * (width > 280 ? 0.4 : 0.5),
              decoration: BoxDecoration(
                color: habit.color,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Color(0xFFFFFFFF),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: width * (width > 280 ? 0.65 : 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.title,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: habit.color != yellowTheme
                                        ? Colors.white
                                        : darkBackground,
                                  ),
                        ),
                        SizedBox(height: 10),
                        StreakWeek(
                          isDone: weekHistory,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/${habit.theme == HabitTheme.bee ? 'bee' : 'flower'}${!habit.isTodayDone ? '_gray' : ''}.svg',
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        habit.streak.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: habit.isTodayDone
                                  ? doneColor
                                  : habit.color != yellowTheme
                                      ? Colors.white
                                      : darkBackground,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!habit.isTodayDone)
              Positioned(
                top: 10,
                right: 10,
                child: SvgPicture.asset('assets/warning.svg'),
              ),
          ],
        );
      },
    );
  }
}
