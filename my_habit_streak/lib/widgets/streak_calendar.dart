import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

class StreakCalendar extends StatefulWidget {
  final Color color;

  const StreakCalendar({
    super.key,
    this.color = blueTheme,
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
        DateTime(currentDate.year, currentDate.month, 1).day;

    // Calculate the first week padding
    int firstWeekPadding = (firstWeekDayOfMonth - 1) % 7;

    // Add the first:
    weeks.add(
      StreakWeek(
        isOtherMonth: List.generate(
            7, (index) => index < firstWeekPadding ? true : false),
        dynamicLabelColor: false,
        // TODO: Replace with actual isDone logic
      ),
    );

    // Add the remaining weeks:
    while (dayCounter <= daysInMonth) {
      List<bool> isOtherMonth = List.generate(7, (index) => false);

      for (int i = 0; i < 7; i++) {
        if (dayCounter > daysInMonth) {
          isOtherMonth[i] = true; // Mark remaining days as other month
        }

        dayCounter++;
      }

      weeks.add(const SizedBox(height: 6));
      weeks.add(
        StreakWeek(
          labels: List.generate(7, (index) => ''),
          isOtherMonth: isOtherMonth,
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
        color: widget.color,
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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  updateMonth(-1);
                },
              ),
              Text(
                '${months[currentDate.month % 12]} ${currentDate.year}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
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
