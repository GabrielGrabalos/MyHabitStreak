import 'package:flutter/material.dart';
import 'dart:math';

import 'package:my_habit_streak/utils/colors.dart';

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

class FloatingActionButtonMenu extends StatefulWidget {
  final List<ButtonData> buttons;
  final List<Color> colors;
  final Color mainButtonColor;
  final int seed;
  final double buttonSpacing;

  const FloatingActionButtonMenu({
    super.key,
    required this.buttons,
    required this.colors,
    this.seed = 14,
    this.buttonSpacing = 70.0,
    this.mainButtonColor = Colors.purple,
  });

  @override
  State<FloatingActionButtonMenu> createState() =>
      _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;
  bool _isAnimating = false; // Track animation state
  late List<double> _tilts;
  late List<Color> _assignedColors;
  OverlayEntry? _overlayEntry;
  late List<Animation<double>> _buttonAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Initialize random values
    final random = Random(widget.seed);
    _tilts = List.generate(widget.buttons.length,
        (index) => (random.nextDouble() * 30 - 15) * (pi / 180));
    _assignedColors = List.generate(widget.buttons.length,
        (index) => widget.colors[random.nextInt(widget.colors.length)]);

    // Create animations for each button
    _buttonAnimations = List.generate(widget.buttons.length, (index) {
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
      );
    });
  }

  void _toggleMenu() {
    // Prevent multiple animations
    if (_isAnimating) return;

    setState(() => _isOpen = !_isOpen);
    _isAnimating = true;

    if (_isOpen) {
      _showOverlay();
      _controller.forward().then((_) {
        if (mounted) {
          setState(() => _isAnimating = false);
        }
      });
    } else {
      _controller.reverse().then((_) {
        _removeOverlay();
        if (mounted) {
          setState(() => _isAnimating = false);
        }
      });
    }
  }

  void _showOverlay() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Full-screen tap detector to close menu
          Positioned.fill(
            child: GestureDetector(
              onPanDown: (_) => _toggleMenu(),
              behavior: HitTestBehavior.translucent,
            ),
          ),
          // Animated buttons
          Positioned(
            left: position.dx,
            bottom:
                MediaQuery.of(context).size.height - position.dy - size.height,
            child: _buildExpandedMenu(size.height),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Widget _buildExpandedMenu(double mainButtonSize) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 150, // Wider to accommodate text
        height: mainButtonSize + widget.buttonSpacing * widget.buttons.length,
        alignment: Alignment.bottomLeft,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main button in overlay
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildMainButton(mainButtonSize),
            ),
            // Sub buttons
            for (int i = 0; i < widget.buttons.length; i++)
              Positioned(
                left: 0,
                bottom: (i + 1) * widget.buttonSpacing,
                child: _buildSubButton(i),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubButton(int index) {
    return AnimatedBuilder(
      animation: _buttonAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _buttonAnimations[index].value) * 20),
          child: Transform.rotate(
            angle: _tilts[index] * _buttonAnimations[index].value,
            child: Opacity(
              opacity: _buttonAnimations[index].value,
              child: IgnorePointer(
                ignoring: _buttonAnimations[index].value < 0.5,
                child: _Button(
                  data: widget.buttons.reversed.toList()[index],
                  color: _assignedColors[index],
                  onTap: () {
                    widget.buttons.reversed.toList()[index].onTap();
                    _toggleMenu();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainButton(double size) {
    return FloatingActionButton(
      onPressed: _toggleMenu,
      backgroundColor: widget.mainButtonColor,
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _controller,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainButton(56);
  }

  @override
  void dispose() {
    _controller.dispose();
    _removeOverlay();
    super.dispose();
  }
}

class _Button extends StatelessWidget {
  final ButtonData data;
  final Color color;
  final VoidCallback onTap;

  const _Button({
    required this.data,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 4,
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          constraints: const BoxConstraints(minWidth: 120),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.icon,
                color: color != yellowTheme ? Colors.white : darkBackground,
                size: 20,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  data.text,
                  style: TextStyle(
                    color: color != yellowTheme ? Colors.white : darkBackground,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
