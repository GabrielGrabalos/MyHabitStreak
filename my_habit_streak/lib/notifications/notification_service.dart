import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/habit.dart';
import '../utils/general_storage_service.dart';
import '../utils/habit_storage_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat_bee');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap if needed
      },
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleTestNotification() async {
    final locale = await GeneralStorageService().getData('language') ?? 'en';
    final l10n = await AppLocalizations.delegate.load(Locale(locale));
    await flutterLocalNotificationsPlugin.show(
      999, // Unique ID for test notification
      l10n.testNotificationTitle,
      l10n.testNotificationBody,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel_id',
          'Test Notifications',
          channelDescription: 'Channel for testing notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.blue,
          enableVibration: true,
          largeIcon: const DrawableResourceAndroidBitmap('bee_sad'),
          styleInformation: BigTextStyleInformation(l10n.testNotificationBody),
        ),
      ),
    );
  }

  // Add to NotificationService class
  Future<String> _getCurrentLocale() async {
    return await GeneralStorageService().getData('language') ?? 'en';
  }

  Future<void> scheduleDailyNotifications(
      HabitStorageService habitStorage) async {
    final locale = await _getCurrentLocale();
    final l10n = await AppLocalizations.delegate.load(Locale(locale));

    // Cancel any existing notifications
    await flutterLocalNotificationsPlugin.cancelAll();

    // Get habits data
    final habits = await habitStorage.getHabits();

    // Schedule notifications for each time
    await _scheduleNotification(
      id: 1,
      hour: 8,
      minute: 0,
      habits: habits,
      title: l10n.goodMorning,
      body: l10n.morningHabitCheck,
      l10n: l10n,
    );

    await _scheduleNotification(
      id: 2,
      hour: 12,
      minute: 0,
      habits: habits,
      title: l10n.middayCheckin,
      body: l10n.middayProgress,
      l10n: l10n,
    );

    await _scheduleNotification(
      id: 3,
      hour: 17,
      minute: 0,
      habits: habits,
      title: l10n.eveningUpdate,
      body: l10n.eveningReview,
      l10n: l10n,
    );

    await _scheduleNotification(
      id: 4,
      hour: 21,
      minute: 0,
      habits: habits,
      title: l10n.nightlyReflection,
      body: l10n.dailyPerformance,
      l10n: l10n,
    );

    await _scheduleNotification(
      id: 5,
      hour: 23,
      minute: 0,
      habits: habits,
      title: l10n.finalReminder,
      body: l10n.lastChance,
      l10n: l10n,
    );
  }

  Future<void> _scheduleNotification({
    required int id,
    required int hour,
    required int minute,
    required List<Habit> habits,
    required String title,
    required String body,
    required AppLocalizations l10n,
  }) async {
    // Customize the notification based on habits
    final completedHabits = habits.where((h) => h.isTodayDone).length;
    final totalHabits = habits.length;
    final progress =
        totalHabits > 0 ? (completedHabits / totalHabits * 100).toInt() : 0;

    // Create a more detailed body based on habits
    final detailedBody = '''
$body

${l10n.progressComplete(progress)}
${l10n.habitsDone(completedHabits, totalHabits)}
${_getMotivationalMessage(progress, l10n)}
''';

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      detailedBody,
      _nextInstanceOfTime(hour, minute),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'habit_channel_id',
          'Habit Reminders',
          channelDescription: 'Notifications for your daily habits',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.blue,
          enableVibration: true,
          largeIcon: DrawableResourceAndroidBitmap(
              'bee${progress == 0 ? '_sad' : ''}'),
          styleInformation: BigTextStyleInformation(detailedBody),
        ),
        iOS: const DarwinNotificationDetails(
          sound: 'default',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  String _getMotivationalMessage(int progress, AppLocalizations l10n) {
    if (progress == 0) return l10n.motivationStart;
    if (progress < 50) return "${l10n.motivationKeepGoing}🔥";
    if (progress < 100) return "${l10n.motivationGreatProgress}🚀";
    return "${l10n.motivationAmazing}😁";
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
      print(
          'Scheduled date was in the past, moving to next day: $scheduledDate');
    }

    return scheduledDate;
  }
}
