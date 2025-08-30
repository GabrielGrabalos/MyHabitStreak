import 'dart:async';

import 'package:flutter/material.dart'; // Using Material Design widgets
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/utils/general_storage_service.dart';
import 'package:my_habit_streak/utils/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import '../l10n/app_localizations.dart';
import 'package:my_habit_streak/widgets/language_selection.dart';
import 'package:my_habit_streak/widgets/floating_action_button_menu.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import '../notifications/ask_for_notification_popup.dart';
import '../notifications/notification_service.dart';
import '../utils/colors.dart';
import '../widgets/habit_list.dart';
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

  late StreamSubscription _storageSubscription;

  final List<Habit> _doneTodayHabits = [];
  final List<Habit> _notDoneTodayHabits = [];
  bool _isLoading = true; // State to manage loading indicator

  final notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _habitsSubscription =
        HabitStorageService.habitsStream.listen((updatedHabits) {
      // Whenever habits are updated, reschedule notifications,
      // so they are always in sync with the latest data.
      notificationService.scheduleNotifications();
      debugPrint(
          'Habits stream updated: ${updatedHabits.length} items\n\n\n'); // Debugging output
    });

    _storageSubscription = GeneralStorageService.storageStream.listen((_) {
      // Whenever general storage changes, reschedule notifications,
      // in case notification preferences or language were changed.
      notificationService.scheduleNotifications();
      debugPrint('General storage updated\n\n\n'); // Debugging output
    });
    _loadAndSeparateHabits(); // Load and separate habits when the screen initializes
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

  // Called when returning to HomeScreen via pop
  @override
  void didPopNext() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAndSeparateHabits(); // Reload habits when returning to this screen
    });
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

  // Method to load all habits and separate them
  Future<void> _loadAndSeparateHabits() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      final List<Habit> allHabits = await HabitStorageService.getHabits();

      // Clear previous lists before repopulating
      _doneTodayHabits.clear();
      _notDoneTodayHabits.clear();

      for (var habit in allHabits) {
        if (habit.isTodayDone) {
          _doneTodayHabits.add(habit);
        } else {
          _notDoneTodayHabits.add(habit);
        }
      }
    } catch (e) {
      // Handle any errors during habit loading
      debugPrint('Error loading habits: $e');
      // Potentially show an error message to the user
    } finally {
      setState(() {
        _isLoading = false; // End loading, even if there was an error
      });
    }
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

                        // If a new habit was created, reload the habits
                        if (newHabit != null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _loadAndSeparateHabits();
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  if (_notDoneTodayHabits.isNotEmpty)
                                    HabitList(
                                      title: AppLocalizations.of(context)!
                                          .notDoneToday,
                                      habits: _notDoneTodayHabits,
                                    ),
                                  if (_doneTodayHabits.isNotEmpty)
                                    HabitList(
                                      title: AppLocalizations.of(context)!
                                          .doneToday,
                                      habits: _doneTodayHabits,
                                    ),
                                  if (_doneTodayHabits.isEmpty &&
                                      _notDoneTodayHabits.isEmpty)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 15,
                                          right: 35,
                                        ),
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/bee_button_indicator.svg',
                                              width: constraints.maxWidth * 0.8,
                                            ),
                                            const SizedBox(height: 10),
                                            Transform.rotate(
                                              angle: -0.25,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .startCreating,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
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
                      ButtonData(
                        text: 'Show instant notification',
                        icon: Icons.notifications,
                        onTap: () {
                          notificationService.showInstantNotification(
                            id: 0,
                            title: 'Notification test',
                            body:
                                'Instant notification body. Bla bla bla, borga na galorga',
                          );
                        },
                      ),
                      ButtonData(
                        icon: Icons.notifications,
                        text: 'Scheduled notification',
                        onTap: () {
                          notificationService.scheduleNotifications();
                        },
                      )
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
