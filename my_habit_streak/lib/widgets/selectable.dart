import 'package:flutter/material.dart';

class Selectable<T> extends StatelessWidget {
  final T value;
  final List<T>? groupValue;
  final ValueChanged<T?> onChanged;
  final Widget child;
  final bool suppressChildInteractions;

  const Selectable({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.child,
    this.suppressChildInteractions = true,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = groupValue?.contains(value);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected == true
              ? Theme.of(context).colorScheme.onSurface.withAlpha(30)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected == true
                ? Theme.of(context).colorScheme.onSurface
                : Colors.grey.withAlpha(80),
            width: isSelected == true ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio<T>(
              value: value,
              groupValue: isSelected == true ? value : null,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.onSurface,
            ),
            Expanded(
              child: suppressChildInteractions
                  ? AbsorbPointer(child: child)
                  : child,
            ),
          ],
        ),
      ),
    );
  }
}
