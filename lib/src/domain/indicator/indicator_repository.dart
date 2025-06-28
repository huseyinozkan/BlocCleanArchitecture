import 'dart:async';

import 'package:bloc_clean_architecture/src/common/blocs/indicator/bloc/indicator_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

abstract interface class IIndicatorRepository {
  void show();
  void hide();

  Stream<IndicatorState> get status;
}

@LazySingleton(as: IIndicatorRepository)
final class IndicatorRepository extends IIndicatorRepository {
  final _indicatorKey = UniqueKey().toString();
  var _requestCountWithIndicator = 0;

  final _controller = StreamController<IndicatorState>.broadcast();

  @override
  Stream<IndicatorState> get status async* {
    yield* _controller.stream;
  }

  @override
  void show() {
    _requestCountWithIndicator++;
    if (_requestCountWithIndicator == 1) _controller.add(IndicatorShow(indicatorKey: _indicatorKey));
  }

  @override
  void hide() {
    _requestCountWithIndicator--;
    assert(_requestCountWithIndicator >= 0, 'Request count with indicator cannot be negative');
    if (_requestCountWithIndicator == 0) _controller.add(IndicatorHide(indicatorKey: _indicatorKey));
  }

  void dispose() {
    _controller.close();
  }
}
