import 'package:flutter/material.dart';

class HabitGroupTag extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isSelected;

  const HabitGroupTag({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(50) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: color,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Colors.white,
                  size: 16,
                ),
              if (label != '') SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w900 : FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
