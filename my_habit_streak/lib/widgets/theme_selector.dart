import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:my_habit_streak/utils/habit_theme.dart';

class ThemeSelector extends StatelessWidget {
  final HabitTheme selectedTheme;
  final ValueChanged<HabitTheme> onChanged;
  final Color color;

  const ThemeSelector({
    super.key,
    this.selectedTheme = HabitTheme.bee,
    this.color = blueTheme,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/${selectedTheme.name}.svg',
          height: 150,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: HabitTheme.values.map((theme) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () {
                    // Call the onChanged callback when a theme is selected
                    onChanged(theme);
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            selectedTheme == theme ? color : Colors.transparent,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: SvgPicture.asset(
                      'assets/${theme.name}.svg',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
