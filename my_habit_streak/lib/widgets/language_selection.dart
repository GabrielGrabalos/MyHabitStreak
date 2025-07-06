import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';

import '../l10n/l10n.dart';

class LanguageSelection extends StatelessWidget {
  LanguageSelection({super.key});

  final Random random = Random(14);

  @override
  Widget build(BuildContext context) {
    return DialogPopup(
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth - 10,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: L10n.all.length,
            itemBuilder: (context, index) {
              final locale = L10n.all[index];
              final languageName = _getLanguageName(locale);

              return Button(
                label: languageName,
                color: cardColors[random.nextInt(cardColors.length)],
                onPressed: () {
                  L10n.load(context, locale);
                  Navigator.of(context).pop();
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        );
      }),
    );
  }

  String _getLanguageName(Locale locale) {
    // Look up localization for the target locale
    final localizations = lookupAppLocalizations(locale);

    // Return the language name if available, otherwise fallback
    return localizations?.language ?? locale.languageCode.toUpperCase();
  }
}
