import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_habit_streak/models/habit_group.dart';

import '../models/habit.dart';

class HabitGroupStorageService {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _habitGroupsKey = 'user_habit_groups';

  // 1. Create a StreamController
  static final _habitGroupsStreamController =
      StreamController<List<HabitGroup>>.broadcast();

  // 2. Expose the stream for others to listen to
  // .broadcast() allows multiple listeners.
  static Stream<List<HabitGroup>> get habitsStream =>
      _habitGroupsStreamController.stream;

  // You should also have a method to close the stream when the service is no longer needed
  void dispose() {
    _habitGroupsStreamController.close();
  }

  static Future<List<HabitGroup>> getAllHabitGroups() async {
    // Read the JSON string from secure storage
    final String? jsonString = await _storage.read(key: _habitGroupsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return []; // Return an empty list if no habits are stored or string is empty
    }

    try {
      // Decode the JSON string back into a list of JSON objects
      // It MUST be a List because saveAllHabits always saves a List
      final List<dynamic> decodedJson = jsonDecode(jsonString);

      // Convert each JSON object back into a Habit instance
      return decodedJson
          .map((json) => HabitGroup.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error decoding habits: $e');
      return [];
    }
  }

  static Future<void> saveAllHabitGroups(List<HabitGroup> habitGroups) async {
    // Convert each Habit object to its JSON representation
    final List<Map<String, dynamic>> habitsJson =
        habitGroups.map((habit) => habit.toJson()).toList();
    // Encode the list of JSON objects into a single JSON string
    final String jsonString = jsonEncode(habitsJson);
    // Store the JSON string securely
    await _storage.write(key: _habitGroupsKey, value: jsonString);

    debugPrint('Habits saved: ${habitGroups.length} items'); // Debugging output

    // 3. Notify all listeners about the updated list
    _habitGroupsStreamController.add(habitGroups);
  }

  static Future<void> saveOrUpdateHabitGroup(HabitGroup habitGroup,
      {String? id}) async {
    final currentHabitGroups = await getAllHabitGroups();

    id ??= habitGroup.id;

    int existingIndex = currentHabitGroups.indexWhere((h) => h.id == id);

    if (existingIndex != -1) {
      currentHabitGroups[existingIndex] = habitGroup;
    } else {
      currentHabitGroups.add(habitGroup);
    }

    await saveAllHabitGroups(currentHabitGroups);
  }

  static Future<void> createNewHabitGroup(String name, Habit? habit) async {
    final newHabitGroup =
        HabitGroup(name: name, habitIds: habit != null ? [habit.id] : []);

    await saveOrUpdateHabitGroup(newHabitGroup);
  }

  static Future<void> deleteHabitGroup(String id) async {
    List<HabitGroup> currentHabits = await getAllHabitGroups();
    currentHabits.removeWhere((hg) => hg.id == id);
    await saveAllHabitGroups(currentHabits);
  }
}
