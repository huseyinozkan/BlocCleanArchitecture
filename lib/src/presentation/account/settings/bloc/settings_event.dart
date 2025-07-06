part of 'settings_bloc.dart';

@immutable
final class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class SettingsInitialEvent extends SettingsEvent {
  const SettingsInitialEvent();
}
