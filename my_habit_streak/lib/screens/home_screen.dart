import 'package:flutter/material.dart'; // Using Material Design widgets
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';

import '../widgets/habit_list.dart';
import '../widgets/header.dart';
import 'create_edit_habit.dart'; // Your storage service

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HabitStorageService _habitStorageService = HabitStorageService();

  final List<Habit> _doneTodayHabits = [];
  final List<Habit> _notDoneTodayHabits = [];
  bool _isLoading = true; // State to manage loading indicator

  @override
  void initState() {
    super.initState();
    _loadAndSeparateHabits(); // Load and separate habits when the screen initializes
  }

  // Method to load all habits and separate them
  Future<void> _loadAndSeparateHabits() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final List<Habit> allHabits = await _habitStorageService.getHabits();

      // Clear previous lists before repopulating
      _doneTodayHabits.clear();
      _notDoneTodayHabits.clear();

      for (var habit in allHabits) {
        if (habit.isTodayDone) {
          _doneTodayHabits.add(habit);
        } else {
          _notDoneTodayHabits.add(habit);
        }
      }
    } catch (e) {
      // Handle any errors during habit loading
      print('Error loading habits: $e');
      // Potentially show an error message to the user
    } finally {
      setState(() {
        _isLoading = false; // End loading, even if there was an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: 'My Habits',
            icon: Icons.add,
            onActionPressed: () async {
              // Navigate to the Create/Edit Habit screen
              final Habit? newHabit = await Navigator.pushNamed(
                context,
                CreateEditHabit.routeName,
                arguments: Habit(),
              ) as Habit?;

              // If a new habit was created, reload the habits
              if (newHabit != null) {
                await _loadAndSeparateHabits();
              }
            },
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        if (_doneTodayHabits.isNotEmpty)
                          HabitList(
                            title: 'Done Today',
                            habits: _doneTodayHabits,
                          ),
                        if (_notDoneTodayHabits.isNotEmpty)
                          HabitList(
                            title: 'Not Done Today',
                            habits: _notDoneTodayHabits,
                          ),
                        if (_doneTodayHabits.isEmpty &&
                            _notDoneTodayHabits.isEmpty)
                          const Center(child: Text('No habits found')),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
