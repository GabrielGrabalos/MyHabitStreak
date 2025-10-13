import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final double spacing;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorSelector({
    super.key,
    this.colors = cardColors,
    this.spacing = 10.0,
    this.selectedColor = blueTheme,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () {
              // Call the onColorSelected callback when a color is selected
              onColorSelected(color);
            },
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: spacing / 2),
              padding: EdgeInsets.all(40 * 0.1),
              // Adjust padding as needed
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedColor == color ? color : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 36,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
