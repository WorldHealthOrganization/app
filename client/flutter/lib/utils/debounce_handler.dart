
import 'dart:async';
import 'package:flutter/material.dart';

/// Handle debounce when we click multiple times quickly.
class DebounceHandler {
  final int millisecondsInterval;
  Timer _timer;

  DebounceHandler({ this.millisecondsInterval = 500 });

  run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: millisecondsInterval), action);
  }
}