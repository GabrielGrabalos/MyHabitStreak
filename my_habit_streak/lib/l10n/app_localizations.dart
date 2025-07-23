import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('zh')
  ];

  /// Language name for English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// Label for language selection
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get idiom;

  /// Link text for privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Application title shown in app bar
  ///
  /// In en, this message translates to:
  /// **'My Habit Streak'**
  String get appTitle;

  /// Title for habit creation screen
  ///
  /// In en, this message translates to:
  /// **'Create Habit'**
  String get createHabit;

  /// Title for habit editing screen
  ///
  /// In en, this message translates to:
  /// **'Edit Habit'**
  String get editHabit;

  /// Label for habit title input field
  ///
  /// In en, this message translates to:
  /// **'Habit Title'**
  String get habitTitle;

  /// Label for description input field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Placeholder text when no habit description exists
  ///
  /// In en, this message translates to:
  /// **'No description provided.'**
  String get noDescription;

  /// Button text to save a habit
  ///
  /// In en, this message translates to:
  /// **'Save Habit'**
  String get saveHabit;

  /// Button text to delete a habit
  ///
  /// In en, this message translates to:
  /// **'Delete Habit'**
  String get deleteHabit;

  /// Button to mark habit as completed
  ///
  /// In en, this message translates to:
  /// **'Mark as done'**
  String get markDone;

  /// Button to mark habit as not completed
  ///
  /// In en, this message translates to:
  /// **'Mark as not done'**
  String get markNotDone;

  /// Title for calendar view showing habit history
  ///
  /// In en, this message translates to:
  /// **'Your streak history'**
  String get streakHistory;

  /// Title for invalid habit error dialog
  ///
  /// In en, this message translates to:
  /// **'Invalid Habit'**
  String get invalidHabit;

  /// Error message for invalid habit input
  ///
  /// In en, this message translates to:
  /// **'Please ensure the habit title is not empty and is unique.'**
  String get invalidHabitMessage;

  /// Title for habit deletion confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Habit?'**
  String get deleteConfirmationTitle;

  /// Message in habit deletion confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this habit? This action cannot be undone.'**
  String get deleteConfirmationMessage;

  /// Title for mark-as-done confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Mark as done?'**
  String get markDoneConfirmation;

  /// Title for mark-as-not-done confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Mark as not done?'**
  String get markNotDoneConfirmation;

  /// Message in mark-as-done confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this habit as done?\nRemember, we\'re here to help. Don\'t lie to yourself!'**
  String get markDoneMessage;

  /// Message in mark-as-not-done confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to mark this habit as not done?'**
  String get markNotDoneMessage;

  /// Button to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Title for main screen showing habit list
  ///
  /// In en, this message translates to:
  /// **'My Habits'**
  String get myHabits;

  /// Section header for uncompleted habits
  ///
  /// In en, this message translates to:
  /// **'Not Done Today'**
  String get notDoneToday;

  /// Section header for completed habits
  ///
  /// In en, this message translates to:
  /// **'Done Today'**
  String get doneToday;

  /// Prompt shown when no habits exist
  ///
  /// In en, this message translates to:
  /// **'Start by creating\na new habit!'**
  String get startCreating;

  /// Title for test notification
  ///
  /// In en, this message translates to:
  /// **'Test Notification'**
  String get testNotificationTitle;

  /// Body text for test notification
  ///
  /// In en, this message translates to:
  /// **'This is a test notification scheduled to appear 1 minute after setup'**
  String get testNotificationBody;

  /// Greeting for morning notification
  ///
  /// In en, this message translates to:
  /// **'Good Morning!'**
  String get goodMorning;

  /// Title for midday check-in notification
  ///
  /// In en, this message translates to:
  /// **'Midday Check-in'**
  String get middayCheckin;

  /// Title for evening update notification
  ///
  /// In en, this message translates to:
  /// **'Evening Update'**
  String get eveningUpdate;

  /// Title for nightly reflection notification
  ///
  /// In en, this message translates to:
  /// **'Nightly Reflection'**
  String get nightlyReflection;

  /// Title for final reminder notification
  ///
  /// In en, this message translates to:
  /// **'Final Reminder'**
  String get finalReminder;

  /// Message for morning habit check notification
  ///
  /// In en, this message translates to:
  /// **'Time to check your habits for the day'**
  String get morningHabitCheck;

  /// Message for midday progress check notification
  ///
  /// In en, this message translates to:
  /// **'How are your habits progressing?'**
  String get middayProgress;

  /// Message for evening review notification
  ///
  /// In en, this message translates to:
  /// **'Time to review your daily habits'**
  String get eveningReview;

  /// Message for daily performance notification
  ///
  /// In en, this message translates to:
  /// **'How did you do with your habits today?'**
  String get dailyPerformance;

  /// Message for last chance notification
  ///
  /// In en, this message translates to:
  /// **'Last chance to complete your habits today'**
  String get lastChance;

  /// Message showing percentage of habits completed today
  ///
  /// In en, this message translates to:
  /// **'Today\'s progress: {progress}% complete'**
  String progressComplete(Object progress);

  /// Message showing number of habits completed out of total
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} habits done'**
  String habitsDone(Object completed, Object total);

  /// Motivational message to encourage starting habits
  ///
  /// In en, this message translates to:
  /// **'You\'ve got this! Start with one small habit.'**
  String get motivationStart;

  /// Motivational message to encourage continuing habits
  ///
  /// In en, this message translates to:
  /// **'Keep going! Every habit counts.'**
  String get motivationKeepGoing;

  /// Motivational message to encourage finishing habits
  ///
  /// In en, this message translates to:
  /// **'Great progress! Finish strong!'**
  String get motivationGreatProgress;

  /// Motivational message for completing all habits
  ///
  /// In en, this message translates to:
  /// **'Amazing! You completed all your habits today!'**
  String get motivationAmazing;

  /// Title for notifications settings screen
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Message explaining the purpose of notifications
  ///
  /// In en, this message translates to:
  /// **'Allow us to send you some notifications to help you never forget about your new habits! We promise not to abuse it!'**
  String get notificationsMessage;

  /// Message shown when user permanently denies notifications
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to permanently deny notifications?'**
  String get permanentlyDeniedMessage;

  /// Button to open app settings for notifications
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// Button to skip notification permission request
  ///
  /// In en, this message translates to:
  /// **'Don\'t ask again'**
  String get dontAskAgain;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'ja', 'pt', 'ru', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt': {
  switch (locale.countryCode) {
    case 'BR': return AppLocalizationsPtBr();
   }
  break;
   }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'ja': return AppLocalizationsJa();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
