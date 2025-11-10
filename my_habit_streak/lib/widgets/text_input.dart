// filepath: /home/genazemildo/Documents/GitHub/MyHabitStreak/my_habit_streak/lib/widgets/text_input.dart
import 'package:flutter/material.dart';

class ThemedTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final Color? cursorColor;
  final int? minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final bool autocorrect;

  const ThemedTextInput({
    super.key,
    this.controller,
    this.labelText,
    this.cursorColor,
    this.minLines,
    this.maxLines,
    this.onChanged,
    this.onEditingComplete,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = cursorColor ?? Theme.of(context).colorScheme.primary;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      autocorrect: autocorrect,
      cursorColor: borderColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18.0),
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
