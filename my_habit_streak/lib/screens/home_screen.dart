import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/models/habit.dart';
import 'package:my_habit_streak/models/habit_group.dart';
import 'package:my_habit_streak/services/general_storage_service.dart';
import 'package:my_habit_streak/services/habit_group_storage_service.dart';
import 'package:my_habit_streak/services/habit_storage_service.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
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
import 'create_edit_habit.dart';
import 'create_group_bottom_sheet.dart'; // Your storage service

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  late StreamSubscription _habitsSubscription;
  late StreamSubscription _habitGroupSubscription;
  late ScrollController _groupScrollController;

  final notificationService = NotificationService();
  bool isLoading = true;

  HabitGroup? _selectedGroup;
  List<HabitGroup> _habitGroups = [];
  List<Habit> _currentHabits = [];
  List<Habit> _allHabits = [];

  @override
  void initState() {
    super.initState();
    _groupScrollController = ScrollController();
    _loadHabitsAndGroups();

    _habitsSubscription = HabitStorageService.habitsStream.listen((event) {
      _loadHabitsAndGroups();
      notificationService.scheduleNotifications();
      if (event.$2 == "create") {
        // Select "All" group:
        _selectedGroup = _habitGroups.first;
        _groupScrollController.jumpTo(0.0);
      }
    } as void Function((List<Habit>, String) event)?);

    _habitGroupSubscription =
        HabitGroupStorageService.habitGroupsStream.listen((updatedGroups) {
      _loadHabitsAndGroups();
    });

    _dealWithNotificationPermission();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _groupScrollController.dispose();
    _habitsSubscription.cancel();
    _habitGroupSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    notificationService.setAppLocalizations(AppLocalizations.of(context)!);
  }

  Future<void> _dealWithNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) return;

    final notShowPopup = await GeneralStorageService.getData(
          'not_show_notification_popup',
        ) as bool? ??
        false;

    if (notShowPopup) return;
    if (!mounted) return;

    final shouldRequestNotification = await showDialog(
        context: context,
        builder: (context) {
          return AskForNotificationPopup(
              isPermanentlyDenied: status.isPermanentlyDenied);
        });

    if (shouldRequestNotification == true) {
      await Permission.notification.request();
      await notificationService.scheduleNotifications();
    }
  }

  Future<void> _loadHabitsAndGroups() async {
    setState(() => isLoading = true);

    _allHabits = await HabitStorageService.getHabits();

    // Load habit groups:
    final customGroups = await HabitGroupStorageService.getAllHabitGroups();

    // Build dynamic groups (All, Not Done, Done):
    List<String> allHabitIds = _allHabits.map((h) => h.id).toList();
    List<String> notDoneHabitIds =
        _allHabits.where((h) => !h.isTodayDone).map((h) => h.id).toList();
    List<String> doneHabitIds =
        _allHabits.where((h) => h.isTodayDone).map((h) => h.id).toList();

    if (!mounted) return;

    _habitGroups = [
      HabitGroup(
        id: 'all',
        name: AppLocalizations.of(context)!.all,
        habitIds: allHabitIds,
      ),
      HabitGroup(
        id: 'not_done',
        name: AppLocalizations.of(context)!.notDone,
        habitIds: notDoneHabitIds,
      ),
      HabitGroup(
        id: 'done',
        name: AppLocalizations.of(context)!.done,
        habitIds: doneHabitIds,
      ),
      ...customGroups,
    ];

    // Preserve selection OR default to "All":
    if (_selectedGroup == null ||
        !_habitGroups.any((g) => g.id == _selectedGroup!.id)) {
      _selectedGroup = _habitGroups.first;
    }

    _loadCurrentHabitsFromSelectedGroup();

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  void _loadCurrentHabitsFromSelectedGroup() {
    if (_selectedGroup == null) return;

    List<String> habitIds;
    if (_selectedGroup!.id == 'all') {
      habitIds = _allHabits.map((h) => h.id).toList();
    } else if (_selectedGroup!.id == 'not_done') {
      habitIds =
          _allHabits.where((h) => !h.isTodayDone).map((h) => h.id).toList();
    } else if (_selectedGroup!.id == 'done') {
      habitIds =
          _allHabits.where((h) => h.isTodayDone).map((h) => h.id).toList();
    } else {
      habitIds = _selectedGroup!.habitIds;
    }

    _currentHabits =
        _allHabits.where((habit) => habitIds.contains(habit.id)).toList();
  }

  void _onGroupSelected(HabitGroup group) {
    setState(() {
      _selectedGroup = group;
      _loadCurrentHabitsFromSelectedGroup();
    });
  }

  void _onGroupEdit(HabitGroup group) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateGroupBottomSheet(
        existingGroup: group,
        availableHabits: _allHabits,
        onCreate: (updatedGroup) async {
          await HabitGroupStorageService.saveOrUpdateHabitGroup(updatedGroup);
          _selectedGroup = updatedGroup;
          _loadHabitsAndGroups();
        },
      ),
    );
  }

  void _onGroupDelete(HabitGroup group) async {
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => DialogPopup(
            title: AppLocalizations.of(context)!.deleteHabitGroupTitle,
            message: AppLocalizations.of(context)!
                .deleteHabitGroupMessage(group.name),
            isWarning: true,
          ),
        ) ??
        false;

    if (!shouldDelete) return;

    await HabitGroupStorageService.deleteHabitGroup(group.id);
    if (_selectedGroup?.id == group.id) {
      _selectedGroup = _habitGroups.first;
      _groupScrollController.jumpTo(0.0);
    }
    _loadHabitsAndGroups();
  }

  void _onAddGroup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateGroupBottomSheet(
        availableHabits: _allHabits,
        onCreate: (newGroup) async {
          await HabitGroupStorageService.saveOrUpdateHabitGroup(newGroup);
          _selectedGroup = newGroup;
          _loadHabitsAndGroups();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Header(
                          title: AppLocalizations.of(context)!.myHabits,
                          icon: Icons.add,
                          onActionPressed: () async {
                            await Navigator.pushNamed(
                              context,
                              CreateEditHabit.routeName,
                            );
                          },
                        ),
                        Expanded(
                          child: _allHabits.isEmpty
                              ? Align(
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
                                )
                              : HabitGroupView(
                                  habitGroups: _habitGroups,
                                  selectedHabitGroup: _selectedGroup,
                                  currentHabits: _currentHabits,
                                  allHabits: _allHabits,
                                  onGroupSelected: _onGroupSelected,
                                  onGroupEdit: _onGroupEdit,
                                  onGroupDelete: _onGroupDelete,
                                  onAddGroup: _onAddGroup,
                                  scrollController: _groupScrollController,
                                ),
                        ),
                      ],
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
                                    builder: (context) => LanguageSelection(),
                                  );
                                }),
                            ButtonData(
                              text: AppLocalizations.of(context)!.privacyPolicy,
                              icon: Icons.privacy_tip,
                              onTap: () async {
                                final url = Uri.parse(
                                  'https://my-habit-streak.web.app/privacy-policy',
                                );
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
