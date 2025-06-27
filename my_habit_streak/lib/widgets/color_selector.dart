import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> colors;
  final double spacing;
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
    this.spacing = 10.0,
    this.selectedColor = blueTheme,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 20; // 20 padding on each side
    final outerSize = (availableWidth - spacing * (colors.length - 1)) / colors.length;
    final innerSize = (outerSize * 0.8).clamp(20.0, 100.0); // Ensure a minimum size for the inner circle

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colors.map((color) {
        return GestureDetector(
          onTap: () {
            // Call the onColorSelected callback when a color is selected
            onColorSelected(color);
          },
          child: Container(
            width: outerSize,
            height: outerSize,
            padding: EdgeInsets.all(outerSize * 0.2), // Adjust padding as needed
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedColor == color ? color : Colors.transparent,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: CircleAvatar(
              backgroundColor: color,
              radius: innerSize, // Adjust radius as needed
            ),
          ),
        );
      }).toList(),
    );
  }
}
