// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get idiom => 'Language';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get appTitle => 'My Habit Streak';

  @override
  String get createHabit => 'Create Habit';

  @override
  String get editHabit => 'Edit Habit';

  @override
  String get habitTitle => 'Habit Title';

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description provided.';

  @override
  String get saveHabit => 'Save Habit';

  @override
  String get deleteHabit => 'Delete Habit';

  @override
  String get markDone => 'Mark as done';

  @override
  String get markNotDone => 'Mark as not done';

  @override
  String get streakHistory => 'Your streak history';

  @override
  String get invalidHabit => 'Invalid Habit';

  @override
  String get invalidHabitMessage => 'Please ensure the habit title is not empty and is unique.';

  @override
  String get deleteConfirmationTitle => 'Delete Habit?';

  @override
  String get deleteConfirmationMessage => 'Are you sure you want to delete this habit? This action cannot be undone.';

  @override
  String get markDoneConfirmation => 'Mark as done?';

  @override
  String get markNotDoneConfirmation => 'Mark as not done?';

  @override
  String get markDoneMessage => 'Are you sure you want to mark this habit as done?\nRemember, we\'re here to help. Don\'t lie to yourself!';

  @override
  String get markNotDoneMessage => 'Are you sure you want to mark this habit as not done?';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get myHabits => 'My Habits';

  @override
  String get notDoneToday => 'Not Done Today';

  @override
  String get doneToday => 'Done Today';

  @override
  String get startCreating => 'Start by creating\na new habit!';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsMessage => 'Allow us to send you some notifications to help you never forget about your new habits! We promise not to abuse it!';

  @override
  String get permanentlyDeniedMessage => 'Are you sure you want to permanently deny notifications?';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get dontAskAgain => 'Don\'t ask again';

  @override
  String notificationTitle(Object count) {
    return 'You have $count habits to complete';
  }

  @override
  String singleHabitNotificationBody(Object habitName) {
    return '\"$habitName\" is waiting for you!';
  }

  @override
  String twoHabitNotificationBody(Object firstHabitName, Object secondHabitName) {
    return '\"$firstHabitName\" and \"$secondHabitName\" are waiting for you!';
  }

  @override
  String multipleHabitNotificationBody(Object firstTwoNames, Object remainingCount) {
    return '$firstTwoNames, and $remainingCount more are waiting for you!';
  }

  @override
  String get countDownNotificationTitle => 'Your time is running out!';

  @override
  String get deleteHabitGroupTitle => 'Delete Group?';

  @override
  String deleteHabitGroupMessage(Object groupName) {
    return 'Are you sure you want to delete the group \"$groupName\"? Don\'t worry, this action will NOT delete the habits inside it.';
  }

  @override
  String get all => 'All';

  @override
  String get notDone => 'Not Done';

  @override
  String get done => 'Done';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';
}
