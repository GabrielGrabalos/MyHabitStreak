import 'package:flutter/material.dart';

import '../models/habit.dart';
import '../utils/colors.dart';

class VisualizeSpecificHabitDay extends StatefulWidget {
  final Habit habit;
  const VisualizeSpecificHabitDay({super.key, required this.habit});

  @override
  State<VisualizeSpecificHabitDay> createState() =>
      _VisualizeSpecificHabitDayState();
}

class _VisualizeSpecificHabitDayState extends State<VisualizeSpecificHabitDay> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.35,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.5, 0.75, 0.95],
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: const BoxDecoration(
            color: darkBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
