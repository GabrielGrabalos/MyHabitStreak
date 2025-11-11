import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../models/habit_completion.dart';
import '../services/habit_storage_service.dart';
import '../widgets/add_edit_completion_popup.dart';
import '../widgets/button.dart';

class AddCompletionButton extends StatelessWidget {
  final Habit habit;
  final TextEditingController noteController;
  final VoidCallback onCompletionAdded;

  const AddCompletionButton({
    super.key,
    required this.habit,
    required this.noteController,
    required this.onCompletionAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      color: habit.color,
      label: "Add completion",
      onPressed: () async {
        noteController.clear();
        final confirmChange = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AddEditCompletionPopup(
              noteController: noteController,
              isEditMode: false,
              color: habit.color,
            );
          },
        );

        if (confirmChange != true) return;

        HabitCompletion newCompletion = HabitCompletion(
          date: DateTime.now(),
          text: noteController.text.trim(),
        );
        habit.addCompletion(newCompletion);
        await HabitStorageService.saveOrUpdateHabit(habit.title, habit);
        onCompletionAdded();
      },
    );
  }
}
