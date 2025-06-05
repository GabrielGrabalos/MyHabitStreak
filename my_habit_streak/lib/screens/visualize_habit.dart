import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';

import '../models/habit.dart';
import '../utils/colors.dart';
import '../utils/habit_theme.dart';

class VisualizeHabit extends StatefulWidget {
  static const String routeName = '/visualize-habit';
  final Habit habit;

  const VisualizeHabit({
    super.key,
    required this.habit,
  });

  @override
  State<VisualizeHabit> createState() => _VisualizeHabitState();
}

class _VisualizeHabitState extends State<VisualizeHabit> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: widget.habit.title,
            icon: Icons.edit,
            onActionPressed: () {
              // Action when the edit icon is pressed
              Navigator.pushNamed(context, CreateEditHabit.routeName,
                  arguments: widget.habit);
            },
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/${widget.habit.theme == HabitTheme.bee ? 'bee' : 'flower'}'
                      '${!widget.habit.isTodayDone ? '_gray' : ''}.svg',
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      widget.habit.streak.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 84,
                            fontWeight: FontWeight.bold,
                            color: widget.habit.isTodayDone
                                ? doneColor
                                : Colors.white,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.habit.color,
                      borderRadius: BorderRadius.circular(25),
                      // Bottom border with lower luminosity to simulate 3D effect
                      border: Border(
                        bottom: BorderSide(
                          color: lowerLuminosity(widget.habit.color, 0.7),
                          width: 5.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: StreakWeek(
                      isDone: widget.habit.getCurrentWeekStatus(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Button(
                    color: widget.habit.color,
                    label:
                        'Mark as ${widget.habit.isTodayDone ? 'not done' : 'done'}',
                    onPressed: () => setState(() {
                      // Update the habit's completion status
                      widget.habit.isTodayDone = !widget.habit.isTodayDone;
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text('Description',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.habit.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  lowerLuminosity(Color color, double diminishingFactor) {
    // Function to lower the luminosity of a color
    return Color.fromRGBO(
      (color.red * diminishingFactor).round(),
      (color.green * diminishingFactor).round(),
      (color.blue * diminishingFactor).round(),
      1,
    );
  }
}
