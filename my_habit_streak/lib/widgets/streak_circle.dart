import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StreakCircle extends StatelessWidget {
  final bool isDone;
  final double size;
  final Color color;
  final double opacity;

  const StreakCircle({
    super.key,
    this.isDone = false,
    this.size = 50,
    this.color = const Color(0xFF4CAF50),
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final image = isDone ? 'happy_face' : 'sad_face';
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(opacity),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SvgPicture.asset(
          'assets/$image.svg',
          width: size * 0.5,
          height: size * 0.5,
        ),
      ),
    );
  }
}
