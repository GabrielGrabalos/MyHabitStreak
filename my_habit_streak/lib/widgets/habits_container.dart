import 'package:flutter/cupertino.dart';
import 'package:my_habit_streak/models/habit.dart';

import 'habit_card.dart';

class HabitsContainer extends StatelessWidget {
  final List<Habit> habits;

  const HabitsContainer({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
