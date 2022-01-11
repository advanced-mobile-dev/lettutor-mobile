import 'dart:async';

import 'package:flutter/scheduler.dart';

class Debouner {
  final int milliseconds;
  Debouner({this.milliseconds});
  Timer _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
