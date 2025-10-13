import 'package:flutter/material.dart';
import 'package:my_habit_streak/l10n/app_localizations.dart';

class HabitGroupTag extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final VoidCallback onGroupEdit;
  final VoidCallback onGroupDelete;
  final IconData? icon;
  final bool isSelected;
  final bool hasMenu;

  const HabitGroupTag({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    required this.onGroupEdit,
    required this.onGroupDelete,
    this.icon,
    this.isSelected = false,
    this.hasMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100), // Circular border for tag
        side: BorderSide(
          color: color,
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      elevation: 4,
      color: isSelected ? color.withAlpha(50) : Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        onLongPress: () async {
          if (!hasMenu) return;

          final renderBox = context.findRenderObject() as RenderBox;
          final offset = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;

          // Approximated of popup because
          // I don't want to deal with dynamic
          // sizing and rendering, and this will
          // never change (always same items),
          // so I don't care enough:
          final menuWidth = 108.0;

          final selected = await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              offset.dx - (menuWidth / 2) + (size.width / 2),
              // shift for horizontal centering
              offset.dy + size.height + 5,
              offset.dx + size.width,
              0,
            ),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.white, width: 1),
            ),
            items: [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.edit),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      size: 20,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    SizedBox(width: 8),
                    Text(AppLocalizations.of(context)!.delete),
                  ],
                ),
              ),
            ],
          );

          if (selected == 'edit') {
            onGroupEdit();
          } else if (selected == 'delete') {
            onGroupDelete();
          }
        },
        borderRadius: BorderRadius.circular(100),
        // Match the Card's border radius
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: 16,
                ),
              if (icon != null && label.isNotEmpty) SizedBox(width: 4),
              if (label.isNotEmpty)
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
