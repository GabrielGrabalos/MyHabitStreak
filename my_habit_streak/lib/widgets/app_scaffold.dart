import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: SafeArea(child: body),
    );
  }
}
