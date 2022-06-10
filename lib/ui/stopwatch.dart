import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch_flutter/provider/stop_watch_provider.dart';
import 'package:stopwatch_flutter/ui/elapsed_time_text.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';

class Stopwatch extends StatefulWidget {
  @override
  _StopwatchState createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();

    _ticker = this.createTicker((elapsed) {
      Provider.of<StopWatchProvider>(context, listen: false)
          .setElapsed(elapsed);
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StopWatchProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: AspectRatio(
        aspectRatio: 0.80,
        child: LayoutBuilder(
          builder: (context, constraints) {
            print("width: ${constraints.maxWidth}");
            final radius = constraints.maxWidth / 2;
            return Stack(
              children: [
                StopWatchRenderer(elapsed: provider.elapsed, radius: radius),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: ResetButton(onPressed: () {
                      provider.reset(_ticker);
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: StartStopButton(
                      isRunning: provider.isRunning,
                      onPressed: () {
                        provider.toggleWatch(_ticker);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
