import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/theme_selector.dart';

import '../models/habit.dart';

class CreateEditHabit extends StatefulWidget {
  static const String routeName = '/create-edit-habit';
  final Habit habit;

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
          const SizedBox(height: 30),
          SingleChildScrollView(
            child: Column(
              children: [
                ThemeSelector(
                  selectedTheme: _editableHabit.theme,
                  onChanged: (value) {
                    setState(() {
                      _editableHabit = _editableHabit.copyWith(theme: value);
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
                        _editableHabit = _editableHabit.copyWith(title: value);
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
                    maxLines: 3,
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _editableHabit);
                    },
                    child: const Text('Save Habit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
