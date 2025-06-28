part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeSwitchedEvent extends ThemeEvent {
  const ThemeSwitchedEvent();
}
