import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitGroupTag extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const HabitGroupTag({
    super.key,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: ,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurface,
              width: 2.0,
            ),),
        child: Text(label),
      ),
    );
  }
}
