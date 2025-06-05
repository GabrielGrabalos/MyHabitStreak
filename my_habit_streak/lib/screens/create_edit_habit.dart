import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/color_selector.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/theme_selector.dart';

import '../models/habit.dart';

class CreateEditHabit extends StatefulWidget {
  static const String routeName = '/create-edit-habit';
  final Habit habit;
  static HabitStorageService habitStorageService =
      HabitStorageService(); // Singleton instance for habit storage

  const CreateEditHabit({super.key, required this.habit});

  @override
  State<CreateEditHabit> createState() => _CreateEditHabitState();
}

class _CreateEditHabitState extends State<CreateEditHabit> {
  // Create mutable state variables
  late Habit _editableHabit;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialize with a copy of the original habit
    _editableHabit = widget.habit;
    _titleController = TextEditingController(text: _editableHabit.title);
    _descriptionController =
        TextEditingController(text: _editableHabit.description);
  }

  @override
  void dispose() {
    // Clean up controllers
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: 'Create Habit',
            icon: CupertinoIcons.xmark,
            onActionPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  ThemeSelector(
                    color: _editableHabit.color,
                    selectedTheme: _editableHabit.theme,
                    onChanged: (value) {
                      setState(() {
                        _editableHabit = _editableHabit.copyWith(theme: value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ColorSelector(
                    selectedColor: _editableHabit.color,
                    onColorSelected: (color) {
                      setState(() {
                        _editableHabit = _editableHabit.copyWith(color: color);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _titleController,
                      onChanged: (value) {
                        setState(() {
                          _editableHabit =
                              _editableHabit.copyWith(title: value);
                        });
                      },
                      cursorColor: _editableHabit.color,
                      decoration: InputDecoration(
                        labelText: 'Habit Title',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: _editableHabit.color,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: _editableHabit.color,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onEditingComplete: () {
                        // Focus on next field when editing is complete
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _descriptionController,
                      onChanged: (value) {
                        setState(() {
                          _editableHabit =
                              _editableHabit.copyWith(description: value);
                        });
                      },
                      // Set minLines to 3 for a minimum height of 3 lines
                      minLines: 3,
                      // Set maxLines to null to allow the field to grow indefinitely
                      maxLines: null,
                      keyboardType: TextInputType.multiline, // Enable multiline input
                      cursorColor: _editableHabit.color,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: _editableHabit.color,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: _editableHabit.color,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),
                    label: 'Save Habit',
                    onPressed: () {
                      // Update the habit with the new values
                      _editableHabit = _editableHabit.copyWith(
                        title: _titleController.text,
                        description: _descriptionController.text,
                      );

                      // Navigate back or perform save action
                      Navigator.pop(context, _editableHabit);

                      // Save the habit using the storage service
                      CreateEditHabit.habitStorageService.saveOrUpdateHabit(_editableHabit);
                    },
                    color: _editableHabit.color,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
