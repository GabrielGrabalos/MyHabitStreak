// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Deutsch';

  @override
  String get idiom => 'Sprache';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get appTitle => 'Meine Gewohnheits-Serie';

  @override
  String get createHabit => 'Gewohnheit erstellen';

  @override
  String get editHabit => 'Gewohnheit bearbeiten';

  @override
  String get habitTitle => 'Gewohnheitstitel';

  @override
  String get description => 'Beschreibung';

  @override
  String get noDescription => 'Keine Beschreibung vorhanden.';

  @override
  String get saveHabit => 'Gewohnheit speichern';

  @override
  String get deleteHabit => 'Gewohnheit löschen';

  @override
  String get markDone => 'Als erledigt markieren';

  @override
  String get markNotDone => 'Als nicht erledigt markieren';

  @override
  String get streakHistory => 'Ihre Serienhistorie';

  @override
  String get invalidHabit => 'Ungültige Gewohnheit';

  @override
  String get invalidHabitMessage => 'Bitte stellen Sie sicher, dass der Gewohnheitstitel nicht leer und eindeutig ist.';

  @override
  String get deleteConfirmationTitle => 'Gewohnheit löschen?';

  @override
  String get deleteConfirmationMessage => 'Sind Sie sicher, dass Sie diese Gewohnheit löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get markDoneConfirmation => 'Als erledigt markieren?';

  @override
  String get markNotDoneConfirmation => 'Als nicht erledigt markieren?';

  @override
  String get markDoneMessage => 'Sind Sie sicher, dass Sie diese Gewohnheit als erledigt markieren möchten?\nDenken Sie daran, wir sind hier, um zu helfen. Lügen Sie sich nicht selbst an!';

  @override
  String get markNotDoneMessage => 'Sind Sie sicher, dass Sie diese Gewohnheit als nicht erledigt markieren möchten?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get myHabits => 'Meine Gewohnheiten';

  @override
  String get notDoneToday => 'Heute nicht erledigt';

  @override
  String get doneToday => 'Heute erledigt';

  @override
  String get startCreating => 'Beginnen Sie mit dem Erstellen\neiner neuen Gewohnheit!';

  @override
  String get testNotificationTitle => 'Testbenachrichtigung';

  @override
  String get testNotificationBody => 'Dies ist eine Testbenachrichtigung, die 1 Minute nach dem Setup erscheint';

  @override
  String get goodMorning => 'Guten Morgen!';

  @override
  String get middayCheckin => 'Mittags-Check-in';

  @override
  String get eveningUpdate => 'Abendupdate';

  @override
  String get nightlyReflection => 'Nächtliche Reflexion';

  @override
  String get finalReminder => 'Letzte Erinnerung';

  @override
  String get morningHabitCheck => 'Zeit, deine Gewohnheiten für den Tag zu überprüfen';

  @override
  String get middayProgress => 'Wie laufen deine Gewohnheiten?';

  @override
  String get eveningReview => 'Zeit, deine täglichen Gewohnheiten zu überprüfen';

  @override
  String get dailyPerformance => 'Wie bist du heute mit deinen Gewohnheiten zurechtgekommen?';

  @override
  String get lastChance => 'Letzte Chance, deine Gewohnheiten heute abzuschließen';

  @override
  String progressComplete(Object progress) {
    return 'Heutiger Fortschritt: $progress% abgeschlossen';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed von $total Gewohnheiten erledigt';
  }

  @override
  String get motivationStart => 'Du schaffst das! Beginne mit einer kleinen Gewohnheit.';

  @override
  String get motivationKeepGoing => 'Weiter so! Jede Gewohnheit zählt.';

  @override
  String get motivationGreatProgress => 'Toller Fortschritt! Beende es stark!';

  @override
  String get motivationAmazing => 'Erstaunlich! Du hast heute alle deine Gewohnheiten erledigt!';

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notificationsMessage => 'Erlaube uns, dir Benachrichtigungen zu senden, damit du deine neuen Gewohnheiten nie vergisst! Wir versprechen, es nicht zu missbrauchen!';

  @override
  String get permanentlyDeniedMessage => 'Möchten Sie Benachrichtigungen dauerhaft ablehnen?';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get dontAskAgain => 'Nicht mehr fragen';
}
