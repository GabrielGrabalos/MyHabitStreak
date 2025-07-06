import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../main.dart';

class L10n {
  static final all = const [
    Locale('en', ''), // English
    Locale('pt', 'BR'), // Portuguese (Brazil)
    Locale('es', ''), // Spanish
    Locale('fr', ''), // French
    Locale('de', ''), // German
    Locale('zh', ''), // Chinese
    Locale('ja', ''), // Japanese
    Locale('ru', ''), // Russian
  ];

  static void load(BuildContext context, Locale locale) {
    MyApp.of(context).setLocale(locale);
  }
}
