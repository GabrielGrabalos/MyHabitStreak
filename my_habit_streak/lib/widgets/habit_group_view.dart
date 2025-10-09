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
  final Function() onAddGroup;
  final ScrollController scrollController; // ✅ NEW

  const HabitGroupView({
    super.key,
    required this.habitGroups,
    required this.selectedHabitGroup,
    required this.currentHabits,
    required this.allHabits,
    required this.onGroupSelected,
    required this.onGroupEdit,
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
                        onLongPress: () {
                          if (!['all', 'not_done', 'done'].contains(group.id)) {
                            onGroupEdit(group);
                          }
                        },
                        isSelected: group.id == selectedHabitGroup?.id,
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
                      onLongPress: () {},
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
