import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../utils/colors.dart';
import '../utils/habit_theme.dart';

class HabitCard extends StatelessWidget {
  final bool isTodayDone;
  final List<bool> weekHistory;
  final Color color;
  final HabitTheme theme;
  final int streak;

  const HabitCard({
    super.key,
    this.isTodayDone = false,
    this.weekHistory = const [true, false, true, true, false, false, false],
    this.color = blueTheme,
    this.theme = HabitTheme.bee,
    this.streak = -1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth - 10; // padding of 5 on each side
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              width: width,
              height: width * (width > 280 ? 0.4 : 0.5),
              // 50% of the width
              // 50% of the width
              decoration: BoxDecoration(
                color: color,
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
                      maxWidth: width *
                          (width > 280 ? 0.65 : 0.5), // Defines StreakWeek size
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Habit Name',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: color != yellowTheme
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
                          'assets/${theme == HabitTheme.bee ? 'bee' : 'flower'}${!isTodayDone ? '_gray' : ''}.svg',
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        streak.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: isTodayDone
                                  ? doneColor
                                  : color != yellowTheme
                                      ? Colors.white
                                      : darkBackground,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isTodayDone)
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
