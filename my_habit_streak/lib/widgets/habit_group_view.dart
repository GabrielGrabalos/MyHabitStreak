import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_habit_streak/services/habit_group_storage_service.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/habit_group_tag.dart';
import 'package:my_habit_streak/widgets/habits_container.dart';
import 'package:my_habit_streak/screens/create_group_bottom_sheet.dart';

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
  HabitGroup? selectedHabitGroup;
  late List<Habit> currentHabits;
  List<Habit> allHabits = [];
  bool isLoading = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
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

  @override
  void dispose() {
    _scrollController.dispose();
    _habitGroupSubscription.cancel();
    _habitsSubscription.cancel();
    super.dispose();
  }

  Future<void> _loadHabitGroupsAndHabits() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    final previouslySelectedId = selectedHabitGroup?.id;

    habitGroups = await HabitGroupStorageService.getAllHabitGroups();
    allHabits = await HabitStorageService.getHabits();

    // Build the default dynamic groups
    List<String> allHabitIds = allHabits.map((h) => h.id).toList();
    List<String> notDoneHabitIds =
        allHabits.where((h) => !h.isTodayDone).map((h) => h.id).toList();
    List<String> doneHabitIds =
        allHabits.where((h) => h.isTodayDone).map((h) => h.id).toList();

    final allGroup = HabitGroup(id: 'all', name: 'All', habitIds: allHabitIds);
    final notDoneGroup =
        HabitGroup(id: 'not_done', name: 'Not Done', habitIds: notDoneHabitIds);
    final doneGroup =
        HabitGroup(id: 'done', name: 'Done', habitIds: doneHabitIds);

    habitGroups.insert(0, allGroup);
    habitGroups.insert(1, notDoneGroup);
    habitGroups.insert(2, doneGroup);

    // Try to restore previously selected group
    selectedHabitGroup = habitGroups.firstWhere(
      (g) => g.id == previouslySelectedId,
      orElse: () => habitGroups[0], // Default to All
    );

    await _loadHabitsFromSelectedGroup();

    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadHabitsFromSelectedGroup() async {
    if (selectedHabitGroup == null) return;

    if (['all', 'not_done', 'done'].contains(selectedHabitGroup!.id)){
      // Build the default dynamic groups
      List<String> allHabitIds = allHabits.map((h) => h.id).toList();
      List<String> notDoneHabitIds =
      allHabits.where((h) => !h.isTodayDone).map((h) => h.id).toList();
      List<String> doneHabitIds =
      allHabits.where((h) => h.isTodayDone).map((h) => h.id).toList();

      habitGroups[0] = HabitGroup(id: 'all', name: 'All', habitIds: allHabitIds);
      habitGroups[1] = HabitGroup(id: 'not_done', name: 'Not Done', habitIds: notDoneHabitIds);
      habitGroups[2] = HabitGroup(id: 'done', name: 'Done', habitIds: doneHabitIds);
    }

    final aux =
        await HabitStorageService.getHabitsById(selectedHabitGroup!.habitIds);
    if (!mounted) return;
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

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 10.0,
              ),
              child: Row(
                children: [
                  ...habitGroups.map(
                    (group) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: HabitGroupTag(
                        label: group.name,
                        color: group.color,
                        onPressed: () {
                          setState(() {
                            selectedHabitGroup = group;
                          });
                          _loadHabitsFromSelectedGroup();
                        },
                        isSelected: group.id == selectedHabitGroup?.id,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: HabitGroupTag(
                      label: '',
                      icon: Icons.add,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          // allows full screen
                          backgroundColor: Colors.transparent,
                          // keeps rounded corners visible
                          builder: (context) => CreateGroupBottomSheet(
                            availableHabits: allHabits,
                            onCreate: (newGroup) async {
                              await HabitGroupStorageService
                                  .saveOrUpdateHabitGroup(newGroup);
                              setState(() {
                                selectedHabitGroup = newGroup;
                              });
                              _loadHabitsFromSelectedGroup();
                            },
                          ),
                        );
                      },
                      color: blueTheme,
                    ),
                  ),
                ],
              ),
            ),
          ),
          HabitsContainer(
            habits: currentHabits,
          ),
        ],
      ),
    );
  }
}
