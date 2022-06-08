import 'dart:math';

import 'package:flutter/material.dart';

class ClockSecondsMarker extends StatelessWidget {
  final int seconds;
  final double radius;
  const ClockSecondsMarker(
      {Key? key, required this.seconds, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = seconds % 5 == 0 ? Colors.white : Colors.grey[700];
    final width = 2.0;
    final height = 12.0;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -height / 2, 0.0)
        ..rotateZ(2 * pi * (seconds / 60.0))
        ..translate(0.0, radius - height / 2, 0.0),
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
