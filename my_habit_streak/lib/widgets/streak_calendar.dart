import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../models/habit.dart';

class StreakCalendar extends StatefulWidget {
  final Habit habit;

  const StreakCalendar({
    super.key,
    required this.habit,
  });

  @override
  State<StreakCalendar> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State<StreakCalendar> {
  final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  DateTime currentDate = DateTime.now();

  void updateMonth(int monthOffset) {
    setState(() {
      currentDate = DateTime(
        currentDate.year,
        currentDate.month + monthOffset,
        currentDate.day,
      );
    });
  }

  List<Widget> _buildWeeks() {
    List<Widget> weeks = [];
    int dayCounter = 1;

    // Calculate the number of days in the current month
    int daysInMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    int firstWeekDayOfMonth =
        DateTime(currentDate.year, currentDate.month, 1).weekday % 7;

    List<bool> weekStreakHistory = widget.habit.getWeekHistory(
      currentDate.year,
      currentDate.month,
      dayCounter,
    );

    // Add the first:
    weeks.add(
      StreakWeek(
        isDone: weekStreakHistory,
        isOtherMonth: List.generate(
            7, (index) => index < firstWeekDayOfMonth ? true : false),
        dynamicLabelColor: false,
        days: List.generate(
          7,
          (index) => index < firstWeekDayOfMonth ? 0 : dayCounter++,
        ),
      ),
    );

    // Add the remaining weeks:
    while (dayCounter <= daysInMonth) {
      List<bool> isOtherMonth = List.generate(7, (index) => false);
      List<int> days = List.generate(7, (index) => 0);

      weekStreakHistory = widget.habit.getWeekHistory(
        currentDate.year,
        currentDate.month,
        dayCounter,
      );

      for (int i = 0; i < 7; i++) {
        if (dayCounter > daysInMonth) {
          isOtherMonth[i] = true; // Mark remaining days as other month
        }
        days[i] = dayCounter <= daysInMonth ? dayCounter : dayCounter - daysInMonth;
        dayCounter++;
      }

      weeks.add(const SizedBox(height: 15.0));
      weeks.add(
        StreakWeek(
          labels: List.generate(7, (index) => ''),
          isDone: weekStreakHistory,
          isOtherMonth: isOtherMonth,
          days: days,
        ),
      );
    }

    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.habit.color,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back,
                    color: widget.habit.color != yellowTheme
                        ? Colors.white
                        : darkBackground),
                onPressed: () {
                  updateMonth(-1);
                },
              ),
              Text(
                '${months[currentDate.month - 1]} ${currentDate.year}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.habit.color != yellowTheme
                          ? Colors.white
                          : darkBackground,
                    ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward,
                    color: widget.habit.color != yellowTheme
                        ? Colors.white
                        : darkBackground),
                onPressed: () {
                  updateMonth(1);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          ..._buildWeeks(),
        ],
      ),
    );
  }
}
