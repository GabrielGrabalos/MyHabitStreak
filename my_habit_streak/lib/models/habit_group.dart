import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:uuid/uuid.dart';

import 'habit.dart';

class HabitGroup {
  static const int currentVersion = 2;

  final String id;
  final String name;
  final List<String> habitIds = [];

  HabitGroup({
    String? id,
    required this.name,
    List<String>? habitIds,
  }) :id = id ?? Uuid().v4();

  Future<Habit> getHabitById(String habitId) async {
    final habitList = await HabitStorageService.getHabits();

    return habitList.firstWhere((habit) => habit.id == habitId);
  }

  Future<List<Habit>> getHabits() async {
    final habitList = await HabitStorageService.getHabits();

    return habitList.where((habit) => habitIds.contains(habit.id)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'habitIds': habitIds,
    };
  }

  factory HabitGroup.fromJson(Map<String, dynamic> json) {
    return HabitGroup(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      habitIds: (json['habitIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
