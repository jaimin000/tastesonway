import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tastesonway/utils/theme_data.dart';

class TimerWidget extends StatefulWidget {
  final int minutes;

  const TimerWidget({Key? key, required this.minutes}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    print(widget.minutes);
    _remainingSeconds = widget.minutes;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return _remainingSeconds == 0 ? BlinkText(
      formatTime(_remainingSeconds),
      style: mTextStyle16(),
      endColor: orangeColor(),
    ):Text(formatTime(_remainingSeconds),style: mTextStyle16(),);
  }
}