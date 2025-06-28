import 'package:bloc_clean_architecture/src/common/constants/app_contants.dart';
import 'package:bloc_clean_architecture/src/common/theme/color_scheme_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@injectable
final class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(theme: PlatformDispatcher.instance.platformBrightness == Brightness.light ? AppConstants.themeConstants.lightTheme.theme : AppConstants.themeConstants.darkTheme.theme)) {
    on<ThemeSwitchedEvent>(_switchTheme);
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ThemeState state) => state.toJson();

  void _switchTheme(ThemeSwitchedEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(theme: state.theme.brightness == Brightness.light ? AppConstants.themeConstants.darkTheme.theme : AppConstants.themeConstants.lightTheme.theme));
  }
}
