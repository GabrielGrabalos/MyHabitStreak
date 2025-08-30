import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/habit_card.dart';

import '../models/habit.dart';

class HabitList extends StatelessWidget {
  final String title;
  final List<Habit> habits;

  const HabitList({
    super.key,
    required this.title,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            8.0,
            16.0,
            0.0,
            0.0,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
        ...habits.map(
          (habit) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: HabitCard(habit: habit),
          ),
        ),
      ],
    );
  }
}
