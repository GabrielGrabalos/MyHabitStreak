import 'package:flutter/material.dart';
import 'package:my_habit_streak/utils/colors.dart';
import 'package:vibration/vibration.dart';

class Button extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsetsGeometry? padding;
  final bool isLoading; // New isLoading parameter

  const Button({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = blueTheme,
    this.padding,
    this.isLoading = false, // Default to false
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double _bottomBorderWidth = 10.0;
  double _verticalOffset = 0.0;

  @override
  void didUpdateWidget(covariant Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset pressed state when loading starts
    if (widget.isLoading && !oldWidget.isLoading) {
      setState(() {
        _bottomBorderWidth = 10.0;
        _verticalOffset = 0.0;
      });
    }
  }

  void _handleTapDown(TapDownDetails details) async {
    if (widget.isLoading) return; // Ignore when loading

    setState(() {
      _bottomBorderWidth = 3.0;
      _verticalOffset = 7.0;
    });

    if (await Vibration.hasAmplitudeControl()) {
      Vibration.vibrate(amplitude: 255, duration: 5);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.isLoading) return; // Ignore when loading

    setState(() {
      _bottomBorderWidth = 10.0;
      _verticalOffset = 0.0;
    });
    widget.onPressed.call();
  }

  void _handleTapCancel() {
    if (widget.isLoading) return; // Ignore when loading

    setState(() {
      _bottomBorderWidth = 10.0;
      _verticalOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTapDown: widget.isLoading ? null : _handleTapDown,
          onTapUp: widget.isLoading ? null : _handleTapUp,
          onTapCancel: widget.isLoading ? null : _handleTapCancel,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 80),
            curve: Curves.easeOut,
            margin: EdgeInsets.only(top: _verticalOffset),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25.0),
              border: Border(
                top: BorderSide(color: widget.color, width: 3),
                left: BorderSide(color: widget.color, width: 3),
                right: BorderSide(color: widget.color, width: 3),
                bottom: BorderSide(
                  color: widget.color,
                  width: _bottomBorderWidth,
                ),
              ),
            ),
            child: TextButton(
              onPressed: null, // Always null, handled by GestureDetector
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.all(16),
              ),
              child: widget.isLoading
                  ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                ),
              )
                  : Text(
                widget.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}