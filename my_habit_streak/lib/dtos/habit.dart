import 'dart:ui';

import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/utils/habit_theme.dart';

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
    this.title = 'New Habit',
    this.description = 'Description of the habit',
    this.theme = HabitTheme.bee,
    this.color = blueTheme,
    Map<String, bool>? streakHistory,
  }) : streakHistory = streakHistory ?? {};

  // Helper function to format DateTime as YYYY-MM-DD
  String formatDate(DateTime date) {
    return date.toIso8601String().split('T')[0];
  }

  // Check if today's habit is completed
  bool get isTodayDone {
    if (_isTodayDone != null) return _isTodayDone!;

    final today = DateTime.now();
    final todayKey = formatDate(today);
    _isTodayDone = streakHistory[todayKey] ?? false;
    return _isTodayDone!;
  }

  // Calculate current streak length
  int get streak {
    if (_streak != null) return _streak!;

    DateTime current = DateTime.now();
    int streak = 0;

    while (streak < 1000) {
      // Prevent infinite loops
      final dateStr = formatDate(current);
      final status = streakHistory[dateStr];

      if (status == true) {
        streak++;
        current = current.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  // Get current week status (Sunday to Saturday)
  List<bool> getCurrentWeekStatus() {
    final today = DateTime.now();
    // Find the most recent Sunday
    final sunday = today.subtract(Duration(days: today.weekday));

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
      'theme': theme,
      'color': color,
      'streakHistory': streakHistory,
    };
  }

  // Create from JSON
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      title: json['title'] as String,
      description: json['description'] as String,
      theme: json['theme'] as HabitTheme,
      color: json['color'] as Color,
      streakHistory: (json['streakHistory'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value as bool),
      ),
    );
  }

  // Helper: Update properties
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
