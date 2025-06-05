import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorSelector({
    super.key,
    this.colors = const [
      pinkTheme,
      yellowTheme,
      greenTheme,
      blueTheme,
      purpleTheme,
    ],
    this.selectedColor = blueTheme,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            // Call the onColorSelected callback when a color is selected
            onColorSelected(color);
          },
          child: Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedColor == color ? color : Colors.transparent,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              backgroundColor: color,
              radius: 30, // Adjust radius as needed
            ),
          ),
        );
      }).toList(),
    );
  }
}
