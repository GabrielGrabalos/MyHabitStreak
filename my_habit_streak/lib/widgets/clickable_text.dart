import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';

class ClickableText extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color color;
  final TextStyle? style;

  const ClickableText({
    super.key,
    required this.label,
    required this.onTap,
    this.color = blueTheme,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: style != null
            ? style!.copyWith(
                color: color,
                decoration: style!.decoration ?? TextDecoration.underline,
                decorationColor: style!.decorationColor ?? color,
              )
            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color,
                  decoration: TextDecoration.underline,
                  decorationColor: color,
                ),
      ),
    );
  }
}
