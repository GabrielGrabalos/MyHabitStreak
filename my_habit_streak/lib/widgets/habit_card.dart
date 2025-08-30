import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/screens/visualize_habit.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../models/habit.dart';
import '../utils/colors.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {

    return Card( // Using Card for a subtle elevation and the InkWell effect
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Color(0xFFFFFFFF),
          width: 2,
        ),
      ),
      elevation: 0,
      color: habit.color,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            VisualizeHabit.routeName,
            arguments: habit,
          );
        },
        borderRadius: BorderRadius.circular(20), // Match the Container's border radius
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth - 20; // width is now the full width of the Card's child
            final padding = min(15.0, width * 0.05); // 5% padding
            final internalWidth = width - (padding * 2);
            return Container(
              padding: EdgeInsets.all(padding),
              width: width,
              height: max(width / 2.5, 100),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: internalWidth * 0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              habit.title,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontSize: 26,
                                color: habit.color != yellowTheme
                                    ? Colors.white
                                    : darkBackground,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            StreakWeek(
                              isDone: habit.getCurrentWeekStatus(),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/${habit.theme.name}'
                                  '${!habit.isTodayDone ? '_gray' : ''}.svg',
                              width: internalWidth * 0.3,
                            ),
                          ),
                          Text(
                            habit.streak.toString(),
                            style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  if (!habit.isTodayDone)
                    Positioned(
                      top: 0, // Adjust position as needed, based on padding
                      right: 0, // Adjust position as needed, based on padding
                      child: SvgPicture.asset('assets/warning.svg'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}