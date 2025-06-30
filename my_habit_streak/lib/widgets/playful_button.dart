import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlayfulMenu extends StatefulWidget {
  final List<ButtonData> buttons;
  final Alignment alignment;
  final Widget mainButtonChild;
  final Color mainButtonColor;
  final List<Color>? colors;
  final double buttonSpacing;
  final double maxTilt;

  const PlayfulMenu({
    super.key,
    required this.buttons,
    this.alignment = Alignment.centerRight,
    this.mainButtonChild = const Icon(Icons.add, color: Colors.white, size: 30),
    this.mainButtonColor = Colors.deepPurple,
    this.colors,
    this.buttonSpacing = 80.0,
    this.maxTilt = 15.0,
  });

  @override
  State<PlayfulMenu> createState() => _PlayfulMenuState();
}

class _PlayfulMenuState extends State<PlayfulMenu>
    with TickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late List<Animation<double>> _buttonAnimations;
  late List<double> _buttonTilts;
  OverlayEntry? _overlayEntry;

  final List<Color> _vibrantColors = [
    Colors.red.shade400,
    Colors.pink.shade400,
    Colors.purple.shade400,
    Colors.deepPurple.shade400,
    Colors.indigo.shade400,
    Colors.blue.shade400,
    Colors.lightBlue.shade400,
    Colors.cyan.shade400,
    Colors.teal.shade400,
    Colors.green.shade400,
    Colors.lightGreen.shade400,
    Colors.lime.shade400,
    Colors.yellow.shade400,
    Colors.orange.shade400,
    Colors.deepOrange.shade400,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.colors != null) {
      _vibrantColors.clear();
      _vibrantColors.addAll(widget.colors!);
    }
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _initializeAnimations();
    _generateRandomTilts();
  }

  void _initializeAnimations() {
    _buttonAnimations = List.generate(widget.buttons.length, (index) {
      final startTime = index * 0.1;
      final endTime = startTime + 0.6;

      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          startTime.clamp(0.0, 1.0),
          endTime.clamp(0.0, 1.0),
          curve: Curves.elasticOut,
        ),
      ));
    });
  }

  void _generateRandomTilts() {
    final random = math.Random(14);
    _buttonTilts = List.generate(
      widget.buttons.length,
      (index) => (random.nextDouble() - 0.5) * 2 * widget.maxTilt,
    );
  }

  Offset _getButtonOffset(int index) {
    final baseOffset = _getAlignmentOffset();
    final spacing = widget.buttonSpacing;

    switch (widget.alignment) {
      case Alignment.centerRight:
        return Offset(baseOffset.dx + (index + 1) * spacing, baseOffset.dy);
      case Alignment.centerLeft:
        return Offset(baseOffset.dx - (index + 1) * spacing, baseOffset.dy);
      case Alignment.topCenter:
        return Offset(baseOffset.dx, baseOffset.dy - (index + 1) * spacing);
      case Alignment.bottomCenter:
        return Offset(baseOffset.dx, baseOffset.dy + (index + 1) * spacing);
      case Alignment.topRight:
        return Offset(
          baseOffset.dx + (index + 1) * spacing * 0.7,
          baseOffset.dy - (index + 1) * spacing * 0.7,
        );
      case Alignment.topLeft:
        return Offset(
          baseOffset.dx - (index + 1) * spacing * 0.7,
          baseOffset.dy - (index + 1) * spacing * 0.7,
        );
      case Alignment.bottomRight:
        return Offset(
          baseOffset.dx + (index + 1) * spacing * 0.7,
          baseOffset.dy + (index + 1) * spacing * 0.7,
        );
      case Alignment.bottomLeft:
        return Offset(
          baseOffset.dx - (index + 1) * spacing * 0.7,
          baseOffset.dy + (index + 1) * spacing * 0.7,
        );
      default:
        return Offset(baseOffset.dx + (index + 1) * spacing, baseOffset.dy);
    }
  }

  Offset _getAlignmentOffset() {
    return const Offset(0, 0); // Main button is at origin
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _showOverlay();
      _animationController.forward();
    } else {
      _removeOverlay();
      _animationController.reverse();
    }
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _closeMenu(),
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _closeMenu() {
    if (_isExpanded) {
      _toggleExpansion();
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DeferredPointerHandler(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Animated child buttons
          ...List.generate(widget.buttons.length, (index) {
            return AnimatedBuilder(
              animation: _buttonAnimations[index],
              builder: (context, child) {
                final offset = _getButtonOffset(index);
                final animation = _buttonAnimations[index];
                final scale = animation.value;
                final opacity = animation.value.clamp(0.0, 1.0);

                return Positioned(
                  left: offset.dx * animation.value,
                  top: offset.dy * animation.value,
                  child: DeferPointer(
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.rotate(
                          angle: _buttonTilts[index] * math.pi / 180,
                          child:
                              _buildChildButton(List.of(widget.buttons.reversed)[index], index),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          // Main button
          Transform.scale(
            scale: _isExpanded ? 1.1 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: widget.mainButtonColor,
                borderRadius: BorderRadius.circular(25),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: _toggleExpansion,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: AnimatedRotation(
                      turns: _isExpanded ? 0.125 : 0, // 45 degrees
                      duration: const Duration(milliseconds: 300),
                      child: widget.mainButtonChild,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildButton(ButtonData buttonData, int index) {
    final color =
        buttonData.color ?? _vibrantColors[index % _vibrantColors.length];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            buttonData.onTap();
            _closeMenu();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  buttonData.icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  buttonData.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonData {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? color;

  const ButtonData({
    required this.icon,
    required this.text,
    required this.onTap,
    this.color,
  });
}
