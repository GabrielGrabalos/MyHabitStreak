import 'package:flutter/material.dart';
import 'package:my_habit_streak/models/habit_completion.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';

import '../l10n/app_localizations.dart';
import '../utils/utils.dart';

class HabitCompletionCard extends StatelessWidget {
  final HabitCompletion habitCompletion;
  final VoidCallback onCompletionEdit;
  final VoidCallback onCompletionDelete;
  final Color color;

  const HabitCompletionCard({
    super.key,
    required this.habitCompletion,
    required this.onCompletionEdit,
    required this.onCompletionDelete,
    this.color = blueTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: color,
          width: 2.5,
        ),
      ),
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return DialogPopup(
                title: Utils.formatTime(context, habitCompletion.date),
                color: color,
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 100,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Text(
                      habitCompletion.text.isNotEmpty
                          ? habitCompletion.text
                          : AppLocalizations.of(context)!.noNoteProvided,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            color: habitCompletion.text.isNotEmpty
                                ? Colors.white
                                : Colors.white54,
                          ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        onLongPress: () async {
          final renderBox = context.findRenderObject() as RenderBox;
          final offset = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;

          // Approximated of popup because
          // I don't want to deal with dynamic
          // sizing and rendering, and this will
          // never change (always same items),
          // so I don't care enough:
          final menuWidth = 108.0;

          final selected = await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              offset.dx - (menuWidth / 2) + (size.width / 2),
              // shift for horizontal centering
              offset.dy + size.height + 5,
              offset.dx + size.width,
              0,
            ),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
            items: [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 20,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.delete),
                  ],
                ),
              ),
            ],
          );

          if (selected == 'edit') {
            onCompletionEdit();
          } else if (selected == 'delete') {
            onCompletionDelete();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                Utils.formatTime(context, habitCompletion.date),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: doneColor,
                    ),
              ),
              const SizedBox(width: 7),
              Text(
                "|",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 22,
                      color: Colors.white54,
                    ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  habitCompletion.text.isNotEmpty
                      ? habitCompletion.text
                      : AppLocalizations.of(context)!.noNoteProvided,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16,
                        color: habitCompletion.text.isNotEmpty
                            ? Colors.white
                            : Colors.white54,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
