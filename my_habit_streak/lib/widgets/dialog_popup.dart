// This stateless widget represents a dialog popup that can be used to display messages or options to the user.
// The user can respond with a confirmation or cancellation action.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/utils/habit_theme.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogPopup extends StatelessWidget {
  final String title;
  final String message;
  final bool isWarning;
  final HabitTheme theme;
  final Color color;
  final bool hasCancelButton;
  final Widget? child;

  const DialogPopup({
    super.key,
    this.title = '',
    this.message = '',
    this.isWarning = false,
    this.theme = HabitTheme.bee,
    this.color = blueTheme,
    this.hasCancelButton = true,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20.0),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: darkBackground,
                borderRadius: BorderRadius.circular(35.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: SingleChildScrollView(
                child: child ??
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: isWarning ? Colors.red : Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          !isWarning
                              ? 'assets/happy_emote.svg'
                              : 'assets/warning_${theme.name}_emote.svg',
                          height: 150,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          message,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        // Cancel button if hasCancelButton is true
                        if (hasCancelButton) ...[
                          Button(
                            label: AppLocalizations.of(context)!.cancel,
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Close the dialog and return false
                            },
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                        ],
                        Button(
                          label: AppLocalizations.of(context)!.confirm,
                          onPressed: () {
                            Navigator.of(context)
                                .pop(true); // Close the dialog and return true
                          },
                          color: isWarning ? Colors.red : color,
                        ),
                      ],
                    ),
              ),
            ),
            // X mark button to close the dialog
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
