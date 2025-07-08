import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../models/habit.dart';
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
    final scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      999, // Unique ID for test notification
      'Test Notification',
      'This is a test notification scheduled to appear 1 minute after setup',
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel_id',
          'Test Notifications',
          channelDescription: 'Channel for testing notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Colors.blue,
          enableVibration: true,
          largeIcon: const DrawableResourceAndroidBitmap('ic_stat_bee'),
          styleInformation: BigTextStyleInformation(
              'This test notification confirms your notification system is working correctly'),
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleDailyNotifications(
      HabitStorageService habitStorage) async {
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
      title: 'Good Morning!',
      body: 'Time to check your habits for the day',
    );

    await _scheduleNotification(
      id: 2,
      hour: 12,
      minute: 0,
      habits: habits,
      title: 'Midday Check-in',
      body: 'How are your habits progressing?',
    );

    await _scheduleNotification(
      id: 3,
      hour: 17,
      minute: 0,
      habits: habits,
      title: 'Evening Update',
      body: 'Time to review your daily habits',
    );

    await _scheduleNotification(
      id: 4,
      hour: 21,
      minute: 0,
      habits: habits,
      title: 'Nightly Reflection',
      body: 'How did you do with your habits today?',
    );

    await _scheduleNotification(
      id: 5,
      hour: 23,
      minute: 0,
      habits: habits,
      title: 'Final Reminder',
      body: 'Last chance to complete your habits today',
    );
  }

  Future<void> _scheduleNotification({
    required int id,
    required int hour,
    required int minute,
    required List<Habit> habits,
    required String title,
    required String body,
  }) async {
    // Customize the notification based on habits
    final completedHabits = habits.where((h) => h.isTodayDone).length;
    final totalHabits = habits.length;
    final progress =
        totalHabits > 0 ? (completedHabits / totalHabits * 100).toInt() : 0;

    // Create a more detailed body based on habits
    final detailedBody = '''
$body

Today's progress: $progress% complete
${completedHabits} of ${totalHabits} habits done
${_getMotivationalMessage(progress)}
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
          largeIcon: const DrawableResourceAndroidBitmap('ic_stat_bee'),
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

  String _getMotivationalMessage(int progress) {
    if (progress == 0) return "You've got this! Start with one small habit.";
    if (progress < 50) return "Keep going! Every habit counts.";
    if (progress < 100) return "Great progress! Finish strong!";
    return "Amazing! You completed all your habits today!";
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
      print('Scheduled date was in the past, moving to next day: $scheduledDate');
    }

    return scheduledDate;
  }
}
