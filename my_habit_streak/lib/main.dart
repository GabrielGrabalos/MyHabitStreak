import 'package:flutter/material.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/screens/home_screen.dart';
import 'package:my_habit_streak/screens/visualize_habit.dart';
import 'package:my_habit_streak/theme.dart';
import 'package:my_habit_streak/widgets/habit_card.dart';

import 'models/habit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: textThemeWithWhite,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        VisualizeHabit.routeName: (context) {
          final habit = ModalRoute.of(context)?.settings.arguments as Habit;
          return VisualizeHabit(habit: habit);
        },
        CreateEditHabit.routeName: (context) {
          final habit = ModalRoute.of(context)?.settings.arguments as Habit;
          return CreateEditHabit(habit: habit);
        },
      },
    );
  }
}