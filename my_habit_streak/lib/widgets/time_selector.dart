import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class TimeSelectorController extends ChangeNotifier {
  int hour;
  int minute;
  bool isAM;
  Color color;

  TimeSelectorController({
    int? hour,
    int? minute,
    bool? isAM,
    this.color = blueTheme,
  })  : hour = hour ?? DateTime.now().hour,
        minute = minute ?? DateTime.now().minute,
        isAM = isAM ?? (DateTime.now().hour < 12);

  TimeOfDay get time {
    int displayHour = hour;
    if (Utils.shouldUseAMPM()) {
      if (!isAM && displayHour < 12) displayHour += 12;
      if (isAM && displayHour == 12) displayHour = 0;
    }
    return TimeOfDay(hour: displayHour, minute: minute);
  }

  void setTime(int newHour, int newMinute, {bool? am}) {
    hour = newHour;
    minute = newMinute;
    if (am != null) isAM = am;
    notifyListeners();
  }

  void setTimeOfDay(DateTime time) {
    hour = time.hour;
    minute = time.minute;
    if (Utils.shouldUseAMPM()) {
      isAM = hour < 12;
    }
    notifyListeners();
  }

  void setTimeToNow() {
    final now = DateTime.now();
    hour = now.hour;
    minute = now.minute;
    if (Utils.shouldUseAMPM()) {
      isAM = hour < 12;
    }
    notifyListeners();
  }
}

class TimeSelector extends StatefulWidget {
  final TimeSelectorController controller;

  const TimeSelector({super.key, required this.controller});

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  bool get _useAMPM => Utils.shouldUseAMPM();

  List<int> get _hours => _useAMPM
      ? List.generate(12, (i) => i == 0 ? 12 : i)
      : List.generate(24, (i) => i);

  List<int> get _minutes => List.generate(60, (i) => i);

  static const int _loopMultiple = 100;
  late List<int> _loopedHours;
  late List<int> _loopedMinutes;

  @override
  void initState() {
    super.initState();

    _loopedHours = List.generate(_hours.length * _loopMultiple,
        (index) => _hours[index % _hours.length]);
    _loopedMinutes = List.generate(_minutes.length * _loopMultiple,
        (index) => _minutes[index % _minutes.length]);

    final initialHour = _useAMPM
        ? (widget.controller.hour % 12 == 0 ? 12 : widget.controller.hour % 12)
        : widget.controller.hour;
    final hourIndex = _loopedHours.indexWhere((h) => h == initialHour) +
        (_loopedHours.length ~/ 2);

    final minuteIndex = _loopedMinutes.indexWhere(
          (m) => m == widget.controller.minute,
        ) +
        (_loopedMinutes.length ~/ 2);

    _hourController = FixedExtentScrollController(initialItem: hourIndex);
    _minuteController = FixedExtentScrollController(initialItem: minuteIndex);

    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPicker(
                  controller: _hourController,
                  values: _loopedHours,
                  onSelectedItemChanged: (index) async {
                    final realIndex = index % _hours.length;
                    widget.controller
                        .setTime(_hours[realIndex], widget.controller.minute);
                    if (await Vibration.hasAmplitudeControl()) {
                      Vibration.vibrate(amplitude: 255, duration: 5);
                    }
                  },
                  textStyle: textStyle,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: textStyle?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                _buildPicker(
                  controller: _minuteController,
                  values: _loopedMinutes,
                  onSelectedItemChanged: (index) async {
                    final realIndex = index % _minutes.length;
                    widget.controller
                        .setTime(widget.controller.hour, _minutes[realIndex]);
                    if (await Vibration.hasAmplitudeControl()) {
                      Vibration.vibrate(amplitude: 255, duration: 5);
                    }
                  },
                  textStyle: textStyle,
                ),
              ],
            ),
            // Highlight band overlay
            IgnorePointer(
              child: Container(
                height: 32,
                constraints: const BoxConstraints(
                  maxWidth: 120,
                ),
                decoration: BoxDecoration(
                  color: widget.controller.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.controller.color.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_useAMPM) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmPmButton('AM', widget.controller.isAM),
              const SizedBox(width: 10),
              _buildAmPmButton('PM', !widget.controller.isAM),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPicker({
    required FixedExtentScrollController controller,
    required List<int> values,
    required Function(int) onSelectedItemChanged,
    required TextStyle? textStyle,
  }) {
    return SizedBox(
      height: 100,
      width: 60,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 32,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        perspective: 0.002,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            if (index < 0 || index >= values.length) return null;
            return Center(
              child: Text(values[index].toString().padLeft(2, '0'),
                  style: textStyle),
            );
          },
          childCount: values.length,
        ),
      ),
    );
  }

  Widget _buildAmPmButton(String label, bool selected) {
    return Card(
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: widget.controller.color,
          width: selected ? 1.5 : 1.0,
        ),
      ),
      elevation: 0,
      color:
          selected ? widget.controller.color.withAlpha(50) : Colors.transparent,
      child: InkWell(
        onTap: () {
          int hour = widget.controller.hour;

          if (label == 'AM') {
            // PM → AM conversion
            if (hour >= 12) {
              hour -= 12;
            }
          } else {
            // AM → PM conversion
            if (hour < 12) {
              hour += 12;
            }
          }

          widget.controller.setTime(
            hour,
            widget.controller.minute,
            am: label == 'AM',
          );
          print("isAM set to ${label == 'AM'}");
        },
        borderRadius: BorderRadius.circular(100),
        // Match the Card's border radius
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
          child: Text(label),
        ),
      ),
    );
  }
}
