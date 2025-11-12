import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/l10n/app_localizations.dart';
import 'package:my_habit_streak/widgets/add_completion_button.dart';
import 'package:my_habit_streak/widgets/completion_list.dart';

import '../models/habit.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class VisualizeSpecificHabitDay extends StatefulWidget {
  final Habit habit;
  final String dateKey;

  const VisualizeSpecificHabitDay({
    super.key,
    required this.habit,
    required this.dateKey,
  });

  @override
  State<VisualizeSpecificHabitDay> createState() =>
      _VisualizeSpecificHabitDayState();
}

class _VisualizeSpecificHabitDayState extends State<VisualizeSpecificHabitDay> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.35,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.5, 0.75, 0.95],
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: darkBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          Utils.formatDate(widget.dateKey),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                        ),
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          'assets/${widget.habit.theme.name}'
                          '${widget.habit.streakHistory[widget.dateKey] == null || widget.habit.streakHistory[widget.dateKey]!.isEmpty ? '_gray' : ''}.svg',
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        AddCompletionButton(
                          habit: widget.habit,
                          dateKey: widget.dateKey,
                          noteController: _noteController,
                          onCompletionAdded: () => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        if (widget.habit.streakHistory[widget.dateKey] !=
                            null) ...[
                          Center(
                            child: Text(
                              "${AppLocalizations.of(context)!.completions} ${widget.habit.streakHistory[widget.dateKey] != null ? widget.habit.streakHistory[widget.dateKey]!.length : 0}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                        CompletionList(
                          habit: widget.habit,
                          completions:
                              widget.habit.streakHistory[widget.dateKey] ?? [],
                          noteController: _noteController,
                          onCompletionsChanged: () => setState(() {}),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
