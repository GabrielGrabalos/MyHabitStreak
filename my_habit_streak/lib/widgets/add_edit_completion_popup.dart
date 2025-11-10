import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
import 'package:my_habit_streak/widgets/text_input.dart';

class AddEditCompletionPopup extends StatelessWidget {
  final TextEditingController noteController;
  final bool isEditMode;
  final Color color;

  const AddEditCompletionPopup({
    super.key,
    required this.noteController,
    required this.isEditMode,
    this.color = blueTheme,
  });

  @override
  Widget build(BuildContext context) {
    return DialogPopup(
        title: isEditMode ? 'Edit Completion' : 'Add Completion',
        color: color,
        child: Column(
          children: [
            ThemedTextInput(
              controller: noteController,
              labelText: 'Add a note... (optional)',
              minLines: 3,
              maxLines: 5,
            )
          ],
        ));
  }
}
