import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_habit_streak/widgets/app_scaffold.dart';
import 'package:my_habit_streak/widgets/header.dart';

class VisualizeHabit extends StatelessWidget {
  const VisualizeHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          Header(
            title: 'Alongamento',
            icon: Icons.edit,
            onActionPressed: () {
              // Action when the edit icon is pressed
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Edit action triggered')),
              );
            },
          ),
          Expanded(child: Column(children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/${theme == HabitTheme.bee ? 'bee' : 'flower'}${!isTodayDone ? '_gray' : ''}.svg',
              ),
            ),
            SizedBox(height: 5),
            Text(
              streak.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isTodayDone
                    ? doneColor
                    : color != yellowTheme
                    ? Colors.white
                    : darkBackground,
              ),
            ),
          ]))
        ],
      ),
    );
  }
}
