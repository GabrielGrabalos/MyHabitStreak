import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/color_selector.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
import 'package:my_habit_streak/widgets/header.dart';
import 'package:my_habit_streak/widgets/theme_selector.dart';
import 'package:vibration/vibration.dart';
import '../l10n/app_localizations.dart';

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
  late Habit _editableHabit = Habit(); // Mutable habit state
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String originalTitle = '';
  bool isCreatingNewHabit = true;
  bool isLoading = false; // Loading state for delete button

  void _initializeHabit() {
    setState(() {
      // Get the habit from Navigator arguments or use a default new habit
      final Object? habitFromArgs = ModalRoute.of(context)?.settings.arguments;

      if (habitFromArgs is Habit) {
        // If the argument is a Habit, use it
        _editableHabit = habitFromArgs;
      } else {
        // Otherwise, create a new Habit
        _editableHabit = Habit();
      }

      isCreatingNewHabit = habitFromArgs == null;

      originalTitle = _editableHabit.title;

      _titleController.text = _editableHabit.title;
      _descriptionController.text =
          _editableHabit.description ?? ''; // Initialize description controller
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This ensures that the widget is fully built before we access the context
      _initializeHabit();
    });
  }

  @override
  void dispose() {
    // Clean up controllers
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<bool> _titleAlreadyExists() async {
    return HabitStorageService.getHabits().then((habits) => habits.any(
        (h) => h.title.toLowerCase() == _editableHabit.title.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: AppLocalizations.of(context)!.createHabit,
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
                        labelText: AppLocalizations.of(context)!.habitTitle,
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
                      textCapitalization: TextCapitalization.words,
                      autocorrect: true,
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
                      keyboardType: TextInputType.multiline,
                      // Enable multiline input
                      cursorColor: _editableHabit.color,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.description,
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
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                    ),
                  ),
                  Button(
                    isLoading: isLoading,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16.0),
                    label: AppLocalizations.of(context)!.saveHabit,
                    onPressed: () async {
                      // Update the habit with the new values
                      setState(() {
                        _editableHabit = _editableHabit.copyWith(
                          title: _titleController.text,
                          description: _descriptionController.text,
                        );
                        isLoading = true; // Set loading state to true
                      });

                      if (!_editableHabit.isHabitValid() ||
                          (isCreatingNewHabit && await _titleAlreadyExists())) {
                        // Vibrate  quickly twice to indicate an error
                        if (await Vibration.hasVibrator()) {
                          Vibration.vibrate(duration: 50, amplitude: 128);
                          await Future.delayed(
                              const Duration(milliseconds: 10));
                          Vibration.vibrate(duration: 30, amplitude: 128);
                        }

                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogPopup(
                              title: AppLocalizations.of(context)!.invalidHabit,
                              message: AppLocalizations.of(context)!
                                  .invalidHabitMessage,
                              theme: _editableHabit.theme,
                              color: _editableHabit.color,
                              hasCancelButton: false,
                            );
                          },
                        );

                        setState(() {
                          isLoading = false; // Reset loading state
                        });

                        return;
                      }

                      // Save the habit using the storage service
                      await HabitStorageService.saveOrUpdateHabit(
                          originalTitle, _editableHabit);

                      setState(() {
                        isLoading = false; // Reset loading state
                      });

                      // Navigate back or perform save action
                      Navigator.pop(context, _editableHabit);
                    },
                    color: _editableHabit.color,
                  ),

                  // Delete button, only shown when editing an existing habit
                  if (!isCreatingNewHabit)
                    Button(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 16.0),
                      label: AppLocalizations.of(context)!.deleteHabit,
                      onPressed: () async {
                        final bool confirmDelete = await showDialog(
                          context: context,
                          builder: (context) {
                            return DialogPopup(
                              title: AppLocalizations.of(context)!
                                  .deleteConfirmationTitle,
                              message: AppLocalizations.of(context)!
                                  .deleteConfirmationMessage,
                              isWarning: true,
                              theme: _editableHabit.theme,
                              color: _editableHabit.color,
                            );
                          },
                        );
                        if (!confirmDelete) return;

                        setState(() {
                          isLoading = true; // Set loading state to true
                        });

                        // Delete the habit using the storage service
                        await HabitStorageService.deleteHabit(
                            _editableHabit.id);

                        setState(() {
                          isLoading = false; // Reset loading state
                        });

                        // Navigate back after deletion
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      color: Colors.red,
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
