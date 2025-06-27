import 'package:flutter/material.dart'; // Using Material Design widgets
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';

import '../main.dart';
import '../widgets/habit_list.dart';
import '../widgets/header.dart';
import 'create_edit_habit.dart'; // Your storage service

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  final HabitStorageService _habitStorageService = HabitStorageService();

  final List<Habit> _doneTodayHabits = [];
  final List<Habit> _notDoneTodayHabits = [];
  bool _isLoading = true; // State to manage loading indicator

  @override
  void initState() {
    super.initState();
    _loadAndSeparateHabits(); // Load and separate habits when the screen initializes
  }

  // Subscribe to route observer
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // Unsubscribe to prevent memory leaks
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // Called when returning to HomeScreen via pop
  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAndSeparateHabits(); // Reload habits when returning to this screen
    });
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
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            children: [
              Header(
                title: 'My Habits',
                icon: Icons.add,
                onActionPressed: () async {
                  // Navigate to the Create/Edit Habit screen
                  final Habit? newHabit = await Navigator.pushNamed(
                    context,
                    CreateEditHabit.routeName,
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
                            if (_notDoneTodayHabits.isNotEmpty) ...[
                              HabitList(
                                title: 'Not Done Today',
                                habits: _notDoneTodayHabits,
                              ),
                              const SizedBox(height: 20),
                            ],
                            if (_doneTodayHabits.isNotEmpty)
                              HabitList(
                                title: 'Done Today',
                                habits: _doneTodayHabits,
                              ),
                            if (_doneTodayHabits.isEmpty &&
                                _notDoneTodayHabits.isEmpty)
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    right: 35,
                                  ),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/bee_button_indicator.svg',
                                        width: constraints.maxWidth * 0.8,
                                      ),
                                      const SizedBox(height: 10),
                                      Transform.rotate(
                                        angle: -0.25,
                                        child: Text(
                                          'Start by creating\na new habit!',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
