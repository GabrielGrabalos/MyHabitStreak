import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

// COpy with white color:
final textTheme = ThemeData(
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 18.0,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16.0,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14.0,
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 32.0,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 28.0,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 24.0,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 36.0,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 32.0,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 28.0,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 18.0,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14.0,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16.0,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14.0,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12.0,
      color: Colors.white,
    ),
  ),
);

final textThemeWithWhite = textTheme.copyWith(
  textTheme: textTheme.textTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: darkBackground,
    onPrimary: Colors.white,
    secondary: yellowTheme,
    onSecondary: Colors.black54,
    error: Colors.red,
    onError: Colors.white,
    surface: darkBackground,
    onSurface: Colors.white,
  ),
);
