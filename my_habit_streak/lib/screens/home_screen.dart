import 'dart:async';

import 'package:flutter/material.dart'; // Using Material Design widgets
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/services/general_storage_service.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/habit_group_view.dart';
import '../l10n/app_localizations.dart';
import 'package:my_habit_streak/widgets/language_selection.dart';
import 'package:my_habit_streak/widgets/floating_action_button_menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../notifications/ask_for_notification_popup.dart';
import '../notifications/notification_service.dart';
import '../utils/colors.dart';
import '../widgets/header.dart';
import 'create_edit_habit.dart'; // Your storage service

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  late StreamSubscription _habitsSubscription;

  final notificationService = NotificationService();
  bool isLoading = true;
  late bool habitsEmpty;

  @override
  void initState() {
    super.initState();
    _habitsSubscription =
        HabitStorageService.habitsStream.listen((updatedHabits) {
      // Whenever habits are updated, reschedule notifications,
      // so they are always in sync with the latest data.
      notificationService.scheduleNotifications();
      debugPrint('Habits stream updated: ${updatedHabits.length} items');
    });
    _loadHabitsEmpty();
    _dealWithNotificationPermission(); // Check notification permission
  }

  // Subscribe to route observer
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    notificationService.setAppLocalizations(AppLocalizations.of(context)!);
  }

  // Unsubscribe to prevent memory leaks
  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _habitsSubscription.cancel();
    super.dispose();
  }

  void _dealWithNotificationPermission() async {
    // Check if notification permission is granted
    final status = await Permission.notification.status;

    if (status.isGranted) return; // Already granted

    final notShowPopup = await GeneralStorageService.getData(
          'not_show_notification_popup',
        ) as bool? ??
        false;

    if (notShowPopup) return; // User opted out of the popup.

    if (!mounted) return; // Ensure the widget is still mounted.

    // Show the notification permission dialog
    final shouldRequestNotification = await showDialog(
        context: context,
        builder: (context) {
          return AskForNotificationPopup(
              isPermanentlyDenied: status.isPermanentlyDenied);
        });

    if (shouldRequestNotification == true) {
      await Permission.notification.request();
      // No need to verify if we were actually granted the permission,
      // since it wouldn't change the behaviour of not having notifications
      // and would waist resources for the checking.
      await notificationService.scheduleNotifications();
    }
  }

  Future<void> _loadHabitsEmpty() async {
    habitsEmpty = (await HabitStorageService.getHabits()).isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SizedBox(
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    Header(
                      title: AppLocalizations.of(context)!.myHabits,
                      icon: Icons.add,
                      onActionPressed: () async {
                        // Navigate to the Create/Edit Habit screen
                        final Habit? newHabit = await Navigator.pushNamed(
                          context,
                          CreateEditHabit.routeName,
                        ) as Habit?;
                      },
                    ),
                    Expanded(
                      child: isLoading
                          ? CircularProgressIndicator()
                          : HabitGroupView(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButtonMenu(
                    seed: 12,
                    colors: cardColors,
                    mainButtonColor: pinkTheme,
                    buttons: [
                      ButtonData(
                          text: AppLocalizations.of(context)!.idiom,
                          icon: Icons.language,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return LanguageSelection();
                                });
                          }),
                      ButtonData(
                        text: AppLocalizations.of(context)!.privacyPolicy,
                        icon: Icons.privacy_tip,
                        onTap: () async {
                          final url = Uri.parse(
                            'https://my-habit-streak.web.app/privacy-policy',
                          );
                          // Attempt to launch the URL in an in-app web view:
                          // redirect to privacy policy URL:
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
