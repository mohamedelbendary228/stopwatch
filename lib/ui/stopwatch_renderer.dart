import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stopwatch_flutter/ui/clock_hand.dart';
import 'package:stopwatch_flutter/ui/clock_markers.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';

class StopWatchRenderer extends StatelessWidget {
  final Duration elapsed;
  final double radius;
  const StopWatchRenderer(
      {Key? key, required this.elapsed, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (var i = 0; i < 60; i++)
          Positioned(
            left: radius,
            top: radius,
            child: ClockSecondsMarker(
              seconds: i,
              radius: radius,
            ),
          ),
        for (int i = 5; i <= 60; i += 5)
          Positioned(
            left: radius,
            top: radius,
            child: ClockTextMarker(value: i, maxValue: 60, radius: radius),
          ),
        Positioned(
          left: radius,
          top: radius,
          child: ClockHand(
            handLength: radius,
            handThickness: 2,
            rotationZAngle: pi + (2 * pi / 60000) * elapsed.inMilliseconds,
            color: Colors.orange,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: radius * 1.3,
          child: ElapsedTimeText(
            elapsed: elapsed,
          ),
        ),
      ],
    );
  }
}
