import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_habit_streak/models/habit_completion.dart';
import 'package:my_habit_streak/utils/colors.dart';

class HabitCompletionCard extends StatelessWidget {
  final HabitCompletion habitCompletion;
  final Color color;

  const HabitCompletionCard({
    super.key,
    required this.habitCompletion,
    this.color = blueTheme,
  });

  String _formatTime(BuildContext context, DateTime time) {
    // Ensure the DateTime is in the device local timezone
    final localTime = time.toLocal();

    // Get locale and 24h preference from the device
    final locale = Localizations.localeOf(context).toString();
    final use24Hour = MediaQuery.of(context).alwaysUse24HourFormat;

    // Use intl for reliable locale-aware formatting.
    // DateFormat.Hm -> 24-hour like "18:30"
    // DateFormat.jm -> 12-hour like "6:30 PM"
    final formatter = use24Hour ? DateFormat.Hm(locale) : DateFormat.jm(locale);
    return formatter.format(localTime);
  }

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
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Text(
                _formatTime(context, habitCompletion.date),
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
                      : "No note provided.",
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
