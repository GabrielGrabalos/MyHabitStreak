import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../dtos/habit.dart';
import '../utils/colors.dart';
import '../utils/habit_theme.dart';

class VisualizeHabit extends StatelessWidget {
  final Habit habit;

  const VisualizeHabit({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(children: [
        Header(
          title: habit.title,
          icon: Icons.edit,
          onActionPressed: () {
            // Action when the edit icon is pressed
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Edit action triggered')),
            );
          },
        ),
        SizedBox(height: 30),
        SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/${habit.theme == HabitTheme.bee ? 'bee' : 'flower'}'
                    '${!habit.isTodayDone ? '_gray' : ''}.svg',
                    width: 150,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    habit.streak.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 84,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: habit.color,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  padding: const EdgeInsets.all(15.0),
                  child: StreakWeek(
                    isDone: habit.getCurrentWeekStatus(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
