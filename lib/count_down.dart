import 'dart:async';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {Key? key, this.width, this.height, this.time, this.color})
      : super(key: key);

  final double? width;
  final double? height;
  final DateTime? time;
  final Color? color;

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late DateTime _targetDateTime;
  Duration _remainingTime = const Duration();
  bool less = false;

  getTargetTime(DateTime target) {
    DateTime targetDateTime = target; // Example target date and time
    DateTime now = DateTime.now();
    Duration difference = targetDateTime.difference(now);
    return DateTime.now().add(difference);
  }

  @override
  void initState() {
    super.initState();
    // Set the target date and time for the countdown
    _targetDateTime = getTargetTime(widget.time ?? DateTime.now());
    // Start the countdown timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Calculate the remaining time
        var difference = widget.time!.difference(DateTime.now());
        print(difference);
        if (difference < const Duration(seconds: 1)) {
          less = true;
        }
        _remainingTime = _targetDateTime.difference(DateTime.now());
      });
      if (_remainingTime.inSeconds <= 0) {
        // Countdown reached zero, cancel the timer
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 50,
      width: widget.width ?? 200,
      decoration: BoxDecoration(
        border: Border.all(
            color: less ? Colors.red : (widget.color ?? Colors.white)),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${_remainingTime.inDays} Days',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color:
            less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
          ),
          Text(
            '${_remainingTime.inHours % 24} Hrs',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color:
            less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
          ),
          Text(
            '${_remainingTime.inMinutes % 60} Min',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
        ],
      ),
    );
  }
}
