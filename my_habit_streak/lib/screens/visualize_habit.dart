import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/screens/visualize_specific_habit_day.dart';
import 'package:my_habit_streak/widgets/add_completion_button.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/completion_list.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/streak_calendar.dart';
import 'package:my_habit_streak/widgets/streak_week.dart';
import 'package:my_habit_streak/widgets/time_selector.dart';
import '../l10n/app_localizations.dart';

import '../models/habit.dart';
import '../utils/colors.dart';

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
  late TextEditingController _noteController;
  late TimeSelectorController _timeSelectorController;

  @override
  void initState() {
    super.initState();
    // Initialize the current habit from the passed argument
    _currentHabit = widget.habit; // Use the habit passed to this widget
    _noteController = TextEditingController();
    _timeSelectorController = TimeSelectorController(
      hour: 0,
      minute: 0,
      color: _currentHabit.color,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  void onDayClick(String dateKey) {
    // If day is today or after:
    DateTime clickedDate = DateTime.parse(dateKey);
    DateTime today = DateTime.now();
    if (!clickedDate.isBefore(DateTime(today.year, today.month, today.day))) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VisualizeSpecificHabitDay(
        habit: _currentHabit,
        dateKey: dateKey,
      ),
    );
  }

  List<int> getDaysOfThisWeek() {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday; // 1 (Mon) to 7 (Sun)
    DateTime monday = now.subtract(Duration(days: currentWeekday - 1));
    return List<int>.generate(
        7, (index) => monday.add(Duration(days: index)).day - 1);
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
                arguments: _currentHabit,
              ) as Habit?;

              // Check if a habit was returned and if it's different
              if (updatedHabit != null && updatedHabit != _currentHabit) {
                setState(() {
                  _currentHabit = updatedHabit;
                });
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
                        'assets/${_currentHabit.theme.name}'
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
                        days: getDaysOfThisWeek(),
                        month: DateTime.now().month,
                        year: DateTime.now().year,
                        onDayClick: onDayClick,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: AddCompletionButton(
                      habit: _currentHabit,
                      noteController: _noteController,
                      timeSelectorController: _timeSelectorController,
                      onCompletionAdded: () => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.description,
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
                          : AppLocalizations.of(context)!.noDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.completions} ${_currentHabit.completions.length}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CompletionList(
                    habit: _currentHabit,
                    completions: _currentHabit.completions,
                    noteController: _noteController,
                    timeSelectorController: _timeSelectorController,
                    onCompletionsChanged: () => setState(() {}),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.streakHistory,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                  const SizedBox(height: 10),
                  StreakCalendar(
                    habit: _currentHabit,
                    onDayClick: onDayClick,
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
