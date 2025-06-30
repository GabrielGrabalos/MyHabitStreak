import 'package:flutter/material.dart';
import 'package:my_habit_streak/l10n/l10n.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/screens/home_screen.dart';
import 'package:my_habit_streak/screens/visualize_habit.dart';
import 'package:my_habit_streak/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/habit.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Habit Streak',
      theme: textThemeWithWhite,
      navigatorObservers: [routeObserver],
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        VisualizeHabit.routeName: (context) {
          final habit = ModalRoute.of(context)?.settings.arguments as Habit;
          return VisualizeHabit(habit: habit);
        },
        CreateEditHabit.routeName: (context) {
          final habit = ModalRoute.of(context)?.settings.arguments as Habit? ?? Habit();
          return CreateEditHabit(habit: habit);
        },
      },
    );
  }
}