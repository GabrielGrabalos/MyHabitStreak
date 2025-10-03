import 'package:flutter/cupertino.dart';
import 'package:my_habit_streak/widgets/habits_container.dart';

class HabitGroupView extends StatefulWidget {
  const HabitGroupView({super.key});

  @override
  State<HabitGroupView> createState() => _HabitGroupViewState();
}

class _HabitGroupViewState extends State<HabitGroupView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Row(
            children: [],
          ),
        ),
        HabitsContainer(
          habits: [],
        ),
      ],
    );
  }
}
