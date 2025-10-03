import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_habit_streak/models/habit.dart'; // Adjust this path to your Habit model

class HabitStorageService {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _habitsKey = 'user_habits';

  // 1. Create a StreamController
  static final _habitsStreamController = StreamController<List<Habit>>.broadcast();

  // 2. Expose the stream for others to listen to
  // .broadcast() allows multiple listeners.
  static Stream<List<Habit>> get habitsStream => _habitsStreamController.stream;

  // You should also have a method to close the stream when the service is no longer needed
  void dispose() {
    _habitsStreamController.close();
  }

  // --- Primary method for saving the entire list of habits ---
  // All modifications (add, update, delete) will eventually call this.
  static Future<void> saveAllHabits(List<Habit> habits) async {
    // Convert each Habit object to its JSON representation
    final List<Map<String, dynamic>> habitsJson =
        habits.map((habit) => habit.toJson()).toList();
    // Encode the list of JSON objects into a single JSON string
    final String jsonString = jsonEncode(habitsJson);
    // Store the JSON string securely
    await _storage.write(key: _habitsKey, value: jsonString);

    debugPrint('Habits saved: ${habits.length} items'); // Debugging output
    
    // 3. Notify all listeners about the updated list
    _habitsStreamController.add(habits);
  }

  // Retrieve a list of Habits
  static Future<List<Habit>> getHabits() async {
    // Read the JSON string from secure storage
    final String? jsonString = await _storage.read(key: _habitsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return []; // Return an empty list if no habits are stored or string is empty
    }

    try {
      // Decode the JSON string back into a list of JSON objects
      // It MUST be a List because saveAllHabits always saves a List
      final List<dynamic> decodedJson = jsonDecode(jsonString);

      // Convert each JSON object back into a Habit instance
      return decodedJson
          .map((json) => Habit.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error decoding habits: $e');
      // If data is corrupted, clear it to prevent continuous errors
      // await clearAllHabits();
      return [];
    }
  }

  // --- New/Updated: Save or Update a single Habit ---
  // This is the "save habit function" you asked for.
  // It handles both adding a new habit and updating an existing one.
  static Future<void> saveOrUpdateHabit(String originalTitle, Habit habitToSave) async {
    List<Habit> currentHabits = await getHabits();

    // Find the index of the habit if it already exists (e.g., by title)
    // IMPORTANT: For robust updates, consider adding a unique ID to your Habit model.
    // For now, we'll use title as a simple identifier.
    int existingIndex =
        currentHabits.indexWhere((h) => h.title == originalTitle);

    if (existingIndex != -1) {
      // Habit exists, update it in the list
      currentHabits[existingIndex] = habitToSave;
      debugPrint('Habit updated: ${habitToSave.title}');
    } else {
      // Habit is new, add it to the list
      currentHabits.add(habitToSave);
      debugPrint('Habit added: ${habitToSave.title}');
    }

    // Save the entire updated list back to storage
    await saveAllHabits(currentHabits);
  }

  // Delete a specific habit by its identifier (e.g., title)
  static Future<void> deleteHabit(String habitTitle) async {
    List<Habit> currentHabits = await getHabits();
    // Remove the habit based on its title
    currentHabits.removeWhere((h) => h.title == habitTitle);
    debugPrint('Habit deleted: $habitTitle');
    // Save the updated list back
    await saveAllHabits(currentHabits);
  }

  // Clear all stored habits
  static Future<void> clearAllHabits() async {
    await _storage.delete(key: _habitsKey);
    debugPrint('All habits cleared.'); // Debugging output
  }
}
