// lib/services/notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';
import '../l10n/app_localizations.dart'; // Import your AppLocalizations

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AppLocalizations? _appLocalizations;

  NotificationService() {
    init();
  }

  Future<void> init() async {
    initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    setLocalLocation(getLocation(timeZoneName));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_bee');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Add a method to set the AppLocalizations instance
  void setAppLocalizations(AppLocalizations appLocalizations) {
    _appLocalizations = appLocalizations;
  }

  // Main functions to show and schedule notifications:

  Future<void> showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_notification_channel_id',
          'Instant Notifications',
          channelDescription: 'Instant notification channel',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: DrawableResourceAndroidBitmap('bee'),
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleReminder({
    required int id,
    required String title,
    required int hour,
    required int minute,
    String? body,
    String? image,
  }) async {
    final TZDateTime now = TZDateTime.now(local);
    TZDateTime scheduledDate =
        TZDateTime(local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel_id',
          'Daily Reminders',
          // Use a localized string here
          channelDescription: 'Reminder to complete daily habits',
          // Use a localized string here
          importance: Importance.max,
          priority: Priority.high,
          largeIcon:
              image != null ? DrawableResourceAndroidBitmap(image) : null,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // Schedule notifications:
  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    final habits = await HabitStorageService.getHabits();
    final undoneHabits = habits.where((habit) => !habit.isTodayDone).toList();

    if (undoneHabits.isEmpty) {
      await flutterLocalNotificationsPlugin.cancelAll();
      return;
    }

    final sortedHabitsByStreakCount = List.of(undoneHabits)
      ..sort((a, b) => b.streak.compareTo(a.streak));

    const notificationTimes = [
      (8, 0),
      (10, 0),
      (12, 0),
      (15, 0),
      (18, 0),
      (20, 0),
    ];

    // Check if _appLocalizations is available before using it
    if (_appLocalizations == null) {
      // Handle the case where localizations are not set yet, perhaps log a warning
      return;
    }

    String bodyText;
    if (undoneHabits.length == 1) {
      bodyText = _appLocalizations!
          .singleHabitNotificationBody(undoneHabits.first.title);
    } else if (undoneHabits.length == 2) {
      final firstHabitName = undoneHabits.first.title;
      final secondHabitName = undoneHabits.last.title;
      bodyText = _appLocalizations!
          .twoHabitNotificationBody(firstHabitName, secondHabitName);
    } else {
      final firstTwoNames = sortedHabitsByStreakCount
          .take(2)
          .map((h) => '"${h.title}"')
          .toList()
          .join(', ');
      final remainingCount = undoneHabits.length - 2;
      bodyText = _appLocalizations!
          .multipleHabitNotificationBody(firstTwoNames, remainingCount);
    }

    for (int i = 0; i < notificationTimes.length; i++) {
      final (hour, minute) = notificationTimes[i];
      await scheduleReminder(
        id: i,
        title: _appLocalizations!.notificationTitle(undoneHabits.length),
        body: bodyText,
        hour: hour,
        minute: minute,
        image: 'bee',
      );
    }

    await scheduleCountDownNotification(
      id: 9999,
      title: _appLocalizations!.countDownNotificationTitle,
      hour: 22,
      minute: 00,
      image: 'bee_sad',
    );
  }

  Future<void> scheduleCountDownNotification({
    required int id,
    required String title,
    required int hour,
    required int minute,
    String? image,
  }) async {
    final TZDateTime now = TZDateTime.now(local);
    TZDateTime scheduledDateTime =
        TZDateTime(local, now.year, now.month, now.day, hour, minute);

    if (scheduledDateTime.isBefore(now)) {
      scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
    }

    final int secondsUntilMidnight =
        86400 - (now.hour * 3600 + now.minute * 60 + now.second);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      null,
      scheduledDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'countdown_notification_channel_id',
          'Countdown Notifications',
          channelDescription: 'Notifications for countdown completion',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon:
              image != null ? DrawableResourceAndroidBitmap(image) : null,
          usesChronometer: true,
          chronometerCountDown: true,
          // Countdown to midnight (00:00)
          when: DateTime.now().millisecondsSinceEpoch +
              secondsUntilMidnight * 1000,
          ongoing: false,
          autoCancel: true,
          timeoutAfter: secondsUntilMidnight * 1000,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}
