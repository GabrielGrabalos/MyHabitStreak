import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_habit_streak/services/habit_group_storage_service.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/habit_group_tag.dart';
import 'package:my_habit_streak/widgets/habits_container.dart';

import '../models/habit.dart';
import '../models/habit_group.dart';

class HabitGroupView extends StatefulWidget {
  const HabitGroupView({super.key});

  @override
  State<HabitGroupView> createState() => _HabitGroupViewState();
}

class _HabitGroupViewState extends State<HabitGroupView> with RouteAware {
  late StreamSubscription _habitGroupSubscription;
  late StreamSubscription _habitsSubscription;

  late List<HabitGroup> habitGroups;
  late HabitGroup selectedHabitGroup;
  late List<Habit> currentHabits;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabitGroupsAndHabits();
    _habitGroupSubscription =
        HabitGroupStorageService.habitGroupsStream.listen((updatedHabitGroups) {
      _loadHabitGroupsAndHabits();
    });
    _habitsSubscription =
        HabitStorageService.habitsStream.listen((updatedHabits) {
      _loadHabitGroupsAndHabits();
    });
  }

  Future<void> _loadHabitGroupsAndHabits() async {
    setState(() {
      isLoading = true;
    });

    habitGroups = await HabitGroupStorageService.getAllHabitGroups();
    final allHabits = await HabitStorageService.getHabits();
    List<String> allHabitIds = [];
    for (var habit in allHabits) {
      allHabitIds.add(habit.id);
    }

    List<String> notDoneHabitIds = [];
    List<String> doneHabitIds = [];
    for (var habit in allHabits) {
      if (!habit.isTodayDone) {
        notDoneHabitIds.add(habit.id);
      } else {
        doneHabitIds.add(habit.id);
      }
    }

    final notDoneGroup = HabitGroup(
      id: 'not_done',
      name: 'Not Done',
      habitIds: notDoneHabitIds,
    );

    final doneGroup = HabitGroup(
      id: 'done',
      name: 'Done',
      habitIds: doneHabitIds,
    );

    final allGroup = HabitGroup(
      id: 'all',
      name: 'All',
      habitIds: allHabitIds,
    );

    habitGroups.insert(0, allGroup);
    habitGroups.insert(1, notDoneGroup);
    habitGroups.insert(2, doneGroup);

    selectedHabitGroup = habitGroups[0];
    await _loadHabitsFromSelectedGroup();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadHabitsFromSelectedGroup() async {
    final aux =
        await HabitStorageService.getHabitsById(selectedHabitGroup.habitIds);
    setState(() {
      currentHabits = aux;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox.expand(
        // Takes all available space
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...habitGroups.map(
                (group) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 6.0,
                  ),
                  child: HabitGroupTag(
                    label: group.name,
                    color: group.color,
                    onPressed: () {
                      setState(() {
                        selectedHabitGroup = group;
                      });
                      _loadHabitsFromSelectedGroup();
                    },
                    isSelected: group.id == selectedHabitGroup.id,
                  ),
                ),
              ),
              HabitGroupTag(
                label: '',
                icon: Icons.add,
                onPressed: () {},
                color: blueTheme,
              ),
            ],
          ),
        ),
        HabitsContainer(
          habits: currentHabits,
        ),
      ],
    );
  }
}
