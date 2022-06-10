import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';

class StopWatchProvider with ChangeNotifier {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  bool _isRunning = false;

  Duration get elapsed => _previouslyElapsed + _currentlyElapsed;
  bool get isRunning => _isRunning;

  void setElapsed(Duration elapsed) {
    _currentlyElapsed = elapsed;
    notifyListeners();
  }

  void toggleWatch(Ticker ticker) {
    _isRunning = !isRunning;
    if (_isRunning) {
      ticker.start();
    } else {
      ticker.stop();
      _previouslyElapsed += _currentlyElapsed;
      _currentlyElapsed = Duration.zero;
    }
    notifyListeners();
  }

  void reset(Ticker ticker) {
    ticker.stop();
    _isRunning = false;
    _currentlyElapsed = Duration.zero;
    _previouslyElapsed = Duration.zero;
    notifyListeners();
  }
}
