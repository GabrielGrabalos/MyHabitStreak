import 'dart:ui'; // Add this import for PlatformDispatcher
import 'package:flutter/material.dart';
import 'package:my_habit_streak/l10n/l10n.dart';
import 'package:my_habit_streak/screens/create_edit_habit.dart';
import 'package:my_habit_streak/screens/home_screen.dart';
import 'package:my_habit_streak/screens/visualize_habit.dart';
import 'package:my_habit_streak/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_habit_streak/utils/general_storage_service.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'models/habit.dart';
import 'notifications/notification_service.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.initialize();

  // Initialize your habit storage
  final habitStorage = HabitStorageService();

  // Schedule notifications
  await notificationService.scheduleDailyNotifications(habitStorage);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
      GeneralStorageService().saveData('language', value.languageCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _resolveSystemLocale();
  }

  void _resolveSystemLocale() async {
    final savedPreferences = await GeneralStorageService().getData('language')
        as String?; // Comes as locale language code

    print('Saved locale: $savedPreferences');

    if (savedPreferences != null) {
      // If a saved locale exists, use it
      setLocale(Locale(savedPreferences));
      return;
    }
    // Get system locales from PlatformDispatcher
    final systemLocales = PlatformDispatcher.instance.locales;

    // Find best matching supported locale
    final resolvedLocale = _findBestLocaleMatch(systemLocales);
    setLocale(resolvedLocale);
  }

  Locale _findBestLocaleMatch(List<Locale> systemLocales) {
    // Try to find exact match (language + country)
    for (final locale in systemLocales) {
      if (L10n.all.contains(locale)) {
        return locale;
      }
    }

    // Try language-only match
    for (final locale in systemLocales) {
      final languageOnly = Locale(locale.languageCode);
      if (L10n.all.contains(languageOnly)) {
        return languageOnly;
      }
    }

    // Fallback to English
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Habit Streak',
      theme: textThemeWithWhite,
      navigatorObservers: [routeObserver],
      supportedLocales: L10n.all,
      locale: _locale,
      debugShowCheckedModeBanner: false,
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
          final habit =
              ModalRoute.of(context)?.settings.arguments as Habit? ?? Habit();
          return CreateEditHabit(habit: habit);
        },
      },
    );
  }
}
