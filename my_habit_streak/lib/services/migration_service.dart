import 'package:flutter/cupertino.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';

import '../models/habit.dart';

class MigrationService {
  static void migrateIfNeeded() async {
    final currentHabitVersion = Habit.currentVersion;
    final currentHabits = await HabitStorageService.getHabits();
    if (currentHabits.isEmpty) {
      debugPrint('No habits found. No migration needed.');
      return;
    }
    final firstHabit = currentHabits.first;
    final savedHabitsVersion = firstHabit.version;

    if (savedHabitsVersion < currentHabitVersion) {
      debugPrint('Migrating habits from version $savedHabitsVersion to $currentHabitVersion');
      final migratedHabits = await migrateHabits(currentHabits);
      await HabitStorageService.saveAllHabits(migratedHabits);
      debugPrint('Migration completed. All habits are now at version $currentHabitVersion');
      print("\n\n\nold habits:");
      print(currentHabits);
      print("\n\n\n\nMigrated habits:");
      print(migratedHabits);
    } else {
      debugPrint('No migration needed. Current version: $currentHabitVersion, Saved version: $savedHabitsVersion');
    }
  }

  static Future<List<Habit>> migrateHabits(List<Habit> oldHabits) async {
    final currentHabitVersion = Habit.currentVersion;
    if (oldHabits.isEmpty) return oldHabits;

    final migratedHabits = <Habit>[];
    for(final habit in oldHabits) {
      Habit migratedHabit = habit;
      for(int v = habit.version; v < currentHabitVersion; v++) {
        migratedHabit = _migrateHabitToNextVersion(habit, v);
      }

      migratedHabits.add(migratedHabit);
    }

    return migratedHabits;
  }

  static Habit _migrateHabitToNextVersion(Habit habit, int fromVersion) {
    switch(fromVersion) {
      case 1:
        return _migrateV1toV2(habit);
      // Future migrations can be added here
      default:
        debugPrint('No migration defined for version $fromVersion');
        return habit;
    }
  }

  // Version-to-version migration functions:

  static Habit _migrateV1toV2(Habit habit) {
    // Version 2 adds 'version' field and 'id' field:

    return Habit(
      id: habit.id.isEmpty ? UniqueKey().toString() : habit.id,
      title: habit.title,
      description: habit.description,
      theme: habit.theme,
      color: habit.color,
      streakHistory: habit.streakHistory,
      version: 2, // Update to new version
    );
  }
}