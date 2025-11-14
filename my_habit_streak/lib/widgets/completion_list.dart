import 'package:flutter/material.dart';
import 'package:my_habit_streak/models/habit_completion.dart';
import 'package:my_habit_streak/widgets/time_selector.dart';
import '../l10n/app_localizations.dart';
import '../models/habit.dart';
import '../services/habit_storage_service.dart';
import '../utils/utils.dart';
import '../widgets/add_edit_completion_popup.dart';
import '../widgets/dialog_popup.dart';
import '../widgets/habit_completion_card.dart';

class CompletionList extends StatelessWidget {
  final Habit habit;
  final List<HabitCompletion> completions;
  final TextEditingController noteController;
  final TimeSelectorController timeSelectorController;
  final VoidCallback onCompletionsChanged;
  final String? dateKey;

  const CompletionList({
    super.key,
    required this.habit,
    required this.completions,
    required this.noteController,
    required this.timeSelectorController,
    required this.onCompletionsChanged,
    this.dateKey,
  });

  @override
  Widget build(BuildContext context) {
    if (completions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          AppLocalizations.of(context)!.noCompletionsYet,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      children: completions.map((completion) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: HabitCompletionCard(
            habitCompletion: completion,
            onCompletionEdit: () async {
              noteController.text = completion.text;
              final confirmChange = await showDialog<bool>(
                context: context,
                builder: (context) {
                  timeSelectorController.setTimeOfDay(completion.date);
                  return AddEditCompletionPopup(
                    noteController: noteController,
                    timeSelectorController: timeSelectorController,
                    isEditMode: true,
                    color: habit.color,
                  );
                },
              );

              if (confirmChange != true) return;
              print("\n\n\nEditing completion...\n\n\n");

              completion.text = noteController.text.trim();
              completion.date = DateTime(
                completion.date.year,
                completion.date.month,
                completion.date.day,
                timeSelectorController.time.hour,
                timeSelectorController.time.minute,
              );
              print("Hour: ${timeSelectorController.time.hour}");
              await HabitStorageService.saveOrUpdateHabit(habit.title, habit);
              onCompletionsChanged();
            },
            onCompletionDelete: () async {
              final confirmDelete = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return DialogPopup(
                    title: AppLocalizations.of(context)!.deleteCompletionTitle,
                    isWarning: true,
                    message:
                        AppLocalizations.of(context)!.deleteCompletionMessage(
                      Utils.formatTime(context, completion.date),
                      Utils.formatDate("", dateTime: completion.date),
                    ),
                  );
                },
              );

              if (confirmDelete != true) return;

              habit.removeCompletion(completion);
              await HabitStorageService.saveOrUpdateHabit(habit.title, habit);
              onCompletionsChanged();
            },
            color: habit.color,
          ),
        );
      }).toList(),
    );
  }
}
