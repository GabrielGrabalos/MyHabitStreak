import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
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
  // It's good practice to have a mutable habit in the state if it can be updated
  // within this widget or from a navigated screen.
  late Habit _currentHabit; // Use a private variable for the mutable state

  @override
  void initState() {
    super.initState();
    // Initialize the current habit from the passed argument
    _currentHabit = widget.habit; // Use the habit passed to this widget
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: _currentHabit.title, // Use _currentHabit
            icon: Icons.edit,
            onActionPressed: () async {
              // Make the callback `async`
              final updatedHabit = await Navigator.pushNamed(
                context,
                CreateEditHabit.routeName,
                arguments: _currentHabit, // Pass the current state of the habit
              ) as Habit?; // Cast the result to Habit? (nullable)

              // Check if a habit was returned and if it's different
              if (updatedHabit != null && updatedHabit != _currentHabit) {
                setState(() {
                  _currentHabit = updatedHabit; // Update the state
                });
                // TODO: You'll also need to save this updatedHabit to your persistent storage here.
                // For example:
                // await HabitStorageService().saveHabits(listOfAllHabits); // You'll need access to the list of habits
                // Or if you have a method to update a single habit in your service:
                // await HabitStorageService().updateHabit(updatedHabit);
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30),
                      SvgPicture.asset(
                        'assets/${_currentHabit.theme == HabitTheme.bee ? 'bee' : 'flower'}'
                        '${!_currentHabit.isTodayDone ? '_gray' : ''}.svg',
                        width: 150,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        _currentHabit.streak.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 84,
                              fontWeight: FontWeight.bold,
                              color: _currentHabit.isTodayDone
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
                        color: _currentHabit.color,
                        borderRadius: BorderRadius.circular(25),
                        border: Border(
                          bottom: BorderSide(
                            color: lowerLuminosity(_currentHabit.color, 0.7),
                            width: 5.0,
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: StreakWeek(
                        isDone: _currentHabit.getCurrentWeekStatus(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Button(
                      color: _currentHabit.color,
                      label:
                          'Mark as ${_currentHabit.isTodayDone ? 'not done' : 'done'}',
                      onPressed: () async {
                        final confirmChange = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return DialogPopup(
                              title: _currentHabit.isTodayDone
                                  ? 'Mark as not done?'
                                  : 'Mark as done?',
                              message:
                                  'Are you sure you want to mark this habit as'
                                  ' ${_currentHabit.isTodayDone ? 'not done' : 'done'}?'
                                  '\nRemember, we\'re here to help. Don\'t lie to yourself!',
                              theme: _currentHabit.theme,
                              color: _currentHabit.color,
                            );
                          },
                        );

                        if (!confirmChange!) return;

                        setState(() {
                          _currentHabit.isTodayDone =
                              !_currentHabit.isTodayDone;
                          HabitStorageService().saveOrUpdateHabit(
                              _currentHabit.title, _currentHabit);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _currentHabit.description != ''
                          ? _currentHabit.description
                          : 'No description provided.',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color lowerLuminosity(Color color, double diminishingFactor) {
    return Color.fromRGBO(
      (color.r * 255 * diminishingFactor).round(),
      (color.g * 255 * diminishingFactor).round(),
      (color.b * 255 * diminishingFactor).round(),
      1,
    );
  }
}
