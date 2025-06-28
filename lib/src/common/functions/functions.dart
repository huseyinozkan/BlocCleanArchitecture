import 'package:bloc/bloc.dart';
import 'package:bloc_clean_architecture/src/common/routing/route_paths.dart';
import 'package:bloc_clean_architecture/src/common/theme/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:rxdart/rxdart.dart';

abstract class MyFunctions {
  static RoutePaths? convertFullPathToEnum(String? fullPath) {
    if (fullPath.isNull) return null;
    return RoutePaths.values.firstWhere((e) => e.asRoutePath.replaceAll('/', '') == fullPath!.split('/').last);
  }

  static EventTransformer<T> debounce<T>(Duration duration) => (events, mapper) => events.debounceTime(duration).flatMap(mapper);

  static Color? currencyColor(BuildContext context, {required double value}) {
    if (value == 0) {
      return context.colorScheme.onSurface;
    } else if (value > 0) {
      return context.theme.extension<MyColors>()?.green;
    } else {
      return context.theme.extension<MyColors>()?.red;
    }
  }
}
