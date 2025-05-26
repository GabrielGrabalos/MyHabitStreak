import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onActionPressed;

  const Header({
    super.key,
    this.title = 'My Habit Streak',
    this.icon,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 15, vertical: icon != null ? 3 : 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (icon != null)
            IconButton(
              icon: Icon(icon, color: Colors.white),
              onPressed: onActionPressed ??
                  () {
                    // Default action if no callback is provided
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Action button pressed')),
                    );
                  },
            ),
        ],
      ),
    );
  }
}
