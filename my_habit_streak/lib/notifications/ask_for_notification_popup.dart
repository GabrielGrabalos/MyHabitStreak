import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/utils/general_storage_service.dart';
import 'package:my_habit_streak/widgets/button.dart';
import 'package:my_habit_streak/widgets/dialog_popup.dart';
import 'package:permission_handler/permission_handler.dart';

class AskForNotificationPopup extends StatelessWidget {
  final bool isPermanentlyDenied;

  const AskForNotificationPopup({
    super.key,
    required this.isPermanentlyDenied,
  });

  @override
  Widget build(BuildContext context) {
    return !isPermanentlyDenied
        ? const DialogPopup(
            title: "Notifications",
            message:
                "Allow us to send you some notifications to help you never forget "
                "about your new habits! We promise not to abuse it!",
          )
        : DialogPopup(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 20),
                SvgPicture.asset('assets/bee_gray.svg',
                    height: 100, fit: BoxFit.contain),
                const SizedBox(height: 20),
                Text(
                  "Are you sure you want to permanently deny notifications?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
                const SizedBox(height: 20),
                Button(
                  label: "Open Settings",
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
                Button(
                    label: "Don't ask again",
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    color: Colors.red,
                    onPressed: () {
                      GeneralStorageService().saveData(
                        "not_show_notification_popup",
                        true,
                      );
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
  }
}
