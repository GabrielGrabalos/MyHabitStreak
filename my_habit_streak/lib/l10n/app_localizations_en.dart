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
  String get testNotificationTitle => 'Test Notification';

  @override
  String get testNotificationBody => 'This is a test notification scheduled to appear 1 minute after setup';

  @override
  String get goodMorning => 'Good Morning!';

  @override
  String get middayCheckin => 'Midday Check-in';

  @override
  String get eveningUpdate => 'Evening Update';

  @override
  String get nightlyReflection => 'Nightly Reflection';

  @override
  String get finalReminder => 'Final Reminder';

  @override
  String get morningHabitCheck => 'Time to check your habits for the day';

  @override
  String get middayProgress => 'How are your habits progressing?';

  @override
  String get eveningReview => 'Time to review your daily habits';

  @override
  String get dailyPerformance => 'How did you do with your habits today?';

  @override
  String get lastChance => 'Last chance to complete your habits today';

  @override
  String progressComplete(Object progress) {
    return 'Today\'s progress: $progress% complete';
  }

  @override
  String habitsDone(Object completed, Object total) {
    return '$completed of $total habits done';
  }

  @override
  String get motivationStart => 'You\'ve got this! Start with one small habit.';

  @override
  String get motivationKeepGoing => 'Keep going! Every habit counts.';

  @override
  String get motivationGreatProgress => 'Great progress! Finish strong!';

  @override
  String get motivationAmazing => 'Amazing! You completed all your habits today!';

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
}
