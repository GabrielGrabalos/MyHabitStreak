import 'package:flutter/cupertino.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
import 'package:my_habit_streak/widgets/text_input.dart';

import '../l10n/app_localizations.dart';
import 'button.dart';

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
      title: isEditMode
          ? AppLocalizations.of(context)!.editCompletion
          : AppLocalizations.of(context)!.addCompletion,
      color: color,
      child: Column(
        children: [
          ThemedTextInput(
            controller: noteController,
            cursorColor: color,
            labelText: AppLocalizations.of(context)!.addANote,
            // 'Add a note... (optional)',
            minLines: 3,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
          ),
          const SizedBox(height: 20),
          Button(
            label: isEditMode
                ? AppLocalizations.of(context)!.update
                : AppLocalizations.of(context)!.addCompletion,
            color: color,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    );
  }
}
