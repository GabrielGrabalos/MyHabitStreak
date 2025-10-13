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
  String get markDoneMessage => 'Sind Sie sicher, dass Sie diese Gewohnheit als erledigt markieren möchten?\nDenken Sie daran, wir sind hier, um zu helfen. Seien Sie ehrlich zu sich selbst!';

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
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get notificationsMessage => 'Erlaube uns, dir Benachrichtigungen zu senden, damit du deine neuen Gewohnheiten nie vergisst! Wir versprechen, es nicht zu missbrauchen!';

  @override
  String get permanentlyDeniedMessage => 'Möchten Sie Benachrichtigungen dauerhaft ablehnen?';

  @override
  String get openSettings => 'Einstellungen öffnen';

  @override
  String get dontAskAgain => 'Nicht mehr fragen';

  @override
  String notificationTitle(Object count) {
    return 'Sie haben $count Gewohnheiten zu erledigen';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '\"$habitName\" wartet auf Sie!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '\"$firstHabitName\" und \"$secondHabitName\" warten auf Sie!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, und $remainingCount weitere warten auf Sie!';
  }

  @override
  String get countDownNotificationTitle => 'Ihre Zeit läuft ab!';

  @override
  String get deleteHabitGroupTitle => 'Gruppe löschen?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Sind Sie sicher, dass Sie die Gruppe \"$groupName\" löschen möchten? Keine Sorge, diese Aktion löscht NICHT die darin enthaltenen Gewohnheiten.';
  }

  @override
  String get all => 'Alle';

  @override
  String get notDone => 'Ausstehend';

  @override
  String get done => 'Erledigt';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get delete => 'Löschen';

  @override
  String get invalidGroupTitle => 'Ungültige Gruppe';

  @override
  String get invalidGroupMessage => 'Bitte geben Sie einen eindeutigen und gültigen Namen für die Gewohnheitsgruppe an.';

  @override
  String get groupTitle => 'Gruppentitel';

  @override
  String get editHabitGroup => 'Gruppe bearbeiten';

  @override
  String get createHabitGroup => 'Gruppe erstellen';

  @override
  String get selectHabits => 'Gewohnheiten auswählen:';

  @override
  String get create => 'Erstellen';

  @override
  String get update => 'Aktualisieren';

  @override
  String get habitSelected => 'ausgewählt';

  @override
  String get habitsSelected => 'ausgewählt';

  @override
  String get nothingMuchHere => 'Nicht viel hier...';

  @override
  String get goToGroupAll => 'Zu \"Alle\" gehen';
}
