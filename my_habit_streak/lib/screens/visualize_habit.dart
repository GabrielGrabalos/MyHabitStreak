import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/header.dart';

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
      body: Column(
        children: [
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
          Expanded(
              child: Column(children: [
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
          ]))
        ],
      ),
    );
  }
}
