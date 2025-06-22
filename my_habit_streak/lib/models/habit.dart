import 'dart:ui'; // For Color
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/utils/habit_theme.dart'; // Assuming this defines your HabitTheme enum

class Habit {
  final String title;
  final String description;
  final HabitTheme theme;
  final Color color;
  final Map<String, bool>
      streakHistory; // Date string (YYYY-MM-DD) -> completion status

  int? _streak; // Cached streak value
  bool? _isTodayDone; // Cached today status

  // Default constructor with optional parameters:
  Habit({
    this.title = '',
    this.description = '',
    this.theme = HabitTheme.bee,
    this.color = blueTheme,
    Map<String, bool>? streakHistory,
  }) : streakHistory = streakHistory ?? {};

  // Helper function to format DateTime as YYYY-MM-DD
  String formatDate(DateTime date) {
    // Ensure consistent format, including padding for month/day if needed
    // For ISO8601String, it's already YYYY-MM-DD for the date part
    return date.toIso8601String().split('T')[0];
  }

  // Check if today's habit is completed
  bool get isTodayDone {
    if (_isTodayDone != null) return _isTodayDone!;

    // Using DateTime.now() without considering timezone or local date issues
    // could lead to inconsistencies around midnight or across timezones.
    // For a local app, it's often fine, but be aware.
    final today = DateTime.now();
    final todayKey = formatDate(today);
    _isTodayDone = streakHistory[todayKey] ?? false;
    return _isTodayDone!;
  }

  set isTodayDone(bool value) {
    final today = DateTime.now();
    final todayKey = formatDate(today);
    streakHistory[todayKey] = value;
    _isTodayDone = value;
    _streak = null; // Reset cached streak when updating today's status
  }

  // Calculate current streak length
  int get streak {
    if (_streak != null) return _streak!;

    DateTime current = DateTime.now().subtract(Duration(days: isTodayDone ? 0 : 1));
    int streak = 0;

    // Loop through past days to calculate streak
    // Streak counts consecutive 'true' days going backwards from today.
    // If today is done, it counts. If yesterday was done and today not, streak is 0.
    // If today is not done, but yesterday was, it depends on whether the check is
    // for a "current active streak" or "longest streak". This logic is for active streak.
    // Adjust max loop count (1000) based on expected max streak.
    while (streak < 1000) {
      final dateStr = formatDate(current);
      final status = streakHistory[dateStr];

      if (status == true) {
        streak++;
        current = current.subtract(const Duration(days: 1));
      } else {
        // If the current day is not true, break the streak.
        // Special case: if today is not true, but the previous day was,
        // and you want to count a streak that ended *yesterday*,
        // you'd need more complex logic. This current logic means
        // if today is not done, the streak is broken at today.
        break;
      }
    }
    _streak = streak; // Cache the calculated streak
    return _streak!;
  }

  // Get current week status (Sunday to Saturday)
  List<bool> getCurrentWeekStatus() {
    final today = DateTime.now();
    // Calculate the most recent Sunday (weekday returns 1 for Monday, 7 for Sunday)
    // Duration(days: today.weekday % 7) gives days since Sunday if Sunday=0.
    // So if today is Monday (1), subtract 1. If Sunday (7), subtract 0.
    final sunday = today.subtract(Duration(days: today.weekday % 7));

    return List.generate(7, (index) {
      final day = sunday.add(Duration(days: index));
      final dateKey = formatDate(day);
      return streakHistory[dateKey] ?? false;
    });
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      // Convert HabitTheme enum to its string name (e.g., 'bee', 'flower')
      'theme': theme.toString().split('.').last,
      // Convert Color object to its integer value (ARGB format)
      'color': color.value,
      // streakHistory is already Map<String, bool>, which is directly JSON-serializable
      'streakHistory': streakHistory,
    };
  }

  bool isHabitValid() {
    // Check if title is not empty and description is not empty
    return title.isNotEmpty && description.isNotEmpty;
  }

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;

    final Habit otherHabit = other as Habit;
    return title == otherHabit.title &&
        description == otherHabit.description &&
        theme == otherHabit.theme &&
        color == otherHabit.color &&
        streakHistory.toString() == otherHabit.streakHistory.toString();
  }

  // Create from JSON
  factory Habit.fromJson(Map<String, dynamic> json) {
    // Helper to parse HabitTheme from string
    HabitTheme parseHabitTheme(String themeString) {
      return HabitTheme.values.firstWhere(
        (e) => e.toString().split('.').last == themeString,
        orElse: () => HabitTheme.bee, // Provide a default if string not found
      );
    }

    return Habit(
      title: json['title'] as String,
      description: json['description'] as String,
      // Convert string back to HabitTheme enum
      theme: parseHabitTheme(json['theme'] as String),
      // Convert integer value back to Color object
      color: Color(json['color'] as int),
      // Map JSON dynamic map back to Map<String, bool>
      streakHistory: (json['streakHistory'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as bool),
      ),
    );
  }

  // Helper: Update properties (remains the same)
  Habit copyWith({
    String? title,
    String? description,
    HabitTheme? theme,
    Color? color,
    Map<String, bool>? streakHistory,
  }) {
    return Habit(
      title: title ?? this.title,
      description: description ?? this.description,
      theme: theme ?? this.theme,
      color: color ?? this.color,
      streakHistory: streakHistory ?? this.streakHistory,
    );
  }
}
