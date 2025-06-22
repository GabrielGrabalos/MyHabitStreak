import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

// The Button widget is now a StatefulWidget to manage its animated state.
class Button extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final EdgeInsetsGeometry? padding;

  const Button(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.color,
      this.padding});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  // State variable to control the width of the bottom border.
  double _bottomBorderWidth = 10.0;

  // State variable to control the vertical offset (simulating movement).
  double _verticalOffset = 0.0;

  // Handles the button being touched down (press starts).
  void _handleTapDown(TapDownDetails details) async {
    setState(() {
      _bottomBorderWidth =
          3.0; // Bottom border width becomes 3.0 (normal width).
      _verticalOffset = 7.0; // Button moves down by 7.0 units.
    });

    if (await Vibration.hasAmplitudeControl()) {
      Vibration.vibrate(amplitude: 255, duration: 5);
    }
  }

  // Handles the button being touched up (press ends).
  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _bottomBorderWidth = 10.0; // Revert to original bottom border width.
      _verticalOffset = 0.0; // Revert to original vertical position.
    });
    // Call the original onPressed callback when the touch ends.
    widget.onPressed.call();
  }

  // Handles when the touch is cancelled (e.g., finger slides off the button).
  void _handleTapCancel() {
    setState(() {
      _bottomBorderWidth = 10.0; // Revert to original bottom border width.
      _verticalOffset = 0.0; // Revert to original vertical position.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0.0),
      child: SizedBox(
        width: double.infinity, // Makes button 100% width
        child: GestureDetector(
          // GestureDetector to detect touch down and up events.
          onTapDown: _handleTapDown, // Call when touch starts.
          onTapUp: _handleTapUp, // Call when touch ends.
          onTapCancel: _handleTapCancel, // Call if touch is cancelled.
          child: AnimatedContainer(
            // AnimatedContainer handles smooth transitions for its properties.
            duration: const Duration(milliseconds: 80),
            // Duration of the animation.
            curve: Curves.easeOut,
            // Animation curve for a smooth deceleration.
            // Apply the vertical offset as a top margin, pushing the button down.
            margin: EdgeInsets.only(top: _verticalOffset),
            decoration: BoxDecoration(
              color: Colors.transparent, // Background of the container.
              borderRadius: BorderRadius.circular(25.0),
              border: Border(
                // Define individual borders for the Container.
                top: BorderSide(color: widget.color, width: 3),
                left: BorderSide(color: widget.color, width: 3),
                right: BorderSide(color: widget.color, width: 3),
                // The bottom border width is controlled by the state variable.
                bottom: BorderSide(
                  color: widget.color,
                  width: _bottomBorderWidth,
                ),
              ),
            ),
            child: TextButton(
              // onPressed is set to null here because GestureDetector is handling the tap events
              // and will call widget.onPressed manually.
              onPressed: null,
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                // Ensure TextButton itself has transparent background.
                padding: const EdgeInsets.all(16), // Adjust padding as needed.
                // The 'side' property is not used here as the border is handled by the parent Container.
              ),
              child: Text(
                widget.label,
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
