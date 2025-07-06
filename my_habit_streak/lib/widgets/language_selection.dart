import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';

import '../l10n/l10n.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogPopup(child: Column(children: L10n.all
        .map(
          (locale) => CupertinoButton(
            onPressed: () {
              L10n.load(context, locale);
              Navigator.of(context).pop();
            },
            child: Text(
              locale.languageCode.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        )
        .toList(),
      ),
    );
  }
}
