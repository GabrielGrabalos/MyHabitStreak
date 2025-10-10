import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/habit_group_tag.dart';
import 'package:my_habit_streak/widgets/habits_container.dart';

import '../models/habit.dart';
import '../models/habit_group.dart';

class HabitGroupView extends StatelessWidget {
  final List<HabitGroup> habitGroups;
  final HabitGroup? selectedHabitGroup;
  final List<Habit> currentHabits;
  final List<Habit> allHabits;
  final Function(HabitGroup) onGroupSelected;
  final Function(HabitGroup) onGroupEdit;
  final Function(HabitGroup) onGroupDelete;
  final Function() onAddGroup;
  final ScrollController scrollController;

  const HabitGroupView({
    super.key,
    required this.habitGroups,
    required this.selectedHabitGroup,
    required this.currentHabits,
    required this.allHabits,
    required this.onGroupSelected,
    required this.onGroupEdit,
    required this.onGroupDelete,
    required this.onAddGroup,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            key: const PageStorageKey('habit_group_scroll'),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
              child: Row(
                children: [
                  ...habitGroups.map((group) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: HabitGroupTag(
                        label: group.name,
                        color: group.color,
                        onPressed: () => onGroupSelected(group),
                        onGroupEdit: () => onGroupEdit(group),
                        onGroupDelete: () => onGroupDelete(group),
                        isSelected: group.id == selectedHabitGroup?.id,
                        hasMenu:
                            !['all', 'done', 'not_done'].contains(group.id),
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: HabitGroupTag(
                      label: '',
                      icon: Icons.add,
                      color: blueTheme,
                      onPressed: onAddGroup,
                      onGroupEdit: () {},
                      onGroupDelete: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          HabitsContainer(habits: currentHabits),
        ],
      ),
    );
  }
}
