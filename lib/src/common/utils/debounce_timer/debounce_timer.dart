import 'dart:async';

import 'package:flutter/material.dart';

final class DebounceTimer {
  DebounceTimer({this.duration = const Duration(milliseconds: 500)});

  final Duration duration;

  Timer? _timer;

  void call({required VoidCallback onFinish}) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(duration, onFinish);
  }

  void cancel() => _timer?.cancel();
}
