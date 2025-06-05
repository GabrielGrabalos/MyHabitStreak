import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Makes button 100% width
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          // Transparent background
          side: BorderSide(color: color, width: 3),
          // Blue border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          padding: const EdgeInsets.all(16), // Adjust padding as needed
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
